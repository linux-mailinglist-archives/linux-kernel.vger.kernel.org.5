Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E8178B748
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjH1Sgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjH1SgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:36:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C0B0;
        Mon, 28 Aug 2023 11:36:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F19A2D8;
        Mon, 28 Aug 2023 20:34:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693247685;
        bh=2LMZvM7f/L2lSgdZaw7tJ5C0Mvviajs9B+1lkKCLG/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZlR3UuXKCpX3sIyiIl4vyQFFIShWmP0GEF2OjSvpOzTSLGK3ERpsN3Qdpo3FfqJd
         lXJ42WRrkQyMghpASYrKz9HSVnbg1qJqT8eO09oiZ0HiNztI9OyrUYACIRLyXjeNub
         HY9tNWBFVrxoumBaFMqnuN822O9siSCc1NYAN/Kw=
Date:   Mon, 28 Aug 2023 21:36:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/15] media: qcom: camss: Pass line_num from compat
 resources
Message-ID: <20230828183616.GJ14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-6-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:34AM +0100, Bryan O'Donoghue wrote:
> line_num indicates the number of RDI - raw data interface channels which
> are associated with a given IFE/VFE - image/video front end.

Should the variable then be renamed to num_rdi or similar ?

> On several SoCs the RDI number is not static for each VFE - for example
> on sm8250 VFE Lite has four RDIs where regular VFE has three.
> 
> Assigning line_num statically in the subdev_init() phase initialises
> each VFE to the lower number, meaning in practical terms that we are
> lobbing off one RDI on some VFEs.
> 
> Interrupt handling uses static for (i = RDI0; i < RDI2; i++) {} in some
> of our VFE blocks but this can't work for situations where we have a
> mixture of VFE @ 3 RDI and VFE-lite @ 4 RDI blocks.
> 
> First step to remediate is to pass line_num from a compat string
> controlled data-structure and do so on a per-VFE basis.
> 
> Later patches will assign the correct number of RDI blocks per VFE.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../media/platform/qcom/camss/camss-vfe-170.c |  2 --
>  .../media/platform/qcom/camss/camss-vfe-4-1.c |  2 --
>  .../media/platform/qcom/camss/camss-vfe-4-7.c |  2 --
>  .../media/platform/qcom/camss/camss-vfe-4-8.c |  2 --
>  .../media/platform/qcom/camss/camss-vfe-480.c |  1 -
>  drivers/media/platform/qcom/camss/camss-vfe.c |  5 +++
>  drivers/media/platform/qcom/camss/camss.c     | 36 ++++++++++++-------
>  drivers/media/platform/qcom/camss/camss.h     |  1 +
>  8 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> index 9905bb06b3823..8aa921400ded0 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
> @@ -756,8 +756,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
>  {
>  	vfe->isr_ops = vfe_isr_ops_170;
>  	vfe->video_ops = vfe_video_ops_170;
> -
> -	vfe->line_num = VFE_LINE_NUM_GEN2;
>  }
>  
>  const struct vfe_hw_ops vfe_ops_170 = {
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> index bc309f326f519..2911e4126e7ad 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> @@ -992,8 +992,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
>  	vfe->isr_ops = vfe_isr_ops_gen1;
>  	vfe->ops_gen1 = &vfe_ops_gen1_4_1;
>  	vfe->video_ops = vfe_video_ops_gen1;
> -
> -	vfe->line_num = VFE_LINE_NUM_GEN1;
>  }
>  
>  const struct vfe_hw_ops vfe_ops_4_1 = {
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> index 8acd76c9746ba..b65ed0fef595e 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> @@ -1188,8 +1188,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
>  	vfe->isr_ops = vfe_isr_ops_gen1;
>  	vfe->ops_gen1 = &vfe_ops_gen1_4_7;
>  	vfe->video_ops = vfe_video_ops_gen1;
> -
> -	vfe->line_num = VFE_LINE_NUM_GEN1;
>  }
>  
>  const struct vfe_hw_ops vfe_ops_4_7 = {
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> index 3a0167ecf873a..7b3805177f037 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> @@ -1173,8 +1173,6 @@ static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
>  	vfe->isr_ops = vfe_isr_ops_gen1;
>  	vfe->ops_gen1 = &vfe_ops_gen1_4_8;
>  	vfe->video_ops = vfe_video_ops_gen1;
> -
> -	vfe->line_num = VFE_LINE_NUM_GEN1;
>  }
>  
>  const struct vfe_hw_ops vfe_ops_4_8 = {
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-480.c b/drivers/media/platform/qcom/camss/camss-vfe-480.c
> index 80338efceb9e1..b1a07e846e25b 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-480.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-480.c
> @@ -572,7 +572,6 @@ static const struct camss_video_ops vfe_video_ops_480 = {
>  static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
>  {
>  	vfe->video_ops = vfe_video_ops_480;
> -	vfe->line_num = MAX_VFE_OUTPUT_LINES;
>  }
>  
>  const struct vfe_hw_ops vfe_ops_480 = {
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 526dd4ab343fe..b789b3b2e4cfd 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1305,6 +1305,11 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	if (!res->line_num)
> +		return -EINVAL;
> +
> +	vfe->line_num = res->line_num;
>  	vfe->ops->subdev_init(dev, vfe);
>  
>  	/* Memory */
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index c8a2571e664fe..ce0d86e45fe48 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -123,7 +123,8 @@ static const struct resources vfe_res_8x16[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe0" },
> -		.interrupt = { "vfe0" }
> +		.interrupt = { "vfe0" },
> +		.line_num = VFE_LINE_NUM_GEN1,
>  	}
>  };
>  
> @@ -263,7 +264,8 @@ static const struct resources vfe_res_8x96[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe0" },
> -		.interrupt = { "vfe0" }
> +		.interrupt = { "vfe0" },
> +		.line_num = VFE_LINE_NUM_GEN1,
>  	},
>  
>  	/* VFE1 */
> @@ -281,7 +283,8 @@ static const struct resources vfe_res_8x96[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe1" },
> -		.interrupt = { "vfe1" }
> +		.interrupt = { "vfe1" },
> +		.line_num = VFE_LINE_NUM_GEN1,
>  	}
>  };
>  
> @@ -442,7 +445,8 @@ static const struct resources vfe_res_660[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe0" },
> -		.interrupt = { "vfe0" }
> +		.interrupt = { "vfe0" },
> +		.line_num = VFE_LINE_NUM_GEN1,
>  	},
>  
>  	/* VFE1 */
> @@ -463,7 +467,8 @@ static const struct resources vfe_res_660[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe1" },
> -		.interrupt = { "vfe1" }
> +		.interrupt = { "vfe1" },
> +		.line_num = VFE_LINE_NUM_GEN1,
>  	}
>  };
>  
> @@ -621,7 +626,8 @@ static const struct resources vfe_res_845[] = {
>  				{ 19200000, 75000000, 384000000, 538666667 },
>  				{ 384000000 } },
>  		.reg = { "vfe0" },
> -		.interrupt = { "vfe0" }
> +		.interrupt = { "vfe0" },
> +		.line_num = VFE_LINE_NUM_GEN2,
>  	},
>  
>  	/* VFE1 */
> @@ -641,7 +647,8 @@ static const struct resources vfe_res_845[] = {
>  				{ 19200000, 75000000, 384000000, 538666667 },
>  				{ 384000000 } },
>  		.reg = { "vfe1" },
> -		.interrupt = { "vfe1" }
> +		.interrupt = { "vfe1" },
> +		.line_num = VFE_LINE_NUM_GEN2,
>  	},
>  
>  	/* VFE-lite */
> @@ -660,7 +667,8 @@ static const struct resources vfe_res_845[] = {
>  				{ 19200000, 75000000, 384000000, 538666667 },
>  				{ 384000000 } },
>  		.reg = { "vfe_lite" },
> -		.interrupt = { "vfe_lite" }
> +		.interrupt = { "vfe_lite" },
> +		.line_num = VFE_LINE_NUM_GEN2,
>  	}
>  };
>  
> @@ -787,7 +795,8 @@ static const struct resources vfe_res_8250[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe0" },
> -		.interrupt = { "vfe0" }
> +		.interrupt = { "vfe0" },
> +		.line_num = 4,
>  	},
>  	/* VFE1 */
>  	{
> @@ -805,7 +814,8 @@ static const struct resources vfe_res_8250[] = {
>  				{ 0 },
>  				{ 0 } },
>  		.reg = { "vfe1" },
> -		.interrupt = { "vfe1" }
> +		.interrupt = { "vfe1" },
> +		.line_num = 4,
>  	},
>  	/* VFE2 (lite) */
>  	{
> @@ -822,7 +832,8 @@ static const struct resources vfe_res_8250[] = {
>  				{ 400000000, 480000000 },
>  				{ 0 } },
>  		.reg = { "vfe_lite0" },
> -		.interrupt = { "vfe_lite0" }
> +		.interrupt = { "vfe_lite0" },
> +		.line_num = 4,
>  	},
>  	/* VFE3 (lite) */
>  	{
> @@ -839,7 +850,8 @@ static const struct resources vfe_res_8250[] = {
>  				{ 400000000, 480000000 },
>  				{ 0 } },
>  		.reg = { "vfe_lite1" },
> -		.interrupt = { "vfe_lite1" }
> +		.interrupt = { "vfe_lite1" },
> +		.line_num = 4,
>  	},
>  };
>  
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index dd8c58d349685..101ce6e527931 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -48,6 +48,7 @@ struct resources {
>  	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
>  	char *reg[CAMSS_RES_MAX];
>  	char *interrupt[CAMSS_RES_MAX];
> +	u8 line_num;
>  };
>  
>  struct icc_bw_tbl {

-- 
Regards,

Laurent Pinchart
