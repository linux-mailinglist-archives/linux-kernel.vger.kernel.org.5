Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29378B791
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjH1SvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjH1SvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:51:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30F8B3;
        Mon, 28 Aug 2023 11:51:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66CB02D8;
        Mon, 28 Aug 2023 20:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693248579;
        bh=wulqYars1EVVyOM4T+aV/A+mi4Ue4Ee6G6mcJR2UFhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGNJs2CzxVkpoUfMK/94YUgqXSHuTjX4dosJleSekA90EIxuRC8lXAAOPO6iHkULj
         ONh++A61reb8l3pzJasRWd/JHVs/DqINbtBusjy/6hJjNMaImyDLOURkIvYFfRYClp
         UxpbLmIt1lLOcz1YT6/0iu3ILK7zoMJmAIfCW1dg=
Date:   Mon, 28 Aug 2023 21:51:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/15] media: qcom: camss: Untangle if/else spaghetti
 in camss
Message-ID: <20230828185110.GN14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-9-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-9-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for the patch.

On Wed, Aug 23, 2023 at 11:44:37AM +0100, Bryan O'Donoghue wrote:
> I refuse to add another SoC to this convoluted if/else structure. By the
> time we added in a third SoC we ought to have transitioned these control
> flow strutures to switches.
> 
> Adding in another Soc or two will make some of these if statements into
> five clause behemoths.
> 
> Introduce switches in the obvious places to despaghetiify.

I like the switch/case better as well, but the current code isn't as bad
as you make it sound. I don't think you need to make such a personal
statement in the commit message and threaten of starting a hunger strike
if the driver doesn't use switch/case :-) Just say that the switch/case
reads more naturally for this specific usage.

> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../media/platform/qcom/camss/camss-csid.c    | 16 ++++---
>  .../media/platform/qcom/camss/camss-csiphy.c  | 22 ++++++---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 45 +++++++++++++------
>  .../media/platform/qcom/camss/camss-video.c   | 16 ++++---
>  4 files changed, 68 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index fd04ed112b564..5dbbcda5232ac 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -592,15 +592,19 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
>  	csid->camss = camss;
>  	csid->id = id;
>  
> -	if (camss->res->version == CAMSS_8x16) {
> +	switch (camss->res->version) {
> +	case CAMSS_8x16:
>  		csid->ops = &csid_ops_4_1;
> -	} else if (camss->res->version == CAMSS_8x96 ||
> -		   camss->res->version == CAMSS_660) {
> +		break;
> +	case CAMSS_8x96:
> +	case CAMSS_660:
>  		csid->ops = &csid_ops_4_7;
> -	} else if (camss->res->version == CAMSS_845 ||
> -		   camss->res->version == CAMSS_8250) {
> +		break;
> +	case CAMSS_845:
> +	case CAMSS_8250:
>  		csid->ops = &csid_ops_gen2;
> -	} else {
> +		break;
> +	default:
>  		return -EINVAL;

This should never happen, as adding support for a new SoC should come
with an update for all the applicable switch/case statements. It's
useful to let the compiler complain if someone forgets to do so, but
with a default case, you will only see the issue at runtime. Could it be
caught at compile time ?

>  	}
>  	csid->ops->subdev_init(csid);
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 593aec5c97bc2..0e8c2a59ea241 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -557,21 +557,31 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  	csiphy->id = id;
>  	csiphy->cfg.combo_mode = 0;
>  
> -	if (camss->res->version == CAMSS_8x16) {
> +	switch (camss->res->version) {
> +	case CAMSS_8x16:
> +	{
>  		csiphy->ops = &csiphy_ops_2ph_1_0;
>  		csiphy->formats = csiphy_formats_8x16;
>  		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x16);
> -	} else if (camss->res->version == CAMSS_8x96 ||
> -		   camss->res->version == CAMSS_660) {
> +		break;
> +	}
> +	case CAMSS_8x96:
> +	case CAMSS_660:
> +	{
>  		csiphy->ops = &csiphy_ops_3ph_1_0;
>  		csiphy->formats = csiphy_formats_8x96;
>  		csiphy->nformats = ARRAY_SIZE(csiphy_formats_8x96);
> -	} else if (camss->res->version == CAMSS_845 ||
> -		   camss->res->version == CAMSS_8250) {
> +		break;
> +	}
> +	case CAMSS_845:
> +	case CAMSS_8250:
> +	{
>  		csiphy->ops = &csiphy_ops_3ph_1_0;
>  		csiphy->formats = csiphy_formats_sdm845;
>  		csiphy->nformats = ARRAY_SIZE(csiphy_formats_sdm845);
> -	} else {
> +		break;
> +	}
> +	default:
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index b789b3b2e4cfd..8f48401e31cd3 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -170,7 +170,9 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>  {
>  	struct vfe_device *vfe = to_vfe(line);
>  
> -	if (vfe->camss->res->version == CAMSS_8x16)
> +	switch (vfe->camss->res->version) {
> +	case CAMSS_8x16:
> +	{
>  		switch (sink_code) {
>  		case MEDIA_BUS_FMT_YUYV8_1X16:
>  		{
> @@ -218,10 +220,13 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>  
>  			return sink_code;
>  		}
> -	else if (vfe->camss->res->version == CAMSS_8x96 ||
> -		 vfe->camss->res->version == CAMSS_660 ||
> -		 vfe->camss->res->version == CAMSS_845 ||
> -		 vfe->camss->res->version == CAMSS_8250)
> +		break;
> +	}
> +	case CAMSS_8x96:
> +	case CAMSS_660:
> +	case CAMSS_845:
> +	case CAMSS_8250:
> +	{
>  		switch (sink_code) {
>  		case MEDIA_BUS_FMT_YUYV8_1X16:
>  		{
> @@ -281,8 +286,12 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>  
>  			return sink_code;
>  		}
> -	else
> -		return 0;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +	return 0;
>  }
>  
>  int vfe_reset(struct vfe_device *vfe)
> @@ -1397,7 +1406,9 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  		init_completion(&l->output.sof);
>  		init_completion(&l->output.reg_update);
>  
> -		if (camss->res->version == CAMSS_8x16) {
> +		switch (camss->res->version) {
> +		case CAMSS_8x16:
> +		{
>  			if (i == VFE_LINE_PIX) {
>  				l->formats = formats_pix_8x16;
>  				l->nformats = ARRAY_SIZE(formats_pix_8x16);
> @@ -1405,8 +1416,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  				l->formats = formats_rdi_8x16;
>  				l->nformats = ARRAY_SIZE(formats_rdi_8x16);
>  			}
> -		} else if (camss->res->version == CAMSS_8x96 ||
> -			   camss->res->version == CAMSS_660) {
> +			break;
> +		}
> +		case CAMSS_8x96:
> +		case CAMSS_660:
> +		{
>  			if (i == VFE_LINE_PIX) {
>  				l->formats = formats_pix_8x96;
>  				l->nformats = ARRAY_SIZE(formats_pix_8x96);
> @@ -1414,11 +1428,16 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  				l->formats = formats_rdi_8x96;
>  				l->nformats = ARRAY_SIZE(formats_rdi_8x96);
>  			}
> -		} else if (camss->res->version == CAMSS_845 ||
> -			   camss->res->version == CAMSS_8250) {
> +			break;
> +		}
> +		case CAMSS_845:
> +		case CAMSS_8250:
> +		{
>  			l->formats = formats_rdi_845;
>  			l->nformats = ARRAY_SIZE(formats_rdi_845);
> -		} else {
> +			break;
> +		}
> +		default:
>  			return -EINVAL;
>  		}
>  	}
> diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
> index 46a89b5f6c171..e695724437ce1 100644
> --- a/drivers/media/platform/qcom/camss/camss-video.c
> +++ b/drivers/media/platform/qcom/camss/camss-video.c
> @@ -1006,7 +1006,8 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
>  
>  	mutex_init(&video->lock);
>  
> -	if (video->camss->res->version == CAMSS_8x16) {
> +	switch (video->camss->res->version) {
> +	case CAMSS_8x16:
>  		if (is_pix) {
>  			video->formats = formats_pix_8x16;
>  			video->nformats = ARRAY_SIZE(formats_pix_8x16);
> @@ -1014,8 +1015,9 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
>  			video->formats = formats_rdi_8x16;
>  			video->nformats = ARRAY_SIZE(formats_rdi_8x16);
>  		}
> -	} else if (video->camss->res->version == CAMSS_8x96 ||
> -		   video->camss->res->version == CAMSS_660) {
> +		break;
> +	case CAMSS_8x96:
> +	case CAMSS_660:
>  		if (is_pix) {
>  			video->formats = formats_pix_8x96;
>  			video->nformats = ARRAY_SIZE(formats_pix_8x96);
> @@ -1023,11 +1025,13 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
>  			video->formats = formats_rdi_8x96;
>  			video->nformats = ARRAY_SIZE(formats_rdi_8x96);
>  		}
> -	}  else if (video->camss->res->version == CAMSS_845 ||
> -		    video->camss->res->version == CAMSS_8250) {
> +		break;
> +	case CAMSS_845:
> +	case CAMSS_8250:
>  		video->formats = formats_rdi_845;
>  		video->nformats = ARRAY_SIZE(formats_rdi_845);
> -	} else {
> +		break;
> +	default:
>  		ret = -EINVAL;
>  		goto error_video_register;
>  	}

-- 
Regards,

Laurent Pinchart
