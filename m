Return-Path: <linux-kernel+bounces-97291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFE87685B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733561C21211
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8256471;
	Fri,  8 Mar 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DkuqvZTD"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E262D781;
	Fri,  8 Mar 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915172; cv=fail; b=AdEqi1H3QeUdF22cDOJ8IN6uqFGh2U1+sPYaSxvGCK3yGxqIIPJxm/uVVh4grbXuigMukXfHeE1gbnQpMy0fVmRnmrDEfzG8vK1pmiX7DYBf+3Yx+3vyf85Ahh+wX03smZQiwk8q/B1z7Ii8rp4DIJgLu16ppgiLr0rX9qnnjMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915172; c=relaxed/simple;
	bh=enUl0fueBjCYmp1QtDsZ23W/EmLo5gYe2pFy/aJUSwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VviNQcC+WOZ0AlWFTEtDT7Zy24Tk8akDx8LPfRgUXt5BGe2c0wX898++CzwZGw+mNPW4IML+eeRZYX23bq30B51uC2HL8MRNdZZss/4WbG8YzCGJMtjEr7tDi/Y7253+Bj997L7ruuKGABKQM15L7lFUYgjv3haO4ZJJ9hXlVOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DkuqvZTD; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAkSR9+itlGYFWWArrqaBKSQK2CaNJvJ/ff784y/7FAs2XOI+wPAGZxWI4jhNYByNwD3Kt2BgpVki8+2hcL53caJgAaIKaW/lZPCRP4Tn/kQSM5hHY5fnBfc8oX/vy05MF9IIddxcvOIMuboWJ7Jvdlmg9C9Nu0e7lp/zleesHvi2gsjRC67qDdBitUzwknMA8g7TR9cyup4RZ0qHzuXsAukSsvHeyGhQhkqAsz0bLCgR3FEXzVGLztzFAQz195Yyovrq8UFEPSk9yj/Wu6ow+gyMoLSsfCtNRermdWMLWKwX8FIR6Msl6A12b+xUT0iOPrBSnYiAWg8MpSQEHCFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUsx9H6wwWO15vYSn8ZN40Q0oT+By9wkYJ1RKkz7F5s=;
 b=h7ttnPBk6GehkSqdbTeMVKLvr3I1CTYZBOkPFfHQ6oL9EY7hXqIPbXzf0vKFd7yHRZootYiqUfUDssstZbPJWMk3UF0L2UdSU0ViqLZ4RiXesAawfx/yt1f7f5TwB3awghAz+NH9055P6A9v+xMVDcM4tJKGNCLSiVnBfsiXLzRmE4GFLLIiKgRV7gSE3Wqet//RDHlGDReljxqhsa1qXfHuopE90Hs1ntyvoqUcT5p4lVtslmh4qvBgrW5WxlgOiSDR3gERTqjJQCSjCSf5tNfdit4JW0RRNavhGzV29p2+izVwQBDsdcaTR1ivXsfOFnDEdUH+ldS3Q4f+69WjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUsx9H6wwWO15vYSn8ZN40Q0oT+By9wkYJ1RKkz7F5s=;
 b=DkuqvZTDl7B5mwPK6E4B3Cha/ff/6P7M5cdUZdIv91F6Pf0dfwxHBtNX51iQSj5CqTD2ci+46mCGkgQ54zkEDPpkbvRbru3plmae2z0BfEPchkIEjdW9lUMepPwsrl+NnxgZW/jvg4E66Euy+d8+HBVVFlJNN7VHL7eS5RXBxPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:26:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
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
Subject: [PATCH v9 1/8] i3c: add target mode support
Date: Fri,  8 Mar 2024 11:25:11 -0500
Message-Id: <20240308162518.1615468-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308162518.1615468-1-Frank.Li@nxp.com>
References: <20240308162518.1615468-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d65994-5a77-4303-2bfa-08dc3f8c72f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vprJj7XwP/kd23hXyazBs+IQkNZ4FWbBr8mq5MDyfVs1Avrs/ajXFFDSUXfmr0ZR5LJXHVzP9ueW5uGlBHXXA1VClAqtcuPU2X9G0d2un4vFysNCXPoDajsceENW8DYy3YoXlBwOUnaMaJA+AKrK/0K0CsGdq1/WfvD95bga1qviDYDkNvEia4xWy7kd8miYukJRqKm5KtL7gNxtUuys7Losb+IPJZ8mMgZsZdFhgU2r52PTxqDHJwv0xljmFh7ILu+E0xecNjsjp/JE/uMxAszdIWGXNQJELSIMCEytJhNmH/2qZvtyWFuPsFuADf2ISoo6rc/YOVm6f4K67c5rv+p7ugwt021qHKdy+ZLmBFk9ubtahbxebdaL6lK2gxDiSaohRxa/YvUkIY9n0YPT030doB2XP1TjdmeQYeFKylempX7ecN2hN8gXs4e8G19iejjvhmMaj6/Sh2PJZ0g2uolpS4cgTPwq2dTvgRf/T82Y2mqpDxnTKgHWTM0IvRXBewZ4lX9gagarGiYFhdh9jwT0kw8gaWr4gv3xwBfxeknqcDdwN4oyoyL/q8HYwbUtAE8w4BhbYGMCJF+7cXaYFO51ece1ciyPILDY5dhtZaIqJRiy9FmSy3h5NC1h00dbWPqDDiOV9a8hQafN/xfDD9M25NXz6WnqNs9uFw4ds+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lcoWQfEXhY0c+8r+kkooYG0wZmDhhv1FpG2U7U78HenIQML6jh9z5LI55tFi?=
 =?us-ascii?Q?i9bUWTZqhX88m370b+XbYOz0ISdkAk14IKVca2o7ja7mGJBvBh3roUdEYDcY?=
 =?us-ascii?Q?zBiE6qrx15lhjZXFIbdUptoEo9EXLdpzdedBPyMpYU8VZWnUoB2qWTvr8Wtz?=
 =?us-ascii?Q?W0o69kr/vNoe11tX2vvIYQVKdDxJDsu/uql9JpaoP6hUCcj6RF3ZWPPy/XqE?=
 =?us-ascii?Q?saZ4ImOY6NHVXBSBYFP+yYcFyMvQdwVmGzR5ujltrhxz6AkTJCAecOY/+ImK?=
 =?us-ascii?Q?FjRAelJc7OY1RKhi9yuMYJtYgaqmdA5ZEEHo5qsYHB+CKir88cLPGJ8vqk/B?=
 =?us-ascii?Q?/JsWXzR6h+VhRY9J993WvetgHx9CsCNABegiqtJt3PvLpFQh8sX09BaN4Qxj?=
 =?us-ascii?Q?i3OhUY4eZx/IJFPy/evTY1nU9AtA4LEWzZBU03Fx/4ulER8xs8hiY+JldgvC?=
 =?us-ascii?Q?S6Og+E+o2Sb+7NHirv0gufYh4tfpbjDJuDFXMYQ1dY9PN2NDJIwVNPjHZJCr?=
 =?us-ascii?Q?g45H8AOthEoJNHT+aO74WwjnTCTDdhHLZk3K/WPmmE1BJIQCTAKwlVcj9bp1?=
 =?us-ascii?Q?QYZb4HybKWyM0OPZ5bi+NYm9gmUwBpCEHJAyhwNIGcv2BNNUwNMMZlmgb9Fd?=
 =?us-ascii?Q?NrcyUhjlAeWOkd+uZqDv7E+QQRzcUGZ+JjeT2tTghfI2KdXNchylNIgYfN4W?=
 =?us-ascii?Q?+7eMwfBtE2t4Y2Ahe9quO94FrZN4ODOLIBakyr3xDe1VC+vk7Ne1L6USleQv?=
 =?us-ascii?Q?0QDO+M88LRsfXhopnaWi1jPIcUTC4YGV9vgss1XGpG3lXkBVbp2+8E38lLI4?=
 =?us-ascii?Q?L6c2kUeKrSS1kXuehu1xsKinHtAuGZitlFREJmwtU4gII/Y3VU2qMBkLCpq7?=
 =?us-ascii?Q?op9Ha4c5otI000tIGvq13pEJGaqLrEE+L5OvxlRkSe0Zp1FYnovwvMMIMswI?=
 =?us-ascii?Q?mVrKAdCQxgQUvoW3porqbPZfVaVUVlaiqaJ3RZ9R3pnKpFtGeEmgsJlLAqdj?=
 =?us-ascii?Q?K8e3onxP3guSmAkEcZPhSQ+Cu3SU82+8FcN0avoFbcVmkm8LnEqaBeWcVAU6?=
 =?us-ascii?Q?Tdg/GaY5lLSKIGNxN3fD+gLW2qNl9yDFvn5q9Z7j3chewPNxcj4D1xa3N77x?=
 =?us-ascii?Q?tC55N0kfvgct1EFfH4SYEpV+3x/5q1OnwC0kCbDRBAxsmWNEOPZ6uqc0PdeZ?=
 =?us-ascii?Q?0ZUOqqlbCukAB91+r9g3YSzxJzr4OQYjXy8E+54uiIOsKbW0HEm4FhA/1yTO?=
 =?us-ascii?Q?Djxio7aCPADYm3OlhHzubbK/FowPu16w9U0HpWJ/LGyzcQ5m1Ae+CPu4ULuj?=
 =?us-ascii?Q?VW1ZykaNZ5HT4Q8JXPlp08b+9zG3P77HDSyyvPL++P7zvOzEbRX1dcoNW9CJ?=
 =?us-ascii?Q?KtMhkDIV7HyoC3B+EBITFJsVeyyyuuo/R+o8FKI5fCWkikPeGuRM68P++0BB?=
 =?us-ascii?Q?mCjjTMbOJ4Obi30yt8NaVbJFBnLPmx4JkdNIIhTSY4Z4WnIjtNpFxYk7sq21?=
 =?us-ascii?Q?VrOBgUJbc7HlhlRMrIGm3UhTdm5LvCVa+ZnrUI5g/Eelbo81jnouVVXBL2V3?=
 =?us-ascii?Q?xR0wEYW0BVHEzUELZZAVFDEF0AViTct/WXFZ1UFA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d65994-5a77-4303-2bfa-08dc3f8c72f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:26:03.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EK8MhyJgTAgqna3w8EuM+FvsfPRUrlF3SEMbwjy7epyD9fLJO8VY2IT0bw8/9E91mJT0MNUWxkrJszlclAtsOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

