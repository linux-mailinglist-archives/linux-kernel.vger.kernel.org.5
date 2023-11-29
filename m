Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7B7FDB89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjK2PeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjK2PeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:34:02 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C5D46;
        Wed, 29 Nov 2023 07:34:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A79960004;
        Wed, 29 Nov 2023 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701272043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FANDQ7uoSzTdIzeKBL55NnIA8H9XZyMvM2cwQYUQKyo=;
        b=JcUysF5LObCUxP+2Txtkuc42eZchSk7Aw0Bs1KL90UDw62icrOphf2M6KqHaEQ3DT+umQV
        c7mMYwxfHt6WhpLCMEGnomDQL6XoaTmSj5tiQDbTP0LG275fpltPAaEg9932R2LtDhOk5E
        9c/BW2U3qVnnJBg6swSNYO7FEoLBRwg6WH6vnKF0c3xMqkc420cxi5P1nKOw8rI/AJbPw0
        8jpV3xH8UTldvJ16pwXNJNqrqJ3rR/Z5DK/4poPmVUOzNuKZN3AWT83mkLNCzxg86DpcLk
        qDWjN4bLZQWZ2HKuih5jbrC70XQHSj2K1P3oA8Ibs067I01vpqKrv9C/ZLw2YA==
Date:   Wed, 29 Nov 2023 16:34:00 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZWdZ6CKHDO5kO9lA@aptenodytes>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JWXUfGgiE2/LRajP"
Content-Disposition: inline
In-Reply-To: <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWXUfGgiE2/LRajP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

The driver is vastly improving, kudos! See a few remaining comments below.

On Thu 16 Nov 23, 12:04, Mehdi Djait wrote:
> This introduces a V4L2 driver for the Rockchip CIF video capture controll=
er.
>=20
> This controller supports multiple parallel interfaces, but for now only t=
he
> BT.656 interface could be tested, hence it's the only one that's supported
> in the first version of this driver.
>=20
> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> but for now it's only been tested on the PX30.
>=20
> CIF is implemented as a video node-centric driver.
>=20
> Most of this driver was written following the BSP driver from rockchip,

nit: Rockchip with uppercase.

> removing the parts that either didn't fit correctly the guidelines, or th=
at
> couldn't be tested.
>=20
> This basic version doesn't support cropping nor scaling and is only
> designed with one SDTV video decoder being attached to it at any time.
>=20
> This version uses the "pingpong" mode of the controller, which is a
> double-buffering mechanism.
>=20
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/media/platform/rockchip/Kconfig       |    1 +
>  drivers/media/platform/rockchip/Makefile      |    1 +
>  drivers/media/platform/rockchip/cif/Kconfig   |   13 +
>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>  drivers/media/platform/rockchip/cif/capture.c | 1120 +++++++++++++++++
>  drivers/media/platform/rockchip/cif/capture.h |   21 +
>  drivers/media/platform/rockchip/cif/common.h  |  129 ++
>  drivers/media/platform/rockchip/cif/dev.c     |  302 +++++
>  drivers/media/platform/rockchip/cif/regs.h    |  127 ++
>  10 files changed, 1724 insertions(+)
>  create mode 100644 drivers/media/platform/rockchip/cif/Kconfig
>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>  create mode 100644 drivers/media/platform/rockchip/cif/capture.h
>  create mode 100644 drivers/media/platform/rockchip/cif/common.h
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3e6dbbbbccb..ad9d0323c956 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18523,6 +18523,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
>  F:	drivers/hid/hid-roccat*
>  F:	include/linux/hid-roccat*
> =20
> +ROCKCHIP CIF DRIVER
> +M:	Mehdi Djait <mehdi.djait@bootlin.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/rockchip,rk3066-cif.yaml

You probably need to update this one too now that we're back to the px30 na=
ming.

