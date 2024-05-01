Return-Path: <linux-kernel+bounces-165847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D213E8B924F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8979F282701
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05BD168B15;
	Wed,  1 May 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JWVEGVnz"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5D165FD0;
	Wed,  1 May 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605937; cv=fail; b=RUoC9brobD8elYWG1FO1KTYK64uofDwjupZQOo87zh71Cl2yPv7sE0qegcfRLkYm18R5Fm/PSdYP0A5lJCN456uZSdVwhmmvAW2bQz64vxk933Fn301NdzewkFqkifJ+DUiZktu+zB91rhRvmFq7xMDePyZpSQMlFL1HTagcuTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605937; c=relaxed/simple;
	bh=t5fQkyoB7W2HmKb8aqNx4MqIa1/aS+2BFZx/8bjW5zI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SI9YatqeeYpnERZRvr6CQ7nbAngnItjLVWxtUY28rGx3+m2uVSm6Se4U/8QqXKYzJy4UmcqY2Y22B05ArAYJmf/Cj666WSE0o31JcITrsdhXzg77DOG6TUK455RG2r018cck3uyILyyqoSQIeXXLnC5fsvGEc33jsyeK7gEfiQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JWVEGVnz; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymx2E7nMxrJ7c4wCub3hBuFXf5Enk/DpRuIe/6rWXqR9ySpWkaNNgPdlVBWRsMLf/k/dGU6Z1t05G6o6uF9eJnOXx0SAJvjHeYCkY58pVW+my+VsEzAK648iG3hx+1aOX9S7xpnfhQ7Pez4e//n6zsN5D4VWlNMd5OqMuUY51DWlPVB1XOyZzMnnaW5C3+spXPv9fmD5dSgD6NbuU3ZBexapK8Wpm9lP3fS+EKVxQo317lwdBu9/MwqkvRcbH5tanHrha69yc4vB5Va6DJtHfYz5fSiHbiaQuw6iYvUa5cIYenLD3/YE6ppuiArV97h1FWr3pgQoOx2RGL5A8ffV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5fQkyoB7W2HmKb8aqNx4MqIa1/aS+2BFZx/8bjW5zI=;
 b=RkzmRHgC5Wot/CNYu+qhN1far6CXnAdY0YThhTSCcn66H26xp4Is29mU2GqWtip7HWv0wh8gH1GbyAzfhrGR6ujMYn1FRT0Ppm8HGsPcYJ319/dRF5oG450X50uQhZTB4IWZ6VNUd0aaKB7RDNRbsnDT+wJzpXQa43QPAXbTrG2ugyikEyPgWk4C2+5mDwk0MnqQK4FstL0C9ox5wS6wdF4MGeWTkKDRdb41pkF/61TUfzXgyX0zPpvTg0uq9fP5COdE44aFKu+z5RZAFu4nU4V19OQT5AVH8J/Azgtu3Wi8vUFeEkyPfMwVn5P4xvYPwK5teNjaa/IFV/XJHQpxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5fQkyoB7W2HmKb8aqNx4MqIa1/aS+2BFZx/8bjW5zI=;
 b=JWVEGVnz3gHmAs3HijSdBSo46gigujeAxTodJZ+LI2PiUC3Vh54eaYwHC6ospCYZ3c7kk0zQNRvnUN6jmGPwyEHgacpY4RYbg4+a/msrvHvyek6cCS14D6ye7BifbzbUorm+6BCXYWoGtUtUc6DP/yoNAGiBR/Ioiw6bm/vC95Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 23:25:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 23:25:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Hal Feng
	<hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
	"soc@kernel.org" <soc@kernel.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Heiko Stuebner <heiko@sntech.de>, Damien Le
 Moal <dlemoal@kernel.org>, Ludovic Desroches
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
	<s.hauer@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Dan Carpenter <dan.carpenter@linaro.org>
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
Subject: RE: [PATCH 08/21] pinctrl: samsung: Use scope based of_node_put()
 cleanups
Thread-Topic: [PATCH 08/21] pinctrl: samsung: Use scope based of_node_put()
 cleanups