Introduce a new target core layer in order to support target functions in
linux kernel. This comprises the controller library and function library.
Controller library implements functions specific to an target controller
and function library implements functions specific to an target function.

Introduce a new configfs entry to configure the target function configuring
and bind the target function with target controller.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    -none
    
    Change from v7 to v8
    Added missed head files
    
    Change from v5 to v6
    - fixed build error when have not CONFIG_TARGET_CONFIGFS
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes: https://lore.kernel.org/oe-kbuild-all/202402030437.GdGCrKeK-lkp@intel.com/
    
    Chagne from v4 to v5
    - add include <linux/slab.h> to fix build error
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-lkp@intel.com/
    
    Chagne from v4 to v8
    - add include <linux/slab.h> to fix build error
    | Reported-by: kernel test robot <lkp@intel.com>
    | Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-lkp@intel.com/

 drivers/i3c/Kconfig        |  28 +-
 drivers/i3c/Makefile       |   2 +
 drivers/i3c/i3c-cfs.c      | 389 ++++++++++++++++++++++++++
 drivers/i3c/target.c       | 453 ++++++++++++++++++++++++++++++
 include/linux/i3c/target.h | 548 +++++++++++++++++++++++++++++++++++++
 5 files changed, 1419 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/target.c
 create mode 100644 include/linux/i3c/target.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a441506f61c..d59a7eb83d13a 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -10,7 +10,7 @@ menuconfig I3C
 	  support for high speed transfers and native interrupt support
 	  without the need for extra pins.
 
-	  The I3C protocol also standardizes the slave device types and is
+	  The I3C protocol also standardizes the target device types and is
 	  mainly designed to communicate with sensors.
 
 	  If you want I3C support, you should say Y here and also to the
@@ -22,3 +22,29 @@ menuconfig I3C
 if I3C
 source "drivers/i3c/master/Kconfig"
 endif # I3C
+
+config I3C_TARGET
+	bool "I3C Target Support"
+	help
+	  Support I3C Target Mode.
+
+	  Enable this configuration option to support configurable I3C target.
+	  This should be enabled if the platform has a I3C controller that can
+	  operate in target mode.
+
+	  Enabling this option will build the I3C target library, which includes
+	  target controller library and target function library.
+
+	  If in doubt, say "N" to disable target support.
+
+config I3C_TARGET_CONFIGFS
+	bool "I3C Target Configfs Support"
+	depends on I3C_TARGET
+	select CONFIGFS_FS
+	help
+	  Configfs entry for target function and controller.
+
+	  This will enable the configfs entry that can be used to configure
+	  the target function and used to bind the function with a target
+	  controller.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982efbc6d91..c275aeae8970c 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3C_TARGET)                += target.o
+obj-$(CONFIG_I3C_TARGET_CONFIGFS)       += i3c-cfs.o
 obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/i3c-cfs.c b/drivers/i3c/i3c-cfs.c
