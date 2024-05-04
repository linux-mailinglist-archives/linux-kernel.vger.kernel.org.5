Return-Path: <linux-kernel+bounces-168474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DA8BB8F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD6D1C22C65
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30438F4E7;
	Sat,  4 May 2024 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="frZD/TGi"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D12374C;
	Sat,  4 May 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783350; cv=fail; b=BTSUeTx3F9Ew1OCa6l6gs5wykGjlx9xrt1nHYbFu9h2eLcm/ekUebnY5uyn8r03S5kApidFnAvL4gGkQGnEDc3n9LnKvdfDbSjAJBWKBOLRkSQMbsqtzYGczN8cMVVfvodEVh7y64Lc31JtZpOXvvwuGv1J7i8yitLr8mHPcXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783350; c=relaxed/simple;
	bh=ol6T1q1Aq60j4vSh/rwMrCMDOxf8jPJ9kodS4MqsQqw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GXz17N4VdmSHie5J1lg8WnD+xSdcwixzYQYLETpJHTWR32x6k/ekh97/a999zeZcImNBMp27DD0ict6xoHibcTF1nPZ2CjAOdv28yJ9wvu9tnqvlKjAgKlr/AE0eTfA2fnNX8W8NT2/uJSHLtQcn+ARuMsoYGkDbNWu14CS+OzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=frZD/TGi; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEM4Cr6Bc7i/vGY7ZKza3LgfoFBp0QOLd1JC74EjjLLRokTAuYCTrw+srckPmdIJd5uS83ne63aCwKvbwUeS1H8lEmtnm0SU/Qhvylws1w8R+79/aPxW27RwGFvTWXJJWUxlVTqTLdl2v70iavVgyWBv6xrzxJXTTrJk/enwhd45wLkDbdVx+GKbDoQ5ZByrjt8L5Ag5gErGYv5CT++ZcRcqT6n/eEaanNXWJVDj42Aq3tmgHIUko/AoXc0mUN8Ff+VqOSn7ZRMCwK1C1CsG0nitOFihwl7yKcxhs8OrmvcACFFVhtGAFtAShsWgxU9nLNv6okor/4hJEY2m/fmSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haZ6P9kChEQ6LyhfR+Vw1ypeLFvLrcIo+nuKLMbxpNM=;
 b=T5GXRI6eNaKKLGeS9WZkc8Tk4t7r5n1dli8RLbZoFm52pyrhs96VCz/we68qbD2qRU6D6g5zWXK2LoYZU8gjBBkJ7VRgr5ElhIjec/t/3YC5sdwYj1aerZyo19OGyIanc7Q6CKT67Z1t5Ny5jbsg7Pzlz7eMtXpKp3tVJk233ayEVQcDIx0OGLl9w4gU7zJ9CdjJeOLcKxdzPHMlk7vdTthUVtsqrl1THebwbTZjlJ2pL9rpMVOgNhXuBM8o+c9FfZYmLh/onHDsPmCfu+K+sgNdF4Pz1mWXy4BOsqJJI1XjP1In8kNFdTT0Ik4UU0Gt7ZvDnWcHhr7k1dyRI9ESHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haZ6P9kChEQ6LyhfR+Vw1ypeLFvLrcIo+nuKLMbxpNM=;
 b=frZD/TGiuzwiq3aN0xaU0zjbB3ugSZ31ODIeHGWqZT7GQ95vXI3uUD61D9fmH/NtpOJpyZBnIFrdMGpS3vM7EBHiQt38hxomx5ZVSIhd8NIax1XUge+LhHpHYLgUxuTop2Ans0QcYgCBmTP02MwwHPSf/o3JLPgryIy3AUnyz18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:08 +0800
