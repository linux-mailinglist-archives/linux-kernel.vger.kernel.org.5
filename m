Return-Path: <linux-kernel+bounces-165277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB88B8A79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727FE1C21272
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDE1292FC;
	Wed,  1 May 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T4AuxXJz"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F3433D4;
	Wed,  1 May 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567853; cv=fail; b=gxTFg3ZVh6jWnveY7mGDoFvfxop5CBBsUi4I0h8MRBeWKE7veAiIkXBLtUKvOqnk5D9po3tglnElJo9OMjqEO75vm0uQgFuiMYOXxt3vihUxBbCrx2LWOfDnTWi+xP+fxrAlwyvaf1GpOrO2m9y2rFiaZbvLqq39/QVhY93lfz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567853; c=relaxed/simple;
	bh=S+XkLCHnGs5USz44JLyd+Xp/AaQfbVg/qJuXb2fjjLI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Oh4JufpFCEKfEFE72uWbXltSzdXkOotfxRE5bZ9XiPFjL8h45tVOfXnX0d5PRtDLJ7ylf79jKduuhUBrkOpAQxJOkNLoCqnxeYulMZRCzXxObskCpQOTeSDP6yx744adGx4L8FdW84/E6H6oABCIn9eVOX6spLNaoqlJKl1aHzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T4AuxXJz; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTfCKx4cSQWZztbmuoS3CDkZmsJd6pJkp9KUN42/IRrqekpRuEXUNjnuQNtUp2A5TtNrvsAEBC7F9wLwEnlo4V1c+iATn53OlCqDXyac6NiL0+OZo+2OCpH4QG6KuGEJF/tW3GO4hw6ZbBiQQ7YALdztrJRXxlPkzKtzObPrfvFVe9cBTrXtOREZPYYvT+Y/iZQqKpD7cmWWbXmP4hmDX6p1MEjj7QfOuNylW65FZlIPW8LqaSf/4NBOoLjEqXF6BpxRBpKci3N5nAkFJQ6v99pHPyDAWs+gXAHaP0FpbJQ5K2HE+wvPNDPdw1/4KwykdX7FMgaUmd2PCSzVJfJoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwLf//ulDgKGYdIslgc2mcconcEqLiM/aJbLmOr9R5c=;
 b=Wp35yQ9T0zgqXbj+1O2zlHGwK4gljsITTMatgAA2xUBsbtz+mrnjjEYSNNss2Xg5zqhNGwgNSzvO98hqNBS2fsBinW7iwij0QJSTasQLhUQ8rfdyE9bXDQYHrXbIve5Gk/CVJjIn8asNGXDK44/ZALhOdvH58x/k4HDlIU27/DiPMS/z1jx9+I2wQg1ukMRDhxKQTKrElgeXSKC00oa4QT5iB8YBI4Kye3m7ndqcp5tk0muDdcQzK1kyPs/rti+zsDy+OF6I5iIYLvjLH2+gydkgeoGaVkVz7L7iXyAFzc3n/7Z2lSei8L6UQvs4xXji/IbxWrVNFEEat9a9qU+V4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwLf//ulDgKGYdIslgc2mcconcEqLiM/aJbLmOr9R5c=;
 b=T4AuxXJzaFZv9OPj5JPUvQkK1dBLoFzSWv5wa78VfgVX7bUbOvxHJbvKWG0QKFPl7cF/h8jw4R282M03y8T+kVe4YKc1kJHwYJwpzwTd/yVkyQabrBfZrSYCrJmpMMk6m7u8RxXsDTibdxM8wus818FvydAO0l1G57bIb8YA4iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:50:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:50:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:07 +0800
