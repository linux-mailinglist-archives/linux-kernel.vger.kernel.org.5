Return-Path: <linux-kernel+bounces-168464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F58BB8E2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86788285E8B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656CE545;
	Sat,  4 May 2024 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C+jtar6q"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8AA946;
	Sat,  4 May 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783295; cv=fail; b=tUSQZeRn034noxlsMonmBWfpyFX7S8nDYrMbBqaMFnZEUrcVKCxj9kkHdE3qEc21l3tMv84rhXBnVPZWAT7EzzDj9mPGaWDXYTBxeW6vUo53a8OaPAKeWghILP5F71tR+gQ/HFd22oRFFRZAUUKmZy1xyU5MeK6DeHdFMVBbFec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783295; c=relaxed/simple;
	bh=5mmWyK9WwIfkcE/cYuEGrNrZK8Et8RVYnJ0d/vH/OxM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=msF4HhPD7z/hHs2G5gtTt8WBdiqC/OftduLgbwAwjesDMdDQ60qbPjrrPuR1T63ebwvAlSbZmExsa9qkvkNzs7QmTbPKDf7uUT6TXs4Y1VXDVRdP75wlC/VKtGyNTbPnyY0wGeJe+y8TF0+CMX9S4v+77GwxeeMfA4Oaf4gToAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C+jtar6q; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXc0MPEo1GlatILkQMzFmcxH2wsulOZzbgZIktIK3A80IrvJZQAdkXv5BmtkxR6GMm2LzruthW//JB8egDg3sMcRQztlA8JwIy/m8dkt2azj4pZEj/Jx7hSPTIJ6L/vzEpPchN82ceXkxUTbj00Km2s0giuDbNlMPHHMCRVV4dxCMUwbM32hgW0NSIg9KeS680RtEAnDkywlIlwUIsIGi7rgX4L6ElZhAgEGy95BjcrLt/QcrFIh+yPFVcOx07ZKFL0hdrXyTILxhhPg7EBdB+6lP/VKVOIfxJF9zoiiL7qa4jUNup2fSq1pN9ObIe4Ao48ZlErIH0R0kQyRWkbx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G9L/mbRTXzjXiBgvg8oD625HrvNI8EifS6jYATL6qs=;
 b=fMiusojq02QHxJr0Qms23ZFUTEuH/rdaIUSDrkskx1rWQTfT1EFiqTA4ssb6gnr5wD/fFvmx1EPhNdpCEMq350wxA0//hG2fpb3lFVAccFIqiX6wf5yAeBVkgVdpz5eLxhxlsLXrMlkGx1WzBaslYyAumsdZwxeu3YS9W9QqHfv1M5FEh56FtlsFl0IvzePyWtO6MnG6Js5jIhJYVjz2BkWAYT+TRPMSCbsZZw0yPPCcBpNfYfuRx1uAeSCOP34VE5Buvk3fepxyZzjQsRxk3scAwth4nifiYWnkRuTgGRhOXVeoMkUok1hCnCcEEfFdQ7BQZrvNZOHaahx5LfRgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G9L/mbRTXzjXiBgvg8oD625HrvNI8EifS6jYATL6qs=;
 b=C+jtar6q7FDBOKyvaaz/McxXt65Axk4CGgloDQqPbFyUI2MRY9ZGDJnUL0e1+D1QKb/6Byi1DZSE9pX74jJyGT3fpfafYqU3/bKBjNyMqT0JxOtiGiKrULjt6JZ+hO5k8UttBh8Q/y3lTbd5NfU/4wpgBNaqC/tsNEs9e5+cu+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:58 +0800
