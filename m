Return-Path: <linux-kernel+bounces-36174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B6839D06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47B328BDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403945B204;
	Tue, 23 Jan 2024 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVWniPr2"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD155C21;
	Tue, 23 Jan 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051486; cv=fail; b=Jd+ihO7/nEDbFpC1GCfB6gSPCwKQAfhuDkE01s/gx8vkMG3RQbwu2qYRVm6d/dXcVifAQEqYcGNnE2vTbD2GkOfwHheaQ3gvRFan0newcGNlXd8AnMRqtquqmKUVaG/khGff6XuLWyIptNbmjFg35SgfMDCw/87c420wOG7Brco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051486; c=relaxed/simple;
	bh=aFPOfC8o6TVPkgK9tJDSz3OHkxkHBGqRxh2jknv+gHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txnhHyr3kG/ccmlAoqT/vZb9TMRVUE95NnRrcrNw954KPRcdU5ZGyMEmR9fTmDGieLxPVtmwZCFRayb/crnejIXhGmRJ1EjKhGri58mvpYmocmgJv3FyTtcaBnBk47hdGOuqbNoGrOpHRxjReXWSVFvt0tbvUtdsnqHZHn5wNdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BVWniPr2; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePTGC7DJI/Pul4BDfqMeZsMRYu+ue2Px0yk9rcUJOyRm8l95DJCVgsK+qAbdoEJCSW8RKo4k2N+WDRgQJF38D92tf8sxWi91JMNsYgpRNDGW5sljwban5o1fglPNs/EFhfSnIVno2yL5nMMq6bt6Huzg27JeZQVRoxKpnddEu06VDp6XjdP5LDRERAKWvQa/23Vda7hRXh26eP5NHYnKMCLp3V6/Bj++tHKSilRBrxj8Duoe0s62bHyj+4PdDNe9eBHSFBN0CTqqRlQHOrGPvPzPRu0anmai5yqcmxA7fCvOdGlsRQGy+zwOOj7/luE8IFnUR1y7LLNQheMLKbT8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv63bzvfpmi9X4WF+c0Nny0z07mV+I5l+14mQv4nxik=;
 b=Mi4AlJZDwrJjPiQtLzasNmj/0ZYbqndCtjcTdu1KwS0EoL9iww3GYvwk5xhs3YNPiM+3aztx8D82zwlPNUG/dpPz4QoriAo7TjEf5xucuOIj1q3bCbzkDx3wuaHevdXbvZn2rVYPacg4g97HuTA6CACq82Bn4brG7rvzRa0TKRHuFNIwaRVGz7RGhPvRqyvYqi64V5NxYZx68/Qx5GEUjpEc4PmAHNIrn61OU9VqKWXfQF9zI4woVu6GUtvw/BvU0vBbc3uMOnFG3528+fVMNzo+9Oq+q7Z6iyYNguK1OuVOgrXw2z3cNPGADuD5xCGEq4Da2edIxrWg6HRskytqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv63bzvfpmi9X4WF+c0Nny0z07mV+I5l+14mQv4nxik=;
 b=BVWniPr2ZSxKGJtjky4zmmm64vkzkPlnClMRo7onIPjMoc9j2u15OkApVkTfmfFhI+vb18DtvhdBuUd9hf1CWMcwKNMScQ7ligAv4KV18XLzjoZ9v/bETKaRqNjm6+e7NuAQxqg6hSw+L0pOi32jU0WXF2uKLcl6pxbqq5n3AiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 5/8] i3c: target: add svc target controller support
