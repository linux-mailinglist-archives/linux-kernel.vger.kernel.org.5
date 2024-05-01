Return-Path: <linux-kernel+bounces-165276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268538B8A73
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D5E1F23895
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26A86634;
	Wed,  1 May 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zm+NsPPc"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93585659;
	Wed,  1 May 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567837; cv=fail; b=AgbFTqzkovjF94PYAaUSfPvbnel/N/RCbKIrS91ibepw0mI7YKz3h8xUPr9bPI/osbtRgEK2j5BPD8HQTV4kjes+Pco4XRavEFD/46WZn3ezZ8T3llvybfipFWykUtsE2tu5Xe6QeCv/kjrbt2+gF5yQP3Mtv4JKxesCkwAB6tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567837; c=relaxed/simple;
	bh=iX5zubnNbP8wUY0NaYvwWM25wwxei0v9ssdTCrvhdpE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=snlyFYhycTL6Ao9GTjIiy62YCIIFKyN/vJ/0cwexc/3C5fM1NB9g5jaumR/2H5C7SOkvCpo1fXyaZf0DGWe8gUDxhDufeIfPD2EkrNFPnSRCamHKjglb3pD0EZYAlnA0bWge7NDVbxKhzMEHatMvDaQ6gSkYu1AEk0jD6/oVBn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zm+NsPPc; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1R/2kBSygpawbf/OUdQzHQ8cQ643vlrYxy6pXl1/l1ON4OJzlLvioqsfrMReStt9XDLrf4ryILDcawhr27WTx8bebUSzgEdGUALzgDeCDRBbF+wTD0wZjPBTTFvtQ7q0S/rajXTrIXzton4inJuxl61cVlyLg8/lBxrjD+e4LnPvPh2j2XnRdXmZxF1/v2d1qhXCUqvMMIh7VZ5YmbK6wUvi4ANQoRCpn7PtPKvCwbHIJZFIYyAAlyv3lvRhMkTfgDE/jSdDGgUU0G7YtJqDwbjjslA23Zdio8axpWizDTlRLKZbeweoqlLRNhRjC+JHQSS8UtDz3bPjgvfbs8nbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y2gws/G4cgntx6EEddCXLTNXN/B4Rx9dThNutE6diQ=;
 b=iq0gi+X5N7Mi7NnfaHH1V9/sFOuQ2U9Ww0xT1nDaMNHqXbYUQtHIvHHJY+jij4BkkT7b7WDCxVbPeGVP9DZ6qWTSCFGXOw5gi0Z2N9pPUvIeTGDNbJmLxfCxlt//n+Lx3BdsQY3ID907DrZaKL7TNKQbZ+UZgpCDqE25EZ6Mh8RejuzS6UvzlhGj46ymvBsRz0o97Lc9NVlCsZlQNkCuP7ogu1ZqHEai9YZC2KGfkw9VEZQbSyt8yNPsEXHlv1xs2NJOZ6m5W5p1jgSjMXf+Sou5sy+6vCIRuUFbQgVHvTXl+1NiczKbIbo6/tzgGkDeARcdLzsSdjnD6gkGe1n9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y2gws/G4cgntx6EEddCXLTNXN/B4Rx9dThNutE6diQ=;
 b=Zm+NsPPcsYoi6mAXOX6uaMJwH+ovuA2QxuaOUEq/1u7KpzczHyQAfDM6BCMhDSdv8WNr8CQGv1PQIF0GBJ4Efcvp4ja/+p5G3wCpP4/vJxb3AO47VyE39qn1x7WNLTdy71eh7daN/nEnag8UFvmfnk7MNUiocdWO1nzb8sEJ8p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:50:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:50:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:06 +0800
