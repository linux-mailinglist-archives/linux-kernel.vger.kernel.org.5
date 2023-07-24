Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEEC75ECDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGXHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGXHyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:54:25 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85313E6E;
        Mon, 24 Jul 2023 00:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpbBKCzON2nJCXRjd9abQ9g56BKlvEGrNBKEChBgi6Js6gph7j04m7aug/UJcDK2ziO6eecIoMz0i7P1giJQQzVXtGeoapK3tJ4JEyBUpH3gi6A1ttYpny+8+o4AVqZi3/gU7nr2grfV7zc7060HmfNIBlyt84f9AIucUP3+FaPmBBauMO4YllU6Kk25oix0iZRM1RShDVfjGbMJx6NeIv0+8aKMdFKtfoVSshzojCFDLm7rlJCjcXkPhVnGwyDawSCJHzZ90XmZsD0BCz5rR5eIDHYG3kViMMqlGM+DF/6/QjK9HC3usnEieOaSaAqudk4JT1uBAHjLU20Vvrwzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SbtTu4p8caZd5D3AyWQHECe/owVBVwmtCG8zdm6C0U=;
 b=FqW8ae5dCWJvLahegXLbj9Tb9Kqp9M2MQu1PVJnCKdYlTGWrJ7vdMzKnv5BsWM7EN0lmhHnj8bIGsu1kfApDLKhISer2K54JtRtYkzArry056LytQAjTTtv3pzD+AaL8/HiY8fFLk0FFgNbFJrvjbz5Kotj/mKBCdTZsrNdc0KqZb7qmEUW1RgUJoWeYvNV/9OXuqvg/LU/LfIexq1l15tdurRBUR4rQVfmTwKA2kE3LCvENlQlfuIZhUxFfwjV1wHf0DG5hA3r1xDYb18rXjchPW2t1w31f65dWL/GQ6N94N65vVe1H8a9tQfBsqU3sHXVkInUwZWhLE6qqbEi7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SbtTu4p8caZd5D3AyWQHECe/owVBVwmtCG8zdm6C0U=;
 b=gtLBI1putbDVCwktMaoyL+m6shH3dMsvQnXIEoro4sJ9jTdxli1AaMnxk7U9jynF01ol/EgWkGgdVRSAFTYXsUjbMv0mqzUIrARZ26bHxO9II/QZ8i9OPVY+eLhaGxZa2zK0shIPQopto2WwuJFljWApOrD0BvbUWOxNJOIseTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 04/10] arm64: dts: imx8ulp: add cpuidle node
