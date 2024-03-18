Return-Path: <linux-kernel+bounces-106798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F382A87F3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99BE2830CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A95DF2A;
	Mon, 18 Mar 2024 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p1Z0Mh9e"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2095.outbound.protection.outlook.com [40.107.105.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2F5D918;
	Mon, 18 Mar 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803815; cv=fail; b=LuppwTUBwvETfN/qmdVt64VPk/XDbQab5t6j/Ia/Ui80MTv06MPgAH6kecwcWGrZq9L4wyOxF/xzcjOa6hUogFHe1tXGvDZq5Hl/KJyCga3hJ3qckmfDRnu7c1UBS7KB1mOhPIZdr8EnmRbw3edRE6OV3LoV36lTg/ov8ZjreCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803815; c=relaxed/simple;
	bh=Xr0jH/u0TZk/IZa3AF2DGD0ucwgcar3AGSTW4n0r+zU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kv5G/ta+Y+DbNztgP6rkQj0iCSJcXoVyEzqBY3ksQNbR5nP+/3dHbczuo0/EpMfBkuonrKmYbUY2IJD0cPZsizjMxUk9ijDCAann7fyfe6T5009CHeEdJPnw1LL0seW4Sj4YvTjjtxNen3/k2uOANsmRnI0lhPYLvfe2ihN4IQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p1Z0Mh9e; arc=fail smtp.client-ip=40.107.105.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVsQjdjyVYBHh2FvcoCthIT5aTcVLnK3rhbB4faQj19A08ElNCvwTQSpg+5Ob+3M0h2QzzvWrrfDlwHCqYLqeWq3m48AFFs6Ngvfu5F/n3ZwlZ1rsL+yg5UZPGCTCfT/lvonYnXuNsGd+LAVy45sqgAOAGVwOcfAO5FPy+b3ow+XWisDQ1MRnqpkY8fOGvp/ByMr1ljoA5jkd2RtoqEJTBzPtLkbKZpm2b2qt+ebl0oXeU3luxQ+A5PoaE0HD1csLuqWwGPRdahKsTTbbo7iG2KL6+QeqwNrcVqK4U5wze7KTsPbSa+dr08mNPrhIjsAEVSbIjNaVYsPtSIzT5x5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3sE8u59A1NjiewBmFkwYkBBG8sHBiVCetPv0GDlgc8=;
 b=h43n6crjrLy36igPxXRybTNEs5qEMiQEXCasiTriNb+A121l8SekVhQk95JHdfzsL+YaGY29BB4vCwBuJsPsMFbdTfrD7kx4DSSCUVXlKVKiQJnNR4HrfIIPrtY5BaFL722OghitV8trAquMoEk3FRTIcsEFB+5cg/SEE566WFSnss0NZL3Zb4c31giUgagfggos23k3mUjvBiyBgSqGCG2xOycVNP4h4iQIF2R21pDa5KYS2yEB7GYn/g6ICx+3u3x1KOHulHwgy70Jl40asB9L44tTNCdS6CB57zs1j1kMri/fdNOKANMYuzhFXvSD5gg6j7pEQiPo8zobfaJ/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3sE8u59A1NjiewBmFkwYkBBG8sHBiVCetPv0GDlgc8=;
 b=p1Z0Mh9eUY1FJzl+91Q+CsJcSZ1xomVbiM/7eiBNcT29eBFA5Pr2Ou2i1op4jSB8gALrAgUbIxyzjH02ZAdKSwqQylgWgOiVyHpKJQHXjDVa9nsZAC8TcUn8rH5bC/0I1zwJqoC1eRqfwiBAkWztGKtGo7xd5QPNvZle/TD+BVk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 23:16:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 23:16:50 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power saving
