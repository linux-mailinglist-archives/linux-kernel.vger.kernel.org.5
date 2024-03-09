Return-Path: <linux-kernel+bounces-97823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A64876FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47571C20BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE8374C4;
	Sat,  9 Mar 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kb6w2Sjw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2036.outbound.protection.outlook.com [40.92.19.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9053839D;
	Sat,  9 Mar 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975030; cv=fail; b=WBcK/FBCZBVVTQty55tocvO9Eh9/GRMin/UJBITqF4jRo+EaguzGRAQhPDzDS2M4yoppTtUyCUgVfhBjTGsH1Lsxs71oH6hU3jpc7wV9I3w2+HGe3ZMq9p6XOB9KEJ4TyoES2XJ5PKYRQJR74n8k78n1sILlG64ykDJTjp8li8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975030; c=relaxed/simple;
	bh=jzUPmXpGAd6vQsqCqWkCNUjY4z7YpiN/g99/hgLEFQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO7UZQzJ9JjOSb8tkOzRDAaWKLqXFUYUFayVppixmwKNPJmvoc//Aa7aJYOtx8tBjnpu4pL6zlcNkXL7+zKM1l09xox8s407vO7Q0wbHyQWKxk/1prgxi9zrFl720YpHlDDg5spbJmcmagtPH6oJPYOqB14JL3HSSWu3R1cMtYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kb6w2Sjw; arc=fail smtp.client-ip=40.92.19.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5zmcUjpNTwT5FHyPAnytUQoUajnTB7vuDPKCiIHCm104eh1L5FQVD64QcugI1WLvatwZqgPdeD4MMwqh0MoOO7oixAISGk/5hxlHDdfq/67BoMnseEdUv7IU4/w0vmbVJ1/SHcpJZUKDjzxG0BGpY+PHfbGY6Blbg788n3tnEFdVQmOur+zC8UKMeSFeSfBYygkyOBeBhZ87LBv/Y6tjg8YzQhNywmmlxAk878Pq/Jx7uw/zeXpoAnYuY9SgI3RY65Mwg0jTEZAwKwNzj6majKVhbwAxSGqR70GmnxquwI4WZUgq/frnuGL5qKW8LAipnw8scwJzMTMN60i5FYmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXKebW81HIKbfru8Xbvk/M2+H4liGBrQ3VC1HcchFE8=;
 b=cQuG9HhjvkGPbdzn0mC0h/zC80g0ycuLtRGxxeHm10lQmxt8GYHP+3tmBO9/ZyUxTQdL6UKbHqlyc2oxdxp7Y9tx76U2j+yuC9bdNFxFGEYc/lbjkJtZDSBmxjOOf/Vflh/V0OddZDe3ZI8fTUMUL2yBEnwb5G0qhYcmtaDLVw3QwfVh4s85l0fv3cpJ1Bun01TVOLkPjra2mREvG39vCVanyE97Zd44CbR8Oolhx3NrUGffRAyU2B+G0KCfivo9FPE+tmClRmVSh1lWG0heSHBFJsUa1VISC/N++GW+ysjqUEIrpOF+f9bNGIkTZYkHxUpbLu2WI2vvarvNXpiddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXKebW81HIKbfru8Xbvk/M2+H4liGBrQ3VC1HcchFE8=;
 b=kb6w2SjwU3FGf/zl7PR0U4q/t3YEJ+LarXp6IQbokG2CnD/8BScJjSwq8a3EER11TxGmOfVKYQepqLabPuHjnNynJ4blM5qRAg0UegJ5hBSUanPo3P+t/Yrp2N8e1RhahHGzQeEHnxTrBqLlRKUcspaiLj7B53zlBGknXy4XAJpVy9SIdu/gdISWqaLqmaJYxBsdtHeKkpUUSv39heUnOM9cMqUbtZwSqdvCw2TWmGYrYy1v4dExpcxpbxNlXmWNa6IWzJmiGLtCu3daB+v8GLgRm1w3/KaoMGSvICCRZ9Q8QRr5zFczO5FIZhJ2hK2bvr9vc4IH/VcPU9cPcPRkfw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4260.namprd20.prod.outlook.com (2603:10b6:303:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 09:03:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 09:03:46 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 5/6] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date: Sat,  9 Mar 2024 17:02:55 +0800
Message-ID:
 <IA1PR20MB4953ED6A4B57773865F49D6DBB262@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DGM7oJ/u4E3Zqiu3rruldR2Kc6ER3uED2BN11vTMJf4=]
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240309090257.927623-5-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a60f150-85fb-42c6-c904-08dc4017d3c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oPrsqEcvz5Yz8k38LX/l0cZ3sKRptcXjGIl8U5tKDOET8CvxKRK0jDKIw1C8SrYHX9XeHLObEsDLb5+eCI5BLnffz1mfBPtt3FefEUxY0pi5maj+sfTXpwJoaM1OkWiGV1503OcZaCgltX5/dooBbFwNeMJO0Q+C5TkoKWW93TqQHP4fjml01UTGJJI2cSxrF6roYbiqIvxjXfYL780yzrM6AxxLMcEa8pVum0XV5l7/o1DeQj74VrxDO8Pgs3XQdPPsiDFsLllunqhwwkCs+UbN/UXc8w4asX0QlSY41ZU3yqvsMaDw9A15b6/nCHQXXvvJfKO+Le7arGIDc+E8aFksaqPwQkv5SOJvAQG+We0VO4TSucJWsDxEoQUh7ytawTFEblUTprUbuus/0nomZw0QokTu4EfdsIwZy2dveJFJ/pVgvgladTv6qi1+0QpOhOVbwNTbzLa2TBS9XaRzLsu+ezS2Q6Zj0XqOSib193rS8unl1WQvrGKXqyzKSg+9RDgUAmBmJfbFbQpt1YASVMzBSxi/3kyHHwsp123eVJDMc+3M+HTPda51ulp6CqpysUzGbNNK0SWuqwDrSvlO4tesQjuKaWoSHqnmIvQAUZZQjEcRnRwK50VIU0C1HjPZHvMhbpwRmfriGYIOdYWKztKY20x0BRGY1sohPSMis4flJbmTUrLCH8RKTsKqElEOVW6w3N5+jl524ro6xaz8+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?awTxKT+wFZqUYL5Pu5lkufDflxHfXY5mSBrtknN5UFPu1TSaFqRMxR3qYpbt?=
 =?us-ascii?Q?t6wzN0+Xqc74emZFcCCTKjvzT1zxPxj9IGrlHppTJvyROSPgALKNkILfyU+P?=
 =?us-ascii?Q?SnpezVf6mfVRuWkVsPNRSE8scFiMfLkndlSMhfLU2/JY8JWCCtaD3V7a23Uf?=
 =?us-ascii?Q?0SdlceIdmYQ99qOY/1qh+hRhA2HZvLl7hflpyU3ZoXL43aU64dfeHwstmdX/?=
 =?us-ascii?Q?p+FYQkb1bkiM5bLMRhMDZ/OVl5WsYhwCFP4W1F7xIKIaHGBvp2NGuoZ6zpHk?=
 =?us-ascii?Q?62XqLy9mbSuOsfQJfRZ+qnph1qnj1wS4K1zWTPvwLAJb1W+8bFITiRAovI7h?=
 =?us-ascii?Q?7OZF5elk5eYiUvX8f34KK9THhzjyH5YCuI3peyRVyUKzphNs47NmeAgcg7cB?=
 =?us-ascii?Q?Dij7i4CSXZH6wYyQ02C3AY+76bYfAippmG1yS1+1jwm5uSrHydaecFIylZSI?=
 =?us-ascii?Q?qgNl/E4ZB/RT3x0k6WJk9rU7kJH14FR6OnjjRI0X4Wrpq4hlAnA+YO2XtRxZ?=
 =?us-ascii?Q?usWoL2y2yNaWo2DzVVUK9FbRagclD6CXLEqCiWK1UHb1Ydrr/hVwqii/bdgy?=
 =?us-ascii?Q?fTFWdn+QgA/mIDhyxEJp7FYxwWc7cK0PgmRDrPFYIVOwt3kkACHtQpU83RdH?=
 =?us-ascii?Q?G40W9jdsYv8+Wpdp6aOSwXGcYID3AOgN2UacDWYb6M7rXai2FXoJeJF3RwPh?=
 =?us-ascii?Q?Q7DcMbsxErJqWPZWHYhqgs+xvtQkebAzWWV0VX3nJpeCTuwwQ+jKZj5qM3Nz?=
 =?us-ascii?Q?Za5Qk7sYBbXP3Vl5MEtawIJKUzXS208cKk0I4fOPk1kMsRNsFW+XajFGB075?=
 =?us-ascii?Q?BnMA7l2Wt5+xU4kqxRdV0giC97ER5/XwaFThvA5zgZ1c9d0mdbcyiaAMxGTo?=
 =?us-ascii?Q?WSuSWsWOUyS9rdIaRsVZlSDMw3WmtZzu0Wt/bCU0eUZnckSdCg/HUeEyQlww?=
 =?us-ascii?Q?SuT9S+zTgdd6oG6ujz+6yiq8ooLWDaNNpixLXEvm1BFDBsVjwu+00TpekpVX?=
 =?us-ascii?Q?HTMP2QB3lwDrKxFnG3rQBTgbThi4mzhAIyZnkkP8SisDCiGyqu1/evQE7I6T?=
 =?us-ascii?Q?za2dKY+3pNcxMmT2s2IKmqbm10dk/b/WcnvwdNO0roWvAZ9395w7YAYfXOjp?=
 =?us-ascii?Q?u2QHSHshZLls/h6DUBPjT2jPkLPhtNfdqj5l8XdO97jkqKfbdeHaPKr+HnvD?=
 =?us-ascii?Q?k7z9HIchzABqx+5ZIGMhYM0yF12kUSZpF1TpPPj6jJGzH6bqJmd3xPdp+adb?=
 =?us-ascii?Q?o5dVn9fsjhhaYkCqUoS8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a60f150-85fb-42c6-c904-08dc4017d3c1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 09:03:46.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4260

Add clock generator node for CV1800B and CV1812H.

Until now, It uses DT override to minimize duplication. This may
change in the future. See the last link for the discussion on
maintaining DT of CV1800 series.

Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
Link: https://lore.kernel.org/all/IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index 165e9e320a8c..baf641829e72 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -16,3 +16,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1800-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
index 3e7a942f5c1a..7fa4c1e2d1da 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -22,3 +22,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1810-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..6ea1b2784db9 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,12 @@ soc {
 		dma-noncoherent;
 		ranges;

+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.44.0


