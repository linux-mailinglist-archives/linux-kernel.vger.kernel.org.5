Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D277B793111
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjIEVkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbjIEVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:40:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D1E73
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARkJfgFrooAjDoAKYRoYF3E1XxbBQaRkFkfB049ZSbMQcTeXFZYb+11nI9qVCxE6hAU1t16v8x00ZBUr8jnRwO9F2v8vZHRjl5X9ldbP4mXEJkwnMF8K2bqI24ukxJiUTw5hjwa+ZDHHYuV8Zb5Dqj/Q3h4M/l+uSWcB3mY2ZuxZF7JvHypeYSa3RBD+u+bmkq7vvJIYGOej0PFKe9H2DpQsFpqQBLX2unJ3B2I/boIig2Idk9Nn2v+6Bz4L6b2ZVymw0sVr2cCDJN+JxZUnvYS5ejzRU3nYbBgYe1ZCMH9GOMfxDtmiROYB8mmxjdCFZE6hlJz/95EkZSCUdmv2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhAWRTZ9ZJxtjvZDtNLnMvxl6E4HoftWE2I+MAyjVkA=;
 b=REYX7p55l2cbcWmbkWx8kovoUnYv43BMgSTb1XoA4VYOSz9A4t9TGTbk1G9ImKPZQjKXQC6a8D7mbmMvF1pm5cN4hcA0O3n/m5xV0awWr6WBJS2Ryq0We0UWFZ4LIAZNdQUAnrHBZNZQufndzqM8j89k4gLnkgxITSuxxJYZih4iLlg9UB7d7VgJjMSGnR+BsdjCiuq6HRkc2Ha8c9rpdG5B43aQyJbHOPhvXWzKXVSLBfamTppUDCiWNZL0aWma7Q/r+iaoO03u4hlKWWu/U2s0PGTSVfbAMqdIhLUaCQPHvEEAC+1Kslm5M6EoJsIvd3o5w/iuk4yP5+vgAvmRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhAWRTZ9ZJxtjvZDtNLnMvxl6E4HoftWE2I+MAyjVkA=;
 b=oGEDXsez5HxemAcXAMXlFA3Tw141e9jhunFHwM3JKQsnqXCEHMKK9bQxKwEZtbac2fAGHTP7Yd+mByaOmWr0P7K/J3qzJb8ZKrl9ASq3y+D22xJ12PnuhzzhZnjNUegx71Mg+N21lp/6I86F3KRFZ3JVGx83v8Yc117Azbn8YgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/9] i3c: slave: func: add tty driver
