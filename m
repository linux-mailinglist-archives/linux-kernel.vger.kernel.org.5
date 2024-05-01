Return-Path: <linux-kernel+bounces-165287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E01F8B8AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B01284976
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDA129E74;
	Wed,  1 May 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mrDsVXkm"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4C12AACA;
	Wed,  1 May 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567982; cv=fail; b=LRuJzlQed62HDdiTUETeaO2tia7URAcgGuOnvTsduQUNhWzd+pIxLmAog8a9VXN8F7iKFFpkxoQp1t7qg9rmhGU+Qq0LEn4OVsgI5iCpWsRd2wHEZtwx7KsJPaYyAY2aqZuIM5LraiXr8ZtM93BeOICD0zJXzooH+5t+Q0mwRCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567982; c=relaxed/simple;
	bh=aGocML37yKFLTQmAgdHIf5uoWsvtHUPQJME8EyVoT6s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GcVYZi/8qxzKcEbgOEd8ywBiG3t9m288Kscnsj3YceEw4YiiJKCQ9mkAKQDD5m6fu9nKCP5wRScUf6gKLBHFyhMX8epziRJ5fQnAEoQFotuxGgqoWKW/ym7NredMLMBadkOOq5oSEicNcrXClgnJbH9Y0ahIBWcTHpq4FvL9cTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mrDsVXkm; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpUpPWj3LUslORyhU7NqW0Z4XFf8H/CovD6oS76C+83yPoJscaMhBLW2LhlsK93q0el2gXTk0ZbrBtvUbvpSPwvNmYVJ9xkoIJMA628vKB4qFl125ZAyJn18sxfB/kqDJck8/qKmPYvWRvGVUNt6tDsJUPQUdihY61NiYKEGc5gJ/fSAL1cH9VZhPjghPD18l8p0YoH0Hl5n289qckXtQAoQIB5hTgGSoU08IpLOgO7NXPWFmou4vmG13slj0KCx89o2C2vQWizE+1u4twKLHbpX4rTWKTZvx2/QAnq4UvVb+e0X2sQgN9NAtHXmrjzH7cabLT3P1u7T8VqUUorFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyGeWpCkYZh4WcKx5URim9X/pl2xw38Z9ho8YthB/aQ=;
 b=dZtKs39o1PgE1rl4YWTIZUQxv2i3w+xckFaDakRDfx50gW9lAyySMsfFSidtvbgOYhYCmUiR49C9yklB3MVOQE2uIrdfkKRJ4X6nGU+QJjFRBLAMh9G17WT4fxEwHNNU3mPD9hhN4WHKqAIkSdI8WPYOdburywYAlmOuUhUEYYkkpgcfOiVMuyjjGdBkIi4tq8oAnrL0S0yqBpv+gBBcaRLRxxpuyCVlMoAbtzEBLhHvV0bRNwKMPL3NTI6dMYnstGuCpkZwMOyRIEd9N1gqi1lkiIMJv/IrotZtDCD6yrYE17ogB76mReUZSAdKKSs/uyMG8Y3C7OLQ2xpvHsd+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyGeWpCkYZh4WcKx5URim9X/pl2xw38Z9ho8YthB/aQ=;
 b=mrDsVXkmUtziBoSBdjyLep7uqWVO4X5qKWOAYEszWk36fCksuvbygikVuT8Kke2s27TrfTKtCT9NqFDzrHvOX1f/wH/FNKRRKsGUC3x7/eIzJk1gY589zToZeZ4iLFja9Y3sP21qyn3B/9489XAxhk6jZu8+dlmncv7ApZ9gRZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:52:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:52:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:15 +0800
