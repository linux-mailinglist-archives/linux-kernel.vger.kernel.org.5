Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030478B683
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjH1Rdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjH1Rdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:33:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24811A;
        Mon, 28 Aug 2023 10:33:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B59ED5AA;
        Mon, 28 Aug 2023 19:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693243935;
        bh=9KC2ZfmLlcUvbLRYR2c0zmIrk6zvtmnSQH8iwYQYe3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQfudyOPjZUI4gApGUQY6EwwjoO7O4A5m/eQRn0UhDjH0T2xdA1JF6VgyUKHL1c+v
         ZT0ADCznUydDLyocsNIPx6OU8hvjvospMPuwG7uE3fErsqHm44BH1lJYhyMDoPSapr
         rTb21IspeRQsXS733yk3dwm3k/JcPv5eWcShhmxY=
Date:   Mon, 28 Aug 2023 20:33:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] media: qcom: camss: Start to move to module
 compat matched resources
Message-ID: <20230828173345.GG14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-3-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:31AM +0100, Bryan O'Donoghue wrote:
> There is a lot of unnecessary if/elsing in this code that arguably
> should never have made it upstream when adding a second let alone
> subsequent SoC.
> 
> I'm guilty of not fixing the mess myself when adding in the sm8250.
> Before adding in any new SoCs or resources lets take the time to cleanup
> the resource passing.
> 
> First step is to pass the generic struct camss_resources as a parameter
> per the compatible list.
> 
> Subsequent patches will address the other somewhat dispirate strutures

s/dispirate/disparate/ ?