Date: Tue, 23 Jan 2024 18:10:40 -0500
Message-Id: <20240123231043.3891847-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123231043.3891847-1-Frank.Li@nxp.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: de96b0d0-35f1-4fe9-1e97-08dc1c689bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Vu4TH+U6x8qFekwClHr9mD+FL6sHmRuaCu2McjZ0UVrZbe+fU/zLD4kTWkfr7//mX0/DkrAZW9pi7o+/TIKkCI53zxcw1l41bulAlGKC8Nxul5Umfy6vfB05VSztfp9lOsK2losMuFg5foVX4dUtD4jkoovV2u6St54D++aC/2sx5Ee+cWuRh8Eh/Q3/2DBJCrIk3rcnhRSiwGX7SodAj9nol5fWxcdMiOS8Hpr4r5vPO5HLFMBxv6F0fd3Pb9VFiB3bLDQ5rrT6uVb5dUpWfz7p9ofKNMq2MspzMvPFkJ6Ztp54VRzNKlIErfqpDcy2t/5CJwOUoO9b97YzRWc0qg670IBIwQ9/picsfHhksgVhPfKoWoZROT/sSomoX102tFg/KuYV2hirJRnvjjHZdI82y6YOISYnLQDntNJ9ly15pXisg2N1PzTn+NEB38FmVJb+KTgES40awgZ5mji2QI4ay4yT3WXrZiN3LNCYqmurSmBt1XYIiCoJT3L2GW4aFFg3qL0TBwgw0g4R8qHgeEdV7YnE4mac3cfqO2mQhV4ZOn1rRw4MO9A6QbJGX3AuG03GyDsqIj5O3XyWhXwWAHVvEi/wBUS0dg0wqKbo+A9SUqE3wLuvRlkG5Y1J6U+1cUi3Dd9pV1RWa9begfroyA8dP2RMfniJEUm+Tu7okU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(30864003)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSieNdyjvqq2BEpfEVvAKjv93Lk9K+pReIu66Om/g2uYqs/Gr/6JHiCg+oHp?=
 =?us-ascii?Q?5ZFAo5GP2Fe8HxCYnsLOGbUG6xX8ItsN8hnfhazQZ6akY5mFsAherjbZNDtP?=
 =?us-ascii?Q?0O6kNQqZPp1wgxvdDTTfTBuLBSiMT1GjBOE2Cgmc9E3GvcHGZieK8lM7kXdQ?=
 =?us-ascii?Q?T7RaKckZi9H1GfKGc/WVN4cNz8XAPTbX58O/qTrcq0BdiQgf/pHmhWDnzXpV?=
 =?us-ascii?Q?xrAAc8Qj6oRPFxMVNmfWpz9L+KcDzbE6vPLdf7VAr4THFeHIA0cLC3onhs8r?=
 =?us-ascii?Q?3j1EnuIM5PJAd2/P8OXjOQ0x4K4fVuTiVZdjhsfGNGaDi71yLNxZxUGy2mY4?=
 =?us-ascii?Q?4nu/gjGX2YpVaFTeRraTlPZXyrTHP4Z4urRtxYDQ1BcTkXW2hQOJIlPBHobd?=
 =?us-ascii?Q?7NrP8Vio0BjzqewMYwq+BS/fB8asCeFPQ6MaFPWftXSjbrye9iPmFF/jZTkE?=
 =?us-ascii?Q?j2+lf37UKKaIMSsGLaB/WrUTovUoLBWIm5RzHsJgtJsxMACV6GZvBKFYwiSu?=
 =?us-ascii?Q?NrPSBv+lW3j35i+SanrXCHwrQpasBqnvt28X85vmGRYNzFYtm1WU0C9ScGaT?=
 =?us-ascii?Q?i6qoUoDELMYTvb+H/0I+L+irPIrz+y7nB3MIPZwtyuxsf4phgjwBQimKg/Qc?=
 =?us-ascii?Q?xHeVAg8WM9kVTuqTTcytCAqRC1tEbn23igvhVJcDGXYhOuHbvcYl4P/qlabS?=
 =?us-ascii?Q?LPQh8mNccl9t+bvcbnAJNiKpB1zQv+iYQHhTg9B1H4P99NR7ttpmLxhTE7JP?=
 =?us-ascii?Q?CUb2L866huJ+7dCjag8bdO4n9gGz2YgQCAhCPxN4/1BdSt/1dO9PzqtoNgw0?=
 =?us-ascii?Q?7//2fZosn0nol52afvpj0gj9Nn8Z7yK7/kdHpuezuQua5OxstQ3njnAZDzwc?=
 =?us-ascii?Q?91Pe4CZiR8BCyH9IhDVsHKHPC9w2cYa9vNzIj21uPHEW/n+96+AvODyH1n6/?=
 =?us-ascii?Q?4/u2LgOPqnMYptc0E/5tERY8vuePRHoI9xM81j2sAmZpgLfdQHC78sP1Sn9j?=
 =?us-ascii?Q?ca2JQPm5dbhIrOyflX/ZEBHo1WH42GTEwqh0bjTLe0ZBV7ekHo8paMaRiH/K?=
 =?us-ascii?Q?Uv4fmOQBFsK8lrL9m2hL3iYWIpX9yv3tg1jJqzEqNKG+ikUddhDk2OQ15KE1?=
 =?us-ascii?Q?rsPIDr271dpjaZmHjbDTFFzDzGXlBE0n/Fz5hBinA7jvv8dOIFXHF96zmVOc?=
 =?us-ascii?Q?+W1j1gWH56jztJRRjY1qgoV2AGUPHS9G0u7p8ezXm4nxtD26sNKuwPQ/ntVg?=
 =?us-ascii?Q?+23voKlBTK7PDwjFBz+P1pv+4GgTz5meLDGiM6cwUle/NnmjwKOw5xOosjtR?=
 =?us-ascii?Q?h0zXwg9UxaS9ehvSLAcm8x0CVel0L/n0vM+euLSNQVRKdxZZhjT+dF03qTdt?=
 =?us-ascii?Q?al0tfSB1mRckS3EdmBFzTZOgAtJrFcgbNB/UgWkI66PvILF7pdeF0ChCLN3K?=
 =?us-ascii?Q?5vJRwzt/I+/+3G7Y38zAqPQUqN2JPjgA+VoExNnhDU5CBzP3YC1YLSJfzLz9?=
 =?us-ascii?Q?GIkN4jWUpOEdMXW2LMCZ6tERli/WCnH+ztwfZ6mExicpBqz3bhmdtEg3jpZO?=
 =?us-ascii?Q?Bf774m6/8wPDWiYDRQctTfpnvN0kQysDmtcfUAiO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de96b0d0-35f1-4fe9-1e97-08dc1c689bfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:20.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocAii78Ii4+Qa6ohvKb2ABAbll9Xrmjy0vqtVEuRIw1ki2Ud5htpNBGU7p2i1r/alCU9gLpzUfP6DeFJhJ6JGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