Subject: [PATCH 15/18] clk: imx: imx8qxp: Add clock muxes for MIPI and PHY
 ref clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-15-f7915489d58d@nxp.com>
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Robert Chiras <robert.chiras@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=4040;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xxTNiTDPAbopWXYDXxGIv8y1Vyhx+iZ9rQ5/X96xIkk=;
 b=JJSHcmBw8XDB5MX/ios8PYv/EvtlP3n4PTHts5VwJMwJ97hDXOl7s/xqcSsk1r8EKnW7jYjcs
 hePASN+FnMLDd5+ki7FywzF6SSf3/U6mn6WU0l0moyrRS7yfZznil0j
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: de741c9a-ba1c-4e14-b4be-08dc6bd31140
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1daQUozazNDK1JwbDlEQ1VHYy9oRmxUbU9lalFqWkZWR0RBZEx5dFRQem1M?=
 =?utf-8?B?d244c21nS1Y2aUREQUNscUNjTHFDMERtRlQxcEg4Z1J6Z3JoSUorVDhmZWMw?=
 =?utf-8?B?cGlmMi9xbmp0amZ3a0RrVkY2UzltRFFkanZ3WEdzUVBUc0VjQmh5R3ZhMGNu?=
 =?utf-8?B?ejN5eVdxUXJId3hzaUZ1VGs4d3J1TldoNm5VaDZRYk4wTXcyK0w5ZmRuTkpL?=
 =?utf-8?B?aDhqR2lJWkpkRUZlMmNmR1FiamM3U2JqaEVsMUpVb3dHYno5ZUFSVzl2a2RB?=
 =?utf-8?B?WWVuRERQeHdOT2tPRnJEUnd5WHFRV3hRdXBJQkFoZnlFajNHWTRUN2VKRVUv?=
 =?utf-8?B?SkVlUldORkRrZDhIWkZqRWltLzlKaWM1ZkNtWjFEc1kvTVZXSEtjdWgxQVYx?=
 =?utf-8?B?VmsxSjA5a2UvTVB5SGMvWDYxT0VuYmxLZUJnbGxYZjZjOFQzcDNmRUdUS1Z0?=
 =?utf-8?B?UytHQVN4Qkt6cGlTNVR1QXdWalNVUVJpNWZaQ29Ob2ZyeVM3MUNZcG9BbWEz?=
 =?utf-8?B?aXpXRlVSM3YreGJCaDJNRDFrT0xud256bDc3UlljTjN0d2lGZzllQkxLLzZD?=
 =?utf-8?B?ODViOXVWSm9nT21XTWtaRDhLREdobjVmbUpIVDl0TnhlbzZqd2YrdU00emJ0?=
 =?utf-8?B?MEpOejVEVEV2L1hRbVFWN2dWczNxWUZkcWpaM0ovemhOOG9zSGcxLzFaTzFq?=
 =?utf-8?B?KzhWd3VpZmEvb2h2VEdQNmNia1p2NTdiZnpsblVnNTJEQlp5eGhESFVlZjJW?=
 =?utf-8?B?UlRKTkFhRFV4M211UU1ML1Y3NTlvUlFldW5wQkVXLzBBdGc5dGtrUGpYczlw?=
 =?utf-8?B?aXFNNGFqNFptWDZ5NE94eTZ5cm9FK1pjZW9rSXc0ZWkzT3JwMldGdWV3Uko0?=
 =?utf-8?B?SWtmOVQ1cDN2S29QVUVzRStoOHVzUkxPQXpNTmZZZmgwUUk3S3VQRTBBWURS?=
 =?utf-8?B?cU45YUZIYW51ZnllL1I2eExwRDMxa2VXQ0R6bkQyOHBVTlR0WUhVaFU3Vkps?=
 =?utf-8?B?MEZJcnU4S242S1FGWElzaGx3cGZMRE83V3k5SExRbVFoM1RYaEQwVFFpMzZM?=
 =?utf-8?B?clFEWm5Jbml3aXBFRWJIWjVteE11bGlVNFhsVGUzSlpzaE9CUjQ2aEVmdzNX?=
 =?utf-8?B?VXpUR2cvZDE5QzVmeXV3Z3dyVk5lMTlSM1hKQjkxOHJFZHdERVMyMkxhaCtk?=
 =?utf-8?B?Mm1MMXcyQ0ZCZTJnUFNFa2lNZzNhWFN4K0pEZENhZjlWUHROaWZ3MDljaTNa?=
 =?utf-8?B?NkVMU0MwQllhcXhEdERSSzRYYXFZL2ZGdVY2OVVHOEp1a05vU1cxYkxLb0ho?=
 =?utf-8?B?cmZOMmRKc1ZRS1p0Ymp3QUV5MmJBdHpOSlpmUmd6ZnBaMTNhRDl3cGhGTFJx?=
 =?utf-8?B?RG1TNVdpS1JLREw4UDZNc0RlMUwyNERZUk1TTVpsMy9ZbTh5Z1daK0wvVWtl?=
 =?utf-8?B?aE5KLzFOOVYzeTJiYUVjOXNrbUtPTklKMW9JVlVxckxyK3hHQ0s3WG5BQ0l2?=
 =?utf-8?B?UG94M2hsMFpQWm05S1NEYzFRMTZmK0dENEpkNzBlVTJwT1pMSWY2UG1VNUsy?=
 =?utf-8?B?YnF4b3VmSE4zWHdSb1VrSW03bllwajJIbkVxdnQrenVIMk95OWhUSmlRNnpL?=
 =?utf-8?B?cVRERGxrU0lsWFVXb0NyUTZVNW9JbUMzRkxJVXlGc3JWOU50aGlITnFqa25t?=
 =?utf-8?B?WkRXeGduS0x1N0ptRG1TY1pDTGhXWURNQXVJUFJRVnVzMm9aNmNVTnVrM1A2?=
 =?utf-8?B?QWloM2ZFL0d3TmpsV3ZlUG1JVFhwMlNxYXYvR2t1RHBmcHAvajZOV1pTUHZ4?=
 =?utf-8?Q?ijlcwVMt7M6PpG7jK62QVhP5wSLIYxjB1b2gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVl5U016ZUlmRmtad0xwaEcyZ3lESk9GRHArTW5yQUlFSGpQdkJJbysxTlIy?=
 =?utf-8?B?czIxYm15QWZKZnFBaWRDQ0o5QUdtT1NwQXpzZTYyOTBZWXFGM1J1eWN4cGly?=
 =?utf-8?B?VmllYnF5ZnJWNHplbVpUSjk0QkUycGhvZlQvcXhpUERwdVVucW9rNkpSckg3?=
 =?utf-8?B?ampDemYvWHBBbmp1NWlXajNLakZmWGdTdTYvQXNzMjhKa1Q1bHpXT1liVFpD?=
 =?utf-8?B?b1BsbFQyY2cxRWVFWHlKNEkxY3U3RnY4N0dWOGlLYVNzUjIwT1Y2R2VFRG82?=
 =?utf-8?B?MWNMSUloWUpxWEM2ZUNOd2s2VFViNFRlY1dHdXpQbG1GVGpWaW1uQytoVm9Q?=
 =?utf-8?B?ZHNFK1JZRXBoZ0ViT2xaSlRGa1dNZHBPbEo2SUVMemhvbnNhSW1xS1JXempC?=
 =?utf-8?B?SFA3M1V2TnJYdVpTUnRSdWs4RFZ4L3pOS3dXVlE1bUtBa1hhbmhpeDZaTiti?=
 =?utf-8?B?b0g4bmVVUEJhSGNEOEpSRmhoUWh4bVJEbWJzem5iaCtnVEljeVE2akd4eko1?=
 =?utf-8?B?TDg2VHYzMmtDQzFwdktPenhIZkc1RWEvNkoyaHNhZjhCb1JJbXZ0RW00UC9w?=
 =?utf-8?B?UDFZRkcwNEZDVVFzRmU4Z0I2bmVHbmJtNSs1SEoxZmJtY0JEdnAxb3pBSkZn?=
 =?utf-8?B?WmN5eTJwc09UTUt2SGovMzg2OWt3emI0WGdtQ2NaODJjdUJMWEdBNWhJQlM4?=
 =?utf-8?B?OGgyV1pMK1AzRjVRcWRZSTRWLzZjNTUrTkpWZXhlOHJ3L1JoUzVMTkJOQldh?=
 =?utf-8?B?alVGa3Q4akIyUjQ5dkpPNWFIS0FsNVU2cXVxdFNSWlRKNUZGdFhleGlYeGV1?=
 =?utf-8?B?RkhheUNORXkvRlBpSG9vUkpZQkZvTDVhNFR3b0phTTRQL1lpRUg5amxYcjZk?=
 =?utf-8?B?bGp3RHE2UUZPVG1OWmVxTDJkeGVWR2NhK2xTUTBOQ0VxMjliQ1drRjl4OTZs?=
 =?utf-8?B?Si96eVN6TnlLTXdZMm9zWHN0bzNjeEt3b0VaTmlLallXVE4wN2lUa01TVSs4?=
 =?utf-8?B?aHFEKzBGUjZBMXNMNXhTK2dSbnI3UWRzRjBtbnlZQ2YwcnQwbmpJY1lRS1V3?=
 =?utf-8?B?QmQxc1h1eGxWTEE2alp2eXZ5YmZDU0NHZnFnS2VRWjlFNFo4cTYrMHljZGNj?=
 =?utf-8?B?Ympsd0NKQmxNcFJzN3IrYVBYS2c1US9sV3VsWk8wTS9wSXV2YlAyRnpVNzdp?=
 =?utf-8?B?VXd6TVF5MFFFTUpsNmEyNExkV0lUSE42cGZ1K1A4dGptWklvdnhGOGJPeWdN?=
 =?utf-8?B?UWliZExoOUVtcDhwaVZ6amhEdEhXL0Q3MHZ1VWFJTUpNdVVEckFQWjlDTXhz?=
 =?utf-8?B?RTlFbUxpS1FCTkV2MjQrU09tK09zODlRZEZYd0lpekc4OU5QN3BQL0d6VzJF?=
 =?utf-8?B?SnMzekhCZjBIOFcrVXRuZzRNem5VVENRYTdyVWtrbjVUbldxUEpiSHI3SE9s?=
 =?utf-8?B?SlRZOGovZEdzNVo1TjZiRjdBak0zNFQ3OUZaWnNHcVZ3UG5aNHkveDFtOU1V?=
 =?utf-8?B?cUZaUkxXaHJMUWZuQTN6blpPUG1pMU9ZVEtPb1owU1dPQ3FJYm4wdlI2Uk9t?=
 =?utf-8?B?NUh4QTd6UlBxREM4aXhVRUUxMytxRUpwMFhpcG95NHpna0hxVCtEMnMzWEJz?=
 =?utf-8?B?b2JocC9xUUkzWEpEcy8rcmZQNE5PdFBESENQL0IvbWg1bGRuRmR4dCtxK2dV?=
 =?utf-8?B?alMyMzhCbW5raWY0UGU5SzF0L1RxK3pCZlZCbndYRERIV1JDd0RURmsxbm9R?=
 =?utf-8?B?SEVEdjJXV05HSHpQMlY1OS9RTVhBT3FmODdSNEJ1V0IyaDR0MkNCQmZGZkNm?=
 =?utf-8?B?TXlCSHZuZTY2Z1BURmNBeWpINGd0dDNDTWNzNTJmbGh6aTRrMVhGK0xvZzZF?=
 =?utf-8?B?UzVMSS9mYzNldDFCVWFxRFdKaGNNMFRnUVhxZytMUU0wMnF3OTRMNUh5MUUv?=
 =?utf-8?B?VzVzeUEvYWdQMmNFSFBhaVJNYmJia2hlMWZFWTVTK21kZ2VwdCtwUTBDOUtw?=
 =?utf-8?B?bkt6a3dGbUFiREQzUDdTcVVFYzdtODdUZEZhbUVBckJLTi9veTVVek5adDl2?=
 =?utf-8?B?dHZGWWEwOUdHTlMwQWNDb2ZtakZZdmpwZHRRMVBaM3dhOUlSS2IySHd5djly?=
 =?utf-8?Q?WovnKxOZv8iUU2zdmDDM4vqP1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de741c9a-ba1c-4e14-b4be-08dc6bd31140
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:25.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGFJ8EkBmYcvRM4GC08jopv3Ene8fvFiEhzeFdyVX1vie9WnWBa56OXB6J0BABJfUoEIVV4pkTSXb0V9nJJBAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: "Oliver F. Brown" <oliver.brown@oss.nxp.com>