Subject: [PATCH 08/21] pinctrl: samsung: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-8-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=7744;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VeeKDmVQFVd8U6dtzX+Yajlue65C4XZpXk6FDSk2jZ8=;
 b=GjOh3r0Wz3VqGH8e47xY8Tl+zHfs0c4a7emejd8aav46XxJ40wN5UDFD8JIY+5m4vEqAFIcIG
 Dd8NJ7mUJcTBSSvQGK6pnvQtPNFzalqmOpKN5v2UL0paRoMFo2tsXKl
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
X-MS-Office365-Filtering-Correlation-Id: d4d7ff38-bc6d-4b76-f92d-08dc69dd4925
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckZFY3UyQkNuNVJPR3lIQUlIbFRwcEIwdlRndGFlUG0rUnZZWm1pZmpKVnFW?=
 =?utf-8?B?ZWRRMjBtZ2xLRUJYd3BUeS9DYTRTTUZtbmdQZTJSR0cvcTFERTJNRTNSOStq?=
 =?utf-8?B?NGw5ZHE4T3k5b0ZYWENvdnFhODlhSWZoWUtCcjF1dVM5SGowOENjdlk5cjEv?=
 =?utf-8?B?S1JlaHA4aVdrcGNaeThYU1k3eFF3TEM2bGRIMkxMam91WUZXYjJTNDFwdGpi?=
 =?utf-8?B?QU5ON2dvVVE0aW1iWG8zQW5UWFd4ZklQRjNoUHlqbllLby92cm9HVmRYMUgx?=
 =?utf-8?B?bnhCK1pFRU1zZGQ2czJVT3NwcVlEcjlQRm5qSFI5bjErZDdlam9vZEtXOS9Y?=
 =?utf-8?B?Y2k3Y1grdXVvVHd2ajdLOXRoMmtSc25lTCtoYkoxMjJmQ3h2RlRKMHNmcVRW?=
 =?utf-8?B?RGdBZVhaSmJQWEVsQ0hHbkI4bG9VYXpEa2plQ1RuU0RHVnJsbnJVdUN2b2V0?=
 =?utf-8?B?VWRIQ3p1b21GUW82SEVvZmtsd3FoVEc1UVRlM0tBeEI4a3J1MWdaOFZLRDJC?=
 =?utf-8?B?OE1MRmNTRGVYZVgzWXlRZkNUMHd2azFuNVN6MDFUdGJmUmtGY1FxZ25vdGw3?=
 =?utf-8?B?UHl0WjVONEx4YmswRWpXcmtqZlhnRTlobVAxQTBpZ1ovSmdOUDJvN0o1Sy9i?=
 =?utf-8?B?OFRnT013TjRJVDJrbWhtdGxUeE9UckVFVGtSVEplbktHNjVWQXlGRVZhUVVU?=
 =?utf-8?B?ZXFzcHRMUko1VkZjZkNRb0lNeVU0d0g5QTNhclNxOXVKVWtqLzBuenRWaitm?=
 =?utf-8?B?c2RPb2p3dC84M0FWUWZiUVVZZldmSnVLdENmcGtUdXNpNlNvL3BTU3RHNzNZ?=
 =?utf-8?B?NEhJRDV1NVU5SnpqMjNnZXNhdk53M0VKeS90VHVYNWdTTzJJK1pNeHlFMWc3?=
 =?utf-8?B?SUhPUUV1NE9TK0NQUFROYnQ4bGQybnY1bHEzcE5wVURUZ2VvZzhSQkJ0ekNT?=
 =?utf-8?B?ZVdrT1pOanZ1R0lTN0VPWFVYYjJsWFZtL0Z6aWJ3a2JONit2bmx6ajdqbk14?=
 =?utf-8?B?eEF1c2l1ZlU1ZGRQemhHODFiZG44d3FvTTlLbS9NRFMrdjgzeUR3STZZa2RE?=
 =?utf-8?B?RnlEZ0ErUTBnODIwdnlacXZLeDlwL1VseWRuWm41Sms3WHR1UFFQL2FNMVd0?=
 =?utf-8?B?OFpZSUJrc0s2clVaZWEwRy91a1FMMGFsbFBtdWhnTTJmOFhLa3NuRGpFUGw1?=
 =?utf-8?B?VldhdVY5Ri9yVGZrbDlIaDZqeHhnTTgrSDE2aWpkVnNUSUg3OWdUdGwvMWU3?=
 =?utf-8?B?NnNSMVBhSDN5VUxSOS8zKzdsdDlNSUFZQm5WenJjWmNUR1c5VFNvV05SNHhw?=
 =?utf-8?B?WG1WU2RJZ3Y2cEh0NXBURWI0WGF2c3BHTlZWanMwNlRYRFFmd1hBRmYxR1lF?=
 =?utf-8?B?eWdyVXgxVGY4SzRBSm1zK1UyZTVGK1VwRUZsT003WjVtZ25CWlgvaHdFYU1K?=
 =?utf-8?B?YVJTZGg0bkdlTDloaDJRVjBxQ3hwRmM0K1NJRkJaZzc0L0MwTi9wMStHL0Jz?=
 =?utf-8?B?d25UREQ4TUFUZGVBU0ViNjJmSEJ1L29lQUkrcUJRVEEyWGF0eDNGQVJYSjZm?=
 =?utf-8?B?dVdDRUhKejM5Z0cyM1JEQjBxNmtJUGlzTlYyZkR5bHFBYkcxQUxlcWxHbklC?=
 =?utf-8?B?dTByTEU1QUt1cWxxSzhmdG5hc090dmlwRWRadnRpZ2JIa1NOb2RvOWhxN01R?=
 =?utf-8?B?MkhSZFdubVArU0d0V09hWjhYa2d2ODFQRzdQRnB6R21hVzE0Z0xjanRTbG9q?=
 =?utf-8?B?QnpkZkNOZFBtWm1ZVFN1RXNwUlBqQ3lrWHg0V2w1REF0bHRpT3V1OEYveEtS?=
 =?utf-8?Q?rNPg3e17qDPfYx9N65zB3Cm7NDsseR1hsaCcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXp5dUV6bVZ6S3AxQzhFb0M0STlLVndNZnF6T09KenVXTXl5bndNeVRrQjBx?=
 =?utf-8?B?WEcxVDJiN05rMXdFVndIOUx3OG1QUGVDaDZIRU9lMm1wdkZPQ1pGK1VKYVBF?=
 =?utf-8?B?K3VZeXJaaE9CdWNkallOcENkamUzTExDSUpaMmtyVG8zOHlndENkMXp3M0JF?=
 =?utf-8?B?aEthZU9iL1dJVUkxWWg5elpkcGZVVFlKZkZvYlJvdHFJeTNUQVdzdWxoN0tl?=
 =?utf-8?B?T1R0b090QlFFT1V2QkxOV1R4THNTWXN6cWthREc2ZGROWm9kMnZqV1hWRFdL?=
 =?utf-8?B?MDJMZHNMSDIvZFlEV3hINHE5VFRwN2kzcUYwTWJZT1pwSUZkN2lQSC9MZU42?=
 =?utf-8?B?MnZCRi9IdTFjMVdsVHNnSit6YjJ0LzdyamExR3pWc0tZa1l4Q1NXU3plbUp4?=
 =?utf-8?B?eERCc25GcmY2c0hIdHVaTWxkeDBwVUQ3RnBXRnVvZkhVWTJ0Nlo5WEtEZzZY?=
 =?utf-8?B?bXhDTU5JVCtuY09lcEtHekoyQjlpTytWOWE0L2Q4b0s5b25ZbVd6dFJlZHBB?=
 =?utf-8?B?N0doa1RWY3BIS1pVeW1FanM5NkJkTmc1SGU2d3dDQWxZRnUrRUVZaCtTQ3pn?=
 =?utf-8?B?VXdIck4reHYrM2lDU2RCRURhbnN6TlBxUXFmVDV0cTh2aGRaWWtkSUdPSEJE?=
 =?utf-8?B?OGxJR2RvdXJIRXhhN21pOWlVck9pUUVjVEN2N3NlclJGU0xQcWx1bEgyWStL?=
 =?utf-8?B?QUN6Q250Y3FxcWpGV1hWWGh4RlZnQXVzTkJRVkY0RjVmNWpuajA1VTBEK1NB?=
 =?utf-8?B?TmpZZ095aVNzeVBFbVd0d09xL2t5aUNjUSt6clMyck14bUVUUUxDS1pzcURB?=
 =?utf-8?B?UW9YZnRXR3Mwd000cFlZakg2U1hxZXdkbnNsbXlRSlVFcGIyVDRyRFhPTE1q?=
 =?utf-8?B?OXF2YTJtQkFVWjhvcTVlYnVLNFM1V3B5TFhCY0d5dGdTeGZ1VXptd1hacVVI?=
 =?utf-8?B?SnI2c3NHUUpEOHMweHMzUEJjRmt2ZEc1N3k4UmtqVVhqU0d6czc0blRiLzFB?=
 =?utf-8?B?aE9KbzZRa0dMRmNtYTlHNlIzYjVuRjZWWFhiSTU2UTJEOUZWQUNHdmZyRlA3?=
 =?utf-8?B?amp4OVc5RC8wTnVnTlhBT1g3c1pmWmNkV1NBeDdiYXpnUUdPYnJNaHN0VGpS?=
 =?utf-8?B?ZEgxOXhHZDhwb1dMTEtqbGh3MFRuYWJWb0t2MmV6SUZraHVkQ01OOVBVdjND?=
 =?utf-8?B?a2Vocll0SnlZc2ZkNG5NOTJvZEh0amppWjRVcFBianp0bjFRVk1oRWx0OTdo?=
 =?utf-8?B?d2JmcXVXTUhFeVNGc25WbDdOQnYxV3JrR0xFc0M2SDU0bGhaYUVLMjh4Q0V3?=
 =?utf-8?B?eDV3dzY4YlFrc1F2OURvRkxpWHBPcjVyODNTRGI2S05vTVR4SEppVkxyOGRp?=
 =?utf-8?B?cmQyRFFjckNkUUl2OTkxZmdKMVdCWVRLckE0b3BPUGNoYmhjRkVSNm9YaEpk?=
 =?utf-8?B?NURHaUFlNUNybzFGbE1mYTBOVXV4ODdRSUVCbTdqQVpiQmRlOHdWaDhVNDNH?=
 =?utf-8?B?dTByRlIrNGtXVmxqODNtbjZyeGZLRGJYT3hCZEFaSDBTQldvcXd2RzJoVjNx?=
 =?utf-8?B?Ukg4Vy9aMU5ZSlNzQit0R20rcDVXTHowWHhKT2haNTRpR0RVSDNOM1BZYk0z?=
 =?utf-8?B?dnQxeTR4Q1A3aFhtRVdxV1cvSW9JUVZrOTNleVlCNEQ3QnpuTW5wNDc2azV3?=
 =?utf-8?B?QzRPdWlvdHpsNlBuYW1aMFpDVWZhWitnTHB6clJJNGh1bklFWTZNN1JzY2xL?=
 =?utf-8?B?WDVPQ2dIWlZ5aVNaUU12b0VOdzdsdUNQdTNQSGQ1ZnFHakZKQ1hPdTFyVWJz?=
 =?utf-8?B?SVowcXAxTlZ5d2dya3VBZ3pIbjgzTTB1cVUrSUlnOGJoWjFBZ0E0ODNiNEpN?=
 =?utf-8?B?aENmc1hBRXV3WGVTczM0eEw4N1FGRHBIMkZmdUFVdE1KK0lDanJPeWpya2t2?=
 =?utf-8?B?TENWZ2xqazh6SXBBdlpYZGxJb3oyK2Y2K1gxQXBtaGJyZytBaDAwU2tKVk1N?=
 =?utf-8?B?eXZyM0ZySzVueGRybUQ5Y3o0RjFaWE9QaWZUS1dDdldrL1dZT0wvUUZPZEIx?=
 =?utf-8?B?bk03WTB0R0NvN2xOUWpyeHBHQUQ3THdzeXRmdmxGUnJmVzNtVWkwYSs1Yjcy?=
 =?utf-8?Q?3jqHc/Osx0qg3zIxztFOL9Cr/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d7ff38-bc6d-4b76-f92d-08dc69dd4925
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:50:31.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVJQm0zO6JyJOjmLH8XQzYxhYJZMbhm8xg/Gc9TT1Jygkr7A547REQ46IEaW+RGW8MU9K7FRr7slrJKBXFh+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c |  3 +--
 drivers/pinctrl/samsung/pinctrl-exynos.c     | 16 ++++------------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c    |  8 ++------
 drivers/pinctrl/samsung/pinctrl-samsung.c    | 26 +++++++-------------------
 4 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 85ddf49a5188..9a57b3ceb536 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -56,7 +56,7 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		       const struct samsung_retention_data *data)
 {
 	struct samsung_retention_ctrl *ctrl;
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	void __iomem *clk_base;
 
 	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
@@ -71,7 +71,6 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 	}
 
 	clk_base = of_iomap(np, 0);
