Return-Path: <linux-kernel+bounces-7310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6581A577
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0534E1F226B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527E4645E;
	Wed, 20 Dec 2023 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZFV2KjDm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AE41C60;
	Wed, 20 Dec 2023 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703090460;
	bh=St3He25wYG5nEOKuPy5JeP7ZSWucXh42wO1IKMUaZSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZFV2KjDmXqnvNr1jlLtnFykcEUuqiFyrF7FTmw4FNQ1lpLDTwDMRURPhVBSv+9MHQ
	 dQYqxXI9ZDqLDBZvcBoYjaJWajbpXx2DQ9RG0CDgDGWglCmtVKMTWCZl07062tnWGZ
	 bnnJnduFyhiJWmfDNg7SO7BOo5CGVfk4V2t7v4syvcSesYj0Uh2cUin9A2HZZLKji1
	 Sd17XTk7jsMEOWF9BPQmTeH401l/bpUmZX17/tL46e1+hbW2HtHqPVjGAyi7xcFkvz
	 vhtZXyANIckxViqLZ3xlYNpSfKy+oaB0FFyVzqGoZtffWYaObyWtnhUGtAPM2y4Ssf
	 YfgxNF2pcmoOg==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC0FA37814A9;
	Wed, 20 Dec 2023 16:40:56 +0000 (UTC)
Message-ID: <8c13951d539ea94f20a96b70ff8287419b597d74.camel@collabora.com>
Subject: Re: [PATCH v4 2/5] media: hantro: add support for STM32MP25 VDEC
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hugues Fruchet <hugues.fruchet@foss.st.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Benjamin Mugnier
 <benjamin.mugnier@foss.st.com>,  Heiko Stuebner <heiko@sntech.de>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
Cc: Marco Felsch <m.felsch@pengutronix.de>, Adam Ford <aford173@gmail.com>
Date: Wed, 20 Dec 2023 11:40:53 -0500
In-Reply-To: <20231220152732.2138260-3-hugues.fruchet@foss.st.com>
References: <20231220152732.2138260-1-hugues.fruchet@foss.st.com>
	 <20231220152732.2138260-3-hugues.fruchet@foss.st.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 20 d=C3=A9cembre 2023 =C3=A0 16:27 +0100, Hugues Fruchet a =C3=
=A9crit=C2=A0:
> Add support for STM32MP25 VDEC video hardware decoder.
> Support of H264/VP8 decoding.
> No post-processor support.
> VDEC has its own reset/clock/irq.

I'd suggest adding:

  The resolution is currently limited to full HD as per test results.
  Higher resolutions results in visual distortion.

