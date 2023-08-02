Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F176CB71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHBLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHBLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:05:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B61FC2;
        Wed,  2 Aug 2023 04:05:03 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED6BE2AC;
        Wed,  2 Aug 2023 13:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690974238;
        bh=/Zx9/P3C2zKaMpPKlWJFPcoQ2soNpcyQ8Kph6gnlnFY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nlZqfOZk/gVT+2IEussVwlLGlSqpcs00IeNTcz8zjARGhHRe1ZVp7731QXglp9GKu
         STemFQE2iXQa79TjOeGXE8T4CBIpwmjsxwttMLnGEgGjxxZZoCQVUOm399dPXyfJqO
         WRBs0Qt6/WL9rRdYrpVR6QV0NptVr5EZYaywqZLg=
Message-ID: <d5d9f2cb-9879-9f25-9b5c-b3b43d551658@ideasonboard.com>
Date:   Wed, 2 Aug 2023 14:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 16/16] media: ti: Add CSI2RX support for J721E
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
 <20230731-upstream_csi-v8-16-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-16-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:29, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus.
> 
> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> called the SHIM layer. It takes in data from stream 0, repacks it, and
> sends it to memory over PSI-L DMA.
> 
> This driver acts as the "front end" to V4L2 client applications. It
> implements the required ioctls and buffer operations, passes the
> necessary calls on to the bridge, programs the SHIM layer, and performs
> DMA via the dmaengine API to finally return the data to a buffer
> supplied by the application.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Co-authored-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Co-authored-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> v7->v8:
> - Move after dt-bindings to keep the series bisectable
> - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
>    SoC-specific CSI2RX bridge compatible
> - Make myself the Maintainer
> - Support RAW8 and RAW10 formats, and setting the pixel-unwrap size on
>    SHIM (RAW10 is stored in 16-bit containers, while RAW8 in 8-bit containers)
> - Fix enum_fmt_vid_cap() to respect CAP_IO_MC and only list pixelformats
>    matching the mbus formats set on the subdev.
> - Fix enum_framesizes() to stop enumerating more than a single framesize
>    (reject non-zero fsize->index)
> - Simplify notifier bound fucntion to use v4l2_create_fwnode_links_to_pad()
>    and inline the video_register() method
> - Add support for draining the DMA with an extra buffer, to get rid of
>    stale data in the pipeline on stream stop (or when frames start
>    getting dropped due to load)
> - Queue all available buffers to DMAEngine in the callback, also use a
>    separate "submitted" queue to track all buffers submitted to DMA
> - Use video_device_pipeline_start() instead of media_pipeline_start()
> - Drop support for VB_READ
> - Print issues in link validation as DEBUG instead of ERROR
> - s/async_subdev/async_connection
> 
>   MAINTAINERS                                        |    7 +
>   drivers/media/platform/ti/Kconfig                  |   12 +
>   drivers/media/platform/ti/Makefile                 |    1 +
>   drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
>   .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1127 ++++++++++++++++++++
>   5 files changed, 1149 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7b867c57920..1c2d75c30ce7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21445,6 +21445,13 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
>   F:	drivers/media/i2c/ds90*
>   F:	include/media/i2c/ds90*
>   
> +TI J721E CSI2RX DRIVER
> +M:	Jai Luthra <j-luthra@ti.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
> +F:	drivers/media/platform/ti/j721e-csi2rx/
> +
>   TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
>   M:	Nishanth Menon <nm@ti.com>
>   M:	Santosh Shilimkar <ssantosh@kernel.org>
> diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform/ti/Kconfig
> index e1ab56c3be1f..42c908f6e1ae 100644
> --- a/drivers/media/platform/ti/Kconfig
> +++ b/drivers/media/platform/ti/Kconfig
> @@ -63,6 +63,18 @@ config VIDEO_TI_VPE_DEBUG
>   	help
>   	  Enable debug messages on VPE driver.
>   
> +config VIDEO_TI_J721E_CSI2RX
> +	tristate "TI J721E CSI2RX wrapper layer driver"
> +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
> +	depends on MEDIA_SUPPORT && MEDIA_CONTROLLER
> +	depends on PHY_CADENCE_DPHY_RX && VIDEO_CADENCE_CSI2RX
> +	depends on ARCH_K3 || COMPILE_TEST
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	help
> +	  Support for TI CSI2RX wrapper layer. This just enables the wrapper driver.
> +	  The Cadence CSI2RX bridge driver needs to be enabled separately.
> +
>   source "drivers/media/platform/ti/am437x/Kconfig"
>   source "drivers/media/platform/ti/davinci/Kconfig"
>   source "drivers/media/platform/ti/omap/Kconfig"
> diff --git a/drivers/media/platform/ti/Makefile b/drivers/media/platform/ti/Makefile
> index 98c5fe5c40d6..8a2f74c9380e 100644
> --- a/drivers/media/platform/ti/Makefile
> +++ b/drivers/media/platform/ti/Makefile
> @@ -3,5 +3,6 @@ obj-y += am437x/
>   obj-y += cal/
>   obj-y += vpe/
>   obj-y += davinci/
> +obj-y += j721e-csi2rx/
>   obj-y += omap/
>   obj-y += omap3isp/
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/Makefile b/drivers/media/platform/ti/j721e-csi2rx/Makefile
> new file mode 100644
> index 000000000000..377afc1d6280
> --- /dev/null
> +++ b/drivers/media/platform/ti/j721e-csi2rx/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIDEO_TI_J721E_CSI2RX) += j721e-csi2rx.o
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> new file mode 100644
> index 000000000000..29f1879cfc25
> --- /dev/null
> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> @@ -0,0 +1,1127 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TI CSI2RX Shim Wrapper Driver
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/