Date:   Mon, 24 Jul 2023 15:58:27 +0800
Message-Id: <20230724075833.2763190-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c84c4e8-17f0-475a-b2b9-08db8c1b2944
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g1UlB5kw6kCeP9nTJvDxDdk7BBY2yDDFZa1ibkYAN9c7FBGu7ODiZsuAutt9lvKsn9LFJtGGQQ7VrRA1qazJMjHKnXjp96CJXrPqZOlKDmEjwxoQBjNRPeSBoQBmNrSlkHrLVWVkKdMfEZxzpHybTx7IgENJOrG8jg/QY6vlK2ESHbmuAV0UFER04OuMRTyDRj96J7wu8eXQlMLg7Lab8+YqpZf7+FcihDc/iisBPfWtGlgF5l8Xdy0e6++bBAbxV0R4SEf4vU23KzCOMS9S82EKfpqwkEKfVFQxFPCBUd62RobggIKb1CpcJcG9Xydyfl9oCV3VLmdmW0BaNRI4vQhzMQz4nyNsUR1fjFssmHGHVGExhemIL+0yw3/l19c5AaV9q6zF5u8ZomDgld/PrVGbljZWFwnxcRinxt63rjFQ44zmhOTdtFK5F9m4zPFNbbsDK6/Gvyicquz6ZeQ4+Zi10oUYQym1LsESRfE2v9rGd8AJThBIP42LUJsOeAyr1j1W6gSospb1lWSQkVEuGeY0VoIxVYY/yIRIiOpW/0pcx6+iR91/nLev+O0dxCiUMX614u6foiOkutFcXJQ3n+EOETRls6menBDJLy7OCZc868dAMo4U6dYPv6MRvhb4QzGHEYdWqJKYSHLamLv4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(52116002)(6666004)(478600001)(54906003)(186003)(2616005)(6506007)(1076003)(26005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38350700002)(38100700002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IEvarb4cpCL9Ec4kocUg2joewm56qTEhQCkb1QVs2vrBlUzktemFyFlkF5C7?=
 =?us-ascii?Q?PK2v1+Uff4TN/NrBFvlpX05olxInANvsm4s9nZ4TVIDp8TGD3coDt80MXaeo?=
 =?us-ascii?Q?/6X8PaZ9fbnorTc6QYt+Cs3hZjTmzAfJ8aeEup60fnRlOEYNyLXBcUPg+Z1b?=
 =?us-ascii?Q?8SCCQQctJDsZDVrux/nNcXJtZF+zLuJK3m2fS3erhqzYMYHDvuJHcyZXW04M?=
 =?us-ascii?Q?ZqedQ8I5omxjMM8B1UV5t1UYynpKmxbq4t3o2JNtPF0xv4ddSkaolunvSu1R?=
 =?us-ascii?Q?kvxOMKNV1/q+QdETwyC8Kva6tkwZ0c29hLr/8QMqDBfJtf/vvNS2mfBl5I0F?=
 =?us-ascii?Q?5/6FuVeIeEGKKd/uo6hQcZmf1yEORDrW9ZPMeJKZ6CK1trpJ9BRfMHHzC/2l?=
 =?us-ascii?Q?TIe7qUQVuM4jBtcuwLXa7Eg/VBWGu7yNo1sj7q8dz89jJljbcqYo3YsN7kki?=
 =?us-ascii?Q?Bawp7vKSf2aqbAYFjKDFkULWqvZvRLGYC963CL/0g2cdeNa4xe96aRM9492L?=
 =?us-ascii?Q?mshPl+uUSkPxqY2iRwbqtIOt6swsx8sKX8a+AGsBYcwOcW2KkH4R5nq7GWQM?=
 =?us-ascii?Q?aATtkn8G3YNkC646zpQPrHUt0iRVpOXa0lVJKydotGsoS02hDRJC+3hzas1X?=
 =?us-ascii?Q?occ3JY6X9I79AYnuA+r+fxP4z+Sh9oZ3Of7mTh7fvS6qGc6+KbG/zuhRe4Ke?=
 =?us-ascii?Q?5U2tmLq44nv36yNgWPW5wGcgDZ9/+PiIQTttp7J7lwWrlzwuKSt9um/C6o2P?=
 =?us-ascii?Q?7Y0wa7IlHqyQrbQJWfiIT052DaSgoFgV9+gGKv+kCfLzrH+4zCkYrz3DIxT2?=
 =?us-ascii?Q?+3OfBY0N/kA+STITQIM+q8byT0sh80pne+bkrPyD3qzlnN3gvh+vSWtc5t6v?=
 =?us-ascii?Q?XRmrxMmuKn71O8nEaRh+Rgc8NlQ5RQaiIRatKc+vNDc4zXM9yd9ij7CtUwtX?=
 =?us-ascii?Q?AqQNsWdG+QFRjUmOZNvQW1K1uJ6BPQOoTv2J1BQTtrPjNDBUzcvBPsegSJ9u?=
 =?us-ascii?Q?/mSSfiZ3SMFpxM+ap4Mk3d6NaUmm5jXn5RCUCrSRfBBnsTMJyf+bilU1atuK?=
 =?us-ascii?Q?QMFuqoqyJ7pjX5OWx9iJqGbqRHV6G8bydrWH4Kk0kd2scRibB4b1q7diOE5f?=
 =?us-ascii?Q?kQumCa1CDcFaiU6KcfJDub+E/vD8msM4ucnWmEY2+sxyUsguCFw6ENpaoi6c?=
 =?us-ascii?Q?80OeBpP5xMHwf0v4CwBnk2W8ewmdT24X6S7B/ZJVmXfEC6kp/zutw12ns8rz?=
 =?us-ascii?Q?GTIhgpBI/ND348rmHE6EcQiiIlqs2RC9ntIRsqCpidYieEnCOMn52BcjHKNP?=
 =?us-ascii?Q?LMw5zDXKHaeYmxrCLhMjCZY6m+CWf9kLXeANUSG/YNdasU59CueHPWfnqhM3?=
 =?us-ascii?Q?y3+7zep/lO4yJv36Lfki3uH6McSRN5VkWW2n8czF1H/77VNCMficqE8zSxvV?=
 =?us-ascii?Q?QGqTApXY9aGF6dsoYUNl4S8GlQeSxo0uV57aNRUte0d7NGX84GAq2xpgsHhi?=
 =?us-ascii?Q?SqI+T5ryeIulsVQ4bM4s4sjbbrHPhPfF3eWw099vMvnny5F6+5obDzAjhXyV?=
 =?us-ascii?Q?9wi2GL/B3FZip22JVspRAJd52JO4SMTFAX5fOKdx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c84c4e8-17f0-475a-b2b9-08db8c1b2944
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:08.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYc3Bes1GVNxR5LF+90RQQO9AnO60Zl9/Qzxm4w9W4kCp6Ods6p3xOjFIuxxJuoCpD9taLSsf0Twcv222WvS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node and enable cpuidle for dual cores. The HW mode in
Arm Trusted Firmware is SoC Application Power Domain Sleep mode.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8891b4dc3bea..17cbe526a5b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -40,6 +40,7 @@ A35_0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		A35_1: cpu@1 {
@@ -48,6 +49,7 @@ A35_1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A35_L2>;
+			cpu-idle-states = <&cpu_sleep>;
 		};
 
 		A35_L2: l2-cache0 {
@@ -55,6 +57,19 @@ A35_L2: l2-cache0 {
 			cache-level = <2>;
 			cache-unified;
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+			};
+		};
 	};
 
 	gic: interrupt-controller@2d400000 {
-- 
2.37.1

