Return-Path: <linux-kernel+bounces-168473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4568BB8F4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7753028654D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA222F0A;
	Sat,  4 May 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TCR+q0xQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563912B83;
	Sat,  4 May 2024 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783346; cv=fail; b=AOhhj4iXL3Le9ZWbz/gtwFWVT/IN6jv4U01aZOCGHIwzj+oQnKAPEWzcby60aq9NCWNyTOeOfhVqY7pSFzsQ+434tm1g1DsHb61A49XRUKxUHjoIwAAzEhBRJWV6DaYyuaimc5k1xTAG9YtY1NUOPkanRDwQAs2HfdI+7Zm8WmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783346; c=relaxed/simple;
	bh=BXE8p0r/N9cwzw9hvSQemC+9EJkYUN9CqF+Rr+r1zUs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tR9nAn49CHFY1cvmvesxYZxHCNs9q6txYNwkIkjR1XdIF1RX2v9teMWHGaDaATgrqEaVwAmNHfPZt7dohXqnZZsUbARvpL6EvZv7gPBgUmiOYhS/UbYijuDaPxH+dYkb7h5x0bARXolWNa0N97Br1I8oVXsSXIjI31sNObOZ/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TCR+q0xQ; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMJh70j8v+JxbUDT4DWADIXQiHst/5kU+pFvUZWIwdXiElSWOD2CDRR9b5ElC/GZg1u8KlwXPW+JL/8W8Z74MFdAjUeBg+EeQ8JL2XEZbXfCKemoyUdNx0pg2MeYu8O9dqXpEJAzToMD/0yuy7vx5oUGVDqiTNdHRqx/0xgRByJ0Yc/ZhIDE9rNgtVePW2H8V4ehsfAK6d6J1xR3wiUHsjzfLRc289dM87xotoASuhbg+vkk7vtYGP8tQ1E1cIP/qy3JlNCEN2GsA6K3Q67qG8H6rlx08/hYZQe+3GKFi536c8qilqKaJ+H8rBC6/Jp8Tdd2QrYY/ktpXHKmvwB9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jembaBdxFeQLoGQq8jEpWbT4U96f9uWnSv2yKKMqdjE=;
 b=Ub1xo60CDxyLwLRTvorteroJeqLDDqF55DAK/GtN2pSCTYkSiIPPLp3/0ocihZVVQllS1SstmLqJAPcxIZyd30tVynCn7IYgsD3gad7v2deSEuXqgn3tMo+z+ZETg3h7sOyveAYyDctiS8EdvmaCCzpc5qQZhSBYWNPJyeWfcdjF5x/lHkFE1kN9hk/WFCzZdu+AKvzrB5yxW+pjunc9dbEzqABUbMjs9d7KvqkEJ28BJFSXsMPi5JP6HbaXI80vF5NJXcAsHGloxgTG/m01VKmRuxc4R8tnzaWTkqN6MUXpVjMlkba486BEryG20wAN5KBMVA7JdX+8Zqkyy5Lzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jembaBdxFeQLoGQq8jEpWbT4U96f9uWnSv2yKKMqdjE=;
 b=TCR+q0xQG3GmSs5mSmtj6oN6GAXeNJRafGMd5wj4tlnV4uucE0eRfCAzNv9ovZ9Q4v5vkqFbxITur0QrLvC3spl058Fky4+7Y93Awyi3x/RzzHVbITiExgFi37k4BuES4Fntornf99p3Ib/qb93Hj0UcMiaqtPUBQG2Ay45I7jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:42:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:42:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:49:07 +0800
