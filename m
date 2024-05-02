Return-Path: <linux-kernel+bounces-166410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13548B9A46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58211C2140F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0A7580A;
	Thu,  2 May 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SszB80WY"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FF664DB;
	Thu,  2 May 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650761; cv=fail; b=UvJrKB2txrA+d/fgJYSpoubG5TUP+IexlWLAKT3a9AQiZKyS+t6YyjwrpeTBx/l5QSB95QuW6Et/uCAqvr+zpcSyfiQua7lqRTKrFKH9CYre4Tppyc9520lRw9jB8iPYYsbjcjqtunSoLMgjLa3GzuwB8cMC3aeJZ9vD2umeh0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650761; c=relaxed/simple;
	bh=IvViEkYMYsrX6BIxX0yAsUrEoy+wiRZto3ExLFkUqqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gncIBB8ePVQAoUlJqI5tCYrtJPf+77o0tEN4cEsKFJCTXaCx+YBzub3Bm6Q2wf5c9Aw7FlknmQd2qsUHy2Kss2NwR6aX1ZqlKaUdagt0mS6XZyUc35/CU1XOZO1v2U7VWpJmrb3afUxzqdvwmeCdltVWZy43o/EomgIxPgCtimw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SszB80WY; arc=fail smtp.client-ip=40.107.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amkq2WvQu1QnHu0iqYK8uFbi9ZQL4oRc9+xfb4teV1gVSCP9xohbP+SJ/EOMff+wnRK/WS3FDcMKThMhzsQD+enz8o4yaharEp6dJmnW5s7I1XRgXQsol/FQ5ebk9YzlMiGeTGtETLnqlS4dnj3HheXTu7ykLQJ79X9cid8DogphcfeWe4SAV5aHB6JJt05tkfw8QCfRLFyxtSNmZnGsj6GhWxUcg2IatrkQNal8jG/Cd8hYSoyIhCF2xRwY3/itmHGrxZ/HXQe6/hbtTzp3lfl7dv8N0eFgbf2EnDWKbjFbnFuyjo6JTwWucprxvwHryHpYTqv7HRQ8VEPN2nS0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3PHUy5vECVwJTbA3EeCiSpXPl8wW/Q54i9MRc1d76M=;
 b=bt/2X80w96VGiwheYWd+8dVrjTjXptr1VymkvoqbKu1vAw8SUiAe1KenigSowq/zBJlPG/hH9bm16OjbMXwAkZ9dWmu7bBIQaAmK+djg5MDH4zVykVeHVnQLjz/oAbwmUDCIrzxRwQh/1zpypVu472/7gKXPtF64Mlz0JUiY+dNIaRUACpKyOtiwXF5gvCNtAyaj/g6E5BywuypSp1LFq8+znJc7rmKsDCvvWTQ/qnDvAlbaa/Bnvdz6q/rwi36D4MMp5g5DwSU4vVhYWJ6r0nl+aNGTEKWKlBj/YEItAhfhkaVoBFfruUPS6jwE7GYro0t0FocZmanR7f4balj+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3PHUy5vECVwJTbA3EeCiSpXPl8wW/Q54i9MRc1d76M=;
 b=SszB80WYZhK+UgxTwpiL4kAN9Zpiw/xbhvlF/o8isdnDhYz0TVvj2R5FOewd4ZKs1beZtLDkIc3gQlbkK+v6j2/+iYpFmZ/4A9+KMACTIFe83rKgz0kYS4IXFtg/YPm0Kc4Ensfjn1BOFEALUHb/0q8gwFwspNTD5nk4NwXclho=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.39; Thu, 2 May
 2024 11:52:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 11:52:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Hal Feng
	<hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
	"soc@kernel.org" <soc@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Stuebner
	<heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aisheng Dong <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>, "Ghennadi Procopciuc (OSS)"
	<ghennadi.procopciuc@oss.nxp.com>, Sean Wang <sean.wang@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH 20/21] pinctrl: aspeed: g5: Use scope based of_node_put()
 cleanups
Thread-Topic: [PATCH 20/21] pinctrl: aspeed: g5: Use scope based of_node_put()
 cleanups