Date:   Tue,  5 Sep 2023 17:38:40 -0400
Message-Id: <20230905213842.3035779-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905213842.3035779-1-Frank.Li@nxp.com>
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: edf7fabb-6481-402f-44d4-08dbae588dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 329Aw+11HxrovyNPjKaFqNV7D6M9QKtqFLcik0TWqV2B+2HSQbZNpWeqpjEqWiHp4k7E3SZfQjshBGzURiW7xbtsM72tTozz6COHl65oxWt48vyMD1+x01AbQ4sLYQZG0PLTgd63HGo+yPPA1VbvodJEO0cV8JM3qnfedEs53kqcqN+tblUt/EQgPf0xp2Yyn8bNy0XzFSDJwY5uCG1ZrHhUo9Zc2Esky486xEU0wJUaW8UGczWCyZ/GqfDXPTpdE6RX+ZaWJl72LZstRDBouEcSmG/W3jTb5cQq5YMJJlL7kME92sNhDpahJQJZ/ORyyTTXk1f9ZG1i2GINCVNPmgzXRynq5p6uPdl/LmsX4yLi9fi81s5j0jd7d+JSF7dbffJ+BAnuu21HcTw8BJjicLy/yTpacuM93LVfR07V3BlBLqobzSEAtr+2UszjL7mF6WaIzM32+XE6/4TDUdk8txPwBjmXxOiupFSkcVIE/bUuoZ9zOqO6+M81+GCodryrxMtl5g+CIVFitkoSXRuz2xBEu4x+SfQFzY42QhsNyudTwsCCFoLjgGvvNeoRdN3C5YXF3UJZu7izcWm+J2X0lAlxz0V4wLpPeJkX8bRLWsskJJaXC5i1N0TLJ1Ra9/7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqYxuuQuYaceM2jH9JXksIqtnIBRy+vxQaPZglOUvm1VLppyF9+lULKV/3xO?=
 =?us-ascii?Q?DmNAoN9cNDzYqs6ZcWSu6Pasl6tN15Y/vNSQvt4RHGqRwkkEqkMID6QmhZ7z?=
 =?us-ascii?Q?oH/8/i02bv7A6W+dVDLNNrk2+/G0yklOLSdDoQ8kc6ToZdrWAaa8iZcQtsJb?=
 =?us-ascii?Q?pSsauq4wL0+GnV7a0dUXZ88HWx/vMuDL5SbLdPTeNgvybSQSpXSZKm+rELoY?=
 =?us-ascii?Q?2L5pb+xX5/wsxlaB88CUoCTzjnl4FIt53JIHjQU+Ey0zW2R1mhN/n3BEeos0?=
 =?us-ascii?Q?xxY1A+msxgfR+VtBDBSbjErDXYSKYIKb/zaGCstPh1EkVJGbb0mHvCkIm3oy?=
 =?us-ascii?Q?n0vPM1p+1vy61NtLfBo7vtHACgfsMBJKzxvaawyyknH6wTzbtjOgkTBRLqbV?=
 =?us-ascii?Q?RahNl6XkzyuQ0CwpBwqdU4pNJmwILSuckL+/SP49uCvblM6ml39M0NeNLxh6?=
 =?us-ascii?Q?aVnGFMtNSWF8cT3yMB9KXdGO8O90Hn6OhTSJaZW2NW4TlVjNX7exQbsMmRVT?=
 =?us-ascii?Q?fy8EVJEzZvHfKDz+FJd/4p67JJaGVpZC4Z1+8F05MgNZ+grBRRWb0CGPB2LX?=
 =?us-ascii?Q?OQw8/Kl3P0tlXzGMGF2XIwRedl6imaBkx4p9oqMRJCud/bveJPkCeEb/L4Ok?=
 =?us-ascii?Q?eaEDOxZtUK/2YOVEP4sL+bhR/PfL5zdaDDLzx1cqQZYSESzJawZbKWCb4xoQ?=
 =?us-ascii?Q?4ztEATFSMPRWBh7feZIa5lBaoQaU2q9DFZZFCiJvHGzmJ8FeETmkKn+fuB2p?=
 =?us-ascii?Q?kc9PcU6TH86M+q0atLR/0xmZwp0Wff7tingxMKESP1cjFp9titJ+MTMfDTD8?=
 =?us-ascii?Q?80J8y6VB7XVtHMr0blcsOLrQGI/hpqx7HyNb6lzt2o7Km/2LvSJpS+2twKZD?=
 =?us-ascii?Q?jO8WVB1/sudhRBC94XbCxVnSffpSqBONrzulOkFkOCL8Ms9PbWfs01ePT9WX?=
 =?us-ascii?Q?lPlWLp1EA9sYnAcCHhxxY/G8qrH8vfNsyg73hpVUrVn/HaiI8wk70lcnfh9y?=
 =?us-ascii?Q?VZV1qmRqNMBfaKPjU+QfPhgVCMVQRkKgMjxTsMBD3rqOIza77bnM6+zVuHSy?=
 =?us-ascii?Q?sWrmBwGepjXxNTihqRABsTAYfFsL7jkeITY4Gc94MHLNwOfF5l53VK1O/Oho?=
 =?us-ascii?Q?D2OvKe1Sp6clvpQukN5t0B45JPszfGT/kEyK6ZlNcQH0ECq3uLNrhr9+gMrh?=
 =?us-ascii?Q?cWbXZrtI6+O6Q4XFD29JTn8HVNmvrBu2aiCxIzEkL/LMDR67NoJsCZFVha//?=
 =?us-ascii?Q?YcovYUE+XVktPblzr9RU4PzmatmqcC4QcRYNbORHN1rM++W5hkUnaz03Mr1o?=
 =?us-ascii?Q?iWhIxNr1RCGtTcel7EKlpUdGGqGCOBl8QckSS7Jw2Oj5UxsHwai2pZXnCwmh?=
 =?us-ascii?Q?Tzl6LyAJzhjFiFedhQydjY2ihBieG2al0j4NPDiyow+Rs2vBoghC9E2lVuAJ?=
 =?us-ascii?Q?4SEfc9mR0F5ly6hFD415rpeS0R63dxLqpD3+hjMfeHOGNWKrNKR/o9el4pfc?=
 =?us-ascii?Q?pp9uBD0IRNvAz7HHeU6RfD0defEEFW+ticEonPTzUp5YzYHQdW3Lc+BbhvpZ?=
 =?us-ascii?Q?1AKwHh3Bj6Zw4OyLaxKGWhIWCfgd0w/a/0q9JNUL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7fabb-6481-402f-44d4-08dbae588dcf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:16.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI8e4dadcGdDMJBy12u4+R7UoOXZyKnHykbwP2j1GfqgYOzerfyGEfGliDK99FyghEeugA94IytNP8Bnc5S7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tty over I3C slave function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig       |   1 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 345 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 359 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index bdc173bc0da12..fa0f63e0e3e6e 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -50,4 +50,5 @@ config I3C_SLAVE_CONFIGFS
 
 if I3C_SLAVE
 source "drivers/i3c/slave/Kconfig"