Add Silvaco I3C target controller support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - fix build warning

 drivers/i3c/master/Makefile         |   2 +-
 drivers/i3c/master/svc-i3c-main.c   |  37 +-
 drivers/i3c/master/svc-i3c-target.c | 776 ++++++++++++++++++++++++++++
 drivers/i3c/master/svc-i3c.h        |   3 +
 4 files changed, 812 insertions(+), 6 deletions(-)
 create mode 100644 drivers/i3c/master/svc-i3c-target.c

diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 484cb81f45821..b9ed6c9e7be13 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -2,6 +2,6 @@
 obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
 obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
 obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
-svc-i3c-objs				+= svc-i3c-main.o svc-i3c-master.o
+svc-i3c-objs				+= svc-i3c-main.o svc-i3c-master.o svc-i3c-target.o
 obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c.o
 obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci/
diff --git a/drivers/i3c/master/svc-i3c-main.c b/drivers/i3c/master/svc-i3c-main.c
index 053b2bd9d8317..34d9f1e64b1c0 100644
--- a/drivers/i3c/master/svc-i3c-main.c
+++ b/drivers/i3c/master/svc-i3c-main.c
@@ -7,24 +7,51 @@
 
 #include "svc-i3c.h"
 
+static bool svc_i3c_is_master(struct device *dev)
+{
+	const char *mode = NULL;
+
+	device_property_read_string(dev, "mode", &mode);
+
+	if (!mode)
+		return true;
+
+	if (strncmp(mode, "target", 6) == 0)
+		return false;
+
+	return true;
+}
+
 static int svc_i3c_probe(struct platform_device *pdev)
 {
-	return svc_i3c_master_probe(pdev);
+	if (svc_i3c_is_master(&pdev->dev))
+		return svc_i3c_master_probe(pdev);
+
+	return svc_i3c_target_probe(pdev);
 }
 
 static void svc_i3c_remove(struct platform_device *pdev)
 {
-	svc_i3c_master_remove(pdev);
+	if (svc_i3c_is_master(&pdev->dev))
+		return svc_i3c_master_remove(pdev);
+
+	svc_i3c_target_remove(pdev);
 }
 
 static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
 {
-	return svc_i3c_master_runtime_suspend(dev);
+	if (svc_i3c_is_master(dev))
+		return svc_i3c_master_runtime_suspend(dev);
+
+	return -EINVAL;
 }
 
 static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
 {
-	return svc_i3c_master_runtime_resume(dev);
+	if (svc_i3c_is_master(dev))
+		return svc_i3c_master_runtime_resume(dev);
+
+	return -EINVAL;
 }
 
 static const struct dev_pm_ops svc_i3c_pm_ops = {
@@ -49,4 +76,4 @@ static struct platform_driver svc_i3c_master = {
 		.pm = &svc_i3c_pm_ops,
 	},
 };
