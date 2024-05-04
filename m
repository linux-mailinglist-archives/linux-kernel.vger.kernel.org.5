Return-Path: <linux-kernel+bounces-168470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394048BB8ED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D10A1C22823
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E619A92E;
	Sat,  4 May 2024 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fx0JN2d6"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB161CF8A;
	Sat,  4 May 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783327; cv=fail; b=I/bGQRsVXS93j2D6S9d7tm/GVRaYeOOv5vVVW7gK6wPgQ/fnVSO9G4Riyi2z2RKWPcy3tgF9wiDGyFEaZwWZCiGwzxQq+gHThaRygGZfokVGkbkfsLpsPjOdB1Mv7lg1nnef7R6+H7I0xsQ2eui4ACopn8QFXmezhRQZp49Rqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783327; c=relaxed/simple;
	bh=i6s2BDOKW6zn7tKgno8avPO6dvuo9b/4Fzr1Ewfft/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RG5TC+4ZndYWIj3iyqmHeYm7tsWsJEoQxTCK1gK8+nw6PMTOztbJfzW7bbw6zdB+Hy2Ke0iIClfhC/mniNBg16+oT/S+H9gZWl/QLUH3wZ5NmP0esqtu8XBQU5wqbzcR2IvzS0VIw3tQxGYrOELRkpb1MYsVrzV71Lylp0adB1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fx0JN2d6; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf/cKsv+RT+XepDl1Fs62jjnPc8KI8/5HvfrSgvSfOfOLoxbD4EMarHPyALh+1NipNRL85O34ZjGB0e0V9rvsPlUqOjVbI3Y/44c+WCNOYu4SSWR4r+NTTKuJ8cJgnUcMcPGygRSBMkhYaJ2iEcJp1mzAI9WDLjlkZey8LPSsmw4WklPtlTA3UQVgYU8peFna1g2ortR5vf7l+9bmLCzdz9ofe4iA26fOQ6ZRzLjg7XMxuGYyW7yhsOjsvMTDgTDsM3xTQfQxjGEzHvb5gwl/DDB4RFmFZcxrAI82gp9XBbtBVlAagX2wZg9BYXMShHs+opLSQDHhVJRinCSwlK64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QiLEK8YsyGhwnQqocYVdqygEuHwuHli5O/GR4Kb5nc=;
 b=gqrM7dsx72s4Iham3b2v4C9ozW4/8XWzaVCYO8Eb6qldhg452robUz8w5x5uMLfhZfPNxwdyuu+5NGgzUkhSfQYNcnxmUblYBgRNQ6nwDi1hevQSR9ZK5TcCuBcsSdSNKo2IYkhO+/Bvz2X3Q7LAgaKR9bQY52gWmuZLuLSuBGRM2GTbWDiEGBA3Aq8s/nVF6m4OffZSs2e663ZComXWzMGzTBpU3b4xwii/Kv6CAa35FWpjjNGiLIVOlgxDKk8xoGRbnkSs4RDbWDpZD0kNMif+YAiwY29gJ9Tzs41XY6NfdPkxuC3FJPeE+vpXBJUUJWNywhNptQ6T+pyA1J3xZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QiLEK8YsyGhwnQqocYVdqygEuHwuHli5O/GR4Kb5nc=;
 b=Fx0JN2d6br5vKiPMkroZNFD3pXopsms0bLmNJh1o3YNNeWTIzIts4TddcF2pxkeFhDWhTdgPGKPv1Weau80Hvg8aFOKv+bi/0wwHu//jWFf9qzVxcpbF0JhoynuX3bjlzpDje5FTrkk8yWFcIFFMD3bYLACpbLddYk3JRB+/VD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:04 +0800
