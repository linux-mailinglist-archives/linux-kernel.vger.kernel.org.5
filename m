Return-Path: <linux-kernel+bounces-18078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EC825869
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014E1C23493
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE23173E;
	Fri,  5 Jan 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bVkA0W2q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137321E507;
	Fri,  5 Jan 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6PUzpQuJJAYpIYkED8iaWKoTIl0o8GE9FB/DGp1hu8F7BFop2G1kwy/W/e5AU3lM456bwxElyWakn/SEHVo3r9KU4VgW8d9r0gspVikEpZi7NJKKq/RVE6aWmkT3ZCwAmgh6E/9nw9ISuazRw9QB3VdtsUxWDLYTU7qjlT49DtY2lkstQ52w0tL1fKinhaFDVaSQhpGXQSOoWtkq0AMs8ckF+XQS7rwM1bplQjK8XQMLZ8V/7ouaTFpqpYJnIQey/3SlQiGcb2D7D24rLi/jPj+zv6s1WcTNN0EPW4KM2/PKVPzLDlu31PYVdfTL1req7eJBWz8B9dAF9FIoPx6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0k/V8C3LLLpC9xJrkIadpQyZcFBUEusZ1QCseXgXds=;
 b=TG64j0M4p+L480BZ5PfHEEVub7jaJLXr43VQelGJDR7JYFNni2wUVfLVHA2iflujDtFQHBKp98ldkVzZN8onPUGg/B6N71A6ID+pEUAn1Y7nrLu3o0h7jlq1NuPnnikTl6ph0+4Y2yjo1RAnRC4go8tbI4pvMRsX2b84M+2cGMvQwLzkjtoT/VRfnw++fQQOjsd/9VHwKJIy0HL60M9t8aKT22kL5JUmOrGZ9eJeiYi1B7iqMJCa0sA+tKi65+lBF2twwriraEJ65Kw1rEtZT9Nl8mOjxgK5BJbcijtw0icc3xA5b5+ra8rBnK877yObs6kwPUi5vqbIEip5M6/qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0k/V8C3LLLpC9xJrkIadpQyZcFBUEusZ1QCseXgXds=;
 b=bVkA0W2qyFjSSsX+xjS7L4y5g+ITUxhcp8kM1kyBWKb7CCMRfktIzzFhSTcU0gb9oAvSIv6bzYnYEkTI5i/RTf/j79GX8R/Wii5FL0LLccPXZxLdMyVDftFJN15OxIQDhFXDJ0IJKFkOhGDEsBotVcLdBtYsBb6OGhWxpJa4GaQ=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS7PR01MB11583.jpnprd01.prod.outlook.com
 (2603:1096:604:241::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.10; Fri, 5 Jan
 2024 16:39:53 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7181.009; Fri, 5 Jan 2024
 16:39:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson
	<sean.anderson@seco.com>
Subject: RE: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
Thread-Topic: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
Thread-Index: AQHaP/BMp3VkzdSHW0qQi1Uk8IEbbrDLaurw
Date: Fri, 5 Jan 2024 16:39:51 +0000
Message-ID:
 <TYCPR01MB11269ABEDCD115064D449267486662@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
 <20240105155918.279657-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240105155918.279657-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS7PR01MB11583:EE_
x-ms-office365-filtering-correlation-id: 31ca393c-e14c-429d-539a-08dc0e0cf064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UAyvrKT44mEBEyXr/DaPKeQGfklXEpAXTtcUntPnWjgIiSdCmJmQxt39iZT5cRRAUeVK1cH/RywEbeYum/PX+QvGKJ8BONn2uLgFACmiB1ZI/JWAZ+IGrDDGPlsBBd2Mml5Wk+rHuJ2bbYOu81SHC22QrXe7x1otXnO/5vcwbIDBA8X4/2BAfe9g1nHou9fUt5C8dxgkOntYy4t+paW0DztHOvJ3jYXrlIC69c3EcgR6vAYUdR7tojMQEVxj93I79JSf56wqKr79Ul0DdgEtDj76fSYqiSY5fQN3OxXS004py5g4pbIzT1+TUI5wZUjhj7Dfg9Z7Kdi02m3vKx3UtGPUiYFb4wxWDmLGKwPmPfYu1vTzf+8mvs5AlG8F4K4nlJqcrVpXiI1LaCKG5ZSNjHMOhkAwlifq55n66sBclLbH4QrymR1uBn4cj42PTsCdIcMN/7Vu0Te0kNj8vf3TI7RCdlL4PWqOsLVpMGkFw4XMHlM1xM85Fy/HqEjUmQQfhH8Bxq80OpB56YRwor2faHnkTzRAldBGVjtmlmBDzYRPJihO2g5kzFdZJEEhZ53q/SKDP4zBOBx3xXPbFCqzVQ9QJYyYNAo26P3pKAyTMi2aa16tYdmTTyp20M/TLrAyjmgptAJnoR79yGrZU4IuFA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(71200400001)(53546011)(9686003)(7696005)(6506007)(478600001)(83380400001)(7416002)(2906002)(41300700001)(76116006)(66556008)(54906003)(66446008)(316002)(66476007)(64756008)(66946007)(110136005)(8936002)(8676002)(52536014)(4326008)(38070700009)(921011)(38100700002)(5660300002)(122000001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tNZ834xSi/r+mn4wBzGL9vKnm0SKBlX5qchn4RF9/IE2o1vf/3E3WNt0JUzo?=
 =?us-ascii?Q?B9usNobUhoDz2V35nBLULQr/G3dvNe9XClY4XfU+FZOXulWMSSJt4skqJBEk?=
 =?us-ascii?Q?JZ/WuhVmtimXyasBLU9mLnLrrsKWZxo82UHJSEi2V/FGtSsqE7hLS7wge00Z?=
 =?us-ascii?Q?m59hACrdgu2RSL40GzJjwwx6qtGCXR/WkO52VgJTb6b0RjBNpveQR8YW2v3/?=
 =?us-ascii?Q?njPZ3RPZEAlgYE8c37FdNrh2AcLkz8CTRW/DA0Bghk9EiHT3U+F7M6VSdACe?=
 =?us-ascii?Q?kLgYGy8iXTRs/iHc+Y02iWhWDJqHE8JKrtdYVh7Jy2AxZJBHF0TeIf5sVZpG?=
 =?us-ascii?Q?Jd0UmDo1SCyQe/k6jcXsZGsqTiBoPY8rEdvmpSqDfO0vjg1nOS6ioqqx7m3l?=
 =?us-ascii?Q?UsDE2gG54MyfX1d7L5tnqdppbpL8mgYVsIAJkA7Rs8F9+Oj+cbtkW87XRQDX?=
 =?us-ascii?Q?ol8l06nz4kY83ozvZVcMyyuSXKJ4VYz97O2fHicVCUAB/jAi6djvIJeGaNbO?=
 =?us-ascii?Q?i/6xXScOQ1aA/mJbXDiXMLHYKEAtPHlMiAqhe1SOu+muEpLR6bHj5FbKO0Yg?=
 =?us-ascii?Q?YC4cOOQLOLTPjM0NMEnclVLQuAqNRJe6YRWmah8RcGNj3CkAuevJ5A2m2CjW?=
 =?us-ascii?Q?dCLwptpmE2QFoDAP+H4YE+h2gN1IcFSpi3r7HXMUg6AbX+sG8gHq3zcj+Xvh?=
 =?us-ascii?Q?gee7t4KhaNn+PLdz2A4SyqC1bniAuMQh2GWPBHLVXmvEkpoFkyGDjXY/h3D3?=
 =?us-ascii?Q?1dwJmRnTGpb8fVdyosniPohRbpiAGqpjnE+FKoQJyj5kY17txpcvFFt41Ygo?=
 =?us-ascii?Q?i9GJ9FCzpD+zIoXIYimRBn+kYNBMJZw5WJorVDJGC05uVjfh5iD8wC/VNvdQ?=
 =?us-ascii?Q?1AV5vYqf3AbItn1pnRBOQcwB5EyzWliOKj3Ee/GY5qRWcv+Nte39fsObQRGC?=
 =?us-ascii?Q?rQ1ZR3KSQB8ZNLnMQLsOEUmbivOqz9K339kCW88MmttK79oUVnzlhnnMqozN?=
 =?us-ascii?Q?/tBJAcTIZkT9TrifHBdwTWp+JDGnds15Sx6f09iTpfWNddM1klLpoiidwbJj?=
 =?us-ascii?Q?GaJplVKovhMZtu9EMK/WAgbKMgJwTWN9tLWHEHw+kE3lHT9lkYp2DOzBlBJ7?=
 =?us-ascii?Q?aj1K+L4cUXGHz3JsGAYvQqt5BpA0Qn+t4eoEiDiPlnTVYeDIhLYbDWbCTM/i?=
 =?us-ascii?Q?6eywG+JPrW90fOW+bGqudMJG0cOVS9bezU4im6FirByyeWcjF2APPyM0FNUr?=
 =?us-ascii?Q?z9v6a207KWufvpl/6nV5cy8VZDs3CCzjH2VUpqfX97VKF6CG/kxituaaIPqg?=
 =?us-ascii?Q?xjMD5BkIDUHZMrOicLcp/9+iC7tybgU3rszfue0ZF8zHNsE1Q7SlSd/iESYC?=
 =?us-ascii?Q?DcxC3omB0rg6SJi/h+qPAt/SxSRR3qOnt9KcgdEVyCUU4t+adtA6MlRhcTAz?=
 =?us-ascii?Q?Lcjy5pGQs4BESLgXNLvYNyjHTLk8d5p1g3aia3QjRkeEyNTU+vYTZdFd+73s?=
 =?us-ascii?Q?tMHx9qIzuIii+DeQCjqdMbwgVohpUrZoS0pq/70ud+U/e6YLcvXHT6Ab8FpR?=
 =?us-ascii?Q?OBnbmohbBKQdu66z/OyCtVdHCZpyLAHxiq+jR+b+FwPY8DJVq2LQ/xIDbmqn?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ca393c-e14c-429d-539a-08dc0e0cf064
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 16:39:51.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWn45HBXGTa3cHv1UincSWRwRWrBz6gnU1gaJauGHqAuhxVa7XIi0yoh74n7Q+4qpQPNKigmd+KRKwj3LN5vQemQLZkTcNuAFgdJzFumbis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11583

Hi Krzysztof Kozlowski,

Thanks for the patch.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, January 5, 2024 3:59 PM
> Subject: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
>=20
> Add a simple driver to control GPIO-based resets using the reset
> controller API for the cases when the GPIOs are shared and reset should b=
e
> coordinated.  The driver is expected to be used by reset core framework
> for ad-hoc reset controllers.
>=20
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS                |   5 ++
>  drivers/reset/Kconfig      |   9 +++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-gpio.c | 121 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 136 insertions(+)
>  create mode 100644 drivers/reset/reset-gpio.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fe27cd60e1b..a0fbd4814bc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8866,6 +8866,11 @@ F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
>  F:	drivers/i2c/muxes/i2c-mux-gpio.c
>  F:	include/linux/platform_data/i2c-mux-gpio.h
>=20
> +GENERIC GPIO RESET DRIVER
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +S:	Maintained
> +F:	drivers/reset/reset-gpio.c
> +
>  GENERIC HDLC (WAN) DRIVERS
>  M:	Krzysztof Halasa <khc@pm.waw.pl>
>  S:	Maintained
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig index
> ccd59ddd7610..bb1b5a326eb7 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1
> on
>  	  BCM7216.
>=20
> +config RESET_GPIO
> +	tristate "GPIO reset controller"
> +	help
> +	  This enables a generic reset controller for resets attached via
> +	  GPIOs.  Typically for OF platforms this driver expects "reset-
> gpios"
> +	  property.
> +
> +	  If compiled as module, it will be called reset-gpio.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile index
> 8270da8a4baa..fd8b49fa46fc 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) +=3D reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) +=3D reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_GPIO) +=3D reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) +=3D reset-intel-gw.o diff --git
> a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c new file mode
> 100644 index 000000000000..cf0a867cbc5f
> --- /dev/null
> +++ b/drivers/reset/reset-gpio.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +
> +struct reset_gpio_priv {
> +	struct reset_controller_dev rc;
> +	struct gpio_desc *reset;
> +};
> +
> +static inline struct reset_gpio_priv
> +*rc_to_reset_gpio(struct reset_controller_dev *rc) {
> +	return container_of(rc, struct reset_gpio_priv, rc); }
> +
> +static int reset_gpio_assert(struct reset_controller_dev *rc, unsigned
> +long id) {
> +	struct reset_gpio_priv *priv =3D rc_to_reset_gpio(rc);
> +
> +	gpiod_set_value_cansleep(priv->reset, 1);
> +
> +	return 0;
> +}
> +
> +static int reset_gpio_deassert(struct reset_controller_dev *rc,
> +			       unsigned long id)
> +{
> +	struct reset_gpio_priv *priv =3D rc_to_reset_gpio(rc);
> +
> +	gpiod_set_value_cansleep(priv->reset, 0);
> +
> +	return 0;
> +}
> +
> +static int reset_gpio_status(struct reset_controller_dev *rc, unsigned
> +long id) {
> +	struct reset_gpio_priv *priv =3D rc_to_reset_gpio(rc);
> +
> +	return gpiod_get_value_cansleep(priv->reset);
> +}
> +
> +static const struct reset_control_ops reset_gpio_ops =3D {
> +	.assert =3D reset_gpio_assert,
> +	.deassert =3D reset_gpio_deassert,
> +	.status =3D reset_gpio_status,
> +};
> +
> +static void reset_gpio_of_args_put(void *data) {
> +	of_node_put(data);
> +}
> +
> +static int reset_gpio_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node **platdata =3D dev_get_platdata(dev);
> +	struct of_phandle_args gpio_args;
> +	struct reset_gpio_priv *priv;
> +	int ret;
> +
> +	if (!platdata || !*platdata)

Maybe, if (!(platdata && *platdata)) which reduces 1 inversion operation.

Cheers,
Biju