-module_platform_driver(svc_i3c_master);
\ No newline at end of file
+module_platform_driver(svc_i3c_master);
diff --git a/drivers/i3c/master/svc-i3c-target.c b/drivers/i3c/master/svc-i3c-target.c
new file mode 100644
index 0000000000000..094efb60cb404
--- /dev/null
+++ b/drivers/i3c/master/svc-i3c-target.c
@@ -0,0 +1,776 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/i3c/target.h>
+#include <linux/i3c/target.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/i3c/device.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+
+#include "svc-i3c.h"
+
+enum i3c_clks {
+	PCLK,
+	FCLK,
+	SCLK,
+	MAXCLK,
+};
+
+struct svc_i3c_target {
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+	struct clk_bulk_data clks[MAXCLK];
+
+	struct list_head txq;
+	spinlock_t txq_lock; /* protect tx queue */
+	struct list_head rxq;
+	spinlock_t rxq_lock; /* protect rx queue */
+	struct list_head cq;
+	spinlock_t cq_lock; /* protect complete queue */
+
+	struct work_struct work;
+	struct workqueue_struct *workqueue;
+
+	struct completion dacomplete;
+	struct i3c_target_ctrl_features features;
+
+	spinlock_t ctrl_lock; /* protext access SCTRL register */
+};
+
+#define I3C_SCONFIG	0x4
+#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
+#define	  I3C_SCONFIG_OFFLINE_MASK	BIT(9)
+#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
+
+#define I3C_SSTATUS	0x8
+#define	  I3C_SSTATUS_STNOTSTOP_MASK	BIT(0)
+#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
+#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
+#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
+#define	  I3C_SSTATUS_DACHG_MASK	BIT(13)
+#define	  I3C_SSTATUS_EVDET_MASK	GENMASK(21, 20)
+#define	  I3C_SSTATUS_EVDET_ACKED	0x3
+#define	  I3C_SSTATUS_IBIDIS_MASK	BIT(24)
+#define	  I3C_SSTATUS_HJDIS_MASK	BIT(27)
+
+#define I3C_SCTRL	0xc
+#define   I3C_SCTRL_EVENT_MASK		GENMASK(1, 0)
+#define	  I3C_SCTRL_EVENT_IBI		0x1
+#define	  I3C_SCTRL_EVENT_HOTJOIN	0x3
+#define   I3C_SCTRL_EXTDATA_MASK	BIT(3)
+#define   I3C_SCTRL_IBIDATA_MASK	GENMASK(15, 8)
+
+#define I3C_SINTSET	0x10
+#define I3C_SINTCLR	0x14
+#define   I3C_SINT_START	BIT(8)
+#define   I3C_SINT_MATCHED	BIT(9)
+#define   I3C_SINT_STOP		BIT(10)
+#define   I3C_SINT_RXPEND	BIT(11)
+#define   I3C_SINT_TXSEND	BIT(12)
+#define   I3C_SINT_DACHG	BIT(13)
+#define   I3C_SINT_CCC		BIT(14)
+#define   I3C_SINT_ERRWARN	BIT(15)
+#define   I3C_SINT_DDRMAATCHED	BIT(16)
+#define   I3C_SINT_CHANDLED	BIT(17)
+#define   I3C_SINT_EVENT	BIT(18)
+#define   I3C_SINT_SLVRST	BIT(19)
+
+#define I3C_SDATACTRL	0x2c
+#define   I3C_SDATACTRL_RXEMPTY_MASK	BIT(31)
+#define   I3C_SDATACTRL_TXFULL_MASK	BIT(30)
+#define	  I3C_SDATACTRL_RXCOUNT_MASK	GENMASK(28, 24)
+#define	  I3C_SDATACTRL_TXCOUNT_MASK	GENMASK(20, 16)
+#define   I3C_SDATACTRL_FLUSHFB_MASK	BIT(1)
+#define   I3C_SDATACTRL_FLUSHTB_MASK	BIT(0)
+
+#define I3C_SWDATAB	0x30
+#define   I3C_SWDATAB_END_ALSO_MASK	BIT(16)
+#define	  I3C_SWDATAB_END_MASK		BIT(8)
+
+#define I3C_SWDATAE	0x34
+#define I3C_SRDATAB	0x40
+
+#define I3C_SCAPABILITIES 0x60
+#define   I3C_SCAPABILITIES_FIFOTX_MASK     GENMASK(27, 26)
+#define   I3C_SCAPABILITIES_FIFORX_MASK     GENMASK(29, 28)
+
+#define I3C_SMAXLIMITS	0x68
+#define   I3C_SMAXLIMITS_MAXRD_MASK  GENMASK(11, 0)
+#define   I3C_SMAXLIMITS_MAXWR_MASK  GENMASK(27, 16)
+
+#define I3C_SIDPARTNO	0x6c
+
+#define I3C_SIDEXT	0x70
+#define	  I3C_SIDEXT_BCR_MASK	GENMASK(23, 16)
+#define	  I3C_SIDEXT_DCR_MASK	GENMASK(15, 8)
+#define I3C_SVENDORID	0x74
+
+#define I3C_SMAPCTRL0	0x11c
+#define	  I3C_SMAPCTRL0_ENA_MASK	BIT(0)
+#define   I3C_SMAPCTRL0_DA_MASK	GENMASK(7, 1)
+
+#define I3C_IBIEXT1	0x140
+#define   I3C_IBIEXT1_CNT_MASK	GEN_MASK(2, 0)
+#define   I3C_IBIEXT1_MAX_MASK	GEN_MASK(4, 6)
+#define   I3C_IBIEXT1_EXT1_SHIFT	8
+#define   I3C_IBIEXT1_EXT2_SHIFT	16
+#define   I3C_IBIEXT1_EXT3_SHIFT	24
+
+#define I3C_IBIEXT2	0x144
+#define	  I3C_IBIEXT2_EXT4_SHIFT	0
+#define	  I3C_IBIEXT2_EXT5_SHIFT	8
+#define	  I3C_IBIEXT2_EXT6_SHIFT	16
+#define	  I3C_IBIEXT2_EXT7_SHIFT	24
+
+static int svc_i3c_target_enable(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+	u32 val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	val = readl_relaxed(svc->regs + I3C_SCONFIG);
+	val |= I3C_SCONFIG_SLVENA_MASK;
+	writel_relaxed(val, svc->regs + I3C_SCONFIG);
+
+	return 0;
+}
+
+static int svc_i3c_target_disable(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+	u32 val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	val = readl_relaxed(svc->regs + I3C_SCONFIG);
+	val &= ~I3C_SCONFIG_SLVENA_MASK;
+	writel_relaxed(val, svc->regs + I3C_SCONFIG);
+
+	return 0;
+}
+
+static int svc_i3c_target_set_config(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func)
+{
+	struct svc_i3c_target *svc;
+	u32 val;
+	u32 wm, rm;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	if (func->static_addr > 0x7F)
+		return -EINVAL;
+
+	val = readl_relaxed(svc->regs + I3C_SCONFIG);
+	val &= ~I3C_SCONFIG_SLVENA_MASK;
+	val |= FIELD_PREP(I3C_SCONFIG_SADDR_MASK, func->static_addr);
+	writel_relaxed(val, svc->regs + I3C_SCONFIG);
+
+	if (func->part_id)
+		writel_relaxed((func->part_id << 16) |
+				((func->instance_id << 12) & GENMASK(15, 12)) |
+				(func->ext_id & GENMASK(11, 0)), svc->regs + I3C_SIDPARTNO);
+
+	writel_relaxed(FIELD_PREP(I3C_SIDEXT_BCR_MASK, func->bcr) |
+		       FIELD_PREP(I3C_SIDEXT_DCR_MASK, func->dcr),
+		       svc->regs + I3C_SIDEXT);
+
+	wm = func->max_write_len == 0 ?
+	     FIELD_GET(I3C_SMAXLIMITS_MAXWR_MASK, I3C_SMAXLIMITS_MAXWR_MASK) : func->max_write_len;
+
+	wm = max_t(u32, val, 8);
+
+	rm = func->max_read_len == 0 ?
+	     FIELD_GET(I3C_SMAXLIMITS_MAXRD_MASK, I3C_SMAXLIMITS_MAXRD_MASK) : func->max_read_len;
+	rm = max_t(u32, val, 16);
+
+	val = FIELD_PREP(I3C_SMAXLIMITS_MAXRD_MASK, rm) | FIELD_PREP(I3C_SMAXLIMITS_MAXWR_MASK, wm);
+	writel_relaxed(val, svc->regs + I3C_SMAXLIMITS);
+
+	writel_relaxed(func->vendor_id, svc->regs + I3C_SVENDORID);
+	return 0;
+}
+
+static const struct i3c_target_ctrl_features *svc_i3c_get_features(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	if (!svc)
+		return NULL;
+
+	return &svc->features;
+}
+
+static void svc_i3c_queue_complete(struct svc_i3c_target *svc, struct i3c_request *complete)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&svc->cq_lock, flags);
+	list_add_tail(&complete->list, &svc->cq);
+	spin_unlock_irqrestore(&svc->cq_lock, flags);
+	queue_work(svc->workqueue, &svc->work);
+}
+
+static void svc_i3c_fill_txfifo(struct svc_i3c_target *svc)
+{
+	struct i3c_request *req, *complete = NULL;
+	unsigned long flags;
+	int val;
+
+	spin_lock_irqsave(&svc->txq_lock, flags);
+	while ((!!(req = list_first_entry_or_null(&svc->txq, struct i3c_request, list))) &&
+	       !((readl_relaxed(svc->regs + I3C_SDATACTRL) & I3C_SDATACTRL_TXFULL_MASK))) {
+		while (!(readl_relaxed(svc->regs + I3C_SDATACTRL)
+					& I3C_SDATACTRL_TXFULL_MASK)) {
+			val = *(u8 *)(req->buf + req->actual);
+
+			if (req->actual + 1 == req->length)
+				writel_relaxed(val, svc->regs + I3C_SWDATAE);
+			else
+				writel_relaxed(val, svc->regs + I3C_SWDATAB);
+
+			req->actual++;
+
+			if (req->actual == req->length) {
+				list_del(&req->list);
+				complete = req;
+				spin_unlock_irqrestore(&svc->txq_lock, flags);
+
+				svc_i3c_queue_complete(svc, complete);
+				return;
+
+				spin_lock_irqsave(&svc->txq_lock, flags);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&svc->txq_lock, flags);
+}
+
+static int svc_i3c_target_queue(struct i3c_request *req, gfp_t gfp)
+{
+	struct svc_i3c_target *svc;
+	struct list_head *q;
+	unsigned long flags;
+	spinlock_t *lk;
+
+	svc = dev_get_drvdata(&req->ctrl->dev);
+	if (!svc)
+		return -EINVAL;
+
+	if (req->tx) {
+		q = &svc->txq;
+		lk = &svc->txq_lock;
+	} else {
+		q = &svc->rxq;
+		lk = &svc->rxq_lock;
+	}
+
+	spin_lock_irqsave(lk, flags);
+	list_add_tail(&req->list, q);
+	spin_unlock_irqrestore(lk, flags);
+
+	if (req->tx)
+		svc_i3c_fill_txfifo(svc);
+
+	if (req->tx)
+		writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTSET);
+	else
+		writel_relaxed(I3C_SINT_RXPEND, svc->regs + I3C_SINTSET);
+
+	return 0;
+}
+
+static int svc_i3c_dequeue(struct i3c_request *req)
+{
+	struct svc_i3c_target *svc;
+	unsigned long flags;
+	spinlock_t *lk;
+
+	svc = dev_get_drvdata(&req->ctrl->dev);
+	if (!svc)
+		return -EINVAL;
+
+	if (req->tx)
+		lk = &svc->txq_lock;
+	else
+		lk = &svc->rxq_lock;
+
+	spin_lock_irqsave(lk, flags);
+	list_del(&req->list);
+	spin_unlock_irqrestore(lk, flags);
+
+	return 0;
+}
+
+static void svc_i3c_target_fifo_flush(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_target *svc;
+	u32 val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	val = readl_relaxed(svc->regs + I3C_SDATACTRL);
+
+	val |= tx ? I3C_SDATACTRL_FLUSHTB_MASK : I3C_SDATACTRL_FLUSHFB_MASK;
+
+	writel_relaxed(val, svc->regs + I3C_SDATACTRL);
+}
+
+static int
+svc_i3c_target_raise_ibi(struct i3c_target_ctrl *ctrl, void *p, u8 size)
+{
+	struct svc_i3c_target *svc;
+	unsigned long flags;
+	u8 *ibidata = p;
+	u32 ext1 = 0, ext2 = 0;
+	u32 val;
+	int ret;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	if (size && !p)
+		return -EINVAL;
+
+	if (size > 8)
+		return -EINVAL;
+
+	val = readl_relaxed(svc->regs + I3C_SSTATUS);
+	if (val & I3C_SSTATUS_IBIDIS_MASK)
+		return -EINVAL;
+
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 10000);
+	if (ret) {
+		dev_err(&ctrl->dev, "Timeout when polling for NO event pending");
+		val &= ~I3C_SCTRL_EVENT_MASK;
+		writel_relaxed(val, svc->regs + I3C_SCTRL);
+		return -ENAVAIL;
+	}
+
+	spin_lock_irqsave(&svc->ctrl_lock, flags);
+
+	val = readl_relaxed(svc->regs + I3C_SCTRL);
+
+	val &= ~I3C_SCTRL_EVENT_MASK | I3C_SCTRL_IBIDATA_MASK;
+	val |= FIELD_PREP(I3C_SCTRL_EVENT_MASK, I3C_SCTRL_EVENT_IBI);
+
+	if (size) {
+		val |= FIELD_PREP(I3C_SCTRL_IBIDATA_MASK, *ibidata);
+		ibidata++;
+
+		if (size > 1)
+			val |= I3C_SCTRL_EXTDATA_MASK;
+
+		size--;
+		if (size > 0) {
+			ext1 |= (size + 2);
+			ext1 |= (*ibidata++) << I3C_IBIEXT1_EXT1_SHIFT;
+			size--;
+		}
+
+		if (size > 0) {
+			ext1 |= (*ibidata++) << I3C_IBIEXT1_EXT2_SHIFT;
+			size--;
+		}
+
+		if (size > 0) {
+			ext1 |= (*ibidata++) << I3C_IBIEXT1_EXT3_SHIFT;
+			size--;
+		}
+
+		writel_relaxed(ext1, svc->regs + I3C_IBIEXT1);
+
+		if (size > 0) {
+			ext2 |= (*ibidata++) << I3C_IBIEXT2_EXT4_SHIFT;
+			size--;
+		}
+
+		if (size > 0) {
+			ext2 |= (*ibidata++) << I3C_IBIEXT2_EXT5_SHIFT;
+			size--;
+		}
+
+		if (size > 0) {
+			ext2 |= (*ibidata++) << I3C_IBIEXT2_EXT6_SHIFT;
+			size--;
+		}
+
+		if (size > 0) {
+			ext2 |= (*ibidata++) << I3C_IBIEXT2_EXT7_SHIFT;
+			size--;
+		}
+
+		writeb_relaxed(ext2, svc->regs + I3C_IBIEXT2);
+	}
+
+	/* Issue IBI*/
+	writel_relaxed(val, svc->regs + I3C_SCTRL);
+	spin_unlock_irqrestore(&svc->ctrl_lock, flags);
+
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 1000000);
+	if (ret) {
+		dev_err(&ctrl->dev, "Timeout when polling for IBI finish\n");
+
+		//clear event to above hang bus
+		spin_lock_irqsave(&svc->ctrl_lock, flags);
+		val = readl_relaxed(svc->regs + I3C_SCTRL);
+		val &= ~I3C_SCTRL_EVENT_MASK;
+		writel_relaxed(val, svc->regs + I3C_SCTRL);
+		spin_unlock_irqrestore(&svc->ctrl_lock, flags);
+
+		return -ENAVAIL;
+	}
+
+	return 0;
+}
+
+static void svc_i3c_target_complete(struct work_struct *work)
+{
+	struct svc_i3c_target *svc = container_of(work, struct svc_i3c_target, work);
+	struct i3c_request *req;
+	unsigned long flags;
+
+	spin_lock_irqsave(&svc->cq_lock, flags);
+	while (!list_empty(&svc->cq)) {
+		req = list_first_entry(&svc->cq, struct i3c_request, list);
+		list_del(&req->list);
+		spin_unlock_irqrestore(&svc->cq_lock, flags);
+		req->complete(req);
+
+		spin_lock_irqsave(&svc->cq_lock, flags);
+	}
+	spin_unlock_irqrestore(&svc->cq_lock, flags);
+}
+
+static irqreturn_t svc_i3c_target_irq_handler(int irq, void *dev_id)
+{
+	struct i3c_request *req, *complete = NULL;
+	struct svc_i3c_target *svc = dev_id;
+	unsigned long flags;
+	u32 statusFlags;
+
+	statusFlags = readl(svc->regs + I3C_SSTATUS);
+	writel(statusFlags, svc->regs + I3C_SSTATUS);
+
+	if (statusFlags & I3C_SSTATUS_DACHG_MASK)
+		complete_all(&svc->dacomplete);
+
+	if (statusFlags & I3C_SSTATUS_RX_PEND_MASK) {
+		spin_lock_irqsave(&svc->rxq_lock, flags);
+		req = list_first_entry_or_null(&svc->rxq, struct i3c_request, list);
+
+		if (!req) {
+			writel_relaxed(I3C_SINT_RXPEND, svc->regs + I3C_SINTCLR);
+		} else {
+			while (!(readl_relaxed(svc->regs + I3C_SDATACTRL) &
+					       I3C_SDATACTRL_RXEMPTY_MASK)) {
+				*(u8 *)(req->buf + req->actual) =
+							readl_relaxed(svc->regs + I3C_SRDATAB);
+				req->actual++;
+
+				if (req->actual == req->length) {
+					complete = req;
+					list_del(&req->list);
+					break;
+				}
+			}
+
+			if (req->actual != req->length && (statusFlags & I3C_SSTATUS_STOP_MASK)) {
+				complete = req;
+				list_del(&req->list);
+			}
+		}
+		spin_unlock_irqrestore(&svc->rxq_lock, flags);
+
+		if (complete) {
+			spin_lock_irqsave(&svc->cq_lock, flags);
+			list_add_tail(&complete->list, &svc->cq);
+			spin_unlock_irqrestore(&svc->cq_lock, flags);
+			queue_work(svc->workqueue, &svc->work);
+			complete = NULL;
+		}
+	}
+
+	if (statusFlags & I3C_SSTATUS_TXNOTFULL_MASK) {
+		svc_i3c_fill_txfifo(svc);
+		spin_lock_irqsave(&svc->txq_lock, flags);
+		if (list_empty(&svc->txq))
+			writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTCLR);
+		spin_unlock_irqrestore(&svc->txq_lock, flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void svc_i3c_cancel_all_reqs(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_target *svc;
+	struct i3c_request *req;
+	struct list_head *q;
+	unsigned long flags;
+	spinlock_t *lk;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+	if (!svc)
+		return;
+
+	if (tx) {
+		q = &svc->txq;
+		lk = &svc->txq_lock;
+	} else {
+		q = &svc->rxq;
+		lk = &svc->rxq_lock;
+	}
+
+	spin_lock_irqsave(lk, flags);
+	while (!list_empty(q)) {
+		req = list_first_entry(q, struct i3c_request, list);
+		list_del(&req->list);
+		spin_unlock_irqrestore(lk, flags);
+
+		req->status = I3C_REQUEST_CANCEL;
+		req->complete(req);
+		spin_lock_irqsave(lk, flags);
+	}
+	spin_unlock_irqrestore(lk, flags);
+}
+
+static int svc_i3c_hotjoin(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+	int ret;
+	u32 val;
+	u32 cfg;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+	if (!svc)
+		return -EINVAL;
+
+	reinit_completion(&svc->dacomplete);
+
+	val = readl_relaxed(svc->regs + I3C_SSTATUS);
+	if (val & I3C_SSTATUS_HJDIS_MASK) {
+		dev_err(&ctrl->dev, "Hotjoin disabled by i3c master\n");
+		return -EINVAL;
+	}
+
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 10000);
+	if (ret) {
+		dev_err(&ctrl->dev, "Timeout when polling for none event pending");
+		return -ENAVAIL;
+	}
+
+	cfg = readl_relaxed(svc->regs + I3C_SCONFIG);
+	cfg |= I3C_SCONFIG_OFFLINE_MASK;
+	writel_relaxed(cfg, svc->regs + I3C_SCONFIG);
+
+	val &= ~(I3C_SCTRL_EVENT_MASK | I3C_SCTRL_IBIDATA_MASK);
+	val |= FIELD_PREP(I3C_SCTRL_EVENT_MASK, I3C_SCTRL_EVENT_HOTJOIN);
+	/* Issue hotjoin*/
+	writel_relaxed(val, svc->regs + I3C_SCTRL);
+
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 100000);
+	if (ret) {
+		val &= ~FIELD_PREP(I3C_SCTRL_EVENT_MASK, I3C_SCTRL_EVENT_MASK);
+		writel_relaxed(val, svc->regs + I3C_SCTRL);
+		dev_err(&ctrl->dev, "Timeout when polling for HOTJOIN finish\n");
+		return -EINVAL;
+	}
+
+	val = readl_relaxed(svc->regs + I3C_SSTATUS);
+	val = FIELD_GET(I3C_SSTATUS_EVDET_MASK, val);
+	if (val != I3C_SSTATUS_EVDET_ACKED) {
+		dev_err(&ctrl->dev, "Master NACKED hotjoin request\n");
+		return -EINVAL;
+	}
+
+	writel_relaxed(I3C_SINT_DACHG, svc->regs + I3C_SINTSET);
+	ret = wait_for_completion_timeout(&svc->dacomplete, msecs_to_jiffies(100));
+	writel_relaxed(I3C_SINT_DACHG, svc->regs + I3C_SINTCLR);
+	if (!ret) {
+		dev_err(&ctrl->dev, "wait for da assignment timeout\n");
+		return -EIO;
+	}
+
+	val = readl_relaxed(svc->regs + I3C_SMAPCTRL0);
+	val = FIELD_GET(I3C_SMAPCTRL0_DA_MASK, val);
+	dev_info(&ctrl->dev, "Get dynamtic address 0x%x\n", val);
+	return 0;
+}
+
+static int svc_i3c_set_status_format1(struct i3c_target_ctrl *ctrl, u16 status)
+{
+	struct svc_i3c_target *svc;
+	unsigned long flags;
+	u32 val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	spin_lock_irqsave(&svc->ctrl_lock, flags);
+	val = readl_relaxed(svc->regs + I3C_SCTRL);
+	val &= 0xFFFF;
+	val |= status << 16;
+	writel_relaxed(val, svc->regs + I3C_SCTRL);
+	spin_unlock_irqrestore(&svc->ctrl_lock, flags);
+
+	return 0;
+}
+
+static u16 svc_i3c_get_status_format1(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	return readl_relaxed(svc->regs + I3C_SCTRL) >> 16;
+}
+
+static u8 svc_i3c_get_addr(struct i3c_target_ctrl *ctrl)
+{
+	struct svc_i3c_target *svc;
+	int val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	val = readl_relaxed(svc->regs + I3C_SMAPCTRL0);
+
+	if (val & I3C_SMAPCTRL0_ENA_MASK)
+		return FIELD_GET(I3C_SMAPCTRL0_DA_MASK, val);
+
+	return 0;
+}
+
+static int svc_i3c_fifo_status(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_target *svc;
+	int val;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	val = readl_relaxed(svc->regs + I3C_SDATACTRL);
+
+	if (tx)
+		return FIELD_GET(I3C_SDATACTRL_TXCOUNT_MASK, val);
+	else
+		return FIELD_GET(I3C_SDATACTRL_RXCOUNT_MASK, val);
+}
+
+static struct i3c_target_ctrl_ops svc_i3c_target_ops = {
+	.set_config = svc_i3c_target_set_config,
+	.enable = svc_i3c_target_enable,
+	.disable = svc_i3c_target_disable,
+	.queue = svc_i3c_target_queue,
+	.dequeue = svc_i3c_dequeue,
+	.raise_ibi = svc_i3c_target_raise_ibi,
+	.fifo_flush = svc_i3c_target_fifo_flush,
+	.cancel_all_reqs = svc_i3c_cancel_all_reqs,
+	.get_features = svc_i3c_get_features,
+	.hotjoin = svc_i3c_hotjoin,
+	.fifo_status = svc_i3c_fifo_status,
+	.set_status_format1 = svc_i3c_set_status_format1,
+	.get_status_format1 = svc_i3c_get_status_format1,
+	.get_addr = svc_i3c_get_addr,
+};
+
+int svc_i3c_target_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i3c_target_ctrl *target;
+	struct svc_i3c_target *svc;
+	int ret;
+	u32 val;
+
+	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
+	if (!svc)
+		return -ENOMEM;
+
+	svc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(svc->regs))
+		return PTR_ERR(svc->regs);
+
+	svc->clks[PCLK].id = "pclk";
+	svc->clks[FCLK].id = "fast_clk";
+	svc->clks[SCLK].id = "slow_clk";
+
+	ret = devm_clk_bulk_get(dev, MAXCLK, svc->clks);
+	if (ret < 0) {
+		dev_err(dev, "fail get clks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(MAXCLK, svc->clks);
+	if (ret < 0) {
+		dev_err(dev, "fail enable clks: %d\n", ret);
+		return ret;
+	}
+
+	svc->irq = platform_get_irq(pdev, 0);
+	if (svc->irq < 0)
+		return svc->irq;
+
+	INIT_LIST_HEAD(&svc->txq);
+	INIT_LIST_HEAD(&svc->rxq);
+	INIT_LIST_HEAD(&svc->cq);
+	spin_lock_init(&svc->txq_lock);
+	spin_lock_init(&svc->rxq_lock);
+	spin_lock_init(&svc->cq_lock);
+	spin_lock_init(&svc->ctrl_lock);
+
+	init_completion(&svc->dacomplete);
+
+	INIT_WORK(&svc->work, svc_i3c_target_complete);
+	svc->workqueue = alloc_workqueue("%s-cq", 0, 0, dev_name(dev));
+	if (!svc->workqueue)
+		return -ENOMEM;
+
+	/* Disable all IRQ */
+	writel_relaxed(0xFFFFFFFF, svc->regs + I3C_SINTCLR);
+
+	val = readl_relaxed(svc->regs + I3C_SCAPABILITIES);
+	svc->features.tx_fifo_sz  = FIELD_GET(I3C_SCAPABILITIES_FIFOTX_MASK, val);
+	svc->features.tx_fifo_sz = 2 << svc->features.tx_fifo_sz;
+
+	svc->features.rx_fifo_sz = FIELD_GET(I3C_SCAPABILITIES_FIFORX_MASK, val);
+	svc->features.rx_fifo_sz = 2 << svc->features.rx_fifo_sz;
+
+	ret = devm_request_irq(dev, svc->irq, svc_i3c_target_irq_handler, 0, "svc-i3c-irq", svc);
+	if (ret)
+		return -ENOENT;
+
+	target = devm_i3c_target_ctrl_create(dev, &svc_i3c_target_ops);
+	if (!target)
+		return -ENOMEM;
+
+	dev_set_drvdata(&target->dev, svc);
+
+	return 0;
+}
+
+void svc_i3c_target_remove(struct platform_device *pdev)
+{
+}
diff --git a/drivers/i3c/master/svc-i3c.h b/drivers/i3c/master/svc-i3c.h
index 0bd1f0112a071..634837f146b2e 100644
--- a/drivers/i3c/master/svc-i3c.h
+++ b/drivers/i3c/master/svc-i3c.h
@@ -8,4 +8,7 @@ void svc_i3c_master_remove(struct platform_device *pdev);
 int svc_i3c_master_runtime_suspend(struct device *dev);
 int svc_i3c_master_runtime_resume(struct device *dev);
 
+int svc_i3c_target_probe(struct platform_device *pdev);
+void svc_i3c_target_remove(struct platform_device *pdev);
+
 #endif
\ No newline at end of file
-- 
2.34.1