Subject: [PATCH 11/18] clk: imx: add CLK_SET_RATE_PARENT for
 lcdif_pixel_src for i.MX7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-11-f7915489d58d@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=1922;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=enKh4CGkqPk5jRnK8VpEttysezgL5JHxfHa9hFqdaL0=;
 b=XTp+h4w3AqyTKCXKfjxukUQ4LbbM6eoS8gKm8xL5R7dbD9vQsps3qqQjoZ6pMmU6THkkbdpkj
 8q7q8DKNAeeDgtId5ZVDc/w18ORYRYtzKm4t7POxhglKvYB6tCKrvcH
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
X-MS-Office365-Filtering-Correlation-Id: a432a48b-4f1a-424b-ccbc-08dc6bd303f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVPR1MwV2J1engrMDlnSFpJdWhHWmoySHorL0RPdXllL1BvTGNvaHU5Y2tV?=
 =?utf-8?B?Ri94UVhJTW1uMUN5NTA4enhrS1ZWZVhpSUgrK1ZGSHVoaEpBbElrSVJ4MFly?=
 =?utf-8?B?RUNNSlFRQ3ZkS0NlaE1sOEtLUG5YTWtNempTK3AvSjVlU1NBOHZhVEdFN2Qz?=
 =?utf-8?B?Ukw0Y3NJVWpad21VZHFuc25hU2E1azNkcFdrTHk0YitpdFhyRGNQa1lIVkRY?=
 =?utf-8?B?em5GSmFXNlJ1MXBRcnMvRlN6VlJoQVh4bmw4eDg3bHBYSUdZSExWV0VxdEhP?=
 =?utf-8?B?NjlXNk9lNjR6M0FDa2hyR0lrcFI4VThSbEN3dTY2bGVCYjUycjZqekhsUXJ6?=
 =?utf-8?B?VjFZRFJ0ekZ1ODdackErcFQ4MmRhQnpmRE5TdExRczNra25YQ3BaaGdGUlFD?=
 =?utf-8?B?eURER0NWclMyUTJ2TlNNSkk4V0tZNjd6TXRBa3ZlZm5xU1QxRjNtSzBGR0ZM?=
 =?utf-8?B?MVFNdDlQY0ZxdVF0VXNTczRGZmFHNGtwSS9ZSUF6TkIzcXJQalFQTGxRUmVO?=
 =?utf-8?B?QUQ4bDZwcTJMdSs5UWptKy9lRFNsa042enEraWR1Q3pJcjNKYXF1NkttSDNF?=
 =?utf-8?B?dnp3YmgzZTZlVnNiZkJzdUVjWFZWajhTcU96cVdUd3RtQWc1amhTcEIxVmlo?=
 =?utf-8?B?UGJOL3Uwa1AzeFA1YTh5R2dYNzZqcnc5czBpUEl0V1AyVk9nQjlYZDhLc1FE?=
 =?utf-8?B?Skd6WER4OERWcjN4SzZ2RVA5NjBMKy9yQ0hLZjM4UENlSFhuK1Z0TUVhUU9v?=
 =?utf-8?B?ZHNteWsxOFF3SVdvbDlOd1JsVFJSalUvMzFSWFpFODllc2VEdGdJLzdMVlpF?=
 =?utf-8?B?cm83Z1VYZkhrQ0VwNjhUV2JyTDBaYS8zcW1oSzFoZ2ducnprSng2T2ZLbWw1?=
 =?utf-8?B?cXY5c0hXckZkWllzaERBSlZFQWYrd0RHZXlpcmQvU2hENkZJT3Vpa3M4MERl?=
 =?utf-8?B?bjh1K1UyaTlkOVlqK1N0YWhWQWRNbDVFMERQamVjUG9maGZ6UC8zQnM1TUFZ?=
 =?utf-8?B?ZnpDVzYzTVN3QmlhcytXVXpabUx2cSs0MnJGUWltR2Y4MHg2MGVEVklWZzM0?=
 =?utf-8?B?UXZpeDVSZXBidm03am4yUkxmb3VjTHRhbmhhbjNUNExFZjNuREpLT3F3dE5H?=
 =?utf-8?B?azQrNk5GTWQ2WEJVWW8vTlRGSUU4YVZjdFRyeHg3cUFsWWNQVkQvR3cvU1p2?=
 =?utf-8?B?UkxFdnBWbUVvTnpoQWxBSG5lOVFpbGt0M29Uc1k5ZytXdkdwMFV1TkcySUZ2?=
 =?utf-8?B?S3ZVWEs0REhqWnJMUTUyRVJIVEphenR1WElIZ0psZjRtZGtCOUd6MVhKK2RU?=
 =?utf-8?B?Q2FsTm1qaWVLZit3bGpYZk93dHh5QkgxWUV3cTFlQ2ZML1FScVBQYnI4Z0lO?=
 =?utf-8?B?eWlCaHJyWnJ0QXVvUVdZMk0yUVZoYURBdUFIa20waDZtckN5eEEzK1ZQakli?=
 =?utf-8?B?RS93QVVBN0JpeFJaYXMwaW5tUDNIK1M5TDRsMU9ONm41bGY4YU4yYmRYc1Rn?=
 =?utf-8?B?MlpyRndMUkx4VUZESUd3TTVxWGUvbUg0eXBTMlhHUHYwdk02UHRmVjJFS2Ix?=
 =?utf-8?B?Q0I4ZzVlRlVwdGVGQ21WdGFwWnMxdXVYSUppcjhIYjVRT1o0TS81RXhwMUc2?=
 =?utf-8?B?OTJHSVpqTElEa3RMMDN0WWQvZ042UkdGdENGYzFLeWtPV0JtVXJ5anI3dXpT?=
 =?utf-8?B?V2RpZllwcWc4eXp1VnVEYXFZdkVScWFZcnk1Ly8zOU5VaEZSdGc5Um53M0Q4?=
 =?utf-8?B?RlEvMFJJVnNtRjRFWXVxSHdTeUVDWnVIcVczVitHUnF2VXJoOSsyUGpqR3Yr?=
 =?utf-8?Q?MP2/qvgjtFbQMheB/x3bBY+7YZ8tXAbjohszk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dzUWFVTm1nUWFWYXVoZVNGcjRxNU94WVZ6YXRVRmdzSnFCRzQxTWV6cjNn?=
 =?utf-8?B?RHBoMytHWUZON0dSUXFWNjNsRDJFemxrSEs5VTQ4bDdUczdDZXJZUDhGamR3?=
 =?utf-8?B?cEVFVDJndGx2UkFFWVREWWlRclpENEZKcGk1M3JsYW5JQnMxTzZCVlBLMTkw?=
 =?utf-8?B?VHl6dmlXcC9XWUhXb1ExTW14UnZCU29JSjF5YzdEem1CMSs0ZG54RTRqYVZp?=
 =?utf-8?B?N2E4Wjh3eW5YSUNZOUxYTkhkNE52eDljSzU2S2UvQ3JsWThTYmE2ZFFjcTR0?=
 =?utf-8?B?Y0Z5NnhTb3U5c0dKK3JEQXBhTW5sRC9RTXZyc0dsSkNqdnFFOEdUeWYvZFV2?=
 =?utf-8?B?K0pmbUl4YVJCeU8zTG54R25Nc2M3UjJHWUdtclVCRHpHblE2cDdhOXc5TzJV?=
 =?utf-8?B?aFFzRmZvbU0wS0VDZWpmVjhsWTZReTMxM1o2TWJGL09aT1MyYS8zem9RdlZx?=
 =?utf-8?B?MkxXMXFKTXdDbmdyZlJ3T2E4eWx1ei84clVEc05PdmcxYmFKbWl0RURBSk90?=
 =?utf-8?B?S3A4WjBnZ0toMlNmVzhQT2k4d2hUNU9WRDN5NFNkMmhzN3VHaHk0SEVJWmpS?=
 =?utf-8?B?WnNYdHo5NzBvOXZnTVozVVMrYWI4dmtRditFQnhabXdCRWdqTVgreUpIZW9s?=
 =?utf-8?B?OWVjWFZxSE1OSk9jVE5hbENFUmx1aDFrejlRczF3c2Z2UFNQODdFVTdDUTJ6?=
 =?utf-8?B?c0pBamVZMC9IYzBHTkpXazNVdWIwS3hyZXlSWlR1U0ZjL3NOR01VSnBvSHRC?=
 =?utf-8?B?N0x1T2oxd08yb2Y1MXVWTGZPRE9wQm5iK3Y1YkVtckd2TU9MTitGNHI4SU51?=
 =?utf-8?B?ZVdUZ3ZqM04xS1JwUGYyVmZRT2cxK3ZvSm1Hd01UTEtRVllZRWNRWU45ME4y?=
 =?utf-8?B?eXNqY3BOQUdOZ0ZwRjVIanBuV1JWQzlUQUhnZ2Rxa1piTkwxcTlIMEdsUTUy?=
 =?utf-8?B?Y2hVL0dDNnhZUGRCdWorWTdQTjRjRVhWTnQ1VnhCVjhMTlNFWFQxQy9lZ0xX?=
 =?utf-8?B?NXQybW44SmRxTGVhamhCaFFnRUh6cGVobVRsamtVbUl3SHdSM000SFBJODVj?=
 =?utf-8?B?ZEdZdmFYR2l2NFVXTzY3cmtiS2RZanpJU09GRUhvUWszMGJEWjZTcGJHaFBL?=
 =?utf-8?B?REZpclBrTWpJZW1KcGo2elZUQnhlVlFpaVRIOHFMbjhORXE3SEIwbmp1aEF2?=
 =?utf-8?B?MlNNS1NFWDRZRXg2ODAxb1hiTFQyYTlSdjUvNFNudVJ4RVFqeDZSSmJZckc1?=
 =?utf-8?B?eVlwS2lvTXdtT3o4cEJrZGxpKzJnZHVGRXN3UUk3T2hoNFc1VGlMZHgxeXlT?=
 =?utf-8?B?V2NWakgyK3MxcXhkd3hRWU9yYkVOaEdIdWdmSnlGcWJBa3dIenlMeUNncm04?=
 =?utf-8?B?R1JaQTNYQmlrK1E5RWxDblJoc3ZjQldvbTM2MnhOT0FLbTI0aUVyengxYis2?=
 =?utf-8?B?UVF2MC9aWnJsS3JpelNCNkFqVVNmVENkcW03OEVMN1ZDQVUrdFQ2aDJ4cGds?=
 =?utf-8?B?c0t4aXhGYWpuQnMxV1YrZnFaNVZNZWNhdEtzZGx2cDJqK2ppMEx6MnNWcVZD?=
 =?utf-8?B?blNiUUErR21Edld1d1NCaDJveGVDZU0rUUJPM1o3Y1Z2S1FiRVJVNm9hV2dM?=
 =?utf-8?B?QmJZeG9WMGcvSUFSZ1NvZHRVaXpDeWN3ZmNlTXNLbk9JZndOYzg4bThtRnBJ?=
 =?utf-8?B?OS9UNG9iQ1lPdi9FdXJFZFlrZjcwR2lXb3BCWHRvVHpoNVlBSCswYzlyaEp4?=
 =?utf-8?B?UXdqOE9qVWxwZTNacVJmY2VjbnhUaVYzcjd5K0VpZzkvOFhrQjBxQUp0ZVhX?=
 =?utf-8?B?SlZoZDdxWURnK3luUDFZU2RmSU9KTTVxdVZBY1JVQTBGTjBNMThTMDllblhM?=
 =?utf-8?B?WWJQWFlkalpPeTdzNy9FTG1TdVdGd2dWaUFtTjRrSnJMSmpnL3VKdlUrRWQ2?=
 =?utf-8?B?NVpOSXFxaUpTMENRRGF0YmlDa09Wb3hTdUZPSlMwTGZtY0pZc0ZlVzdvZDJa?=
 =?utf-8?B?ME1kcUNMajJLSW8xNk5wQ0d1M3FRUVQyUjZKczMrRmlqbityWHdkeStyY2NF?=
 =?utf-8?B?WFlvdEZKVDFYY1YveStXbWpNQVQxL29RRzVCYjJ2Q0swR2lDb2swbFZNTEpo?=
 =?utf-8?Q?RJ0WiJQX8tWpIgCO5gTYY7hEs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a432a48b-4f1a-424b-ccbc-08dc6bd303f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:02.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU9veNwkwDRDtIPXzqhmYcvvFvZAskkGXdrs0TGINDJ024NyqSCTFS4Dw+xeKPdH6HIocEjN5CPsWmCibeuUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

Add flag 'CLK_SET_RATE_PARENT' to 'IMX7D_LCDIF_PIXEL_ROOT_SRC' to
propagate rate changes from LCDIF pixel clock to video PLL to
provide more accurate clock rate for LCDIF pixel clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 1e1296e74835..99adc55e3f5d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -505,7 +505,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE | CLK_SET_RATE_PARENT);
 	hws[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel), CLK_SET_PARENT_GATE);

-- 
2.37.1