+source "drivers/i3c/func/Kconfig"
 endif #I#C_SLAVE
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index ef1acbe13fe60..7814bf2dd9b40 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_I3C)		+= master/
 obj-$(CONFIG_I3C_SLAVE)		+= slave.o
 obj-$(CONFIG_I3C_SLAVE_CONFIGFS)	+= i3c-cfs.o
 obj-$(CONFIG_I3C_SLAVE)		+= slave/
+obj-$(CONFIG_I3C_SLAVE)		+= func/
diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
new file mode 100644
index 0000000000000..f122e2cc32de8
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_SLAVE_FUNC_TTY
+	tristate "PCI Endpoint Test driver"
+	depends on I3C_SLAVE
+	help
+	  I3C Slave TTY Function Driver
+
+	  General TTY over I3C slave controller function drivers.
diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
new file mode 100644
index 0000000000000..db3262e402edd
--- /dev/null
+++ b/drivers/i3c/func/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_I3C_SLAVE_FUNC_TTY)              += tty.o
diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
new file mode 100644
index 0000000000000..be43878913452
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/i3c/slave.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+
+#define PORT_I3C 124
+
+struct ttyi3c_port {
+	struct uart_port	port;
+	struct i3c_slave_func	*i3cdev;
+	unsigned long		buffer;
+	struct work_struct	work;
+	struct workqueue_struct	*workqueue;
+};
+
+static struct uart_driver ttyi3c_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "ttySI3C",
+	.dev_name	= "ttySI3C",
+	.nr		= 1,
+};
+
+static unsigned int ttyi3c_tx_empty(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ttyi3c_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+
+}
+
+static unsigned int ttyi3c_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ttyi3c_stop_tx(struct uart_port *port)
+{
+}
+
+static void ttyi3c_stop_rx(struct uart_port *port)
+{
+}
+
+static void ttyi3c_break_ctl(struct uart_port *port, int break_state)
+{
+}
+
+static int ttyi3c_startup(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ttyi3c_shutdown(struct uart_port *port)
+{
+
+}
+
+static void ttyi3c_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
+{
+
+}
+
+static void
+ttyi3c_set_termios(struct uart_port *port, struct ktermios *termios, const struct ktermios *old)
+{
+
+}
+
+static const char *ttyi3c_type(struct uart_port *port)
+{
+	return "I3CTTY";
+}
+
+static void ttyi3c_release_port(struct uart_port *port)
+{
+
+}
+
+static int ttyi3c_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void ttyi3c_config_port(struct uart_port *port, int flags)
+{
+
+}
+
+static int ttyi3c_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	return 0;
+}
+
+static void ttyi3c_flush_buffer(struct uart_port *port)
+{
+
+}
+
+static void ttyi3c_start_tx(struct uart_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	queue_work(sport->workqueue, &sport->work);
+}
+
+static void i3c_slave_tty_rx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_slave_ctrl_free_request(req);
+		return;
+	}
+
+	for (int i = 0; i < req->actual; i++) {
+		if (tty_insert_flip_char(&port->port.state->port, *(u8 *)(req->buf + i), 0) == 0)
+			port->port.icount.buf_overrun++;
+	}
+
+	tty_flip_buffer_push(&port->port.state->port);
+	req->actual = 0;
+	req->status = 0;
+	i3c_slave_ctrl_queue(req, GFP_KERNEL);
+}
+
+
+static void i3c_slave_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+	struct circ_buf *xmit = &port->port.state->xmit;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_slave_ctrl_free_request(req);
+		return;
+	}
+
+	uart_xmit_advance(&port->port, req->actual);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&port->port);
+
+
+	i3c_slave_ctrl_free_request(req);
+}
+
+static void i3c_slave_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	int cnt = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	int actual;
+	int ret;
+
+	if (cnt == 0)
+		return;
+
+	if (cnt > 0) {
+		struct i3c_request *req = i3c_slave_ctrl_alloc_request(sport->i3cdev->ctrl,
+								       GFP_KERNEL);
+		if (!req)
+			return;
+
+		req->length = ((xmit->tail + cnt) > UART_XMIT_SIZE) ? UART_XMIT_SIZE - xmit->tail :
+								    cnt;
+		req->buf =  xmit->buf + xmit->tail;
+		req->complete = i3c_slave_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_slave_ctrl_queue(req, GFP_KERNEL))
+			return;
+
+		if ((xmit->tail + cnt) > UART_XMIT_SIZE) {
+			req = i3c_slave_ctrl_alloc_request(sport->i3cdev->ctrl, GFP_KERNEL);
+			if (!req)
+				return;
+			req->buf = xmit->buf;
+			req->length = xmit->tail + cnt - UART_XMIT_SIZE;
+			req->complete = i3c_slave_tty_tx_complete;
+
+			if (i3c_slave_ctrl_queue(req, GFP_KERNEL))
+				return;
+		}
+	}
+
+	i3c_slave_ctrl_raise_ibi(sport->i3cdev->ctrl, NULL, 0);
+}
+
+static const struct uart_ops ttyi3c_pops = {
+	.tx_empty       = ttyi3c_tx_empty,
+	.set_mctrl      = ttyi3c_set_mctrl,
+	.get_mctrl      = ttyi3c_get_mctrl,
+	.stop_tx        = ttyi3c_stop_tx,
+	.start_tx       = ttyi3c_start_tx,
+	.stop_rx        = ttyi3c_stop_rx,
+	.break_ctl      = ttyi3c_break_ctl,
+	.startup        = ttyi3c_startup,
+	.shutdown       = ttyi3c_shutdown,
+	.pm             = ttyi3c_uart_pm,
+	.set_termios    = ttyi3c_set_termios,
+	.type           = ttyi3c_type,
+	.request_port   = ttyi3c_request_port,
+	.release_port   = ttyi3c_release_port,
+	.config_port    = ttyi3c_config_port,
+	.verify_port    = ttyi3c_verify_port,
+	.flush_buffer   = ttyi3c_flush_buffer,
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_init      = ttyi3c_poll_init,
+	.poll_get_char  = ttyi3c_poll_get_char,
+	.poll_put_char  = ttyi3c_poll_put_char,
+#endif
+};
+
+static int i3c_slave_tty_bind(struct i3c_slave_func *func)
+{
+	const struct i3c_slave_ctrl_features *feature;
+	unsigned int rxfifo_size;
+	struct ttyi3c_port *port;
+	struct i3c_request *req;
+	int offset = 0;
+	int ret;
+
+	feature = i3c_slave_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = 16;
+
+	port = dev_get_drvdata(&func->dev);
+
+	port->buffer = get_zeroed_page(GFP_KERNEL);
+	if (!port->buffer)
+		return -ENOMEM;
+
+	if (i3c_slave_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failure set i3c config\n");
+		return -EINVAL;
+	}
+
+	req = i3c_slave_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+	do {
+		req->buf = (void *) (port->buffer + offset);
+		req->length = rxfifo_size;
+		req->context = port;
+		req->complete = i3c_slave_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_slave_ctrl_queue(req, GFP_KERNEL))
+			break;
+	} while (req == NULL || offset >= PAGE_SIZE);
+
+	if (i3c_slave_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failure set i3c config\n");
+		return -EINVAL;
+	}
+
+	ret = uart_register_driver(&ttyi3c_reg);
+	if (ret)
+		return ret;
+
+	ret = uart_add_one_port(&ttyi3c_reg, &port->port);
+	if (ret)
+		goto err_one_port;
+
+	ret = i3c_slave_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	uart_remove_one_port(&ttyi3c_reg, &port->port);
+err_one_port:
+	uart_unregister_driver(&ttyi3c_reg);
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_slave_tty_unbind(struct i3c_slave_func *func)
+{
+	struct ttyi3c_port *port;
+
+	port = dev_get_drvdata(&func->dev);
+
+	i3c_slave_ctrl_disable(func->ctrl);
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, 1);
+	uart_remove_one_port(&ttyi3c_reg, &port->port);
+	uart_unregister_driver(&ttyi3c_reg);
+
+	free_page(port->buffer);
+}
+
+static struct i3c_slave_func_ops i3c_tty_ops = {
+	.bind   = i3c_slave_tty_bind,
+	.unbind = i3c_slave_tty_unbind,
+};
+
+static int i3c_tty_probe(struct i3c_slave_func *func)
+{
+	struct device *dev = &func->dev;
+	struct ttyi3c_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = func;
+	port->port.dev = &func->dev;
+	port->port.ops = &ttyi3c_pops;
+	port->port.type = PORT_I3C;
+
+	dev_set_drvdata(&func->dev, port);
+
+	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&func->dev));
+	if (!port->workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&port->work, i3c_slave_tty_i3c_work);
+
+	return 0;
+}
+
+static void  i3c_tty_remove(struct i3c_slave_func *func)
+{
+	struct ttyi3c_port *port;
+
+	port = dev_get_drvdata(&func->dev);
+
+	destroy_workqueue(port->workqueue);
+}
+
+DECLARE_I3C_SLAVE_INIT(tty, i3c_tty_probe, i3c_tty_remove, &i3c_tty_ops);
-- 
2.34.1

