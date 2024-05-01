Return-Path: <linux-kernel+bounces-165292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA348B8ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF61C21BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B912E1DB;
	Wed,  1 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JDJ3tJKS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132612BEA0;
	Wed,  1 May 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568046; cv=fail; b=E8JswDB0VRuSKY3Zsn8+2EA1J+qrmx/KdoIUx5YOIkTDAW6AFnTjR6DT7y5E3O0n8/dJAgxWqU7UNbmUaG90PIIea4jt1fCo31/7FEOgnXL5n8uoEyplwhkQ6TvPSFbEBLTEKL/bShjPC2D5mMP1/v//JwM9iMsM2MZ/iMFAFNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568046; c=relaxed/simple;
	bh=Hg4Xy0vEppWnC63RFatzWPhpn/VvXfklWFuoj2CIg+Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fzaDGuXu3gx21rc8RIV1SPUvAM7AebfW+SYKeC4VkQIy8nENyI2g3OpX1GU2DHbCdmvFrqfjEZVRBp4wJlWS9odRlNqDXCLbLXU9TR6UOAu7CAp6udnhUdZtDRpH1qHk96t/WqGvd3vdXdJ7TmDCk79MR7zPphLxplQeWb9WJdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JDJ3tJKS; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aalf/pOql47GT5ltrEi1+Eny9g+kb6hmT4tgQ3lLG1eBdZTBkY2/+o+z5AmkllwxQZkAkAM4QzrIfg4oWz1ZvJWbdJMUNb5x0EkWXaIof5GJv1y1f+TYeshPXd6qE1rvSj/wY9BxqL+Korsvn1eQTMSC3LAdpIUtt/RRZzD5IfoYhTuK+T3VX7u7onYrp8OtLGHgQefcxQf2i/nzDu2ifabuTssTAGBBOT8jkOwaDW9ZiPQvsz+eJeu7PeS8pgXlyzMP/dXNQsNMCUtPxfq4n2f/AZIG5Yi7U10T7izh1ufjQb2Nc9/IxpsfVNKd4Jnl1yUST9hdvi9y2iSf4VSHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzFmWqqgAaHNbNJ4y5r21eHdO5OywXD/utfmPqrXP8Q=;
 b=oTYVIYaIEia1c6xCx3wSRZ/wvLbfzd1nWwUxdeqcuLBx+Si17fPfRyuLz+t64RXW8czpyAhdDHXACBie25R+cnJwBaCj/sf4f1gETDuNOg1sE9ppmTtTXAeqpIDsPIjOlQZjkM5o/ehbNJCUjhhMx/EgpOby5mNi7bk5l+kzaHxIF6RoC2vRZ6xWzDglw07z4JL1or/NK8ZbWOHuge2Zefg+jMsYQYyCH6sPSaWNKx/SSInjhUx+anoEFomB/nRGcYvm1FmmhG5c9Ks85NOmCfBlPPKjdu3eJVMd4HLPDh6BTAOqd9I+kHp/Pubc3hONpw/85JM4Yd8Be9VK0LObrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzFmWqqgAaHNbNJ4y5r21eHdO5OywXD/utfmPqrXP8Q=;
 b=JDJ3tJKSv7ITKll9IdzYp8RkMp2A4rMq5J2SRZQVUMx5todwNBrKZOGjRm34HacIKopamUcIppjn9B8DkzdS6OQ4K7mRk8xaS3kLlEdvNlfawGVRviSIqa6hgzA6AnmLFPpTqWJElR1EQWnSv2HJ+MbR9Qh0O6cWbaEWFnX689k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:54:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:54:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:19 +0800