-	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 871c1eb46ddf..3775999536e2 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -582,7 +582,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
-	struct device_node *wkup_np = NULL;
+	struct device_node *wkup_np __free(device_node) = NULL;
 	struct device_node *np;
 	struct samsung_pin_bank *bank;
 	struct exynos_weint_data *weint_data;
@@ -612,17 +612,14 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 
 		bank->irq_chip = devm_kmemdup(dev, irq_chip, sizeof(*irq_chip),
 					      GFP_KERNEL);
-		if (!bank->irq_chip) {
-			of_node_put(wkup_np);
+		if (!bank->irq_chip)
 			return -ENOMEM;
-		}
 		bank->irq_chip->chip.name = bank->name;
 
 		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
-			of_node_put(wkup_np);
 			return -ENXIO;
 		}
 
@@ -635,10 +632,8 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		weint_data = devm_kcalloc(dev,
 					  bank->nr_pins, sizeof(*weint_data),
 					  GFP_KERNEL);
-		if (!weint_data) {
-			of_node_put(wkup_np);
+		if (!weint_data)
 			return -ENOMEM;
-		}
 
 		for (idx = 0; idx < bank->nr_pins; ++idx) {
 			irq = irq_of_parse_and_map(to_of_node(bank->fwnode), idx);
@@ -655,13 +650,10 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		}
 	}
 
