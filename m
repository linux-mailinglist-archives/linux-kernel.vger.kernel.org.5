Return-Path: <linux-kernel+bounces-73820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2F85CBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07111C21A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F6154431;
	Tue, 20 Feb 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="psFEfocm"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAD152E0F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471413; cv=fail; b=nP5gj0APwBcguTBDzqTlAvMSfUHEnzCW3Ce0oGQOnx+IKkSJr9Ap/rqDXYrnCls6jehXGiFzTcS18Oy/lOSRvZl9isXWGPGksYhnb41o53xTmmgTDDw7nKRrUv4m/M3xae/SZVnFc9TrQ8EXVtN2IVJA0E5f8UQuzXko8F2GyiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471413; c=relaxed/simple;
	bh=VZazOl/2jHLqd3qjOhGuoUhXgv1sfPdNMEhH9VWq37s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qB81rhJKQbl+hlroW9ep8l3beHf1qQqNN7YBs2htoTXjE1Day7o1dNsNob+ObIFfikI76gqSqSiKBqUEWK/55MlISnVfeVu+y0wz/7vQBDR0rDZaIhf9enoazk7plXlHAdchmG0tV6lzO3VBEqHXPogppQRlO7aett4A1cvJ+4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=psFEfocm; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqWMQSqIUFbnaZOSsmO6kd6G1CtBKEOofSqmr8u7hA86XT65MmWnXeJWO24DxyVUrF97eleySrq5ieWGzAzf/IP4rccuaOPQo/0PCyyhRRPN3c8CMS9RxIHjyyAJQzDTOzGEPFKceQDOFjVtAYExsY7fSeuYLTK6uWM9Hng271SDvNmmxgU/igx1OAf8JoSGasqU1/1wdOLnUfmimQhvOtFm8LBEPPd2gtHu7FSFxJHBJeCaqRaa5UgPitiTgRe4EgDe+CUrP6v9kGqcidCnExpB2HeQ5Yfc6/E8JzMvL1B7LCmpQ0w+epX/DgdsikTaVJIappmioBRvcHtQd8rLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBs8r0awW5c3vbMDvyiXWT95zXYMgW9bHuqD7CQdWGE=;
 b=hGaXmBm4sehnuMK7l9F2FpFYGpISdMSpFPB8NbKEdsrRTTl5sXOu6mZ5ZyWNQnG2t3VXhIJPLZKFBlfUNwtW/W1KqGsY3G3WL47n71xmsJm1Q3bbUPYPJjd7yhwpSIW+/x04AoVYScJphRSPvIjyx1lQ1beqL6uSUcURKl407tIDcxpEjZLKr3/tGMwTp1ummtZXvhOvO1bIm1QYAdzTKas4tDxlsECAmeCPJ63qaj0SOOYn3uYwLTPPpR3f0arLg1YO+L4M6hI9GyX25ZHYZV6NB+OwE9XaIpaAUyuJDKKdJXVt/dGQlsSYVxzt+jI1r1sLBLbYJKOA+g9goSsV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBs8r0awW5c3vbMDvyiXWT95zXYMgW9bHuqD7CQdWGE=;
 b=psFEfocmNyAiL7AnSeNXry2X1odiLt27ObZZJAv25fOtGj+5G98xaGNipzLC4HVjHHCng4oqpxV63RHHmuMDLCP0X6ILFRAEHfggpxl6yE/bb502uUfvbbuj/EePQWbLgq6R04FpeqLYGweEuly0FTXDcNaRtnVeCAVeI1O4KVQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 23:23:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:23:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: Aisheng Dong <aisheng.dong@nxp.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "abel.vesa@linaro.org"
	<abel.vesa@linaro.org>, Bough Chen <haibo.chen@nxp.com>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, Laurentiu Palcu
	<laurentiu.palcu@nxp.com>, Mirela Rabulea <mirela.rabulea@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Topic: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Index: AQHaZBuNdPQ5nfCnVkWVSKv/W8mBWbET3yrA
