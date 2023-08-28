Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725778B5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjH1RGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjH1RFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:05:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F2AC;
        Mon, 28 Aug 2023 10:05:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B143D5AA;
        Mon, 28 Aug 2023 19:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693242269;
        bh=+daqGPJIGqBL4dvQmoVpJp345YT6pJ3wMNls9KsWXLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZyO/4C/nOY2atsoMFI0PffCcqUi8onfPi9Yg609b8J+IcouZqdpBgluRBnsT1XaX
         +GF6oYlB/fZOT9nubE1O2+4kCzRattvOAlljhR03oRJJ5wMut0ELYOSSmkrZuOadfY
         LbEhF98MpbPyVPbCk+nHddpGYTuWHFH0g7bG+k/4=
Date:   Mon, 28 Aug 2023 20:05:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] media: qcom: camss: Fix V4L2 async notifier error
 path
Message-ID: <20230828170559.GW14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-3-bryan.odonoghue@linaro.org>
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

On Tue, Aug 22, 2023 at 09:06:19PM +0100, Bryan O'Donoghue wrote:
> Previously the jump label err_cleanup was used higher in the probe()
> function to release the async notifier however the async notifier
> registration was moved later in the code rendering the previous four jumps
> redundant.
> 
> Rename the label from err_cleanup to err_v4l2_device_register to capture
> what the jump does.

Shouldn't it be named err_v4l2_device_unregister then ? As the
err_register_subdevs label should also be renamed err_unregister_subdevs
you could rename them all in a separate patch.

> Fixes: 51397a4ec75d ("media: qcom: Initialise V4L2 async notifier later")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 75991d849b571..f4948bdf3f8f9 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1617,21 +1617,21 @@ static int camss_probe(struct platform_device *pdev)
>  
>  	ret = camss_icc_get(camss);
>  	if (ret < 0)
> -		goto err_cleanup;
> +		return ret;
>  
>  	ret = camss_configure_pd(camss);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to configure power domains: %d\n", ret);
> -		goto err_cleanup;
> +		return ret;
>  	}
>  
>  	ret = camss_init_subdevices(camss);
>  	if (ret < 0)
> -		goto err_cleanup;
> +		return ret;
>  
>  	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
>  	if (ret)
> -		goto err_cleanup;
> +		return ret;

This doesn't seem right, you should call v4l2_async_nf_cleanup() when
v4l2_async_nf_init() has been called, and that's done before
camss_icc_get().

>  
>  	camss->media_dev.dev = camss->dev;
>  	strscpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
> @@ -1643,7 +1643,7 @@ static int camss_probe(struct platform_device *pdev)
>  	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
> -		goto err_cleanup;
> +		return ret;
>  	}
>  
>  	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
> @@ -1651,12 +1651,12 @@ static int camss_probe(struct platform_device *pdev)
>  	num_subdevs = camss_of_parse_ports(camss);
>  	if (num_subdevs < 0) {
>  		ret = num_subdevs;
> -		goto err_cleanup;
> +		goto err_v4l2_device_register;
>  	}
>  
>  	ret = camss_register_entities(camss);
>  	if (ret < 0)
> -		goto err_cleanup;
> +		goto err_v4l2_device_register;
>  
>  	if (num_subdevs) {
>  		camss->notifier.ops = &camss_subdev_notifier_ops;
> @@ -1690,7 +1690,7 @@ static int camss_probe(struct platform_device *pdev)
>  
>  err_register_subdevs:
>  	camss_unregister_entities(camss);
> -err_cleanup:
> +err_v4l2_device_register:
>  	v4l2_device_unregister(&camss->v4l2_dev);
>  	v4l2_async_nf_cleanup(&camss->notifier);
>  

-- 
Regards,

Laurent Pinchart
