Return-Path: <linux-kernel+bounces-23557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F882AE68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF67B232F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859216438;
	Thu, 11 Jan 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NyI1GNWq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2615AC0;
	Thu, 11 Jan 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704974685;
	bh=6Se+i6JaCfLDPNQmElK0ogd1t9T/zCqDXJC20IqqHn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NyI1GNWqPOw4C2Guhqlf4nXNLrfyju4D+pqBfmSepqRXS774+bQqbtUA5AIVU+zW/
	 fCzmxwmzs45JYoQLlH1DzXmExlSMjyQARdGA+NyCU7gemTt84di2MMIsZ2D76oR4Qa
	 fEkgrOCT7ndPb7DmDgacFfzwzMna9ggCaLM0bsvOCHnzSLuoqelRYi396QQK89dEtD
	 8WIWoT4wzzAacLxyejHgdy3vnvuRkaZugzjsUQzv7+XfJtyTBSBurHogUVJs2YYz3K
	 LWb7Jd6yFtWNEHfQpmYx2zz6vZV0YO3ZoXRG43j3vEEO51ZUw3GMDCuDknBB70qVif
	 IyUuQV+qj6Edg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6BD33781182;
	Thu, 11 Jan 2024 12:04:43 +0000 (UTC)
Message-ID: <3c2bee40-3792-409c-b42f-f8b013ff641c@collabora.com>
Date: Thu, 11 Jan 2024 13:04:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Content-Language: en-US
To: Julien Stephan <jstephan@baylibre.com>
Cc: Louis Kuo <louis.kuo@mediatek.com>, Phi-bang Nguyen
 <pnguyen@baylibre.com>, Florian Sylvestre <fsylvestre@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Andy Hsieh <andy.hsieh@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Paul Elder <paul.elder@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-4-jstephan@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240110141443.364655-4-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/01/24 15:14, Julien Stephan ha scritto:
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This will add the mediatek ISP3.0 seninf (sensor interface) driver found
> on several Mediatek SoCs such as the mt8365.
> 
> Then seninf module has 4 physical CSI-2 inputs. Depending on the soc they
> may not be all connected.
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS                                   |    1 +
>   drivers/media/platform/mediatek/Kconfig       |    1 +
>   drivers/media/platform/mediatek/Makefile      |    1 +
>   drivers/media/platform/mediatek/isp/Kconfig   |    2 +
>   drivers/media/platform/mediatek/isp/Makefile  |    3 +
>   .../platform/mediatek/isp/isp_30/Kconfig      |   16 +
>   .../platform/mediatek/isp/isp_30/Makefile     |    3 +
>   .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
>   .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1488 +++++++++++++++++
>   .../isp/isp_30/seninf/mtk_seninf_reg.h        |  112 ++
>   10 files changed, 1632 insertions(+)
>   create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
>   create mode 100644 drivers/media/platform/mediatek/isp/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
>   create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ea2158864e1..52d200d5e36c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13618,6 +13618,7 @@ M:	Andy Hsieh <andy.hsieh@mediatek.com>
>   S:	Supported
>   F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
>   F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> +F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
>   
>   MEDIATEK SMI DRIVER
>   M:	Yong Wu <yong.wu@mediatek.com>
> diff --git a/drivers/media/platform/mediatek/Kconfig b/drivers/media/platform/mediatek/Kconfig
> index 84104e2cd024..4e0a5a43f35e 100644
> --- a/drivers/media/platform/mediatek/Kconfig
> +++ b/drivers/media/platform/mediatek/Kconfig
> @@ -7,3 +7,4 @@ source "drivers/media/platform/mediatek/mdp/Kconfig"
>   source "drivers/media/platform/mediatek/vcodec/Kconfig"
>   source "drivers/media/platform/mediatek/vpu/Kconfig"
>   source "drivers/media/platform/mediatek/mdp3/Kconfig"
> +source "drivers/media/platform/mediatek/isp/Kconfig"
> diff --git a/drivers/media/platform/mediatek/Makefile b/drivers/media/platform/mediatek/Makefile
> index 38e6ba917fe5..695f05f525a6 100644
> --- a/drivers/media/platform/mediatek/Makefile
> +++ b/drivers/media/platform/mediatek/Makefile
> @@ -4,3 +4,4 @@ obj-y += mdp/
>   obj-y += vcodec/
>   obj-y += vpu/
>   obj-y += mdp3/
> +obj-y += isp/
> diff --git a/drivers/media/platform/mediatek/isp/Kconfig b/drivers/media/platform/mediatek/isp/Kconfig
> new file mode 100644
> index 000000000000..708b9a6660d2
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/Kconfig
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +source "drivers/media/platform/mediatek/isp/isp_30/Kconfig"
> diff --git a/drivers/media/platform/mediatek/isp/Makefile b/drivers/media/platform/mediatek/isp/Makefile
> new file mode 100644
> index 000000000000..a81ab33d0dd3
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += isp_30/
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/Kconfig b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> new file mode 100644
> index 000000000000..9791312589fb
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MTK_SENINF30
> +	tristate "MediaTek ISP3.0 SENINF driver"
> +	depends on VIDEO_V4L2_SUBDEV_API
> +	depends on MEDIA_CAMERA_SUPPORT
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	select V4L2_FWNODE
> +	default n
> +	help
> +	  This driver provides a MIPI CSI-2 receiver interface to connect
> +	  an external camera module with MediaTek ISP3.0. It is able to handle
> +	  multiple cameras at the same time.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mtk-seninf.
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/Makefile b/drivers/media/platform/mediatek/isp/isp_30/Makefile
> new file mode 100644
> index 000000000000..ac3142de4739
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_MTK_SENINF30) += seninf/
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile b/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
> new file mode 100644
> index 000000000000..f28480d6d6c3
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +mtk-seninf-objs += mtk_seninf.o
> +
> +obj-$(CONFIG_MTK_SENINF30) += mtk-seninf.o
> diff --git a/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
> new file mode 100644
> index 000000000000..67b2c697d9ca
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
> @@ -0,0 +1,1488 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/videodev2.h>
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
> +
> +#include "mtk_seninf_reg.h"
> +
> +#define SENINF_TIMESTAMP_STEP		0x67
> +#define SENINF_SETTLE_DELAY		0x15
> +#define SENINF_HS_TRAIL_PARAMETER	0x8
> +
> +#define SENINF_MAX_NUM_INPUTS		4
> +#define SENINF_MAX_NUM_OUTPUTS		6
> +#define SENINF_MAX_NUM_MUXES		6
> +#define SENINF_MAX_NUM_PADS		(SENINF_MAX_NUM_INPUTS + \
> +					 SENINF_MAX_NUM_OUTPUTS)
> +
> +#define SENINF_DEFAULT_BUS_FMT		MEDIA_BUS_FMT_SGRBG10_1X10
> +#define SENINF_DEFAULT_WIDTH		1920
> +#define SENINF_DEFAULT_HEIGHT		1080
> +
> +#define SENINF_PAD_10BIT		0
> +
> +#define SENINF_TEST_MODEL		0
> +#define SENINF_NORMAL_MODEL		1
> +#define SENINF_ALL_ERR_IRQ_EN		0x7f
> +#define SENINF_IRQ_CLR_SEL		0x80000000
> +
> +#define SENINF_MIPI_SENSOR		0x8
> +
> +#define MTK_CSI_MAX_LANES 4
> +
> +/* Port number in the device tree. */
> +enum mtk_seninf_port {
> +	CSI_PORT_0 = 0,	/* 4D1C or 2D1C */
> +	CSI_PORT_1,	/* 4D1C */
> +	CSI_PORT_2,	/* 4D1C */
> +	CSI_PORT_0B,	/* 2D1C */
> +};
> +
> +enum mtk_seninf_id {
> +	SENINF_1 = 0,
> +	SENINF_2 = 1,
> +	SENINF_3 = 2,
> +	SENINF_5 = 4,
> +};
> +
> +static const u32 port_to_seninf_id[] = {
> +	[CSI_PORT_0] = SENINF_1,
> +	[CSI_PORT_1] = SENINF_3,
> +	[CSI_PORT_2] = SENINF_5,
> +	[CSI_PORT_0B] = SENINF_2,
> +};
> +
> +enum mtk_seninf_phy_mode {
> +	SENINF_PHY_MODE_NONE,
> +	SENINF_PHY_MODE_4D1C,
> +	SENINF_PHY_MODE_2D1C,
> +};
> +
> +enum mtk_seninf_format_flag {
> +	MTK_SENINF_FORMAT_BAYER = BIT(0),
> +	MTK_SENINF_FORMAT_DPCM = BIT(1),
> +	MTK_SENINF_FORMAT_JPEG = BIT(2),
> +	MTK_SENINF_FORMAT_INPUT_ONLY = BIT(3),
> +};
> +
> +/**
> + * struct mtk_seninf_conf - Model-specific SENINF parameters
> + * @model: Model description
> + * @nb_inputs: Number of SENINF inputs
> + * @nb_muxes: Number of SENINF MUX (FIFO) instances
> + * @nb_outputs: Number of outputs (to CAM and CAMSV instances)
> + */
> +struct mtk_seninf_conf {
> +	const char *model;
> +	u8 nb_inputs;
> +	u8 nb_muxes;
> +	u8 nb_outputs;
> +};
> +
> +/**
> + * struct mtk_seninf_format_info - Information about media bus formats
> + * @code: V4L2 media bus code
> + * @flags: Flags describing the format, as a combination of MTK_SENINF_FORMAT_*
> + */
> +struct mtk_seninf_format_info {
> +	u32 code;
> +	u32 flags;
> +};
> +
> +/**
> + * struct mtk_seninf_input - SENINF input block
> + * @pad: DT port and media entity pad number
> + * @seninf_id: SENINF hardware instance ID
> + * @base: Memory mapped I/O based address
> + * @seninf: Back pointer to the mtk_seninf
> + * @phy: PHY connected to the input
> + * @phy_mode: PHY operation mode (NONE when the input is not connected)
> + * @bus: CSI-2 bus configuration from DT
> + * @source_sd: Source subdev connected to the input
> + */
> +struct mtk_seninf_input {
> +	enum mtk_seninf_port pad;
> +	enum mtk_seninf_id seninf_id;
> +	void __iomem *base;
> +	struct mtk_seninf *seninf;
> +
> +	struct phy *phy;
> +	enum mtk_seninf_phy_mode phy_mode;
> +
> +	struct v4l2_mbus_config_mipi_csi2 bus;
> +
> +	struct v4l2_subdev *source_sd;
> +};
> +
> +/**
> + * struct mtk_seninf_mux - SENINF MUX channel
> + * @pad: DT port and media entity pad number
> + * @mux_id: MUX hardware instance ID
> + * @base: Memory mapped I/O based address
> + * @seninf: Back pointer to the mtk_seninf
> + */
> +struct mtk_seninf_mux {
> +	unsigned int pad;
> +	unsigned int mux_id;
> +	void __iomem *base;
> +	struct mtk_seninf *seninf;
> +};
> +
> +/**
> + * struct mtk_seninf - Top-level SENINF device
> + * @dev: The (platform) device
> + * @phy: PHYs at the SENINF inputs
> + * @num_clks: Number of clocks in the clks array
> + * @clks: Clocks
> + * @base: Memory mapped I/O base address
> + * @media_dev: Media controller device
> + * @v4l2_dev: V4L2 device
> + * @subdev: V4L2 subdevice
> + * @pads: Media entity pads
> + * @notifier: V4L2 async notifier for source subdevs
> + * @ctrl_handler: V4L2 controls handler
> + * @source_format: Active format on the source pad
> + * @inputs: Array of SENINF inputs
> + * @muxes: Array of MUXes
> + * @conf: Model-specific SENINF parameters
> + * @is_testmode: Whether or not the test pattern generator is enabled
> + */
> +struct mtk_seninf {
> +	struct device *dev;
> +	struct phy *phy[5];
> +	unsigned int num_clks;
> +	struct clk_bulk_data *clks;
> +	void __iomem *base;
> +
> +	struct media_device media_dev;
> +	struct v4l2_device v4l2_dev;
> +	struct v4l2_subdev subdev;
> +	struct media_pad pads[SENINF_MAX_NUM_PADS];
> +	struct v4l2_async_notifier notifier;
> +	struct v4l2_ctrl_handler ctrl_handler;
> +
> +	struct mtk_seninf_input inputs[SENINF_MAX_NUM_INPUTS];
> +	struct mtk_seninf_mux muxes[SENINF_MAX_NUM_MUXES];
> +
> +	const struct mtk_seninf_conf *conf;
> +
> +	bool is_testmode;
> +};
> +
> +inline struct mtk_seninf *sd_to_mtk_seninf(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct mtk_seninf, subdev);
> +}
> +
> +static inline bool mtk_seninf_pad_is_sink(struct mtk_seninf *priv,
> +					  unsigned int pad)
> +{
> +	return pad < priv->conf->nb_inputs;
> +}
> +
> +static inline bool mtk_seninf_pad_is_source(struct mtk_seninf *priv,
> +					    unsigned int pad)
> +{
> +	return !mtk_seninf_pad_is_sink(priv, pad);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Formats
> + */
> +
> +static const struct mtk_seninf_format_info mtk_seninf_formats[] = {
> +	{
> +		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SBGGR14_1X14,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG14_1X14,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGRBG14_1X14,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SBGGR16_1X16,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG16_1X16,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGRBG16_1X16,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB16_1X16,
> +		.flags = MTK_SENINF_FORMAT_BAYER,
> +	}, {
> +		.code = MEDIA_BUS_FMT_UYVY8_1X16,
> +	}, {
> +		.code = MEDIA_BUS_FMT_VYUY8_1X16,
> +	}, {
> +		.code = MEDIA_BUS_FMT_YUYV8_1X16,
> +	}, {
> +		.code = MEDIA_BUS_FMT_YVYU8_1X16,
> +	}, {
> +		.code = MEDIA_BUS_FMT_JPEG_1X8,
> +		.flags = MTK_SENINF_FORMAT_JPEG,
> +	}, {
> +		.code = MEDIA_BUS_FMT_S5C_UYVY_JPEG_1X8,
> +		.flags = MTK_SENINF_FORMAT_JPEG,
> +	},
> +	/* Keep the input-only formats last. */

Your comment doesn't make me understand why input-only formats shall be
placed last - and makes me think that having two arrays (one for both
and one for input only) would be easier and less error prone, other than
making you able to drop the MTK_SENINF_FORMAT_INPUT_ONLY flag entirely.

> +	{
> +		.code = MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8,
> +		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SRGGB10_DPCM8_1X8,
> +		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SBGGR10_DPCM8_1X8,
> +		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
> +	}, {
> +		.code = MEDIA_BUS_FMT_SGBRG10_DPCM8_1X8,
> +		.flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY,
> +	}
> +};
> +
> +static const struct mtk_seninf_format_info *mtk_seninf_format_info(u32 code)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mtk_seninf_formats); ++i) {
> +		if (mtk_seninf_formats[i].code == code)
> +			return &mtk_seninf_formats[i];
> +	}
> +
> +	return NULL;
> +}
> +

