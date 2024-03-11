Return-Path: <linux-kernel+bounces-98756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E2877EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01EF1C2149A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD583A268;
	Mon, 11 Mar 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QfQy2p8H"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E43BB47;
	Mon, 11 Mar 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156261; cv=fail; b=Gfdas7jPsg5eIn1SihmEAxnIRcRjqACOAN1C119s4qdKA1LtKHG9ue++ZRkkK1/adY7SIKzBtXFauODo76DRdBEE1EXvOulFQ0E3pJ7xB4wpFc40lDt2pszIigNwfCQ3Y8j7uYZ4YENjjcODyK4VP0G38glf5412qvcinqO2i6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156261; c=relaxed/simple;
	bh=Pqw6txsZ2rC3PcvL8JI9YJXr6Ow/ZJRt15XGgfedm08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4MnYvNANzn+PgrSo29A6qGIVfsaYu+944x6ml3o/Irv8nR9pGfj2365qoxXzGuZQPbBzoWN2D5jHAS8/4vyGYl6ACISsQMNlWmaEw8b+aNfO0Z6+qakAGApj14hNPNPNGiXvDvFAP/bWs9Wi0BhRRma/J8pbxQiIGN286J48+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QfQy2p8H; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP716wmr1nyEBIBUCZYbaNZkLvLVv0d34d+Lh4aJByXfhEiXn3QoIGp8WGk8pqs9dbRC/RKQX29mXUAR6nV6KW3HFYeDJkW7YFffv/5z87cjsrUKOT81ojySgWB4lbeU7prj9/RuYwEz9R0azY5RlK+KblpPqMsvkxSE9TCYc6yQcnTzCVj/Bxx9T62fBftkHEPcNTtp9oGGRtOeLG8inxT6SST6FWgjSZBzS29p0jS73QvlVl4zSvjH1+gXLrDpDk1rbppeAu2dlyNdLq/CScX+WL7TdmTpzR3eGLMT3YYGgTwXP8mAHVwXFLWBsF5DlEUvu+ZULZeYlITgtHcbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=dgaVG5KVuxep58Dl4Scxd/lJhWC1GuHmTvsAuW/Bm6gbZndXF1/X5egDQ4LuoW0VLJaebkgIowEt38DMmPs0w11XPBTci1NZKoERLEeSGEsCAZQ6vCg5IUaaLwHWIlJpO2mRYrIwK+87ZGHFkstYKS1aYJvBznYWQYcFkzsQVstNiNMAIa0C6eLb5BTspp4tqCyFc1afGIWqZTCGiy302B9Zb3VXSEHdMoVe8tf+BUeOUIdwLdiGg6GPCxgSEb4OpD+KKetgaZY/s97Gh1DGkRqIGBK44RzAHsK/SQJFbseDG3aQtJIJkl8/0tF4o8OdoD9SMIGExbdK8eZvJYImBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXa2yjlS4oIF90OZ1WhVXXURTSQfG8y5lbaLGgqfVcM=;
 b=QfQy2p8HZm7Y/KFuV0XTu8c5cBdDnzKohhVNE8p77MXFSteid5bhRSKkOVCnBy88NbXJ2QgYL7pxK0QAfRGLHbtBJ+ooCCG8tWlk92DP9crs7pJKMRr1sVN2YzlqVP8mIH834eIMzqazzwLJ2AijB6fMQMkeFxxab32HQKaSII0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:24:16 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 11:24:16 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 1/3] regulator: dt-bindings: pca9450: add pca9451a support
