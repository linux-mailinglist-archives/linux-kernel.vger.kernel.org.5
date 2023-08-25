Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A57787EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbjHYDtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjHYDs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:48:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F51BEC;
        Thu, 24 Aug 2023 20:48:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [95.214.66.65])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FF52DA8;
        Fri, 25 Aug 2023 05:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692935252;
        bh=ky6/WjS65zIrPHIv07qMBISkOZ2rTYZIM/9/ml8foMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeV4tYnNwqtqqnnJ7iX3U+Ngf+xxxWBQHkCUct8Z52AxoGiGmJUxdjYleZ9/3OARU
         U9jsNCQVjVwvEfbUOHgvT+HfBTFOhr4Q+lCuijlspuCFELgKQ/+JDKDKX+BUFR/A2V
         v+GDbKe6tgd6jTxfF4xKSAoXUv8dLofTcF8gIzI4=
Date:   Fri, 25 Aug 2023 06:48:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: Re: [PATCH v9 05/13] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Message-ID: <20230825034858.GF6477@pendragon.ideasonboard.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
 <20230811-upstream_csi-v9-5-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811-upstream_csi-v9-5-8943f7a68a81@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thank you for the patch.

On Fri, Aug 11, 2023 at 04:17:27PM +0530, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> The format is needed to calculate the link speed for the external DPHY
> configuration. It is not right to query the format from the source
> subdev. Add get_fmt and set_fmt pad operations so that the format can be
> configured and correct bpp be selected.
> 
> Initialize and use the v4l2 subdev active state to keep track of the
> active formats. Also propagate the new format from the sink pad to all
> the source pads.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Co-authored-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> Changes from v8:
>     - Squash the patch adding RAW8 and RAW10 formats within this one
>     - Single line struct entries in formats[] array
>     - Skip specifiying redundant format.which entry in init_cfg()
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 101 ++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 9de3240e261c..047e74ee2443 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -61,6 +61,11 @@ enum csi2rx_pads {
>  	CSI2RX_PAD_MAX,
>  };
>  
> +struct csi2rx_fmt {
> +	u32				code;
> +	u8				bpp;
> +};
> +
>  struct csi2rx_priv {
>  	struct device			*dev;
>  	unsigned int			count;
> @@ -95,6 +100,32 @@ struct csi2rx_priv {
>  	int				source_pad;
>  };
>  
> +static const struct csi2rx_fmt formats[] = {
> +	{ .code	= MEDIA_BUS_FMT_YUYV8_1X16, .bpp = 16, },
> +	{ .code	= MEDIA_BUS_FMT_UYVY8_1X16, .bpp = 16, },
> +	{ .code	= MEDIA_BUS_FMT_YVYU8_1X16, .bpp = 16, },
> +	{ .code	= MEDIA_BUS_FMT_VYUY8_1X16, .bpp = 16, },
> +	{ .code	= MEDIA_BUS_FMT_SBGGR8_1X8, .bpp = 8, },
> +	{ .code	= MEDIA_BUS_FMT_SGBRG8_1X8, .bpp = 8, },
> +	{ .code	= MEDIA_BUS_FMT_SGRBG8_1X8, .bpp = 8, },
> +	{ .code	= MEDIA_BUS_FMT_SRGGB8_1X8, .bpp = 8, },
> +	{ .code	= MEDIA_BUS_FMT_SBGGR10_1X10, .bpp = 10, },
> +	{ .code	= MEDIA_BUS_FMT_SGBRG10_1X10, .bpp = 10, },
> +	{ .code	= MEDIA_BUS_FMT_SGRBG10_1X10, .bpp = 10, },
> +	{ .code	= MEDIA_BUS_FMT_SRGGB10_1X10, .bpp = 10, },
> +};
> +
> +static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(formats); i++)
> +		if (formats[i].code == code)
> +			return &formats[i];
> +
> +	return NULL;
> +}
> +
>  static inline
>  struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>  {
> @@ -303,12 +334,73 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>  	return ret;
>  }
>  
> +static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
> +			  struct v4l2_subdev_state *state,
> +			  struct v4l2_subdev_format *format)
> +{
> +	struct v4l2_mbus_framefmt *fmt;
> +	unsigned int i;
> +
> +	/* No transcoding, source and sink formats must match. */
> +	if (format->pad != CSI2RX_PAD_SINK)
> +		return v4l2_subdev_get_fmt(subdev, state, format);
> +
> +	if (!csi2rx_get_fmt_by_code(format->format.code))
> +		format->format.code = formats[0].code;
> +
> +	format->format.field = V4L2_FIELD_NONE;
> +
> +	/* Set sink format */
> +	fmt = v4l2_subdev_get_pad_format(subdev, state, format->pad);
> +	if (!fmt)
> +		return -EINVAL;

You can drop this check, as format->pad is CSI2RX_PAD_SINK, this is
guaranteed to succeed.

> +
> +	*fmt = format->format;
> +
> +	/* Propagate to source formats */
> +	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
> +		fmt = v4l2_subdev_get_pad_format(subdev, state, i);
> +		if (!fmt)
> +			return -EINVAL;

Same here.

With these minor issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		*fmt = format->format;
> +	}
> +
> +	return 0;
> +}
> +
> +static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
> +			   struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_format format = {
> +		.pad = CSI2RX_PAD_SINK,
> +		.format = {
> +			.width = 640,
> +			.height = 480,
> +			.code = MEDIA_BUS_FMT_UYVY8_1X16,
> +			.field = V4L2_FIELD_NONE,
> +			.colorspace = V4L2_COLORSPACE_SRGB,
> +			.ycbcr_enc = V4L2_YCBCR_ENC_601,
> +			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
> +			.xfer_func = V4L2_XFER_FUNC_SRGB,
> +		},
> +	};
> +
> +	return csi2rx_set_fmt(subdev, state, &format);
> +}
> +
> +static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
> +	.get_fmt	= v4l2_subdev_get_fmt,
> +	.set_fmt	= csi2rx_set_fmt,
> +	.init_cfg	= csi2rx_init_cfg,
> +};
> +
>  static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
>  	.s_stream	= csi2rx_s_stream,
>  };
>  
>  static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
>  	.video		= &csi2rx_video_ops,
> +	.pad		= &csi2rx_pad_ops,
>  };
>  
>  static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
> @@ -532,9 +624,13 @@ static int csi2rx_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_cleanup;
>  
> +	ret = v4l2_subdev_init_finalize(&csi2rx->subdev);
> +	if (ret)
> +		goto err_cleanup;
> +
>  	ret = v4l2_async_register_subdev(&csi2rx->subdev);
>  	if (ret < 0)
> -		goto err_cleanup;
> +		goto err_free_state;
>  
>  	dev_info(&pdev->dev,
>  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
> @@ -544,6 +640,8 @@ static int csi2rx_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_free_state:
> +	v4l2_subdev_cleanup(&csi2rx->subdev);
>  err_cleanup:
>  	v4l2_async_nf_unregister(&csi2rx->notifier);
>  	v4l2_async_nf_cleanup(&csi2rx->notifier);
> @@ -560,6 +658,7 @@ static void csi2rx_remove(struct platform_device *pdev)
>  	v4l2_async_nf_unregister(&csi2rx->notifier);
>  	v4l2_async_nf_cleanup(&csi2rx->notifier);
>  	v4l2_async_unregister_subdev(&csi2rx->subdev);
> +	v4l2_subdev_cleanup(&csi2rx->subdev);
>  	media_entity_cleanup(&csi2rx->subdev.entity);
>  	kfree(csi2rx);
>  }
> 

-- 
Regards,

Laurent Pinchart