Thread-Topic: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Thread-Index: AQHaeQD2LJT94i1NhEORr0hu4k8XbrE+Ip3w
Date: Mon, 18 Mar 2024 23:16:50 +0000
Message-ID:
 <DU0PR04MB941745611C0FE10E847C4B25882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1710743811-1698-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1710743811-1698-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8129:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XFPkp5JEwaPaXoydacjFAhg9cDSDAGRXcqKv6dSTZrRJAQ9UFxXY1hCaKs8vkwd/6qksY6PkVNuXyytJUhyLCp734ulfO27/QXpZ9e2DOoEn2llz/LZksCkarSTlf7lpOxpwHGbzSrH8oJ2r2DJsIz040LkTVEzGxbrB9Z6TfMM/wG8YhP7WPP9L9zvhwG1Xmh3LSjyuhPOeWLau0WSKyYOO3WRPHO3d1irfJeOyD5Fi6LVV3+E9U0HBe85UHI1WQf3g3yuUkfNduReZT+0cEsOTh/gDr0v/vnzvX1crbk2KyzeiBogutp7gtd8JgULj5rXn66giiIp0WSHDwFLU1H58FEGyyf0OHPLlEbrHfwc0Fi36jJR56H3i/uYdxM5oMUN+BGTUzVH1+Zech4MjcmHlNjCMZ+V7VD1b0YBYlXSgzaisYNMN68jAgmFnNlBGX5nVtGIgZ2M2cOlq9cJlZ5BXDzGiAOLZNFxfAJbQo3+ZQ1Y6ro9uxLLenXnJYWbvfT4qzUAhXp00dcTZi2+LiSWDHGJGBvfnV+MYvkyoyw9u/djYzmN8DG8L2sQmhGy3gy6geTqc8AzwkusuC45JAuHk8J5TO69VItj5Lr7cNE8bPvNZOCzKn3sdZngSx+qkUBUemz1a0Fq2o9XolS++B78Fc8T/vKhm4XDkCTgRblloS57ueNMquO6y9y02KQ2dGXLHkW3Buc3LY+fmNv4KiQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TFy98a5BZo+VK9MXl+93MW6EerGVfkPZqSVZ8q5HWSmr9sR+Sp15kBnzG/JV?=
 =?us-ascii?Q?rY9KSJ1iuGP/+fdqVlmyGLMjQ1/Z3xmOfLJqXXaJjGPmiw8e2o/uIiW4NHkB?=
 =?us-ascii?Q?sXQNhNOgPSHKtKBy1AUSoM6ffimIRxhpgeYMkh9BbBuJQel/qHaqSWVXfN4w?=
 =?us-ascii?Q?aRVLPizFNNKQlu7yRPj3nxjcGaGmXBo1QwJwrqopucspSYaHxltahc1nTmz9?=
 =?us-ascii?Q?OjRUK08ESqnnVRoNRjFn7JBLn+EgiOkOS1QLYjJpVmvPFMygWAVNOALW4Azo?=
 =?us-ascii?Q?/cgIgdH4dbnOx87zsKZOaUtW4coZ28K0SrLMCfJ5EllHHoRJ00h+kOGnrwLQ?=
 =?us-ascii?Q?HlpY6I4VnC1SDDFeVsrHGfhh897FFyJdvTSgC5MrvLGv0lz7uTHeeLHYb1A4?=
 =?us-ascii?Q?Y7snAayyPmjN5I+sI0P/7ANhilOOa2DwufKzt3jRaR6qDM0cZBvF691apzeC?=
 =?us-ascii?Q?rpKYKJqjFzQBsh84hgNGNGEvxDHSfx2glxcLo5HBdsYN3EgFpLrQbwNm0Vij?=
 =?us-ascii?Q?vKFB/hJ4Uji1ofNa0vi2uzmqAjD7caJ7dCQT04BgZs6b3p7qqLgX3+Uj1lHO?=
 =?us-ascii?Q?Zmq4BdGoEtEbnHpcmb5yGc5GjPYsVX6TmaSOInkFZlCZBI2jS7RZ67sJP9Wt?=
 =?us-ascii?Q?nlULsqWMpCl6MKjWvFWRsdlr17tsjvQJd35lKTpZzOMMFztTRY7Ww+NFLa22?=
 =?us-ascii?Q?haqReCpnipuhu2IFy+ui/YGu1vYAxdvKfEat4PTecW93EPvWLD3L2ELXoGEb?=
 =?us-ascii?Q?QvxReSiZeL29xbR8wRg7mVtN+8WQlepfqh/PiVYr8X4zoheCNyMwxLloIldA?=
 =?us-ascii?Q?YFIAplypHneVTAUgSANxCKtbXxYuvGxBYzMn4X37Mr3yGBPd0AwavxLD+WEZ?=
 =?us-ascii?Q?ZxQi+1bKLPUqrabJvSVOdniH4T4ZXhZzUXx4mtaGHGirRoHj4zN8B/Gfukh2?=
 =?us-ascii?Q?Mjl+pEubXNHGZzoDNy/byw0/QOQXXocV/B4SWuAnkDfgjw0LIaNVHDJEoxKw?=
 =?us-ascii?Q?wYlbhachNXrndDcvlcXmH5CDOoB2wPI7M9+OxKxZBWmaiWorBYqReAXcOY53?=
 =?us-ascii?Q?pT9LMU8vGdY2r4NsBG8etrNs+OXDRis2rxOW3L/fMaKZ2K1UTnvkvTDDB+kR?=
 =?us-ascii?Q?VtZR+F5rW71GP7F6+3fy/U7de85PqmZ/6fJazuXA80W5+7He+2kFVJBNWHya?=
 =?us-ascii?Q?oxkoXHzOE2FrN9NV1KKtMpp168rdsChEvOP1iXJwRMww/lnZFt214TfdW9qJ?=
 =?us-ascii?Q?uT69P4tgccPPp61/MZYtXjJQ7ZOhft/Zp7BDUrQbDqchAnZxxPrYOpQDd11E?=
 =?us-ascii?Q?YkpZWhKQa0Pha4TM8UEWHx6qPbSzHvx4W1EmG4P1PBZ7uIUYCpwRvrTpXC8S?=
 =?us-ascii?Q?MVHfuoewVRdBQsuyunaNL/+E4EGK1zNJOjIIRbUIOrdc95h5QK3yvK8x5i/s?=
 =?us-ascii?Q?ylSUo/0B0gpxViw3AnvW45j+fmh8HWtsPyDvSWvy1ravsYlEVxYLbKeIY2My?=
 =?us-ascii?Q?Xvvy4Xeo67Vgo15XhqFyOgj5W/wSPIpz7sohg2vURoJD6tCfbc9LYAlNLxs+?=
 =?us-ascii?Q?N05QwccWAyLjL+2mZqo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2815800f-d244-4e97-2c5c-08dc47a17dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 23:16:50.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTTV0nKfUufTusi67lypYpuwx7ByssFFtkfPFRRRZXkv6313/Jw9+8g0+pjgfVP4IPcA4p9ITjNJUG1TSVjlIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129