Subject: [PATCH 05/18] clk: imx: pll14xx: Add constraint for fvco frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-5-f7915489d58d@nxp.com>
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
 Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1882;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ITpMc0XDxQEnK8rIvUINBCDmIwwvJJ8hnlCjcXFS7+o=;
 b=rGfviR7PwPWCE1ffyTS7CSGZZAyaa2MX3+Z/5EYDswUDqc7NyMEAczXa7jMKLts7+f3tMQP4g
 Vs9u3C18IJbDfIXG3mTPY5TRU46Ad4NbsPqn8Wl1hkyz+bmWlNnV2Xe
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
X-MS-Office365-Filtering-Correlation-Id: 87501d15-1bf4-4500-ed93-08dc6bd2f04a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWFiWFc1eXBOVlJXSkZaZ1NrZ0laOTJvaTJsNnY5dE5jdnprbkVPZkx6N3p1?=
 =?utf-8?B?MmNmQmNsbWw1S0RtSHU5US9xYnRod2VTL2hDUVUrdTE2Z3Q1MnBad2VrQUFR?=
 =?utf-8?B?dmNsZDduNlE5a0F3Uzh4dHQ1eDVFTlBJNDhlY0cvZTBqUEduVkZWMjZ0ZDBO?=
 =?utf-8?B?c1JWb1UvZDZSYnRIRXIzQThQNUQvWjZuZDZZZ1d0elkzY2JIM0NvK3kyKzRH?=
 =?utf-8?B?b1JpdFNwRmpKNmdrcjVJSEZQY1AvNU03NTJVVXRZM0tGK3RJZnZPaFhxaG5P?=
 =?utf-8?B?b3ZYZXZ5b2wyc0FaTUNDZ2ZkL3lvejRuOTFLTkZPclgvOVgyMG1CY0I3S0Rs?=
 =?utf-8?B?K2g1L1JsZTJUbUZKNko0WDN1eCsrc0lqcmFGcStmemMwQzdNWXFwSTBtRkF5?=
 =?utf-8?B?VVU3NHFwTWJlNytqbms3Y1cwaEo2cnN6aXpzTFZMUXVzUG5UN1BaNHprZXFZ?=
 =?utf-8?B?Vms3VGVoaGdYNXhJOEt6QWpackxlQnRGSks4cVZzSU40dmxDYzVPSEhlSjhj?=
 =?utf-8?B?bWZPQ204NWN1TXk3akprWFZ2Q1dMMFAwS3JvSmJKVkZEdlY4NjQraTlrTFBt?=
 =?utf-8?B?eDJsdUhURlNib2tCUkhMY1dhdXZTdmVlZnBUREMwUVRRTVRVdURjUEFIN2Zw?=
 =?utf-8?B?RHFwZGNoL1Q3cUpuOElTbTZWSVRCZ09QUVRZc2NpSjFYcEdodVZ0UkRUUFQ1?=
 =?utf-8?B?clk0cHI0azFsWHBnR3Z6WGVWT3U3ZjNQNi9YWEdraGNFcGFIbklJdDRsMS83?=
 =?utf-8?B?dmxJZTM4L0RwUTBGN3I5aXhmamRyVVYvbVkzSHBhVWtYcXhHdWV4b25qMGk5?=
 =?utf-8?B?TXNaNlNSMVcxektqc00vSEJhZ1JPVy9nL1FpYlRiOFRNdlNkYVMrbVFWVHpD?=
 =?utf-8?B?Z1h6UkcxR0hDaUxnTSs2TnBGT3REWVJmeWNzcWlUWWpqOW9JYU1DMXQyemRD?=
 =?utf-8?B?V3lyNEJFSkhtdkludFpycVVsM3pGNHdyV3FoUXVNNXR4L0VZY0p5SUlBSWFa?=
 =?utf-8?B?SmJUU0JsYVhOOGVZc0Z6Q1NPV2FrTUdQWTZVdWxTM0E2dWg4R2gwd0t3Uk9V?=
 =?utf-8?B?ZlFpSElXbjlVTWNQTlptbkNqSHIxUVZLT1o4V2ZrN2JxTS9GL1BjNmxlNy9r?=
 =?utf-8?B?SGpjMmEzV2crQWNTTGZjbXdobkRQTSs5aWMrQ3RaTDFxa3o0azYrc1FnU0hD?=
 =?utf-8?B?S050USs1M2h6U2FTZEVtT24yTExsWFFrQ2s3U0FhS05NZkxEZVZVeHZLY2Ju?=
 =?utf-8?B?UlRwYU5HYVZhSk9ESnNtMHdxeGtVT3l2WU5oK0ZEL2hzNi9Ua2dMQXNFZVRz?=
 =?utf-8?B?dDg0VjFSZlFzdFFlbEg3MnErOE1VQThCZnJKeTh2bEh6d0hjS1VPR3o2czQr?=
 =?utf-8?B?OHZWcGtYUGdrRU55RWt1aWEvYnJoL2hmUzljNk92WkllTFY3VWFaUDg2UjFy?=
 =?utf-8?B?b3gySmJ2SkFUeW5QdHhRSTFTSlN0aW5GRG4rUE5zZmVzdkV4dkxib0RnUVpQ?=
 =?utf-8?B?WmU5ZnJWblUxSjlMVElISHV5YjB4TEViTFhtUFZVcUlEc3JoZ2phdXVxS2tp?=
 =?utf-8?B?SDNWU1pGdTh3c2hMUDl4elA0NUtNQ3ZTeFV6bkptS1JCN3R1UHNPMjhlaXZm?=
 =?utf-8?B?Sk5YcjgrSmhYTkx4VzlOcFNiWmtuSnErMWRpM3pRL3RFM0Q1T0NPR3BydGo0?=
 =?utf-8?B?bE14Zk9EYlBHaHRCYTNPYkJNS2JESHZ5elVSK05CQ1VLOGljYnRVN0NHVFo1?=
 =?utf-8?B?Q2ZwVzBDb2xwUU9GelF1ZVRxSTRVa1ZQSTNocUFNQzJtTFN3WGhyZGVVM3h2?=
 =?utf-8?Q?PoqZUxKd5mKetB9hfjZQ3vazvgSxWV+NXZwNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2I2TG9BeFZveDhibUI0SGtYUkt5ZUx6cW1MeXo5YzI2WStvMldURVk5c2Vk?=
 =?utf-8?B?RUtVVFdscURXWDNTYldoWnl6YU4zSmlPNTg3bkpMSXN6VkMzOXd6dFUyK3Y0?=
 =?utf-8?B?VHhuc1NtQW41Z3dwM3hEVzdabGZPcW5CK001MXpWYW5YSDFSaEtGZkR0N3J2?=
 =?utf-8?B?T2gzODlLM0F1Q2Z4UE9ndjUySktrMTl0ZzFWT0UzcGRvd1JDRi96T0pLbzFS?=
 =?utf-8?B?QnQ4Z2JXY0x4RlMyRWRiWFFjLzhFUzFQbSs4a1BJMWc5ZUE4U3RVeElGZFBE?=
 =?utf-8?B?bXVhMEI1b2s2T3VIYXlCdXpZNUFFanVzNFdFcGRZbGFGL25seVFkOFJjYjF2?=
 =?utf-8?B?NEs3N29va1hUQ2VVdDhlZTNPYU9KZm9Yb2cwMDlIWG1xRThFaFZIRlRYbDFM?=
 =?utf-8?B?NytiWmg1RWFrRmlESitkUDhrT1ZQekp2cFJIV0x5QkpNc2pyZHNqK3N2dE52?=
 =?utf-8?B?VE94WHhGaVlkZS9VbGdMdTkxdXN5UElXZEgvQnI0K2JiMlZCWEU0OE9qZ3kx?=
 =?utf-8?B?b2VVV1ExRG5HVzBhZ1hjY2kxV2hGdUZvYXlDT25SN3ZDUzFFTkxYZkM0R0s3?=
 =?utf-8?B?SjhNRGxuSVNsVTNnTCtROE93YldGZERCVnloUHdVS2ZpOGxoU2tTSXNCU0JP?=
 =?utf-8?B?dlVicmZ6bWFyUnRNS0hkZlZaOFhJOXN2UnV6c1RiTTF3c3Y4enJPN2xPZVNz?=
 =?utf-8?B?RE0rVHJLK3l4WVE5NlJDUG9QOFN2elNkNFMrUTQ0QkRSOFErOGhHQ1VjMzVs?=
 =?utf-8?B?S1ovbzg2R2ZYTlpmTllkSU5Ec2d2SjdnRS9xL1d6SnRZQjNVR0V6T0VyVCtx?=
 =?utf-8?B?RjBlMGhIWTZZN04wN1JkR2hxK3FKVS9SZWExWWlObmdldnV4b0ZKKzZ3TjVH?=
 =?utf-8?B?RnZUdzN6ZlFoQXJhVE45bW1aSWZ4bGNzM3hjcnQ4eVp2QjIyZTZCN29hWTZj?=
 =?utf-8?B?emxCdGFlTXNEb3NYZHRabEJqRURSQzFCYVNEUThWRVI3MlRXWUV2MTFYK2lL?=
 =?utf-8?B?RE1KS2JNM1V5ZEpLNGwzbDc1aC84b2JlWll5SURBMzRyYkowaGpFWnJhbFpV?=
 =?utf-8?B?TDR2U2srRHdNZGdnQzhsUUZzQ0NGTTdzYmtPcm5TWVVZV2lLb1J4aWxyTzRw?=
 =?utf-8?B?cDh6Q0JrSFJuQjFORFdOTlBnU0NuNEJPZkFwNlZsRHVEYmNjTzVuL2lyaFVh?=
 =?utf-8?B?ck9BVkNtQVJiR01EenFxeFZFZkRqU3FVRTRnN3NLSDc3M2h5WG9GeW1nbmIv?=
 =?utf-8?B?OWx2VnUyTXVTc3VZcDZaOFROOXpBcHRJT2sraE9CanFHZXdwN0JudHVwMUs2?=
 =?utf-8?B?a1lEUGJCdFFxY2xCN05UbGNaNStIS0JwUmw4dE1lYzkxZGZnRGtrc01oUlZS?=
 =?utf-8?B?Um1uV2U2emlkQkc0MXVVWHFIVW8zUkdONHNjamo3SkhPYXB4S1k1NTk3UkNj?=
 =?utf-8?B?Vkt5akhacmdRNWVNWTdrNEZoSnhtRWlERVY3eW1GNFpTalMxLzNZK0FWcDh0?=
 =?utf-8?B?NDljOUJEOTFrTzZ0cTJuTGJMbkJqSlZ2NWFSS1JHckhJa1V4S3VUMW1oMUln?=
 =?utf-8?B?MEYwS0FsSisvbUxVbzhrd1ZPb1dMNlZmeG1NQno4MTVFS05BMUxBa2wvaXNX?=
 =?utf-8?B?aUlIY3VFaE5sb0hWWjd5WU1pNlZvU2NteUt0SC9jMFo2Nlc3bUhnSDhPazJ3?=
 =?utf-8?B?VGJPKy9WZjE2V0tQZXBDdE5adkp6Uks5bzd0VHo0VU01TkY1SFl0elB2cHFl?=
 =?utf-8?B?VEQzdmR2b015SHhmSUZNbEhINERFdVFHKzVSMS9ISy91UFZZVUtmKzk4RTN5?=
 =?utf-8?B?Z2lkeEFJNVBnTENlWTdVaElzenZpdCtJRXpicFRtUHRQay94NDZXRS9YSHNW?=
 =?utf-8?B?MVg5Wmp1R1NncFdva1hHSEtXcm9GK25YMGtrQzFUbXlOam9LaGdXNHpIa0Nv?=
 =?utf-8?B?MzJFcmhLbjh0eThPcUlaZzZNVUVscVR1bm8zR0ZaampLL3A0MWgwS2EvRlc0?=
 =?utf-8?B?L0NzbEdQMTFJUXBNanI3dXhtNnZNd0cxVmJVS0xrWmpwaWZQVG04UnJNeklG?=
 =?utf-8?B?ZGUyT2ZXVC9FV25vZGxoalR6dDBQRllwRlova1haUU11aXVxcmFuL054TE1j?=
 =?utf-8?Q?Jsc7H6gNKRNT2hZjMJVcwpdMD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87501d15-1bf4-4500-ed93-08dc6bd2f04a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:29.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRuuFfV898wL1reGTV7VQ84Kzk3A6ODTPbEA18bVNDxl1poeBeKhNWVcEs26PtBv05KccImSDPik022ZjftuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The fvco frequency range is between 1600MHz and 3200MHz, without
