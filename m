Return-Path: <linux-kernel+bounces-161416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583088B4BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9181F21A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23636A8A6;
	Sun, 28 Apr 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i/5cIerL"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72BA6A8C1;
	Sun, 28 Apr 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306487; cv=fail; b=AshbgNlytbCQFYiRbTw9bDnZaPWFnmFOgqOrm8n/kvoB3DiJWtUEGp517m7k8Hm3twtNbHFU4HUbbRuvPyAxirxWFZq9SqZ40ctIHambF5sU3QUmnMtOW0mMRb6NlElooUC1WB2TeCaAIthH2LvUMp6rfJ44K+2I7iDE2ls7s1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306487; c=relaxed/simple;
	bh=Hu8Y6lppkOettce1a/rFH1WQtUm08Pv1RkhM7lBqUbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a11h7wVjByyz4q7hPH0IkUDrpm474qfYx2lDYfGO5NtrKBbBGTQNLMj9PyQkZilPDvcccv+LUk3bWyRMHzJScfgsvMUUq4Ar9LTRfzuhpXny2fEwMgrsfItPAWGgoEfEqV12sPcp2cpg2Rcyz8k4eIeS265ZxrYu4XE4Rd9q7oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=i/5cIerL; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJz4BP56YQKj3TxPmTkNp5x6n3NSFsntRsKnMTv1uODJFyJ6glQbwyoFvr9pAAoPUyb881OqlOFGIkaZ8ssn/S08SVmEUiKK3kuSjP1+Q+2jfS7Xclh7pimV4RsHbr1BgpubhBfMqq4fGDU3M5dJNUOKRgmfdZHtYbuKqOCc9N0Kl1gUL+Mr4CNQBogcOP7RUk0Ef9pczR1Z9vtUjMT4+Oq/aNuaQgXOQNz7pVFvjflivhXaJ+O4YsvqwzWD07BYFusxgNI5PXpy8P0zNeRRQXKwf/XLE+1Q6HwK8fMVL+jKx+ZC5GcZ3PwqoVOW9F3TKk/8PWYEP0BGMyeY0zfHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KayQ5sORRDEkmpUuI126NU5NUox4eR7Tqdb1bDll9Q8=;
 b=ZAW+9WVkTmMMlmQO84epYdqijl0cD2/x29aYsfRTsuzHLEn3egdJgxKePe2Zw2TQVzymFlt+tqsiWQF9rOGS65fAlmCOZDN4Vfz/WCWR6L3+wa5vXMKIAVQ1RzrD+SHghzCBjxRZUT5t9JDv4kfbhTjoNezv1A8JVMngM2m1v7Pc9RfZ1l6Lw+1T8RNXRWhrCL2zn02J53LL32v2SmRlsd3EfKMv6i3B3Vs/3nWBRtKvVS3gYhy0dbSQ2orOh9fOkBQmvB1aJXh7Lqg11v+X5iDT2G/Hc6pK2dEX8IE5lfbFqCPiKL77LE7F5V+IUeJc1mF/25wp87Hywm7+SXgEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KayQ5sORRDEkmpUuI126NU5NUox4eR7Tqdb1bDll9Q8=;
 b=i/5cIerLzlLLXttFJrpPo/71GKcL2uQ4DLf2F9XplTpFFeyDIC0xrhA09tmhBFyJX+hY7WHwbcvpGX5nIANg8c6SEzmr52y5y3Z6nwi7CFDP3rtVADWwbY9tQje4bw8HMOnl7H5I1dA+DbyvVHUNP/c7Lnf4waW2QPEK1nKrR2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 12:14:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 12:14:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 20:22:21 +0800