.snip..

> +
> +static void mtk_seninf_input_setup_csi2(struct mtk_seninf_input *input,
> +					struct v4l2_subdev_state *state)
> +{
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int num_data_lanes = input->bus.num_data_lanes;
> +	unsigned int val = 0;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	/* Configure timestamp */
> +	writel(SENINF_TIMESTAMP_STEP, input->base + SENINF_TG1_TM_STP);
> +
> +	/* HQ */
> +	writel(0x0, input->base + SENINF_TG1_PH_CNT);

Zero means:
  - Sensor master clock: ISP_CLK
  - Sensor clock polarity: Rising edge
  - Sensor reset deasserted
  - Sensor powered up
  - Pixel clock inversion disabled
  - Sensor master clock polarity disabled
  - Phase counter disabled

> +	writel(0x10001, input->base + SENINF_TG1_SEN_CK);

Unroll this one... this is the TG1 sensor clock divider.

CLKFL GENMASK(5, 0)
CLKRS GENMASK(13, 8)
CLKCNT GENMASK(21,16)

Like this, I don't get what you're trying to set, because you're using a fixed
sensor clock rate, meaning that only a handful of camera sensors will be usable.

Is this 8Mhz? 16? 24? what? :-)

Two hints:
  - sensor_clk = clk_get_rate(isp_clk) / (tg1_sen_ck_clkcnt + 1);
  - int mtk_seninf_set_sensor_clk(u8 rate_mhz);