> +F:	drivers/media/platform/rockchip/cif/
> +
>  ROCKCHIP CRYPTO DRIVERS
>  M:	Corentin Labbe <clabbe@baylibre.com>
>  L:	linux-crypto@vger.kernel.org
> diff --git a/drivers/media/platform/rockchip/Kconfig b/drivers/media/plat=
form/rockchip/Kconfig
> index b41d3960c1b4..f73d68d1d2b6 100644
> --- a/drivers/media/platform/rockchip/Kconfig
> +++ b/drivers/media/platform/rockchip/Kconfig
> @@ -2,5 +2,6 @@
> =20
>  comment "Rockchip media platform drivers"
> =20
> +source "drivers/media/platform/rockchip/cif/Kconfig"
>  source "drivers/media/platform/rockchip/rga/Kconfig"
>  source "drivers/media/platform/rockchip/rkisp1/Kconfig"
> diff --git a/drivers/media/platform/rockchip/Makefile b/drivers/media/pla=
tform/rockchip/Makefile
> index 4f782b876ac9..1a7aa1f8e134 100644
> --- a/drivers/media/platform/rockchip/Makefile
> +++ b/drivers/media/platform/rockchip/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y +=3D cif/
>  obj-y +=3D rga/
>  obj-y +=3D rkisp1/
> diff --git a/drivers/media/platform/rockchip/cif/Kconfig b/drivers/media/=
platform/rockchip/cif/Kconfig
> new file mode 100644
> index 000000000000..68fc50c51f1c
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/Kconfig
> @@ -0,0 +1,13 @@
> +config VIDEO_ROCKCHIP_CIF
> +	tristate "Rockchip CIF Video Camera Interface"
> +	depends on VIDEO_DEV
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on PM && COMMON_CLK
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	select VIDEO_V4L2_SUBDEV_API
> +	help
> +	  This is a driver for Rockchip SoC Camera interface. It supports
> +	  parallel interfaces such as BT.656. This camera interface is both
> +	  called VIP and CIF.
> diff --git a/drivers/media/platform/rockchip/cif/Makefile b/drivers/media=
/platform/rockchip/cif/Makefile
> new file mode 100644
> index 000000000000..e44ef687aeb6
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIDEO_ROCKCHIP_CIF) +=3D rockchip-cif.o
> +rockchip-cif-objs +=3D dev.o capture.o
> diff --git a/drivers/media/platform/rockchip/cif/capture.c b/drivers/medi=
a/platform/rockchip/cif/capture.c
> new file mode 100644
> index 000000000000..bf443cdf2f67
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/capture.c
> @@ -0,0 +1,1120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip CIF Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "capture.h"
> +#include "common.h"
> +#include "regs.h"
> +
> +#define CIF_REQ_BUFS_MIN	2
> +#define CIF_MIN_WIDTH		64
> +#define CIF_MIN_HEIGHT		64
> +#define CIF_MAX_WIDTH		8192
> +#define CIF_MAX_HEIGHT		8192
> +
> +#define CIF_PLANE_Y		0
> +#define CIF_PLANE_UV		1
> +
> +static struct cif_output_fmt out_fmts[] =3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV16,
> +		.fmt_val =3D CIF_FORMAT_YUV_OUTPUT_422 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
> +		.cplanes =3D 2,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_NV61,
> +		.fmt_val =3D CIF_FORMAT_YUV_OUTPUT_422 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
> +		.cplanes =3D 2,
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.fmt_val =3D CIF_FORMAT_YUV_OUTPUT_420 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_UVUV,
> +		.cplanes =3D 2,
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV21,
> +		.fmt_val =3D CIF_FORMAT_YUV_OUTPUT_420 |
> +			   CIF_FORMAT_UV_STORAGE_ORDER_VUVU,
> +		.cplanes =3D 2,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_RGB24,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_RGB565,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_BGR666,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SRGGB8,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGRBG8,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGBRG8,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SBGGR8,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SRGGB10,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGRBG10,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGBRG10,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SBGGR10,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SRGGB12,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGRBG12,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SGBRG12,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SBGGR12,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_SBGGR16,
> +		.cplanes =3D 1,
> +	}, {
> +		.fourcc =3D V4L2_PIX_FMT_Y16,
> +		.cplanes =3D 1,
> +	}
> +};
> +
> +static const struct cif_input_fmt in_fmts[] =3D {
> +	{
> +		.mbus_code	=3D MEDIA_BUS_FMT_YUYV8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_YUYV8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_YVYU8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_YVYU8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_UYVY8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_UYVY8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_VYUY8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_VYUY8_2X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_YUV_INPUT_422 |
> +				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
> +		.fmt_type	=3D CIF_FMT_TYPE_YUV,
> +		.field		=3D V4L2_FIELD_INTERLACED,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SBGGR12_1X12,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGBRG12_1X12,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SGRBG12_1X12,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_SRGGB12_1X12,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_RGB888_1X24,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_Y8_1X8,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_8,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_Y10_1X10,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_10,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}, {
> +		.mbus_code	=3D MEDIA_BUS_FMT_Y12_1X12,
> +		.dvp_fmt_val	=3D CIF_FORMAT_INPUT_MODE_RAW |
> +				  CIF_FORMAT_RAW_DATA_WIDTH_12,
> +		.fmt_type	=3D CIF_FMT_TYPE_RAW,
> +		.field		=3D V4L2_FIELD_NONE,
> +	}
> +};
> +
> +static const struct
> +cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
> +{
> +	struct v4l2_subdev_format fmt;
> +	u32 i;
> +
> +	fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
> +	fmt.pad =3D 0;
> +	v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(in_fmts); i++)
> +		if (fmt.format.code =3D=3D in_fmts[i].mbus_code &&
> +		    fmt.format.field =3D=3D in_fmts[i].field)
> +			return &in_fmts[i];
> +
> +	v4l2_err(sd->v4l2_dev, "remote's mbus code not supported\n");
> +	return NULL;
> +}
> +
> +static struct
> +cif_output_fmt *find_output_fmt(struct cif_stream *stream, u32 pixelfmt)
> +{
> +	struct cif_output_fmt *fmt;
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(out_fmts); i++) {
> +		fmt =3D &out_fmts[i];
> +		if (fmt->fourcc =3D=3D pixelfmt)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct cif_buffer *cif_get_buffer(struct cif_stream *stream)
> +{
> +	struct cif_buffer *buff;
> +
> +	lockdep_assert_held(&stream->vbq_lock);
> +
> +	if (list_empty(&stream->buf_head))
> +		return NULL;
> +
> +	buff =3D list_first_entry(&stream->buf_head, struct cif_buffer, queue);
> +	list_del(&buff->queue);
> +
> +	return buff;
> +}
> +
> +static int cif_init_buffers(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	stream->buffs[0] =3D cif_get_buffer(stream);
> +	stream->buffs[1] =3D cif_get_buffer(stream);
> +
> +	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
> +		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +		return -EINVAL;
> +	}
> +
> +	stream->drop_frame =3D false;
> +
> +	cif_write(cif_dev, CIF_FRM0_ADDR_Y,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM0_ADDR_UV,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_UV]);
> +
> +	cif_write(cif_dev, CIF_FRM1_ADDR_Y,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM1_ADDR_UV,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_UV]);
> +
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	return 0;
> +}
> +
> +static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct cif_buffer *buffer =3D NULL;
> +	u32 frm_addr_y, frm_addr_uv;
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	buffer =3D cif_get_buffer(stream);
> +
> +	/*
> +	 * In Pingpong mode:
> +	 * After one frame0 captured, CIF will start to capture the next frame1
> +	 * automatically.
> +	 *
> +	 * If there is no buffer:
> +	 * 1. Make the next frame0 write to the buffer of frame1.
> +	 *
> +	 * 2. Drop the frame1: Don't return it to user-space, as it will be
> +	 *    overwritten by the next frame0.
> +	 */
> +	if (!buffer) {
> +		stream->drop_frame =3D true;
> +		buffer =3D stream->buffs[1 - stream->frame_phase];
> +	} else {
> +		stream->drop_frame =3D false;
> +	}
> +
> +	stream->buffs[stream->frame_phase] =3D buffer;
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	frm_addr_y =3D stream->frame_phase ? CIF_FRM1_ADDR_Y : CIF_FRM0_ADDR_Y;
> +	frm_addr_uv =3D stream->frame_phase ? CIF_FRM1_ADDR_UV : CIF_FRM0_ADDR_=
UV;
> +
> +	cif_write(cif_dev, frm_addr_y, buffer->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, frm_addr_uv, buffer->buff_addr[CIF_PLANE_UV]);
> +}
> +
> +static void cif_stream_stop(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	u32 val;
> +
> +	val =3D cif_read(cif_dev, CIF_CTRL);
> +	cif_write(cif_dev, CIF_CTRL, val & (~CIF_CTRL_ENABLE_CAPTURE));
> +	cif_write(cif_dev, CIF_INTEN, 0x0);
> +	cif_write(cif_dev, CIF_INTSTAT, 0x3ff);
> +	cif_write(cif_dev, CIF_FRAME_STATUS, 0x0);
> +
> +	stream->stopping =3D false;
> +}
> +
> +static int cif_queue_setup(struct vb2_queue *queue,
> +			   unsigned int *num_buffers,
> +			   unsigned int *num_planes,
> +			   unsigned int sizes[],
> +			   struct device *alloc_devs[])
> +{
> +	struct cif_stream *stream =3D queue->drv_priv;
> +
> +	if (*num_planes)
> +		return sizes[0] < stream->pix.sizeimage ? -EINVAL : 0;
> +
> +	*num_planes =3D 1;
> +	sizes[0] =3D stream->pix.sizeimage;
> +
> +	return 0;
> +}
> +
> +static void cif_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> +	struct cif_buffer *cifbuf =3D to_cif_buffer(vbuf);
> +	struct vb2_queue *queue =3D vb->vb2_queue;
> +	struct cif_stream *stream =3D queue->drv_priv;
> +	struct v4l2_pix_format *pix =3D &stream->pix;
> +	unsigned long lock_flags;
> +	int i;
> +
> +	struct cif_output_fmt *fmt =3D stream->cif_fmt_out;
> +
> +	memset(cifbuf->buff_addr, 0, sizeof(cifbuf->buff_addr));
> +
> +	cifbuf->buff_addr[0] =3D vb2_dma_contig_plane_dma_addr(vb, 0);
> +
> +	for (i =3D 0; i < fmt->cplanes - 1; i++)
> +		cifbuf->buff_addr[i + 1] =3D cifbuf->buff_addr[i] +
> +			pix->bytesperline * pix->height;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +	list_add_tail(&cifbuf->queue, &stream->buf_head);
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +}
> +
> +static void cif_return_all_buffers(struct cif_stream *stream,
> +				   enum vb2_buffer_state state)
> +{
> +	struct cif_buffer *buf;
> +	unsigned long lock_flags;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	if (stream->buffs[0]) {
> +		vb2_buffer_done(&stream->buffs[0]->vb.vb2_buf, state);
> +		stream->buffs[0] =3D NULL;
> +	}
> +
> +	if (stream->buffs[1]) {
> +		if (!stream->drop_frame)
> +			vb2_buffer_done(&stream->buffs[1]->vb.vb2_buf, state);
> +
> +		stream->buffs[1] =3D NULL;
> +	}
> +
> +	while (!list_empty(&stream->buf_head)) {
> +		buf =3D cif_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +	}
> +
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +}
> +
> +static void cif_stop_streaming(struct vb2_queue *queue)
> +{
> +	struct cif_stream *stream =3D queue->drv_priv;
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	stream->stopping =3D true;
> +	ret =3D wait_event_timeout(stream->wq_stopped,
> +				 !stream->stopping,
> +				 msecs_to_jiffies(1000));
> +	if (!ret) {
> +		cif_stream_stop(stream);
> +		stream->stopping =3D false;

This is already set in cif_stream_stop.

> +	}
> +
> +	/* Stop the sub device. */
> +	sd =3D cif_dev->remote.sd;
> +	v4l2_subdev_call(sd, video, s_stream, 0);

Please do this before stopping the capture interface.

If there is an issue caused by the fact that wq_stopped needs a final inter=
rupt
to complete (which me might loose if we don't wait for another frame) then =
make
it clear in the comment why you're doing things in that order.

> +
> +	pm_runtime_put(cif_dev->dev);
> +
> +	cif_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
> +}
> +
> +static int cif_stream_start(struct cif_stream *stream)
> +{
> +	u32 val, mbus_flags, href_pol, vsync_pol, fmt_type,
> +	    xfer_mode =3D 0;
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct cif_remote *remote_info =3D &cif_dev->remote;
> +	int ret;
> +	u32 input_mode;
> +
> +	stream->frame_idx =3D 0;

You probably need to reset frame_phase to 0 too, unless the controller will
restart from the previous position after a stream off + stream on sequence?
(This seems unlikely.)

> +
> +	fmt_type =3D stream->cif_fmt_in->fmt_type;
> +	input_mode =3D (remote_info->std =3D=3D V4L2_STD_NTSC) ?
> +		      CIF_FORMAT_INPUT_MODE_NTSC :
> +		      CIF_FORMAT_INPUT_MODE_PAL;
> +	mbus_flags =3D remote_info->mbus.bus.parallel.flags;
> +	href_pol =3D (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
> +			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
> +	vsync_pol =3D (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
> +			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
> +
> +	val =3D vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_va=
l |
> +	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode;
> +	cif_write(cif_dev, CIF_FOR, val);
> +
> +	val =3D stream->pix.width;
> +	if (stream->cif_fmt_in->fmt_type =3D=3D CIF_FMT_TYPE_RAW)
> +		val =3D stream->pix.width * 2;
> +
> +	cif_write(cif_dev, CIF_VIR_LINE_WIDTH, val);
> +	cif_write(cif_dev, CIF_SET_SIZE,
> +		  stream->pix.width | (stream->pix.height << 16));
> +
> +	cif_write(cif_dev, CIF_FRAME_STATUS, CIF_FRAME_STAT_CLS);
> +	cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_CLS);
> +	cif_write(cif_dev, CIF_SCL_CTRL, (fmt_type =3D=3D CIF_FMT_TYPE_YUV) ?
> +					 CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS :
> +					 CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS);
> +
> +	ret =3D cif_init_buffers(stream);
> +	if (ret)
> +		return ret;
> +
> +	cif_write(cif_dev, CIF_INTEN, CIF_INTEN_FRAME_END_EN |
> +				      CIF_INTEN_LINE_ERR_EN |
> +				      CIF_INTEN_PST_INF_FRAME_END_EN);
> +
> +	cif_write(cif_dev, CIF_CTRL, CIF_CTRL_AXI_BURST_16 |
> +				     CIF_CTRL_MODE_PINGPONG |
> +				     CIF_CTRL_ENABLE_CAPTURE);
> +
> +	return 0;
> +}
> +
> +static int cif_start_streaming(struct vb2_queue *queue, unsigned int cou=
nt)
> +{
> +	struct cif_stream *stream =3D queue->drv_priv;
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct v4l2_device *v4l2_dev =3D &cif_dev->v4l2_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd) {
> +		ret =3D -ENODEV;
> +		v4l2_err(v4l2_dev, "No remote subdev detected\n");
> +		goto destroy_buf;
> +	}
> +
> +	ret =3D pm_runtime_get_sync(cif_dev->dev);

Use pm_runtime_resume_and_get instead.

> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to get runtime pm, %d\n", ret);
> +		goto destroy_buf;
> +	}
> +
> +	sd =3D cif_dev->remote.sd;
> +
> +	stream->cif_fmt_in =3D get_input_fmt(cif_dev->remote.sd);
> +	if (!stream->cif_fmt_in)
> +		goto runtime_put;
> +
> +	ret =3D cif_stream_start(stream);
> +	if (ret < 0)
> +		goto stop_stream;
> +
> +	ret =3D v4l2_subdev_call(sd, video, s_stream, 1);
> +	if (ret < 0)
> +		goto stop_stream;
> +
> +	return 0;
> +
> +stop_stream:
> +	cif_stream_stop(stream);
> +runtime_put:
> +	pm_runtime_put(cif_dev->dev);
> +destroy_buf:
> +	cif_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
> +
> +	return ret;
> +}
> +
> +static const struct vb2_ops cif_vb2_ops =3D {
> +	.queue_setup =3D cif_queue_setup,
> +	.buf_queue =3D cif_buf_queue,
> +	.wait_prepare =3D vb2_ops_wait_prepare,
> +	.wait_finish =3D vb2_ops_wait_finish,
> +	.stop_streaming =3D cif_stop_streaming,
> +	.start_streaming =3D cif_start_streaming,
> +};
> +
> +static int cif_init_vb2_queue(struct vb2_queue *q,
> +			      struct cif_stream *stream)
> +{
> +	q->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	q->io_modes =3D VB2_MMAP | VB2_DMABUF;
> +	q->drv_priv =3D stream;
> +	q->ops =3D &cif_vb2_ops;
> +	q->mem_ops =3D &vb2_dma_contig_memops;
> +	q->buf_struct_size =3D sizeof(struct cif_buffer);
> +	q->min_buffers_needed =3D CIF_REQ_BUFS_MIN;
> +	q->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->lock =3D &stream->vlock;
> +	q->dev =3D stream->cifdev->dev;
> +
> +	return vb2_queue_init(q);
> +}
> +
> +static void cif_update_pix(struct cif_stream *stream,
> +			   struct cif_output_fmt *fmt,
> +			   struct v4l2_pix_format *pix)
> +{
> +	struct cif_remote *remote_info =3D &stream->cifdev->remote;
> +	struct v4l2_subdev_format sd_fmt;
> +	u32 width, height;
> +
> +	sd_fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad =3D 0;
> +	v4l2_subdev_call(remote_info->sd, pad, get_fmt, NULL, &sd_fmt);
> +
> +	width =3D clamp_t(u32, sd_fmt.format.width,
> +			CIF_MIN_WIDTH, CIF_MAX_WIDTH);
> +	height =3D clamp_t(u32, sd_fmt.format.height,
> +			 CIF_MIN_HEIGHT, CIF_MAX_HEIGHT);
> +
> +	pix->width =3D width;
> +	pix->height =3D height;
> +	pix->field =3D sd_fmt.format.field;
> +	pix->colorspace =3D sd_fmt.format.colorspace;
> +	pix->ycbcr_enc =3D sd_fmt.format.ycbcr_enc;
> +	pix->quantization =3D sd_fmt.format.quantization;
> +	pix->xfer_func =3D sd_fmt.format.xfer_func;
> +
> +	v4l2_fill_pixfmt(pix, fmt->fourcc, pix->width, pix->height);
> +}
> +
> +static int cif_set_fmt(struct cif_stream *stream,
> +		       struct v4l2_pix_format *pix)
> +{
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct v4l2_subdev_format sd_fmt;
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (vb2_is_streaming(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	fmt =3D find_output_fmt(stream, pix->pixelformat);
> +	if (!fmt)
> +		fmt =3D &out_fmts[0];
> +
> +	sd_fmt.which =3D V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad =3D 0;
> +	sd_fmt.format.width =3D pix->width;
> +	sd_fmt.format.height =3D pix->height;
> +
> +	ret =3D v4l2_subdev_call(cif_dev->remote.sd, pad, set_fmt, NULL, &sd_fm=
t);
> +	if (ret)
> +		return ret;
> +
> +	cif_update_pix(stream, fmt, pix);
> +	stream->pix =3D *pix;
> +	stream->cif_fmt_out =3D fmt;
> +
> +	return 0;
> +}
> +
> +void cif_set_default_format(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream =3D &cif_dev->stream;
> +	struct v4l2_pix_format pix;
> +
> +	cif_dev->remote.std =3D V4L2_STD_NTSC;
> +
> +	pix.pixelformat =3D V4L2_PIX_FMT_NV12;
> +	pix.width =3D CIF_DEFAULT_WIDTH;
> +	pix.height =3D CIF_DEFAULT_HEIGHT;
> +
> +	cif_set_fmt(stream, &pix);
> +}
> +
> +void cif_stream_init(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream =3D &cif_dev->stream;
> +	struct v4l2_pix_format pix;
> +
> +	memset(stream, 0, sizeof(*stream));
> +	memset(&pix, 0, sizeof(pix));
> +	stream->cifdev =3D cif_dev;
> +
> +	INIT_LIST_HEAD(&stream->buf_head);
> +	spin_lock_init(&stream->vbq_lock);
> +	init_waitqueue_head(&stream->wq_stopped);
> +}
> +
> +static const struct v4l2_file_operations cif_fops =3D {
> +	.open =3D v4l2_fh_open,
> +	.release =3D vb2_fop_release,
> +	.unlocked_ioctl =3D video_ioctl2,
> +	.poll =3D vb2_fop_poll,
> +	.mmap =3D vb2_fop_mmap,
> +};
> +
> +static int cif_enum_input(struct file *file, void *priv,
> +			  struct v4l2_input *input)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct v4l2_subdev *sd =3D stream->cifdev->remote.sd;
> +	int ret;
> +
> +	if (input->index > 0)
> +		return -EINVAL;
> +
> +	ret =3D v4l2_subdev_call(sd, video, g_input_status, &input->status);
> +	if (ret)

Just ignore input->std if ret =3D=3D -EOPNOTSUPP. Not every subdev will sup=
port
this operation.

> +		return ret;
> +
> +	strscpy(input->name, "Camera", sizeof(input->name));
> +	input->type =3D V4L2_INPUT_TYPE_CAMERA;
> +	input->std =3D stream->vdev.tvnorms;
> +	input->capabilities =3D V4L2_IN_CAP_STD;
> +
> +	return 0;
> +}
> +
> +static int cif_try_fmt_vid_cap(struct file *file, void *fh,
> +			       struct v4l2_format *f)

Please move this closer to the other functions dealing with v4l2 format.

> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_output_fmt *fmt;
> +
> +	fmt =3D find_output_fmt(stream, f->fmt.pix.pixelformat);
> +	if (!fmt)
> +		fmt =3D &out_fmts[0];
> +
> +	cif_update_pix(stream, fmt, &f->fmt.pix);
> +
> +	return 0;
> +}
> +
> +static int cif_g_std(struct file *file, void *fh, v4l2_std_id *norm)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_remote *remote_info =3D &stream->cifdev->remote;
> +
> +	*norm =3D remote_info->std;
> +
> +	return 0;
> +}
> +
> +static int cif_s_std(struct file *file, void *fh, v4l2_std_id norm)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_remote *remote_info =3D &stream->cifdev->remote;
> +	int ret;
> +
> +	if (norm =3D=3D remote_info->std)
> +		return 0;
> +
> +	if (vb2_is_busy(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	ret =3D v4l2_subdev_call(remote_info->sd, video, s_std, norm);
> +	if (ret)
> +		return ret;
> +
> +	remote_info->std =3D norm;
> +
> +	/* S_STD will update the format since that depends on the standard. */
> +	cif_update_pix(stream, stream->cif_fmt_out, &stream->pix);
> +
> +	return 0;
> +}
> +
> +static int cif_querystd(struct file *file, void *fh, v4l2_std_id *a)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_remote *remote_info =3D &stream->cifdev->remote;
> +
> +	*a =3D V4L2_STD_UNKNOWN;
> +
> +	return v4l2_subdev_call(remote_info->sd, video, querystd, a);
> +}
> +
> +static int cif_enum_fmt_vid_cap(struct file *file, void *priv,
> +				struct v4l2_fmtdesc *f)
> +{
> +	struct cif_output_fmt *fmt =3D NULL;
> +
> +	if (f->index >=3D ARRAY_SIZE(out_fmts))
> +		return -EINVAL;
> +
> +	fmt =3D &out_fmts[f->index];
> +	f->pixelformat =3D fmt->fourcc;
> +
> +	return 0;
> +}
> +
> +static int cif_s_fmt_vid_cap(struct file *file,
> +			     void *priv, struct v4l2_format *f)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	int ret;
> +
> +	if (vb2_is_busy(&stream->buf_queue))
> +		return -EBUSY;
> +
> +	ret =3D cif_set_fmt(stream, &f->fmt.pix);
> +
> +	return ret;
> +}
> +
> +static int cif_g_fmt_vid_cap(struct file *file, void *fh,
> +			     struct v4l2_format *f)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +
> +	f->fmt.pix =3D stream->pix;
> +
> +	return 0;
> +}
> +
> +static int cif_querycap(struct file *file, void *priv,
> +			struct v4l2_capability *cap)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct device *dev =3D stream->cifdev->dev;
> +
> +	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
> +	strscpy(cap->card, dev->driver->name, sizeof(cap->card));
> +	snprintf(cap->bus_info, sizeof(cap->bus_info),
> +		 "platform:%s", dev_name(dev));
> +
> +	return 0;
> +}
> +
> +static int cif_enum_framesizes(struct file *file, void *fh,
> +			       struct v4l2_frmsizeenum *fsize)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct v4l2_subdev_frame_size_enum fse =3D {
> +		.index =3D fsize->index,
> +		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	fmt =3D find_output_fmt(stream, fsize->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fse.code =3D fmt->mbus;
> +
> +	ret =3D v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_size,
> +			       NULL, &fse);
> +	if (ret)
> +		return ret;
> +
> +	fsize->type =3D V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fsize->discrete.width =3D fse.max_width;
> +	fsize->discrete.height =3D fse.max_height;
> +
> +	return 0;
> +}
> +
> +static int cif_enum_frameintervals(struct file *file, void *fh,
> +				   struct v4l2_frmivalenum *fival)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +	struct v4l2_subdev_frame_interval_enum fie =3D {
> +		.index =3D fival->index,
> +		.width =3D fival->width,
> +		.height =3D fival->height,
> +		.which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> +	};
> +	struct cif_output_fmt *fmt;
> +	int ret;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	fmt =3D find_output_fmt(stream, fival->pixel_format);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	fie.code =3D fmt->mbus;
> +
> +	ret =3D v4l2_subdev_call(cif_dev->remote.sd, pad, enum_frame_interval,
> +			       NULL, &fie);
> +	if (ret)
> +		return ret;
> +
> +	fival->type =3D V4L2_FRMSIZE_TYPE_DISCRETE;
> +	fival->discrete =3D fie.interval;
> +
> +	return 0;
> +}
> +
> +static int cif_g_input(struct file *file, void *fh, unsigned int *i)
> +{
> +	*i =3D 0;
> +	return 0;
> +}
> +
> +static int cif_s_input(struct file *file, void *fh, unsigned int i)
> +{
> +	if (i)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int cif_g_parm(struct file *file, void *priv, struct v4l2_streamp=
arm *p)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	return v4l2_g_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
> +}
> +
> +static int cif_s_parm(struct file *file, void *priv, struct v4l2_streamp=
arm *p)
> +{
> +	struct cif_stream *stream =3D video_drvdata(file);
> +	struct cif_device *cif_dev =3D stream->cifdev;
> +
> +	if (!cif_dev->remote.sd)
> +		return -ENODEV;
> +
> +	return v4l2_s_parm_cap(video_devdata(file), cif_dev->remote.sd, p);
> +}
> +
> +static const struct v4l2_ioctl_ops cif_v4l2_ioctl_ops =3D {
> +	.vidioc_reqbufs =3D vb2_ioctl_reqbufs,
> +	.vidioc_querybuf =3D vb2_ioctl_querybuf,
> +	.vidioc_create_bufs =3D vb2_ioctl_create_bufs,
> +	.vidioc_qbuf =3D vb2_ioctl_qbuf,
> +	.vidioc_expbuf =3D vb2_ioctl_expbuf,
> +	.vidioc_dqbuf =3D vb2_ioctl_dqbuf,
> +	.vidioc_prepare_buf =3D vb2_ioctl_prepare_buf,
> +	.vidioc_streamon =3D vb2_ioctl_streamon,
> +	.vidioc_streamoff =3D vb2_ioctl_streamoff,
> +
> +	.vidioc_g_std =3D cif_g_std,
> +	.vidioc_s_std =3D cif_s_std,
> +	.vidioc_querystd =3D cif_querystd,
> +
> +	.vidioc_enum_fmt_vid_cap =3D cif_enum_fmt_vid_cap,
> +	.vidioc_try_fmt_vid_cap =3D cif_try_fmt_vid_cap,
> +	.vidioc_s_fmt_vid_cap =3D cif_s_fmt_vid_cap,
> +	.vidioc_g_fmt_vid_cap =3D cif_g_fmt_vid_cap,
> +	.vidioc_querycap =3D cif_querycap,
> +	.vidioc_enum_framesizes =3D cif_enum_framesizes,
> +	.vidioc_enum_frameintervals =3D cif_enum_frameintervals,
> +
> +	.vidioc_enum_input =3D cif_enum_input,
> +	.vidioc_g_input =3D cif_g_input,
> +	.vidioc_s_input =3D cif_s_input,
> +
> +	.vidioc_g_parm =3D cif_g_parm,
> +	.vidioc_s_parm =3D cif_s_parm,
> +};
> +
> +void cif_unregister_stream_vdev(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream =3D &cif_dev->stream;
> +
> +	media_entity_cleanup(&stream->vdev.entity);
> +	video_unregister_device(&stream->vdev);
> +}
> +
> +int cif_register_stream_vdev(struct cif_device *cif_dev)
> +{
> +	struct cif_stream *stream =3D &cif_dev->stream;
> +	struct v4l2_device *v4l2_dev =3D &cif_dev->v4l2_dev;
> +	struct video_device *vdev =3D &stream->vdev;
> +	int ret;
> +
> +	strscpy(vdev->name, CIF_DRIVER_NAME, sizeof(vdev->name));
> +	mutex_init(&stream->vlock);
> +
> +	vdev->ioctl_ops =3D &cif_v4l2_ioctl_ops;
> +	vdev->release =3D video_device_release_empty;
> +	vdev->fops =3D &cif_fops;
> +	vdev->minor =3D -1;
> +	vdev->v4l2_dev =3D v4l2_dev;
> +	vdev->lock =3D &stream->vlock;
> +	vdev->device_caps =3D V4L2_CAP_VIDEO_CAPTURE |
> +			    V4L2_CAP_STREAMING;
> +	vdev->tvnorms =3D V4L2_STD_NTSC | V4L2_STD_PAL;
> +	video_set_drvdata(vdev, stream);
> +	vdev->vfl_dir =3D VFL_DIR_RX;
> +	stream->pad.flags =3D MEDIA_PAD_FL_SINK;
> +
> +	cif_init_vb2_queue(&stream->buf_queue, stream);
> +
> +	vdev->queue =3D &stream->buf_queue;
> +	strscpy(vdev->name, KBUILD_MODNAME, sizeof(vdev->name));
> +
> +	ret =3D media_entity_pads_init(&vdev->entity, 1, &stream->pad);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret < 0)
> +		v4l2_err(v4l2_dev,
> +			 "video_register_device failed with error %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void cif_vb_done(struct cif_stream *stream,
> +			struct vb2_v4l2_buffer *vb_done)
> +{
> +	vb2_set_plane_payload(&vb_done->vb2_buf, 0,
> +			      stream->pix.sizeimage);
> +	vb_done->vb2_buf.timestamp =3D ktime_get_ns();
> +	vb_done->sequence =3D stream->frame_idx;
> +	vb2_buffer_done(&vb_done->vb2_buf, VB2_BUF_STATE_DONE);
> +}
> +
> +static void cif_reset_stream(struct cif_device *cif_dev)
> +{
> +	u32 ctl =3D cif_read(cif_dev, CIF_CTRL);
> +
> +	cif_write(cif_dev, CIF_CTRL, ctl & (~CIF_CTRL_ENABLE_CAPTURE));
> +	cif_write(cif_dev, CIF_CTRL, ctl | CIF_CTRL_ENABLE_CAPTURE);
> +}
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx)
> +{
> +	struct device *dev =3D ctx;
> +	struct cif_device *cif_dev =3D dev_get_drvdata(dev);
> +	struct cif_stream *stream =3D &cif_dev->stream;
> +	unsigned int intstat;
> +	u32 lastline, lastpix, ctl, cif_frmst;
> +
> +	intstat =3D cif_read(cif_dev, CIF_INTSTAT);
> +	cif_frmst =3D cif_read(cif_dev, CIF_FRAME_STATUS);
> +	lastline =3D CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_LINE));
> +	lastpix =3D  CIF_FETCH_Y_LAST_LINE(cif_read(cif_dev, CIF_LAST_PIX));
> +	ctl =3D cif_read(cif_dev, CIF_CTRL);
> +
> +	/*
> +	 * There are two irqs enabled:
> +	 *  - PST_INF_FRAME_END: cif FIFO is ready,
> +	 *    this is prior to FRAME_END
> +	 *  - FRAME_END: cif has saved frame to memory,
> +	 *    a frame ready
> +	 */
> +
> +	if (intstat & CIF_INTSTAT_PST_INF_FRAME_END) {
> +		cif_write(cif_dev, CIF_INTSTAT,
> +			  CIF_INTSTAT_PST_INF_FRAME_END_CLR);
> +
> +		if (stream->stopping)
> +			/* To stop CIF ASAP, before FRAME_END irq. */
> +			cif_write(cif_dev, CIF_CTRL,
> +				  ctl & (~CIF_CTRL_ENABLE_CAPTURE));
> +	}
> +
> +	if (intstat & CIF_INTSTAT_PRE_INF_FRAME_END)
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_PRE_INF_FRAME_END);
> +
> +	if (intstat & (CIF_INTSTAT_LINE_ERR | CIF_INTSTAT_PIX_ERR)) {
> +		v4l2_err(&cif_dev->v4l2_dev,
> +			 "LINE_ERR OR PIX_ERR detected, stream will be reset");
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_LINE_ERR |
> +						CIF_INTSTAT_PIX_ERR);
> +		cif_reset_stream(cif_dev);
> +	}
> +
> +	if (intstat & CIF_INTSTAT_FRAME_END) {
> +		struct vb2_v4l2_buffer *vb_done =3D NULL;
> +
> +		cif_write(cif_dev, CIF_INTSTAT, CIF_INTSTAT_FRAME_END_CLR |
> +						CIF_INTSTAT_LINE_END_CLR);
> +
> +		if (stream->stopping) {
> +			cif_stream_stop(stream);
> +			wake_up(&stream->wq_stopped);
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (lastline !=3D stream->pix.height) {
> +			v4l2_err(&cif_dev->v4l2_dev,
> +				 "Bad frame, irq:%#x frmst:%#x size:%dx%d\n",
> +				 intstat, cif_frmst, lastpix, lastline);
> +
> +			cif_reset_stream(cif_dev);
> +		}
> +
> +		if (cif_frmst & CIF_INTSTAT_F0_READY)
> +			stream->frame_phase =3D 0;
> +		else if (cif_frmst & CIF_INTSTAT_F1_READY)
> +			stream->frame_phase =3D 1;
> +		else
> +			return IRQ_HANDLED;
> +
> +		vb_done =3D &stream->buffs[stream->frame_phase]->vb;
> +		if (!stream->drop_frame) {
> +			cif_vb_done(stream, vb_done);
> +			stream->frame_idx++;
> +		}
> +
> +		cif_assign_new_buffer_pingpong(stream);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/media/platform/rockchip/cif/capture.h b/drivers/medi=
a/platform/rockchip/cif/capture.h
> new file mode 100644
> index 000000000000..533e62f518da
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/capture.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_CAPTURE_H
> +#define _CIF_CAPTURE_H
> +
> +struct cif_device;
> +
> +void cif_unregister_stream_vdev(struct cif_device *dev);
> +int cif_register_stream_vdev(struct cif_device *dev);
> +void cif_stream_init(struct cif_device *dev);
> +void cif_set_default_format(struct cif_device *dev);
> +
> +irqreturn_t cif_irq_pingpong(int irq, void *ctx);
> +void cif_soft_reset(struct cif_device *cif_dev);
> +
> +#endif
> diff --git a/drivers/media/platform/rockchip/cif/common.h b/drivers/media=
/platform/rockchip/cif/common.h
> new file mode 100644
> index 000000000000..d801da61d99d
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/common.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_COMMON_H
> +#define _CIF_COMMON_H
> +
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define CIF_DRIVER_NAME		"rockchip-cif"
> +
> +#define CIF_MAX_BUS_CLK		8
> +#define CIF_MAX_SENSOR		1
> +#define CIF_MAX_RESET		5
> +
> +#define CIF_DEFAULT_WIDTH	640
> +#define CIF_DEFAULT_HEIGHT	480
> +
> +struct cif_buffer {
> +	struct vb2_v4l2_buffer	vb;
> +	struct list_head	queue;
> +	u32			buff_addr[VIDEO_MAX_PLANES];
> +};
> +
> +static inline struct cif_buffer *to_cif_buffer(struct vb2_v4l2_buffer *v=
b)
> +{
> +	return container_of(vb, struct cif_buffer, vb);
> +}
> +
> +struct cif_remote {
> +	struct v4l2_subdev	*sd;
> +	int			pad;
> +	struct v4l2_mbus_config mbus;
> +	int			lanes;
> +	v4l2_std_id		std;
> +};
> +
> +struct cif_output_fmt {
> +	u32	fourcc;
> +	u32	mbus;
> +	u32	fmt_val;
> +	u8	cplanes;
> +};
> +
> +enum cif_fmt_type {
> +	CIF_FMT_TYPE_YUV =3D 0,
> +	CIF_FMT_TYPE_RAW,
> +};
> +
> +struct cif_input_fmt {
> +	u32			mbus_code;
> +	u32			dvp_fmt_val;
> +	enum cif_fmt_type	fmt_type;
> +	enum v4l2_field		field;
> +};
> +
> +struct cif_stream {
> +	struct cif_device		*cifdev;
> +	bool				stopping;
> +	wait_queue_head_t		wq_stopped;
> +	int				frame_idx;
> +	int				frame_phase;
> +	bool				drop_frame;
> +
> +	/* Lock between irq and buf_queue, buffs. */
> +	spinlock_t			vbq_lock;
> +	struct vb2_queue		buf_queue;
> +	struct list_head		buf_head;
> +	struct cif_buffer		*buffs[2];
> +
> +	/* Lock used by the V4L core. */
> +	struct mutex			vlock;
> +	struct video_device		vdev;
> +	struct media_pad		pad;
> +
> +	struct cif_output_fmt		*cif_fmt_out;
> +	const struct cif_input_fmt	*cif_fmt_in;
> +	struct v4l2_pix_format		pix;
> +};
> +
> +static inline struct cif_stream *to_cif_stream(struct video_device *vdev)
> +{
> +	return container_of(vdev, struct cif_stream, vdev);
> +}
> +
> +struct cif_match_data {
> +	struct clk_bulk_data *clks;
> +	int clks_num;
> +};
> +
> +struct cif_device {
> +	struct device			*dev;
> +	int				irq;
> +	void __iomem			*base_addr;
> +	struct reset_control		*cif_rst;
> +
> +	struct v4l2_device		v4l2_dev;
> +	struct media_device		media_dev;
> +	struct v4l2_async_notifier	notifier;
> +	struct v4l2_async_connection	asd;
> +	struct cif_remote		remote;
> +
> +	struct cif_stream		stream;
> +	const struct cif_match_data	*match_data;
> +};
> +
> +static inline void cif_write(struct cif_device *cif_dev, unsigned int ad=
dr,
> +			     u32 val)
> +{
> +	writel(val, cif_dev->base_addr + addr);
> +}
> +
> +static inline u32 cif_read(struct cif_device *cif_dev, unsigned int addr)
> +{
> +	return readl(cif_dev->base_addr + addr);
> +}
> +
> +#endif
> diff --git a/drivers/media/platform/rockchip/cif/dev.c b/drivers/media/pl=
atform/rockchip/cif/dev.c
> new file mode 100644
> index 000000000000..380f24a1c7b1
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip CIF Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <media/v4l2-fwnode.h>
> +
> +#include "capture.h"
> +#include "common.h"
> +#include "regs.h"
> +
> +static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct cif_device *cif_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	cif_dev =3D container_of(notifier, struct cif_device, notifier);
> +	sd =3D cif_dev->remote.sd;
> +
> +	mutex_lock(&cif_dev->media_dev.graph_mutex);
> +
> +	ret =3D v4l2_device_register_subdev_nodes(&cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret =3D media_create_pad_link(&sd->entity, 0,
> +				    &cif_dev->stream.vdev.entity, 0,
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret)
> +		dev_err(cif_dev->dev, "failed to create link");
> +
> +unlock:
> +	mutex_unlock(&cif_dev->media_dev.graph_mutex);
> +	return ret;
> +}
> +
> +static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_subdev *subdev,
> +				 struct v4l2_async_connection *asd)
> +{
> +	struct cif_device *cif_dev =3D container_of(notifier,
> +						  struct cif_device, notifier);
> +	int pad;
> +
> +	cif_dev->remote.sd =3D subdev;
> +	pad =3D media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (pad < 0)
> +		return pad;
> +
> +	cif_dev->remote.pad =3D pad;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_async_notifier_operations subdev_notifier_ops =
=3D {
> +	.bound =3D subdev_notifier_bound,
> +	.complete =3D subdev_notifier_complete,
> +};
> +
> +static int cif_subdev_notifier(struct cif_device *cif_dev)
> +{
> +	struct v4l2_async_notifier *ntf =3D &cif_dev->notifier;
> +	struct device *dev =3D cif_dev->dev;
> +	struct v4l2_async_connection *asd;
> +	struct v4l2_fwnode_endpoint vep =3D {
> +		.bus_type =3D V4L2_MBUS_UNKNOWN,
> +	};
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	v4l2_async_nf_init(ntf, &cif_dev->v4l2_dev);
> +
> +	ep =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +					     FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep)
> +		return -ENODEV;

With this you are only supporting endpoint 0 (aka CVBS over MUX0).
You are also not configuring the YSEL and IFSEL fields for now.

This is fine but you need to at least explain it with a comment here.

> +	ret =3D v4l2_fwnode_endpoint_parse(ep, &vep);
> +	if (ret)
> +		goto complete;
> +
> +	if (vep.bus_type !=3D V4L2_MBUS_BT656 &&
> +	    vep.bus_type !=3D V4L2_MBUS_PARALLEL) {
> +		v4l2_err(&cif_dev->v4l2_dev, "unsupported bus type\n");
> +		goto complete;
> +	}
> +
> +	asd =3D v4l2_async_nf_add_fwnode_remote(ntf, ep,
> +					      struct v4l2_async_connection);
> +	if (IS_ERR(asd)) {
> +		ret =3D PTR_ERR(asd);
> +		goto complete;
> +	}
> +
> +	ntf->ops =3D &subdev_notifier_ops;
> +
> +	ret =3D v4l2_async_nf_register(ntf);
> +	if (ret)
> +		v4l2_async_nf_cleanup(ntf);
> +
> +complete:
> +	fwnode_handle_put(ep);
> +
> +	return ret;
> +}
> +
> +static struct clk_bulk_data px30_cif_clks[] =3D {
> +	{ .id =3D "aclk", },
> +	{ .id =3D "hclk", },
> +	{ .id =3D "pclk", },
> +};
> +
> +static const struct cif_match_data px30_cif_match_data =3D {
> +	.clks =3D px30_cif_clks,
> +	.clks_num =3D ARRAY_SIZE(px30_cif_clks),
> +};
> +
> +static const struct of_device_id cif_plat_of_match[] =3D {
> +	{
> +		.compatible =3D "rockchip,px30-vip",
> +		.data =3D &px30_cif_match_data,
> +	},
> +	{},
> +};
> +
> +static int cif_get_resource(struct platform_device *pdev,
> +			    struct cif_device *cif_dev)

I think you can fold this into probe.

> +{
> +	struct resource *res;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev,
> +			"Unable to allocate resources for device\n");
> +		return -ENODEV;
> +	}
> +
> +	cif_dev->base_addr =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(cif_dev->base_addr))
> +		return PTR_ERR(cif_dev->base_addr);
> +
> +	return 0;
> +}
> +
> +static int cif_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct v4l2_device *v4l2_dev;
> +	struct cif_device *cif_dev;
> +	int ret, irq;
> +
> +	cif_dev =3D devm_kzalloc(dev, sizeof(*cif_dev), GFP_KERNEL);
> +	if (!cif_dev)
> +		return -ENOMEM;
> +
> +	cif_dev->match_data =3D of_device_get_match_data(dev);
> +	if (!cif_dev->match_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, cif_dev);
> +	cif_dev->dev =3D dev;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, cif_irq_pingpong, IRQF_SHARED,
> +			       dev_driver_string(dev), dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request irq failed\n");
> +
> +	cif_dev->irq =3D irq;
> +
> +	ret =3D cif_get_resource(pdev, cif_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_clk_bulk_get(dev, cif_dev->match_data->clks_num,
> +				cif_dev->match_data->clks);
> +	if (ret)
> +		return ret;
> +
> +	cif_dev->cif_rst =3D devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(cif_dev->cif_rst))
> +		return PTR_ERR(cif_dev->cif_rst);

