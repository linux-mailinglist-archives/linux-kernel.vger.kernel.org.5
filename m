Return-Path: <linux-kernel+bounces-168459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71C8BB8D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E50285D21
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5017C9;
	Sat,  4 May 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SvhuDGiq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A751A34;
	Sat,  4 May 2024 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783268; cv=fail; b=R1020Y552wrbfRMSwruicMBgaDjGcXO0TcbxFBDgSPxpKIYw5T/cD5GOzRoG4aOQ/DsVVZ+fvDN+RQZQVYCerlPpqpLyA1HmM20/tcuDpP8OeCKrrFdjK3bDsoJ+lemEsAeDLafdeEFkIA90h0ARhBkRIUdDNugHcrU/tvmxJ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783268; c=relaxed/simple;
	bh=/4QFCsE3xBmY4w7jpkFfAWfR/afmM/wGZ6lkkJbEAdM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ToDMs0sXjMR+7Cr8oLN1DpG2FfQHKA2Jgo66rlXDj6ZC+eaXSBxJAIMIbc2dxJEp3gpSuGbgGeTHVebZUTuBj42lJjwYGq3LPkcNKomp/hhAlbv+CGF2oeRN3nvR8i+xxnWIBK8B/RoPRwenmzUSJBr5PA/HkPLy0+0Xh6j6RQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SvhuDGiq; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSi8gS2rPZoIQbGtzNCz2oYzi/mTuDuzWLWNKAwhvGMfKJZssY7ivPV3X4r7iJGkxPrANm/6tXGQ64V/SdCh6OAfsb9aOlwmYtQBNqKonfMHwRBsZsUiFjeeuIAHG9Hv0lkzpfn98wfIdCqBuE/H0w2YP2urVnpqwjVbyuvEBnhoYllMgoLWIj0u62lB3dtDQOmne6BZYYob8PR9T9jCFCLee0gVQmd6B8fEl39BBg745lBwwf0tYZywyINrgUgXSKDCip1zR75Oa6pD4gXsVLrKabimLgO3GGNyQNLQO93OUv3XCUapaOSmoua3ngx34pGqo6qnIu6GzYYM8f0SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCq3Gd+1nDS1Ju79bW0XQVJTPMhOZngl0OuPgpjlAGE=;
 b=nU8tgzN5tfD9wyrpxsKEHIEXL4STZv9II8mjFmg6c/Hoao60jKVhO1wHQxw7tbyuK9Gx3n/KBPvN+X1+ctpvH3NwXUBTXPK10wjojXZ1PK5XsJXbLaB+12kF7jxeNd0105Mue3EOGq3rnCS+TxtY8NRYbZTeKWjtIODUy6G80tlBqGKZa2TwxWUQrWqWtcGjZCBmDZJjbYdedjkuqsrMisc7Sg2f8YHkfw0+ZtLFwY+GDfcI7JD1DLZCbtDXZ4ol304ZkRNxVohNWDd+hRN1v/IJofIyVD1b74KqLDCB9ffpmVz4e1exbkVmdY5cF9GLYFAx9NJQXN3NbFyfbfWJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCq3Gd+1nDS1Ju79bW0XQVJTPMhOZngl0OuPgpjlAGE=;
 b=SvhuDGiqV37U9PV7olAfvSdQHe8vF1XXkpwcisyOfWSBkphO/Zguycwrhpkt12YBsSGmfnBAIBjLNv/7GlL5zLWBwvHm8PbrrDzCY5KWnMeon58CT5CDXGmoiqDp9I/5bad+szc9yx0ALflHbUxY3bxaaTjldeNgOJ8ihWxhOFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/18] clk: imx: misc update/fix
