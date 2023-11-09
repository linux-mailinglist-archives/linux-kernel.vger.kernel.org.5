Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD707E6EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjKIQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjKIQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B554421B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:33:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E5C433CA;
        Thu,  9 Nov 2023 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699547586;
        bh=iwH27tYu+P7Y1x7hZ5JuE532p4duwWE/n3Uu9Or2XNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3fFGh4KIpq1TnzrNOmXXWidRYaHjfyeFKnciwAQyU/CejNlDAL+gnmPwCaBsgv9a
         /oXcreb34SttsF9ceHXowP42SupsqNQb0z1zgB+4cFjD6sBrlNgpyRMYuqJf5nOs7k
         yTKs5eE5dts7e4JZzFVowCe5qrekhcF9qhfNzeWLyWKAfwff3WMkXI4Rq/sdx69iu4
         CsFdvxbDFGitd49vizBmG4+b3Z4GfjJUXek9AnjW0y3GXhgUR0h0lkG2+gCIUsm4ga
         Qeed+hpUZdLN9oKhmAy5EVR7t2ey9MJ5PR70/zeAQS6sRM+vMSa/cVHkh0buHket+R
         c7sdtjJCBarpQ==
Date:   Thu, 9 Nov 2023 22:02:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event
 of a disable channel
Message-ID: <20231109163253.GL3752@thinkpad>
References: <1699341365-47737-1-git-send-email-quic_qianyu@quicinc.com>
 <1699341365-47737-4-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699341365-47737-4-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:16:04PM +0800, Qiang Yu wrote:
> Ckeck mhi channel state after getting chan->lock to ensure that we only
> queue buffer to an enabled channel and process event of an enabled channel.
> 

This commit message doesn't give proper explanation on how the channel can go to
disabled state in between parse_xfer_event() and mhi_gen_tre().

- Mani

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index a236dc2..b137d54 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -672,6 +672,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  			}
>  
>  			read_lock_bh(&mhi_chan->lock);
> +			if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
> +				goto end_process_tx_event;
>  		}
>  		break;
>  	} /* CC_EOT */
> @@ -1211,6 +1213,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>  
>  	/* Protect accesses for reading and incrementing WP */
>  	write_lock_bh(&mhi_chan->lock);
> +	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
> +		return -EINVAL;
>  
>  	buf_ring = &mhi_chan->buf_ring;
>  	tre_ring = &mhi_chan->tre_ring;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