Thread-Index: AQHam8aaaSsA7ukUMEKRJbR3/u/LvLGDHuAAgAC3pIA=
Date: Thu, 2 May 2024 11:52:35 +0000
Message-ID:
 <DU0PR04MB9417870C10E47E1AF8557ECD88182@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
	 <20240501-pinctrl-cleanup-v1-20-797ceca46e5c@nxp.com>
 <eda5b1da03d4adfa5761c49527a9232ec7facae3.camel@codeconstruct.com.au>
In-Reply-To:
 <eda5b1da03d4adfa5761c49527a9232ec7facae3.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8431:EE_
x-ms-office365-filtering-correlation-id: 2f5bda49-263b-41d0-4907-08dc6a9e5b87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?En67lJh5OpmXGA0+qkvw/pUmZyYDav18gPEdojMdTFCCRoPg7jJbAGXsqE1d?=
 =?us-ascii?Q?lUJdr15c3v1kma7D72rfUWfwJ/4mQIwe5HDrGKZ4dAOgC9meXQkXAtSepcZg?=
 =?us-ascii?Q?xlyn2onvraEcOEsQ825+OiQ7KtvCvKzK6+g5hfcNZHFdEXZRGzxew3kCYwnR?=
 =?us-ascii?Q?s0nXZ30kFsouLoE75VFkZX5W/qZHVM2ngn22qSUJhZrmDeVR5AipeUS7lro1?=
 =?us-ascii?Q?g6F9y6qSf0Srm+aZ50bZbwZ+Gg6RpgBGDMwzQnEbIQWnWL8xlWn439W/CEK5?=
 =?us-ascii?Q?Xs5IrLXdEDrHX3UwDsDGWP/ezDdsMlQtA4ZRS2eEnRji9H2LBqTBSaRG0Z1k?=
 =?us-ascii?Q?/w3AVZG4+brm2Ix5sAXrgl+e1suwMEBnfxOcYlg0Bb0Eig2gVtL0tB7cfJld?=
 =?us-ascii?Q?mzzQSUlTN7h5CblRlGS+BhZZ9bzUtJbXlZDvnVtGbt49JWIKEdF2HIn+dm0R?=
 =?us-ascii?Q?Kcbhos3Ho20Opac25GHkywDqcbzLKq/BqXKCCheCx2MRGyIEKr4frEg23jpn?=
 =?us-ascii?Q?ZbHTkzOEJvVcCpED5rSJjUOPZcg54KEFqK2OO3zgZ4J4arq0HEO/ZIxwdUyX?=
 =?us-ascii?Q?z3gjGC5EWmIe4M3FZyyYgxzkNxBnsSYhGumqpqpHLcDPAX5nOWKogQ7tyYeM?=
 =?us-ascii?Q?yzDPrLpjOqb8Fl5XANXoLa1hUQVmuFAGp4DWZk8U7SgWCioKGQDkKMAqD89Q?=
 =?us-ascii?Q?E3U3EBuKEQT1jWHc9a0u2K1OkbY/OgcehxN2Gyu7dcEC9nMwxzGaO9r3eQQJ?=
 =?us-ascii?Q?vko3tTZ98gcvSiv1Ilej61ptc25/vPPLyJ9EeKwCV9CCPwtrpbYi4hokD9p8?=
 =?us-ascii?Q?qUYcxL4UQJG9HZoGm6LqghOk8cfhlPORzUwQNdZUllZ2xifHmh/O0QxHwzz6?=
 =?us-ascii?Q?2tBJxJOedVGOFa6pfHcJ4bA0V4tGcOyPM96Zq7Ubx/fMhMiwhkPxXhV9cbCU?=
 =?us-ascii?Q?ym8n0jat5deQQk2RS8BGYF0WBhFacMIz8IBsnWMn4GECzTjcH0OiquZMxksp?=
 =?us-ascii?Q?EYGmoJW5Lf76fZMmRopM/nPUYb8gDFG3+1oS2uuV4ZJZt/ymzce9rFIHAQGu?=
 =?us-ascii?Q?nyoNEiHdcprjMk8c2Er4a2Uz9O+4a49rY4TzGocjPaGFyjF2WBGADAiAuGlw?=
 =?us-ascii?Q?TPUUjcXrmJ7IiwAh7H4U2nG6mFXEy1REXCKxpV+KXG8/PvLpDdGolxxLdeLv?=
 =?us-ascii?Q?TqJbmNsfTwSdSzoPUidPWbguH6TkMO0l+xI3n5QB0t2haIDkgusbg10aTnZv?=
 =?us-ascii?Q?M2+jg3ZZ50duP8JUg1ia+BcNdAU43cEO8oYdgoTWY+dGOJGtBUhxgdmJf7vg?=
 =?us-ascii?Q?ikY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bc5jUGsgYHqzOvX+49kv1vg8rkGxOqmxB19PbkLxadanRzcC4hyxC81OQzJA?=
 =?us-ascii?Q?uImQSJvjYauT9dWSJ49e7zG76oDLPhHGbfo3cPzY08RtQ7aBYh8vHzMLbImd?=
 =?us-ascii?Q?X476mh3XTky/N8WZMW8MGVx2Hbs2hoovM7DkVrvA4z+u1LYMxShcYlMVg4Au?=
 =?us-ascii?Q?FG7JtKVJyU2ZxMPoTwZHhxeOM7s/FWyqzxXNyBxWNNe8NsTIbanSpYEwuQyD?=
 =?us-ascii?Q?OLAfgYqz5N1PMs9+x4D8+OYSQpb6+5n+OaReIufJl2SLT7XrrFP6trYxe6Fb?=
 =?us-ascii?Q?aA1FASzHDXowbzrMaJf10vFepK2Gas6YK4lAgYzjrRGWRk3r2hBsHvVdMcMF?=
 =?us-ascii?Q?fG038CoxkgxU8eTqZwNMaasd9FVqH6wb9o28ZL3iIjE8tftRPTyndGMguFDv?=
 =?us-ascii?Q?bLSV3n3SU5IuSGAvRMvBRzMlEpK4NGCjRtSm235hrwHHSSpHHieZJvwUIPYj?=
 =?us-ascii?Q?Aae/2TA1PaipQgCEKCujF75CFEdmrf/tQbYXEGHaVeCjlfd8i4A/++VLzZBp?=
 =?us-ascii?Q?sP69CX9E+B/EA33+33l1RynEAjQPzwxmOAuQP1u7pEh9UDoqkrA6EUPNCFB6?=
 =?us-ascii?Q?ZfunHuJdBH8D7UNGWwtvb60cPAEGYC835qiHpoDKo9lWgkns08ewycKtxvNS?=
 =?us-ascii?Q?lII6aFfmqjSHTjc4uvGPPXOk7tFpTKHZyr2R5tvvG0O0miBcZgOy9GEHYpAp?=
 =?us-ascii?Q?MSE/ry1PDN3lcCvifLRjye7cEOkPjypYq+MJH9Nrbb5fFyGfQHRPDhuOaMQM?=
 =?us-ascii?Q?iDCbeBKztne7LVXW4HAuiiNWVC54QLJVsk71xIl5U3/8q92OziQJdvOHplwB?=
 =?us-ascii?Q?ZBArbj2C/yh/nuTwSixJUN/kPEZmHnIBZLOUM3vH8GcOn7b3wbUCje8zSKx0?=
 =?us-ascii?Q?0HYhWd1eoDQwpkZmlJ8pLdZBRayrP3FDIkTEmTZVrDDgPawYgLHqfcJ4ANpr?=
 =?us-ascii?Q?w+ty81gFHx5DkLwi15SAVmVJ7d+oLD/b3apTpVsUD9nYdfM7Zt49KOOhVJ/O?=
 =?us-ascii?Q?s+cMEr8pGxzMOEvAqzxtU7LE87I7kvo9Xg1zmbNGrbckcoAO7bTyhH8f8BRX?=
 =?us-ascii?Q?rOGKf8Kl2VbBpJrc5vBZyjUu6aTlPuTjvbUNA74LRMPnTcIB1cBs9LlZzYQK?=
 =?us-ascii?Q?7mBmSalX0XW8G9AzZFQDj8+UyxQn5Jt32vlgbv88yL7QsiGaA8gD1fRpaaxK?=
 =?us-ascii?Q?L7wepYAzDaxnqHFj5jVWmUfGHAFuD1mwm8YrGm68OXz/r3rQ2pTSEteB2MYI?=
 =?us-ascii?Q?vwkAfTNV7GWDMMaQ6W7eH3m477jmVxe+kotSwQuVtBD867UbehPZC9MUTqDz?=
 =?us-ascii?Q?PzKWN+HdX54Hc674QVdEaBYOaYZ48TvydoD8cA9flM8d5E5B4p63/ChMLLp2?=
 =?us-ascii?Q?DCfZ2ZIptoD8TLXWRIaKtNeR+nnCsKtPOEr9afosVgCAFxC0PVroBcUJu9wo?=
 =?us-ascii?Q?zUxTG4lBb16Qz4Lb6cw6DxoQe7CEY6jMvCRRd4dt4LNIujGXNuNRxPAKpYGu?=
 =?us-ascii?Q?xo713XexTSR/P5c33sNiL9rp5a++XYj8jgKNb2LFn99HqSvE9ojYTNZSPpcq?=
 =?us-ascii?Q?RHZ6yXiNJrAM+Gupl8c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5bda49-263b-41d0-4907-08dc6a9e5b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 11:52:35.2518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2ftlX9BDVLp0UwX6Z6D0XfhGfpFPf+aQRsjHzlhDpcxVKPCMIZpR6rEx5g577LBG62VsxhF59Y+gj+QBvuicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