-	if (!muxed_banks) {
-		of_node_put(wkup_np);
+	if (!muxed_banks)
 		return 0;
-	}
 
 	irq = irq_of_parse_and_map(wkup_np, 0);
-	of_node_put(wkup_np);
 	if (!irq) {
 		dev_err(dev, "irq number for muxed EINTs not found\n");
 		return 0;
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index c5d92db4fdb1..9acf65eb0f5b 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -685,7 +685,7 @@ static const struct of_device_id s3c64xx_eint0_irq_ids[] = {
 static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
-	struct device_node *eint0_np = NULL;
+	struct device_node *eint0_np __free(device_node) = NULL;
 	struct device_node *np;
 	struct samsung_pin_bank *bank;
 	struct s3c64xx_eint0_data *data;
@@ -701,10 +701,8 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
 		return -ENODEV;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		of_node_put(eint0_np);
+	if (!data)
 		return -ENOMEM;
-	}
 	data->drvdata = d;
 
 	for (i = 0; i < NUM_EINT0_IRQ; ++i) {
@@ -713,7 +711,6 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
 		irq = irq_of_parse_and_map(eint0_np, i);
 		if (!irq) {
 			dev_err(dev, "failed to get wakeup EINT IRQ %d\n", i);
-			of_node_put(eint0_np);
 			return -ENXIO;
 		}
 
@@ -721,7 +718,6 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
 						 s3c64xx_eint0_handlers[i],
 						 data);
 	}