Subject: [PATCH 21/21] pinctrl: pinconf-generic: Use scope based
 of_node_put() cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-21-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1107;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2wM6S75hkeICu8KMVBGWw7nINzfNCEUbOtGveeJZglQ=;
 b=Fst3hl45iGHgFaoTiJF+h16Ucdgm/tZpALLXVlVt5L+nhkjqsyRRvNK9ZdG7OKgMxyr0zBvOm
 dFZohN5Zm5QAMChdlPzaw9SqDpw6GAaAdpZSobM0eKkl3aXOvSnJAOJ
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: aa011eb6-b045-4e93-0830-08dc69ddc61b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFpqNGRmTWRtU3lGeEppNk1EOWwzSW1MckY5NCtQcDRMaEJhVTM5NSsvL2Qx?=
 =?utf-8?B?emE5TEdKbDl5Q2JrZDVFZUtsYjZ3NU1kVFhhdUVUUEJxaG1rSXM5L0xWUFpO?=
 =?utf-8?B?eE1OUWFRMjNpdXgwbkMwZjhENXBPV0ZieCttWldCbWlvUkN0bUVKeDVWMFNq?=
 =?utf-8?B?aXBrRGgwQ1RWTzBJZlEyZW9ZeWJydmxhSURpczBhakJyMHkweUJKK1hQcjds?=
 =?utf-8?B?ZFF5Unh2QmlWK3hMT2Njd29YSTExQThVdGppUGtFWDZtRE1kZ3hrR0xJRlNz?=
 =?utf-8?B?ejNkL01tUlo5MDNkRGQ2ZTFtQlllaVFHc2VIejVWdDU4R0srdFJCWGFXSkpy?=
 =?utf-8?B?b2M4RjhXS0xuVTNoSEk2T3NZVTRsZnhiQzBrQXlDNU1veVpKQ2hsNHZQRkZt?=
 =?utf-8?B?R0gzbE9UMUhlQzJVTlprcDdrY1dOMEk1bDVFa2wwbjcvRDhBY00wYUNpNjBC?=
 =?utf-8?B?bWswNUFrNUMxRWtjNkg5REVwZWZ1UVFkQ1BEUXA1NlZFYUUwdXRjNWJxNkxJ?=
 =?utf-8?B?ZFo3QkZkNmF2d2hrb3NNK1Z4N3R3MFNXN3FqMUdHNE91SEFLN2M3aTY0RVdV?=
 =?utf-8?B?Y2gwOXk3M01rZ3lpb2I1NS9kWU9Cam1GZWVPSW1xQ3FpdHZQcEoxNkk3dHhF?=
 =?utf-8?B?aDczY1l1dHJHQmJYWkdTQkxObGl0dEkwTUp6RjVkQUcrcHZzem9IUFhWa0pG?=
 =?utf-8?B?KzhLa1NKZ1BDTmsxTmNVZ3lHWGhUdDZTWHIya0s0U2dPclB4ZUdUbTV0V3lZ?=
 =?utf-8?B?R1VqS3BxenRBWldVREgxOVFXSVkzSjRmWmg2NEc3QldkMGJCbG5RNUhyczJD?=
 =?utf-8?B?amxMaXlLTjIwaG9BeVZCS2hCaGlzTTlPSFRGd3M1R1NpM0lPeW5tUmttNVJU?=
 =?utf-8?B?Q0tuUGZRV3BFOWI0N3BvRzNjaWZObEhCMlJSZWtiZllyTXR1UVlkTnhZd2ZT?=
 =?utf-8?B?ajBSSVV5ZjgwK1FiOVpyeStrcFhxTnZSeCtlNnRpMUxwZ0JVSVJ4OFRJaWQw?=
 =?utf-8?B?b2VrdjhDMDRaeFNOVmRYVDFIMExyMHhxSzJDSDVsclRySDdUdGVNLzdrVUtP?=
 =?utf-8?B?aGtGTFVzMlVQQWcyWHdTc1hIL2VUaGw1YzFOU1oySlR6QlBOaktMU3MxSWFr?=
 =?utf-8?B?M1NDZ2Zma2FScGZTMGY0QmtQc053QXVwQXdpRmFwK3Q0bFU5bjh5dUlFNkk5?=
 =?utf-8?B?cENHaTYrVXlUMWlybFZpUTMxeFk1Zm1FWERyNE1rVHVPOXdacWZuUHQ5ZVRh?=
 =?utf-8?B?a3laamdZa3NnMGY5Vlp5TzU3elBFMDROTmlvaVI3VTFFUk12cFNLb3BoSVM2?=
 =?utf-8?B?Y3ZDNGFzUHdyMzgzYSthZ2hJckRKcUxRakJIUmp2K1d1RC83cTRXYnZrOEUw?=
 =?utf-8?B?R1dEcWRjWktMaUlTeGVmRTd1TEtLZDVnd2FaS2xVSFh1U1k2QW9vTzBINmt0?=
 =?utf-8?B?ZFNYZ296TVJ2c0RzNVFTSm5NeFE2MHZOOEdRVEY0UFhiVUkrNGlUMXZ0WGFj?=
 =?utf-8?B?MmtBVVVVNHluRy9vdC9JcG1lb0YxckpMT3c4eWUzcnRQK3ZMUGw0ckp0Q3No?=
 =?utf-8?B?T2ZXWnhUdkY0SmRzbXJBMTZIUytUZEVBS1VGMjhzZmN6UE5GaVQrTjNpQVA5?=
 =?utf-8?B?UkpacklSU2RVbWRrTEs5NysyRGhSV1djUnQvM28zMDB3Q2pTcnhJYXhEWVBQ?=
 =?utf-8?B?QUZMOHpZSjZJR29taXMyZkowR3N0aHJKNGhjdURrQWJiYUJTSjRwcU0wTzZV?=
 =?utf-8?B?cU1veTA3ejg0Z01jSlEwUTk1SWJGZTcvVWYvUjVwRUZ6TmRpT2VHK1ByeTZ3?=
 =?utf-8?Q?DFh7R+aqHLm34ueiBA+hALoXYKGBdcR2huZDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3lCMmtxNllJQ3l3VHZkcExKRElZUGdEd0k3cTFEWHk3eFNRUmlnSGwzNFk1?=
 =?utf-8?B?b0FWWld3aUY0c25ucjdaMGh5RGhJOWV4dFBIZ0JoUVdiaitGemRjQzh3NE9z?=
 =?utf-8?B?LzBXRXZKL1psbnRpMUFkNzJNWXZWcktXVmNRNEtaNUhDZ3J6Wm8yalVrUVVU?=
 =?utf-8?B?WVkyekpMeU5DQ3J4M1dYM0hoQ05BWkZ6Z05zeFdSVFVQUkR2WUZ0V0xoSVZX?=
 =?utf-8?B?ZTJndGhDV2dvVnN6Ym9QSE9lWEFoUmFUdkhvYVlmbzI5LzdoWnIwQnhZY2cw?=
 =?utf-8?B?dGRRQjZLZjFGYU91VWxVbGVTTk5RSllGKzhNRUVkYmNpK3JESzdzNVNpSy9O?=
 =?utf-8?B?TXRXcGxUeXoySk1uVlNKQ2pPQTZnaTVNR01ZbFUvSEFVdkdiMmFZeGNRUktQ?=
 =?utf-8?B?VjdxTDlvMXE5c0VCSUJwb3h3MDJlVlg4anJ1Ym9zQjVxT0VHNXFSaFZaS0gz?=
 =?utf-8?B?WG9zVS9kWUJ3NjRYaG1Hek1DcDJBYkhoMUI5eVFSZmpUN3pYSkJHWit4YlVO?=
 =?utf-8?B?dkxQUWZiRHNxeUJHYTN6ZG5QcjlZRmJNelBJbmtkcDZuUVRqVFZDVEdkQ2N5?=
 =?utf-8?B?NEIzcjRobFk3aUxvanYrZ2lmSGk5ZjBWSExwK0E0TlkwK1YrTTVPNFJ1WDY4?=
 =?utf-8?B?bTd1VzVSejBOSUxnYk5XVFJXQ3FlZ001MEVZVU5TMVhNZFh3akxnOHlZYTFn?=
 =?utf-8?B?RllnVUtRMjNLL1lkc2MvVmg3Y2x1akF6S1JGeFNpcFdYV3lkMHZBaHN6bmx5?=
 =?utf-8?B?VGswTmtNOHRSYUJHZDZTQkxJTmVTbU1PZHlpeitiNGVTOUpoVGJtRVdFa1Zy?=
 =?utf-8?B?S2VIUnc4NnZ6Y2E1WnM5UTEwcWR4VlVFbFgxekxOZTZRVk1MOUdHd0o1L1oz?=
 =?utf-8?B?WW1ibW5yWnZPOTJnWGNVdUZSTW1XYU4xQkc3TzBoeFNhalFXZjZOWHJPaHlR?=
 =?utf-8?B?VlpWVTlxSjJSTFVEOFJiU2prZE5UN2tCQ2FRd1ZMK1JMU0JoTmZwRUJWMDcy?=
 =?utf-8?B?NU8zZm1wT05IT2dPU2xqZytpOHA2ak5IV1FrQ1paYTJWMnVVdEgwTlZ5TDhk?=
 =?utf-8?B?TGx6VW4vdEhrQVdaMmVsK3JBLzFCaG96b0Rxcmx6c2dVdXgyU093S1F4RXl5?=
 =?utf-8?B?WTRHNTlXeXYyVUVmK0RMV3FMNHp6M3JYall3RUpOOStVNnFJTHlHUi9NMm9p?=
 =?utf-8?B?cHZMVFRCR2ZBOVlXeEZHN0VWNUNlT1ZYRmttSHN6M3NRWmdLcUZaUWhMYU1y?=
 =?utf-8?B?a3VrNkFPbEZYUk1vZHhZMnBLY2hJS3BrNTdqY3k1VzRFNGtMQXN3MGN6b2w1?=
 =?utf-8?B?ci9pS082UDJ2VFNKZG5aZUd0TGVleTVQTlhiSTdBQVh1RTRzcC9ZUFlGMUpW?=
 =?utf-8?B?eDQrMzZuY1d4YndrbFR2TlVpTlB2eHZ6MlZ5M2dObWg0Zmhrc3dtQ25hS2g5?=
 =?utf-8?B?YVBkaXN3RXJOYzd4U0QzNHEyaDVDM201OFJSdmdGdWhNelVSeS96UTFKcGN4?=
 =?utf-8?B?QS9Kd3JWU1FjMENpWmlXZlRlRnNWc0tIbWtBS0tjcGs4U2NJR0E4NWpORDA2?=
 =?utf-8?B?ajlENXgrTG5yNzg0NTZYb3RMQzVqcnZSYzhsTlNoSVFRMklvbjRhem5LQ3FN?=
 =?utf-8?B?aitHQUg3L3U5ZEVtaE1ONkNONGx4V296NHdtWkllK1M2d3ZJTDBnZDBmVSta?=
 =?utf-8?B?YVVJRE45M3lRVExhVWxEWVNmU0s2YWFiWEJOcHZGUVcvRExYdHZKQmFqSjlE?=
 =?utf-8?B?d0lTTVlJbXdKVFR4TlZ3Zm9jK3lXU0VFK2c2S0ltRkZrbnpaOVJVNFdzOWxP?=
 =?utf-8?B?bzdkTnp5MmV6bkJYRmxkalNkd240N09LdEo2UTh0TUgyVU00YWZlL2puTUp3?=
 =?utf-8?B?YlFRZS9UaS9ldTZPTmJyUFloQ3BvN3RoakhlZVBlK3VWSTBidWtvS2F1YTh2?=
 =?utf-8?B?ZDh0SzhWemMrbHU2U2JwUjRFUlI2N2hobm5ZbnBwb2hSdlVYNzhZNWdRcDNl?=
 =?utf-8?B?b1RodUF4OHBpMzJaME5kaDR2UDhxQkVuc2o3NUdXLzZNWk9DZVo1Z09yYnJ5?=
 =?utf-8?B?cEo4QmxUOTBFZCsrS0tuVTJSMW1CQXlWMG1zMFF5Vlp2MlhNZUgrV0R5blNZ?=
 =?utf-8?Q?ROEgMVxQL9XNCr4Ol96pd4sJ2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa011eb6-b045-4e93-0830-08dc69ddc61b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:54:01.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIlETgYicOXhlsUoUZ/2k7SDvKOTmE/R5jtZBOI7DzknFcGm9/UrdoPMVjPu0KuJaiNr1Qn21skLWVl6yPQcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinconf-generic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 80de389199bd..a499b8af5c1f 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -382,7 +382,6 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 		unsigned int *num_maps, enum pinctrl_map_type type)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
@@ -394,13 +393,11 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto exit;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = pinconf_generic_dt_subnode_to_map(pctldev, np, map,
 					&reserved_maps, num_maps, type);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			goto exit;
-		}
 	}
 	return 0;
 

-- 
2.37.1


