Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0707AD378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjIYIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIYIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:34:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE19D;
        Mon, 25 Sep 2023 01:34:16 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E153EB1;
        Mon, 25 Sep 2023 10:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695630755;
        bh=0QwUbjQUlXfPv/XmeskRAPh2SX5+oNeZWNjuJJ2bi40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke1gke97WaCQtADlcgql9ZVjilv8aUaUYAJPObQaTeICFbdX0WNfSlMLqjKE5BfpS
         O853vMK90rgyqEo2AElK1b3QG0dGxe3H3dwwVE81XJFyNQlfScay/BtU4JffV8+L0K
         QUxmO7yiBp2tbE62H9tu1wLmty1ToELhkivgI1OU=
Date:   Mon, 25 Sep 2023 11:34:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/17] media: qcom: camss: Remove special case for VFE
 get/put
Message-ID: <20230925083425.GB8583@pendragon.ideasonboard.com>
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-10-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911131411.196033-10-bryan.odonoghue@linaro.org>
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

On Mon, Sep 11, 2023 at 02:14:03PM +0100, Bryan O'Donoghue wrote:
> From sdm845 onwards we need to ensure the VFE is powered on prior to
> switching on the CSID.
> 
> Currently the code tests for sdm845, sm8250 and then does get/set. This is
> not extensible and it turns out is not necessary either since vfe_get and
> vfe_set reference count.
> 
> Remove the over-conservative SoC version check.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb3 # db410c
> ---
>  drivers/media/platform/qcom/camss/camss-csid.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 99f651e2021cb..02ae3f5cb0c0e 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -159,15 +159,12 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>  	struct camss *camss = csid->camss;
>  	struct device *dev = camss->dev;
>  	struct vfe_device *vfe = &camss->vfe[csid->id];
> -	u32 version = camss->res->version;
>  	int ret = 0;
>  
>  	if (on) {
> -		if (version == CAMSS_8250 || version == CAMSS_845) {
> -			ret = vfe_get(vfe);
> -			if (ret < 0)
> -				return ret;
> -		}

Maybe a comment to explain why we call vfe_get() could be useful ?

		/*
		 * From SDM845 onwards, the VFE needs to be powered on before
		 * switching on the CSID. Do so unconditionally, as there is no
		 * drawback in following the same powering order on older SoCs.
		 */

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		ret = vfe_get(vfe);
> +		if (ret < 0)
> +			return ret;
>  
>  		ret = pm_runtime_resume_and_get(dev);
>  		if (ret < 0)
> @@ -217,8 +214,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>  		regulator_bulk_disable(csid->num_supplies,
>  				       csid->supplies);
>  		pm_runtime_put_sync(dev);
> -		if (version == CAMSS_8250 || version == CAMSS_845)
> -			vfe_put(vfe);
> +		vfe_put(vfe);
>  	}
>  
>  	return ret;

-- 
Regards,

Laurent Pinchart
