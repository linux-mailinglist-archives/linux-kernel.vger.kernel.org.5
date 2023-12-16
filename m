Return-Path: <linux-kernel+bounces-2088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD58157B9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652B5286575
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F11171E;
	Sat, 16 Dec 2023 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8Rwtikr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C910A2B;
	Sat, 16 Dec 2023 05:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85618C433C8;
	Sat, 16 Dec 2023 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702703961;
	bh=geWMBLcp6sf1ms/3Xd1oNOeH2gSFO3bsbIdjbrF8pBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8RwtikrCgR7IeIf7effE0TXN2gDjVDQjkMDLuYViPS7qJV/Q5yClH/ecL+nhocjc
	 dH7gc6QhfrFKI7Auns+lzUfAQm8tqkWphKmEsXaIfpGP/8WxZiIJLdVgSa3LDz+jLY
	 l9lUGVTUyVUj7UJhnYJrDeIxRQjZgl7DDuIEWApuLzN8/6xzwKunEKlj6xxiKGVD29
	 oKDguXIFl9sPRsWLUK1XNgsfcd+mMl8CGUMcji03D8Cn1jqolY4eNNyaL/XHQBNwzb
	 AGMeNDg1RSJSOB3HeBlAJuHLgglU/W9W4xhiD97bqdK3StzdbMNBPppOu39ez7Ors6
	 ILzEUHamsW2JA==
Date: Sat, 16 Dec 2023 10:49:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v5 2/2] bus: mhi: host: Drop chan lock before queuing
 buffers
Message-ID: <20231216051908.GB3405@thinkpad>
References: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
 <1702276972-41296-3-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1702276972-41296-3-git-send-email-quic_qianyu@quicinc.com>

On Mon, Dec 11, 2023 at 02:42:52PM +0800, Qiang Yu wrote:
> Ensure read and write locks for the channel are not taken in succession by
> dropping the read lock from parse_xfer_event() such that a callback given
> to client can potentially queue buffers and acquire the write lock in that
> process. Any queueing of buffers should be done without channel read lock
> acquired as it can result in multiple locks and a soft lockup.
> 

Cc: <stable@vger.kernel.org> # 5.7
Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 32021fe..25f98d6 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  			mhi_del_ring_element(mhi_cntrl, tre_ring);
>  			local_rp = tre_ring->rp;
>  
> +			read_unlock_bh(&mhi_chan->lock);
> +
>  			/* notify client */
>  			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>  
> @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  					kfree(buf_info->cb_buf);
>  				}
>  			}
> +
> +			read_lock_bh(&mhi_chan->lock);
>  		}
>  		break;
>  	} /* CC_EOT */
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

