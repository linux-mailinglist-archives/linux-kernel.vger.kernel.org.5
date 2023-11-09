Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F37E6E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjKIQXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbjKIQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:23:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616C35B5;
        Thu,  9 Nov 2023 08:23:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A8BC433CA;
        Thu,  9 Nov 2023 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699547003;
        bh=aePtJT7WZA8ttpok02zN1PeRQSCh1RDBZ95u1jYBnzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke+SaWDQtXbP9Tyl3sK4r/Ial5r7s/CKpJsmhLHN3qyYhReR6LOfFBT31k72kXku/
         swCbvX368DR4M3u5wSWPqx0d3ur3zRrLy+A4nqUINZfmO8B4Dy+BHLCaAYM1EKmo+X
         kANAktvKSoLk77NTUKuEunuC6dxaJxhOtYgnw/giK82UNqg78m26sH736ZHeM+ACUI
         DncwowPeCHCBZer+qofUSdp5dVjzc8eCjVj//4lx/tvzSLlaU/ZR6c1z68G0qmb6Jh
         nk4JG9AVOhwpjmnEv1rrXOeb4AWSiHmB5nNoRsk8H1QFhPxO+rfPONp2P6lFNW7JBf
         7H9Ns9umIw4ng==
Date:   Thu, 9 Nov 2023 21:53:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com,
        Bhaumik Bhatt <bbhatt@codeaurora.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Message-ID: <20231109162310.GJ3752@thinkpad>
References: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
 <1699341365-47737-2-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699341365-47737-2-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:16:02PM +0800, Qiang Yu wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Protect WP accesses such that multiple threads queueing buffers for
> incoming data do not race.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 6cf1145..c9415b0 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1205,6 +1205,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	int eot, eob, chain, bei;
>  	int ret;
>  
> +	/* Protect accesses for reading and incrementing WP */
> +	write_lock_bh(&mhi_chan->lock);
> +
>  	buf_ring = &mhi_chan->buf_ring;
>  	tre_ring = &mhi_chan->tre_ring;
>  
> @@ -1222,8 +1225,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  
>  	if (!info->pre_mapped) {
>  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> -		if (ret)
> +		if (ret) {
> +			write_unlock_bh(&mhi_chan->lock);
>  			return ret;
> +		}
>  	}
>  
>  	eob = !!(flags & MHI_EOB);
> @@ -1240,6 +1245,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  	mhi_add_ring_element(mhi_cntrl, tre_ring);
>  	mhi_add_ring_element(mhi_cntrl, buf_ring);
>  
> +	write_unlock_bh(&mhi_chan->lock);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