Date: Sat, 04 May 2024 08:48:53 +0800
Message-Id: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWFNWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNj3czcCt3knGzdRBPTJLPkVPNkQ9NEJaDqgqLUtMwKsEnRsbW1AGa
 jee1ZAAAA
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
 Chancel Liu <chancel.liu@nxp.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Florin Pavelescu <florin.pavelescu@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Robert Chiras <robert.chiras@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=2595;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/4QFCsE3xBmY4w7jpkFfAWfR/afmM/wGZ6lkkJbEAdM=;
 b=XfeN93zOna/of4biPn9LWRkCRYeWNoqNsOAJ5qSF5+H4B+tkPG99JAu0vr8yTMFMrNyngGYYX
 ycg0z0ANTSZB9evipUN/DZdRHTtOEMPriHw2AYOS5a5cgQYtseurhIL
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
X-MS-Office365-Filtering-Correlation-Id: bafb7d6f-6f38-40dd-27fe-08dc6bd2df9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU96OGp4VWIxYW96eFQzMldnc0F0VlhXN3poa2FUamVKQUh6WjcwQS9jVXVy?=
 =?utf-8?B?aThLVFRYVng4aVRTYll4VjZldjJPTU5Pc1dRVjdPNlhlZTMvK0V5Rzg4MXhQ?=
 =?utf-8?B?UkpGWXJmcDBLVEhVa3RlZDcwWkszV25uUUNncXNUb2RwUW9Hd3dzN2FoUFM4?=
 =?utf-8?B?Mit4bDdOWmczd0hIU2JScjdlWTAxRFplcUpiNmFCa3RvMERqa0l4bnBMb2Fk?=
 =?utf-8?B?WHB1cFZ4L2N1Yng2Vk9UU3JqaUlxd3ZNYytMOE9LRmliTTR5RnNBL3RxZlha?=
 =?utf-8?B?L3R5RVZqa0kyTzVtOHNFc1hiOU02RlhhWkF1Znkya3JCdmRZNXpxdjFwMnRV?=
 =?utf-8?B?ZGJZbHRwOVg1RmxXYVBJWDg3ZWRZQzZkZkhicE5LRmhKSUpqK1lGTlE1Nldm?=
 =?utf-8?B?MVBqdDJ6c1JubFJtbWpMSjBxSzgyZmdPd0hacXBDUjA5YVJ1NlkybEVkdFY4?=
 =?utf-8?B?T1JqOUxnYlhvRlFJOGJhemh4d2Fod2xoUXFTbFF0OG12Mjd1R1lnY3dGbXFO?=
 =?utf-8?B?QjJucFp2YTlwalRrVVRiOWJJL21vblgxQXdUL0VPSmNHcUZRa3dVR29YQU56?=
 =?utf-8?B?amFLZkpCOHVCbEd6c3A5R3djYmhUNm5ieU9iL3NiS0FnTWQycHpJVS9CUEZm?=
 =?utf-8?B?NlVDVzlxV3J5N1pDWUoxOVVXUXI1U2o4b2JMNUxWa0R2RWpwV1dqODhMMmtX?=
 =?utf-8?B?c0huazd5cXMvMzF4NWQ5NWE5L09YOEhVUVVpajJHUzFnR1Z6bS9aUFkvOWNw?=
 =?utf-8?B?Wnk5dXE5T2dhSng1WklNdDEwM2RhR1Vac3k3VXNFcHdlcTN3WVMwaFhCeG9q?=
 =?utf-8?B?dlZMN1NQUm9seDN5MkRyYzFDVTArTjZnR25zVmRuU09SNlZxUGRDL2FlSDhC?=
 =?utf-8?B?QlFCUmQxaHc2eGsvcDlIYTQrRFdKK053QTh5KytnUkRRZmRBYmVuRFhEWVY5?=
 =?utf-8?B?b1ppTmMzdjZEQUptQWlDZUsxOVNiSEg1UmZnaTloRVpZbWdEVmhlcmErb1Rl?=
 =?utf-8?B?bFFwUkU1Q2JxRCtiRDBtQm9ibVpCdVVWVi9JNThyNWJsQmhVSkdlVUNuWFVU?=
 =?utf-8?B?bUwvREZxQm5oM1ZxeDdsSzIrUmI1U3hGU29ZM2hzN21ha29UZzNPbXVNRmJL?=
 =?utf-8?B?SXY0eDBiUzJhNmpsUy9pcXFzcWw3b2tDWkxNS2VZNHh2anZxK21vdnNhbnNY?=
 =?utf-8?B?UGh2RWptWU5EMklQYlBnT1QvYmpYNE16VWNsNWc0YWRpVUU4Tjlnb0FiK3hH?=
 =?utf-8?B?aCtQS1hUUXZma2NjdHBOZFdmWTNoTjR6MzBac3Btd2NQNU5TNmdrUjl5aFlx?=
 =?utf-8?B?ZWZxRUJxTUJFbFNkMXRub3oyUm9sWU9uMnBQdjJoTVZLaHJ5OFQzS2MzUUN1?=
 =?utf-8?B?MVNrdjBRS3lYaytIeTkwOTRYSitGWFJ6b1NLdDExUEFKeFRMbERpOUdIRVRX?=
 =?utf-8?B?L2hVSDJCQjZMaG1aN0xEODlManhEMU9jSHA0ZWZqN0FrZVkzUE5RdWJMSHhj?=
 =?utf-8?B?ZTFaYUpwTWluRTFqYlU4M3Iwem0zT2NpUmhhRFhKS0haWFRid2duNm1qNTNt?=
 =?utf-8?B?bTZnVkdhZHVLSmxmUzhqZE50eVZnSEZFeEJUck9tTzNkblJMclFwVVUyMWJa?=
 =?utf-8?B?V3puQ3hwQXdUVGIrQ2ZkYUZUNll3cyt1MkZaaERPV2ZNUWNFQU9sblFHOG1s?=
 =?utf-8?B?OTdsSkZUb1dDajhqRXdueGNEUDlBV2trbmtMeS82cys2WTJZakNRb3FWL1Js?=
 =?utf-8?B?K2t0aXdPOUo5am9FTTcrZGp1TVR6Mzkzd0lOUEJYb01rQXlZYVpOVFgvNjIw?=
 =?utf-8?Q?0AmsD6tY6Xf5L3Q20cH319k2gWRQ2RGgkBZqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEQrbGpnSWpHM3Rua01LV0VVZytwd1RKQzZCbnVwTFY3YjNhZVZVRENoaUZS?=
 =?utf-8?B?a0JTNG9tL21IK1lSbXdxYklwNm1UQnB2dlFQcVBNMzN2emNxcDRNUGVrT29v?=
 =?utf-8?B?TjlqVC9iQlZwQ1JvVmlpaEkrS2JoVmVhUUxWVkRHNzBrV0QydVZ1TTBGOEh5?=
 =?utf-8?B?cGkwQjc5RmYwODZYWDJVR0VpeG5naGVDaE1OQ2I3eFF5THhpMEJWUEV3NXY4?=
 =?utf-8?B?NU0vVnB6QW9rUXpCRHBvYjlSNDBqc0JUMjhjbFozRVFFaWdHdXVSaTA4UWNj?=
 =?utf-8?B?bzN6dHNvRklnNnhvWTVVVEIvOUphUzk2bDA4WUFxNjZSRUw0TUozdTlGbzAx?=
 =?utf-8?B?eHRaKzdvd0s4U1dmWFpUYVRvODNTUVU2SXorVDZzY1UyN3RpWGRVUmNhL1Jk?=
 =?utf-8?B?R09kc2hXTkJkWW1HeTY3cFdqaDdMbUlFYUNvdSsySk9ZUFNUakk3bjRrak1D?=
 =?utf-8?B?OTI1dmJvUWUzT20xUGZPM2RhU0N3L21Mc2JmREdzUTR0L0R0c1VPSkkzM1Zs?=
 =?utf-8?B?bzZKeDVkYURnMXFxRGtJeXJNVmxTNCtnRCttSmFXYzVuZm9aRGFEdUo4d0I2?=
 =?utf-8?B?eHlMd0gvMEVuNUdMcjRTSDVoTXJ3anJyTFRqNWRMSlJDdHliRmFJMGNTZjA0?=
 =?utf-8?B?M01iaWRteEd6aGZacU5XUVJlS3NvWG0xZEpjZGhkRWF3WHFFTmV2cWlOVTlX?=
 =?utf-8?B?NC9xVUlhay9uNVNaRHB5OUVtdnhBVXpMeXhHeEFOQmJycUhrdW9EdkRsTHdX?=
 =?utf-8?B?ZTF0U3p6RjU5UFJPaGpwOXg4azRENGtKYWZmSXpiVGhrZWY1dGt6QjRiLzgr?=
 =?utf-8?B?Q1RQYjI2aWM5ZEhZclV1MXBFVlBaYlVTQlBjTEppK0VEb0VPdEo3Z1VMRTZ4?=
 =?utf-8?B?VGRQRGpQcnpUV0RHWkdoa04yU2V6dS96eS8ya09aMHVnK25LMmo4VENmNVhP?=
 =?utf-8?B?Q1FVcVowS2pIRm9DaHhxNHZZTXp2VmxwWDVWWTRtV05zcTN1NzJYeHVsbXhI?=
 =?utf-8?B?U2xrTWZXQko1WkU0a2hBeHZGZys1Wkx6RzBSNjdNWVVUZEtTSU4vZUJ3c0xY?=
 =?utf-8?B?YmFNUkRkTWlCcVRNRU9rT2pDaE5kM2lZWGhVYzFKV1FHOVowb3dpb29BTy9v?=
 =?utf-8?B?SStxVXZONUsrOEh3UTZTbVRpY0l0R3FOa2p1bTQzK2x6RmpqWWc2VU5TMnJZ?=
 =?utf-8?B?Z0hUaU5aUjZkR3A4YVVtaVVFT2FmVWU3M2QxcWpsYi9kSjllWnY0a2w5Unc4?=
 =?utf-8?B?MzJWRGNnNlhGd2J5c2hoRXhsT0FBUmpUelRsM1YrWCtSWGpBZis5ZG1kRTNo?=
 =?utf-8?B?ZVdEdEdXUXprQXpmbUkxb1VpN0NVUjgrOEhCYms0VHlPalBWeEFxcHV2N1Vv?=
 =?utf-8?B?MUpsSnNqdmpFay9EZXRRN0JieXV6RWw4RWV0VGdHK2xmcmE0WU5uMDJ2ZEtO?=
 =?utf-8?B?cWg1NmMvNFl1RVNoTWo4RFNwR1FpM0kwOVRkRTQzWmNLZDRMT0V2cVA0aFF0?=
 =?utf-8?B?Nll0elVmRVR4RDkrRzN6YW4vdzRGcSt3czRJRStrakhGTDBrZ0ttTFRMVUVC?=
 =?utf-8?B?Mmd2N1lZRUtjTFU5R0Zud3p0N2MrNGZYV0Y5MmxwWVdmTnBjTi93ZXpSeVg5?=
 =?utf-8?B?NUFzVzZxUnM4UHdlK1ZFSEhVYVMwTStDZTh5T0JOczI5UWJZWnhwUm9iTUdG?=
 =?utf-8?B?TWc1emlmRGxVdVVaTmp5dXpQaTljOWtGaEUxdmhxdDJRTjJGOTQ0K2ZlNkE2?=
 =?utf-8?B?c3NPdFpFY0p0b0NWL2c3NlpnazFNL0syRDFKY2VNL2N1N0tPK2ZISTBRNTdZ?=
 =?utf-8?B?MlFCOE5KUGtXWDcxK2NLWDU3NUpkSWI2ekdaSUtyZ1Fia2QzOEMwUCtFUnBo?=
 =?utf-8?B?REU2UnpaQThmMFR4YXhRamNhaExuanlCZEdBZUdGZjhHNVpPS0tjWTNEN0xa?=
 =?utf-8?B?NnNqZStGSm5zMEdkTEtxa0VEUmErOVNQcGFSRFlCKytOejJ2OCs2MUl4OXlY?=
 =?utf-8?B?UlN1RUlZaDFJRHNBckZWVU55bnN6TnhJYU5VWU9XTTJYOUszOXJOdzd5Y01L?=
 =?utf-8?B?S1NuZUcxRlJpbi9TTU9OZXNTSWVJYjVkTWtxaFhXbHlYaUcvQnh6OXc5NUVj?=
 =?utf-8?Q?F6so2iSjMptYWkI4fhg2ctbRD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb7d6f-6f38-40dd-27fe-08dc6bd2df9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:02.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbqLgNLhVn5T1aGg5FStQt4F3SVV4ZpEsJ54+Tw0lhr2TULUqCERESrnYWFdb7tFvJ1CxRe3eugZkTKEb/tifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

