Return-Path: <linux-kernel+bounces-2090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9F8157BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4806228678E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11811CAC;
	Sat, 16 Dec 2023 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of3V1Q8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F011119B;
	Sat, 16 Dec 2023 05:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F8C433C7;
	Sat, 16 Dec 2023 05:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702704105;
	bh=3eaa/Z7yDUXKlQqwD+4l93z2758pfkfkFBK1mutDW8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of3V1Q8Ieqf/wmPZydE4Ev1mmMm+yb1yeoOt4xDu4H9NExwvYjJ5qW2ZSKZlQDbY4
	 sGMP9CgOAffy+NmeQDJbzj27bMcAeyXl1JiH/MoRm0ASEw2i0OXcXCKfqQUbB7BYnt
	 41dXYD6Wb/WtL2KzWf9WZb1umHJZnCz+d3y/yST8GlZQiAwMSfSx/2p3rmVpvnlnRl
	 VzbD+PFhGENXHgNP+r5SPEKbx66285mGLR44OMglNzvR45GYyENUZb64WZTHHFCirB
	 O6U1VppT2IRoLVMl/lyftqEHiUlAA625jzmX4oeoicQKqC5CDQiM08eom5sImlJCFU
	 eHaq5eIZDFD8g==
Date: Sat, 16 Dec 2023 10:51:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: quic_jhugo@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v5 0/2] bus: mhi: host: Add lock to avoid race when
 ringing channel DB
Message-ID: <20231216052132.GC3405@thinkpad>
References: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1702276972-41296-1-git-send-email-quic_qianyu@quicinc.com>

On Mon, Dec 11, 2023 at 02:42:50PM +0800, Qiang Yu wrote:
> 
> 1. We need a write lock in mhi_gen_tre otherwise there is race of the WP
> used for ringing channel DB between mhi_queue and M0 transition.
> 2. We can not invoke local_bh_enable() when irqs are disabled, so move
> read_lock_irqsave() under the mhi_gen_tre() since we add write_lock_bh() in
> mhi_gen_tre().
> 3. Unlock xfer_cb to prevent potential lockup
> 

Applied to mhi-next!

- Mani

> v1 -> v2:
> Added write_unlock_bh(&mhi_chan->lock) in mhi_gen_tre() before return
> because of error process.
> 
> v2 -> v3:
> 1. split protecting WP and unlocking xfer_cb into two patches
> 2. Add a new patch to stop processing buffer and eventof a disabled or
> stopped channel.
> 
> v3 -> v4:
> 1. Modify commit message
> 2. Add unlock operation before return error
> 
> v4 -> v5:
> 1. Squash "protecting WP" and "Take irqsave lock" into one patch
> 2. Drop patch 3/4 of patch v4
> 
> Bhaumik Bhatt (1):
>   bus: mhi: host: Add spinlock to protect WP access when queueing TREs
> 
> Qiang Yu (1):
>   bus: mhi: host: Drop chan lock before queuing buffers
> 
>  drivers/bus/mhi/host/main.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