Please :-)

> +
> +	/* First Enable Sensor interface and select pad (0x1a04_0200) */
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, PAD2CAM_DATA_SEL, SENINF_PAD_10BIT);
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 0);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_CSI2_IP_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT, SENINF_NCSI2_IP_EN, 0);
> +
> +	/* DPCM Enable */
> +	if (fmtinfo->flags & MTK_SENINF_FORMAT_DPCM)
> +		val = SENINF_CSI2_DPCM_DI_2A_DPCM_EN;
> +	else
> +		val = SENINF_CSI2_DPCM_DI_30_DPCM_EN;
> +	writel(val, input->base + SENINF_CSI2_DPCM);
> +
> +	/* Settle delay */
> +	mtk_seninf_input_update(input, SENINF_CSI2_LNRD_TIMING,
> +				DATA_SETTLE_PARAMETER, SENINF_SETTLE_DELAY);
> +
> +	/* HQ */
> +	writel(0x10, input->base + SENINF_CSI2_LNRC_FSM);

As far as I know, SENINF_CSI2_LNRC_FSM is a read-only register: this write will do
exactly nothing...

> +
> +	/* CSI2 control */
> +	val = readl(input->base + SENINF_CSI2_CTL)
> +	    | (FIELD_PREP(SENINF_CSI2_CTL_ED_SEL, DATA_HEADER_ORDER_DI_WCL_WCH)
> +	    | SENINF_CSI2_CTL_CLOCK_LANE_EN | (BIT(num_data_lanes) - 1));
> +	writel(val, input->base + SENINF_CSI2_CTL);
> +
> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> +				BYPASS_LANE_RESYNC, 0);