Upstream several patches landed in NXP downstream repo for some time.
- i.MX8M/93/7ULP composite clk update
- Fix Fracn-gppll MFN got lost
- PLL14xx update
- i.MX8MP DRAM CLK fix
- i.MX8MM/N misc update
- Init i.MX8QXP parent clk before child clk

Downstream tags are kept for the patches got R-b

Although there are a few fixes, non-urgent for 6.9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Adrian Alonso (1):
      clk: imx: imx8mn: add sai7_ipg_clk clock settings

Florin Pavelescu (1):
      clk: imx: pll14xx: potential integer overflow eliminated by casting to u64

Jacky Bai (2):
      clk: imx: composite-93: keep root clock on when mcore enabled
      clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one

Oliver F. Brown (1):
      clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks

Peng Fan (8):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: imx8mp-audiomix: remove sdma root clock
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
      clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
      clk: imx: imx8qxp: Add LVDS bypass clocks
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      clk: imx: fracn-gppll: update rate table

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Shengjiu Wang (2):
      clk: imx: pll14xx: Add constraint for fvco frequency
      clk: imx: pll14xx: use rate_table for audio plls

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

 drivers/clk/imx/clk-composite-7ulp.c  |  5 ++++
 drivers/clk/imx/clk-composite-8m.c    | 53 +++++++++++++++++++++++++++--------
 drivers/clk/imx/clk-composite-93.c    | 15 +++++-----
 drivers/clk/imx/clk-fracn-gppll.c     |  6 ++++
 drivers/clk/imx/clk-imx7d.c           |  6 ++--
 drivers/clk/imx/clk-imx8mm.c          |  2 +-
 drivers/clk/imx/clk-imx8mn.c          |  1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c |  1 -
 drivers/clk/imx/clk-imx8mp.c          |  4 +--
 drivers/clk/imx/clk-imx8qxp.c         | 51 +++++++++++++++++++++------------
 drivers/clk/imx/clk-pll14xx.c         | 21 ++++++++++++--
 11 files changed, 120 insertions(+), 45 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240503-imx-clk-a45b6ce7c15a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


