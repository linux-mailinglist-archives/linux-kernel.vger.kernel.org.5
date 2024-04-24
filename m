Return-Path: <linux-kernel+bounces-156741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F18B0782
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A27F1C22051
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B031159585;
	Wed, 24 Apr 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PWKLsoKz"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E8158D79;
	Wed, 24 Apr 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955241; cv=fail; b=ksSWCn9s2htfyEprj0OZ0RpqBsBYbZEuobAELLs8HoVulVajQtckuP8hMGlhGW8VllW3MKZJRDr+xchqlB8AUSzHvs1PRT4LnZ6WxsmKmrWr/9bcPr5YpE3p9omW16rZKTrOWgGt/PXGUsGKbdKX34JifLYHO+SPvKDBtS5jbq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955241; c=relaxed/simple;
	bh=ML1qbnkuFPdktT+QXQmvuA7fIWnFd7ZIWjYF+1I6ZAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcVp3SOSI1AqS3YBthKpS8f+PXZ02vup4GzV71G26JSLotr/ENl/uDh64ybE4kOfh1c//GtE8+JPg0qk05/eKBlNPlEX+OeW+IHBtQRS263W9tM3A8e1NolMLCwReanFfbCQ7Jo9AbPO8UIgZ4qSzkXZd5p+nqvV1gr30+fafCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PWKLsoKz; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUdshx4B0aGYMcz/6MnRgevaSsKPZQoC/mNBeRhZ6Sts3APRtndtpu2baQlhNdc5MHrWBq/+uT3owFa6D7SdUQZKfhrjH9e+S6B/H2NfQGlQsL+gNn1VhzPRqI72I0eptH9j7Rnzfjze+u5H/PhuiU6J726xa/lhOXDaca+A8vBKJLFYppb89p7e/TEFi08gUYbR5/Jj4BUFRqhrirNxbjsCxyZTEFb+YMnGM9D3l1UzC1xnkMZujubNEE299VtN3dNojB+aAoHkqPK8eAE2HgS/Xv8AP2YXEQiXuf5fnSoi4hLaa5j84G+JY6z37rEm15QsmEKFcb3vvZvS9KQsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIh1oHlJrWApgSPqf0tBwCaEILLf7qRJugcNLaHO0Ss=;
 b=OZUK4RFXSC1QYkqRP+Syy9g8ojF80d3TT4/rC4vx/jDTTj/QhLS87pVKx8PHVbdKHJw9S1YKcF+4IT53PqbLFhuQ+Zwqsd9g1NZQvHI8MVL1L/7KDUyCit4onvXrR4TJYy/JcI8mPxHmPRfk/Kk6N4heoSOQlvn4bLPMpQKQKaWb6TTPc3qxhqyD22jqKEutwIuV8kVFPsQwSnRnPIeWULNaTqD6NfpJ9dl7YPAjFwiM1lZOmOBe3g1pSqO8zCkRnRd1lwXDcPqQugJVpAFpk0DteatHjroI1J2rwbgnGGMAGNeRe1+lW1+He+O3m8+gEEM8EZOZGfThJddNp7R+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIh1oHlJrWApgSPqf0tBwCaEILLf7qRJugcNLaHO0Ss=;
 b=PWKLsoKz0yld+26YLPinLTFb09FpLT8zg+iPs9nZlvjIJoJHJLuVtvrTvUNa3NUPnkAFYzU+h3HgyF9k2t3X6AMfI1sFo4J3vvb25Tb6EdMd5qegaSliVDKoP1VGyAV5aq/6B0Sxy/aDdq7sjD7uvvLPQVRVGdFTbvCryGMVUVQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 10:40:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 10:40:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Aiuto <fabio.aiuto@engicam.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, matteo.lisi <matteo.lisi@engicam.com>, Mirko
 Ardinghi <mirko.ardinghi@engicam.com>