The MIPI Pixel and PHY Reference can use the bypass clock as a source. The
MIPI bypass clock is the Pixel clock from the Display controller via the
pixel link. Using the pixel clock for the PHY reference allows the MIPI bit
clock match the pixel rate exactly.

The MIPI pixel clock is currently set to be source from the bypass clock in
the SCFW. This patch allows the pixel clock parent to be set by the kernel
in the event that the SCFW default clock parent may change in the future.

Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index a0654edaae83..fe6509be6ce9 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -90,6 +90,22 @@ static const char * const mipi_sels[] = {
 	"clk_dummy",
 };
 
+static const char * const mipi0_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi0_bypass_clk",
+};
+
+static const char * const mipi1_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi1_bypass_clk",
+};
+
 static const char * const lcd_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
@@ -222,25 +238,25 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi0_pixel_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi0_dsi_phy_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_pwm0_clk", IMX_SC_R_MIPI_0_PWM_0, IMX_SC_PM_CLK_PER);
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi1_pixel_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi1_dsi_phy_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi1_i2c0_clk", IMX_SC_R_MIPI_1_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_i2c1_clk", IMX_SC_R_MIPI_1_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_pwm0_clk", IMX_SC_R_MIPI_1_PWM_0, IMX_SC_PM_CLK_PER);

-- 
2.37.1