-	of_node_put(eint0_np);
 
 	bank = d->pin_banks;
 	for (i = 0; i < d->nr_banks; ++i, ++bank) {
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ed07e23e0912..4cae112ca15b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -250,7 +250,6 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
@@ -265,12 +264,11 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 							&reserved_maps,
 							num_maps);
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = samsung_dt_subnode_to_map(drvdata, pctldev->dev, np, map,
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -753,7 +751,6 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 {
 	struct samsung_pmx_func *functions, *func;
 	struct device_node *dev_np = dev->of_node;
-	struct device_node *cfg_np;
 	unsigned int func_cnt = 0;
 	int ret;
 
@@ -761,9 +758,7 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 	 * Iterate over all the child nodes of the pin controller node
 	 * and create pin groups and pin function lists.
 	 */
-	for_each_child_of_node(dev_np, cfg_np) {
-		struct device_node *func_np;
-
+	for_each_child_of_node_scoped(dev_np, cfg_np) {
 		if (!of_get_child_count(cfg_np)) {
 			if (!of_find_property(cfg_np,
 			    "samsung,pin-function", NULL))
@@ -772,7 +767,7 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 			continue;
 		}
 
-		for_each_child_of_node(cfg_np, func_np) {
+		for_each_child_of_node_scoped(cfg_np, func_np) {
 			if (!of_find_property(func_np,
 			    "samsung,pin-function", NULL))
 				continue;
@@ -791,16 +786,12 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 	 * and create pin groups and pin function lists.
 	 */
 	func_cnt = 0;
-	for_each_child_of_node(dev_np, cfg_np) {
-		struct device_node *func_np;
-
+	for_each_child_of_node_scoped(dev_np, cfg_np) {
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0) {
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -808,14 +799,11 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 			continue;
 		}
 
-		for_each_child_of_node(cfg_np, func_np) {
+		for_each_child_of_node_scoped(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0) {
-				of_node_put(func_np);
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;

-- 
2.37.1