93 columns: fits in one line (not only this one!).

> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL, CDPHY_SEL, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_RESYNC_MERGE_CTL,
> +				CPHY_LANE_RESYNC_CNT, 3);
> +	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_MODE, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_MODE, CSR_CSI2_HEADER_LEN, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_MASK_0, 0xff00);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DPHY_SYNC, SYNC_SEQ_PAT_0, 0x001d);
> +
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, CLOCK_HS_OPTION, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HSRX_DET_EN, 0);
> +	mtk_seninf_input_update(input, SENINF_CSI2_CTL, HS_TRAIL_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CSI2_HS_TRAIL, HS_TRAIL_PARAMETER,
> +				SENINF_HS_TRAIL_PARAMETER);
> +
> +	/* Set debug port to output packet number */
> +	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CSI2_DGB_SEL, DEBUG_SEL, 0x1a);
> +
> +	/* HQ */
> +	writel(0xfffffffe, input->base + SENINF_CSI2_SPARE0);

I have no idea what this SPARE0 does, but I think that this is something that you
want to get from platform_data, as I guess this would be different on various SoCs?

> +
> +	/* Enable CSI2 IRQ mask */
> +	/* Turn on all interrupt */
> +	writel(0xffffffff, input->base + SENINF_CSI2_INT_EN);
> +	/* Write clear CSI2 IRQ */
> +	writel(0xffffffff, input->base + SENINF_CSI2_INT_STATUS);
> +	/* Enable CSI2 Extend IRQ mask */

