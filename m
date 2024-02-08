Return-Path: <linux-kernel+bounces-58397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47284E5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF8B1F220C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249088002E;
	Thu,  8 Feb 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TAV1rP/G"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DB85C73;
	Thu,  8 Feb 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411726; cv=fail; b=sNqRlEAE3Z6kNgyrjSAdSvCN2Byr6hHN3/hhl0PaykMtv7fKDNfUSF+oixnPPndLJRc8pUuETOn4X2Nj/trBgFqOsDQb+ec4jtOqXCgM1ea+CCT7ePTwnO/v+EM7l9trcbamDYM7e1R5G4mYGWYYSOrg9CT07tT/cKxi7O1zzvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411726; c=relaxed/simple;
	bh=cwbo1GKMkabi0KyHCZXugYVNbZjoWzK11emt0jqwWJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siOdJuJxKDc+w1Ny1AMpH7GtUWfhd6Nj63izjWJl1b0FDtPzs+BQemn1ovjT/3tJCtjXuKwwrx1JVNULIc5WTCLqOWLSeV48eP5G4xl41RGi9sMopbQQg9Wixwk8dWj7cvulVZCGDZ7409ltXZ1qLa1aqkF400LLzRlyZeoRu28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TAV1rP/G; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDya8lvlR2nvh1VKRsQ+FkbVQtlp36b1flXBwifUMqh4neBzJ94NR5sSKKUt8ACz8Qvf96a4h/3klg7AcsNwd+Xq5rWhI5TswQ0/eRCoagbSTsvOKvAW4jjlWg/xCtLI3ellXJDbRFAikvqw0LzTx/duyLUn02kYu9Qfdx4WHV+ahcjzYux4D/2gHVxBl0gJxhvZoRGYcembkNu+nrfcxgpGPItxnMVoToSDRZIAV+I2a2qkJpGvLMCsebRY598gfB+uMdIPq5a5U6JnnAM8j3MWzML7Q6IqsIGAwDsW3vC3ig+ahc2nXATaKOtZBh+9wzpSfMxSZIa41pmxq7yBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04xqZBjF8Z1MoZTW2zREKB6wmaZdVutdhyYJgIV1Fgc=;
 b=KaxRbniqv6hsxpWxSWctRX2g4s2bJQsJFOacUcc1NtUFyANPNjAkFJ40oo2r8hJ7sw+6lxWFjC1pCngwvhIKEYDo6nDnkwp8zjz6IbrhjfADBy77YYG8hI4yIMw1yiIxl4wREV3PD5RfTcG/llUngPJ13unyB0lNOmasa8uD/yXEOkSK4hSUdFxQfql4/b2hOo6hRRzT+8YYUqIdCeIBkd/rjQgxFsu2dbBQrA7Hk+KztxizvHxZfEw0kbUI7vSc0a9U0hYasqH62sh23m/oFQU7SXecS1EoJlxdjK1vEwd+GwpXiLYagBErZ5d8AuTkQ2C0andlVne4meJkGuVOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04xqZBjF8Z1MoZTW2zREKB6wmaZdVutdhyYJgIV1Fgc=;
 b=TAV1rP/GtcUeFdu4jayNsgMNGk9OWumBar+oIRNEB7Y8MB/YpRmYiOrYfREY7WspnjK/4goAxY4+3450GdrQEX5dtD9mMSS3l562Bwqxw+JXm+2iW3bFn8iAj3og7/uJSHjf8NEpmCoTaDuA6E+KbrBnBt4d0LLQQ/WL1+4e+eQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:02:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:02:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
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
Subject: [PATCH v8 6/8] i3c: target: func: add tty driver
Date: Thu,  8 Feb 2024 12:01:15 -0500
Message-Id: <20240208170117.798357-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: f1103997-bb95-4dfc-3834-08dc28c7ab51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LwhYZm3OmyqoOwqNcCEY4InWdT/3IdEUBzbp8pj7H64nVb9eeRDx9+P8UD6OGRNc46WV/gg23IneVYCD2spetxONF5xAHYw6sUfZrP7V4Xy+Pg5F6BgGkKQKiTUBJxK9CCoajgdORyQAZfntu8jAUOW8Oxqi2R+Nwclooxkf1yrfQuTt1MTX39BMBtXqQwzjXcs3Qy58kEdjsZi5dfTB1L0lGiWOokosvdsybZZIgTja89qloQHJg4K5gp1cHpjWrEhJbvQITws33jx7zSCrasLGrauwiti7YAe6Ym4TGTM2QghaqfJl/HpW85pczcA9j3WT5O8VIDR+xZaNmFTqgox34eAiyMIMJzkwrzDUbRSES6CwPHKm8EaojegezkLHQdwkbjoPakPKFFERfMETjjspUw39v1ZYd4vFV7AokRfGN9tagVpSSBj4o8Bl+GG+qOT4oPZLamr4uIQdNNH9TmFmXL0H1OaLoFQ9nCW0+G3JM4st0WOowMfBmMmaUCOhIar8eFsUxso+4dHFDj5Oq//O67di8vCOVme3hNT782rHjdn8v61gzoNOVi33eu55KDjdSZAdy1tUGpxkYHGbcCmjwX++z46jdwhTR1vOLBZIPAScYjRQap6CbJRRrEQP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(6666004)(52116002)(6506007)(83380400001)(37006003)(86362001)(7416002)(41300700001)(1076003)(2616005)(26005)(34206002)(6512007)(36756003)(8676002)(8936002)(4326008)(6486002)(478600001)(2906002)(30864003)(5660300002)(66476007)(66946007)(316002)(66556008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rU4G4oNbSY8F5dCuw0ln4tHw5Cwt2clj5hPGevdJP5e3VQgKKNs2SMMHSu7S?=
 =?us-ascii?Q?vhhKxGgU0fCQGTi4jSmlguZKfvRQkkupRIhUy4pUydejsmPZTdgJ8MesMP7v?=
 =?us-ascii?Q?Pt2LuQDPzs+HbpTdAHyOQ4sukgnrFmjQRqHqrsebkmGj214VjpRuof4I7E67?=
 =?us-ascii?Q?4hNkWe6vLVxmklTcGZKly6Z72msY1n6HJAt/xqFF8ZOMnh2fJ4XjTplcPgbA?=
 =?us-ascii?Q?RL/NQmG6rlQyHi6ogsditDaX5hR2BhTK4Snll3lI+gWPEmoJs/O6EmTgEr+u?=
 =?us-ascii?Q?S9XEfUHQTee1v4vSocmtF6M5OyqPQa/bidXXlvilAq8zEyuncJ8gobULEcel?=
 =?us-ascii?Q?R7pkm/TLTgL/FzFBTnaRgIpMUV3cjYqEIuwBN+tPK/mKGtMgSj4il7W6wn33?=
 =?us-ascii?Q?71oDa/XBGWaDsxAv/cOV+NJ8XxlPgP79oOPz/pDh5yZSyO7Vei9fzmMsf47Z?=
 =?us-ascii?Q?o3IEK+ksm8bMNF7UTY/bm7XVo72XVeA6o5nL8oczT2bluTAbkEK0Kr25+wuw?=
 =?us-ascii?Q?UsWrYc/1Yq5bcSjdqLfFCrIoRD6V7O9gsniqro/OoIX1mQl7/XK+lGXjZuYR?=
 =?us-ascii?Q?q0owGNCyKBmv27d9b0J45Y4x0GBFwQbAf8SjMDrE7zoSRD5DCDkhvaj5X5Sd?=
 =?us-ascii?Q?TdVZV7zh4mSOdNfNWDSAjvg2yF3k00eXCf4rQduRHDd88nXmKRx5XI4G6FFx?=
 =?us-ascii?Q?gBTCPkgr4f3LuAvEL9Y0BYPqHMP9e5FVPAZcSpDp01F1u8ysc7oGmxSeLjeS?=
 =?us-ascii?Q?YlM3+35M806G24zXAW6k9vC1upH1AqRn2env5/Fd91eSnUIzuwjlPbf4vdAT?=
 =?us-ascii?Q?M0q4RGo7gFj743tNrgDQ5wTrBUV9MPXOrOCda7dphii0o4fCtEwaOxPP7ouM?=
 =?us-ascii?Q?24qSV013mQ2gqSrgGaiOlFB03h+MFzH7eszxxZ+FBQlLLer6gndrLvYhsz6j?=
 =?us-ascii?Q?pgOBn59VQXbIfFFP8dVphzLWE3APp6HEGYC6JwTTrbdYkBVtyzROmPgcWF9Q?=
 =?us-ascii?Q?NN2uwa2/UYOjFho1VFl9rgrbh4WZwPh18XdgjN8t14SsAhEgX8Mz1s1rkBeq?=
 =?us-ascii?Q?fYgupGW07OUdw2mp5KoZ/RDwvjXd0N+O5NY3LxVB2THCDYFRYwHLdYblybK1?=
 =?us-ascii?Q?bgQ4LuMfSh3x2bBeRXduiBz/+Jet8EjeMXWZ8FNaNtsK4fc4PfxNL2NMZWIr?=
 =?us-ascii?Q?OGVefwjHfWKQZlEyb7MrpEWhZyR9Mkqo6zKQDW358ibUHDJOzAllaPEqvELL?=
 =?us-ascii?Q?J7mauOm1nycTNaksY6Yk9mvlWp4iQ6YOSdJ0g+ewrHIBEmWEjUlLdmLQoNzU?=
 =?us-ascii?Q?egx4akVbx4Dn3DMck/gvT9ZocGStGLPQw+r0TDaLECW5f5reAQGTVSmEPxqw?=
 =?us-ascii?Q?SxZS2Tobu4sN9DHd6M/wM6LDcX5idnQ2SLX1NfQ3Rtnb7nXG+OHouZ+GnYqw?=
 =?us-ascii?Q?uH22Db4caETqosawaGNE992W3ZCgYd+CYh6Gh6b29cxKUvJ+TGJOXSiFc9IA?=
 =?us-ascii?Q?q4hRuGfAMmNDXKrmFAPZbIWyCwT7v7t15T1L7m+CMpdl/FQrrGPP1quDdwRQ?=
 =?us-ascii?Q?P8ZTHHMB0CUVjZet8osCNwKV63X2gSvdOI9sa5ZQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1103997-bb95-4dfc-3834-08dc28c7ab51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:02:01.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wchm8ERBtZuq9Gmj+cpj52dW7E3E5YGXOGRFcICHEwSO5q/vXA9UDL01j1FvU8SUxtzhUYSRpMq0STLOHgnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Add tty over I3C target function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - reorder header file
    - add missed header files
    
    Change from v5 to v7
    - none
    Change from v4 to v5
    - remove void*
    - include bitfield.h
    - remove extra ()
    - oneline for struct ttyi3c_port *sport

 drivers/i3c/Kconfig       |   3 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 481 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 497 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d59a7eb83d13a..fca808cda87b3 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -48,3 +48,6 @@ config I3C_TARGET_CONFIGFS
 	  the target function and used to bind the function with a target
 	  controller.
 