Date: Tue, 20 Feb 2024 23:23:28 +0000
Message-ID:
 <DU0PR04MB941768597A9B5BFBFBF2C26D88502@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: c55239c1-517c-4d0f-1e09-08dc326af220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WxNbVHPV032PJADgVO3VqTxxRRHCTI0IDFqBHNc+379VLKIWZIklXXi2yWliITlk8MLF7byGoOo4QGoXlwFXNgUt2WBbh8TuRHHmDXba/qX4q0Fyg+bvzU7ahBixBsz3IdVK6Wn6seAPgQ6jXGzS0w0i2uQBNIiX7+oeFTpQnYMYboFPj7LRh6G7KgzUwoLiEo0TKljDbRYPaH8hwxLIyjoEe2wLXPQf+GzluV9RynsRFpKXWVOB//KjcwZcZb2qNfBiMzqpHeVJvvTiTBUicsAFpzHdA975pHGQLl4TJVMgAAPKRYc7jcLwXE40kDmFega8rFX5X7yxj2Fnk3X92iDus1xH9phs2U8TuhpkOYG+doz7GANsoP3NdsTQFBo2tloHuvwrbTJTTubIaGtyi9OcxS5YshmFzvLtT3M+oq8/GUW/MJxu9TjJWGdDSpPoXbgxB/eojgUYTGI9zls1QQJYUcUH3CB2jBCQVbgtBRE3tLKqPKK7xOA4ufEvQrncNxlygEJvu6EVq/4jB14orPB1M6LmKG0klDdbajNc39w9R8dulvCxSUV0La6gteiUDyFExTUR+pOQ8GUXfE7qTdOC5y28uk9qDb5MyFoEk2A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QmHBTZYcKnUPJJNnx4aimTiiCKjNug8ayuiF8a28YWQs4tDDoA4MXlX/rKoP?=
 =?us-ascii?Q?LtjfvUDN9dshbOWAti24YO3hS8HlDyT3FdImKj/+SekqXFZr+9j4lPzQGg3n?=
 =?us-ascii?Q?KufMqeKXXKCmIgcYRBNualPRbfmN7fiDDcOiymelpnJVh8Jbm10FzuU13Icp?=
 =?us-ascii?Q?0pIClycwohKP+jBO5EbDJ0E10mXm6Kro1qZ5yAmfFlmZUG8Euqfe2WdEV34J?=
 =?us-ascii?Q?oDcKuyF39Jb5jQ13qkKBkmMi6qOP6Y6bTMNmpzKt4YVd9JpnIKFwFxA+5taR?=
 =?us-ascii?Q?RFyl6jVCIUV7D3qZGyu54tKgb8XsLtuzuciCXhi8Y2BZjUBOnMo6EJgqkg27?=
 =?us-ascii?Q?R2wFC+JBFAUF0tmo/pYQxIWFxIDzPIXm7tTcmeJtEzbZEx6qjHERPDNSXmaw?=
 =?us-ascii?Q?Vy644OzGlM5R7QUGv64AhsWeLJc6lPt63MFxSb6DyBecWXcHN+Rljpq4OZsd?=
 =?us-ascii?Q?XlOqKMnD0DBrN61SXv12oz7KZXs0DD5ANqji73cGLQn6Hvg+RraOHFZ+CC6A?=
 =?us-ascii?Q?SLD6q159+lnpZjKQt5DAkh1PzbLPR7IG6aKfG3AfntHhTuL6NQP28iqP22j/?=
 =?us-ascii?Q?Zsy9fcaTjchf4wIdcPdz1RyHkh+34pSIX8FAcXmsLxf+axgG+q+iXxki89dC?=
 =?us-ascii?Q?ZY1FgBy/ydgmx6zScDsMBnAZ4h/Nd1F7ybogHAWFPwkk+QPaXTgt+y+R2Hf8?=
 =?us-ascii?Q?FORjfWIh+offcB4qPCWq+dR6pqht+W3swACEjkg/Rq/J/e15KPPhVKKm7JN4?=
 =?us-ascii?Q?qr+k0jCYLyHKjeQ7xDzVpF/fLvx9DS2eOpM0HiUIKvb1W+NABGn9q0093+3M?=
 =?us-ascii?Q?X8Kf73R50NiaYs9KfoiLZpZILwkLlYyED3FzpAXtUcsEMdnMzFm9H7GJXtux?=
 =?us-ascii?Q?Cufv5B8zeOpnehPxazGdFMCTs0v+YeQScYkmf/BecnJRViqHp/j9xK5n4D8N?=
 =?us-ascii?Q?6XJndvwcItjWFEPQWZYIbISg9l5A+bjQUkGNoRkgyLvWAgHBuBrsagQD6RnL?=
 =?us-ascii?Q?bYc6V1gxt/MRmYY3v8SDtY088jjIyqponqX7IddQNMGxFlGUnomLjPwOj5tG?=
 =?us-ascii?Q?K9rySvb0LpCE21AWT2QAz356oHP60yeIG/LQpD3fqhu89NP+yWnwEAAivt0x?=
 =?us-ascii?Q?TBdXbyD2OUF7QccTqyQA9FBZVcMOAPpGsytquY/elks7bMCIfW7wlSGdp5Wu?=
 =?us-ascii?Q?V0sRV1if7wcybqNhf3jZxIohna0DGZG68jjRdhoNevui7QSQKOwSb7FC/qL2?=
 =?us-ascii?Q?DnzG7NkA2WZ5W9Bx49/9+b+p0rBtvY/M03TETQroSd7cXF8y402wPAEaVZBJ?=
 =?us-ascii?Q?zA6PVWY4F/cGpTH6zF8sJAAaFOhLQBa7Kb8HTPWEEdSL1o6V3F20pgWNF+4d?=
 =?us-ascii?Q?39+5J1u3uiT1WgQFZVI3zLjQPeFoerEU22LOq6xml9QcJyd4hRAJhslgxQKH?=
 =?us-ascii?Q?+K911xMnnN6j06psOmZ6xCv0sO62gcmGF4m//BcN2UeFyexu2zBWu7MBom9q?=
 =?us-ascii?Q?1DtRqxlu+BC2JlndoNnd+BzMU3yiTSD4DdnrzDRzuoObbUB3deOV0k8eGJ7X?=
 =?us-ascii?Q?lXmXp3cLsG40f3XnHRo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c55239c1-517c-4d0f-1e09-08dc326af220
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 23:23:28.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+qAZ/FsAt2xdxZ6wT2oyMBHfok9R+festB+1ugyqHo8fVgpo/hl0lXaugatY4ibuCRSNHYMhyu0wHAUnsjJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

> Subject: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
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

Please still keep nxp internal tree and add an entry for the extra external=
 list.

Regards,
Peng.

>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>=20
> Shawn, can you please pick this up via your tree?
>=20
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..3db382dc8f7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
>  M:	Sascha Hauer <s.hauer@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  R:	Fabio Estevam <festevam@gmail.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +R:	NXP Linux Team <imx@lists.linux.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> @@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Shenwei Wang <shenwei.wang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +R:	NXP Linux Team <imx@lists.linux.dev>
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
> +R:	NXP Linux Team <imx@lists.linux.dev>
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


