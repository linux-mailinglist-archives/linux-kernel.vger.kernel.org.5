Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9478B67C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjH1RbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjH1Raw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:30:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20EF199;
        Mon, 28 Aug 2023 10:30:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38EF75AA;
        Mon, 28 Aug 2023 19:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693243765;
        bh=+9kR5KSAAXEVqyb3QGonVbpDtX8gMHb1l6U512kVzDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Boy4rj9kr50PYEG+J4eCNOS8nstepuA1zvvDtiTKLkF+ezDnLG8x1e/Ynsi+IsEfl
         QI2ORxTuuCwsWsOYmkMJMnrPHGIHPF5D2dpgQ9YwdOHvfcJQ+l6qvjF9EhjQSfYvPN
         LZQEoe8SoROu5m3KCv2OOq02EQZyV4s5/vK1smHQ=
Date:   Mon, 28 Aug 2023 20:30:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] media: qcom: camss: Amalgamate struct resource
 with struct resource_ispif
Message-ID: <20230828173055.GF14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-2-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:30AM +0100, Bryan O'Donoghue wrote:
> There is no good reason to differentiate the two resource structures
> here. As part of a general tidyup of the declaration and passing of
> resources within in the CAMSS driver it will be advantageous to have
> one unified resource structure.
> 
> The two structures are very similar anyway thus leading more credence
> still to the argument there should be only one.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-ispif.c |  4 ++--
>  drivers/media/platform/qcom/camss/camss-ispif.h |  4 ++--
>  drivers/media/platform/qcom/camss/camss.c       | 14 +++++++-------
>  drivers/media/platform/qcom/camss/camss.h       |  8 +-------
>  4 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
> index 1c7e4b1b49401..61765b874b9a2 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -1095,7 +1095,7 @@ static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>   * Return 0 on success or a negative error code otherwise
>   */
>  int msm_ispif_subdev_init(struct camss *camss,
> -			  const struct resources_ispif *res)
> +			  const struct resources *res)
>  {
>  	struct device *dev = camss->dev;
>  	struct ispif_device *ispif = camss->ispif;
> @@ -1152,7 +1152,7 @@ int msm_ispif_subdev_init(struct camss *camss,
>  
>  	/* Interrupt */
>  
> -	ret = platform_get_irq_byname(pdev, res->interrupt);
> +	ret = platform_get_irq_byname(pdev, res->interrupt[0]);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.h b/drivers/media/platform/qcom/camss/camss-ispif.h
> index fdf28e68cc7d8..c7c41f7afcaad 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.h
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.h
> @@ -66,10 +66,10 @@ struct ispif_device {
>  	struct camss *camss;
>  };
>  
> -struct resources_ispif;
> +struct resources;
>  
>  int msm_ispif_subdev_init(struct camss *camss,
> -			  const struct resources_ispif *res);
> +			  const struct resources *res);
>  
>  int msm_ispif_register_entities(struct ispif_device *ispif,
>  				struct v4l2_device *v4l2_dev);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index f4948bdf3f8f9..de39dc987444f 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -93,14 +93,14 @@ static const struct resources csid_res_8x16[] = {
>  	},
>  };
>  
> -static const struct resources_ispif ispif_res_8x16 = {
> +static const struct resources ispif_res_8x16 = {
>  	/* ISPIF */
>  	.clock = { "top_ahb", "ahb", "ispif_ahb",
>  		   "csi0", "csi0_pix", "csi0_rdi",
>  		   "csi1", "csi1_pix", "csi1_rdi" },
>  	.clock_for_reset = { "vfe0", "csi_vfe0" },
>  	.reg = { "ispif", "csi_clk_mux" },
> -	.interrupt = "ispif"
> +	.interrupt = { "ispif" }
>  
>  };
>  
> @@ -234,7 +234,7 @@ static const struct resources csid_res_8x96[] = {
>  	}
>  };
>  
> -static const struct resources_ispif ispif_res_8x96 = {
> +static const struct resources ispif_res_8x96 = {
>  	/* ISPIF */
>  	.clock = { "top_ahb", "ahb", "ispif_ahb",
>  		   "csi0", "csi0_pix", "csi0_rdi",
> @@ -243,7 +243,7 @@ static const struct resources_ispif ispif_res_8x96 = {
>  		   "csi3", "csi3_pix", "csi3_rdi" },
>  	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
>  	.reg = { "ispif", "csi_clk_mux" },
> -	.interrupt = "ispif"
> +	.interrupt = { "ispif" }
>  };
>  
>  static const struct resources vfe_res_8x96[] = {
> @@ -410,7 +410,7 @@ static const struct resources csid_res_660[] = {
>  	}
>  };
>  
> -static const struct resources_ispif ispif_res_660 = {
> +static const struct resources ispif_res_660 = {
>  	/* ISPIF */
>  	.clock = { "top_ahb", "ahb", "ispif_ahb",
>  		   "csi0", "csi0_pix", "csi0_rdi",
> @@ -419,7 +419,7 @@ static const struct resources_ispif ispif_res_660 = {
>  		   "csi3", "csi3_pix", "csi3_rdi" },
>  	.clock_for_reset = { "vfe0", "csi_vfe0", "vfe1", "csi_vfe1" },
>  	.reg = { "ispif", "csi_clk_mux" },
> -	.interrupt = "ispif"
> +	.interrupt = { "ispif" }
>  };
>  
>  static const struct resources vfe_res_660[] = {
> @@ -1122,7 +1122,7 @@ static int camss_init_subdevices(struct camss *camss)
>  {
>  	const struct resources *csiphy_res;
>  	const struct resources *csid_res;
> -	const struct resources_ispif *ispif_res;
> +	const struct resources *ispif_res;
>  	const struct resources *vfe_res;
>  	unsigned int i;
>  	int ret;
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index f6c326cb853b8..e95211cdb1fd6 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -44,18 +44,12 @@
>  struct resources {

While at it, or in a separate patch, could you rename this to
camss_resources ? resources is a too generic name, too likely to clash.
With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	char *regulators[CAMSS_RES_MAX];
>  	char *clock[CAMSS_RES_MAX];
> +	char *clock_for_reset[CAMSS_RES_MAX];
>  	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
>  	char *reg[CAMSS_RES_MAX];
>  	char *interrupt[CAMSS_RES_MAX];
>  };
>  
> -struct resources_ispif {
> -	char *clock[CAMSS_RES_MAX];
> -	char *clock_for_reset[CAMSS_RES_MAX];
> -	char *reg[CAMSS_RES_MAX];
> -	char *interrupt;
> -};
> -
>  struct icc_bw_tbl {
>  	u32 avg;
>  	u32 peak;

-- 
Regards,

Laurent Pinchart