+if I3C_TARGET
+source "drivers/i3c/func/Kconfig"
+endif # I3C_TARGET
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index c275aeae8970c..11f026d6876fe 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C_TARGET)                += target.o
 obj-$(CONFIG_I3C_TARGET_CONFIGFS)       += i3c-cfs.o
 obj-$(CONFIG_I3C)		+= master/
+obj-$(CONFIG_I3C_TARGET)	+= func/
diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
new file mode 100644
index 0000000000000..7115129eb7d5a
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_TARGET_FUNC_TTY
+	tristate "I3C target tty driver"
+	depends on I3C_TARGET
+	help
+	  I3C Target TTY Function Driver.
+
+	  General TTY over I3C target controller function drivers.
diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
new file mode 100644
index 0000000000000..16b3b9301496b
--- /dev/null
+++ b/drivers/i3c/func/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_I3C_TARGET_FUNC_TTY)              += tty.o
diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
new file mode 100644
index 0000000000000..2cf25c8d49f2b
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/iopoll.h>
+#include <linux/i3c/target.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/workqueue.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+
+#define I3C_TX_NOEMPTY		BIT(0)
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_IBI_TX		BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	struct i3c_target_func *i3cdev;
+	struct completion txcomplete;
+	spinlock_t xlock;
+	void *buffer;
+	struct work_struct work;
+	u16 status;
+	struct i3c_request *req;
+};
+
+static void i3c_target_tty_rx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	tty_insert_flip_string(&port->port, req->buf, req->actual);
+	tty_flip_buffer_push(&port->port);
+
+	req->actual = 0;
+	req->status = 0;
+	i3c_target_ctrl_queue(req, GFP_KERNEL);
+}
+
+static void i3c_target_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *sport = req->context;
+	unsigned long flags;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	kfifo_dma_out_finish(&sport->port.xmit_fifo, req->actual);
+	sport->req = NULL;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		complete(&sport->txcomplete);
+	else
+		queue_work(system_unbound_wq, &sport->work);
+
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	i3c_target_ctrl_free_request(req);
+}
+
+static void i3c_target_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct i3c_request *req = sport->req;
+	struct scatterlist sg[1];
+	unsigned int nents;
+	u8 ibi;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		return;
+
+	if (!req) {
+		req = i3c_target_ctrl_alloc_request(sport->i3cdev->ctrl, GFP_KERNEL);
+		if (!req)
+			return;
+
+		sg_init_table(sg, ARRAY_SIZE(sg));
+		nents = kfifo_dma_out_prepare(&sport->port.xmit_fifo, sg, ARRAY_SIZE(sg),
+					      UART_XMIT_SIZE);
+		if (!nents)
+			goto err;
+
+		req->length = sg->length;
+		req->buf =  sg_virt(sg);
+
+		req->complete = i3c_target_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err;
+
+		sport->req = req;
+	}
+
+	ibi = I3C_TTY_IBI_TX;
+	i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+
+	return;
+
+err:
+	i3c_target_ctrl_free_request(req);
+}
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	const struct i3c_target_ctrl_features *feature;
+	struct i3c_target_func *func = sport->i3cdev;
+	struct i3c_request *req;
+	int rxfifo_size;
+	int offset = 0;
+	int ret;
+
+	feature = i3c_target_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret)
+		return ret;
+
+	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->buffer)
+		goto err_alloc_rx_buf;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = I3C_TTY_TRANS_SIZE;
+
+	do {
+		req = i3c_target_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+		if (!req)
+			goto err_alloc_req;
+
+		req->buf = sport->buffer + offset;
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_target_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err_alloc_req;
+	} while (req && offset + rxfifo_size < UART_XMIT_SIZE);
+
+	reinit_completion(&sport->txcomplete);
+
+	return 0;
+
+err_alloc_req:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	free_page((unsigned long)sport->buffer);
+err_alloc_rx_buf:
+	tty_port_free_xmit_buf(port);
+	return -ENOMEM;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, false);
+
+	tty_port_free_xmit_buf(port);
+	free_page((unsigned long)sport->buffer);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	idr_remove(&i3c_tty_minors, sport->minor);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static int i3c_target_tty_bind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	int minor;
+	int ret;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	if (i3c_target_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failed to set i3c config\n");
+		return -EINVAL;
+	}
+
+	spin_lock_init(&sport->xlock);
+	init_completion(&sport->txcomplete);
+
+	ret = minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+
+	if (minor < 0)
+		goto err_idr_alloc;
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &func->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_register_port;
+	}
+
+	sport->minor = minor;
+	ret = i3c_target_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+err_register_port:
+	idr_remove(&i3c_tty_minors, sport->minor);
+err_idr_alloc:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_target_tty_unbind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_disable(func->ctrl);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 1);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+
+	free_page((unsigned long)sport->buffer);
+}
+
+static struct i3c_target_func_ops i3c_func_ops = {
+	.bind   = i3c_target_tty_bind,
+	.unbind = i3c_target_tty_unbind,
+};
+
+static int i3c_tty_probe(struct i3c_target_func *func)
+{
+	struct device *dev = &func->dev;
+	struct ttyi3c_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = func;
+	dev_set_drvdata(&func->dev, port);
+
+	INIT_WORK(&port->work, i3c_target_tty_i3c_work);
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status | I3C_TX_NOEMPTY);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->work);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_put(&sport->port.xmit_fifo, ch);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (!kfifo_is_empty(&sport->port.xmit_fifo))
+		queue_work(system_unbound_wq, &sport->work);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return kfifo_avail(&sport->port.xmit_fifo);
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_port_activate(&sport->port, tty);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+	int ret;
+
+	tty->driver_data = sport;
+
+	if (!i3c_target_ctrl_get_addr(sport->i3cdev->ctrl)) {
+		dev_dbg(&sport->i3cdev->dev, "No target addr assigned, try hotjoin");
+		ret = i3c_target_ctrl_hotjoin(sport->i3cdev->ctrl);
+		if (ret) {
+			dev_err(&sport->i3cdev->dev, "Hotjoin failure, check connection");
+			return ret;
+		}
+	}
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	int val;
+	int ret;
+	u8 ibi = I3C_TTY_IBI_TX;
+	int retry = 100;
+
+	if (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		do {
+			ret = wait_for_completion_timeout(&sport->txcomplete, timeout / 100);
+			if (ret)
+				break;
+			i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+		} while (retry--);
+
+		reinit_completion(&sport->txcomplete);
+	}
+
+	read_poll_timeout(i3c_target_ctrl_fifo_status, val, !val, 100, timeout, false,
+			  sport->i3cdev->ctrl, true);
+
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & ~I3C_TX_NOEMPTY);
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.open = i3c_open,
+	.close = i3c_close,
+	.write = i3c_write,
+	.put_char = i3c_put_char,
+	.flush_chars = i3c_flush_chars,
+	.write_room = i3c_write_room,
+	.throttle = i3c_throttle,
+	.unthrottle = i3c_unthrottle,
+	.wait_until_sent = i3c_wait_until_sent,
+};
+
+DECLARE_I3C_TARGET_FUNC(tty, i3c_tty_probe, NULL, &i3c_func_ops);
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(
+		I3C_TTY_MINORS, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttySI3C", i3c_tty_driver->name = "ttySI3C",
+	i3c_tty_driver->minor_start = 0,
+	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	i3c_tty_driver->init_termios = tty_std_termios;
+	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
+					       CLOCAL;
+	i3c_tty_driver->init_termios.c_lflag = 0;
+
+	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
+
+	ret = tty_register_driver(i3c_tty_driver);
+	if (ret)
+		goto err_register_tty_driver;
+
+	ret = i3c_target_func_register_driver(&ttyi3c_func);
+	if (ret)
+		goto err_register_i3c_driver;
+
+	return 0;
+
+err_register_i3c_driver:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_register_tty_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_target_func_unregister_driver(&ttyi3c_func);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.34.1


