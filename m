Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37E078B69B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjH1RgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjH1Rfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:35:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C2189;
        Mon, 28 Aug 2023 10:35:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF6BB5AA;
        Mon, 28 Aug 2023 19:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693244050;
        bh=i5yEt1rOz6ejIJ7pTu0XP1EoqHDTe3dEe9m0qZ2IZT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npKyvKKuoLAUHAMsUCVnCEoTC5kLRwnv67JFvHRFDd/slgls8dXjFcsGU60/iVbW9
         DqVWnCRZmn9rhuOZp6BdlcLABRaqVmk0m2EmF/HYNQwSc5gVhGzmgAS7tIWPM18knO
         Gxi7VSoyV239RAHSTcf276XEF7PKhfkJBUJh9AfU=
Date:   Mon, 28 Aug 2023 20:35:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] media: qcom: camss: Pass icc bandwidth table as
 a platform parameter
Message-ID: <20230828173541.GH14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-4-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-4-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:32AM +0100, Bryan O'Donoghue wrote:
> Pass the bandwidth table as a platform parameter not if/else derived
> pointer to the static table.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/qcom/camss/camss.c | 29 +++++++----------------
>  drivers/media/platform/qcom/camss/camss.h |  3 ++-
>  2 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 82e679c8ca011..9a15f2253aa20 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1485,21 +1485,15 @@ static int camss_configure_pd(struct camss *camss)
>  static int camss_icc_get(struct camss *camss)
>  {
>  	const struct resources_icc *icc_res;
> -	int nbr_icc_paths = 0;
>  	int i;
>  
> -	if (camss->version == CAMSS_8250) {
> -		icc_res = &icc_res_sm8250[0];
> -		nbr_icc_paths =	ICC_SM8250_COUNT;
> -	}
> +	icc_res = camss->res->icc_res;
>  
> -	for (i = 0; i < nbr_icc_paths; i++) {
> +	for (i = 0; i < camss->res->icc_path_num; i++) {
>  		camss->icc_path[i] = devm_of_icc_get(camss->dev,
>  						     icc_res[i].name);
>  		if (IS_ERR(camss->icc_path[i]))
>  			return PTR_ERR(camss->icc_path[i]);
> -
> -		camss->icc_bw_tbl[i] = icc_res[i].icc_bw_tbl;
>  	}
>  
>  	return 0;
> @@ -1737,6 +1731,8 @@ static const struct camss_resources sm8250_resources = {
>  	.csiphy_res = csiphy_res_8250,
>  	.csid_res = csid_res_8250,
>  	.vfe_res = vfe_res_8250,
> +	.icc_res = icc_res_sm8250,
> +	.icc_path_num = ARRAY_SIZE(icc_res_sm8250),
>  };
>  
>  static const struct of_device_id camss_dt_match[] = {
> @@ -1753,14 +1749,10 @@ MODULE_DEVICE_TABLE(of, camss_dt_match);
>  static int __maybe_unused camss_runtime_suspend(struct device *dev)
>  {
>  	struct camss *camss = dev_get_drvdata(dev);
> -	int nbr_icc_paths = 0;
>  	int i;
>  	int ret;
>  
> -	if (camss->version == CAMSS_8250)
> -		nbr_icc_paths =	ICC_SM8250_COUNT;
> -
> -	for (i = 0; i < nbr_icc_paths; i++) {
> +	for (i = 0; i < camss->res->icc_path_num; i++) {
>  		ret = icc_set_bw(camss->icc_path[i], 0, 0);
>  		if (ret)
>  			return ret;
> @@ -1772,17 +1764,14 @@ static int __maybe_unused camss_runtime_suspend(struct device *dev)
>  static int __maybe_unused camss_runtime_resume(struct device *dev)
>  {
>  	struct camss *camss = dev_get_drvdata(dev);
> -	int nbr_icc_paths = 0;
> +	const struct resources_icc *icc_res = camss->res->icc_res;
>  	int i;
>  	int ret;
>  
> -	if (camss->version == CAMSS_8250)
> -		nbr_icc_paths =	ICC_SM8250_COUNT;
> -
> -	for (i = 0; i < nbr_icc_paths; i++) {
> +	for (i = 0; i < camss->res->icc_path_num; i++) {
>  		ret = icc_set_bw(camss->icc_path[i],
> -				 camss->icc_bw_tbl[i].avg,
> -				 camss->icc_bw_tbl[i].peak);
> +				 icc_res[i].icc_bw_tbl.avg,
> +				 icc_res[i].icc_bw_tbl.peak);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index f632ee49ad83e..988c313b63551 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -84,6 +84,8 @@ struct camss_resources {
>  	const struct resources *csid_res;
>  	const struct resources *ispif_res;
>  	const struct resources *vfe_res;
> +	const struct resources_icc *icc_res;
> +	const int icc_path_num;
>  };
>  
>  struct camss {
> @@ -105,7 +107,6 @@ struct camss {
>  	struct device **genpd;
>  	struct device_link **genpd_link;
>  	struct icc_path *icc_path[ICC_SM8250_COUNT];
> -	struct icc_bw_tbl icc_bw_tbl[ICC_SM8250_COUNT];
>  	const struct camss_resources *res;
>  };
>  

-- 
Regards,

Laurent Pinchart