Thread-Index: AQHam8YmBGCJNNA84UmfIILd289ovLGCk2mAgABx0FA=
Date: Wed, 1 May 2024 23:25:25 +0000
Message-ID:
 <DU0PR04MB941755376CA87C2EC70FDF7088192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <20240501-pinctrl-cleanup-v1-8-797ceca46e5c@nxp.com>
 <34193501-5b7b-4ffd-8549-a04c6930d02d@kernel.org>
In-Reply-To: <34193501-5b7b-4ffd-8549-a04c6930d02d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GV1PR04MB10241:EE_
x-ms-office365-filtering-correlation-id: 1ecc1975-1626-4c5f-fa77-08dc6a35faca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zm92QVI1bGJnZHIxT2ZNZW9xQWFTTjZCSlR6TitRdFBQZ1h2N1FZK3hKK2dT?=
 =?utf-8?B?d3Z5TkZWaDlmWmhJV1g4M3U1bjRKN05yMjUzSmhFQWJaaDAzMXRHbU9ycGhP?=
 =?utf-8?B?MFZPUGd4Yy9HUCtReGJIY0RwOU9Zc1hSZ1dUU2o1Q0lGWVc3NGZQYVA0eWh0?=
 =?utf-8?B?MTJoMUF3N2g4ZWNBN2NabE5ZOE0xNkplMmxjaGl0UjBWclA5L3A5dTF2dE9v?=
 =?utf-8?B?N05wQzcvS0JveExqck5NcHh0QUwwODNmWWJQLzBLTlhuNXdxYkhoWUpaZ2h2?=
 =?utf-8?B?YUNYUmVHTDYvMGJWY21tUWlUdnNRTUhyUGc3enA0WlRRYmcrRk9rMUw3d1Vw?=
 =?utf-8?B?TWJDbDlOSEo4QXNyaFBNd0JBbmp3SGc4VDFWSW04dU9xQThCR0hQUWRCU2JO?=
 =?utf-8?B?VlZ6ZU54L0pONnNIR3pBT3Brc3hyTkFjTk40dm90YTArSTJkRUp3RDlFUy9R?=
 =?utf-8?B?dWZYZmF2eVZseWFCd0EvNmpTVXJlajN0NnlmYjRrSnlKUFhlelF5MFQ0Mkxs?=
 =?utf-8?B?eXdsMTg2MHo1WGN5dUV4TzkrRUNZQXFNcmRCS3oxZ3RHb2o2cHhZWnB0aTJJ?=
 =?utf-8?B?L2EvZGJZQXVTTkloeGsza0FJZGN5RmtBS3dCdkFHMW8yQnBFQ3ZucVJ0eEdG?=
 =?utf-8?B?ZkhoVHdsUGtjc1Y3eXRpUGhnNzViN3RVS3lEcU1DVy9YSjlubFcveU5xd2Ra?=
 =?utf-8?B?S1U3WmxSOGVrZjVzcXJDTHdYOFZGYzdFZnVkdXFhcnh3NkVJaGdJNUNQYmFv?=
 =?utf-8?B?cjcydWhJMjRJWCtSVVIzSVEvNDdsMWRWdFNRMTBmOTNKaW5HNjFtMTY4dkxN?=
 =?utf-8?B?blVGN3g3RTY3N09RTkpsY1NlLy9ReE91a0JMS2h1V1ozemUzYnlnU1dDNDF3?=
 =?utf-8?B?czdpK3luWmRKVGRrVEx2alU0djIrS2I3QkUyWEVVUHdUdGlST1BzaEx1djFB?=
 =?utf-8?B?OGdDTXB5R3BIWnI1OVZZaUJodkpFTHN3UmRYeFV2OURUeW5ucCtjaytlTmlz?=
 =?utf-8?B?STl0R2dKNmNRSFVHZ0RYVWdiVEdlZnBLaEExYXZXS0xGWGlsZjF1OGtOcS9x?=
 =?utf-8?B?MStMbEJ3dzVySHNxcnNmZG5uam45UzNoUTV6b1h2R1lYaFk4ZnJ4UnBJak03?=
 =?utf-8?B?M01ibWhEc0NpZ1R0V09TRXNpQ2pqOWZmb1Mxd09XZFg1d3lwWTdmVkVzNllQ?=
 =?utf-8?B?YlA4ZE9KM2ZhTmRQRjI1V20yV3AwTGFKV2RiLzY2dmxFNmE1eDNRV2s4VmlW?=
 =?utf-8?B?QXd2U1VvQ3RHRER5czJwN3dBN1RWRmxkOVFEMGY4dkVaajRSdDJWc0FkNU5m?=
 =?utf-8?B?Szg5T3c5U1lTR1BZd0gzYmdpdmhhSkhvRGxGbHhYT0JQWVFQcVpSWnR2Q3Uy?=
 =?utf-8?B?Y002eTd2SEw1L1J5L2JaTE52M09WaGtXdlBXcE1sTUNFb0NLNDhEWWV1WHRK?=
 =?utf-8?B?RVAyR2tEN3RjNU5TS3dDenRRTDNRMjJLM09ZWHk3UjRWZnFUb2UrT0RSSlI0?=
 =?utf-8?B?bGd3Vnk3SmxlbWVQZWtiSmI3SU1iaVJTUUYzWDF0WkdURFU2Q3kxbGhnSzJy?=
 =?utf-8?B?MlFOQm85ZGROaWNsNmhYS1NISnFTbnlJbEFtYW42c0h2L1NKQjFBZk5TblB3?=
 =?utf-8?B?UVFuWUVUVG9UcUNMWXJmNkIvdEVOQVhPM2dXd1V5eUVrQndTTHU0OEZLRDJ4?=
 =?utf-8?B?aE0wNjhOOFFWcm9nd0NUNGdjNjJ1aXJ1bUFMZS83cmExdk0rWWhtNGNKWlM0?=
 =?utf-8?B?dW5JSlk1ZXBjS0NNZE8rTGtBUGxDWnRmWUZNS0EzTldLY3dwODd6T0Q4NitF?=
 =?utf-8?Q?ecs+/6H9G7rwzePKqPBFXtVSCx3cpadhirpqo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWlUT1gyWXp0Kzc4c1VqRk5ZL1RJbTRXbFFwdXkyRTFTaHJ3SEVQSUNIK24w?=
 =?utf-8?B?VjRPMlArdEpHSjJoQUVtVGZyRTZlV0xpcXJkTEFzQjFaQjBTZnhkSmx2UVJl?=
 =?utf-8?B?a0h3Wk45THdjZUVTVjhGaStFNnI1dXpBdHUrMmQrdlIrVERLeDlUOUY4K0dn?=
 =?utf-8?B?aDZvRTQ1NEx2VVN4aDFTbEJueHNYOFlvRmFOQnFraXFUd1pLMFY5RXNsclNz?=
 =?utf-8?B?Z05UUjBidlZmb0QyOGpnU28wQmhQZFIzVGl6eGpUcUhsWTZnb2pjUjFObEI5?=
 =?utf-8?B?S3NVN2VWM2RYV2EvanRrMzBLVWwzb3ljSE5LcDRpaGNGQVRFWElJUXFQMnlI?=
 =?utf-8?B?eGQvRjR2N0kyWTF3MU1udUhidmorWmpRSytmQmJLYjdFYURRY2RzTnZwR1Mr?=
 =?utf-8?B?S00zd3dxTGNDN3dhd1Q4aWVwSGE3dWlwaEEzV3Z4dzQ1WkY1Tm1BMUN6NUY5?=
 =?utf-8?B?U0pZUkx4UDkvazNOTUdmaHdCdEFYSFRjd3NOc0ExczZEY3QvMzA1bkYxejJE?=
 =?utf-8?B?aFYzNVVUcnVDZ2p0Ykw1M3VMU1R4Y3pvZmVUM2tPS2E5NFBGS2pRWUc2NzJN?=
 =?utf-8?B?SllCcEFxbjAybTcvUytEMWZ4bGhxaitMeXF3anNBOGxWMU1WNVcwUjR6T3ZU?=
 =?utf-8?B?dGRjYmdZM0xaUGs3ZlFwUlViVklkc3QwQlg1cWRndXlmQWltSmpCUU9QRnBR?=
 =?utf-8?B?SFFPWkNKeDZqc3lKZWNlWGhTZzd0QTZjQURjNDB2S2Q4eFp0N080Sk12UGZX?=
 =?utf-8?B?U0hld3pMWWtWOUVDb0NET05CTzFkdEROUjJYd21XWXNYeWkvUzVMd1ROdktZ?=
 =?utf-8?B?LzQ4R084Q3Rwbjk2K1JEWVRLSEMyckRWajB4Qmc2ck1UMGNkblFiS09tTk1H?=
 =?utf-8?B?SkFYUm52RnB6a3owemwrdGE3SmQ2QnE2RnpuQ0ZKUkxUTXJaUGVGK3BrZWQ5?=
 =?utf-8?B?NWZodko2NElYMUhyNWREOThhQTdsemVqbWdPL3k4Vk9wSk5udVZ1YmY1OHEv?=
 =?utf-8?B?STlSV2dxRGhOV3FjeGlMd3BMZ2NpMHZrU2M5YXM5SDVyTTM0cVpSWVlxQWZD?=
 =?utf-8?B?TkhDN2FlelJyaGhMdWtzenFjS09ESlBGRFplNHA5UUI3THd3ckxNT2JVYVZS?=
 =?utf-8?B?Y05hY3lDUmN6eDZET2pycjhEaW1xOUJycEpMV3Y1M3lKc3RMUmJWRzNicDN3?=
 =?utf-8?B?a1lYQmtKbURTcTE2RTZpOEZhSnBNSkdaZVEzRE1zbFNJTitoWEp3cUoyZ3g5?=
 =?utf-8?B?S0drNlRHYUFiWkttK2ZJamk3VTZoeUYrL3hkS05GSWVjZHZpRzFUYk9YS1FB?=
 =?utf-8?B?MXd1OHA1R29BUXF2ZGpSd21XdkQyYzVobnY0UUJKSTJ4RXREdlpoTkNFcmlh?=
 =?utf-8?B?WVhacEJXTjZ1ZXRCZzdsN245dElqWUJlUGFLYVozR0NuLzRxd01rekxmc2lh?=
 =?utf-8?B?Ym9wRURmNFR5SEJDbjRZZ0VJZUN0eWt6YU5LNHJ4UmliWWpGVGszcVF5Nmc3?=
 =?utf-8?B?S2pZMEdudTkzcFV3YWp5Q1o3TnN0L1RKdkNaekZIZU00a0dLQ2V0NmczK0Z1?=
 =?utf-8?B?d05yTURFZmhIM013T21HSmJjNzluMEFocmtYQUtjdDFjOTNNMWkwaW9iT2V5?=
 =?utf-8?B?MWJwa2U1elFnMDRWd0o3cy9RTGVzUmUzWlBKNlErQkY4SlFSc21FaEVRZE0r?=
 =?utf-8?B?eFJuN29IVS9DQ0N3R09IWGljL2FqYWVRREoxaXA4SENUaXY3Z0w5TEQ1MUxB?=
 =?utf-8?B?czYwK3dISHZQaGhOVms0eDdWWDBvOHoxYUpraXRsZ0YxS0xZSjRlZzdCazNu?=
 =?utf-8?B?NDlROWppTzlaSXJudjF4cWhkd1RnMXJaeUNqRWp0R2NVZndLK3N5MTVXcVNH?=
 =?utf-8?B?WlkzTE9ZNHFKV1UwRUxpQnRWK1dLeGtFd0tBNTZvUkxqOGtacTZyaFZTMjhB?=
 =?utf-8?B?bFNTdGM5Q1g0bkVjV2krM0s5czVITU11eTlBM0dmVjdrRkErdjBkeEI3RVBi?=
 =?utf-8?B?ODczNFdYMjlwclEvdDlmeU1JOU9pZkhIREt5bUFFUTJVV2VvSFVJWWU0V0pz?=
 =?utf-8?B?UU9JTEFMNXNENVIxdWRRYkVTMkowTldYc0FRdXpLazdkbzYrU0YxRzd1TFU4?=
 =?utf-8?Q?/L3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecc1975-1626-4c5f-fa77-08dc6a35faca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 23:25:25.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghjxKUsI+Coy8Ono9sx8NzlzbdLDcJYbNd5FjTpZMp7O+P/w1uhXLynPLIDB9X8Jf8jexwNOPauz1zfWm6gTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA4LzIxXSBwaW5jdHJsOiBzYW1zdW5nOiBVc2Ugc2NvcGUg