Subject: RE: [PATCH v4 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
Thread-Topic: [PATCH v4 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
Thread-Index: AQHaliMBk1y8nHmWX0uBJChnGhrB3rF3O01Q
Date: Wed, 24 Apr 2024 10:40:34 +0000
Message-ID:
 <DU0PR04MB941752F89618BF68ABF1908F88102@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240424083607.11162-1-fabio.aiuto@engicam.com>
 <20240424083607.11162-4-fabio.aiuto@engicam.com>
In-Reply-To: <20240424083607.11162-4-fabio.aiuto@engicam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8252:EE_
x-ms-office365-filtering-correlation-id: 89319549-dcc6-449a-3c7d-08dc644af8a9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ss9OAT5ky8xP0mcw6eiMvo4jQeng60Jtj8jny8cDtyUAQd+3cEv81kBVGdJR?=
 =?us-ascii?Q?qYhAr4Nro//1wX5mI/IAhp8Tl0gIc16IGQxDjGWW4nbv1UXpj07mvGBzOGU2?=
 =?us-ascii?Q?W8htbl0AyFur6UDabzCWcrXtEp2pl6PiuLMVORx3HLt3oF1fib5oQ3TVJjRJ?=
 =?us-ascii?Q?QoghyzO0+z7+5HmASDa2BsEroMu1uSPMCAxyln5QCQAdc2FyrJ2UX7yxvBQB?=
 =?us-ascii?Q?A6X/CuMiypJaEheAdAa8Hbnb8rbNeFdV6GPx0kqevMaoEy7YquQwyOsMn68P?=
 =?us-ascii?Q?48wmctEDHXZPMCOiHhIORSDkr/v7iz7MoXW2X/2/GaYe4OjmlitVRZBUpunS?=
 =?us-ascii?Q?6+WsYlFeU//TKhcktMIfIsgBYGSi8iA8Un2ljSH7z28aDpjfKg0CtZWReQzF?=
 =?us-ascii?Q?vAql8BcbmuNoINsCUwoKzEYg93B8cSf4On7dT/oknEzaMq/mv3EBfIFgygxP?=
 =?us-ascii?Q?dgF/NNRjqXzC0seDz+Xq69SNyIyVSEv1uRr1/NFl7e/vVmQLbyPOz/qe+zxZ?=
 =?us-ascii?Q?XAHUfCD00ZA8kGcdbtd2dupt5dettOjTyxI5HfF7+hXkcCflE/5sfTvtjtcm?=
 =?us-ascii?Q?VNFEOlu3XqD76EVvdRqUZpuqm2D3qHvcQOTtLY2kPa9BOdpKhU07329oa9y2?=
 =?us-ascii?Q?bHLwHnTnl6IZEwh9+CQIOU0UEweQwg6iwTswBpQ1MdS5eOCP+d4WqGV1dkRU?=
 =?us-ascii?Q?v2KAqp8bZCQ/X4fT64nyqEdswesU5aQltW9pJYN765qIqj9isxVcyoaYZQDa?=
 =?us-ascii?Q?DpOmEETdFCs5qflcWUx828FQ8EC7IE1CZmskIA8F1W0kEgdBqO32RQaoCXS7?=
 =?us-ascii?Q?+/3gX+87RXvtY58wyNV95AQYlkhFOO5UAcOHWQ14AskmkBsWm5WWDLVcRXuc?=
 =?us-ascii?Q?sVoaxaf5Mllw7o1pYhVfTxEaapi/fAiW8MXnPXKUaHctS7Gn1GOL/98/s/wC?=
 =?us-ascii?Q?kS+VdcWMy8b8a8A03H8Edh982mK4Z2Ew7QC3FvPSBVzISFyp2YVzumloRiGS?=
 =?us-ascii?Q?dhNqEju7Osmtmb35BcK5VL6XXa8E9SpzhZkmhAGt3h/f5nxxjTGtWPCjFODG?=
 =?us-ascii?Q?Gt92z6PNy8zMUHvt4cuoSAN1fvEedh/AEqFtHG8hPPy0YoOUSTOgHIE6riov?=
 =?us-ascii?Q?5JK9CUKvaa5Axvk/C5UMh6tQZVcbxLEvzEPHBFIPeGAOknSR4tgYQ3A4MBjd?=
 =?us-ascii?Q?ReoyzNVaTX8I98R2bcobx6CAK/p/cEjffquhJ8FaoRRqgUrUFN29JChuuKTF?=
 =?us-ascii?Q?L66/f42kOxnz9rYzFBcVridCCPp4eixB5PN8X21W8VZ8RTvSJ0XALCkStDKs?=
 =?us-ascii?Q?w891xWXadZ4MxLsyP/5OQ67oANbRZHFRKaLk7zji8bOQaQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bZFszp6GDBFB/I6DExLw4yVX3MswGJKX9HlgKTrl/NaauXqgc7Ju28uxFHr8?=
 =?us-ascii?Q?qYmmn4fqT3xwa6cUSVCFhCbaK7aNBVjbOazpU+Eb0/AhSGqCwOOixGW6kGUn?=
 =?us-ascii?Q?wxwJU5vBK6A7l+XwnjWAdUj9cyfqBe+eiJ56R6ZWtoTzQUOKg1PC7g0jNEEZ?=
 =?us-ascii?Q?OcdsmZn0S55mcYi7PxOrUY5DzW6SzSEIcGHmlZ+2Or1LPckZX2YCtbr2dr5J?=
 =?us-ascii?Q?C7aUbS6YkPuGEWwAoyNMqloVN3vjJZMBuYyqTV0cD1aayG5dByS0gkzJ9ix4?=
 =?us-ascii?Q?Cg2xg5H19RtnppwbghUvFVe8mO5PXZT8KsXcXkAzVmNF01bczHSnbMvn9QnY?=
 =?us-ascii?Q?f++kNatlib+hU4kWLTY1AQa+rJaRStGN1uf5ZKsLVghV0NuLlVB7svCOIzjO?=
 =?us-ascii?Q?VAdPlJQvoOnCdkYgqgXiU8jUXKorJdwbWOrLhgON3ii1449msoCELvhhY7NB?=
 =?us-ascii?Q?rGs3h6Myq4/7Uozo69PYsNDLdiILyfivNEOh8ifSI+smWMhicQktWMxBWHpa?=
 =?us-ascii?Q?F5PrFqg9PNaJ/HADv9BV2ugWsiRZQ4JyC/o4VOcpYvhK9m0vZGBQS90d3vc8?=
 =?us-ascii?Q?ZDBrW+n4IYwvAtjUfLTxBw9ZCE0/11bAKac971/aCMaKo9Dfn5NsPudQ0f/M?=
 =?us-ascii?Q?VJ7Lps9i/Ev/qPqzk0XfEqrkvsbBmejMs3cTdyBMW8gmrw5Dyutp/rQAhXtJ?=
 =?us-ascii?Q?zLPgu0MGNsc69ZHoDrFLKeSl07N5MAe5aNONaZvbI8R3BQE7xJQgj7klJL0W?=
 =?us-ascii?Q?ar6NVXyV8uTswAMTZNKqt2EeYs3mgnSiNKvdFccG51SYPiRoxhE43CBo7Rd9?=
 =?us-ascii?Q?lfPkK7Yj5sVEP+eBGuHHB7SbOe7CQ9fnS+vrqOCwRyH9KBvRhQz4SIC4VJsf?=
 =?us-ascii?Q?RDROJXEalelit2+H8Q/E9cZFTnJBJgCDJSKFvdYd2ralwxN5OBW4agNmDhcy?=
 =?us-ascii?Q?RhUYQT70EiVLLTzXEUYbfaQCKh+M9ZQQcqGS5C0YJsSYQ0yumFGVnuciHQFB?=
 =?us-ascii?Q?gma/p3/xNGwIB3IhqMVYYVwRcwkDYnVJcmmoBJik/QnnXt1epgAtPhP2tTGD?=
 =?us-ascii?Q?TpdH9H54qsls7q0hyif5WB5nR3p66i9Q34H/OL81d5vzNtuBMGNCBg+/xWnk?=
 =?us-ascii?Q?Rqe7pUjmfSfobZ7m/hqo5LVTG6V4xTJTVkq5fx6aKf4+wYPsTAj03bLOMZsA?=
 =?us-ascii?Q?irqrU+mgYcm2VtJH8boRNaEDvTDZaGiWwuMxAf6S2aELgwur4679dGrCnKJW?=
 =?us-ascii?Q?OyPO7/Bm9Xu1NDaW3vOAJehvCmXBedASs/6/sa7le+gNvlAVthn71b+arJ5n?=
 =?us-ascii?Q?5dm0Jwio0iDH5M8TCDQxV34devZ5A/3pZiIzifAIc4xUXFdV5PX2XrZCYRBa?=
 =?us-ascii?Q?1yGOcUn0MrHFnBlq75nJXqCF57hO+LX3M2Qj4s9TEYasDxHCP/6+clMjqYIr?=
 =?us-ascii?Q?Adspldtp4bZaWH2kDO1+kNeCaeI2pCDiyLkZrF/15KIY11JMQhYKzMKJST6O?=
 =?us-ascii?Q?Wz8zp76uRLGa/5ca5uB0putLf5ex0Fa0QKKCMD3a4fpVMqgHRixHOC1NItZa?=
 =?us-ascii?Q?g3CGUV3iG807WVDHPkQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89319549-dcc6-449a-3c7d-08dc644af8a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 10:40:34.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gN2lFEdp9CB3iAGppJ7pXvBxgOlIfq/MY43lgcpSuI7LYGCQb4fOrBQ4IZgNbWfYS00mIoEooMi5hNrYQVmeJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

> Subject: [PATCH v4 3/3] arm64: dts: imx93: Add Engicam i.Core MX93
> EDIMM 2.0 Starter Kit
>=20
> i.Core MX93 is a NXP i.MX93 based SoM by Enigcam which needs to be
> mounted on top of Engicam baseboards.
>=20
> Add support for EDIMM 2.0 Starter Kit hosting i.Core MX93.
>=20
> Starter Kit main features:
>=20
> 2x LVDS interfaces
> HDMI output
> Audio out
> Mic in
> Micro SD card slot
> USB 3.0 A port
> 3x USB 2.0 A port
> Gb Ethernet
> 2x CAN bus, 3x UART interfaces
> SIM card slot
> M.2 KEY_B slot
>=20
> Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-icore-mx93-edimm2.dts | 344 ++++++++++++++++++
>  2 files changed, 345 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-
> edimm2.dts
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 045250d0a040..d26c0a458a44 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -226,6 +226,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-icore-mx93-edimm2.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb diff --git
> a/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> new file mode 100644
> index 000000000000..8b4f465e9cd1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2024 Engicam s.r.l.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93-icore-mx93.dtsi"
> +
> +/ {
> +	model =3D "Engicam i.Core MX93 - EDIMM 2 Starterkit";
> +	compatible =3D "engicam,icore-mx93-edimm2", "engicam,icore-mx93",
> +		     "fsl,imx93";
> +
> +	aliases {
> +		rtc1 =3D &bbnsm_rtc;
> +	};
> +
> +	bt_reg_on: regulator-btregon {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "BT_REG_ON";
> +		regulator-min-microvolt =3D <100000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		states =3D <3300000 0x1>, <100000 0x0>;
> +		gpios =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	reg_1v8_sgtl: regulator-1v8-sgtl {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "1v8_sgtl";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_3v3_avdd_sgtl: regulator-3v3-avdd-sgtl {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "3v3_avdd_sgtl";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_3v3_sgtl: regulator-3v3-sgtl {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "3v3_sgtl";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			alloc-ranges =3D <0 0x80000000 0 0x40000000>;
> +			size =3D <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +
> +		rsc_table: rsc-table@2021f000 {
> +			reg =3D <0 0x2021f000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: vdevbuffer@a4020000 {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0xa4020000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@a4000000 {
> +			reg =3D <0 0xa4000000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@a4008000 {
> +			reg =3D <0 0xa4008000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: vdev1vring0@a4000000 {
> +			reg =3D <0 0xa4010000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: vdev1vring1@a4018000 {
> +			reg =3D <0 0xa4018000 0 0x8000>;
> +			no-map;
> +		};
> +	};
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "imx93-sgtl5000";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,bitclock-master =3D <&dailink_master>;
> +		simple-audio-card,frame-master =3D <&dailink_master>;
> +		/*simple-audio-card,mclk-fs =3D <1>;*/
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&sai3>;
> +		};
> +
> +		dailink_master: simple-audio-card,codec {
> +			sound-dai =3D <&sgtl5000>;
> +			clocks =3D <&clk IMX93_CLK_SAI3_IPG>;
> +		};
> +	};
> +
> +	usdhc3_pwrseq: usdhc3-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_usdhc3_pwrseq>;
> +		reset-gpios =3D <&gpio2 22 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&cm33 {
> +	mbox-names =3D "tx", "rx", "rxdb";
> +	mboxes =3D <&mu1 0 1>,
> +		 <&mu1 1 1>,
> +		 <&mu1 3 1>;
> +	memory-region =3D <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> +			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +	status =3D "okay";
> +};
> +
> +&flexcan1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan1>;
> +	fsl,stop-mode =3D <&aonmix_ns_gpr 0x10 4>;
> +	status =3D "okay";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan2>;
> +	fsl,stop-mode =3D <&aonmix_ns_gpr 0x10 4>;
> +	status =3D "okay";
> +};
> +
> +&lpi2c1 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	clock-frequency =3D <400000>;
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&pinctrl_lpi2c1>;
> +	pinctrl-1 =3D <&pinctrl_lpi2c1>;
> +	status =3D "okay";
> +
> +	pcf8523: rtc@68 {
> +		compatible =3D "nxp,pcf8523";
> +		reg =3D <0x68>;
> +	};
> +
> +	sgtl5000: codec@a {
> +		compatible =3D "fsl,sgtl5000";
> +		status =3D "okay";
> +		#sound-dai-cells =3D <0>;
> +		reg =3D <0x0a>;
> +		clocks =3D <&clk IMX93_CLK_SAI3_GATE>;
> +		VDDA-supply =3D <&reg_3v3_avdd_sgtl>;
> +		VDDIO-supply =3D <&reg_3v3_sgtl>;
> +		VDDD-supply =3D <&reg_1v8_sgtl>;
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart1>;
> +	status =3D "okay";
> +};
> +
> +&lpuart5 { /* RS485 */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart5>;
> +	status =3D "okay";
> +};
> +
> +&lpuart8 { /* RS232 */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart8>;
> +	status =3D "okay";
> +};
> +
> +&micfil {
> +	#sound-dai-cells =3D <0>;
> +	assigned-clocks =3D <&clk IMX93_CLK_PDM>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates =3D <196608000>;
> +	status =3D "okay";
> +};
> +
> +&mu1 {
> +	status =3D "okay";
> +};
> +
> +&mu2 {
> +	status =3D "okay";
> +};
> +
> +&sai1 {
> +	#sound-dai-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_sai1>;
> +	assigned-clocks =3D <&clk IMX93_CLK_SAI1>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates =3D <12288000>;
> +	status =3D "okay";
> +};
> +
> +&sai3 {
> +	pinctrl-names =3D "default";
> +	#sound-dai-cells =3D <0>;
> +	pinctrl-0 =3D <&pinctrl_sai3>;
> +	assigned-clocks =3D <&clk IMX93_CLK_SAI3>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates =3D <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	status =3D "okay";
> +};
> +
> +&usdhc3 { /* WiFi */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3>;
> +	mmc-pwrseq =3D <&usdhc3_pwrseq>;
> +	bus-width =3D <4>;
> +	no-1-8-v;
> +	non-removable;
> +	max-frequency =3D <25000000>;
> +	status =3D "okay";
> +
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	brcmf: bcrmf@1 {
> +		reg =3D <1>;
> +		compatible =3D "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&wdog3 {
> +	status =3D "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_bluetooth: bluetoothgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO19__GPIO2_IO19
> 	0x31e // BT_REG_ON
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_PDM_CLK__CAN1_TX
> 	0x139e
> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX
> 	0x139e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
> +			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL
> 	0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA
> 	0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK
> 	0x31e
> +			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC	0x31e
> +			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00
> 	0x31e
> +			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00
> 	0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC	0x31e
> +			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK	0x31e
> +			MX93_PAD_GPIO_IO17__SAI3_MCLK
> 	0x31e
> +			MX93_PAD_GPIO_IO21__SAI3_TX_DATA00
> 	0x31e
> +			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00
> 	0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_UART1_RXD__LPUART1_RX
> 	0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX
> 	0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO01__LPUART5_RX
> 	0x31e
> +			MX93_PAD_GPIO_IO00__LPUART5_TX
> 	0x31e
> +			MX93_PAD_GPIO_IO02__LPUART5_CTS_B
> 	0x31e
> +			MX93_PAD_GPIO_IO03__LPUART5_RTS_B
> 	0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart8: uart8grp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO13__LPUART8_RX
> 	0x31e
> +			MX93_PAD_GPIO_IO12__LPUART8_TX
> 	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD3_CLK__USDHC3_CLK
> 	0x17fe
> +			MX93_PAD_SD3_CMD__USDHC3_CMD
> 	0x13fe
> +			MX93_PAD_SD3_DATA0__USDHC3_DATA0
> 	0x13fe
> +			MX93_PAD_SD3_DATA1__USDHC3_DATA1
> 0x13fe
> +			MX93_PAD_SD3_DATA2__USDHC3_DATA2
> 0x13fe
> +			MX93_PAD_SD3_DATA3__USDHC3_DATA3
> 0x13fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_pwrseq: usdhc3pwrseqgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_GPIO_IO22__GPIO2_IO22
> 	0x31e // WL_REG_ON
> +		>;
> +	};
> +
> +};
> --
> 2.34.1
>=20


