Return-Path: <linux-kernel+bounces-32034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F283558B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871222813AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9B36AFD;
	Sun, 21 Jan 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RLiWtsvH"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76110364DD;
	Sun, 21 Jan 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705837593; cv=fail; b=Pj2mZZLcsF6uCCurL5qxC70C2+OfDgEXFgRY0jtotWMAe4sPQRVQcwU43v6GcCLhReP0Vl0qPsDYOpVqeWPnu5ZidfaXrQgCqS9QZijzqBYF8VhzGSV0AwP8M5XBcdyZJnknifGf4k5K03AAqq9EcRnrQJMt3HQSluudF2wc2mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705837593; c=relaxed/simple;
	bh=Hu+MIOVmsToquZuWyybKYrx/TK4Mdu+TAB62Py2cjdI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sABhKcdtPHEUcYhJbYBkNqJTqZgj6tMs4rvi+wulPKxr+q2daqDShiCuNnOtkdQJtxumi5XpVGY3mAkcnFmdKS/uze3xh8sOQsw6GLndJRXGeQBdr8Kora3pBqtzBgSzr3QxIHmWHTutOAaVasizSvsf5Pim2Yd4e3Z44xDq9Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RLiWtsvH; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJFG7RkkA+XrTKlihrDFteO0sCfihJrbQZ3YA2yyEFJ5wGjaUrDl2jGerGRBq5CDl1TOWd/FnzfyIkY4opGxoX0onAHxN+ap6DXp4GN6D/a9C/wf6t+H4KhEeQOq3KW+Hy5x0tTolpq1PBWkOulW8kswhEuNk2pFcROrkvcPPRJIcPU5DyDjvoX6Akb43MY9P0LNX8/k91ANg25OwXgecdPf66PtnI/ppjgRRgSUaVBmTxvmGmWwqdipRciEmAbsUVXnK/zNc1gOxVqhu+5VZTS0vxfBa3jS94OD8399zhhUoJbvdAiM/qLNRScc7feHnyN8eEqadTUakSIqE62sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZx8JwWfIp5vMl44ZTPLjoRkE3WAq/IHvp7t8fEsCPQ=;
 b=E+JCH2qS/57Kq0fukAbRakUDLrYv9Sna7Hdn0lBniHnvmboIA8ucZkw0XFf6TK4QTZSVnO6UddQbxNdMQYUy5LWJuGOusph8sV30crLc5q0UfJ/4VeHlWqIfjB0HoxHATa0twvVJuN8mEae0QWYsOOdZ/fDYgEYh/z7+WPUNLrccrljEaYaK5gYqfAIdWvzjXBscl1fuCxJ8fgRngqrY+p4p0xzDc3LNgzY0UuzulcbJvPLuhQpCVgXHwW3nC1zWiJCQ2aCaiAHUGw/i2bwI5Op7XFOCbMxCZst8FflNLMPS1pYwkJnVCeziF5qlbES3zQEo7yG5VZMhtvdyEtJggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZx8JwWfIp5vMl44ZTPLjoRkE3WAq/IHvp7t8fEsCPQ=;
 b=RLiWtsvHFdAWejpvtrFdHVP/4/DDIEmXzVt7/u/dM+2hO2FOhPNRaZ8Wq27CzKjYyehm4eR7Tpa0fUobTACqaAxc7CibAZICOjFVVCTPsdkY2YfQ5WQcCfgbZQcoY3WOvoGhahjXAzVzs9rQtvXo0IGBO1lf/FghWKLnNJPIyoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 21 Jan
 2024 11:46:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 11:46:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-imx@nxp.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: power: support NXP i.MX95