You are no doing anything with the reset array. You should manage it in the
runtime pm functions.

> +
> +	cif_stream_init(cif_dev);
> +	strscpy(cif_dev->media_dev.model, "cif",
> +		sizeof(cif_dev->media_dev.model));
> +	cif_dev->media_dev.dev =3D &pdev->dev;
> +	v4l2_dev =3D &cif_dev->v4l2_dev;
> +	v4l2_dev->mdev =3D &cif_dev->media_dev;
> +	strscpy(v4l2_dev->name, "rockchip-cif", sizeof(v4l2_dev->name));
> +
> +	ret =3D v4l2_device_register(cif_dev->dev, &cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	media_device_init(&cif_dev->media_dev);
> +
> +	ret =3D media_device_register(&cif_dev->media_dev);
> +	if (ret < 0)
> +		goto err_unreg_v4l2_dev;
> +
> +	/* Create & register platform subdev. */
> +	ret =3D cif_register_stream_vdev(cif_dev);
> +	if (ret < 0)
> +		goto err_unreg_media_dev;
> +
> +	ret =3D cif_subdev_notifier(cif_dev);
> +	if (ret < 0) {
> +		v4l2_err(&cif_dev->v4l2_dev,
> +			 "Failed to register subdev notifier(%d)\n", ret);
> +		goto err_unreg_stream_vdev;
> +	}
> +
> +	cif_set_default_format(cif_dev);

You should call pm_runtime_set_suspended here.

> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_stream_vdev:
> +	cif_unregister_stream_vdev(cif_dev);
> +err_unreg_media_dev:
> +	media_device_unregister(&cif_dev->media_dev);
> +err_unreg_v4l2_dev:
> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> +	return ret;
> +}
> +
> +static int cif_plat_remove(struct platform_device *pdev)
> +{
> +	struct cif_device *cif_dev =3D platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);

