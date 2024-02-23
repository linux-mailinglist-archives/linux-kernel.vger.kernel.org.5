Return-Path: <linux-kernel+bounces-77564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF986078F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B211C21CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05155399;
	Fri, 23 Feb 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbfjtoMs"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAF7F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647607; cv=fail; b=UqqS27KcoFnX5O8ByY8YCoZdv9tqEGEoGsLL1enybcZX9zo3jrrbvdH/bIrjurHPAV3nO34beWilIcs5MNlhdiPhTXw8nS23YmKau5lLijz4AXKJ/9lHMkgmMIiN2HAQjcfRWkoURyjpUa5KpfPm1qTrbQOb7B72EVAQYpJ6F6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647607; c=relaxed/simple;
	bh=1IjJPNjReCci8BfI3ZnT8Yc93NmBf3z6lghfJR2/jFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sdJ/MJoaI6XavWtVxrQ4jZYMkm6MpT2aHO/1xjkYClxm8X/+5MCHJy7xTaDNeB/cdBWPdUSgNzKD+qojnxQdfZKGlwmXdIHDUULM2OxtsKvrCb62KQPWQ4+wWOOsLLqrY0LvHyZEWh3lbub4xEoU/x/MEPBT1B08zek19MDnhbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbfjtoMs; arc=fail smtp.client-ip=40.107.15.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYTkGwl0UlBlu98Dw8thobyXHfyVnxWPyJIeR6sOkwqHfPAsXJVGD5c076LkExraRBle6FdvmuPajKF1oXbE8lRjKNRRaaDflCI/68EuZbLs3k6pY6Xi3ZByUi9+XaZqK8cOJTVwa2+OETALChp03EKVt84k/YgvlHbAOMy9VGLL8wAKCVSyLBdUT//QnlRVtxO0lKV4/k9Bx86bgaFFO7vGjKo+9crnYIfoVu7JwIe3sTxZyFDvifuS7hgbVeztR5QKGNZsy1r71pKYCYkurhoqFtmy4GZwZqSVFE+KrQqL/LOJUxzVGXfNRqe1Za5UTMr0V3oRYdbotzcHn+MRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJswcpU89pbUrxuCquX+XTJf4CDU/FAeQNQZ+2hmgNs=;
 b=h0awX6gfncRI6ej42hjdXmpC2b31vjAqDBXxgAYPAsOIm6yZsfw5iZLaB6ZH+B2nkIeoCBDSdsYG5Wciv7cLeHLtOUjucoWN9zLuF6XlfdHFRu/UYCwgZ+ZJj9/mjn8dEXcPLewIx9tnRevB6kc4bif7L0XOdYudWme8Je1XZQ/wb/SszaA0sQ43w7I+tLUqzHtyc+9smeFuf3RrYTeEC18Wd/ft4ywyySL6Iu2T0rf0Asiqf59BFOsrOsOS6OiDr+N4jo6LnO8QV2JceEPUYM78QaRAdKUvfXS23EHw7MKjOrOkTAau6qIvXaMCfkiTBd7IgClHHADctNhM4kiCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJswcpU89pbUrxuCquX+XTJf4CDU/FAeQNQZ+2hmgNs=;
 b=fbfjtoMsD3vM18TexKPWqSNzPhs0iQYCWufl4j6o4SdtNSTudsWs+qNt9mNhKt6Sa1yKwq9Epzg2NMtbKB35m5DvLx/TkNFgHB32KCTRIs6hld3pGu2aROF9tnsaafmkGgavT/cfcy2Ldjhf3lxOyPMcT7ZgN6lQaMYMS6lrtzg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7821.eurprd04.prod.outlook.com (2603:10a6:102:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Fri, 23 Feb
 2024 00:20:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 00:20:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"abel.vesa@linaro.org" <abel.vesa@linaro.org>, Bough Chen
	<haibo.chen@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, Laurentiu Palcu <laurentiu.palcu@nxp.com>, Mirela Rabulea
	<mirela.rabulea@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
	"a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>
Subject: RE: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Topic: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Index: AQHaZZAK3HsnMTrKqE+zTI6ulJ5/urEXENaA
Date: Fri, 23 Feb 2024 00:20:00 +0000
Message-ID:
 <DU0PR04MB9417EDA0F58C88FC74DFAA1988552@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7821:EE_
x-ms-office365-filtering-correlation-id: 3e54cee4-badb-496c-9e13-08dc34052ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2XBAlWK3NmgfH7gT6u2OaNmCFWn7Bc5iqarivRHcV7ynav7R6eC93dllQdqkmGGV/G2VbEzEXFkSEOGQ+OFtfeEzewH2PqeN0DutO1ENcvamhJPm5TArTbp/6b/Hxcye5IfBZ3/MO0zifFUQFNrIwCdIOlBzRd1o6xswxTXrl5pQ3HFpcN6P9ANhX3VR6kIcn2rIc1iz8OzzCa0WIbcQB2xJv5U4RJiRVH4wXAOp6+mBnR94etgGveC41/aF9zaeO0INopN6hrveMnKfEjme6LnB5vsZybRT/y7GNmt0Nb2yxxM/s4z/vzGB/ipFL/wn7zG1M/GguYllJAADTnoetFkCMxk2WrLlJMOKKRA2fKxLA9tlyRuyYO0GDrELi5t4xXILYjpS4BZ0kFuUne2VTNN/ZSrHsOk/VlIkrcFd0WtGU/Avkuy7e5UiYXmuoea0w3EWkenULN7wfpMWdKzOfaO9Ty7M6vYVQJ7TvJ8obNsu8h3PAjV5okohaoJt5rVO9j1yi6sUZqzB38+i3wthgPpQHLEitkrULokGG0+XIvFVAKZpOPElFDRYd6bCuGI3XbVdxjwlXQEVv0EtIotYTWhjhiBgjAQ2e7qyon+kw70=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sMCgjYMHrMNF4TNBhhIZvw9G1oM2btPnAYGuQ9vtmxvHbjWZYsNlAhxxpEjG?=
 =?us-ascii?Q?eb0IbOf3R0HwKe40ygDuHtKB5VaQgX0ewItLap1QKCbNOA75fA6zLQ37G8qA?=
 =?us-ascii?Q?/mHgEGgC8ZQV1dAYhGbBCPzQrz3QRrpslJnC8h/EO5I8uD6GBiZ++vrpkllS?=
 =?us-ascii?Q?3LzQmS8djtYgdTcZ8imgXiW7CY4xbo1TFlzg5LtvPwWOuWogNV5+Hgom2crm?=
 =?us-ascii?Q?cr3AgP1IvCOdkBPWwc2EnfQnYts/WiiDLgny+YIMax48tEDewala7uJNDtUY?=
 =?us-ascii?Q?bQtmYUFMIzdyuSBj7GKo0LBqWfbMgbTQH6CywV1RQKm4L46OC5c+Mw7wBQDD?=
 =?us-ascii?Q?FzfMuxjKh/DWZ51iO9t9B7REVdBg7cPKvdLgFqByR0beNtb7Y8YDLe7xSgZv?=
 =?us-ascii?Q?BgbyjeBZQIxX+muF1ETrI3yosyUKDO/e4lrgT4MjUzOZs2/9JOrkv4/wb+MI?=
 =?us-ascii?Q?ypUtaaolmAL6dtkIEz6h6bH1yRVB3Ryk7CcPqYL6XQmZGcA39bCDNB6Wpy10?=
 =?us-ascii?Q?anhpsYYUZV4Ca8aO/h7DNCs8z7mLMGq9mEVt6ZOzxB+j9AS1qFLqAVIMe6VJ?=
 =?us-ascii?Q?IJsBVu7r3Ap8VlAy6aXIVqMcoIrf8OVTjQW60bQVtnK2fEtyqh95E6bpUhEa?=
 =?us-ascii?Q?/NwZHnkSmHrUzXmfwz9HXpHtKcn342/r12FR++i0i4zmiYfSMR+4IVDQ8gro?=
 =?us-ascii?Q?9YcGhd1ikJ3ATRU6zOTnlzhuj8wBERL+LOT0TMjuL1JYyJQpNI2jWuOfcZ50?=
 =?us-ascii?Q?OzZeZjn0LmE3Y67TbJQLYVm9YRSml1deYv6OrDdOAtS2yY2/sX5FzKijqnqC?=
 =?us-ascii?Q?EfjrPZEfJQ86Y9up2GizJVg+2Xm4kdgGQ43CEVEkUF3Tz4PpvBxLiXPw7E8W?=
 =?us-ascii?Q?rE/IrE0mfIU025Ts8Fp+pTuwp4XHPEU6WjC5AcILXrHKxRs+dbdIr7ru2yeI?=
 =?us-ascii?Q?kI4H//vplSP/bbJwR/UD7DGohKEDNPc4WY4VYoEk0tknvmpWMmtRd3wLLn5e?=
 =?us-ascii?Q?TDhVKGuWzobQtG28Zl0uNAcmQ/H8rzhFqjuLJ/0s5dRNkwrvqH6S8UmF+yp9?=
 =?us-ascii?Q?b0n9NIINK71dElR9qX7kb3Kb3LKaCYfsPzq5imh2fBGmCelgdknmfCjIllED?=
 =?us-ascii?Q?ZJXyBQzwf8NRKjRZSkCK0Ke/Z7KGMdpq0LNrdoJHzWKCOQkzen6EaSiYE/H5?=
 =?us-ascii?Q?xI1pe3E5Y3c3AHXg39ut4eR7ngJm3E5JOp3IzL4MJvdyemmxRieFEwIN0tNr?=
 =?us-ascii?Q?7uUYJboIrpnGO/LF3cmg4u+OehYJhyShM5a2AhDtqL9TJf0ZHjro+SglIgBB?=
 =?us-ascii?Q?ZAPE7pfBWJ5E+Brc9ZKrUItPZ38kZAjl7+pqQlu1HAkeW/mgNjuulbEWMYby?=
 =?us-ascii?Q?tZmXMhQUeZMMuo/YhvC8qGv0VAFMeKcTYHOz3UWZgAXd8W59R4BIqiX+eDs0?=
 =?us-ascii?Q?k7dhp4LcXnHSxT/hfazC10WBTkkTIR9U6VdmxKrs1aox0IS/asNYJ+V8T0Sw?=
 =?us-ascii?Q?koHGhS0OejsNMlVsTM9tyGtrXSWOihHqH4zRrg6CCCiw5i5P+R09ld0Nl4a+?=
 =?us-ascii?Q?+/rcnMgm7eTh0TcIpK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e54cee4-badb-496c-9e13-08dc34052ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 00:20:00.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azfqPf5G37eOHE7iTcIHv4hUtUrhNVh14RpcA19XcYa0msF3hJ8y9OMsaFP87AAGoFkKjsS7vjjCvGxot8Oi2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7821

> Subject: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX
> development
>=20
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> So far we used an internal linux-imx@nxp.com email address to gather all
> patches related to NXP i.MX development.
>=20
> Let's switch to an open mailing list that provides ability for people fro=
m the
> community to subscribe and also have a proper archive.
>=20
> List interface at: https://lists.linux.dev.
> Archive is at: https://lore.kernel.org/imx/
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes since v1:
> - changed from R to L as per Ahmad suggestion
> - removed name 'NXP Linux Team' from list name as per Aisheng suggestion
>=20
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..2344eda616f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
>  M:	Sascha Hauer <s.hauer@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  R:	Fabio Estevam <festevam@gmail.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> @@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Shenwei Wang <shenwei.wang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -8524,7 +8524,7 @@ F:	drivers/i2c/busses/i2c-imx.c
>  FREESCALE IMX LPI2C DRIVER
>  M:	Dong Aisheng <aisheng.dong@nxp.com>
>  L:	linux-i2c@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>  F:	drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -15704,7 +15704,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
>  NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
>  L:	linux-iio@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> @@ -15741,7 +15741,7 @@ F:	drivers/gpu/drm/imx/dcss/
>  NXP i.MX 8QXP ADC DRIVER
>  M:	Cai Huoqing <cai.huoqing@linux.dev>
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -15749,7 +15749,7 @@ F:	drivers/iio/adc/imx8qxp-adc.c
>=20
>  NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
>  M:	Mirela Rabulea <mirela.rabulea@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +L:	imx@lists.linux.dev
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -15759,7 +15759,7 @@ NXP i.MX CLOCK DRIVERS
>  M:	Abel Vesa <abelvesa@kernel.org>
>  R:	Peng Fan <peng.fan@nxp.com>
>  L:	linux-clk@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git
> clk/imx
>  F:	Documentation/devicetree/bindings/clock/imx*
> @@ -19630,7 +19630,7 @@ F:	drivers/mmc/host/sdhci-of-at91.c
>=20
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-imx.c
> --
> 2.25.1