Subject: [PATCH 09/21] pinctrl: renesas: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-9-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=7968;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=K64zqrCbOC3rYAPmpNXeqloBPZKzMWC8Ln5phskDCDI=;
 b=SVSZB2OptEjixUVsBxQFlBLMyaX5ozL4HG2RhrVwKgQLHU+s64uygotTA6azDA6z8npJ4Ulj2
 IlTLsI741+qBoolYUGSxm6k4Tb0gI94BPqScicGbaZ2GKveAWUAEHGf
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332603a-25bf-4c13-196f-08dc69dd52b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JML2pHTVE1ZW1LVmVpNDlmcnVKS1l0OVBLcS85Y1IraEUvVHhBd2wvU2hD?=
 =?utf-8?B?NXIvNW9pYXNyOXB0cU1Mci9hZFNJeEE3blVwQWtUY1ZpU3EyVjBGeWlpQVpm?=
 =?utf-8?B?WVFObmRFV2FWRk9SVTYvT3JLck1DZUpqc0xFZ3h1eThNeTNOQ3g3bFpwcTFO?=
 =?utf-8?B?Tytwd0lxeXZrNWxyd01XbFBpTDdOYTRaeXBaSXJDUzhOYXp6eG56MHBWOUQz?=
 =?utf-8?B?MGYzVFhiTmk1bmsvL3BEMHcrV1ZZbDNDU0pDNC9zaGZvREZuOW50KzRha1g2?=
 =?utf-8?B?UXNtUU1HOGZCWnpMOGJxYzUwSHZ5SVkrdSsxTWR3S2hxY0NmVTdNanQyTmZY?=
 =?utf-8?B?NGliWStFSnhYVUhtbmVmcm4yWWFFYVlvc2ttZmlSZFBqZE1PeFNKditFeHlu?=
 =?utf-8?B?MmdmRGNDL09CQXV0WDlRNTRVZEpqUHdjblp3Nk9sbkR4dFR2UjRZYXVxbGxT?=
 =?utf-8?B?RDUxc0d1eWZoS2xMWHZsM0lvVFNkeWtjS0V5V2tHZlp6YlpUVDhDNURlOVlJ?=
 =?utf-8?B?ZjV4UFJ2TGVlSk96d3MwM2hMKzVoOWlNZWpJd3MxdjlGRy9abUVWcmNiNHBa?=
 =?utf-8?B?d00rTE1VVWl2N0hOeVVhdWp6UWVqYlp6SFgxcGRORlR3NXhzc01GaUZwVFlw?=
 =?utf-8?B?VTl3WUFZZFFhYytlbXZpVlhaL2hGdCtoZ1pOR0JNbVJubkd3SE9GS0JPOGk2?=
 =?utf-8?B?Zm02bHE2T1M4MGxCVnN1aFJzNXJuVE9ZS1FCQW9BVWJ3YW5GaXBKVDFTWWFJ?=
 =?utf-8?B?dXVGVVM0KzlhNVVzd0M2VjI4OUZYVEdYclZvbUVwMjNoZG44dy85MG1TaUhu?=
 =?utf-8?B?NUxnTUMzelZCV2k1Rno2YkFxK2NpZ1pwRVRhdWZ0cHhOL3pFdmRMZnRFT3Ew?=
 =?utf-8?B?Z0tsTG1KWjlGZWdsWUxvK2VnUGF5VjBZZmpyRHlFSFIvS08vTDhtU09mdTF5?=
 =?utf-8?B?N0dCMzhLQ254Ymh5cS8wTHozaWxHN3hOS21ZWVFXRjFINzVlbU9pNGg3NVQz?=
 =?utf-8?B?YkVFblRic01nTzVGLzIvd2FVM3NkdzRNWURuTFN3Qnh4b3cwb1hjWGVhbit1?=
 =?utf-8?B?MGYrcDMwQ05MYjNqWXd0U0JnM09peWw0YWVkMWVXUmNDV2ZqVkRZT2J0aURk?=
 =?utf-8?B?L01zL2tmc2w2aHZZaHhSelR0bndDYitKazZIVm4vYWx0eHpKeEtQZElIUVFw?=
 =?utf-8?B?a1JNdE5oOEd6b3hOVjlkYzZQQzEwK3M5WHhIWlpsTTI5RVFXR0tBZS82cTJz?=
 =?utf-8?B?dWRhTlo2YXB3aHJvR3I3ZVgzbUd3RjEyY1Q4aEYrRTYzd2loUWFZN3lSUUU4?=
 =?utf-8?B?NUFRK2ovWFc2VDRBZzhqZE5MTDJiLy9TUnBPbzlKQjJ5dmRFRjF4M1BVcHBE?=
 =?utf-8?B?enlyVGdmY21RcERmWEJYMjBYQ0lKcWplVlhaczNCR2IzZEllODV5L3loTGtz?=
 =?utf-8?B?cm1YZ2czV1F0M21MYjI1WnFxTFlXY0hhbzFLQ1gyRFRVRDZOc2FRY0tJSU9w?=
 =?utf-8?B?MXloTDFtOFlJWFpIbG9IRkRjMEMwVWpFNXNsLzU0NUk4OVBYbjZGV3Jpa1VO?=
 =?utf-8?B?cUVpUW1BdkRiaXQ2a3pOZHF2YXY1ZmlMSm5VM1lLUlJXWFhUVGpVRE10UmVY?=
 =?utf-8?B?T05HUWNESmFmeXZ5THgxSkhOVkhCaXV5VGhmZHdqRkw2Z1Fta3k5MTlKNndh?=
 =?utf-8?B?enUwbFBRY3pRT3d2dFM5ckt3NzdVS05BdTVjdk96akgzRWNsS21waTZPbFI5?=
 =?utf-8?B?M2V3cnBSMnh4TXpBSThIcTRGaFJEYUNtTmFsYkJvNXhmaXhmYXpxVFBCNDdM?=
 =?utf-8?Q?4WQx7qq/stSGHV448X+2zE3JH3vvEEfPrz2YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVqdFk0YUhsV3dGK1dBVUU5U0ZZRnQrT3BMMFJXMTJxa1BJeXhOZHcrbVdm?=
 =?utf-8?B?WTdSUHVCOThPeFc2SWtjMVNkc0tmd0V2dG1Cek0rSm9HVkNWY3RmcEx3aGc4?=
 =?utf-8?B?cGE3Vk9GamNYbGVvcm9tRVhSWTBleTYxUXk4MGdxVnlobGJ4QVZwZ2VvV3Fv?=
 =?utf-8?B?S1hPMEttVEtOZElsUjVMa2NPbkRUOFIrU0oxU00rOTM0Z05PamZTN29vSGh3?=
 =?utf-8?B?LzR3OTlLMmwxTnhTS09sL1ROSnF0MWdieEl1czhSQWdTUGUwd0Rha0VoL2tv?=
 =?utf-8?B?V0JTdmZ1NHFlQ3FyM0RhWktvNWdENFhoSGxxWDlmeGJDZmpycW8vc0EzbUU0?=
 =?utf-8?B?bmdhejgwWERMSTgzZTUxc3kyK05BTW01a3BxMnJ1MERDc29RZWcveFJ6T0p5?=
 =?utf-8?B?aU9JSE4waEhabHpUNEJqT0hhTWlJWjlHN1NrVk5hV3VOQ3ZtOUI4SnNhVTd0?=
 =?utf-8?B?bTR5c3lSOVlJa3NBYm9mbDhqM3ZjSEtBNXBmUDZBVmdmUVQxWktQYjFTaWpX?=
 =?utf-8?B?MnRIeXFSQk5RUjRyb2VtYUk5N1FWTXBrcEhPMXJJSUtNeDFRWFRYRzBWUXVR?=
 =?utf-8?B?MFRvRnV2T0wzaEpvNHI0MThqM0QrcVVkZ2Y3eEtxd1JYQXppN1g4S1pmKzVr?=
 =?utf-8?B?MDNyNEROWG84dFVMVDNmT2RTc0IvR3FxQnVaUDgyWkxZN3BkaVVVVXI3eW9i?=
 =?utf-8?B?SnY4UWoxcGNWTGlyMkdKYms0bkFjZk1iU1kyNHlyejcxa0FZcTFabVRic0k0?=
 =?utf-8?B?eXpvYUVTNUZucWROaDRCZEpJc2JjWDVscWNZZUhRSXRTNXkzQk52MTdwaHM0?=
 =?utf-8?B?TlI4NWh0N1NNSGJuaVU5ZVVHZ0xSbkRaUXpKOHRvdVZ4MFdpQlBXamRFVWZv?=
 =?utf-8?B?aStXOENUQ2FkUGlWNWFEd1JLemwwS2NDQVlyeEx3R0RCNGhiNWIwbzkyazhU?=
 =?utf-8?B?ZlFQVkNXZXZ1TmMvMGtBTXZMODFrWjVTeFkrWVVWczdQQm93NDZHZnFXMERT?=
 =?utf-8?B?T1ZGekh2bnYvL1FCZU5aNDZkOXAzVE0rSHhJbjJCaUovY0FDN2sxUXhqT0hN?=
 =?utf-8?B?K2lpZG8zYzNKR01BbVhvYjBiQ0thcXhoVkNmK1h1TWZybG9TQ3ordnpxY3JL?=
 =?utf-8?B?SCs0dmNxWTBjTFE3TFkyTEUxVUV6bnJNb3o0ZmJvajRLK09NYjFhdFhFWElu?=
 =?utf-8?B?N0FzWUM3Y09JS1ovZ0dxOTJmWjVuYXZCbzBMOWxIb3gxMzVjcnhBbVlkT3hm?=
 =?utf-8?B?OUVTcjVLRkVWdUpnQWx3T1daVXBIejYrUUM1UDU3eDg4OEtNSWxmZEU3QUM0?=
 =?utf-8?B?TzhNMmVxb1Q3NDJMc0dCdC9Td0xYNmVuM2Z2WEV1NEFyMzdOMGloTEZWSGll?=
 =?utf-8?B?Z2dUNW9VMlJpM2JNL20yZXdETDBqZktkc2cvNFlkTVpYL3ZETVlORFY4ajNF?=
 =?utf-8?B?VDRhV0cwYWozc1YvdEJhbFo3MGZQUDRjT29CZFdGOTdsaHFmKzBXZnk3d0JB?=
 =?utf-8?B?RTJValpPK0NlWXVWSTFNN1Q4RFhJSnduSGpVdFR5bW9ndHhmWkE1R0dwYjcr?=
 =?utf-8?B?NXBISXpYRmRBOEJSMXVpN2FnWTA2U0V5Y2gyaWRhcTlBNERFMVcvNkxOdzRV?=
 =?utf-8?B?ZHlEWFlMaVIyU2FDNFNhY3VIcG56blJ0OEJOUjNEd2VFVVZJRGg3UEdudjR2?=
 =?utf-8?B?WmpoZ3pKcDhrMkhMSmtDMlM0RWxTd0V1SEw5NmRTMHdVZUZTSUhUOFVhM0sz?=
 =?utf-8?B?Q25RZUVHODlISExtQitLQTRhSW4yUWdsMGZwT1RCcWViNkdZamh1d3lBMEtj?=
 =?utf-8?B?d0pIQUdyNWVILzQvRUIvN2tnU2pUcURyVFJKTGk4Y29VajllL1RZU3J1VlFE?=
 =?utf-8?B?K1N3MGlTUDl5eGVJdUdUckZFZm8xYU5rSDk3V1djTldnUXE3cnNxRnBZMFFh?=
 =?utf-8?B?WkV6VjhIa20zb0FEbHlvQ2RraU5EY2JkQjBoWDl4MmpldSs0THJpY2wxaU1Q?=
 =?utf-8?B?UGYrZ0lXSWVzRk1iQ1kvRDhLREFiV05UdzRhSXlEdCtVTjVpMHBnQithbnNa?=
 =?utf-8?B?TjRpSVRGSU1OMzIvTmhtK29vMnA5WFAzNU5UUGxyTEl2VERsUjBOSkFZejZx?=
 =?utf-8?Q?0wt6dzZkR4JSqp7z9lZUvCznw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332603a-25bf-4c13-196f-08dc69dd52b7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:50:47.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgoF+yszrnD5AaOJsghO43g3qH8yKF0h0gMRpzeHEQQMg+zIOBVBqRnq7ye3+fpjloNfUHkXq1ug+XUNsY376w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c  | 14 ++++----------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 +++-------
 drivers/pinctrl/renesas/pinctrl-rzn1.c  | 23 +++++++----------------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c |  7 ++-----
 drivers/pinctrl/renesas/pinctrl.c       |  7 ++-----
 5 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index edcbe7c9ad56..6527872813dc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -852,7 +852,6 @@ static const struct gpio_chip rza1_gpiochip_template = {
  */
 static int rza1_dt_node_pin_count(struct device_node *np)
 {
-	struct device_node *child;
 	struct property *of_pins;
 	unsigned int npins;
 
@@ -861,12 +860,10 @@ static int rza1_dt_node_pin_count(struct device_node *np)
 		return of_pins->length / sizeof(u32);
 
 	npins = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_pins = of_find_property(child, "pinmux", NULL);
-		if (!of_pins) {
-			of_node_put(child);
+		if (!of_pins)
 			return -EINVAL;
-		}
 
 		npins += of_pins->length / sizeof(u32);
 	}
@@ -986,7 +983,6 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct rza1_pinctrl *rza1_pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct rza1_mux_conf *mux_confs, *mux_conf;
 	unsigned int *grpins, *grpin;
-	struct device_node *child;
 	const char *grpname;
 	const char **fngrps;
 	int ret, npins;
@@ -1023,13 +1019,11 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	ret = rza1_parse_pinmux_node(rza1_pctl, np, mux_conf, grpin);
 	if (ret == -ENOENT)
-		for_each_child_of_node(np, child) {
+		for_each_child_of_node_scoped(np, child) {
 			ret = rza1_parse_pinmux_node(rza1_pctl, child, mux_conf,
 						     grpin);
-			if (ret < 0) {
-				of_node_put(child);
+			if (ret < 0)
 				return ret;
-			}
 
 			grpin += ret;
 			mux_conf += ret;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c3256bfde502..85a4f3c7d73c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -745,7 +745,6 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 				unsigned int *num_maps)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -753,13 +752,11 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzg2l_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	if (*num_maps == 0) {
@@ -2201,7 +2198,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 	const char *name = dev_name(pctrl->dev);
 	struct irq_domain *parent_domain;
 	struct of_phandle_args of_args;
-	struct device_node *parent_np;
+	struct device_node *parent_np __free(device_node) = of_irq_find_parent(np);
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -2210,7 +2207,6 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 		return -ENXIO;
 
 	parent_domain = irq_find_host(parent_np);
-	of_node_put(parent_np);
 	if (!parent_domain)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 4b2f107824fe..e1b4203c66c6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -404,7 +404,6 @@ static int rzn1_dt_node_to_map(struct pinctrl_dev *pctldev,
 			       struct pinctrl_map **map,
 			       unsigned int *num_maps)
 {
-	struct device_node *child;
 	int ret;
 
 	*map = NULL;
@@ -414,12 +413,10 @@ static int rzn1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		return ret;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzn1_dt_node_to_map_one(pctldev, child, map, num_maps);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -760,7 +757,6 @@ static int rzn1_pinctrl_parse_functions(struct device_node *np,
 {
 	struct rzn1_pmx_func *func;
 	struct rzn1_pin_group *grp;
-	struct device_node *child;
 	unsigned int i = 0;
 	int ret;
 
@@ -793,15 +789,13 @@ static int rzn1_pinctrl_parse_functions(struct device_node *np,
 		ipctl->ngroups++;
 	}
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &ipctl->groups[ipctl->ngroups];
 		grp->func = func->name;
 		ret = rzn1_pinctrl_parse_groups(child, grp, ipctl);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 		i++;
 		ipctl->ngroups++;
 	}
@@ -816,7 +810,6 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 				 struct rzn1_pinctrl *ipctl)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	unsigned int maxgroups = 0;
 	unsigned int i = 0;
 	int nfuncs = 0;
@@ -834,7 +827,7 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	ipctl->ngroups = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		maxgroups += rzn1_pinctrl_count_function_groups(child);
 
 	ipctl->groups = devm_kmalloc_array(&pdev->dev,
@@ -844,12 +837,10 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!ipctl->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzn1_pinctrl_parse_functions(child, ipctl, i++);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 0767a5ac23e0..0cae5472ac67 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -388,7 +388,6 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 				unsigned int *num_maps)
 {
 	struct rzv2m_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -396,13 +395,11 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzv2m_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	if (*num_maps == 0) {
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index 4d9d58fc1356..03e9bdbc82b9 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -241,7 +241,6 @@ static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = pmx->pfc->dev;
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -249,13 +248,11 @@ static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = sh_pfc_dt_subnode_to_map(pctldev, child, map, num_maps,
 					       &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	/* If no mapping has been found in child nodes try the config node. */

-- 
2.37.1