You missed:
	writel(0xffffffff, input->base + SENINF_CSI2_INT_EN_EXT);

P.S.: #define SENINF_CSI2_INT_EN_EXT 0x0b10


> +	/* Turn on all interrupt */

/* Reset the CSI2 to commit changes */ <-- makes more sense, doesn't it?

> +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 1);
> +	udelay(1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);
> +}
> +
> +static void mtk_seninf_mux_setup(struct mtk_seninf_mux *mux,
> +				 struct mtk_seninf_input *input,
> +				 struct v4l2_subdev_state *state)
> +{
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int pix_sel_ext;
> +	unsigned int pix_sel;
> +	unsigned int hs_pol = 0;
> +	unsigned int vs_pol = 0;
> +	unsigned int val;
> +	u32 rst_mask;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, input->pad, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	/* Enable mux */
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, SENINF_MIPI_SENSOR);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT, SENINF_SRC_SEL_EXT, SENINF_NORMAL_MODEL);
> +
> +	pix_sel_ext = 0;
> +	pix_sel = 1;


	pixels_per_cycle = 1;
	bus_width = pixels_per_cycle >> 1;

because:  0 == 1pix/cyc, 1 == 2pix/cyc, 2 == 4pix/cyc, 3 == 8pix... etc
..but the width of this register depends on the SoC, so you also want to set
constraints to the bus width on a per-soc basis (platform data again, or at
least leave a comment here).

	mtk_seninf_mux_update(....  PIX_SEL_EXT, bus_width);
	mtk_seninf_mux_update(....  PIX_SEL, bus_width);

> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT, SENINF_PIX_SEL_EXT, pix_sel_ext);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
> +
> +	if (fmtinfo->flags & MTK_SENINF_FORMAT_JPEG) {
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 0);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN,
> +				      FIFO_FLUSH_EN_JPEG_2_PIXEL_MODE);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN,
> +				FIFO_PUSH_EN_JPEG_2_PIXEL_MODE);
> +	} else {
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN,
> +				     FIFO_FLUSH_EN_NORMAL_MODE);
> +		mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN,
> +				FIFO_PUSH_EN_NORMAL_MODE);
> +	}
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
> +
> +	val = mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);
> +	rst_mask = SENINF_MUX_CTRL_SENINF_IRQ_SW_RST | SENINF_MUX_CTRL_SENINF_MUX_SW_RST;
> +
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val | rst_mask);

Are you sure that you don't need any wait between assertion and deassertion of RST?
Looks strange, but I don't really know then.

> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val & ~rst_mask);
> +
> +	/* HQ */
> +	mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, 0xc2000);

val = SENINF_FIFO_FULL_SEL;

/* SPARE field meaning is unknown */
val |= 0xc0000;

	mtk_seninf_mux_write(mux, SENINF_MUX_SPARE, val);

> +}
> +
> +static void mtk_seninf_top_mux_setup(struct mtk_seninf *priv,
> +				     enum mtk_seninf_id seninf_id,
> +				     struct mtk_seninf_mux *mux)
> +{
> +	unsigned int val;
> +
> +	/*
> +	 * Use the top mux (from SENINF input to MUX) to configure routing, and
> +	 * hardcode a 1:1 mapping from the MUX instances to the SENINF outputs.
> +	 */
> +	val = readl(priv->base + SENINF_TOP_MUX_CTRL)
> +		& ~(0xf << (mux->mux_id * 4));
> +	val |= (seninf_id & 0xf) << (mux->mux_id * 4);
> +	writel(val, priv->base + SENINF_TOP_MUX_CTRL);
> +
> +	writel(0x76541010, priv->base + SENINF_TOP_CAM_MUX_CTRL);

Each four bits of TOP_CAM_MUX_CTRL selects between seninf1 to seninf8 muxes, and
TOP_MUX_CTRL is laid out in the very same way.

This means that if you're calculating a value for TOP_MUX_CTRL, you can do exactly
the same for TOP_CAM_MUX_CTRL.

> +}
> +
> +static void seninf_enable_test_pattern(struct mtk_seninf *priv,
> +				       struct v4l2_subdev_state *state)
> +{
> +	struct mtk_seninf_input *input = &priv->inputs[CSI_PORT_0];
> +	struct mtk_seninf_mux *mux = &priv->muxes[0];
> +	const struct mtk_seninf_format_info *fmtinfo;
> +	const struct v4l2_mbus_framefmt *format;
> +	unsigned int val;
> +	unsigned int pix_sel_ext;
> +	unsigned int pix_sel;
> +	unsigned int hs_pol = 0;
> +	unsigned int vs_pol = 0;
> +	unsigned int seninf = 0;
> +	unsigned int tm_size = 0;
> +	unsigned int mux_id = mux->mux_id;
> +
> +	format = v4l2_subdev_state_get_stream_format(state, priv->conf->nb_inputs, 0);
> +	fmtinfo = mtk_seninf_format_info(format->code);
> +
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, MUX_LP_MODE, 0);
> +
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF_PCLK_EN, 1);
> +	mtk_seninf_update(priv, SENINF_TOP_CTRL, SENINF2_PCLK_EN, 1);
> +
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL, SENINF_SRC_SEL, 1);
> +	mtk_seninf_input_update(input, SENINF_CTRL_EXT,
> +				SENINF_TESTMDL_IP_EN, 1);
> +
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_EN, 1);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_PAT, 0xc);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_VSYNC, 4);
> +	mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_DUMMYPXL, 0x28);
> +
> +	if (fmtinfo->flags & MTK_SENINF_FORMAT_BAYER)
> +		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x0);
> +	else
> +		mtk_seninf_input_update(input, SENINF_TG1_TM_CTL, TM_FMT, 0x1);
> +
> +	tm_size = FIELD_PREP(SENINF_TG1_TM_SIZE_TM_LINE, format->height + 8);
> +	switch (format->code) {
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_VYUY8_1X16:
> +	case MEDIA_BUS_FMT_YUYV8_1X16:
> +	case MEDIA_BUS_FMT_YVYU8_1X16:
> +		tm_size |= FIELD_PREP(SENINF_TG1_TM_SIZE_TM_PXL, format->width * 2);
> +		break;
> +	default:
> +		tm_size |= FIELD_PREP(SENINF_TG1_TM_SIZE_TM_PXL, format->width);
> +		break;
> +	}
> +	writel(tm_size, input->base + SENINF_TG1_TM_SIZE);
> +
> +	writel(TEST_MODEL_CLK_DIVIDED_CNT, input->base + SENINF_TG1_TM_CLK);
> +	writel(TIME_STAMP_DIVIDER, input->base + SENINF_TG1_TM_STP);
> +
> +	/* Set top mux */
> +	val = (readl(priv->base + SENINF_TOP_MUX_CTRL) & (~(0xf << (mux_id * 4)))) |
> +		((seninf & 0xf) << (mux_id * 4));
> +	writel(val, priv->base + SENINF_TOP_MUX_CTRL);