Do this at the end of the function instead.

> +
> +	media_device_unregister(&cif_dev->media_dev);
> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> +	cif_unregister_stream_vdev(cif_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cif_runtime_suspend(struct device *dev)

Should not be __maybe_unused now that you depend on PM.

> +{
> +	struct cif_device *cif_dev =3D dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(cif_dev->match_data->clks_num,
> +				   cif_dev->match_data->clks);
> +

You need to handle resets too.

> +	return pinctrl_pm_select_sleep_state(dev);

This should not be required at all. I don't see any sleep state pinctrl ent=
ry
defined in the binding (and don't see why we would need one).

> +}
> +
> +static int __maybe_unused cif_runtime_resume(struct device *dev)

Same thing about __maybe_unused.

> +{
> +	struct cif_device *cif_dev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pinctrl_pm_select_default_state(dev);

Same comment as above.

> +	if (ret < 0)
> +		return ret;
> +
> +	return clk_bulk_prepare_enable(cif_dev->match_data->clks_num,
> +				       cif_dev->match_data->clks);
> +}
> +
> +static const struct dev_pm_ops cif_plat_pm_ops =3D {
> +	.runtime_suspend =3D cif_runtime_suspend,
> +	.runtime_resume	 =3D cif_runtime_resume,

Just one space before "=3D", you are not tab-aligning here.

> +};
> +
> +static struct platform_driver cif_plat_drv =3D {
> +	.driver =3D {
> +		   .name =3D CIF_DRIVER_NAME,
> +		   .of_match_table =3D cif_plat_of_match,
> +		   .pm =3D &cif_plat_pm_ops,
> +	},
> +	.probe =3D cif_plat_probe,
> +	.remove =3D cif_plat_remove,
> +};
> +module_platform_driver(cif_plat_drv);
> +
> +MODULE_AUTHOR("Rockchip Camera/ISP team");
> +MODULE_DESCRIPTION("Rockchip CIF platform driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/rockchip/cif/regs.h b/drivers/media/p=
latform/rockchip/cif/regs.h
> new file mode 100644
> index 000000000000..b8500f0a9ac1
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/regs.h
> @@ -0,0 +1,127 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rockchip CIF Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#ifndef _CIF_REGS_H
> +#define _CIF_REGS_H
> +
> +#define CIF_CTRL				0x00
> +#define CIF_INTEN				0x04
> +#define CIF_INTSTAT				0x08
> +#define CIF_FOR					0x0c
> +#define CIF_LINE_NUM_ADDR			0x10
> +#define CIF_FRM0_ADDR_Y				0x14
> +#define CIF_FRM0_ADDR_UV			0x18
> +#define CIF_FRM1_ADDR_Y				0x1c
> +#define CIF_FRM1_ADDR_UV			0x20
> +#define CIF_VIR_LINE_WIDTH			0x24
> +#define CIF_SET_SIZE				0x28
> +#define CIF_SCM_ADDR_Y				0x2c
> +#define CIF_SCM_ADDR_U				0x30
> +#define CIF_SCM_ADDR_V				0x34
> +#define CIF_WB_UP_FILTER			0x38
> +#define CIF_WB_LOW_FILTER			0x3c
> +#define CIF_WBC_CNT				0x40
> +#define CIF_CROP				0x44
> +#define CIF_SCL_CTRL				0x48
> +#define CIF_SCL_DST				0x4c
> +#define CIF_SCL_FCT				0x50
> +#define CIF_SCL_VALID_NUM			0x54
> +#define CIF_LINE_LOOP_CTR			0x58
> +#define CIF_FRAME_STATUS			0x60
> +#define CIF_CUR_DST				0x64
> +#define CIF_LAST_LINE				0x68
> +#define CIF_LAST_PIX				0x6c
> +#define CIF_FETCH_Y_LAST_LINE(VAL)		((VAL) & 0x1fff)
> +
> +#define CIF_CTRL_ENABLE_CAPTURE			BIT(0)
> +#define CIF_CTRL_MODE_PINGPONG			BIT(1)
> +#define CIF_CTRL_MODE_LINELOOP			BIT(2)
> +#define CIF_CTRL_AXI_BURST_16			(0xf << 12)
> +
> +#define CIF_INTEN_FRAME_END_EN			BIT(0)
> +#define CIF_INTEN_LINE_ERR_EN			BIT(2)
> +#define CIF_INTEN_BUS_ERR_EN			BIT(6)
> +#define CIF_INTEN_SCL_ERR_EN			BIT(7)
> +#define CIF_INTEN_PST_INF_FRAME_END_EN		BIT(9)
> +
> +#define CIF_INTSTAT_CLS				0x3ff
> +#define CIF_INTSTAT_FRAME_END			BIT(0)
> +#define CIF_INTSTAT_LINE_END			BIT(1)
> +#define CIF_INTSTAT_LINE_ERR			BIT(2)
> +#define CIF_INTSTAT_PIX_ERR			BIT(3)
> +#define CIF_INTSTAT_DFIFO_OF			BIT(5)
> +#define CIF_INTSTAT_BUS_ERR			BIT(6)
> +#define CIF_INTSTAT_PRE_INF_FRAME_END		BIT(8)
> +#define CIF_INTSTAT_PST_INF_FRAME_END		BIT(9)
> +#define CIF_INTSTAT_FRAME_END_CLR		BIT(0)
> +#define CIF_INTSTAT_LINE_END_CLR		BIT(1)
> +#define CIF_INTSTAT_LINE_ERR_CLR		BIT(2)
> +#define CIF_INTSTAT_PST_INF_FRAME_END_CLR	BIT(9)
> +#define CIF_INTSTAT_ERR				0xfc
> +
> +#define CIF_FRAME_STAT_CLS			0x00
> +#define CIF_FRAME_FRM0_STAT_CLS			0x20
> +
> +#define CIF_FORMAT_VSY_HIGH_ACTIVE		BIT(0)
> +#define CIF_FORMAT_HSY_LOW_ACTIVE		BIT(1)
> +
> +#define CIF_FORMAT_INPUT_MODE_YUV		(0x00 << 2)
> +#define CIF_FORMAT_INPUT_MODE_PAL		(0x02 << 2)
> +#define CIF_FORMAT_INPUT_MODE_NTSC		(0x03 << 2)
> +#define CIF_FORMAT_INPUT_MODE_BT1120		(0x07 << 2)
> +#define CIF_FORMAT_INPUT_MODE_RAW		(0x04 << 2)
> +#define CIF_FORMAT_INPUT_MODE_JPEG		(0x05 << 2)
> +#define CIF_FORMAT_INPUT_MODE_MIPI		(0x06 << 2)
> +
> +#define CIF_FORMAT_YUV_INPUT_ORDER_UYVY		(0x00 << 5)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_YVYU		BIT(5)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_VYUY		BIT(6)
> +#define CIF_FORMAT_YUV_INPUT_ORDER_YUYV		(0x03 << 5)
> +#define CIF_FORMAT_YUV_INPUT_422		(0x00 << 7)
> +#define CIF_FORMAT_YUV_INPUT_420		BIT(7)
> +
> +#define CIF_FORMAT_INPUT_420_ORDER_ODD		BIT(8)
> +
> +#define CIF_FORMAT_CCIR_INPUT_ORDER_EVEN	BIT(9)
> +
> +#define CIF_FORMAT_RAW_DATA_WIDTH_8		(0x00 << 11)
> +#define CIF_FORMAT_RAW_DATA_WIDTH_10		BIT(11)
> +#define CIF_FORMAT_RAW_DATA_WIDTH_12		(0x02 << 11)
> +
> +#define CIF_FORMAT_YUV_OUTPUT_422		(0x00 << 16)
> +#define CIF_FORMAT_YUV_OUTPUT_420		BIT(16)
> +
> +#define CIF_FORMAT_OUTPUT_420_ORDER_EVEN	(0x00 << 17)
> +#define CIF_FORMAT_OUTPUT_420_ORDER_ODD		BIT(17)
> +
> +#define CIF_FORMAT_RAWD_DATA_LITTLE_ENDIAN	(0x00 << 18)
> +#define CIF_FORMAT_RAWD_DATA_BIG_ENDIAN		BIT(18)
> +
> +#define CIF_FORMAT_UV_STORAGE_ORDER_UVUV	(0x00 << 19)
> +#define CIF_FORMAT_UV_STORAGE_ORDER_VUVU	BIT(19)
> +
> +#define CIF_FORMAT_BT1120_CLOCK_SINGLE_EDGES	(0x00 << 24)
> +#define CIF_FORMAT_BT1120_CLOCK_DOUBLE_EDGES	BIT(24)
> +#define CIF_FORMAT_BT1120_TRANSMIT_INTERFACE	(0x00 << 25)
> +#define CIF_FORMAT_BT1120_TRANSMIT_PROGRESS	BIT(25)
> +#define CIF_FORMAT_BT1120_YC_SWAP		BIT(26)
> +
> +#define CIF_SCL_CTRL_ENABLE_SCL_DOWN		BIT(0)
> +#define CIF_SCL_CTRL_ENABLE_SCL_UP		BIT(1)
> +#define CIF_SCL_CTRL_ENABLE_YUV_16BIT_BYPASS	BIT(4)
> +#define CIF_SCL_CTRL_ENABLE_RAW_16BIT_BYPASS	BIT(5)
> +#define CIF_SCL_CTRL_ENABLE_32BIT_BYPASS	BIT(6)
> +#define CIF_SCL_CTRL_DISABLE_32BIT_BYPASS	(0x00 << 6)
> +
> +#define CIF_INTSTAT_F0_READY			BIT(0)
> +#define CIF_INTSTAT_F1_READY			BIT(1)
> +
> +#define CIF_CROP_Y_SHIFT			16
> +#define CIF_CROP_X_SHIFT			0
> +
> +#endif
> --=20
> 2.41.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--JWXUfGgiE2/LRajP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVnWegACgkQ3cLmz3+f
v9F7cQf/e8cAj32L0Tr2LhjeTkrozIHGBB76jNu6da00p4THEevM7FR4ZNfLUv5b
NyOJUokSoN/aFHen2I2VxyYFOMZTWHRVnUNESS5vk6NEKCqiyYGkEBq6J6f5pJIO
DK8A3ptKznBo4+/8TfinX6wKCRfZkr6/ZyE7Y35DE7P3jUh3Jeyy2jSy9CDx7oCm
vhUUtOWav9wdYCJDwPBSdiQmnJRZ4yCe4sz+GJCCr9CdDDi6B1fxUP6VdrBaA4Am
y1912PhMALO7kiHmh1U2TA/pjgrzOfo/UbkqliFVj74w/MnN2zuFS87Qx4z6skc6
QcFdrvgNldq6tJxpB4WDCG/GNCAYcw==
=DGiH
-----END PGP SIGNATURE-----

--JWXUfGgiE2/LRajP--
