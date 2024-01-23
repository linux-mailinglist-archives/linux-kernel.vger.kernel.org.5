Return-Path: <linux-kernel+bounces-36175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF3839D09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1201E1C22AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB85B21C;
	Tue, 23 Jan 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kn54h7qB"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770645B1F5;
	Tue, 23 Jan 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051488; cv=fail; b=UpJiuMPnM1ejAAGfiXvI19DihMaZXU6p3+meZb0geDRlmucwaRzkHVnH1AkMOngzgEUkweZ8dmmrr4BSZxoYfdzSMdmBAcm6xwEPKRf46HQieAefr5oYKlvvjwFdyIPXoaHAulUTihmKMDgTrT4oaIBdNyOFNIZUPXv22MpFmC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051488; c=relaxed/simple;
	bh=23Zrugn41ufadFybEsxMIRXjfH4sZn99V7/xL4FkvrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QR/VDTvuxU++l1QyZv8CV+7L8T+Iz+H/ims5anXnrN+RXvjc5ikss44/vlVVX/Mz1Hv+1MZ6NWWUnR/K1Wgg6+kbcQZCUqviw1WsLoBgU1Bh5elOKqUCy7Hyh9z7hKqeP+gQYJFCoPLs104pzMtsL9RlsV1KJ3dk37dII7NItgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kn54h7qB; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvKQv3W+mKZc+LCG7Fa2D7OvbyFtzSmS39yqzaDJ7rCS/L6pAIVeYukVTsVrfSvBAT1sjczAcp0G4C5vVXd5b6dXnTqCacwyY7Mj+TpW6ZmS6aT+6c2V1hYkFUwCORp7HyTq9rmNHj5IyeXbSujJ4n6xmcVAxKyPhzJPOMtskI4dCC8J3i6DudCuSWRAn5swGtjBA7QY2UfP1if9Mw4htyxPosri9o6yRlkuaqxS/90+v204YxhutBcic24uYLUGG4VbfyzNvz9+DTcBeNfOUfi/2W3uh/f0sKZUrBPTjAQ8yL03u9V/BIltgP5z/DlIYnF2e2piMO4FpDMvdqQ0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elXeixqm9OIPId/PL+W1dlakQnATLdA4uJRwdF4nyGo=;
 b=A+CCq8dC4C8I7n0jJL4adJcuJ+hs1rdjG1Xa/3HQXuFZJ8XT0o3aUzsHjz/VbSeP8C52nLy5GwTohXrszzVQwy6FrJL5wD0uuJZv6S6KciP9Hw5VOOGMHKNwq0mINLVXLPduWBqG/YWfScG2aJu8M2aDcKzet9mNkeXkCkvaM+o+agQk3LK3qq5Cd3KRfOFwAJsQ+36Whq0efUuwspE9ET6oL8YYMBuey6h7KAtdqes9MVGmZ4tz2SAN4DIdsRymVq7/Isdb5jhENHs+sbP9EjoJ5wZkgR8Zj2nSy5oyOilIC7/JDbN5eFe9AoTD2sFt6CNxyYO1/FZ85bN5oFic/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elXeixqm9OIPId/PL+W1dlakQnATLdA4uJRwdF4nyGo=;
 b=kn54h7qBkgL/06hw7lX9QSbP6SFvf8FUUQr2G1ESCy3NXHDBKkVljpsTx8ZV1W6UyuYMLQ3REeg3LOLfounbcRwU+qBptwupjF1rz9UOYCD+9JQ3epqRODDFP42f7dcfmHbKLLl7+bC5itztxvyPhXygxw7SQu1FREqc/xAw8a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:24 +0000
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
Subject: [PATCH v4 6/8] i3c: target: func: add tty driver
Date: Tue, 23 Jan 2024 18:10:41 -0500
Message-Id: <20240123231043.3891847-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50a431b9-2f00-4374-1574-08dc1c689e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LyxIHKdIyjl3gUUEE1JqHbGwMjsNPdEGmcxgQL5FLrudj3/Xxn2CM39uCkLRvK2D8LmBWzx0v0R+/Iw2kRZd3mF3YXH72lnzNdze5eRV111dh1h0q5stbqB1b6Ce98ffoTr1q6vnwA+7fQ0vdqld3qysI9FQ/FauSGkmrYLb6wKi643E3PLh2nVsRfIbmqdB8z5hAgJgGipi5K7fQXiNosiZfCIaHpcJ6dHyNfbiKmKCVy251l63dfrqPeKQ75Y23VVu3/jC5yQJoZOO2NyBf0rInIk9po8q7h+0yznwt0J0XFoU5e5/TKl7uDBLpQeqEGNTzrQKNKnkiV4Fm7LfZhbaKnnINQ11VSandpBxGqFBXW7MYpcKT7YvxDOeQsW2ZpJ6LgYis0oWq7gyycUeKldUA/W0zai68F8PpapKRtXCQ3ZurlmeY4OBQgQkUJfQJSVSeacy6oCEbx+4iwtFoQ/6rmOwhBvum8VX5hvjVGKso+S6+aCT4Y1ahp6xq1sAZwp8piDOaWzQonLivoXhiMK91GA3meZPeZv3sQVpgk8ovhJ4hP651XqX6GlvmiDNeULsTX/IRYMVicbvloH/4giNKoceg477vKarXyt8JDdeAT2/3mub3kU9t1OF94nG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(30864003)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/vEF8zrihrwL6yIcR7UC6a3vUfpduTNZzAQetk6pFIO7PT20QrOq+KTsNBC?=
 =?us-ascii?Q?IG/m5TVsyZfS/Tf3w7fAj/dm6CIu7Eeczpyo7YAnYujcS9vsvCNtXwY8efE7?=
 =?us-ascii?Q?6OPu1lY2+Vt6LxtutKn7jLpdS9Yfh74ZR5EPyGs+yIyCTYwnHnAb2r2GG/8V?=
 =?us-ascii?Q?587/3hqz1+6JxP0D2MjOtrlnkpHW2t9x+Acms2ZG8ZCWqq/Ho/p3JmGHSQHC?=
 =?us-ascii?Q?ZIZUxcoK22m7V5q7bCFIK87GFzj9hZ0iiq2OiWuVIyD3bCFsfVycdfITagC5?=
 =?us-ascii?Q?G/ISRcYShIlRANReeGxDAohlNpEAidiTbiakN0YG4eOUrJgXAjvBPmYxnnN1?=
 =?us-ascii?Q?nZjRLqUjHv8hLQfY/xo+4ympwoggIFJUlN93xpFiKZHAcu5nejBEEcHUzAG8?=
 =?us-ascii?Q?ni+dUhFrsCfaApwDF2yFvIM8WpV50JUoyfsVL4Y/Y2y1gzqrsSvKGPkLgZU5?=
 =?us-ascii?Q?0/n1Grlq3EUDlhajNjakicMGbHBaxugyZg9FrjOiCmDmQufWH57gSXXmFRBN?=
 =?us-ascii?Q?X9F3tXX5HZ16p+J6q/yDvdBNwYHkFDI2oAFNsrl5RRtyr3hBoYQBpZpP5CEj?=
 =?us-ascii?Q?rjPh8hbN2fvNKdgpdrdzHg/TfGcQZg4Qa46DOt+u++w/FGHawQHkOOYIFVeL?=
 =?us-ascii?Q?PGO5Yb7ALfXgDxbMXdkx0ywpMlKDoBR9a6sSXP0+zRrE8rIhh0EDQyQK7+Z9?=
 =?us-ascii?Q?D3SjnxgM/mkQZdURV70EX2HV9WEcVwdLrPmP+Bd6j8UIceAAJ3DzCUci++KF?=
 =?us-ascii?Q?8VMLn4X+e2sKIh2szy9uTipnU8pS6Ax84hnj3NtVxrebVzIn5dqe0Aq+0lQc?=
 =?us-ascii?Q?C656qw6//7cltiCBXePI0DgJk2TKMjSEsPQP6Tngyb5JqbCjoc7FxqaXbhWd?=
 =?us-ascii?Q?dzjyWcS16umshSaDD3lQvt2UPVeM8PbU5jBFi5Ib0neyQ7hp1AiiejinlFSZ?=
 =?us-ascii?Q?JtTTb02DMH0L9sv55cdFbwvCv7QhrjznbPjc7k0ouCk4BqLc+dGHCLi8YHdB?=
 =?us-ascii?Q?1pX3AF5Yc1aTag5iTzTGZGWHXd7nDaRK0vpYJPcU9iY0Wg2+Eg9LzpUmrWDs?=
 =?us-ascii?Q?yWfmDRlrR50pXHxVgUSmfwuIMBLji+4TS7oSTRaQAwa+QTlJ+JDrhotAh6Ur?=
 =?us-ascii?Q?JH0KzDM2C7639B2otCAXX+QgXovHT927zTjn57WtyH75CgYPLNCUj9EDfcwT?=
 =?us-ascii?Q?SpgKnhxv1emswcuC12oi6bZ22JYdiyYYNMAYmveZgL6nqhFpq3Gpl0LAeAPq?=
 =?us-ascii?Q?mzXzEZJS1nC9xhVKTkF8+Noq8pKO/kDeqSEplTzqCBTSanq3g1L2Bh783ALp?=
 =?us-ascii?Q?LQOwp2EHajFMUp1iFjh+jaZDOr1jT52U8VfgFWzqH71WKCTbXE8Nsr6nOFht?=
 =?us-ascii?Q?cCtA2uj0O7fuR7y+RM6dUyEAG7SVdk0TIe59UcuHapnx4DvVuSVz/ODm3Zzg?=
 =?us-ascii?Q?UW35PULzulDuDyssXZy+GnSL5mky0bmtv7l4DqLg+lifM0KWcqlAPGIcpaG3?=
 =?us-ascii?Q?c4YiNOw40i8XrGos5pBVpMe9K5S9Ja6AfSdSssjQQwyD4dFcOOllJVkvHOxV?=
 =?us-ascii?Q?WGgZ/n1OTj8SfOy4oUOTRUE4ssdTvVWb8c3luRbn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a431b9-2f00-4374-1574-08dc1c689e5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:24.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q39h5xzwwj0kS/eYNt36FJHguFGyJqWejgn/DepoDRcX83yH34JQA7AOqD7aLI2Ic9RjcBe4LuWt+IQ9vaLdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

Add tty over I3C target function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig       |   3 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 475 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 491 insertions(+)
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
index 0000000000000..bad99c08be0ac
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/i3c/target.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
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
+		req->buf = (void *) (sport->buffer + offset);
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_target_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err_alloc_req;
+	} while (req && (offset + rxfifo_size) < UART_XMIT_SIZE);
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
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
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
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
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
+		dev_err(&func->dev, "failure set i3c config\n");
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
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & (~I3C_TX_NOEMPTY));
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


