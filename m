Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCB7B6506
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbjJCJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjJCJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F2AC;
        Tue,  3 Oct 2023 02:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595A2C433C7;
        Tue,  3 Oct 2023 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696324250;
        bh=Z+wmAtHqbMWcV1UFwatglg3NhgUKFXMT7eH43M0T72c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FegFeLZElKhpoAIbd9qwFCXONwOtsHoZTiYZXtPRg6Ak67D634u1p66W01secUEoF
         kyWnoYJSqVmwb6uoWaEdeLQjP/ssn4EGZX3OOipsiDIXxYbSWLfJ4JeuPRMnaplfdJ
         mkc4SJW1Bt6++VMx2eS5io+Ex2ag3LaTgH/HrB7WpjWl97oYlZM5ti7H0i7ctOKDtT
         6xJ1c4UaFxohIgv3uw9JYYBc6rjVceCH/ypSmF+RJLCdPZ2m8kD6OGcK2iGiLnlUWh
         U8rr+np2v8N+5+vlpo4+BkYu0sACTbfLb2gV5wVs0PSBRwbAm0pn0o6R4y2ZaDPZIo
         qMw+2tL280e9A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnbQh-0008P5-0z;
        Tue, 03 Oct 2023 11:11:00 +0200
Date:   Tue, 3 Oct 2023 11:10:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, marijn.suijten@somainline.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: do not reinitialize phy unless retry
 during link training
Message-ID: <ZRvaoz7CbNncM3t6@hovoldconsulting.com>
References: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:19:50PM -0700, Kuogee Hsieh wrote:
> DP PHY re-initialization done using dp_ctrl_reinitialize_mainlink() will
> cause PLL unlocked initially and then PLL gets locked at the end of
> initialization. PLL_UNLOCKED interrupt will fire during this time if the
> interrupt mask is enabled.
> However currently DP driver link training implementation incorrectly
> re-initializes PHY unconditionally during link training as the PHY was
> already configured in dp_ctrl_enable_mainlink_clocks().
> 
> Fix this by re-initializing the PHY only if the previous link training
> failed.
> 
> [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/30
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

This fixes the above warning and avoids the unnecessary PHY power-off
and power-on during boot of the ThinkPad X13s:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

I guess this one should go to stable as well:

Cc: stable@vger.kernel.org	# 5.10

Is anyone planning on getting this fixed in 6.6-rc? I noticed that this
one still hasn't shown up linux-next.

> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index a7a5c7e..77a8d93 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1774,13 +1774,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>  		return rc;
>  
>  	while (--link_train_max_retries) {
> -		rc = dp_ctrl_reinitialize_mainlink(ctrl);
> -		if (rc) {
> -			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
> -					rc);
> -			break;
> -		}
> -
>  		training_step = DP_TRAINING_NONE;
>  		rc = dp_ctrl_setup_main_link(ctrl, &training_step);
>  		if (rc == 0) {
> @@ -1832,6 +1825,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>  			/* stop link training before start re training  */
>  			dp_ctrl_clear_training_pattern(ctrl);
>  		}
> +
> +		rc = dp_ctrl_reinitialize_mainlink(ctrl);
> +		if (rc) {
> +			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
> +			break;
> +		}
>  	}
>  
>  	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)

Johan