You can update the year above.

> + * Author: Pratyush Yadav <p.yadav@ti.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include <media/mipi-csi2.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mc.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#define TI_CSI2RX_MODULE_NAME		"j721e-csi2rx"
> +
> +#define SHIM_CNTL			0x10
> +#define SHIM_CNTL_PIX_RST		BIT(0)
> +
> +#define SHIM_DMACNTX			0x20
> +#define SHIM_DMACNTX_EN			BIT(31)
> +#define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
> +#define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
> +#define SHIM_DMACNTX_FMT		GENMASK(5, 0)
> +#define SHIM_DMACNTX_UYVY		0
> +#define SHIM_DMACNTX_VYUY		1
> +#define SHIM_DMACNTX_YUYV		2
> +#define SHIM_DMACNTX_YVYU		3
> +#define SHIM_DMACNTX_SIZE_8		0
> +#define SHIM_DMACNTX_SIZE_16		1
> +#define SHIM_DMACNTX_SIZE_32		2
> +
> +#define SHIM_PSI_CFG0			0x24
> +#define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
> +#define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
> +
> +#define PSIL_WORD_SIZE_BYTES		16
> +/*
> + * There are no hard limits on the width or height. The DMA engine can handle
> + * all sizes. The max width and height are arbitrary numbers for this driver.
> + * Use 16K * 16K as the arbitrary limit. It is large enough that it is unlikely
> + * the limit will be hit in practice.
> + */
> +#define MAX_WIDTH_BYTES			SZ_16K
> +#define MAX_HEIGHT_LINES		SZ_16K
> +
> +#define DRAIN_TIMEOUT_MS		50
> +
> +struct ti_csi2rx_fmt {
> +	u32				fourcc;	/* Four character code. */
> +	u32				code;	/* Mbus code. */
> +	u32				csi_dt;	/* CSI Data type. */
> +	u8				bpp;	/* Bits per pixel. */
> +	u8				size;	/* Data size shift when unpacking. */
> +};
> +
> +struct ti_csi2rx_buffer {
> +	/* Common v4l2 buffer. Must be first. */
> +	struct vb2_v4l2_buffer		vb;
> +	struct list_head		list;
> +	struct ti_csi2rx_dev		*csi;
> +};
> +
> +enum ti_csi2rx_dma_state {
> +	TI_CSI2RX_DMA_STOPPED,	/* Streaming not started yet. */
> +	TI_CSI2RX_DMA_IDLE,	/* Streaming but no pending DMA operation. */
> +	TI_CSI2RX_DMA_ACTIVE,	/* Streaming and pending DMA operation. */
> +};
> +
> +struct ti_csi2rx_dma {
> +	/* Protects all fields in this struct. */
> +	spinlock_t			lock;
> +	struct dma_chan			*chan;
> +	/* Buffers queued to the driver, waiting to be processed by DMA. */
> +	struct list_head		queue;
> +	enum ti_csi2rx_dma_state	state;
> +	/*
> +	 * Queue of buffers submitted to DMA engine.
> +	 */
> +	struct list_head		submitted;
> +};
> +
> +struct ti_csi2rx_dev {
> +	struct device			*dev;
> +	void __iomem			*shim;
> +	struct v4l2_device		v4l2_dev;
> +	struct video_device		vdev;
> +	struct media_device		mdev;
> +	struct media_pipeline		pipe;
> +	struct media_pad		pad;
> +	struct v4l2_async_notifier	notifier;
> +	struct v4l2_subdev		*subdev;

I think "source_subdev" is a better name, to make it clear it's not 
referring to a subdev owned by this driver.

> +	struct vb2_queue		vidq;
> +	struct mutex			mutex; /* To serialize ioctls. */
> +	struct v4l2_format		v_fmt;
> +	struct ti_csi2rx_dma		dma;
> +	u32				sequence;
> +};
> +
> +static const struct ti_csi2rx_fmt formats[] = {
> +	{
> +		.fourcc			= V4L2_PIX_FMT_YUYV,
> +		.code			= MEDIA_BUS_FMT_YUYV8_1X16,
> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_UYVY,
> +		.code			= MEDIA_BUS_FMT_UYVY8_1X16,
> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_YVYU,
> +		.code			= MEDIA_BUS_FMT_YVYU8_1X16,
> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_VYUY,
> +		.code			= MEDIA_BUS_FMT_VYUY8_1X16,
> +		.csi_dt			= MIPI_CSI2_DT_YUV422_8B,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SBGGR8,
> +		.code			= MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.csi_dt			= MIPI_CSI2_DT_RAW8,
> +		.bpp			= 8,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SGBRG8,
> +		.code			= MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.csi_dt			= MIPI_CSI2_DT_RAW8,
> +		.bpp			= 8,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SGRBG8,
> +		.code			= MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.csi_dt			= MIPI_CSI2_DT_RAW8,
> +		.bpp			= 8,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SRGGB8,
> +		.code			= MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.csi_dt			= MIPI_CSI2_DT_RAW8,
> +		.bpp			= 8,
> +		.size			= SHIM_DMACNTX_SIZE_8,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SBGGR10,
> +		.code			= MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.csi_dt			= MIPI_CSI2_DT_RAW10,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_16,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SGBRG10,
> +		.code			= MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.csi_dt			= MIPI_CSI2_DT_RAW10,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_16,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SGRBG10,
> +		.code			= MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.csi_dt			= MIPI_CSI2_DT_RAW10,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_16,
> +	}, {
> +		.fourcc			= V4L2_PIX_FMT_SRGGB10,
> +		.code			= MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.csi_dt			= MIPI_CSI2_DT_RAW10,
> +		.bpp			= 16,
> +		.size			= SHIM_DMACNTX_SIZE_16,
> +	},
> +
> +	/* More formats can be supported but they are not listed for now. */
> +};
> +
> +static const unsigned int num_formats = ARRAY_SIZE(formats);
> +
> +/* Forward declaration needed by ti_csi2rx_dma_callback. */
> +static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
> +			       struct ti_csi2rx_buffer *buf);
> +
> +static const struct ti_csi2rx_fmt *find_format_by_pix(u32 pixelformat)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < num_formats; i++) {
> +		if (formats[i].fourcc == pixelformat)
> +			return &formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static const struct ti_csi2rx_fmt *find_format_by_code(u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < num_formats; i++) {
> +		if (formats[i].code == code)
> +			return &formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static void ti_csi2rx_fill_fmt(const struct ti_csi2rx_fmt *csi_fmt,
> +			       struct v4l2_format *v4l2_fmt)
> +{
> +	struct v4l2_pix_format *pix = &v4l2_fmt->fmt.pix;
> +	unsigned int pixels_in_word;
> +	u8 bpp = csi_fmt->bpp;
> +	u32 bpl;
> +
> +	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / bpp;
> +
> +	pix->width = clamp_t(unsigned int, pix->width,
> +			     pixels_in_word,
> +			     MAX_WIDTH_BYTES * 8 / bpp);
> +	pix->width = rounddown(pix->width, pixels_in_word);
> +
> +	pix->height = clamp_t(unsigned int, pix->height, 1, MAX_HEIGHT_LINES);
> +
> +	v4l2_fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	pix->pixelformat = csi_fmt->fourcc;
> +	pix->colorspace = V4L2_COLORSPACE_SRGB;
> +	pix->sizeimage = pix->height * pix->width * (bpp / 8);
> +
> +	bpl = (pix->width * ALIGN(bpp, 8)) >> 3;

You do "/ 8" and "* 8" elsewhere in the function, so I think it makes 
sense to "/ 8" here too, instead of ">> 3".

Is this correct? Why is aligned bpp used here, but when calculating 
sizeimage, bpp is not aligned?

> +	pix->bytesperline = ALIGN(bpl, 16);

Why align to 16?

Shouldn't sizeimage usually be bytesperline * height?

You could add a few comments here to clarify all the aligns, roundings 
and clampings.

> +}
> +
> +static int ti_csi2rx_querycap(struct file *file, void *priv,
> +			      struct v4l2_capability *cap)
> +{
> +	strscpy(cap->driver, TI_CSI2RX_MODULE_NAME, sizeof(cap->driver));
> +	strscpy(cap->card, TI_CSI2RX_MODULE_NAME, sizeof(cap->card));
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
> +				      struct v4l2_fmtdesc *f)
> +{
> +	const struct ti_csi2rx_fmt *fmt = NULL;
> +
> +	if (f->mbus_code) {
> +		if (f->index > 0)
> +			return -EINVAL;

This fails to enumerate the formats if mbus_code is set, doesn't it?

> +
> +		fmt = find_format_by_code(f->mbus_code);
> +	} else {
> +		if (f->index >= num_formats)
> +			return -EINVAL;
> +
> +		fmt = &formats[f->index];
> +	}
> +
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	f->pixelformat = fmt->fourcc;
> +	memset(f->reserved, 0, sizeof(f->reserved));
> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *prov,
> +				   struct v4l2_format *f)
> +{
> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
> +
> +	*f = csi->v_fmt;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
> +				     struct v4l2_format *f)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +
> +	/*
> +	 * Default to the first format if the requested pixel format code isn't
> +	 * supported.
> +	 */
> +	fmt = find_format_by_pix(f->fmt.pix.pixelformat);
> +	if (!fmt)
> +		fmt = &formats[0];
> +
> +	if (f->fmt.pix.field == V4L2_FIELD_ANY)
> +		f->fmt.pix.field = V4L2_FIELD_NONE;
> +
> +	if (f->fmt.pix.field != V4L2_FIELD_NONE)
> +		/* Interlaced formats are not supported. */
> +		f->fmt.pix.field = V4L2_FIELD_NONE;

Can't you just always set the field to V4L2_FIELD_NONE?

> +	ti_csi2rx_fill_fmt(fmt, f);
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
> +				   struct v4l2_format *f)
> +{
> +	struct ti_csi2rx_dev *csi = video_drvdata(file);
> +	struct vb2_queue *q = &csi->vidq;
> +	int ret;
> +
> +	if (vb2_is_busy(q))
> +		return -EBUSY;
> +
> +	ret = ti_csi2rx_try_fmt_vid_cap(file, priv, f);
> +	if (ret < 0)
> +		return ret;
> +
> +	csi->v_fmt = *f;
> +
> +	return 0;
> +}
> +
> +static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
> +				     struct v4l2_frmsizeenum *fsize)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +	unsigned int pixels_in_word;
> +	u8 bpp;
> +
> +	fmt = find_format_by_pix(fsize->pixel_format);
> +	if (!fmt || fsize->index != 0)
> +		return -EINVAL;
> +
> +	bpp = ALIGN(fmt->bpp, 8);
> +
> +	/*
> +	 * Number of pixels in one PSI-L word. The transfer happens in multiples
> +	 * of PSI-L word sizes.
> +	 */
> +	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / bpp;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
> +	fsize->stepwise.min_width = pixels_in_word;
> +	fsize->stepwise.max_width = rounddown(MAX_WIDTH_BYTES * 8 / bpp,
> +					      pixels_in_word);
> +	fsize->stepwise.step_width = pixels_in_word;
> +	fsize->stepwise.min_height = 1;
> +	fsize->stepwise.max_height = MAX_HEIGHT_LINES;
> +	fsize->stepwise.step_height = 1;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops csi_ioctl_ops = {
> +	.vidioc_querycap      = ti_csi2rx_querycap,
> +	.vidioc_enum_fmt_vid_cap = ti_csi2rx_enum_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap = ti_csi2rx_try_fmt_vid_cap,
> +	.vidioc_g_fmt_vid_cap = ti_csi2rx_g_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap = ti_csi2rx_s_fmt_vid_cap,
> +	.vidioc_enum_framesizes = ti_csi2rx_enum_framesizes,
> +	.vidioc_reqbufs       = vb2_ioctl_reqbufs,
> +	.vidioc_create_bufs   = vb2_ioctl_create_bufs,
> +	.vidioc_prepare_buf   = vb2_ioctl_prepare_buf,
> +	.vidioc_querybuf      = vb2_ioctl_querybuf,
> +	.vidioc_qbuf          = vb2_ioctl_qbuf,
> +	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
> +	.vidioc_expbuf        = vb2_ioctl_expbuf,
> +	.vidioc_streamon      = vb2_ioctl_streamon,
> +	.vidioc_streamoff     = vb2_ioctl_streamoff,
> +};
> +
> +static const struct v4l2_file_operations csi_fops = {
> +	.owner = THIS_MODULE,
> +	.open = v4l2_fh_open,
> +	.release = vb2_fop_release,
> +	.read = vb2_fop_read,
> +	.poll = vb2_fop_poll,
> +	.unlocked_ioctl = video_ioctl2,
> +	.mmap = vb2_fop_mmap,
> +};
> +
> +static int csi_async_notifier_bound(struct v4l2_async_notifier *notifier,
> +				    struct v4l2_subdev *subdev,
> +				    struct v4l2_async_connection *asc)
> +{
> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
> +
> +	csi->subdev = subdev;
> +
> +	return 0;
> +}
> +
> +static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
> +	struct video_device *vdev = &csi->vdev;
> +	int ret;
> +
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l2_create_fwnode_links_to_pad(csi->subdev, &csi->pad,
> +					      MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> +
> +	if (ret) {
> +		video_unregister_device(vdev);
> +		return ret;
> +	}
> +
> +	return v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
> +}
> +
> +static const struct v4l2_async_notifier_operations csi_async_notifier_ops = {
> +	.bound = csi_async_notifier_bound,
> +	.complete = csi_async_notifier_complete,
> +};
> +
> +static int ti_csi2rx_init_subdev(struct ti_csi2rx_dev *csi)

