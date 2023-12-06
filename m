Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287AC806E17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377667AbjLFLfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjLFLfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:35:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFADC9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:35:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A678C433C7;
        Wed,  6 Dec 2023 11:35:32 +0000 (UTC)
Message-ID: <43621420-2482-4634-9c3e-1a3278481540@xs4all.nl>
Date:   Wed, 6 Dec 2023 12:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-b4-camss-named-power-domains-v6-0-3ec2fd9e8e36@linaro.org>
 <20231123-b4-camss-named-power-domains-v6-5-3ec2fd9e8e36@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231123-b4-camss-named-power-domains-v6-5-3ec2fd9e8e36@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 18:03, Bryan O'Donoghue wrote:
> Right now we use fixed indexes to assign power-domains, with a
> requirement for the TOP GDSC to come last in the list.
> 
> Adding support for named power-domains means the declaration in the dtsi
> can come in any order.
> 
> After this change we continue to support the old indexing - if a SoC
> resource declaration or the in-use dtb doesn't declare power-domain names
> we fall back to the default legacy indexing.
> 
> From this point on though new SoC additions should contain named
> power-domains, eventually we will drop support for legacy indexing.
> 
> Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 24 +++++++++++++++++++++++-
>  drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++++++++++++++-----
>  drivers/media/platform/qcom/camss/camss.h     |  2 ++
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 60c4730e7c9d1..083d1445a6e25 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1382,7 +1382,29 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  	if (!res->line_num)
>  		return -EINVAL;
>  
> -	if (res->has_pd) {
> +	/* Power domain */
> +
> +	if (res->pd_name) {
> +		vfe->genpd = dev_pm_domain_attach_by_name(camss->dev,
> +							  res->pd_name);
> +		if (IS_ERR(vfe->genpd)) {
> +			ret = PTR_ERR(vfe->genpd);
> +			return ret;
> +		}
> +	}
> +
> +	if (!vfe->genpd && res->has_pd) {
> +		/*
> +		 * Legacy magic index.
> +		 * Requires
> +		 * power-domain = <VFE_X>,
> +		 *                <VFE_Y>,
> +		 *                <TITAN_TOP>
> +		 * id must correspondng to the index of the VFE which must
> +		 * come before the TOP GDSC. VFE Lite has no individually
> +		 * collapasible domain which is why id < vfe_num is a valid
> +		 * check.
> +		 */
>  		vfe->genpd = dev_pm_domain_attach_by_id(camss->dev, id);
>  		if (IS_ERR(vfe->genpd))
>  			return PTR_ERR(vfe->genpd);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 35918cf837bdd..f2d2317c38b5b 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1522,12 +1522,28 @@ static int camss_configure_pd(struct camss *camss)
>  		return 0;
>  
>  	/*
> -	 * VFE power domains are in the beginning of the list, and while all
> -	 * power domains should be attached, only if TITAN_TOP power domain is
> -	 * found in the list, it should be linked over here.
> +	 * If a power-domain name is defined try to use it.
> +	 * It is possible we are running a new kernel with an old dtb so
> +	 * fallback to indexes even if a pd_name is defined but not found.
>  	 */
> -	camss->genpd = dev_pm_domain_attach_by_id(camss->dev, camss->genpd_num - 1);
> -	if (IS_ERR(camss->genpd)) {
> +	if (camss->res->pd_name) {
> +		camss->genpd = dev_pm_domain_attach_by_name(camss->dev,
> +							    camss->res->pd_name);
> +		if (IS_ERR(camss->genpd)) {
> +			ret = PTR_ERR(camss->genpd);
> +			goto fail_pm;
> +		}
> +	}
> +
> +	if (!camss->genpd) {
> +		/*
> +		 * Legacy magic index. TITAN_TOP GDSC must be the last
> +		 * item in the power-domain list.
> +		 */
> +		camss->genpd = dev_pm_domain_attach_by_id(camss->dev,
> +							  camss->genpd_num - 1);
> +	}
> +	if (IS_ERR_OR_NULL(camss->genpd)) {
>  		ret = PTR_ERR(camss->genpd);

I get this smatch warning here:

drivers/media/platform/qcom/camss/camss.c:1555 camss_configure_pd() warn: passing zero to 'PTR_ERR'

I'm not really sure what the intent is here.

If the fix is small, then I can change it myself, otherwise I need an updated patch.

Regards,

	Hans

>  		goto fail_pm;
>  	}
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 1ba824a2cb76c..cd8186fe1797b 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -48,6 +48,7 @@ struct camss_subdev_resources {
>  	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
>  	char *reg[CAMSS_RES_MAX];
>  	char *interrupt[CAMSS_RES_MAX];
> +	char *pd_name;
>  	u8 line_num;
>  	bool has_pd;
>  	const void *ops;
> @@ -84,6 +85,7 @@ enum icc_count {
>  
>  struct camss_resources {
>  	enum camss_version version;
> +	const char *pd_name;
>  	const struct camss_subdev_resources *csiphy_res;
>  	const struct camss_subdev_resources *csid_res;
>  	const struct camss_subdev_resources *ispif_res;
> 

