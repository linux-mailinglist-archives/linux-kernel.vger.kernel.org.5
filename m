Return-Path: <linux-kernel+bounces-43437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007228413DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842941F24489
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330176053;
	Mon, 29 Jan 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VF0fBQWI"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119B15956E;
	Mon, 29 Jan 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558047; cv=fail; b=g/IFD2YugtF6Sdvy/j8K9fJ7X8NZ2k+GBX4mMi0ttJmLLEJTCFqXqNsd95UCs4pK+vhnVqXLDagTjMqGNZqYRohVS5OJ7TsLVJC9S2McDyZMbBnLQB33MjI35Lp7DgzoUR0fNqdpDZDHI1g+1PJrLMw72A0BnmdL0kzEG6GI7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558047; c=relaxed/simple;
	bh=pSHn5pe2T7CNk30XYkpTMpxSnkJGjZfI89cLYBZwKmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFxTvB2fDeoygMXTY5MxFJGxDakE8uWJmVDxcywoLuqRWZdhGY4ELmApFA2v2gMPg3z07lgpDU/sHDkouhcqKHAX3g7AOhA5+ySTNwRjbwCm61AgAt89/L9STXu9CujAyJ4WaTZvVurUuKb9xMqlAgdPHODseOeihISFfjJAOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VF0fBQWI; arc=fail smtp.client-ip=40.107.13.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGs8yVgUAqDanHLZusPJQqhcQc5MXoaL+vEKITOfSWiFdxqmWTPuM2O3wtYopcbNZjZvI9F918IoBvuz/r/2vzkKOAAduRzPvEQgNpNu2tr/8SoOXGBqXYzdn2sJImjlrTJD3ohZwbUktagJB8MVB1oS3KJpBMpg+d0UQIFoKe5chIphdc/+r6ntD4ouSxuJN0/Qz3PMf1WPhKeb2RsH1yueDPejMFQVxu33Mlg4x0hYK/et0B9mMzC0VBC7e1pGiu7/i0YgcCJ6tBB492Ejv7v4hbG/CK6Hu1iLzHaSmM5zm2Sv/5sktAc8L4GiRYMjXvJjf09MERBy49OOJb14Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66HiLs3b1iMU04QWqs91Xe7r0swHyhSiPnguRpkkI2U=;
 b=K89DQRmzsgYIIAQ7Dts1hKZVmbexahbr49gCbcu9GD168cB2dGtGIepoHO+gCFKMR0LP8Y4RTYAfDq25YvOiUKF/TWbM6PoWDVnhQ18+9b/yFSI52InqKSSJS5sKb/9WXGRGzyHxgG7RpZzN/spL65lFH0U4ZKtUBzT9HN/99XcKJyLb6v1++oEBoG40jJw33lNRpNAslFlqQjILSBzF4A4PujGx2WxdUOlbjC/HEVruoCXHG0DFOPwHsZ5/XjdUEBAazQjG2MJSqNaVnXA+nc03umXv+goR9LG8ZMd1x+7RB042Q2udZVRFToeIMIvkvsb2nqL0kGoXhz0Q2rS9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66HiLs3b1iMU04QWqs91Xe7r0swHyhSiPnguRpkkI2U=;
 b=VF0fBQWIXcNnLPiE8waM64WyMjVaZYQ7BmGV0ltYIYwKlUEwMvupya9EuMmnYnVB9+HwYv7SBxol2kuPflRSSDgdd5nAkHMunclT9nScbhn9fwR8xylVRFyc+9wO05xw1Ayw9uof+rRhSZDDuQtJwd7IZt+ODPrueT2ZPfdEanE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:54:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:54:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
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
Subject: [PATCH v5 5/8] i3c: target: add svc target controller support
Date: Mon, 29 Jan 2024 14:53:18 -0500
Message-Id: <20240129195321.229867-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9258ac71-610b-40e1-0ae9-08dc21040990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xOxWid4/++x1TEgSLkQqGKRhVa+G8vBubzKteJ+atl5Jo7KrFOEJXfS/L1WUgmw9/kVHcJ3pD1bN6iB334GfnYRZt1gndQ/iWOrTWpBFv/Nmt7kWjzntraSANtsSH9cJeETxSc5WnKheW+0pezTbsGMG+vWuaurVnXjmdqyYOh2RKBKAt9Ym2LGbBZSPSCpXCbTv3IYWdQ8aoM8JoNLpm4Uc5YcyX1YUo4mWxry2XuuQTxAAX+faklmxpEhSBGpHvX8KSxW12r8h6WlscD/7R+KPDv3BgGi43/XDCa+iTiNJlSftgwGuCVeREbumGjyFvSHX3wUqPZSqRadC3LrpPAjt4otA/Z5JRPO1gjFrcKmHV2GQx4EQ/70o3vCJy8MokufKAk1Ec0S3buk08mWcsCocxJ4ibHkYuEgRvyOJEeZRVH/XUQanBuJIryG+abyYV9Tl15GenlPAZaAP7YF3mVG6u0nsoTZcAPdIg8NDJP+y2T3khFvYktItubtTRlWn5lNGvVx8R4kXLdJW8d+Mnp7YRpYbHqvCTll7cHLsvOTK/dwRJ4LX+2M0+ujJUgFSpIVAQ5kPQciqATXFFepyhuxRRdJEb28NppJhfN2l8S84beOwKRD4tEaGtu8O6rd6uKMAB6gCA1jeDYlb9RTr7zkQD35ZglfhTEGsXfyYHgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(30864003)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+wSCWdcjPQ03zakYuEaWxzFOVSgyE4AlAA8YGT/BUCcyDx00OfXX5+D3YiC?=
 =?us-ascii?Q?Ps1rZrkihFi1KU0K+k/cvFK2xmMhwZD1LFxZSUg8YSozznBZoP8t1H36sOWn?=
 =?us-ascii?Q?ET4RT2bBOGH0q1IAZDr6334exlU8DMd4mmzLV19qOCC/e/Ob+T9hIt0TDASX?=
 =?us-ascii?Q?G6lM2WbZNYbYCYCe7WxPaS/LTBczeCt79bHOy9oXCh/mvxx92JlJqu8X/H8O?=
 =?us-ascii?Q?6lM1poDMs1rD2cizzvqWe0B7flIt+hUDmRRF2tFCuvPJ0ligIQlqD5DdYjUg?=
 =?us-ascii?Q?uzavpzofP7J+HcO60+mPS3DlIGyN9ChW9MBxnxCwJI36J8MGd0kb9Pj2hJ6x?=
 =?us-ascii?Q?vnBhplXsQJE4BCgOcHHK/wtY04MonqYT3freHPuRgZUfABtCy20BJqhVvHFS?=
 =?us-ascii?Q?rt0sOm1E5db41zO3KN6hZ9x3TW5Ld0OEOh3ojaytvvb9RhJwEYMapFURaAwn?=
 =?us-ascii?Q?gy+8bILxvo1u7VnyktVu/oleZjBnlDejmQpV/3+diYijhiAZrKMxPaHIcJy2?=
 =?us-ascii?Q?2seLNtzqrvBYTS6bzysYHi/0Y9V7t26aI/UYtO7Cq2TI4u1gVz0eeiG8Ts80?=
 =?us-ascii?Q?yDBNczdoLURJkCcFRFH47Rx13BK6+6TVrjQcM/JfnFl0coKmSjowCmmNiFNa?=
 =?us-ascii?Q?YqlwnTPQ+k+WAiBKX0Q88Bw35h8EjNLwxKkZHs4WDF9BQtgS2vH6sxnYFUiF?=
 =?us-ascii?Q?upmRi8J3a9RfZd8JmSWcoj+fgmevg0X15RxjyXsXiUqjYsXBZ8DHiWQa4h2i?=
 =?us-ascii?Q?OLJ3FvlcR+zUnUYQ1uZANReQ1lYwePirWqfm+8ssaAaMup8VmoaIj/x1GqQb?=
 =?us-ascii?Q?twmfyJrXpsfGCp6qe8fzThPIR3q210w57EV7D7JQ2iHVfG/c5ETc0QvOulSz?=
 =?us-ascii?Q?eNfwMxHcRmdhgvOTkXexebm8rkxihCUTHZ5wu9/nrxRLeH3V+cHYR6x1BckF?=
 =?us-ascii?Q?nYaLTxVaEwowtVtbLunXajZ9H9eX4k1cIyNlAbxCPrI5TxlPY6zWOzliIcM6?=
 =?us-ascii?Q?NLAiaZE/GM2UDT4DTB4brcSQEz5wHjFIS4GIKUtsXjtjinWRsIIO8zf5uEMk?=
 =?us-ascii?Q?qGJHAnOGetKzL2CcM4fFHjvK2S3HH1CAGQcV0iXzdjJVPgrfE8Z0Erk/IYuf?=
 =?us-ascii?Q?8GzwyXS3+T6qwP+EqgfbtolREGevTf+djnyMh6VgVaEa3MsV5hWyTAP1ksQq?=
 =?us-ascii?Q?x4krwAvTqUYcIoYuKSPCZtkbSAbkVJVOrMuqDJsSsEhRJNAmy0yJOYHPHCtA?=
 =?us-ascii?Q?yB5wwpjL9eoAXWwwWcoSfJOsjoDXt68yYPckKfZ7AaYijhL9gcWVOKuKop8Z?=
 =?us-ascii?Q?JXbnWy31Z7ISonSsP6A6IhDZwjoQNqe4oSTZ96TIqx7ESFhQ256hng6faCk3?=
 =?us-ascii?Q?pKm8E70dyL6+qnXlhb1o3hfZtX6JuHkIpPrcvguVZMABseg33SdZUNpz5/4W?=
 =?us-ascii?Q?9z400UpncsAQWaZb+WRTNN/r7cIrafhWzJjM6Z20eD6BOYE01VRKPzJN7jCK?=
 =?us-ascii?Q?q9Dbc5kgc0ypN3FbcNJ2a6paFGLGpQ4JVrzaKFWb/tnI23QB9xvpXv834Z2v?=
 =?us-ascii?Q?N3gvtAC5lINGjr8ySmHvsfWZcrs+Ram7eWC7UTG1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9258ac71-610b-40e1-0ae9-08dc21040990
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:54:00.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JieXFVX5ebTi8wk2uuOGyV+aeqoJTbMl/KY8Y6fuCKDbK61vbLNwGds2rycQubZDb2zzoUTZczgOj4MGkNkPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

Add Silvaco I3C target controller support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - fix build warning

 drivers/i3c/master/Makefile         |   2 +-
 drivers/i3c/master/svc-i3c-main.c   |  35 +-
 drivers/i3c/master/svc-i3c-target.c | 776 ++++++++++++++++++++++++++++
 drivers/i3c/master/svc-i3c.h        |   3 +
 4 files changed, 811 insertions(+), 5 deletions(-)
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
index 6be6a576cdf7a..e34b128ab274a 100644
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
index 26a3fbcdb6524..122663a791c78 100644
--- a/drivers/i3c/master/svc-i3c.h
+++ b/drivers/i3c/master/svc-i3c.h
@@ -8,5 +8,8 @@ void svc_i3c_master_remove(struct platform_device *pdev);
 int svc_i3c_master_runtime_suspend(struct device *dev);
 int svc_i3c_master_runtime_resume(struct device *dev);
 
+int svc_i3c_target_probe(struct platform_device *pdev);
+void svc_i3c_target_remove(struct platform_device *pdev);
+
 #endif
 
-- 
2.34.1