This is misnamed. ti_csi2rx_async_notifier_register()?

> +{
> +	struct fwnode_handle *fwnode;
> +	struct v4l2_async_connection *asc;
> +	struct device_node *node;
> +	int ret;
> +
> +	node = of_get_child_by_name(csi->dev->of_node, "csi-bridge");
> +	if (!node)
> +		return -EINVAL;
> +
> +	fwnode = of_fwnode_handle(node);
> +	if (!fwnode) {
> +		of_node_put(node);
> +		return -EINVAL;
> +	}
> +
> +	v4l2_async_nf_init(&csi->notifier, &csi->v4l2_dev);
> +	csi->notifier.ops = &csi_async_notifier_ops;
> +
> +	asc = v4l2_async_nf_add_fwnode(&csi->notifier, fwnode,
> +				       struct v4l2_async_connection);
> +	of_node_put(node);
> +	if (IS_ERR(asc)) {
> +		v4l2_async_nf_cleanup(&csi->notifier);
> +		return PTR_ERR(asc);
> +	}
> +
> +	ret = v4l2_async_nf_register(&csi->notifier);
> +	if (ret) {
> +		v4l2_async_nf_cleanup(&csi->notifier);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
> +{
> +	const struct ti_csi2rx_fmt *fmt;
> +	unsigned int reg;
> +
> +	fmt = find_format_by_pix(csi->v_fmt.fmt.pix.pixelformat);
> +	if (!fmt) {
> +		dev_err(csi->dev, "Unknown format\n");
> +		return;
> +	}

The error print here is rather vague, and as there's no error code 
returned, the caller doesn't handle the error.

> +
> +	/* De-assert the pixel interface reset. */
> +	reg = SHIM_CNTL_PIX_RST;
> +	writel(reg, csi->shim + SHIM_CNTL);
> +
> +	reg = SHIM_DMACNTX_EN;
> +	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
> +
> +	/*
> +	 * Using the values from the documentation gives incorrect ordering for
> +	 * the luma and chroma components. In practice, the "reverse" format
> +	 * gives the correct image. So for example, if the image is in UYVY, the
> +	 * reverse would be YVYU.
> +	 */
> +	switch (fmt->fourcc) {
> +	case V4L2_PIX_FMT_UYVY:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_YVYU);
> +		break;
> +	case V4L2_PIX_FMT_VYUY:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_YUYV);
> +		break;
> +	case V4L2_PIX_FMT_YUYV:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_VYUY);
> +		break;
> +	case V4L2_PIX_FMT_YVYU:
> +		reg |= FIELD_PREP(SHIM_DMACNTX_YUV422,
> +					SHIM_DMACNTX_UYVY);
> +		break;
> +	default:
> +		/* Ignore if not YUV 4:2:2 */
> +		break;
> +	}
> +
> +	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
> +
> +	writel(reg, csi->shim + SHIM_DMACNTX);
> +
> +	reg = FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
> +	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
> +	writel(reg, csi->shim + SHIM_PSI_CFG0);
> +}
> +
> +static void ti_csi2rx_drain_callback(void *param)
> +{
> +	struct completion *drain_complete = param;
> +
> +	complete(drain_complete);
> +}
> +
> +static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
> +{

I think it would be good to explain in a comment somewhere what why this 
dma draining is needed and how it works.

> +	struct dma_async_tx_descriptor *desc;
> +	struct device *dev = csi->dma.chan->device->dev;
> +	struct completion drain_complete;
> +	void *buf;
> +	size_t len = csi->v_fmt.fmt.pix.sizeimage;
> +	dma_addr_t addr;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	init_completion(&drain_complete);
> +
> +	buf = dma_alloc_coherent(dev, len, &addr, GFP_KERNEL | GFP_ATOMIC);
> +	if (!buf)
> +		return -ENOMEM;

If I understand right, this is called when the streaming is stopped, but 
could also be called on frame drops? You're allocating a DMA buffer for 
a full frame. Large runtime DMA buffer allocations are a bit scary. What 
happens if it fails?

Is it possible to preallocate, or use smaller buffers (perhaps with 
multiple dma operations) to do the flush?

The dma doesn't support writing to a constant address, does it (in which 
case a very small buffer would suffice)?

  Tomi