> which we are also doing if/else on and assigning statically.
> 
> Squashed down a commit to drop useless NULL assignment for ispif resources.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 92 ++++++++++++-----------
>  drivers/media/platform/qcom/camss/camss.h |  8 ++
>  2 files changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index de39dc987444f..82e679c8ca011 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_domain.h>
> @@ -1120,47 +1121,13 @@ static int camss_of_parse_ports(struct camss *camss)
>   */
>  static int camss_init_subdevices(struct camss *camss)
>  {
> -	const struct resources *csiphy_res;
> -	const struct resources *csid_res;
> -	const struct resources *ispif_res;
> -	const struct resources *vfe_res;
> +	const struct camss_resources *res = camss->res;
>  	unsigned int i;
>  	int ret;
>  
> -	if (camss->version == CAMSS_8x16) {
> -		csiphy_res = csiphy_res_8x16;
> -		csid_res = csid_res_8x16;
> -		ispif_res = &ispif_res_8x16;
> -		vfe_res = vfe_res_8x16;
> -	} else if (camss->version == CAMSS_8x96) {
> -		csiphy_res = csiphy_res_8x96;
> -		csid_res = csid_res_8x96;
> -		ispif_res = &ispif_res_8x96;
> -		vfe_res = vfe_res_8x96;
> -	} else if (camss->version == CAMSS_660) {
> -		csiphy_res = csiphy_res_660;
> -		csid_res = csid_res_660;
> -		ispif_res = &ispif_res_660;
> -		vfe_res = vfe_res_660;
> -	}  else if (camss->version == CAMSS_845) {
> -		csiphy_res = csiphy_res_845;
> -		csid_res = csid_res_845;
> -		/* Titan VFEs don't have an ISPIF  */
> -		ispif_res = NULL;
> -		vfe_res = vfe_res_845;
> -	} else if (camss->version == CAMSS_8250) {
> -		csiphy_res = csiphy_res_8250;
> -		csid_res = csid_res_8250;
> -		/* Titan VFEs don't have an ISPIF  */
> -		ispif_res = NULL;
> -		vfe_res = vfe_res_8250;
> -	} else {
> -		return -EINVAL;
> -	}
> -
>  	for (i = 0; i < camss->csiphy_num; i++) {
>  		ret = msm_csiphy_subdev_init(camss, &camss->csiphy[i],
> -					     &csiphy_res[i], i);
> +					     &res->csiphy_res[i], i);
>  		if (ret < 0) {
>  			dev_err(camss->dev,
>  				"Failed to init csiphy%d sub-device: %d\n",
> @@ -1172,7 +1139,7 @@ static int camss_init_subdevices(struct camss *camss)
>  	/* note: SM8250 requires VFE to be initialized before CSID */
>  	for (i = 0; i < camss->vfe_num + camss->vfe_lite_num; i++) {
>  		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
> -					  &vfe_res[i], i);
> +					  &res->vfe_res[i], i);
>  		if (ret < 0) {
>  			dev_err(camss->dev,
>  				"Fail to init vfe%d sub-device: %d\n", i, ret);
> @@ -1182,7 +1149,7 @@ static int camss_init_subdevices(struct camss *camss)
>  
>  	for (i = 0; i < camss->csid_num; i++) {
>  		ret = msm_csid_subdev_init(camss, &camss->csid[i],
> -					   &csid_res[i], i);
> +					   &res->csid_res[i], i);
>  		if (ret < 0) {
>  			dev_err(camss->dev,
>  				"Failed to init csid%d sub-device: %d\n",
> @@ -1191,7 +1158,7 @@ static int camss_init_subdevices(struct camss *camss)
>  		}
>  	}
>  
> -	ret = msm_ispif_subdev_init(camss, ispif_res);
> +	ret = msm_ispif_subdev_init(camss, res->ispif_res);
>  	if (ret < 0) {
>  		dev_err(camss->dev, "Failed to init ispif sub-device: %d\n",
>  		ret);
> @@ -1554,6 +1521,10 @@ static int camss_probe(struct platform_device *pdev)
>  	if (!camss)
>  		return -ENOMEM;
>  
> +	camss->res = of_device_get_match_data(dev);
> +	if (!camss->res)
> +		return -ENODEV;

You could possibly drop the error check, as this can't happen.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  	atomic_set(&camss->ref_count, 0);
>  	camss->dev = dev;
>  	platform_set_drvdata(pdev, camss);
> @@ -1735,12 +1706,45 @@ static void camss_remove(struct platform_device *pdev)
>  		camss_delete(camss);
>  }
>  
> +static const struct camss_resources msm8916_resources = {
> +	.csiphy_res = csiphy_res_8x16,
> +	.csid_res = csid_res_8x16,
> +	.ispif_res = &ispif_res_8x16,
> +	.vfe_res = vfe_res_8x16,
> +};
> +
> +static const struct camss_resources msm8996_resources = {
> +	.csiphy_res = csiphy_res_8x96,
> +	.csid_res = csid_res_8x96,
> +	.ispif_res = &ispif_res_8x96,
> +	.vfe_res = vfe_res_8x96,
> +};
> +
> +static const struct camss_resources sdm660_resources = {
> +	.csiphy_res = csiphy_res_660,
> +	.csid_res = csid_res_660,
> +	.ispif_res = &ispif_res_660,
> +	.vfe_res = vfe_res_660,
> +};
> +
> +static const struct camss_resources sdm845_resources = {
> +	.csiphy_res = csiphy_res_845,
> +	.csid_res = csid_res_845,
> +	.vfe_res = vfe_res_845,
> +};
> +
> +static const struct camss_resources sm8250_resources = {
> +	.csiphy_res = csiphy_res_8250,
> +	.csid_res = csid_res_8250,
> +	.vfe_res = vfe_res_8250,
> +};
> +
>  static const struct of_device_id camss_dt_match[] = {
> -	{ .compatible = "qcom,msm8916-camss" },
> -	{ .compatible = "qcom,msm8996-camss" },
> -	{ .compatible = "qcom,sdm660-camss" },
> -	{ .compatible = "qcom,sdm845-camss" },
> -	{ .compatible = "qcom,sm8250-camss" },
> +	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
> +	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
> +	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
> +	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
> +	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
>  	{ }
>  };
>  
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index e95211cdb1fd6..f632ee49ad83e 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -79,6 +79,13 @@ enum icc_count {
>  	ICC_SM8250_COUNT = 4,
>  };
>  
> +struct camss_resources {
> +	const struct resources *csiphy_res;
> +	const struct resources *csid_res;
> +	const struct resources *ispif_res;
> +	const struct resources *vfe_res;
> +};
> +
>  struct camss {
>  	enum camss_version version;
>  	struct v4l2_device v4l2_dev;
> @@ -99,6 +106,7 @@ struct camss {
>  	struct device_link **genpd_link;
>  	struct icc_path *icc_path[ICC_SM8250_COUNT];
>  	struct icc_bw_tbl icc_bw_tbl[ICC_SM8250_COUNT];
> +	const struct camss_resources *res;
>  };
>  
>  struct camss_camera_interface {

-- 
Regards,

Laurent Pinchart
