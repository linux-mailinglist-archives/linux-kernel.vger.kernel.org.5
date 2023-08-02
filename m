Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB27176C8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHBItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHBItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:49:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FDBD9;
        Wed,  2 Aug 2023 01:48:58 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C5A88DA;
        Wed,  2 Aug 2023 10:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690966073;
        bh=AHE/esg6v9mEw8Sbx7rGCFI2379V3KnTYnVDFT7MLBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C4xeGIi/Ud2dvO6bkox1STXTrpJz5iKaN4dxG+8k1/UTVAZBmBl9bEIokxpD5MjDc
         fqEGVZE3DZg73Z7orZ4ynKgTs8Ba6e1/kbka06sF9J17jP1dUKNpNo/uwMYI718XCi
         4ToAf8LTiwfu4o9C4XpkEjqZyZqhE98jLxXkDdiI=
Message-ID: <bf914485-09af-4f32-0636-d1a7232216d0@ideasonboard.com>
Date:   Wed, 2 Aug 2023 11:48:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 07/16] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-7-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-7-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:29, Jai Luthra wrote:
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
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> v7->v8:
> - Use active subdev state to use v4l2_subdev_get_fmt
> - Propagate formats from sink to source pads
> - Drop Laurent's R-by because of the above changes
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 107 ++++++++++++++++++++++++++-
>   1 file changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 83d1fadd592b..4f9654366485 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -61,6 +61,11 @@ enum csi2rx_pads {
>   	CSI2RX_PAD_MAX,
>   };
>   
> +struct csi2rx_fmt {
> +	u32				code;
> +	u8				bpp;
> +};
> +
>   struct csi2rx_priv {
>   	struct device			*dev;
>   	unsigned int			count;
> @@ -95,6 +100,36 @@ struct csi2rx_priv {
>   	int				source_pad;
>   };
>   
> +static const struct csi2rx_fmt formats[] = {
> +	{
> +		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
> +		.bpp	= 16,
> +	},
> +};

I think you could just squash the "media: cadence: csi2rx: Support RAW8 
and RAW10 formats" into this one. Also, the lines could well be one-liners:

	{ .code	= MEDIA_BUS_FMT_YUYV8_1X16, .bpp = 16, },


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
>   static inline
>   struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>   {
> @@ -303,12 +338,75 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>   	return ret;
>   }
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
> +
> +	*fmt = format->format;
> +
> +	/* Propagate to source formats */
> +	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
> +		fmt = v4l2_subdev_get_pad_format(subdev, state, i);
> +		if (!fmt)
> +			return -EINVAL;
> +		*fmt = format->format;
> +	}

Not really part of this patch, but why does csi2rx create more than one 
source pad? It doesn't support streams, so how are those pads used?

> +	return 0;
> +}
> +
> +static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
> +			   struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_format format = {
> +		.which = state ? V4L2_SUBDEV_FORMAT_TRY
> +			: V4L2_SUBDEV_FORMAT_ACTIVE,

I don't think this is correct. If you enable the active state, you'll 
always get a state here, and thus this function doesn't really know if 
it is TRY or ACTIVE state (nor should it care).

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
>   static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
>   	.s_stream	= csi2rx_s_stream,
>   };
>   
>   static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
>   	.video		= &csi2rx_video_ops,
> +	.pad		= &csi2rx_pad_ops,
>   };
>   
>   static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
> @@ -532,9 +630,13 @@ static int csi2rx_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_cleanup;
>   
> +	ret = v4l2_subdev_init_finalize(&csi2rx->subdev);
> +	if (ret)
> +		goto err_cleanup;
> +
>   	ret = v4l2_async_register_subdev(&csi2rx->subdev);
>   	if (ret < 0)
> -		goto err_cleanup;
> +		goto err_free_state;
>   
>   	dev_info(&pdev->dev,
>   		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
> @@ -544,6 +646,8 @@ static int csi2rx_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_free_state:
> +	v4l2_subdev_cleanup(&csi2rx->subdev);
>   err_cleanup:
>   	v4l2_async_nf_unregister(&csi2rx->notifier);
>   	v4l2_async_nf_cleanup(&csi2rx->notifier);
> @@ -560,6 +664,7 @@ static void csi2rx_remove(struct platform_device *pdev)
>   	v4l2_async_nf_unregister(&csi2rx->notifier);
>   	v4l2_async_nf_cleanup(&csi2rx->notifier);
>   	v4l2_async_unregister_subdev(&csi2rx->subdev);
> +	v4l2_subdev_cleanup(&csi2rx->subdev);
>   	media_entity_cleanup(&csi2rx->subdev.entity);
>   	kfree(csi2rx);
>   }
> 

