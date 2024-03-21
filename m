Return-Path: <linux-kernel+bounces-110704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA708862B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637CA1F22A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DA13667F;
	Thu, 21 Mar 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lMO2daTv"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2098.outbound.protection.outlook.com [40.107.7.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D5136664;
	Thu, 21 Mar 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057649; cv=fail; b=hYkcJjh04szKzlpSBfv7FLOSAWHMNST105KZKNYG7E3gt01QLZibN7HpLFp9CC5uCv+dlWD7sJO9H9YGF4HWJLDaIEjIkfcd/RxXqsnhdfq73RAete+JUswufx159NkVd6oONNbKuOtfyp8Ht2DDXCDISG7WVBHNZdDLazJQWJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057649; c=relaxed/simple;
	bh=mda7g5pHtfOO0rbLFtiKO4fjWPTLR3R4wEL2TOMRefo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K3cxw9sKrae2MGZ+ymZUBr0/EjZLU68yD29g7rT0GM/i2JLGvulC6UHorq4foxXJV8rJ1JDO1JwhujdmaEfs9wsb6kKBPoR6nPZCEhbd8xgFQKcUVXPIyWE1+iLpLLgJ4TxVRgQiyp4SIpaYVKx2ge0wDk5V7p66mzA2mLhm1JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lMO2daTv; arc=fail smtp.client-ip=40.107.7.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8JcTXeXBkCwRINt8gdNTKtxZpJDUyu11bd027HxHhBssDlQ/rtEgR2VDWINItKMRGr+zeXDqQ4U5YTOBb9Or/BBDB9OU85BuFGU4uKxYdfj4GJuUs5EDxozJbNfNfRLONzaoC6WfICdD/hDRpwQuQH+dwL2cgR5lbvgWR90fTN6Wyxk8batmR9SIxGf74rkm9RL25LK5yrlWK+7fK5YfkzZVxDzaVup0L8JJKrY5qmT8uktLa3CHVw/rVDjnb7x0ePjB5NVD9DjfGfNNGzzwr+D4v6ljfvb34upXq56+xDbJ9QTkfCxoG/zsBn9Itrf6ETYKZJ9xhIKyvOGD4EV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEt4gxlPjpub5Ndo9VZ+tz5IbDf3ZqXjsUfCrjVBraQ=;
 b=EZM+juPsigIJC/dBVcn1KLIY49AM95dIgINWA3QHxSzyBdKb4mfJ1ET01RyMQtNqYDcjTBUMR4nIDVfpVdGgp6UPlqDb9k/POD1bNOJd7MFaSFbk/XWbWiQAVBSKRVYKbUBTxPSj9YooXWNvwSKbL/F5ib/zknvsBTOXiqOsAmb2ruObhfUjuUdArDrM50Mlynrm7Z+OWgB6kWbf2KHk+1Jj+BZXtUkge30ADkeyn0gH7EyETL/VY7wNi5or2F+m/v1AAGpmveu/RfJQMgdwPtAVgV4BhrRkO5vsVWehtdnjHumwbhqpQ27Vmhpgx0vKkYRB3itGyRJJ/qp/BQ5epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEt4gxlPjpub5Ndo9VZ+tz5IbDf3ZqXjsUfCrjVBraQ=;
 b=lMO2daTvaVuthHIt1oqgk7lea7kXiF0aAFKy3ScOoqQgd8VmzirD2sboLGpbq04t/xGK/FeqFNMGPt7bs+4QNwgxH+Aykrr5UN3xZUf8goiDHIDqSQ89ikE/ydAI9X8GKxggSW3NU0EPSqg5yy1zZzsepFzcBy69Z2qZSEr8RLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 21 Mar
 2024 21:47:20 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 21:47:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 21 Mar 2024 22:47:11 +0100