this constraint the fvco may out of range, the real output
frequency is no accurate.

Aslo correct the name for fvco and fout clock.

Fixes: b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Jacky Bai <ping.bai@nxp.com>
Tested-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index d63564dbb12c..55812bfb9ec2 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -131,7 +131,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 {
 	u32 pll_div_ctl0, pll_div_ctl1;
 	int mdiv, pdiv, sdiv, kdiv;
-	long fout, rate_min, rate_max, dist, best = LONG_MAX;
+	long fvco, fout, rate_min, rate_max, dist, best = LONG_MAX;
 	const struct imx_pll14xx_rate_table *tt;
 
 	/*
@@ -144,6 +144,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 	 *
 	 * fvco = (m * 65536 + k) * prate / (p * 65536)
 	 * fout = (m * 65536 + k) * prate / (p * 65536) / (1 << sdiv)
+	 *
+	 * e) 1600MHz <= fvco <= 3200MHz
 	 */
 
 	/* First try if we can get the desired rate from one of the static entries */
@@ -193,6 +195,10 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 			kdiv = pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rate, prate);
 			fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
 
+			fvco = fout << sdiv;
+
+			if (fvco < 1600000000 || fvco > 3200000000)
+				continue;
 			/* best match */
 			dist = abs((long)rate - (long)fout);
 			if (dist < best) {

-- 
2.37.1