Subject: [PATCH v3 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-imx95-dts-v3-v3-3-765395f88b9f@nxp.com>
References: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
In-Reply-To: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714306959; l=3510;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qT4Urm2bngTFEX8AHvmqq0bSKXJ0FrCxSGzOCDPuXlI=;
 b=FboCHewJfhH6d3l86ZhTWXC6/2QM8jIdql/IXwfc6/3NkhBNc9007kBZDshPc25CQA4qck/P7
 0paHA/tjnIFAMzFjrmWrOmcZsCClU9d2DIp6P9aD4MUy6tq9sG6EJ+u
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb5a62f-15a0-4037-f5f6-08dc677cc905
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhYYk5qdXdXVVg4YkFaZHgrOEJwZXVsYXJoak8xWEFjdG9TdWwyOENXdEhL?=
 =?utf-8?B?YVRMWE1Gc3pZeDQxS0lnb1hHcHgvTHU0RnFxeHJvZklQOEt1TlkwNzFvMjRG?=
 =?utf-8?B?emxBaTNXSXptZW5HTElPMWhXTlRXT2VoRVMxODVaUkltNm5BMjFEZVNOTk5i?=
 =?utf-8?B?SVk1TWVvUjc4RDdVYThjbUZJc3dCTWp4ajByYmplaFlIdUtOTENhRXJxWDFS?=
 =?utf-8?B?ME0zNFpLY1VuZkNVRWh4Q2hEa2lkTFFYUXdKZzQvNE1aV0pGaW1xSmtJN0pl?=
 =?utf-8?B?Ry8xOHg1aWcxeTBXWEZWMHhOQTU4MkY4a2RVNExHd3pKUHBUbjFHQWtWRmF6?=
 =?utf-8?B?TGtVRE1KbW91UDZ0VHRveUYrMDdScmRNY3hWY2llREZ3YUQwaDF0T0xtRFVz?=
 =?utf-8?B?N1diM21MbHRSQlgwNzJ1b3FPUklUQjZrazErSHlUdndqTjZGM1gvZDB3WjVX?=
 =?utf-8?B?MjRjRjNOd0NEejZicFBZYWZiczc4YmhzdzZrNzcxRWU3NE9DMERtMExQKzhN?=
 =?utf-8?B?elVlbkNraURqYmxvemxXT1VsOHJnWG5tSWZYa01GR3dYbEZ4OXo3NEM4Vmkw?=
 =?utf-8?B?QjlsUmI2QVFWOWM5QjVWK3kyV0NYWWl6TXp6azkvYnlhMW9hN0hnSEp3YU5i?=
 =?utf-8?B?MTdkejgyc1RkUitzQU1xdFZvWDVLakFYb1g5R3dkempmb0lFWUZ6R1NYUlor?=
 =?utf-8?B?bnNUbVhocUg3UlFJblhqVTBVb3MvdXlYaWdZN1hTdTZmN1J4N1dRSm1KcHRh?=
 =?utf-8?B?dCtmZTE5Y0FJS0c0cVdhYlRCTXBuVUwvUExLSXl2Y2NYUm5OblBicWxVblpI?=
 =?utf-8?B?ZFhKcWNKZWZaa0NnVXhuMkYrNVZBT0VEYk5HYWpBRC9lcnloSFM4M29vY3lu?=
 =?utf-8?B?TUVrdk5uNFk2RlNUdHB4R2VsTFlUTW5PY3NvRWZqa281eDRVSGkza1BTNnVp?=
 =?utf-8?B?cFg1ZHU0UC94N2VjNWhiTWxzUE4zSHZlS0g5WVE0ME40MzBNVXNVVWdjQnNT?=
 =?utf-8?B?RWVDYmNTY3pUVm1saGNPbSs0d3gvbEkxMjdFUWhjMHYxV2puOHlET2tseDhU?=
 =?utf-8?B?bm9kekc1b2V4cCs3UlJ3VXViZkd1d0R2WEdwZ29RSmdZeHFJWWkyZGU2bHVp?=
 =?utf-8?B?aW0zQ0IyRGc1WW10ekVHOEZFT0R5aEpMcDFMOFlvRUp1N3ZzQVV0SHRtUXlN?=
 =?utf-8?B?K2Y4dHROb1VsQmhvMk5kdEVkSVpmTmRtRG9NWWUwbkowUXJ6YVpsd3Q2dHlz?=
 =?utf-8?B?VkxIOWdYeUFxUG13Mkl2Z3NPdEtTV1JndSs4c2Zwd3RSRXVlbnV5aENoY1dj?=
 =?utf-8?B?dlV6SldBTnh1YUM2TUFHbzdoK3dFRnFnWUlYVDI3c0VoRjV6ZXpLdFBhY3lv?=
 =?utf-8?B?eGh0S1pSaWR1bUpzb2R5cy9DTUt2Mkpmc3MrS1B5bnFJNy90WVJtRDhQK1Jn?=
 =?utf-8?B?aHNWa2JpSWJuOHRVdE9neUc1Yng1L00rcDQ2OC9VTmV3SkNpUUtDTk0wdTNt?=
 =?utf-8?B?S2NLV2tQL29aY2Rhek1UZzJKWlNyQXFEZmEyYSt2ajdsWUZvL1diU1RDQXZl?=
 =?utf-8?B?MXc1VEtrNUZDMHVnL2N5STNVTUw4U1J4OU00bFQ5UWEwZ21yRVVOdnd2aEFL?=
 =?utf-8?B?RTVzL0RkakllRFJUc2NOOXY4OEYvenZpYkVyMEtXSXdVYTJjSTBsZitSYTBn?=
 =?utf-8?B?ZU44QjdzT1YyNzlnWUhKUENkV09xZlU0NnlGNHlMVUhldEVnRUJhdDhhdThr?=
 =?utf-8?B?M1NmN2U4NmRTcWsvNUs2a2NsRXZnODRaTTZpa2taR2RpNWNvOHpIWHM4Rnly?=
 =?utf-8?B?Nk03TXBJTGhYbmlnRkNMUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlpkYlVpK3htVVhUMzVLdk0wNEpyeHNHVGROclJQQ2V3MlBKazIzUVVzOUY3?=
 =?utf-8?B?TUdObTlGL1hvZGdZVE1FbGtvQUhTOGoySnFXQSsrbCtjcUVTVHJ6VHRqSHRG?=
 =?utf-8?B?cGRUVW4wbklnM1RaTW16Z1lqaUVkNXVmZUdOc0NLeXMrODJkT0Y2VUpPMnls?=
 =?utf-8?B?cXBjZFYrRTJlZ0dWNzVIV1VuWDROR2xSak1ScmRZOHd0Tk80SEVvT1pkQlRL?=
 =?utf-8?B?Si9qUXVMVFZkdzBRMFFxZDJsVERxazdCYkx2Qkk0UkhhUzNHQXRXRlFBTkND?=
 =?utf-8?B?Rk5EUWhmdEpoNmV0RDRRdWU4VWdwTEJTYWg2NXFjaEZkTjk5aGxMQ08zV3B2?=
 =?utf-8?B?WCtRSUVFNFcrZTRmc2p5UVIzWTZrN0JxRzNtQ3B6UkVsbUxKdStmYVVsdlRN?=
 =?utf-8?B?ak5jS1Z2c2JrekhsYUxkcjRyaEl0blRHdXdVOFM4QkFoNlB1My9PY0V5NFN5?=
 =?utf-8?B?ZlhsdXFqY1VGdGE4S1BYeGt5Ty9FK2lLTDZCd1FydnROOGFnaDlxMmZVZzZZ?=
 =?utf-8?B?QUcvc3hUL3FnK3cwVEMxcU1uZDk3RGEzSHVtSW1Ta0l2Vm1ROFVKejkxeWY4?=
 =?utf-8?B?bHg0Zml6emg0VTdZaUhNd0UvcHRZVU1ybnpXb0tVM0lwc0hGNVA3dzA0bmtt?=
 =?utf-8?B?RUhwYlZMWWt2R1BnQU1mUkphbEpNbkN6SGQ5UndrZnNKZnB1aTM5TWc5MkNB?=
 =?utf-8?B?NGE4RVk2RVplT2lBMllUSW9QVkdnRVA3OEhVY0ozaEh5SFpPOG1iZ0YvWHhM?=
 =?utf-8?B?T2hxWlVaRll1bkRsQ1JsM1h6b0xwNWR5ZlYxV1BZTWpuamtoQVB0MU9qdlRp?=
 =?utf-8?B?K1dpbDYyK2JXZDJhWExwdzU5R1E5ODBHbVlJSkUrQ0hWNkhNWTdBUC93WndO?=
 =?utf-8?B?SGRHdWFwcXMyK05uYlRKVmNvOVFmVW9DVmQwWUhPbEpFNnZlVnFmWW1ZMWFL?=
 =?utf-8?B?cWpPcTQrbUVad2lVM3JzSTZTdUk3ejJhV1VvRStMTExaRlZxdy9sYm15Zjln?=
 =?utf-8?B?Z1FuRWFKU3ZvZUtOMklSajR5eEdxckhWWmlFT0pJaWhJZ21jMFNFaTdlaWVh?=
 =?utf-8?B?REd4b3h6UktobnFtUVVrVUNHQlRzR0d0b0lKNjNWMm0wUFhkeHVZTkNSb1Ft?=
 =?utf-8?B?ZzhkVEplYm5kbW9RTVB1Q05zTEpyWG13bmRndktWTE1HMlg4bkYxTkxaSFBC?=
 =?utf-8?B?L3cxVk9XbW9EWkxieEJjMDd1amQ3U1BDWlcrL3RvL2ZTQllNVnVPNG5YSVJ6?=
 =?utf-8?B?ZFFha3hjajExVWkrVTN4Q3pOQmpXQ00xMFR6eDA5SkkxbHFrUGZpYW1TZ0pC?=
 =?utf-8?B?ZS9DdTYwSFA2VzQvWWFiSDg1eUZnNmt2VUdES25sa2t5WEF2RzI4ZkdiMDdC?=
 =?utf-8?B?V2x4TXk4SEZWSjE1NkpROXN6NUl2RmRlWFhKdFduYktGdjFIQmd5dTFNRmYw?=
 =?utf-8?B?Wlh4SHVTNU45WGtKRGxuanZwbWtYS1VMV2lLMElaZWtUZjhJTU5pcEdock1n?=
 =?utf-8?B?WE5PcU9rWStxSjVCMncrWVJIblpUajAyaTJnV1hTMUczeXFRNm11dVB0SFNq?=
 =?utf-8?B?QWdRQmtBMXFMU0Z3MmNmc0ZtNjN0ZElOSG94dlNiM014NTdsQ1BydjVwRzBD?=
 =?utf-8?B?OS85ek5wOVpsREttdnBkczQ5TVhtcjUxYk9PN1B6UVdEV1FDaGtVQlJsb09U?=
 =?utf-8?B?QUxOZ3ZPeVYvQmJTQU56SUhXTVZNbFVMYXBwWVlkbWtGQW01WjVEb2ZTY0th?=
 =?utf-8?B?VHY5Q1dtVTk4SXAyR3RsNVcvejhwSFFiYW5xcUQ3VzZTUDBUMVNVS1dvUHU3?=
 =?utf-8?B?L3BQeDJrWEwvYXVROFJWVy95Lzc4U25iV3o4ZnFGc2VTR0dTQ2dlWmpLNzF2?=
 =?utf-8?B?YWoyZm1ZaXRpVlh5ZEltWHJpZEl4UUNHK0ZUUGxCSkp3SFFxNTliVEpEOHFG?=
 =?utf-8?B?YXk2NDl6TTkyYjVwdkZaVXBpdElkK2NQVlRVeDVNWVByUFh1L3BjNFZXcEtv?=
 =?utf-8?B?TWRrZUFDRFVwdnBoUDVsTURDaDdNM2EvK0lxcUU0bVBsRFRieWhuV3R0MklN?=
 =?utf-8?B?N0REcloyOVo0SHpsemorb2tKZGJSMW8vc2JiMWx2MUxMTU14WFNGNm5aR1Ry?=
 =?utf-8?Q?kTNKypGMde/+C5vn3XwhpumbO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb5a62f-15a0-4037-f5f6-08dc677cc905
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 12:14:42.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAzHmdxgkbPaw1Qxf2cpiQ2JfzICBR7JcOIbYDHX5mKYfv0SiiHlDiod2RcVYBiDqSdnWFXr521u8ebtVJhywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

As of now, because scmi pinctrl support not ready, so count on
bootloader to set the pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 111 ++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..057e23fde780 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..4ca63ea1e787
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};

-- 
2.37.1