Subject: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
In-Reply-To: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: f089505c-f12e-4f62-11cc-08dc49f07bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	keBpmPsrm3iFsUVcgEpps23LxGHQR+Be8uAzF3vpZLGXnm+/b53hgTMiAu52DDJ7jVr2eQCretCEV45R66gzAFfzNnbgn5GGqN98N7G76ZPvgTsz0hyGH5PKazzARW+LcsU47gnwxd4iZmIpZZt+YZ5XpZVNrX5wIZTEH0oth3JcXLP3QTurc7KpHBdT9bhRvR90N/BFoFA5Hvi4ayA9yq6ZJiDKKqoFunNh31+aZJhU/7/pA8ZvNbl39QanShGgxGO/ExdyKiMj8ECOGWCsaOnW1efiIQE/IqklG3iBdqtoo3rC6w/kMAQpcBrVvf+ZBUAhSmM+rJPqGMmjgEqic7/j3osZDblbnuHsSxBzqc5QkXdAp5HjclXzq+4iMp8FarnSgVxbKUxsdcIfWs7/tdOM5YtcqSDNAFksi/CdbBwnryU8/6T2NzHMKlhLGF1BIMbQ4JCW37eVY5JuRuwYP7jjjS4ceQtLAXcfXPH0X1/Y8LmXMzXdHq1CgfnTRsAyxWxQl/jG8JAUGsMVqFSd4CZqDskrB142wM/60ZwJrYcrjsHIpDabJM1o39/DIwqV3CX1c0J41ianlFBdJ/5XIRdj8WYZe4hiinFN4htQd87e3SzXKIaGgRfxzsDDUCRTsuly+hDs++pte20Me6FDvoAHpdQ2KOV2QjbLvLRkLBOXjXRX6HHHuaq/g3uL3CMau444mTLVHL0nZHs73qNfjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXVjbmwwNWVFbTcxMC96WG1LUE5UZklUQ0UyVFd0cy9KOXJicGdyZkJCZ2xz?=
 =?utf-8?B?RGlBb0VFUkpRdU5VRHZySnl4NEpqMFpTZDJiZ2ZsamVxbURxNk9GeVA5d0RG?=
 =?utf-8?B?cEw2WC9mZWpJdnRQVEVuSDl1N3hpZEtaT0dZU0JGU1lZVUZZRWMxckh2WWFq?=
 =?utf-8?B?WFd2K0l5NkVONFh4VkJveUtPZ1k2ZDdFOVZ5SExaWVdOaFZrSWxIb2cyYW5T?=
 =?utf-8?B?UU4ySndKUlhWN095ck8wYms4eC9EcERWblMwR25BS2ltUHorSTdVZ3pwMnJM?=
 =?utf-8?B?TXp5NGdiUGNMV2VnbnF4N2dNT3V1dG5EWEk5UkQ1ZjNRRjFvam42ckJuaHZ1?=
 =?utf-8?B?YXRNeUF4ZXptWU1NMkd6T1c1a0J3bm93R1I2elk5K044emxXZnlST2tqRmQ4?=
 =?utf-8?B?VXZxTU1UNXJLM1RaZjFkbHJFblIrNXpCRlRQcFNqVFBwYmRDSGRyaDE1Rnhp?=
 =?utf-8?B?OHZSSXRWbXVaTU9ndm5PU3NpRW5lZjNSWnE2V3Raa2ovOWtIN2c3UGtHSjVI?=
 =?utf-8?B?NGhGeTRnY0JtbE45YWQvQ0V2MkZwbDA0dkhHRDJXVkRUZmc3UUdpWWZoRm5t?=
 =?utf-8?B?UFJBZGk3cjVudGxUVWJqRVBFNWx2VjNtQVVPZkx2VGozeGRrMEd6QXRsM2V4?=
 =?utf-8?B?a1BUbWluOXpHc3NTZ0NjNHdHSmFkMVVhQ3RsZG40bE5DR29XMVVWQTVwVTJB?=
 =?utf-8?B?TEdXVjlxMFVRWWd5aFd3UXV0aE5GSlNLTHFqQmI2dkI3ZUFrSFRDTERLZVRa?=
 =?utf-8?B?NlNKUnRwNkl5SmdJZlE2cFBZTC92eGQwVzFCRzk2TUN6ZHd5K2kzWlpLOU8x?=
 =?utf-8?B?SzdKV1pMbmtnckVYZHlsNFNCaElON2xWMUZianI4cmx3ZjBIYisyWWZjYlBl?=
 =?utf-8?B?dGZxU09VaGc5Z2UxcHlyWUZIMmVGVFdjWDczT25IVHMyUk1hOVdMMVo2eWpG?=
 =?utf-8?B?cXVkZjhGL3F6OS91L1ZhRllDd011cXhQdDlXdkR4SjR6STB4S2IrMWVRZ1ZX?=
 =?utf-8?B?NGpsVll5U0l1cXhQbzZvMTd6NTF0bWZBL0ZxeURXMmF0RVN3blNySnZUeGNF?=
 =?utf-8?B?NFBlTTIrWFhrdi9SQldRb2lEYno1RlFBdGs0b3VqRE9nTEFjRnd3ejQ4Ny85?=
 =?utf-8?B?MlREbnl5cEVhczJlb2F1emJhTFQycDZSc2Q3aW82K04wNk5va2ltZ2JLa1ov?=
 =?utf-8?B?OGNFN1BMdVdNbHJmWURlN0taYUdTcjBQdENRekpCeXE0cjV3TWF1NHpRRFlT?=
 =?utf-8?B?ajRzdDJ2YUQyQVBCQSs5SE1DUWNiMTk0amVXc0tWMTNsSjhQZjFIS0pYdFBK?=
 =?utf-8?B?djhtQmg3Mm9PQmRqcDlLaHlRVlZXblUvQ2o0NTdVYlNRc2hWZmdUOWFVTFll?=
 =?utf-8?B?ajZJQi93SHNLc1lmdWVvTER0K1VMY1llZ2p3VkFxNU5lcGlINkxoelJYdmYr?=
 =?utf-8?B?SnplWEFzY2NraU0ydHJDSDd1Q3RPSXIzUGEwWVArczdhWlRxaXUzNVBpN1Ax?=
 =?utf-8?B?d3RXakJoK2hHWEhvOWRMYWZxOFd2OXUwczhJNDZ0U1cyNkQrNmVLSjh5L1pU?=
 =?utf-8?B?LzFuazlEYk4zVkFRWXVCSUI4L0xMYjgrdmlvUEwzTFIyZ0xTUDhMWVEyYnF0?=
 =?utf-8?B?c2srQWN1eVFLVmsrZTM2aFdXa1JlZisyc1lXakZucFpTaTQraVhaY3Ixc1hW?=
 =?utf-8?B?TFpYcDUrM2xlb0J4MXViYjJsZVlsOFBjcFhLSnY2ekhJUy9zdW1NWm9wdFBy?=
 =?utf-8?B?SWVFOUlmeWhKenpwSlBUQXBkWiswVCtsOWYwSHZabHFvZ1h5UDMzTlRsM3Ix?=
 =?utf-8?B?a3FzYnFXTUZkSWpVMEE4MVViQVBQL3h2cmw1TTdjMDg3dDdVdWNXUGN3VTJN?=
 =?utf-8?B?QTFpaVZMZzdGNzFrYTZUbnNPT2hyd2NrTHdTNW5tYlIzc1hCc1orWXArS2hp?=
 =?utf-8?B?eWVHZnhVSVloUmI0RlNkZmR4N3k4dlJlZ0RNdjhHblFrWFQ0Ym9XV1JkVUZY?=
 =?utf-8?B?bXlrakpvRlJ5VzRjSnFsWDQzS0pUNlU2bnNTMjYrbmhiWDBFZzRkQW5lbnN5?=
 =?utf-8?B?WWRLM3JpN09YeGxmQTh6NkZscjl4Rno3RFBnWFI0c2ZwUXZCTTQwN0xVTVY3?=
 =?utf-8?Q?SDxrlHM7TG/oXCc8RK7+QQn9u?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f089505c-f12e-4f62-11cc-08dc49f07bf2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 21:47:20.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG/7wb5CCnBWtjeL3R1sFL+flpv1E+hQ4Dijh3gRU8FkD7rG1BPyFBi7UU4ua107Ew0XgQVY0ZOvr7UyvrGyIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Add bindings for SolidRun Clearfog boards, using a new SoM based on
CN9130 SoC.
The carrier boards are identical to the older Armada 388 based Clearfog
boards. For consistency the carrier part of compatible strings are
copied, including the established "-a1" suffix.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..36bdfd1bedd9 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,16 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 clearfog family single-board computers
+        items:
+          - enum:
+              - solidrun,clearfog-base-a1
+              - solidrun,clearfog-pro-a1
+          - const: solidrun,clearfog-a1
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+          - const: marvell,armada-ap807-quad
+          - const: marvell,armada-ap807
+
 additionalProperties: true

-- 
2.35.3