Subject: [PATCH 14/18] clk: imx: imx8qxp: Add LVDS bypass clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-14-f7915489d58d@nxp.com>
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
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=3946;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UduvV+cQrI7InFFBa0tNN9NOOunIk8WRP1Hq2ak4H5Q=;
 b=oJkFQnbH5D8mssVtVdKyx2I0Is0kx0tcLJ17MN/7ouK08gpqyC7u6Hxf5xOODYxdvixwlY8Zm
 zs3yUvQYONVCDyTiGUDhEfyrTnHq3/17F6shgOMkw4vZ5bvsXpZQKpa
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
X-MS-Office365-Filtering-Correlation-Id: 25acf670-d556-4736-2b13-08dc6bd30dce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGN5MG1mRy93Q3p0TW9zQUhaekNVb0MrcUM2dTVxZDMva1dmazIyWXFJNHli?=
 =?utf-8?B?UjMrdmRKZDN1d3FOQ1ZnTE5EU0EvQlZCSDlRcEZRSXI1R0JxTjJMeFJaSWx3?=
 =?utf-8?B?bm80bkxNRVVUOXI5QUVxWnJlNkxtTUM5NzZwWjZ3cU1ZSW9FOVBZeFVtQ05Q?=
 =?utf-8?B?Z1p5NWp5VHIzVXRGWGxWd0VoTEJBR2EvaE9pVWpma20zZGlzOGM1Uk9TQkVm?=
 =?utf-8?B?bGtLcUwva0xsMlJoeE5zOXNqZ3lmd0YyS09UVDRLdnlzM05BUWwxVU11Z29x?=
 =?utf-8?B?WEFiNUJYbytjUTJsYnVHSDZHQUgxbnN0MS9GSXIrL0dLVVJaQ080bmViYVh1?=
 =?utf-8?B?bnl5ZFJUaHZZQ2IxdW5adEk1WUFrTUhTY3hnRXJYZXNLZHRCOGdib29FOVE5?=
 =?utf-8?B?OXVQVkJIK1R0cWN2MnlOL20xV1QrT3lDRWNQOFo2elZhWlltRFdNUHB1MzB0?=
 =?utf-8?B?U2Ivd1h4Q3RlQngxajBjM0hnVW1iSENzd1hrcDI1cTQyNjZ2ZFplNTVkMDNi?=
 =?utf-8?B?YzU1cnZqdytzamV5ZFM0VFVpcWxod1VVWHJUcndXVWJyVHgxOVFmVUYwYnRX?=
 =?utf-8?B?MTRGYzlRSlVvS1MrRGkrN0ovcW1oOUJRdzN0WUtXbTR6ZEFiZW1rRlpwbjl0?=
 =?utf-8?B?WGtxVURQdFhrb1JSK1dta08zcHNTdlR4alM5L2w1WTMrVEo2b2hmWitmQlZY?=
 =?utf-8?B?OVI3YXRVWG1uSmpQVTlNOWs0cVlwN0d0OVVJajBoMllOaWt0RVVkeENsWlFS?=
 =?utf-8?B?ZFpkS3Q5MUhtVTJNT2N4MnBmSlRxeHk4eTAxdTZSNDFTbjZIaWZOZEZQRjM2?=
 =?utf-8?B?U0FKcW5CejBUR1hVVHRxeG9vOW5CbzhEUHEybHRVclE2VDNuSnBFMDlNQ2NE?=
 =?utf-8?B?Z1VucU16UVVZckE2bWQvOStFaWtDSG5tN2Q5QloybTFIaXdBdzdsMDBUTWli?=
 =?utf-8?B?NktVUzJOV3luR3lzQ1EvejM2UGtHdUlOemNKdjhiM002KzhMT0t4WUNaRlV0?=
 =?utf-8?B?ODlBeXBhUjRLMjgrS20ybTZLaTlwdmYwOFhndkZ3S0FVUXh0TVFBci9hTklu?=
 =?utf-8?B?cS9OMVVaN010Vzl4SE85Q0l3UW5UVVMzNFNPcjhPVWhWU1luZGF4T2J4dTA0?=
 =?utf-8?B?T3U3RUtuRm5VT0RtOWpyYURwdlY4WEh3c3lPMGFEYWlSamI1QWlWK2M4N3h0?=
 =?utf-8?B?Rk04R0IzcnpaemxqZW4zcTBmbG5sZ2tJeUJFWm0vMEp0QzhROEhhMml0WXdL?=
 =?utf-8?B?UEdocnQyUk1RazVnZGpja1U2K2l0U0FiN3FOR3R6RTROVzkyM2trU2NJVFYz?=
 =?utf-8?B?ZTl5VExicDlJMExwMlR3b2wxL0VmaXJkaWJXSmxSUGVvMHBQWGswSUdWNXVa?=
 =?utf-8?B?ZjJHUFd5aFI0TVRnb1l2ZGJYaVJySEp4ZTh5dTl2b2wvSU9TQWpDN0MrWGxz?=
 =?utf-8?B?VDNwRDU3UXd4eFB1Z0t6aDRSRDU1V3N1YjVlRk05N3hoYk5HN3Zrb3BJd09p?=
 =?utf-8?B?R1dPeE8zaHJlTzRkUFFSd2JVMGI0WEtHUFIvak5zU0sydEJvUHpvY3dkTEpt?=
 =?utf-8?B?SEhVTDg2QTYwKzNId2VmRVJZY3U4MUJhK2J2ZEljWTExWVR4UzBMWWwxaG05?=
 =?utf-8?B?eFhOYzhnQVhDNWxHbVd0ZHpBZ1RzNThhWE9jOEF0TkVLZjFuc0FnUVlSMm50?=
 =?utf-8?B?Q3RCNHhNcDV0aFAvSkFKbnEwK0VXVEw5cmkzVHR4akRqUlFnSHlEdXZrRmlt?=
 =?utf-8?B?eEVUU09xTlJHYTl5QmU4SXNTM2doQVBLVzhhNUw0ZXRFV0tLMlNjMzBaNTlI?=
 =?utf-8?Q?pFXX0frrWuEv1crbhgq87a8IovJF5MI/2Ta14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHR4TEFzL3AyVGMwdjRJSEREQ3NFanlvUHhieEhCNHpFKy9pK2JNdStGUHVa?=
 =?utf-8?B?TGh2dTd1VC9SRXRRZXpoUEF1c05ibnVoRFc4QUhPbVZnMzVRRHhVaUJwQ3dS?=
 =?utf-8?B?WWZVVzVmMURzNndDZ2JOZHZqZDQxYlljSXpVUHpKVG14MGhLeGJ3N1JwTTdm?=
 =?utf-8?B?V1gvaUQyaGtUK2hMcGpyLzZvcitJeFdTcGhleklnc3M5bUxhL1pYTi93d29D?=
 =?utf-8?B?ajFIRVpuUjFOUEkwZmx2VUFaWXpWc3FXZ0lMVEw0OHZVbFF4MGRIdHV2Ykpw?=
 =?utf-8?B?ZFpTZ2tldWpuQngwVkk5MGd1bmRtVmZ4SVRvS05rYTE3a01BWGxFTWdta1Vp?=
 =?utf-8?B?QXB5TERwWE1nSklIT1VYcVdDMGs5UFRXZ2VGVzgrTUlneHVla0xqaHZnWXdj?=
 =?utf-8?B?SCs0WTJPb1lmd3huWlBZMUdoK1JpUVRzM1BOY0tpVEN0dTI4dldiS2J3QTJB?=
 =?utf-8?B?aUMwZXdORzBuZGtKRFV5eEphVnc4Q3NRUFBlMm1sSXY2VEQ0TmNQV3lGclpR?=
 =?utf-8?B?dWFHdEgyYTZFeDFob2V2bDF0RU9rUVI2bUgvOGlMZWMwRzNOUDBLaGYwSWFx?=
 =?utf-8?B?RWRWVVh6MDRJS09TWEttQ3FKZEZCRks5bDlkZEdHZ1V2Sk5MWU54bzJQSEoz?=
 =?utf-8?B?Z0hzZ1djNk84WFVrWFRaNjFuSk9yYWhCM2lWbnBubGlZRzlPNFc5Tm5lSmVR?=
 =?utf-8?B?NzZ5QjlSY2tpUjJVcW0wdm5pNGpHWG43dHVCVG56YU9wR3VVb3M5eUZ3N1dM?=
 =?utf-8?B?NW9WSGpkcEpqVDNRMk50SFdsZUFtbXgzZVdPSk4zUllVM3dydzMvZWE2MnF0?=
 =?utf-8?B?QUMxZmtEa0szUHNOQUZsaldFNUkwc1hTVy8rUERqdXlhQkhyaXZLdGRJbGRN?=
 =?utf-8?B?UWV6RzVYMTl4b0R1UGV2REJnVUswcWJwdTQ3azM5MXU1ekpxQ3R1ODg1NnBW?=
 =?utf-8?B?a0NReEY3VGE4djdaUmRIN1cvd1NQbVF6b0FleHNXeEFaWDEyc3lWcm9IQ2pk?=
 =?utf-8?B?ai9OVzNKN0k4RFVXOWRFNUJjYXNHaXltS1BEeUtpcDhOR1NSTW5yQk5qMXdh?=
 =?utf-8?B?TjlyVS9lRXRYUXF0Vk1LL0pYNHd0Yk9TL3pnS0NpNzRUeURsTG9aTGcwajFZ?=
 =?utf-8?B?amIzMVFmeTVEempCQTI5bE1UK2dFRUQ0UG80d2ZmZFIzenlhc3hJVTk0RStz?=
 =?utf-8?B?Y1ZOcEFQbHpUeGFEM2lFK0h1dmJrbHBpY1Z1RFA2d3cvT0VQUUFDQnc4cUFn?=
 =?utf-8?B?cG8xNlVteTk3OFBoMUord1RmUFNMZk9yTzNvckpzWjhseGlndTk0NmhPQW1x?=
 =?utf-8?B?MklIZTlMU2VMcDhRKzFyRzZJYTRBbkwwblBRQkNrSFR6TmtXUFJTRHNwajRh?=
 =?utf-8?B?REtqRHRtSGk5d0ZXc0xZSTJTR1pnS1ZlcVZFU0dMNU1EVklmejBHRjJDQWM1?=
 =?utf-8?B?dzVORkxsei9zejllS0U3MmFkL1p0V2w1NTVYanRxNWwrUnZCS0V4N3Y0a2lS?=
 =?utf-8?B?VEI1b0p5OG5pT0J0NDdKYThhWWM0aWh1Q28vbGVoeGZyRU1MMzJEVFJxenAv?=
 =?utf-8?B?OWROaGtkM1I0Q0w5eGhXaktHdVdGQWFxYXZBL0Z2cnp1dFVzM3M5SnVLeXpm?=
 =?utf-8?B?NURYNXhJWnVsaG1IWjhuRXAzUTY3U1pnNVg2TXdtdXlNQm1yZUhPczVRUmpF?=
 =?utf-8?B?TE5zbk1UeGtMUWJrVFFUMDdwSEE5SjZ2T1dsN2Z0Q0QwSXJpRThmbnlKS2xV?=
 =?utf-8?B?OEs2dTk3ZlM1OWNJQWNkcjZEOHdTTVM0VnVZUHVHaHplQndQMnhEWGpOalFt?=
 =?utf-8?B?N1NLOEFFSGdOU3RUb3hLd0F2UVZ1QTQvTGtEN0dDTWl6bjh5Z0VkeDRZWVFs?=
 =?utf-8?B?VENVaERxVjFzUWVSWUZ4cWVXc0dtdXQ0YUJXdkh3d2hIYkgwVUVvcEhuc1lU?=
 =?utf-8?B?dW92QzRBc3ZRbFBoRVpjY1dGQlNiQU5XejBXdDVDY2ZJVFVIVXZuaXZ2MCtm?=
 =?utf-8?B?NWtlTmVubGdNZ0xScklHc2FKMGQ3SGVFZTU0b1g5N0tLRnQ1SU45Ty9US0hn?=
 =?utf-8?B?RXdJaWM5OTN4RTJac3RNNk82ZWVDN0J5aVVKcDBmYkI3eWJWdW9xN2ovMFM4?=
 =?utf-8?Q?X7TRCaFnMCadBnk2pW2x3hwak?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25acf670-d556-4736-2b13-08dc6bd30dce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:42:19.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nar6kjVz76042Qeht6jW9yLogXZJTDH0TrHNWUOxhkQ5iv3/auRDJFf1Q5sT/Wqt0sOVnFBSVw1V+RbYPCBxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Peng Fan <peng.fan@nxp.com>