> Subject: Re: [PATCH 20/21] pinctrl: aspeed: g5: Use scope based
> of_node_put() cleanups
>
> On Wed, 2024-05-01 at 20:56 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use scope based of_node_put() cleanup to simplify code.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> > b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> > index 5bb8fd0d1e41..61fbfddb5938 100644
> > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> > @@ -2629,14 +2629,13 @@ static struct regmap
> *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
> >             return ctx->maps[ip];
> >
> >     if (ip =3D=3D ASPEED_IP_GFX) {
> > -           struct device_node *node;
> > +           struct device_node *node __free(device_node) =3D NULL;
> >             struct regmap *map;
> >
> >             node =3D of_parse_phandle(ctx->dev->of_node,
> >                                     "aspeed,external-nodes", 0);
> >             if (node) {
> >                     map =3D syscon_node_to_regmap(node);
> > -                   of_node_put(node);
> >                     if (IS_ERR(map))
> >                             return map;
> >             } else
> > @@ -2648,7 +2647,7 @@ static struct regmap
> *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
> >     }
> >
> >     if (ip =3D=3D ASPEED_IP_LPC) {
> > -           struct device_node *np;
> > +           struct device_node *np __free(device_node) =3D NULL;
> >             struct regmap *map;
> >
> >             np =3D of_parse_phandle(ctx->dev->of_node,
> > @@ -2660,7 +2659,6 @@ static struct regmap
> *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
> >                             return ERR_PTR(-ENODEV);
> >
> >                     map =3D syscon_node_to_regmap(np->parent);
> > -                   of_node_put(np);
> >                     if (IS_ERR(map))
> >                             return map;
>
> I think I agree with Krzysztof's feedback on the Samsung patch[1], and th=
at I
> prefer the existing approach for the Aspeed driver. My reasoning suggests=
 the
> existing implementation does the right thing. That said, the code could b=
e
> adjusted to use early returns and consistent variable names, which might
> make it easier to reason about.

No problem, let's keep the code as it is.

Thanks,
Peng

I'll consider a follow-up patch to address that.
>
> Regardless, thanks for taking the time to explore the cleanup.
>
> Andrew
>
> [1]:
> https://lore.ke/
> rnel.org%2Flkml%2F34193501-5b7b-4ffd-8549-
> a04c6930d02d%40kernel.org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com
> %7C44ef77e479264eccd73f08dc6a4263c6%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638502080600849943%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C0%7C%7C%7C&sdata=3DtuUu1IeqM5sQjqiN1fwzPAbSoZw%2FUNEd2
> u%2BzpaBhJ4M%3D&reserved=3D0
>
> >             } else
> >