new file mode 100644
index 0000000000000..5178b978ebca7
--- /dev/null
+++ b/drivers/i3c/i3c-cfs.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Configfs to configure the I3C Slave
+ *
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/i3c/target.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(functions_mutex);
+static struct config_group *functions_group;
+static struct config_group *controllers_group;
+
+struct i3c_target_func_group {
+	struct config_group group;
+	struct i3c_target_func *func;
+};
+
+struct i3c_target_ctrl_group {
+	struct config_group group;
+	struct i3c_target_ctrl *ctrl;
+};
+
+static inline struct i3c_target_func_group *to_i3c_target_func_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct i3c_target_func_group, group);
+}
+
+static inline struct i3c_target_ctrl_group *to_i3c_target_ctrl_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct i3c_target_ctrl_group, group);
+}
+
+static int i3c_target_ctrl_func_link(struct config_item *ctrl_cfg, struct config_item *func_cfg)
+{
+	struct i3c_target_func_group *func_group = to_i3c_target_func_group(func_cfg);
+	struct i3c_target_ctrl_group *ctrl_group = to_i3c_target_ctrl_group(ctrl_cfg);
+	struct i3c_target_ctrl *ctrl = ctrl_group->ctrl;
+	struct i3c_target_func *func = func_group->func;
+	int ret;
+
+	ret = i3c_target_ctrl_add_func(ctrl, func);
+	if (ret)
+		return ret;
+
+	ret = i3c_target_func_bind(func);
+	if (ret) {
+		i3c_target_ctrl_remove_func(ctrl, func);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_target_ctrl_func_unlink(struct config_item *ctrl_cfg, struct config_item *func_cfg)
+{
+	struct i3c_target_func_group *func_group = to_i3c_target_func_group(func_cfg->ci_parent);
+	struct i3c_target_ctrl_group *ctrl_group = to_i3c_target_ctrl_group(ctrl_cfg);
+	struct i3c_target_ctrl *ctrl = ctrl_group->ctrl;
+	struct i3c_target_func *func = func_group->func;
+
+	i3c_target_func_unbind(func);
+	i3c_target_ctrl_remove_func(ctrl, func);
+}
+
+static ssize_t i3c_target_ctrl_hotjoin_store(struct config_item *item, const char *page, size_t len)
+{
+	struct i3c_target_ctrl_group *ctrl_group = to_i3c_target_ctrl_group(item);
+	struct i3c_target_ctrl *ctrl;
+	int ret;
+
+	ctrl = ctrl_group->ctrl;
+
+	ret = i3c_target_ctrl_hotjoin(ctrl);
+	if (ret) {
+		dev_err(&ctrl->dev, "failed to hotjoin i3c target controller\n");
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+static ssize_t i3c_target_ctrl_hotjoin_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%d\n", 0);
+}
+
+CONFIGFS_ATTR(i3c_target_ctrl_, hotjoin);
+
+static struct configfs_item_operations i3c_target_ctrl_item_ops = {
+	.allow_link     = i3c_target_ctrl_func_link,
+	.drop_link      = i3c_target_ctrl_func_unlink,
+};
+
+static struct configfs_attribute *i3c_target_ctrl_attrs[] = {
+	&i3c_target_ctrl_attr_hotjoin,
+	NULL,
+};
+
+static const struct config_item_type i3c_target_ctrl_type = {
+	.ct_item_ops    = &i3c_target_ctrl_item_ops,
+	.ct_attrs	= i3c_target_ctrl_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+/**
+ * i3c_target_cfs_add_ctrl_group() - add I3C target controller group
+ * @ctrl: I3C target controller device
+ *
+ * Return: Pointer to struct config_group
+ */
+struct config_group *i3c_target_cfs_add_ctrl_group(struct i3c_target_ctrl *ctrl)
+{
+	struct i3c_target_ctrl_group *ctrl_group;
+	struct config_group *group;
+	int ret;
+
+	ctrl_group = kzalloc(sizeof(*ctrl_group), GFP_KERNEL);
+	if (!ctrl_group) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	group = &ctrl_group->group;
+
+	config_group_init_type_name(group, dev_name(&ctrl->dev), &i3c_target_ctrl_type);
+	ret = configfs_register_group(controllers_group, group);
+	if (ret) {
+		pr_err("failed to register configfs group for %s\n", dev_name(&ctrl->dev));
+		goto err_register_group;
+	}
+
+	ctrl_group->ctrl = ctrl;
+
+	return group;
+
+err_register_group:
+	kfree(ctrl_group);
+
+err:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(i3c_target_cfs_add_ctrl_group);
+
+/**
+ * i3c_target_cfs_remove_ctrl_group() - remove I3C target controller group
+ * @group: the group to be removed
+ */
+void i3c_target_cfs_remove_ctrl_group(struct config_group *group)
+{
+	struct i3c_target_ctrl_group *ctrl_group;
+
+	if (!group)
+		return;
+
+	ctrl_group = container_of(group, struct i3c_target_ctrl_group, group);
+	i3c_target_ctrl_put(ctrl_group->ctrl);
+	configfs_unregister_group(&ctrl_group->group);
+	kfree(ctrl_group);
+}
+EXPORT_SYMBOL(i3c_target_cfs_remove_ctrl_group);
+
+#define I3C_SLAVE_ATTR_R(_name)                                                \
+static ssize_t i3c_target_func_##_name##_show(struct config_item *item, char *page)    \
+{                                                                              \
+	struct i3c_target_func *func = to_i3c_target_func_group(item)->func;                     \
+	return sysfs_emit(page, "0x%04x\n", func->_name);               \
+}
+
+#define I3C_SLAVE_ATTR_W(_name, _u)                                            \
+static ssize_t i3c_target_func_##_name##_store(struct config_item *item,               \
+				       const char *page, size_t len)           \
+{                                                                              \
+	_u val;                                                               \
+	struct i3c_target_func *func = to_i3c_target_func_group(item)->func;                     \
+	if (kstrto##_u(page, 0, &val) < 0)                                      \
+		return -EINVAL;                                                \
+	func->_name = val;                                              \
+	return len;                                                            \
+}
+
+I3C_SLAVE_ATTR_R(vendor_id);
+I3C_SLAVE_ATTR_W(vendor_id, u16);
+CONFIGFS_ATTR(i3c_target_func_, vendor_id);
+
+I3C_SLAVE_ATTR_R(vendor_info);
+I3C_SLAVE_ATTR_W(vendor_info, u16);
+CONFIGFS_ATTR(i3c_target_func_, vendor_info);
+
+I3C_SLAVE_ATTR_R(part_id);
+I3C_SLAVE_ATTR_W(part_id, u16);
+CONFIGFS_ATTR(i3c_target_func_, part_id);
+
+I3C_SLAVE_ATTR_R(instance_id);
+I3C_SLAVE_ATTR_W(instance_id, u8);
+CONFIGFS_ATTR(i3c_target_func_, instance_id);
+
+I3C_SLAVE_ATTR_R(ext_id);
+I3C_SLAVE_ATTR_W(ext_id, u16);
+CONFIGFS_ATTR(i3c_target_func_, ext_id);
+
+I3C_SLAVE_ATTR_R(max_write_len);
+I3C_SLAVE_ATTR_W(max_write_len, u16);
+CONFIGFS_ATTR(i3c_target_func_, max_write_len);
+
+I3C_SLAVE_ATTR_R(max_read_len);
+I3C_SLAVE_ATTR_W(max_read_len, u16);
+CONFIGFS_ATTR(i3c_target_func_, max_read_len);
+
+I3C_SLAVE_ATTR_R(bcr);
+I3C_SLAVE_ATTR_W(bcr, u8);
+CONFIGFS_ATTR(i3c_target_func_, bcr);
+
+I3C_SLAVE_ATTR_R(dcr);
+I3C_SLAVE_ATTR_W(dcr, u8);
+CONFIGFS_ATTR(i3c_target_func_, dcr);
+
+static struct configfs_attribute *i3c_target_func_attrs[] = {
+	&i3c_target_func_attr_vendor_id,
+	&i3c_target_func_attr_vendor_info,
+	&i3c_target_func_attr_part_id,
+	&i3c_target_func_attr_instance_id,
+	&i3c_target_func_attr_ext_id,
+	&i3c_target_func_attr_max_write_len,
+	&i3c_target_func_attr_max_read_len,
+	&i3c_target_func_attr_bcr,
+	&i3c_target_func_attr_dcr,
+	NULL,
+};
+
+static const struct config_item_type i3c_target_func_type = {
+	.ct_attrs       = i3c_target_func_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct config_group *i3c_target_func_make(struct config_group *group, const char *name)
+{
+	struct i3c_target_func_group *func_group;
+	struct i3c_target_func *func;
+	int err;
+
+	func_group = kzalloc(sizeof(*func_group), GFP_KERNEL);
+	if (!func_group)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&func_group->group, name, &i3c_target_func_type);
+
+	func = i3c_target_func_create(group->cg_item.ci_name, name);
+	if (IS_ERR(func)) {
+		pr_err("failed to create i3c target function device\n");
+		err = -EINVAL;
+		goto free_group;
+	}
+
+	func->group = &func_group->group;
+
+	func_group->func = func;
+
+	return &func_group->group;
+
+free_group:
+	kfree(func_group);
+
+	return ERR_PTR(err);
+}
+
+static void i3c_target_func_drop(struct config_group *group, struct config_item *item)
+{
+	config_item_put(item);
+}
+
+static struct configfs_group_operations i3c_target_func_group_ops = {
+	.make_group     = &i3c_target_func_make,
+	.drop_item      = &i3c_target_func_drop,
+};
+
+static const struct config_item_type i3c_target_func_group_type = {
+	.ct_group_ops   = &i3c_target_func_group_ops,
+	.ct_owner       = THIS_MODULE,
+};
+
+/**
+ * i3c_target_cfs_add_func_group() - add I3C target function group
+ * @name: group name
+ *
+ * Return: Pointer to struct config_group
+ */
+struct config_group *i3c_target_cfs_add_func_group(const char *name)
+{
+	struct config_group *group;
+
+	group = configfs_register_default_group(functions_group, name,
+						&i3c_target_func_group_type);
+	if (IS_ERR(group))
+		pr_err("failed to register configfs group for %s function\n",
+		       name);
+
+	return group;
+}
+EXPORT_SYMBOL(i3c_target_cfs_add_func_group);
+
+/**
+ * i3c_target_cfs_remove_func_group() - add I3C target function group
+ * @group: group to be removed
+ */
+void i3c_target_cfs_remove_func_group(struct config_group *group)
+{
+	if (IS_ERR_OR_NULL(group))
+		return;
+
+	configfs_unregister_default_group(group);
+}
+EXPORT_SYMBOL(i3c_target_cfs_remove_func_group);
+
+static const struct config_item_type i3c_target_controllers_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static const struct config_item_type i3c_target_functions_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static const struct config_item_type i3c_target_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct configfs_subsystem i3c_target_cfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "i3c_target",
+			.ci_type = &i3c_target_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(i3c_target_cfs_subsys.su_mutex),
+};
+
+static int __init i3c_target_cfs_init(void)
+{
+	int ret;
+	struct config_group *root = &i3c_target_cfs_subsys.su_group;
+
+	config_group_init(root);
+
+	ret = configfs_register_subsystem(&i3c_target_cfs_subsys);
+	if (ret) {
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret, root->cg_item.ci_namebuf);
+		goto err;
+	}
+
+	functions_group = configfs_register_default_group(root, "functions",
+							  &i3c_target_functions_type);
+	if (IS_ERR(functions_group)) {
+		ret = PTR_ERR(functions_group);
+		pr_err("Error %d while registering functions group\n",
+		       ret);
+		goto err_functions_group;
+	}
+
+	controllers_group =
+		configfs_register_default_group(root, "controllers",
+						&i3c_target_controllers_type);
+	if (IS_ERR(controllers_group)) {
+		ret = PTR_ERR(controllers_group);
+		pr_err("Error %d while registering controllers group\n",
+		       ret);
+		goto err_controllers_group;
+	}
+
+	return 0;
+
+err_controllers_group:
+	configfs_unregister_default_group(functions_group);
+
+err_functions_group:
+	configfs_unregister_subsystem(&i3c_target_cfs_subsys);
+
+err:
+	return ret;
+}
+module_init(i3c_target_cfs_init);
+
+MODULE_DESCRIPTION("I3C FUNC CONFIGFS");
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
diff --git a/drivers/i3c/target.c b/drivers/i3c/target.c
new file mode 100644
index 0000000000000..a2738b8341f7a
--- /dev/null
+++ b/drivers/i3c/target.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * configfs to configure the I3C Slave
+ *
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/configfs.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i3c/target.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(func_lock);
+static struct class *i3c_target_ctrl_class;
+
+static void i3c_target_func_dev_release(struct device *dev)
+{
+	struct i3c_target_func *func = to_i3c_target_func(dev);
+
+	kfree(func->name);
+	kfree(func);
+}
+
+static const struct device_type i3c_target_func_type = {
+	.release        = i3c_target_func_dev_release,
+};
+
+static int i3c_target_func_match_driver(struct device *dev, struct device_driver *drv)
+{
+	return !strncmp(dev_name(dev), drv->name, strlen(drv->name));
+}
+
+static int i3c_target_func_device_probe(struct device *dev)
+{
+	struct i3c_target_func *func = to_i3c_target_func(dev);
+	struct i3c_target_func_driver *driver = to_i3c_target_func_driver(dev->driver);
+
+	if (!driver->probe)
+		return -ENODEV;
+
+	func->driver = driver;
+
+	return driver->probe(func);
+}
+
+static void i3c_target_func_device_remove(struct device *dev)
+{
+	struct i3c_target_func *func = to_i3c_target_func(dev);
+	struct i3c_target_func_driver *driver = to_i3c_target_func_driver(dev->driver);
+
+	if (driver->remove)
+		driver->remove(func);
+	func->driver = NULL;
+}
+
+static const struct bus_type i3c_target_func_bus_type = {
+	.name = "i3c_target_func",
+	.probe = i3c_target_func_device_probe,
+	.remove = i3c_target_func_device_remove,
+	.match = i3c_target_func_match_driver,
+};
+
+static void i3c_target_ctrl_release(struct device *dev)
+{
+	kfree(to_i3c_target_ctrl(dev));
+}
+
+static void devm_i3c_target_ctrl_release(struct device *dev, void *res)
+{
+	struct i3c_target_ctrl *ctrl = *(struct i3c_target_ctrl **)res;
+
+	i3c_target_ctrl_destroy(ctrl);
+}
+
+struct i3c_target_ctrl *
+__devm_i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			     struct module *owner)
+{
+	struct i3c_target_ctrl **ptr, *ctrl;
+
+	ptr = devres_alloc(devm_i3c_target_ctrl_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	ctrl = __i3c_target_ctrl_create(dev, ops, owner);
+	if (!IS_ERR(ctrl)) {
+		*ptr = ctrl;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ctrl;
+}
+
+static int devm_i3c_target_ctrl_match(struct device *dev, void *res, void *match_data)
+{
+	struct i3c_target_ctrl **ptr = res;
+
+	return *ptr == match_data;
+}
+
+/**
+ * __i3c_target_ctrl_create() - create a new target controller device
+ * @dev: device that is creating the new target controller
+ * @ops: function pointers for performing target controller  operations
+ * @owner: the owner of the module that creates the target controller device
+ *
+ * Return: Pointer to struct i3c_target_ctrl
+ */
+struct i3c_target_ctrl *
+__i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			struct module *owner)
+{
+	struct i3c_target_ctrl *ctrl;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return ERR_PTR(-EINVAL);
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	device_initialize(&ctrl->dev);
+	ctrl->dev.class = i3c_target_ctrl_class;
+	ctrl->dev.parent = dev;
+	ctrl->dev.release = i3c_target_ctrl_release;
+	ctrl->ops = ops;
+
+	ret = dev_set_name(&ctrl->dev, "%s", dev_name(dev));
+	if (ret)
+		goto put_dev;
+
+	ret = device_add(&ctrl->dev);
+	if (ret)
+		goto put_dev;
+
+	ctrl->group = i3c_target_cfs_add_ctrl_group(ctrl);
+	if (!ctrl->group)
+		goto put_dev;
+
+	return ctrl;
+
+put_dev:
+	put_device(&ctrl->dev);
+	kfree(ctrl);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(__i3c_target_ctrl_create);
+
+/**
+ * devm_i3c_target_ctrl_destroy() - destroy the target controller device
+ * @dev: device that hat has to be destroy
+ * @ctrl: the target controller device that has to be destroy
+ *
+ * Invoke to create a new target controller device and add it to i3c_target class. While at that, it
+ * also associates the device with the i3c_target using devres. On driver detach, release function
+ * is invoked on the devres data, then devres data is freed.
+ */
+void devm_i3c_target_ctrl_destroy(struct device *dev, struct i3c_target_ctrl *ctrl)
+{
+	int r;
+
+	r = devres_destroy(dev, devm_i3c_target_ctrl_release, devm_i3c_target_ctrl_match,
+			   ctrl);
+	dev_WARN_ONCE(dev, r, "couldn't find I3C controller resource\n");
+}
+EXPORT_SYMBOL_GPL(devm_i3c_target_ctrl_destroy);
+
+/**
+ * i3c_target_ctrl_destroy() - destroy the target controller device
+ * @ctrl: the target controller device that has to be destroyed
+ *
+ * Invoke to destroy the I3C target device
+ */
+void i3c_target_ctrl_destroy(struct i3c_target_ctrl *ctrl)
+{
+	i3c_target_cfs_remove_ctrl_group(ctrl->group);
+	device_unregister(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_destroy);
+
+/**
+ * i3c_target_ctrl_add_func() - bind I3C target function to an target controller
+ * @ctrl: the controller device to which the target function should be added
+ * @func: the target function to be added
+ *
+ * An I3C target device can have only one functions.
+ */
+int i3c_target_ctrl_add_func(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func)
+{
+	if (ctrl->func)
+		return -EBUSY;
+
+	ctrl->func = func;
+	func->ctrl = ctrl;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_add_func);
+
+/**
+ * i3c_target_ctrl_remove_func() - unbind I3C target function to an target controller
+ * @ctrl: the controller device to which the target function should be removed
+ * @func: the target function to be removed
+ *
+ * An I3C target device can have only one functions.
+ */
+void i3c_target_ctrl_remove_func(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func)
+{
+	ctrl->func = NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_remove_func);
+
+/**
+ * i3c_target_ctrl_get() - get the I3C target controller
+ * @name: device name of the target controller
+ *
+ * Invoke to get struct i3c_target_ctrl * corresponding to the device name of the
+ * target controller
+ */
+struct i3c_target_ctrl *i3c_target_ctrl_get(const char *name)
+{
+	int ret = -EINVAL;
+	struct i3c_target_ctrl *ctrl;
+	struct device *dev;
+	struct class_dev_iter iter;
+
+	class_dev_iter_init(&iter, i3c_target_ctrl_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		if (strcmp(name, dev_name(dev)))
+			continue;
+
+		ctrl = to_i3c_target_ctrl(dev);
+		if (!try_module_get(ctrl->ops->owner)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		class_dev_iter_exit(&iter);
+		get_device(&ctrl->dev);
+		return ctrl;
+	}
+
+err:
+	class_dev_iter_exit(&iter);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_get);
+
+/**
+ * i3c_target_ctrl_put() - release the I3C endpoint controller
+ * @ctrl: target controller returned by pci_target_get()
+ *
+ * release the refcount the caller obtained by invoking i3c_target_ctrl_get()
+ */
+void i3c_target_ctrl_put(struct i3c_target_ctrl *ctrl)
+{
+	if (!ctrl || IS_ERR(ctrl))
+		return;
+
+	module_put(ctrl->ops->owner);
+	put_device(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_put);
+
+/**
+ * i3c_target_ctrl_hotjoin() - trigger device hotjoin
+ * @ctrl:  target controller
+ *
+ * return: 0: success, others failure
+ */
+int i3c_target_ctrl_hotjoin(struct i3c_target_ctrl *ctrl)
+{
+	if (!ctrl || IS_ERR(ctrl))
+		return -EINVAL;
+
+	if (!ctrl->ops->hotjoin)
+		return -EINVAL;
+
+	return ctrl->ops->hotjoin(ctrl);
+}
+EXPORT_SYMBOL_GPL(i3c_target_ctrl_hotjoin);
+
+/**
+ * i3c_target_func_bind() - Notify the function driver that the function device has been bound to a
+ *			   controller device
+ * @func: the function device which has been bound to the controller device
+ *
+ * Invoke to notify the function driver that it has been bound to a controller device
+ */
+int i3c_target_func_bind(struct i3c_target_func *func)
+{
+	struct device *dev = &func->dev;
+	int ret;
+
+	if (!func->driver) {
+		dev_WARN(dev, "func device not bound to driver\n");
+		return -EINVAL;
+	}
+
+	if (!try_module_get(func->driver->owner))
+		return -EAGAIN;
+
+	mutex_lock(&func->lock);
+	ret = func->driver->ops->bind(func);
+	if (!ret)
+		func->is_bound = true;
+	mutex_unlock(&func->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_target_func_bind);
+
+/**
+ * i3c_target_func_unbind() - Notify the function driver that the binding between the function
+ *			      device and controller device has been lost.
+ * @func: the function device which has lost the binding with the controller device.
+ *
+ * Invoke to notify the function driver that the binding between the function device and controller
+ * device has been lost.
+ */
+void i3c_target_func_unbind(struct i3c_target_func *func)
+{
+	if (!func->driver) {
+		dev_WARN(&func->dev, "func device not bound to driver\n");
+		return;
+	}
+
+	mutex_lock(&func->lock);
+	if (func->is_bound)
+		func->driver->ops->unbind(func);
+	mutex_unlock(&func->lock);
+
+	module_put(func->driver->owner);
+}
+EXPORT_SYMBOL_GPL(i3c_target_func_unbind);
+
+/**
+ * i3c_target_func_create() - create a new I3C function device
+ * @drv_name: the driver name of the I3C function device.
+ * @name: the name of the function device.
+ *
+ * Invoke to create a new I3C function device by providing the name of the function device.
+ */
+struct i3c_target_func *i3c_target_func_create(const char *drv_name, const char *name)
+{
+	struct i3c_target_func *func;
+	struct device *dev;
+	int ret;
+
+	func = kzalloc(sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &func->dev;
+	device_initialize(dev);
+	dev->bus = &i3c_target_func_bus_type;
+	dev->type = &i3c_target_func_type;
+	mutex_init(&func->lock);
+
+	ret = dev_set_name(dev, "%s.%s", drv_name, name);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	ret = device_add(dev);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	return func;
+}
+EXPORT_SYMBOL_GPL(i3c_target_func_create);
+
+/**
+ * __i3c_target_func_register_driver() - register a new I3C function driver
+ * @driver: structure representing I3C function driver
+ * @owner: the owner of the module that registers the I3C function driver
+ *
+ * Invoke to register a new I3C function driver.
+ */
+int __i3c_target_func_register_driver(struct i3c_target_func_driver *driver, struct module *owner)
+{
+	int ret = -EEXIST;
+
+	if (!driver->ops)
+		return -EINVAL;
+
+	if (!driver->ops->bind || !driver->ops->unbind)
+		return -EINVAL;
+
+	driver->driver.bus = &i3c_target_func_bus_type;
+	driver->driver.owner = owner;
+
+	ret = driver_register(&driver->driver);
+	if (ret)
+		return ret;
+
+	i3c_target_cfs_add_func_group(driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__i3c_target_func_register_driver);
+
+/**
+ * i3c_target_func_unregister_driver() - unregister the I3C function driver
+ * @fd: the I3C function driver that has to be unregistered
+ *
+ * Invoke to unregister the I3C function driver.
+ */
+void i3c_target_func_unregister_driver(struct i3c_target_func_driver *fd)
+{
+	mutex_lock(&func_lock);
+	mutex_unlock(&func_lock);
+}
+EXPORT_SYMBOL_GPL(i3c_target_func_unregister_driver);
+
+static int __init i3c_target_init(void)
+{
+	int ret;
+
+	i3c_target_ctrl_class = class_create("i3c_target");
+	if (IS_ERR(i3c_target_ctrl_class)) {
+		pr_err("failed to create i3c target class --> %ld\n",
+		       PTR_ERR(i3c_target_ctrl_class));
+		return PTR_ERR(i3c_target_ctrl_class);
+	}
+
+	ret = bus_register(&i3c_target_func_bus_type);
+	if (ret) {
+		class_destroy(i3c_target_ctrl_class);
+		pr_err("failed to register i3c target func bus --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(i3c_target_init);
+
+static void __exit i3c_target_exit(void)
+{
+	class_destroy(i3c_target_ctrl_class);
+	bus_unregister(&i3c_target_func_bus_type);
+}
+module_exit(i3c_target_exit);
+
diff --git a/include/linux/i3c/target.h b/include/linux/i3c/target.h
new file mode 100644
index 0000000000000..b0bf06685834c
--- /dev/null
+++ b/include/linux/i3c/target.h
@@ -0,0 +1,548 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef I3C_TARGET_H
+#define I3C_TARGET_H
+
+#include <linux/device.h>
+#include <linux/slab.h>
+
+struct i3c_target_func;
+struct i3c_target_ctrl;
+
+/**
+ * struct i3c_target_func_ops - set of function pointers for performing i3c target function
+ *				operations
+ * @bind: ops to perform when a controller device has been bound to function device
+ * @unbind: ops to perform when a binding has been lost between a controller device and function
+ *	    device
+ */
+struct i3c_target_func_ops {
+	int (*bind)(struct i3c_target_func *func);
+	void (*unbind)(struct i3c_target_func *func);
+};
+
+/**
+ * struct i3c_target_func_driver - represents the I3C function driver
+ * @probe: ops to perform when a new function device has been bound to the function driver
+ * @remove: ops to perform when the binding between the function device and function driver is
+ *	    broken
+ * @name: I3C Function driver name
+ * @driver: I3C Function driver
+ * @ops: set of function pointers for performing function operations
+ * @owner: the owner of the module that registers the I3C function driver
+ * @epf_group: list of configfs group corresponding to the I3C function driver
+ */
+struct i3c_target_func_driver {
+	int (*probe)(struct i3c_target_func *func);
+	void (*remove)(struct i3c_target_func *func);
+
+	char *name;
+	struct device_driver driver;
+	struct i3c_target_func_ops *ops;
+	struct module *owner;
+};
+
+/**
+ * struct i3c_target_func - represents the I3C function device
+ * @dev: the I3C function device
+ * @name: the name of the I3C function device
+ * @driver: the function driver to which this function device is bound
+ * @group: configfs group associated with the EPF device
+ * @lock: mutex to protect i3c_target_func_ops
+ * @ctrl: binded I3C controller device
+ * @is_bound: indicates if bind notification to function driver has been invoked
+ * @vendor_id: vendor id
+ * @part_id: part id
+ * @instance_id: instance id
+ * @ext_id: ext id
+ * @vendor_info: vendor info
+ * @static_addr: static address for I2C. It is 0 for I3C.
+ * @max_write_len: maximum write length
+ * @max_read_len: maximum read length
+ * @bcr: bus characteristics register (BCR)
+ * @dcr: device characteristics register (DCR)
+ */
+struct i3c_target_func {
+	struct device dev;
+	char *name;
+	struct i3c_target_func_driver *driver;
+	struct config_group *group;
+	/* mutex to protect against concurrent access of i3c_target_func_ops */
+	struct mutex lock;
+	struct i3c_target_ctrl *ctrl;
+	bool is_bound;
+
+	u16 vendor_id;
+	u16 part_id;
+	u8 instance_id;
+	u16 ext_id;
+	u8 vendor_info;
+	u16 static_addr;
+	u16 max_write_len;	//0 is hardware default max value
+	u16 max_read_len;	//0 is hardware default max value
+	u8 bcr;
+	u8 dcr;
+};
+
+enum i3c_request_stat {
+	I3C_REQUEST_OKAY,
+	I3C_REQUEST_PARTIAL,
+	I3C_REQUEST_ERR,
+	I3C_REQUEST_CANCEL,
+};
+
+/**
+ * struct i3c_request - represents the an I3C transfer request
+ * @buf: data buffer
+ * @length: data length
+ * @complete: call back function when request finished or cancelled
+ * @context: general data for complete callback function
+ * @list: link list
+ * @status: transfer status
+ * @actual: how much actually transferred
+ * @ctrl: I3C target controller associate with this request
+ * @tx: transfer direction, 1: target to master, 0: master to target
+ */
+struct i3c_request {
+	void *buf;
+	unsigned int length;
+
+	void (*complete)(struct i3c_request *req);
+	void *context;
+	struct list_head list;
+
+	enum i3c_request_stat status;
+	unsigned int actual;
+	struct i3c_target_ctrl *ctrl;
+	bool tx;
+};
+
+/**
+ * struct i3c_target_ctrl_features - represents I3C target controller features.
+ * @tx_fifo_sz: tx hardware fifo size
+ * @rx_fifo_sz: rx hardware fifo size
+ */
+struct i3c_target_ctrl_features {
+	u32 tx_fifo_sz;
+	u32 rx_fifo_sz;
+};
+
+/**
+ * struct i3c_target_ctrl_ops - set of function pointers for performing controller operations
+ * @set_config: set I3C controller configuration
+ * @enable: enable I3C controller
+ * @disable: disable I3C controller
+ * @raise_ibi: raise IBI interrupt to master
+ * @alloc_request: allocate a i3c_request, optional, default use kmalloc
+ * @free_request: free a i3c_request, default use kfree
+ * @queue: queue an I3C transfer
+ * @dequeue: dequeue an I3C transfer
+ * @cancel_all_reqs: call all pending requests
+ * @fifo_status: current FIFO status
+ * @fifo_flush: flush hardware FIFO
+ * @hotjoin: raise hotjoin request to master
+ * @set_status_format1: set i3c status format1
+ * @get_status_format1: get i3c status format1
+ * @get_addr: get i3c dynmatic address
+ * @get_features: ops to get the features supported by the I3C target controller
+ * @owner: the module owner containing the ops
+ */
+struct i3c_target_ctrl_ops {
+	int (*set_config)(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func);
+	int (*enable)(struct i3c_target_ctrl *ctrl);
+	int (*disable)(struct i3c_target_ctrl *ctrl);
+	int (*raise_ibi)(struct i3c_target_ctrl *ctrl, void *p, u8 size);
+
+	struct i3c_request *(*alloc_request)(struct i3c_target_ctrl *ctrl, gfp_t gfp_flags);
+	void (*free_request)(struct i3c_request *req);
+
+	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
+	int (*dequeue)(struct i3c_request *req);
+
+	void (*cancel_all_reqs)(struct i3c_target_ctrl *ctrl, bool tx);
+
+	int (*fifo_status)(struct i3c_target_ctrl *ctrl, bool tx);
+	void (*fifo_flush)(struct i3c_target_ctrl *ctrl, bool tx);
+	int (*hotjoin)(struct i3c_target_ctrl *ctrl);
+	int (*set_status_format1)(struct i3c_target_ctrl *ctrl, u16 status);
+	u16 (*get_status_format1)(struct i3c_target_ctrl *ctrl);
+	u8  (*get_addr)(struct i3c_target_ctrl *ctrl);
+	const struct i3c_target_ctrl_features *(*get_features)(struct i3c_target_ctrl *ctrl);
+	struct module *owner;
+};
+
+/**
+ * struct i3c_target_ctrl - represents the I3C target device
+ * @dev: I3C target device
+ * @ops: function pointers for performing endpoint operations
+ * @func: target functions present in this controller device
+ * @group: configfs group representing the I3C controller device
+ */
+struct i3c_target_ctrl {
+	struct device dev;
+	const struct i3c_target_ctrl_ops *ops;
+	struct i3c_target_func *func;
+	struct config_group *group;
+};
+
+/**
+ * i3c_target_ctrl_raise_ibi() - Raise IBI to master
+ * @ctrl: I3C target controller
+ * @p: optional data for IBI
+ * @size: size of optional data
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int i3c_target_ctrl_raise_ibi(struct i3c_target_ctrl *ctrl, void *p, u8 size)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->raise_ibi)
+		return ctrl->ops->raise_ibi(ctrl, p, size);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_target_ctrl_cancel_all_reqs() - Cancel all pending request
+ * @ctrl: I3C target controller
+ * @tx: Transfer diretion queue
+ */
+static inline void i3c_target_ctrl_cancel_all_reqs(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->cancel_all_reqs)
+		ctrl->ops->cancel_all_reqs(ctrl, tx);
+}
+
+/**
+ * i3c_target_ctrl_set_config() - Set controller configuration
+ * @ctrl: I3C target controller device
+ * @func: Function device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_set_config(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->set_config)
+		return ctrl->ops->set_config(ctrl, func);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_target_ctrl_enable() - Enable I3C controller
+ * @ctrl: I3C target controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_enable(struct i3c_target_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->enable)
+		return ctrl->ops->enable(ctrl);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_target_ctrl_disable() - Disable I3C controller
+ * @ctrl: I3C target controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_disable(struct i3c_target_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->disable)
+		return ctrl->ops->disable(ctrl);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_target_ctrl_alloc_request() - Alloc an I3C transfer
+ * @ctrl: I3C target controller device
+ * @gfp_flags: additional gfp flags used when allocating the buffers
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline struct i3c_request *
+i3c_target_ctrl_alloc_request(struct i3c_target_ctrl *ctrl, gfp_t gfp_flags)
+{
+	struct i3c_request *req = NULL;
+
+	if (ctrl && ctrl->ops && ctrl->ops->alloc_request)
+		req = ctrl->ops->alloc_request(ctrl, gfp_flags);
+	else
+		req = kzalloc(sizeof(*req), gfp_flags);
+
+	if (req)
+		req->ctrl = ctrl;
+
+	return req;
+}
+
+/**
+ * i3c_target_ctrl_free_request() - Free an I3C transfer
+ * @req: I3C transfer request
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline void
+i3c_target_ctrl_free_request(struct i3c_request *req)
+{
+	struct i3c_target_ctrl *ctrl;
+
+	if (!req)
+		return;
+
+	ctrl = req->ctrl;
+	if (ctrl && ctrl->ops && ctrl->ops->free_request)
+		ctrl->ops->free_request(req);
+	else
+		kfree(req);
+}
+
+/**
+ * i3c_target_ctrl_queue() - Queue an I3C transfer
+ * @req: I3C transfer request
+ * @gfp_flags: additional gfp flags used when allocating the buffers
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_queue(struct i3c_request *req, gfp_t gfp_flags)
+{
+	struct i3c_target_ctrl *ctrl;
+	int ret = -EINVAL;
+
+	if (!req)
+		return -EINVAL;
+
+	ctrl = req->ctrl;
+
+	req->actual = 0;
+	req->status = 0;
+	if (ctrl && ctrl->ops && ctrl->ops->queue)
+		ret = ctrl->ops->queue(req, gfp_flags);
+
+	return ret;
+}
+
+/**
+ * i3c_target_ctrl_dequeue() - Dequeue an I3C transfer
+ * @req: I3C transfer request
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_dequeue(struct i3c_request *req)
+{
+	struct i3c_target_ctrl *ctrl;
+	int ret = -EINVAL;
+
+	if (!req)
+		return -EINVAL;
+
+	ctrl = req->ctrl;
+	if (ctrl && ctrl->ops && ctrl->ops->dequeue)
+		ret = ctrl->ops->dequeue(req);
+
+	return ret;
+}
+
+/**
+ * i3c_target_ctrl_fifo_status() - Get controller FIFO status
+ * @ctrl: I3C target controller device
+ * @tx: 1: Target to master, 0: master to target
+ *
+ * Returns: How much data in FIFO
+ */
+static inline int
+i3c_target_ctrl_fifo_status(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->fifo_status)
+		return ctrl->ops->fifo_status(ctrl, tx);
+
+	return 0;
+}
+
+/**
+ * i3c_target_ctrl_fifo_flush() - Flush controller FIFO
+ * @ctrl: I3C target controller device
+ * @tx: 1: Target to master, 0: master to target
+ *
+ */
+static inline void
+i3c_target_ctrl_fifo_flush(struct i3c_target_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->fifo_flush)
+		return ctrl->ops->fifo_flush(ctrl, tx);
+}
+
+/**
+ * i3c_target_ctrl_get_features() - Get controller supported features
+ * @ctrl: I3C target controller device
+ *
+ * Returns: The pointer to struct i3c_target_ctrl_features
+ */
+static inline const struct i3c_target_ctrl_features*
+i3c_target_ctrl_get_features(struct i3c_target_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_features)
+		return ctrl->ops->get_features(ctrl);
+
+	return NULL;
+}
+
+/**
+ * i3c_target_ctrl_set_status_format1() - Set controller supported features
+ * @ctrl: I3C target controller device
+ * @status: I3C GETSTATUS format1
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_target_ctrl_set_status_format1(struct i3c_target_ctrl *ctrl, u16 status)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->set_status_format1)
+		return ctrl->ops->set_status_format1(ctrl, status);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_target_ctrl_get_status_format1() - Get controller supported features
+ * @ctrl: I3C target controller device
+ *
+ * Return: I3C GETSTATUS format1
+ */
+static inline u16
+i3c_target_ctrl_get_status_format1(struct i3c_target_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_status_format1)
+		return ctrl->ops->get_status_format1(ctrl);
+
+	return 0;
+}
+
+/**
+ * i3c_target_ctrl_get_addr() - Get controller address
+ * @ctrl: I3C target controller device
+ *
+ * Return: address
+ */
+static inline u8 i3c_target_ctrl_get_addr(struct i3c_target_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_addr)
+		return ctrl->ops->get_addr(ctrl);
+
+	return 0;
+}
+
+#define to_i3c_target_ctrl(device) container_of((device), struct i3c_target_ctrl, dev)
+
+#define to_i3c_target_func(func_dev) container_of((func_dev), struct i3c_target_func, dev)
+#define to_i3c_target_func_driver(drv) (container_of((drv), struct i3c_target_func_driver, driver))
+
+#define i3c_target_ctrl_create(dev, ops) \
+		__i3c_target_ctrl_create((dev), (ops), THIS_MODULE)
+#define devm_i3c_target_ctrl_create(dev, ops) \
+		__devm_i3c_target_ctrl_create((dev), (ops), THIS_MODULE)
+
+#ifdef CONFIG_I3C_TARGET
+struct i3c_target_ctrl *
+__devm_i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			     struct module *owner);
+struct i3c_target_ctrl *
+__i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			struct module *owner);
+
+void devm_i3c_target_ctrl_destroy(struct device *dev, struct i3c_target_ctrl *epc);
+void i3c_target_ctrl_destroy(struct i3c_target_ctrl *epc);
+
+int i3c_target_ctrl_add_func(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func);
+void i3c_target_ctrl_remove_func(struct i3c_target_ctrl *ctrl, struct i3c_target_func *func);
+int i3c_target_ctrl_hotjoin(struct i3c_target_ctrl *ctrl);
+
+struct i3c_target_ctrl *i3c_target_ctrl_get(const char *name);
+void i3c_target_ctrl_put(struct i3c_target_ctrl *ctrl);
+
+int i3c_target_func_bind(struct i3c_target_func *func);
+void i3c_target_func_unbind(struct i3c_target_func *func);
+struct i3c_target_func *i3c_target_func_create(const char *drv_name, const char *name);
+
+#define i3c_target_func_register_driver(drv) \
+	__i3c_target_func_register_driver(drv, THIS_MODULE)
+
+int __i3c_target_func_register_driver(struct i3c_target_func_driver *drv, struct module *owner);
+void i3c_target_func_unregister_driver(struct i3c_target_func_driver *drv);
+#else
+static inline struct i3c_target_ctrl *
+__devm_i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			     struct module *owner)
+{
+	return NULL;
+}
+
+static inline struct i3c_target_ctrl *
+__i3c_target_ctrl_create(struct device *dev, const struct i3c_target_ctrl_ops *ops,
+			struct module *owner)
+{
+	return NULL;
+}
+#endif
+
+#ifdef CONFIG_I3C_TARGET_CONFIGFS
+struct config_group *i3c_target_cfs_add_ctrl_group(struct i3c_target_ctrl *ctrl);
+void i3c_target_cfs_remove_ctrl_group(struct config_group *group);
+struct config_group *i3c_target_cfs_add_func_group(const char *name);
+void i3c_target_cfs_remove_func_group(struct config_group *group);
+#else
+static inline struct config_group *i3c_target_cfs_add_ctrl_group(struct i3c_target_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static inline void i3c_target_cfs_remove_ctrl_group(struct config_group *group)
+{
+}
+
+static inline struct config_group *i3c_target_cfs_add_func_group(const char *name)
+{
+	return NULL;
+}
+
+static inline void i3c_target_cfs_remove_func_group(struct config_group *group)
+{
+}
+#endif
+
+#define DECLARE_I3C_TARGET_FUNC(_name, _probe, _remove, _ops)			\
+	static struct i3c_target_func_driver _name ## i3c_func = {		\
+		.driver.name = __stringify(_name),				\
+		.owner  = THIS_MODULE,						\
+		.probe = _probe,						\
+		.remove = _remove,						\
+		.ops = _ops							\
+	};									\
+	MODULE_ALIAS("i3cfunc:" __stringify(_name))
+
+#define DECLARE_I3C_TARGET_INIT(_name, _probe, _remove, _ops)			\
+	DECLARE_I3C_TARGET_FUNC(_name, _probe, _remove, _ops);			\
+	static int __init _name ## mod_init(void)				\
+	{									\
+		return i3c_target_func_register_driver(&_name ## i3c_func);	\
+	}									\
+	static void __exit _name ## mod_exit(void)				\
+	{									\
+		i3c_target_func_unregister_driver(&_name ## i3c_func);		\
+	}									\
+	module_init(_name ## mod_init);						\
+	module_exit(_name ## mod_exit)
+
+#endif
-- 
2.34.1


