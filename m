Return-Path: <linux-kernel+bounces-168461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151808BB8DC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF3C1C22B87
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4717FE;
	Sat,  4 May 2024 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="beP4RVJX"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D0DDBD;
	Sat,  4 May 2024 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714783278; cv=fail; b=WWOTUpCwStVvNEQND0P6xeMvO4r6U8XQzyAPOA7AOMvjx6/BnF1/Q9EhRaAB/fNhs772xLRym+JtJod79gWq5wA/KGB4lArFSK77Zi4UbZMdM80OBVAYSjGAgB//asPksPNoIT5tuZvCuJtLw4VAddourhgvSKGgbi8vfpO8JvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714783278; c=relaxed/simple;
	bh=6bfV1dS4W03vysGWKUi5DvTJJb/JmkVcqlEWc5z/JWg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MUJAB5ph6BTbF8ZYWFdwI6/QfW5rcQbLfokn/MyAgk0jOgkLY+SeIMCPQZbaOoYYnQj8tdMmkyeJ2iC857iGF4QnTFWg0xF4bVi9gma1uW6sVErKGiS0mVwPmWqN4FMnzlA4zRzWmLSd7Nj2PSv06aQ9uSXtQnJmV5YynRL0Q/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=beP4RVJX; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5qCufNfSAiYu0lHWeji7Zkyc1bhWYsxOUQ5pPMGHQwnFJdaunKLhhBYiVrUXUw3yxqfsUQiS68LXGXQ9qnSphdfXpsj+8h+w/8IooqNL2lqYMJBvbvihTaVM+51NJ/4li3iFNNM67mZswQSH5Las9fNw19u1musmWHM2xUFXz9eaepxcnrzYD2aIdXmSHVDgP3YwIA7hCFHWhOd0dvjmi1YKLnmRkn2t/2eCLIwB97k3cVwfe9MyS1VtVC6g147ylOehZO0iWlAcXuQXPxwtNbmNyB4kAdg16MQ+3O9zMjXcUQoe/ET1v8kizWVe9gtzhJqJaovxxqmrERT0GQhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGMI2AiGxzw3PtYdGfhqBPcJZuR1jYmB5HiZD5n8n9U=;
 b=E2ZfAVfjtrTq57DbWsgcsxAeDV6xx6RDmu3Od2CPEItisyuxlaJtWrr0MIgB8xWDPtB1rNx7vx7l2vznD7/ZFAr4/eaLMVnRcvhlQEXwct63UdiJeSHxWXCwCtOpLytxkpdaNxRorIuDQkNPbXN1+GLwBX8+Dk7j649fybdnLQQ7kqEsw6LxPkucyRX6QFgOqK+TPIDzs0mxpRSke3Nu56CaEWJm0HeK7JiRZVetIFKjHzw6h4ByxE2rxiPZDn2kvd3S5TVZcuZinIsYzv1CWnoPUumy0XAWCLWQpCJ5e3RU7xCBEqoW+LBVQjonuW1K2MSg0PspprXIAl+gS9CFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGMI2AiGxzw3PtYdGfhqBPcJZuR1jYmB5HiZD5n8n9U=;
 b=beP4RVJXKfA0VyKIo9b5Fxhx+pYU039zLwUQQtw3nDTRCqJsx+VSMbFNNPLhRGUL+6wO2h4cT46jqpsc4bP8xTEpEVoqWPxX/hHkAtQz1RhR3WY2nz5xCu7TGUPEXMjMbYy++aAbAnHAhJuj9a47skkF9watz3UtOWe7GMNzruQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7726.eurprd04.prod.outlook.com (2603:10a6:102:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 00:41:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 00:41:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 08:48:55 +0800
Subject: [PATCH 02/18] clk: imx: composite-93: keep root clock on when
 mcore enabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240504-imx-clk-v1-2-f7915489d58d@nxp.com>
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
 Chancel Liu <chancel.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714783747; l=2275;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nzd37ej6sCrJO2CX0AUOVMMELufbZrxk0WgiSw0tXHw=;
 b=ZpZQ4CTt9Q0v3CidAfPTOx0iAPeCEzp5sE1+Hz3Vbmoc4EdTbB04/h89bvHDFglwc2HIEwfYY
 cQiiBpsCKYKBEuMj2WkFEaqyBvuyFqV9EGT8SVQBO6XbVChNLFKuv7A
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
X-MS-Office365-Filtering-Correlation-Id: f7580939-a12b-43fc-4ad0-08dc6bd2e663
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|366007|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekxueEoyZHoyK0tQdnN5V1Nvb2R6MUVFaExqcE1NMWw1RTlWNXYvcWs4b3k2?=
 =?utf-8?B?OVVOYkNzOEw3OFhtM0xmTHB1OFBtS1RjYm1wV2xiTllDMnVyRHd4SFhCOEJZ?=
 =?utf-8?B?dEdDWEd6YnNHZ1UxUnJxTkN1QStUcW9CQlJvVWpiWHRHbnN2bFhaQndFWEVl?=
 =?utf-8?B?Mk1xODlwNUNBQVA2VDVjMThTaGpOeGF2Q1Z0MWFuQ3pkWnlGNVVYejZiUEV1?=
 =?utf-8?B?Y3ZHMWMvcnpONHZkdmdTNWMvM0dHT2RqLzJRUG9IT2xhUS9ZN0x3dXIvZGtV?=
 =?utf-8?B?TER4TTRKMVh6Q3JCQzBwL055SmdLYys1SnpOOTMwUkpZcGU5MEhHV2tvSStr?=
 =?utf-8?B?amlEM3dGd0paK2FSQmZ6KzRsKzh3N3JEN1VMd1lwOS9uZkRCQ1lBN1Yra3Rt?=
 =?utf-8?B?NHhvU1JqUjJ0YkUxT1Z1b25HSEg3djRiRWNZdS9Sc0k1Umoxb29iSjRoeHJG?=
 =?utf-8?B?aUIrMWpBZFNIZDFEN0FxeGJ5OElhdEwxd2V2ZG41U1hNaCt2dzZKOGlXYmZ1?=
 =?utf-8?B?b1Ira29vZ2RoQzc0ck8xWjl3YkdXSmRHSUZKZ2pXdHZjNXVqSEIzSzMwVGNZ?=
 =?utf-8?B?anp0REFCeDlZZ1pUYnJXMUZ1eS9MdVhDbG4zdTBWbGRkZ1lkSHBvUlBSRWFn?=
 =?utf-8?B?MzlNOFBtZFZUc2hTYU1vcXNOMmxteHRuOERCWGNVUjdGZzdZemtQOUd1RXBU?=
 =?utf-8?B?VnllZHhLbS9zRDNXekt1QXM2NDRnL3JRMytVdEJZc24wdlhNN3hBelMrTEw0?=
 =?utf-8?B?M3hXQUlTUnhzelAybEZsa0NUY1M2NkxxNVZQcHdXOWJiWS82c01TREFmRVpO?=
 =?utf-8?B?WmtVYU1DaFYwLzJ2THUxVXh1ZkFMMmMza3pVbzFHU25GbFNMSSs2blhMZWFs?=
 =?utf-8?B?K3dMY09LQlo4WXlPMXFJUTRudXlCbkd3amx0S2hMdVZUb3FJZ2VuWFdOOGZp?=
 =?utf-8?B?QWlXYlJyWkNETlpnZHdzNGtNMmh3eWJRNUl4QXoyTTZ2QStlUFhIWkRxcy9z?=
 =?utf-8?B?TWlsY3Nob2RkTGxpZW1EcTZlYWlHbXRQdk15dzNYRDhWdG15U3l2WXE0TGZk?=
 =?utf-8?B?QmpHNWNQZ2U4YzBrZ1Z0bHN5OWUyMWdxNGRpUTVOWjAydURXK2M1MjNtLzdl?=
 =?utf-8?B?a1ZHQ1RCZ1JNSVptZGtSU0NKZmtTMHVHajBySGdobEpPWXZTQjg4akFnMXhw?=
 =?utf-8?B?NVFXUmZ0ZElTZ0p5TjBaREd6NVBXNjZtVis2TWJyVjg3NnI3Wm9QZEhZNEh6?=
 =?utf-8?B?UTkxRDgwSDBLRU44VzVNVkVoQmRrc3REZ0pPOFI5M0FaZ0c1K0JLc1RKbmtl?=
 =?utf-8?B?QW5KUG1QeURUM1VGQVJ1QStQcGFmaURwSzYxS09tMmU3UWNJNkVSY3NQWkZh?=
 =?utf-8?B?M3h3WXhNN3krZmZKV0xZc0JNTlFudVNkNkN3QUkvVWI2MnhxQWd2YmR1QTY5?=
 =?utf-8?B?VTNjZkNrb09NemZxb2kxWUxDTEVpYkNlRGFTc3dUNHAwN2JxalBud1BYV3h1?=
 =?utf-8?B?WnZ6RDBiYkpjQ3VIbEo2VHFjQlB5U1BTYTczTzlYS3V0WHpqM2Z1TytvVXJ4?=
 =?utf-8?B?U3NZQ3B5M3pvS3Jub1JvSlE1aTZpRUZISE83UGRjOXBYNWFYcEZOREFsOFIw?=
 =?utf-8?B?ZnByOWlaTVo1ZzRWSkRLNTFUR0pyWUliTmNrMng3N20yRXh3b245Y29vNU9W?=
 =?utf-8?B?RExOTGJaa200cVJ4K3pHdWFHdXQ2K2ZtNERIM1BMVHJLN0JBWW82Rzc2Y0ZH?=
 =?utf-8?B?VXRET0RjdTQ4R0g5eUdFZ2o1Uk9aL3pNWkhMT1c5VTFybkJIdWdHNEM4OU1X?=
 =?utf-8?Q?0SxE8gZTaLMYrZxy3DZg/3ayoCcbOFeBpubz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xXb3BSd1U1MlVPTE1sVzBSOEw3dG9yYXZHdU5qWHNKRFpONWgzelMzaGdR?=
 =?utf-8?B?QjdLSGhNbzROSlR0NUFHQ0VkZmRMQjY1QTBKbFV2bmRVcHcwb3hwdS82Qzht?=
 =?utf-8?B?S0t1K3B4bmFPUHY1RmVyZkNxcDRnejg3L2VqZlZzOENyS1N6K0pIZlFxcjNj?=
 =?utf-8?B?blpGZ1NMNnNlUnVWeWFWUm5LS0c0WXI2V05jZHo0Nk9uWU5UTEJiR3IrQXVt?=
 =?utf-8?B?N3JSUXkzTzR4aW12TTgweGZOUTQ4VjVuMTlGV3Uzd0M5R0tBajJRWHo4aG9C?=
 =?utf-8?B?VDlPcXpuUnpnZTJpOFN5SGw5bDRtL005OWkzVkN5TmVQMUhqdUd0VXpFUm9Z?=
 =?utf-8?B?TDFWT0VjTkZOVGtVOENHalM4Q2hIUUx6SmN4Z1hBeW5xZWZnbkZiOFB2czJ3?=
 =?utf-8?B?aGVzTmZzSTJ3L2NGb0NNTXd5K1V3OGt0N2d0MGVaS3lFY2ZsQzJRZ3IyQUEx?=
 =?utf-8?B?R296Mm9TMGNJZXRFSi9xVTBSUjV3Z2s3VnA3TXBNVzBxR3NJMHRTQ0xjTUlP?=
 =?utf-8?B?YjFjSXBXZ0xzZXJEUUQ4WXgxQW5TUGhsQ3dZTnE4aGNxb05HOUhqTVpUSzZL?=
 =?utf-8?B?MTRhRnFPK1gzcDYzM2VRZkxQSi82TUYraUx3SEJOcFRicjA1SXpKQ3EwbHd2?=
 =?utf-8?B?cElIOWxEalpVMzhxTEMyMTI1aDJURHhqeTVyLzBOZmQ2SkVXd09sWDJtMXpJ?=
 =?utf-8?B?NFIzQ09jQW5tUGRQUXFqaDk0TExYZHo2SnNBYWNmV3VQa001cDBoazM1VUpJ?=
 =?utf-8?B?eVRaVUJOaHFVVTh2TjFmck56aGUxR0FISWl4MDRpdE1WN3BjYk9oQ2wyb2Y3?=
 =?utf-8?B?ZDVIYTZaNkoxd251elVXWmtGVzd2SWF4VnVkK280MnJROTBka0pmRUNUMnZh?=
 =?utf-8?B?ZUxzbEZza1dlTzM1dmI4LzZYSU1HVWMzQnZjbTF2R2g0UThIYUJzbGZUR3Jp?=
 =?utf-8?B?YjZmVmRvVXdDVFloRzRQT3MzWmRjOTV2b0YwTHVUZjNBL3Jub3FoZi9ZT0lV?=
 =?utf-8?B?SUFIZlVTSUNFNzZoRnZTS0lwNGxhcS8zbmUrVS9RaTl3M0dEaDU1T0FPT09X?=
 =?utf-8?B?WDBtMDJ6TGJubVlRVVdMSmQrTWlrNmJMWDRSWDlodXpSck0zU1NqR04yVTlt?=
 =?utf-8?B?Qi9zeXVXdC9rNXlMWkN4WVRJSlhBVk1tSVloTTVOOThFdDJQYVdubjVmWktw?=
 =?utf-8?B?cml4dzVac1RodGNPTUdyRXdISmt1b002aXVGL2FOcDRyZ3RYbGlXd2F4UUpD?=
 =?utf-8?B?VHZhMVRRdHFOLzFBbWNKWE8zTkVJbkZQU0ZtVkhOc0hZRzFCeGJ5TE4rd2dn?=
 =?utf-8?B?bm8yemtZMjdLTDJWeFpOMXdBaWVSVnU5akJYVHpvVnRTN2ZsaTNaeW5MZFgv?=
 =?utf-8?B?RHJNdEt3SnZPVzVqYi95WlJ1dEl3NHFGRlBJUkFkQVFrSXZaWnNrVEZTWUsw?=
 =?utf-8?B?cGRVMjNpK2I5L3J0WEI5WEplWjVEQlo0K2tteG4xd3VoelpKUDRtSXhrM3Y0?=
 =?utf-8?B?Skd0V0ZwVFZ2L3ZDWFZaR1BlY3R5dzB1QlNyNEt2VWhRMmhRVE1hYlFEcjVB?=
 =?utf-8?B?Wm5WVk5QS1hjSE1kdHRCWDlFU2ZDeU9aRk14NUFQdjhXTkNWL2JlcGlpamJz?=
 =?utf-8?B?K28rZS9nTG5Xb1pMQlowcUlDcjRrSGtMcEtFQWVWQnVMYndpTXA1R0tlck9V?=
 =?utf-8?B?OFdFdnJIMVkxMGYwbHlJKzJLajArNGEveWFxZ093NVZJd0tMb2ZLdnNjRlJk?=
 =?utf-8?B?NkJwN2VkUEVXYkpsajQvYXdwREVnUDlvOVd3aU0ydlpIQmlpRlJXZDVvczQ2?=
 =?utf-8?B?ZlhDdm42TXlqejF0Z0xBeFdOdFpjcHQyaTZTdjVPaEtLSnFLZDN2STVMdllZ?=
 =?utf-8?B?bHJ3Ky95S1YvcmhtTytYVWM1QlRsWTFkNTdMY1VEVDlLWjNtSVlGS1pOKzk1?=
 =?utf-8?B?dno3Kzc5eWxDclZrdlZmZUMzOE4rS2I1UVJwbHNJY1gwSU5KOGdOaGcvRnUw?=
 =?utf-8?B?Q0JZUDAzQ1BHZnl2bWR1UU9NUDUxMDNrS2RSZm5NeGJwcEI1bXR0Q0xtUTRi?=
 =?utf-8?B?WVFrbWtXdmpwL0VhQmVrTnAyd05rdFYxajZjWjBndmwyVTRNU2VxdGU0Q29T?=
 =?utf-8?Q?rBJcFBjf7fsYOlE2IfO+z6AUx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7580939-a12b-43fc-4ad0-08dc6bd2e663
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 00:41:13.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K97XeFzAbgl18NZ6cn6eE1ibx4dlaLn3rfIKMM9//ajxpzvjYsyFoNXdhLvlkfdExgO1kXZAllDVAWuNd4M9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7726

From: Jacky Bai <ping.bai@nxp.com>

Previously we assumed that the root clock slice is enabled
by default when kernel boot up. But the bootloader may disable
the clocks before jump into kernel. The gate ops should be registered
rather than NULL to make sure the disabled clock can be enabled
when kernel boot up.  Refine the code to skip disable the clock
if mcore booted.

Fixes: a740d7350ff7 ("clk: imx: imx93: add mcore_booted module paratemter")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-93.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 81164bdcd6cc..6c6c5a30f328 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -76,6 +76,13 @@ static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
 
 static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
 {
+	/*
+	 * Skip disable the root clock gate if mcore enabled.
+	 * The root clock may be used by the mcore.
+	 */
+	if (mcore_booted)
+		return;
+
 	imx93_clk_composite_gate_endisable(hw, 0);
 }
 
@@ -222,7 +229,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else if (!mcore_booted) {
+	} else {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,12 +245,6 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
-	} else {
-		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
-					       &imx93_clk_composite_divider_ops, NULL,
-					       &imx93_clk_composite_gate_ops,
-					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))

-- 
2.37.1