Subject: [PATCH 17/21] pinctrl: mediatek: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-17-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=2143;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lm1PEdHATfoxwJUL9YMs41GxvVEK/pacMdZ5mWFlWX8=;
 b=9opStnvvifVa3C/7Di6MWEQ5dybv+YMYe/v16eI3vkA8ELbqt3EumCOS/cY4boy3ZcVAxR+Ys
 /w1RPbIr2kdCf3yCOuLiSFTt5g7rwevE2UcF77MN/YvcE4IrIOWCqeE
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
X-MS-Office365-Filtering-Correlation-Id: f1a3651a-3d30-46cc-ad5d-08dc69dd9fc2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lMVzdHbThCcUgrZlVaQlNSL2NBRzdIZG5ybEtPaWpJanBhUnZzb01PUzJn?=
 =?utf-8?B?bjMxYnprSmFxSjJYNTBPa2xEeTFtVHgrbWZVejhIZlI1dTBES1BpdWZwRjhy?=
 =?utf-8?B?WVBUa0hxa0pXYWtHTktob2VIUzhBb3pRSzRqdlA4a2hIeFdGdXVDZ3lHdmxp?=
 =?utf-8?B?YWhUS2doTnRtdVRuL3RmVGdjemx5VEJLZDZYbXF5MGVhdC9OK3drTVlTTkpN?=
 =?utf-8?B?czJhZUc0Y3ZPeWh5RVFQMERQTlFzMmcxQlJrMldNUUhlbEpVd1BZeFJ0bE9D?=
 =?utf-8?B?QW4wU0dUeGN2U2s5N0o5bkEySElmMnZzTDM1VnFSdjFHa1IrRWFkTzkwd3Z4?=
 =?utf-8?B?TDhxTm9VMExGMjJpSnpMQ0E1VW56TTE0V09Fd0UwVjV1WnQwYUM3dWZVVHNh?=
 =?utf-8?B?d0tabm81SWtZc2hMdm93dlQycWJhbk5xZ0I3K09TU3JsYUhQNnNjVEo0cmRm?=
 =?utf-8?B?TG9oanVyZHF1L1NaZkxkNWZqZjNlb2d3cUJaNE9XVStrSC9MZ0tIeEQ2V2NF?=
 =?utf-8?B?MkRqMTFmM1hiQ2lTcXhIVGQ0eDFsb3BDNVkxeC9wcWFrKys0V3g3d1ErUHJB?=
 =?utf-8?B?ZFNGY0FtUURvRCtTaUNvbXY2YzNXd3hNOHo0QmhGVGJTemU3UWEzSk1OR2x2?=
 =?utf-8?B?QVY1bWMxNGpCeHgyN004WVl4a0xmTVc1dzlkMGJKaWNxbVBJeDFEMmxKNUk5?=
 =?utf-8?B?SXBlR0FnZjNWVGthWDlpREoxSDc4VDhEYlNCZkdQYVNZU3FEV1lMOXBnVk1L?=
 =?utf-8?B?RWs3SXpiVHVTV0swdExnelRyMU9aWmVrYjJJeEhFOE9Gd0lqbHhWVkRqcUhp?=
 =?utf-8?B?TUh4cHJVUnZQWXRTd0RhYWE1Smk3ckZMUVFvd21weTV6aDNzK3hmbGVjRkU1?=
 =?utf-8?B?NmUzc05pT0QzU2YxTWo1TXl5b0hUdUg4ZFhaTFFiK3kvWnhOa0FHWW1YSFRw?=
 =?utf-8?B?Y280ZDFrc2pJbEdCaGVqNG4zVW5iVHoxQjI0RVBhbEVyelNZZUVjNGlMWlQz?=
 =?utf-8?B?WnZIYXJSb1NqU2tSNlRzcEh0TUNLc0c5ck1MNFNrSGZKbU1ZVGdiNUJlUEJo?=
 =?utf-8?B?MjdrOTU1VlhlMmtJclVYZHBHeWhmMTlEYVN5RlFpclBnYmlkRVh3QkZseHBS?=
 =?utf-8?B?SUlUZWpab2xha2kxTUlLZWIvQVhNcERsa0txekxEcHBjcjZDZ3l5NkZkbCtx?=
 =?utf-8?B?M1B5U2xaWFpWTFJ3UEtxZWNtQ21zWk0rUTh1RTZ0TnhSTnI3L0VUZDFoNmZE?=
 =?utf-8?B?dVRONXVPb1dBZXVCeXczOEozaEFhK0RuMXM1eTh0aVhhMEpDMTRnc1QrL1Qr?=
 =?utf-8?B?WGRnellrRWRVdkdrRHVjUEloUksxTytNUGpQU1pNQ05iQzdqU2QyaTVQbzhu?=
 =?utf-8?B?dU5kY0VEQlcwNGMwL0pVSGRhVzQ0VHZXYkZnb09Rd1VqVHlwS04zamhKNXUz?=
 =?utf-8?B?SUMwS0UzMVNyQWJOVWxaaXVsYXZsOXNidFpUNlVHeEo2VGVvMUJpTnBWb0xn?=
 =?utf-8?B?dytidXprdDVOUVpLc2hrZHZkRDEra1YxMUpnYVNVU0tzb1RDQTVuNmtBSlh4?=
 =?utf-8?B?TUEyRi9tTWdwdG5GRXg0VG5mcHM0a3U3bExCZEY4bklzRlZBTExmTVdRYkgv?=
 =?utf-8?B?Y3RwL1VubzhWUWtNMUFhRVZOR2ExTWNLQ250cHZtdFVvVW1rZE8yVm1EZWlv?=
 =?utf-8?B?ZGZWWDJGWTZ5bGlMQ1FmWVM2SndSU2ZVZXpRa0czcEJxZHZSQXljc1p0RHhR?=
 =?utf-8?B?OHlsRjJxL0tVQWczR2ZTRDlYSk5WZWY4VzBGRmRhMlRNOStOTnptT0c4dDBK?=
 =?utf-8?Q?V65tZJfkZ6dTArMu3qZt5tWFQDG5QRUgV4V3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtMNXU2SFFFaXFRcEJHeDFQU1l3amJ3ck1aRWVsVHhqYzUvVFZmTXN5U1l0?=
 =?utf-8?B?aEl5NTV6UjRnc29wMlpUelYrdW53Q3NWK1MvbUtQdVhycmdnTU5EdWl2SUYx?=
 =?utf-8?B?UnJJSEVQN3R6VVRGeWl4SlAxT0VSN3hVQmdHdnMwVVdDMU10SHdka2syRFFm?=
 =?utf-8?B?YWtLdSsvZzBZVW1hRFQvcWI0bm5hNFhDYVVjZTFTcFkzWHhYSWI1ejR5QU5q?=
 =?utf-8?B?WXBDZGNYc3EzMUFRSnVqNmJ1QWlNenJndzYvNEFRcVpraWlVN1hvaGdlVXhH?=
 =?utf-8?B?S0lIdzV0ZjI4UElJeE80THh3K0xWb1VNRXZKRENMV2lvcVM1MTlzTWMyVlVw?=
 =?utf-8?B?dUsrcG1oNDByUTJZWmZFSndYVnlYRkxuNTlGa0k2bHAyc0dFMU9KQTZ4cDlp?=
 =?utf-8?B?QnBHRUtPQW1iQ3BYNUJXaVpNdGlHcWRXUG1sWnVxdlR0bFZZbldBcXlNd3JX?=
 =?utf-8?B?bDJyVEJjNWEyREZWbk1sZ3A4ZWRHQzJITzVFdTY2ODJGK2VPV0pMejFUSnRY?=
 =?utf-8?B?d0RTUGd3N2ttbTVUOWt1cGE1SERwSWJYc1ZFcEVlcm1EMjIwdGExRnp3ZWNT?=
 =?utf-8?B?QnNsQngxTzBkNHdRR1ZNQ3hiRkhUeTdiU1pJbkZMQjN5aXRYWTliMGlFVk8r?=
 =?utf-8?B?Q1pYWnRuWXJCVGx1ckdPQW0yemJYT0xvNW1nemRpMjhGZWVYcFRKMS9iU3Z3?=
 =?utf-8?B?SmVDTDBpaVdiaGdRQlBhWXNCMCt2VkhPbFRLQnplMDJkYjhqUlFwNXZRdzUw?=
 =?utf-8?B?RjcrUTE0R3hNc1Q0aTIxOGo4d3haZzdwNy9GM3R0QndRT0VpUHRIdmdlbU9m?=
 =?utf-8?B?dHVQVGRBMUxYZ09wOTM2YU5FK0FOL3hFVDdEb1J5NGd1Z21yV1N5aUtBWDRN?=
 =?utf-8?B?c3djQms1T1dzZUhlb3VDdTNoQ2tpL3kyR0NwbkdwQWpCY053djhpRTlZcjUv?=
 =?utf-8?B?dEpRcWxSNDJlc0hjMC9QNVhDOERweFRIRURUWEdwbCt4VXNsQlo1MlViUzRx?=
 =?utf-8?B?cXVzK0VhM2ttYlVsRE5XZWJtWm1PRitFeEhDR0JDZ09ocjlwcmpFRnBPdENP?=
 =?utf-8?B?VHBrU2wwRmZkWW5Wd0hwOURBOThwbzFmTTZJNVlud0FxYlk1bFhSN2QvWVFm?=
 =?utf-8?B?cVNhZnd4OWoreEVRa0RoL1pST2lRUWJSaHpKUUw3ajU4QmE4MmRDaEdzbWZh?=
 =?utf-8?B?UEw1WG5ucXVvekpqUUk4VXhDL2tSL0tGdlBaT2RBU3BIMzI2c294NStveWxm?=
 =?utf-8?B?SU1WL1IrdGZHaVdyK04wQy9LVGVORjdvL3RsbE9YN3poMDRaVWdkRW5GQkk2?=
 =?utf-8?B?MDNLWUVnam1KWHNic05WNWxXNHNjY2VQK3dENi9kQ1RjeFNaV1Q4d2FBL1U2?=
 =?utf-8?B?eUJFUCsxVlFQYmtHWjdmSStJdm1VYXBpbUp3d2lpMG1OL3I4WGdOdFRmNHRK?=
 =?utf-8?B?KzJzUlJqR3BCYzNyRG5sbVFXcUNpVk8yQmRPV29CR3pKZGY5R0V6Um1hc2Ru?=
 =?utf-8?B?NXdHRU1lSzBucW5ZbklPSCs1YXVEWGd2d3daVU5veUdybkhPMGF3b1VOU212?=
 =?utf-8?B?NUZkQzRKRmVjcVFWV1N5dlJJcUU3cjF3cGxGRFRsZ3dQcmJhd0xKNlZlTGdY?=
 =?utf-8?B?Q0FhZG5hdjVLdUhBVy9ZTW1nMFVzQS9YWTZ6U0kya1hWNElJME9kTkdVckdC?=
 =?utf-8?B?N09TT0RqWDVHTTZ3bExmOUVXVHhMRDVsVGYweEVPZ1g4aFRpRkJsVzg3Z3VB?=
 =?utf-8?B?UlNnQkNmNEQ5K2xtdGw0SDJzMXpJWGVCcEJSSHRMRHkwY2xGVFBmN0FwSGI4?=
 =?utf-8?B?UnRaNDBJelJ0S0k2WnAxTGdBSzZXVjVZU0VycjV2dFVtRWlQL0hhTG9KME1u?=
 =?utf-8?B?WnJEZVM0ak9hTnp0OC9lV0NXZHlsVHRrcURYYUpYb3IxQkM5dUxkckZTa1BZ?=
 =?utf-8?B?Mzk2UlhmcGFyOUx1VnpPWW5PNFpjUWpDM29MZnlTMkpmQ3ZMa0ZNck10b1hC?=
 =?utf-8?B?M2MwNmRGOWZrVWFybmljeUcxOW1XQkZoVkllUktmSGw1SENHVDIwNFMvZW9H?=
 =?utf-8?B?WGkyWEFTNzRDTzQ0a0Q5ME0wSUh4UFh4TnFGYlQ5S0xkcUlqOWJ0a3ZCRkxR?=
 =?utf-8?Q?PHA61ryC+yhtOBZ8pzmXye8wu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a3651a-3d30-46cc-ad5d-08dc69dd9fc2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:52:57.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3oLRc6l+FkKfo79zh0DsHLNILeEjROEGdxGeEg0+nNZJ2mSCQbwMXmvOULDFDez2sxfMOKB3TAK1TIdpXdBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 +---
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index d39afc122516..91edb539925a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -621,7 +621,6 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct device_node *np_config,
 				 struct pinctrl_map **map, unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -629,12 +628,11 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index b19bc391705e..e12316c42698 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -536,7 +536,6 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				    struct pinctrl_map **map,
 				    unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -544,13 +543,12 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
 						  &reserved_maps,
 						  num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}

-- 
2.37.1