Date: Sun, 21 Jan 2024 19:50:43 +0800
Message-Id: <20240121115043.1419916-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 622f0baf-5a72-42b9-787a-08dc1a769a40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pgiSkLi/XIoHVFtAocYsAocA8RYMYejDVktaz79jrbMwtTgGYcHZjy+uxiMM90VHhrFkKhaYGsrXPtliw/im4nEVPdqnDkEGRMwynSmGEIfptGLYELtVsmElpSS8tJ/FP5jhaHnTNkZU3p466Emwdx27WZEULxfPBTfAYpU8cijPO/KjU+bxWoX+fbrKflMrtEWse3UVdwbkeXXkQcWqel7ukMXjmoziGhVXZM3yV+bpC60bK3XQ++7qx9CKtArKTU8KPO6baiwo4UFzv+evnAIDteDnJasvRRow1lGXgc60v/xcKudeqfOdkj/M9nI0TnLU8TUlb9YwWZbgkpgN3WWVnZrONXLtIlyY5OKcnnXpQxePuFU3ZooUnMvy4OFE3/H1akPQws3GrtzllV56libGl6IFdjp5b4ccr6B18UH36CtbHphVndJ7CL4rK8rNm1E0N5bnf3vs5crdgnE0VdfnZBShscPo8N2MFeazAhiw6GIVsz34jK1IPCWczO9QY+T0Tg31Ph5lv8abDtve8rUc6/lu61ZEFQyKtLjbFuX+WngOYr3tNXOenJetw3Py24/khGuIRMV5pvpZ+XSKCMqWaH3H7yvGSlANCh+n6M89LH3Vea5SpqStsoIfQoIn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6666004)(6512007)(6506007)(1076003)(26005)(52116002)(2616005)(38100700002)(86362001)(38350700005)(8936002)(41300700001)(8676002)(4326008)(6486002)(2906002)(5660300002)(7416002)(316002)(478600001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUDw0thnisEu4MHbSFr2HL+EG1rvJqBRVgOYWyjNe6i9SOY0yuz+piXq4UbV?=
 =?us-ascii?Q?1tPoPJlPNIJX0aaUXr/meqtnNEYZKl0E2dtSQf3NC8l2QDBX0f9P7h8JHhEs?=
 =?us-ascii?Q?fmK/NByx3yx9Z7TmNcZfrgWDMp6pMtg4RbMFhRtRqWjfMyl1DKJKznIvimaE?=
 =?us-ascii?Q?7NqqyFKpIgTyOC6ZF+RqL+gzUfBovQdaVFYODlFU3Mukyvkc0qeE1FfpT3Rs?=
 =?us-ascii?Q?8YavxgrvXR0YzOiiqa9xWFJNgYEL+Ew1QmcmKBsElJ5tD/sdHOUK9yp9uw0R?=
 =?us-ascii?Q?DkNseOo9fX1qL5Iezy4VvPdABP6JLb26kw5S+uKoU0G9arr1jx5nRrVGugUS?=
 =?us-ascii?Q?Gn00t5qfBrV6RzyUJplnxtwx1L+aTdXN3ofjT1GqqnKrUkAVIvYm/s+Jb7vL?=
 =?us-ascii?Q?3H3qidxtNV3ARH6+1DTGdfVZg7BGRcvIoZU6aGXs3ukaC7SqMWIX0Ca6rj+l?=
 =?us-ascii?Q?IgUYSSZQxymjUw+eezutySyFArPO0jirJjDsWoAL+DMkbViAL4VH6CwNfXew?=
 =?us-ascii?Q?58kq6Ed5M7h/VF0TPYluf7isIiaku8DCO2PvqmTvTzueLcVMqm534GouTCIk?=
 =?us-ascii?Q?c5YUsAx49XW8ea/soXZbYBj2lYZTr4WMNx/TY1oNw8J+vc9u/IvtjTdcKug+?=
 =?us-ascii?Q?aZGHycHrDWSwG0OoiI/uKp0dvFnRDYszoX3w17lCzLIlKTty1FF6sQ3vo8Ly?=
 =?us-ascii?Q?H4II2WkFFhoHUmmpEm6K3ucQkNesueMGBWnhMgWJWQ8sJ0GMqR2wuxnZeSA6?=
 =?us-ascii?Q?HqJ9rmS8bb1Z8o0LKVW6cGEJ6jATcEo3zMpBhVC9jm0dzwsurg3WUKsmRTZn?=
 =?us-ascii?Q?7z+VKeS3obEYWnS7tNjR+D36qFo4fF1waiZiJYT34ToE8w5XtcJKfyqRNXjb?=
 =?us-ascii?Q?GPR1XZbkQ6/l6T/CwaEe6N0bMAwO8iFfLQPS7PUHLLaik/yq3olEmk3m7YKp?=
 =?us-ascii?Q?rtkpVy0mm8zkp5299MWx+Y2m0wpGlbHNkiMMA+7eEsEFUlYZbzU36WIJVmb3?=
 =?us-ascii?Q?PEAh67Iet6eWnNAydjjtRhwAV/HRlO/6cEAa+mQ/BuNRVkMxOAy2Zw51MmVM?=
 =?us-ascii?Q?nQNeKzTQ2mbA1FGd6iwucREpUvAdKi4IijbbWuZP8rwzOfQMmvBJCU0pPs3a?=
 =?us-ascii?Q?wVIGkGRyZILFH7VG5uCE8XxJvGz+Mla98PP83alsFmgfiXg5t0icBW/C0Eh3?=
 =?us-ascii?Q?rTu3g+aRzkOVCrO/VxpIqhIvobJW/PjilmHQUpMitoQmdDOHcRFfMPapmncx?=
 =?us-ascii?Q?7ld3/SgLfT8eEPy2DSqe28yllgxTFij46QE++TcLoH7wyt3utDcILzaH/DSu?=
 =?us-ascii?Q?foJh4OrHTIgHvFHmElM8q7Ax1/Ow0Hdha+pEqJKJnsGQi3qiDUdapChFc84B?=
 =?us-ascii?Q?lQGdOQo9++7msRZPooCLEVlFKExkQVI+0DFEvWObrYH/n4Bv0H6dbbKHWgZU?=
 =?us-ascii?Q?rYZFuuVq88o5/krfarlAFAurIH0ME+g2LHl01+LDGBAkpXclIZwWocNi1yZi?=
 =?us-ascii?Q?knRstxavEYUdEqoStdWy2tkcNN0XcB8321ryVM9AxkU6PfYvWrfqH/kqDnX1?=
 =?us-ascii?Q?QVGWxH0vhUGK03eQz6L/Z9cTxW6KScuO42xnAE7c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f0baf-5a72-42b9-787a-08dc1a769a40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 11:46:27.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozb4F+gwLeSBgnjI1KOQruCiR4eR5XXNBfizQHnZPal4grmHz/sEhC5k4U0rzCLm8d2VOdygT1ElJ2eOYxwnhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 power domain dt-binding header file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/nxp,imx95-power.h | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/dt-bindings/power/nxp,imx95-power.h

diff --git a/include/dt-bindings/power/nxp,imx95-power.h b/include/dt-bindings/power/nxp,imx95-power.h
new file mode 100644
index 000000000000..71ff8689f145
--- /dev/null
+++ b/include/dt-bindings/power/nxp,imx95-power.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX95_POWER_H__
+#define __DT_BINDINGS_IMX95_POWER_H__
+
+#define IMX95_PD_ANA		0
+#define IMX95_PD_AON		1
+#define IMX95_PD_BBSM		2
+#define IMX95_PD_CAMERA		3
+#define IMX95_PD_CCMSRCGPC	4
+#define IMX95_PD_A55C0		5
+#define IMX95_PD_A55C1		6
+#define IMX95_PD_A55C2		7
+#define IMX95_PD_A55C3		8
+#define IMX95_PD_A55C4		9
+#define IMX95_PD_A55C5		10
+#define IMX95_PD_A55P		11
+#define IMX95_PD_DDR		12
+#define IMX95_PD_DISPLAY	13
+#define IMX95_PD_GPU		14
+#define IMX95_PD_HSIO_TOP	15
+#define IMX95_PD_HSIO_WAON	16
+#define IMX95_PD_M7		17
+#define IMX95_PD_NETC		18
+#define IMX95_PD_NOC		19
+#define IMX95_PD_NPU		20
+#define IMX95_PD_VPU		21
+#define IMX95_PD_WAKEUP		22
+
+#define IMX95_PERF_ELE		0
+#define IMX95_PERF_M33		1
+#define IMX95_PERF_WAKEUP	2
+#define IMX95_PERF_M7		3
+#define IMX95_PERF_DRAM		4
+#define IMX95_PERF_HSIO		5
+#define IMX95_PERF_NPU		6
+#define IMX95_PERF_NOC		7
+#define IMX95_PERF_A55		8
+#define IMX95_PERF_GPU		9
+#define IMX95_PERF_VPU		10
+#define IMX95_PERF_CAM		11
+#define IMX95_PERF_DISP		12
+#define IMX95_PERF_A55PER	13
+#define IMX95_PERF_A55P		14
+#define IMX95_PERF_A55C0	15
+#define IMX95_PERF_A55C1	16
+#define IMX95_PERF_A55C2	17
+#define IMX95_PERF_A55C3	18
+#define IMX95_PERF_A55C4	19
+#define IMX95_PERF_A55C5	20
+
+#endif
-- 
2.37.1