YmFzZWQgb2Zfbm9kZV9wdXQoKQ0KPiBjbGVhbnVwcw0KPiANCj4gT24gMDEvMDUvMjAyNCAxNDo1
NiwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4NCj4gPiBVc2Ugc2NvcGUgYmFzZWQgb2Zfbm9kZV9wdXQoKSBjbGVhbnVwIHRv
IHNpbXBsaWZ5IGNvZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9waW5jdHJsL3NhbXN1bmcvcGluY3Ry
bC1leHlub3MtYXJtLmMgfCAgMyArLS0NCj4gPiAgZHJpdmVycy9waW5jdHJsL3NhbXN1bmcvcGlu
Y3RybC1leHlub3MuYyAgICAgfCAxNiArKysrLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvcGlu
Y3RybC9zYW1zdW5nL3BpbmN0cmwtczNjNjR4eC5jICAgIHwgIDggKystLS0tLS0NCj4gPiAgZHJp
dmVycy9waW5jdHJsL3NhbXN1bmcvcGluY3RybC1zYW1zdW5nLmMgICAgfCAyNiArKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDM5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9z
YW1zdW5nL3BpbmN0cmwtZXh5bm9zLWFybS5jDQo+ID4gYi9kcml2ZXJzL3BpbmN0cmwvc2Ftc3Vu
Zy9waW5jdHJsLWV4eW5vcy1hcm0uYw0KPiA+IGluZGV4IDg1ZGRmNDlhNTE4OC4uOWE1N2IzY2Vi
NTM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9zYW1zdW5nL3BpbmN0cmwtZXh5
bm9zLWFybS5jDQo+ID4gKysrIGIvZHJpdmVycy9waW5jdHJsL3NhbXN1bmcvcGluY3RybC1leHlu
b3MtYXJtLmMNCj4gPiBAQCAtNTYsNyArNTYsNyBAQCBzNXB2MjEwX3JldGVudGlvbl9pbml0KHN0
cnVjdA0KPiBzYW1zdW5nX3BpbmN0cmxfZHJ2X2RhdGEgKmRydmRhdGEsDQo+ID4gIAkJICAgICAg
IGNvbnN0IHN0cnVjdCBzYW1zdW5nX3JldGVudGlvbl9kYXRhICpkYXRhKSAgew0KPiA+ICAJc3Ry
dWN0IHNhbXN1bmdfcmV0ZW50aW9uX2N0cmwgKmN0cmw7DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wOw0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCBfX2ZyZWUoZGV2aWNlX25vZGUp
ID0gTlVMTDsNCj4gPiAgCXZvaWQgX19pb21lbSAqY2xrX2Jhc2U7DQo+ID4NCj4gPiAgCWN0cmwg
PSBkZXZtX2t6YWxsb2MoZHJ2ZGF0YS0+ZGV2LCBzaXplb2YoKmN0cmwpLCBHRlBfS0VSTkVMKTsg
QEANCj4gPiAtNzEsNyArNzEsNiBAQCBzNXB2MjEwX3JldGVudGlvbl9pbml0KHN0cnVjdCBzYW1z
dW5nX3BpbmN0cmxfZHJ2X2RhdGENCj4gKmRydmRhdGEsDQo+ID4gIAl9DQo+ID4NCj4gPiAgCWNs
a19iYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPiA+IC0Jb2Zfbm9kZV9wdXQobnApOw0KPiANCj4g
SSBkb24ndCB0aGluayB0aGUgY29kZSBhcyBzaW1wbGVyLiBQcmV2aW91cyB3YXMgdmVyeSBlYXN5
IHRvIHJlYWQsIG9idmlvdXMsIG5vDQo+IGVycm9yIHBhdGhzLg0KPiANCj4gVG8gbWUgYW55IGNv
bnZlcnNpb24gb2Ygc3VjaCBvZl9ub2RlX2dldCBpbW1lZGlhdGVseSBmb2xsb3dlZCBieQ0KPiBv
Zl9ub2RlX3B1dCBpcyB1bndlbGNvbWVkLiBFYXN5IGNvZGUgaXMgYmVpbmcgIGNvbnZlcnRlZCB0
byBjb21wbGljYXRlZA0KPiBvbmUuDQoNCm9rLiBJIHdpbGwgZHJvcCB0aGUgY2hhbmdlcyB0byBj
b2RlIHBpZWNlcyBhcyB5b3UgY29tbWVudGVkLg0KDQpUaGFua3MsDQpQZW5nLg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

