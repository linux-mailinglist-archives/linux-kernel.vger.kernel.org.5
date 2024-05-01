Return-Path: <linux-kernel+bounces-165274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B828B8A67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D441C219A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04827F49F;
	Wed,  1 May 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mP2fBb9I"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1F1EA84;
	Wed,  1 May 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567804; cv=fail; b=ENPlDDpJ7vqJTbhzs9lgI7Pu+1iTVtnGC0cLS7no7Cbq2Ke/Ijw41cnFSx4NyYuXiCppjhEW73b7V9r7mN71aPrd9TMDP7a3XR8xDOsGlZpBZxRQeVOF3PyEP2fzgLP1NiypQFBdOuYER6/7eGPh72aa0rrIVEb3RCBpT7vSZT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567804; c=relaxed/simple;
	bh=8+3VXwLUrYD3nDfOr7HntPuhh41zJEyci3faFCn1b9g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZKPorfMwkw/QXH0MmqK8z3w9BXt15W9GNKDwcuj6lEKDbsINB/H3D1XEm5oeBE4Ok3AlwwzxuupJME9SeahbP8/KfoqTzY6it45RY2uFl8UU8RnXz4QKCKkGxNnbrvl5MvulN5TMXgGaLzlSvN5kpOzwu8sGwESKlVLKIiu8qn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mP2fBb9I; arc=fail smtp.client-ip=40.107.13.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhv1eTm7xvunKW9nrQbYUw6o64/7RgXliZ2QCHTS2bxKvyHLwGFdX8dPqYPu1CDauO46kyGkV2lBJExChqWL+4+PAak0QMpvgTnwWB8AFNItcVpNEB8aDVq9mU8s5PLmUhxTpKWe4MWkf/T+Qy6Uz+QDfqQPC8v4QdklsHoPaQj2HPzl3EiC3GtD+WsKnayB2P+KLLyaPq4pPpGJvwWWWroYVH6fSe4Kld0KBPzn61688C0sZ7mFY9N4Wj3JafYW8RuOyoYUqoMJPa1z/DkQ4RdIajWMAq8dalZJlmmGNQ+9L+0rWt21ifKfGSYZBglaCAHlYHFxymjUGEyrMrlWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wlbn/xB/PZwPV7ROj5DqSEALVDss+DndXNnPfNwAESg=;
 b=kB1mwpdK6vW/OhPu1g5ZbbKKvNxrjbcs55N4d+z5FtBYh9KUvOI9mjriAdo9Skj/jBM38nlr+Sn3qSlGX7nkKcksYEwDb4znJEMUlraiUbLiFCIzWhxB5mO4XVeq8p674RX/Gki01hBCd/Byo+qrXszWHM46QPFjT/MwhZfjWzWKmYTA38Nvr1yeNFsrJ6BBVYkAmDUVpI7Hjc9YyW2Jtg7tlsn0lbIoM7jZcmR7M6quIFev291wVv7HH8LIpBoN9rOSsyfzripn54xlFpTxULydO7al2z7R5FHt0PmBBzBl5IBaVkRayXn/ikKDBhqQYxpuYHIwyut8M1fg3kZDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlbn/xB/PZwPV7ROj5DqSEALVDss+DndXNnPfNwAESg=;
 b=mP2fBb9II0l3GeKaliashAz8NJejLF3MK/r6w9BzUaDj/X7zXYHKb9x7HauCtaXpmfJo4FZbTXSn7gjfjmn9uRwzxSaQkiNJEtqxirHEfdcLS0A014uAFHK3GXynGnojTaoEziZLFfs8+i77ybXaQH37okheUM/Xg4Y9+IgXUS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:49:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:49:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:04 +0800