Date: Mon, 11 Mar 2024 19:31:59 +0800
Message-Id: <20240311113201.664252-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311113201.664252-1-joy.zou@nxp.com>
References: <20240311113201.664252-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adc8f49-764a-4d6e-a022-08dc41bdc903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8vHrWmIljL1KL76JjomVrwNwKhnxTbzJ/aRBZwqb9UILCCsiArwxlxgMPa1hcor4RWc+QF3K6F88Kkka2aND/fjBfoFdJojmdOrGW6AGBQTPPgWgqlk2Tm4Hkz4t16jcg1yOZgYjEeKbO5YwsuYVH2nsgijFzdfq9sT3VZn8qjW4WIIQFGQi9KQxu6bz5r0cdtdkegCrMa7Q5XqYj6M0Qp13MY/XxkDDV85af81CqeJXaip27sRptgCrp7NseOTDreNFugTtkGW6hw5Yy5VwlRRS1S76hTcjLwd7STDPnBCp03/xVc0WjzJumSqRhK7n8ganhL0Dv9DnsNpGTKIOxiV8rcKGA3pj4NNOrt482rxUN0u79NuBwLKsfFRNhLgAaCwyKbjzB6kg1zrF04z7TfZvPJcCovyKUUhRT6q3DDyWYzGN9Xz+Fyqo7HC3b4LOM1NcMKk3v/HJaYrIS9KIp6Pd7BEn19R90ynYyJ6tbHNn6DzIQEc/j3vmHlwRzxwDrtQ4vOrXiBJJAWSIyTMdlroudA/zUK+F8oBv+PtuZCAk0htziPKMymOoqjBIDTKpANMKwFbzTGXD9v0Pc5oTlznzhqR8zbJsSrIe4+CHJ9FhKWi2Stj2xvwvYIyv5aIVTOCOx9AHp+e+5IE0/Fk3qxU7enpOcxq61JZwBLemmdJSIzIyfLHU3Dw80TiGqydl+KcyHhxbYMN+m809oroVmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kN9zrGB741VfGkHkcCsfteS7GlwYXDRb6kLJjc2opuvDfzZZrWrX8Hmq8Di?=
 =?us-ascii?Q?DFt2KT9HeOQB97X5zru1na2OgBP2B0HoKlE49S0oTg7mq3aB8bg6rH6pd+p1?=
 =?us-ascii?Q?IxcyXfg6WAfz9TZgvXEBQzezJE9Wpcv8KPw2ElrPQ7/IR+KGD/rrHWQcoA7C?=
 =?us-ascii?Q?jrM1PwP/o6Va5hD/JETeLV+RUpXFjcm4jZeIp3/9bAYm5BsTbVI+Cak6kv/Q?=
 =?us-ascii?Q?J5nLNYwjECMa5CnBp7xFWwF1qxEZiwM3Ah1nCY11Cke+FcKOcyffCVUZDm18?=
 =?us-ascii?Q?+m7bomilcSxQAnpJEI0dqwRqkrmahjiDR9Ewb3gM/ZuJMV4cKM57YpZkKQ65?=
 =?us-ascii?Q?bRfmhFV9kzgbux5jovabFbzLOKuSUDn0xmsIJKxzxkhOXzzreDdMfJ8KQJfy?=
 =?us-ascii?Q?gsa0cotQPwRd9nUxSuMceJXOJ/0Fu8J6vvMvA+1c+tKB9cXlemqFu9LxBIn1?=
 =?us-ascii?Q?uw2ZpeWd+jM0uIrDiOkuA9PHsRyrvg/otMa43CE/FhpFNe1s/lsB3PBQt1ld?=
 =?us-ascii?Q?d1rr87bicEG5ZrQB3pfljs8DaANCnt2KuPisU4mj5g75GQ9PnNX9HyBXLKf/?=
 =?us-ascii?Q?hX6mb8OpU/H++wfugjNAGT7oj5jLzkv3D85KUq2eNsPioJmWPlHhs+4nqu5G?=
 =?us-ascii?Q?THJp/03SjQannXdvvap19XHZTruTNmFAxzxEb3XiAYbh1rgZFoBMFrP99a7G?=
 =?us-ascii?Q?BsexA2tiUJh3kISYlbXBnfyAZMgCLoqrkTfSaxHEeqKHVG77Jq0QSBHylzON?=
 =?us-ascii?Q?EK1wrLdk0wMzdSaJjqr21qw9MkpkJlKZvl+hX6zf+uXTKjaHJ0Ske/YfASrS?=
 =?us-ascii?Q?ihZ0LLLRp+XETptm4FXuNKAKq052UTVQwAZO2pyyOYuTivQ9rVjQji8EMuqm?=
 =?us-ascii?Q?86FXiglyeVCoH1oCMVkL7wN9zaX96XhLikPawIiPCnLt7OxrTsLZCw/veBvo?=
 =?us-ascii?Q?Wfe8/6bkgJcxqrogIqwzJiNYYJLgDKsUPxoUFDhxZHSke2MYd4+nQbAssLq5?=
 =?us-ascii?Q?vODijYogwRJ5RmWpcBwjmvx1rMtQuB5A+nTM+u9da8JqiDBaWePOFWuEVUD2?=
 =?us-ascii?Q?+cTmToVV3NYmnmtxjftI7gyunjtGwgGZwRIuqo1S7k3cI2+17/tvaDgBbVir?=
 =?us-ascii?Q?9xKe9t5JY4l/bsL2S62Wc6N3Cp+2KR3HKjFV9Hw8aDkyvrt5ugq9C+lO+/L9?=
 =?us-ascii?Q?qWvd3G+UXL4etEtgy3adcig03Nw0o5LNKoh9T+vzHq8ZdioUcfYpimzkZeZv?=
 =?us-ascii?Q?Eac71Wjkcu7nqNgP5QJSmqfxq/EuckH3iWfzSokS40fuZzr6oGzD5ZhgVOpC?=
 =?us-ascii?Q?HhBXD9i2Kckh7mgOuvXoIWEJRoliX6IlVJjjHUL/yVVZVff+7QvC/uMBm1Iw?=
 =?us-ascii?Q?W+0VS5PzVXcVlYkpqmI9RVIPP1KcQsBjZzG6CTMI5dFavE/TpvjUH1x9IQYJ?=
 =?us-ascii?Q?kgdPEbCAy+0zTkdXBqyVOZ2v4VSowFvszGu+WYU+B6QP2kd92jIhwYki36W5?=
 =?us-ascii?Q?Lgwh3ZM3mk3UKWmd1t7HmcO2PWy0JVJzHfOKVuM7D3Vr+A+De3y+2FvNkP0j?=
 =?us-ascii?Q?aDDzgXBGj5lpe5rGO+2S4T20S8HdATeTvWRzZsTd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adc8f49-764a-4d6e-a022-08dc41bdc903
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:24:16.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q/6w+AAnqeicOHSp9HSlhFTydc06xQPsWewHBvKj9R0vAvFPui+dtJDEJlcZLQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690

Update pca9450 bindings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
changes in v3:
1. add Acked-by tag.

changes in v2:
1. adjust the subject prefix sequence.
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e9774..849bfa50bdba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -28,6 +28,7 @@ properties:
       - nxp,pca9450a
       - nxp,pca9450b
       - nxp,pca9450c
+      - nxp,pca9451a
 
   reg:
     maxItems: 1
-- 
2.37.1