> Subject: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power
> saving
>=20
> Add pm_runtime support for power saving. In pm runtime suspend state the
> registers will be reseted, so add registers save in pm runtime suspend an=
d
> restore them in pm runtime resume.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 99 ++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-
> imx8mp-audiomix.c
> index 55ed211a5e0b..d2bf53e2aacf 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -7,10 +7,12 @@
>=20
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>=20
>  #include <dt-bindings/clock/imx8mp-clock.h>
>=20
> @@ -18,6 +20,7 @@
>=20
>  #define CLKEN0			0x000
>  #define CLKEN1			0x004
> +#define EARC			0x200
>  #define SAI1_MCLK_SEL		0x300
>  #define SAI2_MCLK_SEL		0x304
>  #define SAI3_MCLK_SEL		0x308
> @@ -26,6 +29,12 @@
>  #define SAI7_MCLK_SEL		0x314
>  #define PDM_SEL			0x318
>  #define SAI_PLL_GNRL_CTL	0x400
> +#define SAI_PLL_FDIVL_CTL0	0x404
> +#define SAI_PLL_FDIVL_CTL1	0x408
> +#define SAI_PLL_SSCG_CTL	0x40C
> +#define SAI_PLL_MNIT_CTL	0x410
> +#define IPG_LP_CTRL		0x504
> +#define REGS_NUM		16
>=20
>  #define SAIn_MCLK1_PARENT(n)						\
>  static const struct clk_parent_data					\
> @@ -182,13 +191,65 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D {
>  	CLK_SAIn(7)
>  };
>=20
> +struct clk_imx8mp_audiomix_regs {
> +	u32 regs_num;
> +	u32 regs_off[];
> +};
> +
> +static const struct clk_imx8mp_audiomix_regs audiomix_regs =3D {
> +	.regs_num =3D REGS_NUM,
> +	.regs_off =3D {
> +		CLKEN0,
> +		CLKEN1,
> +		EARC,
> +		SAI1_MCLK_SEL,
> +		SAI2_MCLK_SEL,
> +		SAI3_MCLK_SEL,
> +		SAI5_MCLK_SEL,
> +		SAI6_MCLK_SEL,
> +		SAI7_MCLK_SEL,
> +		PDM_SEL,
> +		SAI_PLL_GNRL_CTL,
> +		SAI_PLL_FDIVL_CTL0,
> +		SAI_PLL_FDIVL_CTL1,
> +		SAI_PLL_SSCG_CTL,
> +		SAI_PLL_MNIT_CTL,
> +		IPG_LP_CTRL
> +	},
> +};
> +
> +struct clk_imx8mp_audiomix_drvdata {
> +	void __iomem *base;
> +	u32 regs_save[REGS_NUM];
> +};
> +
> +static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool
> +save) {
> +	struct clk_imx8mp_audiomix_drvdata *drvdata =3D
> dev_get_drvdata(dev);
> +	void __iomem *base =3D drvdata->base;
> +	int i;
> +
> +	if (save) {
> +		for (i =3D 0; i < audiomix_regs.regs_num; i++)
> +			drvdata->regs_save[i] =3D readl(base +
> audiomix_regs.regs_off[i]);
> +	} else {
> +		for (i =3D 0; i < audiomix_regs.regs_num; i++)
> +			writel(drvdata->regs_save[i], base +
> audiomix_regs.regs_off[i]);
> +	}
> +}
> +
>  static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)  {
> +	struct clk_imx8mp_audiomix_drvdata *drvdata;
>  	struct clk_hw_onecell_data *priv;
>  	struct device *dev =3D &pdev->dev;
>  	void __iomem *base;
>  	struct clk_hw *hw;
> -	int i;
> +	int i, ret;
> +
> +	drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
>=20
>  	priv =3D devm_kzalloc(dev,
>  			    struct_size(priv, hws,
> IMX8MP_CLK_AUDIOMIX_END), @@ -202,6 +263,9 @@ static int
> clk_imx8mp_audiomix_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>=20
> +	drvdata->base =3D base;
> +	dev_set_drvdata(dev, drvdata);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(sels); i++) {
>  		if (sels[i].num_parents =3D=3D 1) {
>  			hw =3D devm_clk_hw_register_gate_parent_data(dev,
> @@ -257,10 +321,38 @@ static int clk_imx8mp_audiomix_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(hw))
>  		return PTR_ERR(hw);
>=20
> -	return devm_of_clk_add_hw_provider(&pdev->dev,
> of_clk_hw_onecell_get,
> -					   priv);
> +	ret =3D devm_of_clk_add_hw_provider(&pdev->dev,
> of_clk_hw_onecell_get,
> +					  priv);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	clk_imx8mp_audiomix_save_restore(&pdev->dev, true);
> +
> +	return 0;
>  }
>=20
> +static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev) {
> +	clk_imx8mp_audiomix_save_restore(dev, true);
> +
> +	return 0;
> +}
> +
> +static int clk_imx8mp_audiomix_runtime_resume(struct device *dev) {
> +	clk_imx8mp_audiomix_save_restore(dev, false);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
> +			   clk_imx8mp_audiomix_runtime_resume, NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
> +};
> +
>  static const struct of_device_id clk_imx8mp_audiomix_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx8mp-audio-blk-ctrl" },
>  	{ /* sentinel */ }
> @@ -272,6 +364,7 @@ static struct platform_driver
> clk_imx8mp_audiomix_driver =3D {
>  	.driver =3D {
>  		.name =3D "imx8mp-audio-blk-ctrl",
>  		.of_match_table =3D clk_imx8mp_audiomix_of_match,
> +		.pm =3D &clk_imx8mp_audiomix_pm_ops,
>  	},
>  };
>=20
> --
> 2.34.1