Subject: [PATCH 06/21] pinctrl: sprd: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-6-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=1540;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BMqLHOrX8EQjg9Z3uUGPLv8QrQVTIzjrj8QOQ3y5znM=;
 b=uzJS94q3JPQHLA5Dfym/hBeiB+V5HFBQEhABQJBlklJZsJPGzVQEg5YpRg/g13KZh31C77PmN
 EFur8rCNveRAK/bhsPtw3a3Fbhh+KOPCez1GBrD/0yhQsXLFPZg8lzr
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
X-MS-Office365-Filtering-Correlation-Id: 13bd78cd-48a6-4e37-ac13-08dc69dd35f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T25xdHFSOHZMczRGQm5lTU5nUjRqY2ZLa0Z6NHVOZUFrTWhJb1JuVUM0R1dt?=
 =?utf-8?B?WTVHRlcwQnlqVFlaK2ZrWWJCb2t1eU8wWU1OVC82QTlLa1lHNTN5aWtZVkFK?=
 =?utf-8?B?V2Z1cHhRZUdQTWhWeGcyajVCcTdyQTB6ZGp2Y25VYi94Y0lvaUVscTJOUUVq?=
 =?utf-8?B?ejVLait0S3lUbnMzRGpFN1IybFV4REFtYXk3TXA4bXByMmFoVFdaK3N2Kzho?=
 =?utf-8?B?alB6aDVRMDQ2RkEvYVJkK2ErMjBKZXRrRGpNektqNWZ1dFNuY1c1Ykxwd0E4?=
 =?utf-8?B?LzdaZ0NycGZ4Q0t4WWtkTWwzUmJCQWFpVE5mdmdIbnorbkpTclQzRjI2bTBm?=
 =?utf-8?B?Wlh2d0hzL1J4ZmRzdTcwUHVPWnpSczFFUHVqWU5ZckMvbUllbzl2QVZKMmFE?=
 =?utf-8?B?MFV5RmZmRGxiek9scGljNTZ2Q1FRRk0rRVNxNzY0YXR6MklYbUFENzdFSVJr?=
 =?utf-8?B?SytXb3BhQS90YWx6UHNXT2JQTG9zNjI5alNRbzFWNXhCakxGVHQxb1FObUVY?=
 =?utf-8?B?WTdPbmNNeVljaVpWZzZXdjk2b0dxNWVpOENVZzVyNGVnQVU4L3UwOVRIeGFj?=
 =?utf-8?B?ZUsvZzB3QzdONThqWHI2bHJjcWZvN1p1TllQRE1pUWZYaDEvN2JSb2JwL3RU?=
 =?utf-8?B?dUhqZzMxdlYxSUVzeWFwVXBUaEd6OCtkSjlCanhxYVZZSmRxbEVZTURIQ29I?=
 =?utf-8?B?a2pqWEJRMFhZZ2EzVEVYOS9FWDlVVmZkSlB6ck5JV1RFeVpwbHUzVU9IVzlT?=
 =?utf-8?B?Q2lJUGkvTXBDK1drc0RGSW4va2trT2Rxd2xMU3pPeEk1TUk1TGF6YjVyVnBs?=
 =?utf-8?B?OUJ1cyttNDY2N1Vvc3V4dXNHeENkVVkrUnJmWXdCY3dJTVY5VjhUVUo2LzZN?=
 =?utf-8?B?czZWUEFCOHVlN1BwbFVVVW9LN3h5azlsV0JuNGxXQkZSaUdrcVpqb21tSVph?=
 =?utf-8?B?Sk5JdzdiZmRzQkQ4dGxqeHhQU05XUi9QZm1pVWR3bStQVVJUK2NIVmgvYVhQ?=
 =?utf-8?B?bTFGeUlQcExOcW5FSFNYeGNFTmlHYTVwY0JuTzBDckF4UjBPd3dnV2xZNUFS?=
 =?utf-8?B?ZVlUMU1Velg0K3VhUEVjSjBSamhKS3hrQ0tpRjNUSjdKWTZsZzJLSkp5Vkdk?=
 =?utf-8?B?emFIYkJBdU93M0hrbEZFemlQRFhOb25iVmY0UW1Fc0dBTTZmMlNBdFBMcUJi?=
 =?utf-8?B?c0FxOWZENzBMSTFHMVJtelFuMmc3UkRVT1BzQXJjZ3VLVTVYbzJEMzA1V2hG?=
 =?utf-8?B?WFZ3bk1HRXdEbXkxb3N1cDliZVNBZGhmYVVBMmF1RmR5ZFFCYTBZZm5SNWlZ?=
 =?utf-8?B?SnJXSTdrcG10ZERjVitTbnYxZ3pHTmhicmREVCtCK1dGbXVpUUttYWt5RHo0?=
 =?utf-8?B?d3dyd0VIYmlPRDBkMDhuTmtzNENudEVEYmtaUElZcGpXRjBva2FwbWVHQUFI?=
 =?utf-8?B?YW5ZdlJubmtkaFFzcXE5UUMwUURZbE1jRTMyMHYwbUVmb2lFYTFqRDVmOW54?=
 =?utf-8?B?dG16OS8ycmd5TThwdk9NY1JPdnQzRHhvdFE3VkxBSk5zSDZqWWZLeEEzblpR?=
 =?utf-8?B?T3YwdklrUi9md0tCWVpFT2tFendDNS9rWnBKNUQwS2R0S2k4dTZjV2J5ZWRm?=
 =?utf-8?B?b3IreHJkSnpockF2am5oOHUvSm1jQVBMRHFwalVsZUY4SHlXWk13bGhsejJP?=
 =?utf-8?B?OEFGeEF3T3F3cnluenA2OTgvRE9zeUR1NERhbEt6UjB3YUErT1V3NmU1NnBL?=
 =?utf-8?B?RUNNUnRUN0oyRjhUd0tHbmNrcmJZOE5Sc0NUSGw0K2JQU2VDTHp3Z0FmbGhz?=
 =?utf-8?Q?v7YJxb4LXHRfyZiQiZTyAIZ2iQdkdKxJlaJQs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJZR2FHVzFMZjlUaXdCQnBZa2JObEFtd25RNGZ0SmRKUTdsV3RDbVc2aks5?=
 =?utf-8?B?VDV2SmI1dEdoczRReTVGQXVQMkx0aHFPUzQ1TUVsdHdNZ2QxVnM2eVZFZ01t?=
 =?utf-8?B?VkZKY2VlMklZN1BpWTJXZUZzQmpsVEl5aWVNRS9RT29lZUxLK210bUFOUnJU?=
 =?utf-8?B?MmREOTlDcnhGNHU5eW51SEc2bjNQamlQd2hJT1BtdFVkTWIyMTFQc0pLbXY1?=
 =?utf-8?B?S0NRWU9XNEVoa2VYYjE0U1B4NWZRT3BTMEtiRFhwaGRJNUZnejVJclI4TmRE?=
 =?utf-8?B?TlBkQ2lqTWpGakl1OVlFd1NpSWEzb3dJZE1XTGY3bG5FOHdTbmpBSzUwKzZF?=
 =?utf-8?B?UW5uTjZHNzJNb052MURpU3ZvZWZ4TXFnNDdzUkp2V2dvV3pJUXViYUh1ZEZT?=
 =?utf-8?B?TndxOXY1Q2I5amh3YXJGRDRoNklOTzljaTZBbDVvWTA0VmtCaTE5RVR6V0JT?=
 =?utf-8?B?eE5ud0xSVEFKV2xaSXJQbVBlRkxzajNkUENVMjJORmNkQTY2blZvYVJWNkNL?=
 =?utf-8?B?Q3lJcjFaUHIwTWJUQVVIcU90dzY1K1laaXEyY3pHdjJYanlyeCtjbjZzRW81?=
 =?utf-8?B?VFkweTBnNHZTRzVUazIrVUQwb2tnNlpIYXRvaGtxR3A3NG16cjE1NXdraU1T?=
 =?utf-8?B?UmhhQzB2RnMrVVJ3QXFVTXZlNHZKY1FWUDN3cFFYWnJyRFN3R1JoZmo0VTFk?=
 =?utf-8?B?dWhsWUZSZW93RE43ajJJREMvZUlYdDJwU2pwcmVVRU5VNTAyYlA2NTdKYkxP?=
 =?utf-8?B?dkczL2wzd3pEMy9nRDY3SnFCWnlicGpieHE5eFRrSy9IcUhIbWxNOEd3bUxZ?=
 =?utf-8?B?YUFCbUJ3MzVUNEFuVGVNNW5RcFJjaWE1RkFIU0FDQnMxUTBuNGRYak1SZ1d6?=
 =?utf-8?B?UmlwSG9OaXVsekRHTUFCMW9JK1MybEFOdFFSWFhyZjhPQ25uTjZqV3hpdVhv?=
 =?utf-8?B?azQya3QrdE5CaThhdDV0OUtJU3VkSEh6cVdzbzBkdFdyVXI3Slc5SGxSb0lB?=
 =?utf-8?B?OGFvLzcvenNTWWpMMUtCU2NLdkVlWnRjdlRRRTZKc3ZkTmpLSWowNkxKS3lM?=
 =?utf-8?B?U0dBY3RlNFJVc3BoaFAwTzN1Z2lTUzdZM040aEx4NUlqTkFWUmRMMktkQjBo?=
 =?utf-8?B?OFZpMHdHQU9Bam0rQzc3VFRtVUN3aStQbjhIK1I3K3VIc052SWx2QjA3U0hQ?=
 =?utf-8?B?aTR3WkJBMWNGcmRDRTV2eUoxaWs1U203K0M4UElJc1paQ2RhUGl4QXJ2TnBX?=
 =?utf-8?B?djVWM1JsU2xWeVJZTXQzWG1hSk9nc1F0aDhKMTYxUE1ibE96Y1I3TkM0cC9r?=
 =?utf-8?B?c29VZzJnaFlKOUxWNGNjZFFkNXVnZDcwcEx6QUNidlJTQnFkM0V3UytORnhM?=
 =?utf-8?B?N0gvZnJjZHRWcWhHSjFYMjJUZDhpMVJJSUVmRmxMV1oxNXBFMGhsWVRQcFc4?=
 =?utf-8?B?SWwxTXU3MjZZZm5MdVNySzZnbDdlVjdia01jeVFJQjNPd1dmb0NOa3hpVytW?=
 =?utf-8?B?RlFicVE2bFRQZURNTmwwaXc1Ujhvb2FqYUJjUmx5clRDRUtqQ2tzcUoyQ3pa?=
 =?utf-8?B?dmpBOStKdVlTcmorK1VtR05sYk5hU2ppemZ5Zm0wbFUrUnZKa2lhSkhzSEZJ?=
 =?utf-8?B?M216NEszY1VIckZqTEpJaGgvYWc2WmdTZithcTVDVXhmVGJXeUpkTm9GVk9N?=
 =?utf-8?B?VURyRGVBRTBtaDdhVXJmTS9LMmlXS3F4VGoweHdoenpEWEVZaWRCSVdmdGlt?=
 =?utf-8?B?SmlaSHZsaUhkZzJSTHFXSXFza1Z6SmJVeTU0L1BtV1FIdHFZbzIrV2htM3VY?=
 =?utf-8?B?Z0taRk80bHRQN1ZDZng3T2NrZkRzcW1Sd3Rqejk4cjJ3aURuY3pCcFA2Z2RE?=
 =?utf-8?B?a0xpRll3OURuRGQ4ZGpuak9ibVJENklJQkNoY2ZwYTlPdmVoYitqL0ZrU3Fj?=
 =?utf-8?B?MXhkMEM3Wm1SNVo1MVFNQVF0NzlWaWdJNWI4WXZJS3BBcTZQcHBqUDg5enRz?=
 =?utf-8?B?YjdoS3ZOVzdwcmFKS3ZFckMwcXhPME5JN0xxVzM3VmVQVXlSQ3VINlY5Z0di?=
 =?utf-8?B?ZXhVM0JEcDdHeDhWcUthV1RHZVM5OGZCRmJMS1dhWndSY3VHWWdPZm9hemNY?=
 =?utf-8?Q?ojaxbn/DfModTkmMKq5aeVstd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bd78cd-48a6-4e37-ac13-08dc69dd35f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:49:59.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQwUUTKPiQihfGdhaJ3Zux5//CziSv+w5sPrXRinOo0DZZHN5lFE9uUBlB+TKIp6YSfoLdBBKWRlLQOu//Ngug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index d0b6d3e655a2..c4a1d99dfed0 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -934,7 +934,6 @@ static int sprd_pinctrl_parse_dt(struct sprd_pinctrl *sprd_pctl)
 {
 	struct sprd_pinctrl_soc_info *info = sprd_pctl->info;
 	struct device_node *np = sprd_pctl->dev->of_node;
-	struct device_node *child, *sub_child;
 	struct sprd_pin_group *grp;
 	const char **temp;
 	int ret;
@@ -962,25 +961,20 @@ static int sprd_pinctrl_parse_dt(struct sprd_pinctrl *sprd_pctl)
 	temp = info->grp_names;
 	grp = info->groups;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = sprd_pinctrl_parse_groups(child, sprd_pctl, grp);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 
 		*temp++ = grp->name;
 		grp++;
 
 		if (of_get_child_count(child) > 0) {
-			for_each_child_of_node(child, sub_child) {
+			for_each_child_of_node_scoped(child, sub_child) {
 				ret = sprd_pinctrl_parse_groups(sub_child,
 								sprd_pctl, grp);
-				if (ret) {
-					of_node_put(sub_child);
-					of_node_put(child);
+				if (ret)
 					return ret;
-				}
 
 				*temp++ = grp->name;
 				grp++;

-- 
2.37.1