For iMX8QXP and iMX8QM, add bypass clocks and register some of the LVDS
clocks with imx_clk_scu2 as the parent needs to explicitly set.

In order to make sure MIPI DSI works well after suspend/resume, the LVDS
pixel and phy clocks must be initialized before the MIPI tx_esacpe
and rx_escape clocks. LVDS phy, LVDS pixel, tx_escape, and rx_esacpe are all
on the same MSLICE. They all share the same clock parent. So, setting the
parent source or rate affects all of these clocks. In the LVDS use case the
MIPI tx_escape and rx_escape are not saved and restored. So, LVDS works for
either clock initialization order. For MIPI case, LVDS must be initialized first.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 7d8883916cac..a0654edaae83 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -71,7 +71,7 @@ static const char *const lvds0_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi0_lvds_bypass_clk",
+	"lvds0_bypass_clk",
 };
 
 static const char *const lvds1_sels[] = {
@@ -79,7 +79,7 @@ static const char *const lvds1_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi1_lvds_bypass_clk",
+	"lvds1_bypass_clk",
 };
 
 static const char * const mipi_sels[] = {
@@ -223,9 +223,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi0_lvds_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi0_lvds_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
@@ -235,10 +235,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi1_lvds_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi1_lvds_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
-
+	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);

-- 
2.37.1