With similar minor addition (please suggest something you are confortable w=
ith):

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  drivers/media/platform/verisilicon/Kconfig    | 14 ++-
>  drivers/media/platform/verisilicon/Makefile   |  3 +
>  .../media/platform/verisilicon/hantro_drv.c   |  3 +
>  .../media/platform/verisilicon/hantro_hw.h    |  1 +
>  .../platform/verisilicon/stm32mp25_vdec_hw.c  | 92 +++++++++++++++++++
>  5 files changed, 110 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.=
c
>=20
> diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/p=
latform/verisilicon/Kconfig
> index e65b836b9d78..7642ff9cf96c 100644
> --- a/drivers/media/platform/verisilicon/Kconfig
> +++ b/drivers/media/platform/verisilicon/Kconfig
> @@ -4,7 +4,7 @@ comment "Verisilicon media platform drivers"
> =20
>  config VIDEO_HANTRO
>  	tristate "Hantro VPU driver"
> -	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMP=
ILE_TEST
> +	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || ARCH=
_STM32 || COMPILE_TEST
>  	depends on V4L_MEM2MEM_DRIVERS
>  	depends on VIDEO_DEV
>  	select MEDIA_CONTROLLER
> @@ -16,8 +16,8 @@ config VIDEO_HANTRO
>  	select V4L2_VP9
>  	help
>  	  Support for the Hantro IP based Video Processing Units present on
> -	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
> -	  encoding and decoding.
> +	  Rockchip, NXP i.MX8M and STM32MP25 SoCs, which accelerate video
> +	  and image encoding and decoding.
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hantro-vpu.
> =20
> @@ -52,3 +52,11 @@ config VIDEO_HANTRO_SUNXI
>  	default y
>  	help
>  	  Enable support for H6 SoC.
> +
> +config VIDEO_HANTRO_STM32MP25
> +	bool "Hantro STM32MP25 support"
> +	depends on VIDEO_HANTRO
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	default y
> +	help
> +	  Enable support for STM32MP25 SoCs.
> diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/=
platform/verisilicon/Makefile
> index 6ad2ef885920..5854e0f0dd32 100644
> --- a/drivers/media/platform/verisilicon/Makefile
> +++ b/drivers/media/platform/verisilicon/Makefile
> @@ -39,3 +39,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) +=3D \
> =20
>  hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) +=3D \
>  		sunxi_vpu_hw.o
> +
> +hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) +=3D \
> +		stm32mp25_vdec_hw.o
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index a9fa05ac56a9..2db27c333924 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -733,6 +733,9 @@ static const struct of_device_id of_hantro_match[] =
=3D {
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SUNXI
>  	{ .compatible =3D "allwinner,sun50i-h6-vpu-g2", .data =3D &sunxi_vpu_va=
riant, },
> +#endif
> +#ifdef CONFIG_VIDEO_HANTRO_STM32MP25
> +	{ .compatible =3D "st,stm32mp25-vdec", .data =3D &stm32mp25_vdec_varian=
t, },
>  #endif
>  	{ /* sentinel */ }
>  };
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/med=
ia/platform/verisilicon/hantro_hw.h
> index 7f33f7b07ce4..b7eccc1a96fc 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -406,6 +406,7 @@ extern const struct hantro_variant rk3568_vpu_variant=
;
>  extern const struct hantro_variant rk3588_vpu981_variant;
>  extern const struct hantro_variant sama5d4_vdec_variant;
>  extern const struct hantro_variant sunxi_vpu_variant;
> +extern const struct hantro_variant stm32mp25_vdec_variant;
> =20
>  extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>  extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
> diff --git a/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c b/dri=
vers/media/platform/verisilicon/stm32mp25_vdec_hw.c
> new file mode 100644
> index 000000000000..aa8b0f751390
> --- /dev/null
> +++ b/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * STM32MP25 VDEC video decoder driver
> + *
> + * Copyright (C) STMicroelectronics SA 2022
> + * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
> + *          for STMicroelectronics.
> + *
> + */
> +
> +#include "hantro.h"
> +
> +/*
> + * Supported formats.
> + */
> +
> +static const struct hantro_fmt stm32mp25_vdec_fmts[] =3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.frmsize =3D {
> +			.min_width =3D FMT_MIN_WIDTH,
> +			.max_width =3D FMT_FHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D FMT_MIN_HEIGHT,
> +			.max_height =3D FMT_FHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_VP8_FRAME,
> +		.codec_mode =3D HANTRO_MODE_VP8_DEC,
> +		.max_depth =3D 2,
> +		.frmsize =3D {
> +			.min_width =3D FMT_MIN_WIDTH,
> +			.max_width =3D FMT_FHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D FMT_MIN_HEIGHT,
> +			.max_height =3D FMT_FHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> +		.codec_mode =3D HANTRO_MODE_H264_DEC,
> +		.max_depth =3D 2,
> +		.frmsize =3D {
> +			.min_width =3D FMT_MIN_WIDTH,
> +			.max_width =3D FMT_FHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D FMT_MIN_HEIGHT,
> +			.max_height =3D FMT_FHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +};
> +
> +/*
> + * Supported codec ops.
> + */
> +
> +static const struct hantro_codec_ops stm32mp25_vdec_codec_ops[] =3D {
> +	[HANTRO_MODE_VP8_DEC] =3D {
> +		.run =3D hantro_g1_vp8_dec_run,
> +		.reset =3D hantro_g1_reset,
> +		.init =3D hantro_vp8_dec_init,
> +		.exit =3D hantro_vp8_dec_exit,
> +	},
> +	[HANTRO_MODE_H264_DEC] =3D {
> +		.run =3D hantro_g1_h264_dec_run,
> +		.reset =3D hantro_g1_reset,
> +		.init =3D hantro_h264_dec_init,
> +		.exit =3D hantro_h264_dec_exit,
> +	},
> +};
> +
> +static const struct hantro_irq stm32mp25_irqs[] =3D {
> +	{ "vdec", hantro_g1_irq },
> +};
> +
> +static const char * const stm32mp25_clk_names[] =3D { "vdec-clk" };
> +
> +const struct hantro_variant stm32mp25_vdec_variant =3D {
> +	.dec_fmts =3D stm32mp25_vdec_fmts,
> +	.num_dec_fmts =3D ARRAY_SIZE(stm32mp25_vdec_fmts),
> +	.codec =3D HANTRO_VP8_DECODER | HANTRO_H264_DECODER,
> +	.codec_ops =3D stm32mp25_vdec_codec_ops,
> +	.irqs =3D stm32mp25_irqs,
> +	.num_irqs =3D ARRAY_SIZE(stm32mp25_irqs),
> +	.clk_names =3D stm32mp25_clk_names,
> +	.num_clocks =3D ARRAY_SIZE(stm32mp25_clk_names),
> +};