This is duplicated, and it is the same that you have in mtk_seninf_top_mux_setup()

> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_MUX_EN, 1);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_SRC_SEL_EXT, SENINF_TEST_MODEL);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_SRC_SEL, 1);
> +
> +	pix_sel_ext = 0;
> +	pix_sel = 1;
> +

This is in mtk_seninf_mux_setup(), but if you apply my suggestion, it won't be in
there anymore, so you'll call a function here to set the right value :-)

> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL_EXT,
> +			      SENINF_PIX_SEL_EXT, pix_sel_ext);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_PIX_SEL, pix_sel);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_PUSH_EN, 0x1f);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FLUSH_EN, 0x1b);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, FIFO_FULL_WR_EN, 2);
> +
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_POL, hs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_VSYNC_POL, vs_pol);
> +	mtk_seninf_mux_update(mux, SENINF_MUX_CTRL, SENINF_HSYNC_MASK, 1);
> +
> +	mtk_seninf_mux_write(mux, SENINF_MUX_INTEN,
> +			     SENINF_IRQ_CLR_SEL | SENINF_ALL_ERR_IRQ_EN);
> +
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> +			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) |
> +			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);
> +	udelay(1);
> +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL,
> +			     mtk_seninf_mux_read(mux, SENINF_MUX_CTRL) &
> +			     ~(SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> +			       SENINF_MUX_CTRL_SENINF_MUX_SW_RST));
> +
> +	//check this
> +	writel(0x76540010, priv->base + SENINF_TOP_CAM_MUX_CTRL);
> +
> +	dev_dbg(priv->dev, "%s: OK\n", __func__);
> +}
> +

Cheers,
Angelo


