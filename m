Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D740D793117
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbjIEVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjIEVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:41:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A826CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIveLh10H5aopjMzZD3a42DuRq+IvxB6dcigjBGTChsZt4IjVtH4JCtnOv1m4vEsbU61YN3nDMCTZLHK0R9YdL6di9L+1alSr3GeVAADuY2o9/kbbFJWTynh/PSmPoKNdTvMj/ZXdulXOubiCDRZpvJTI1shWdjtVCnuyjq+JGln9bqEaigzFqn1o9mp81Yh0Y9HaD7mTt5OuZUK1gLj4WB11aQeC1FTAjBZd6ynQMpRVjFEwsFDzzA9i7ECmgr6qcUuWjxBPos8Vic5Ko+1N8l0ukA+Y7MWMb5DUMdJiPdFQ62MbO50E9t0R6vfdUVdd8tO+5Bxj4tPa41ijLyhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlawwosMXrMoZ+wp3paBmDaG6KOjXo8Zh5YFVNjP46s=;
 b=erxXcWPwehL3scO/4jCgBc4EoImHK7T2BF0UztbrqmymJM76B7tb6MY7QDtZVGSbMf3IfVOPzJEVdPhMJXD4F5PdXImXXO0szavLLYRLs/Pbj0ag2kJ4HIl2ErtzA5rypO3L0XnfM7e7TA01IyU2+2R1vAO0KTbtmwa3+c8fF8WwxL49wdAmW6AWiRNWzZI0gfwc+kW8vr7CxHdjEX79D/ZekRYwxpXKHSoQX52lbYcyeza2CIB+fZf0A3ayzbRI+7W651OmNXk8+3oY0ElHmDUvkwG8Ihnr8IQeNsJKGwCUNmw2Y0Io/Z5doesosORLRk1TNVrz/uVk4Vl9AsALIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlawwosMXrMoZ+wp3paBmDaG6KOjXo8Zh5YFVNjP46s=;
 b=LsyOlxEweBR3/hZoZ0OJnVMvjC+xReKiPVLm0QSm2fOfEjlKwyLl1tfSSZ7IY/BVL/RFa9PcZ69aFwgs9nUKui7EhwsBykYORpT5SLAzk0lA/a5GxqCFkLWWKGPYB6wfeJi5preggybBvAWB6MWU8f/xnhmL0nXkDxmJhCS6hRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 8/9] tty: serial: add tty over I3C master side driver
Date:   Tue,  5 Sep 2023 17:38:41 -0400
Message-Id: <20230905213842.3035779-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 020a5abf-5767-44ef-7ecf-08dbae588f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Xf2k0Xpvbu/NTAKjP5FXz2SqtlmSGWTQ0sChxnGeQXqr+Ek8o+4cUgsimm/VQr8Epc0GgjmyKEW7bG8Geb7Jml0CZkWS/ZXSGDJXG0ecEG5DiRCYfhonkJFbhu8tyHkw4jeulLSxLIiTk5iNiESk5iHHKsrtqSZaPebFt2Jf5ufklMMOJwgMe1t6yWU2fE1ceC2RfwNJCIw2Gh+xTf5eDYYloq+VnJnDeorMqol+DFQl+oS4yfw1TDj3AliYKKMlUkLwt7ipu84PqDakPx/AnmLqBi39GZS0XbxSOU7H+iW7j59hZXGmVmVRUNKI9127GB0bCKjvkWmie/ceeL0zuaMJUv2CZbInrgea+A6tS+0O93ux9+htZzaVqAHs6U9ILpO+eBMSYYPWZl6RnFszIOZ8Sxh/eifq50kWadkZeM8Oqmiqenj+rzwgXNIz63hmnc6s9C+nL7/B7OJsWP0WHrJpiIapLcQIPVhGdFc+g/kVW3BchaJ0GDE/E7tsculxgo0gkV/ovumB8uWFF/uLS/CjF8sOC2bTRZV5MGlUGGa5kRIWuFoVAA5X2V3CYnlgJ/l1w1tiNg0DwuKisv1iDRtUWOL6wz9uq3SiCfZFpY7k3aGW0NSKIviBtnjoqL5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrcqDp+nKzK6Hmqb1bn7lPKo+FbONQPk2/CtHz0oTQ2uHt7csCpWiNJ2PJ4e?=
 =?us-ascii?Q?Z1cagxOmvFXck/nMw9vpUJmOfml6wlokRHgxw9xZ+AN9jelUvAZkCP0tMICA?=
 =?us-ascii?Q?2bXpy1uT+SeXk9hy1MkzCoUA3c1ubbyDUh1iBF/0dcJO/nt0F6RvbaJfbWnL?=
 =?us-ascii?Q?mNae9SGdjhpioi408MRPX06jCaEu6McN6u1lzbLf0u8JNZAOfq7P3OdqJzew?=
 =?us-ascii?Q?qdkusagljQYJkTsb5bGa/46RBjYdzsmJwOQ3RUfZ+wSM8wB7cycoZVhSo3Fr?=
 =?us-ascii?Q?qaM1axErk4BXPQOQ0Cyk5lHHrn4dHEhPJYYGzzQ37gk+xbSGFY2JujGyrB7j?=
 =?us-ascii?Q?9dV0GqDKwMGXqHDBf5keRwOc6ZcnCfwPSSeAS6ImOFFYHaBdqvXr68cfhndN?=
 =?us-ascii?Q?rJazAyc7/F+n8kmg4XxZ7KNxQloTmPgRMNQIzlDYpJuAq4GMzgGYKBCaOkdT?=
 =?us-ascii?Q?cq+tVr2eYmm+awCdzxLp+a3rkIXE7gjXs52rUForuuMAXrVvI2X1lLTbMuWs?=
 =?us-ascii?Q?6z08YnWe5YjFvTi04FH8GgJzX7bFo5+/lodQzOO7rqDBqNQOpc4VacZQJc/Y?=
 =?us-ascii?Q?8z6x3D973zEXgTcAikxve4A9QeVEg89TAI+x59Cmyfk+cW3c50JFaPKm969K?=
 =?us-ascii?Q?lvJp/fyEhkNyux3EA+1tQ0VlItCLJVEm9Bc83Uv/paYiSz69ipM1xIm+GHcX?=
 =?us-ascii?Q?z+YNcvoI89H5VGtGX7L9X9YAPmupvvYBo4uVdRlmFibYwvSBH6PnwFrfXet2?=
 =?us-ascii?Q?leN3FsZh148yg9/pb7BhFMGXtCS1/OyTQerwsMTB78qsoZ41J7C1k4A8Oz+3?=
 =?us-ascii?Q?a5Se8CB5mdEFjTuRHB9riWzM53WBgCGO6P9wLEH+Lbx+j1cwPtfJx3THEGuQ?=
 =?us-ascii?Q?bqagJGW52GqDglFdjTe4i0oe+09X0a8PDz5qxSPHEBUy9/hakdVDma1OaB7r?=
 =?us-ascii?Q?Sk9ZMWIzHTRH4IEuPElu2MnFMY97lBWWSdQXBTNw/y7cPkKJsFZ/Hxxu0WUd?=
 =?us-ascii?Q?0YTktXmQ5rgurtIFry1OiKFk+62YI/GBkfWG6czNNxV2ctdiEvkC6IfdXtx3?=
 =?us-ascii?Q?TN3aizUnD0Xw/Ahytgw9qTEFFxkjPV+N5cVUqz1nzwuI4wfSF561KLIdzzRU?=
 =?us-ascii?Q?JgZmFRfvYzA189TcvFbNziSodHt7U8xw8PbFfMQgqqWEBjuBM6e7nsb2KnLd?=
 =?us-ascii?Q?yvyTlXWAjLwXnZdKnq/Srxbz0aVXrtMpAmQFnOCrv6GmTzISTFw5qIMGlV+p?=
 =?us-ascii?Q?qX8T/KmLFjKoc0wMRkAhXEqHZ9dyptNln6PAo+GkZk0pegSX6cLuW3i340KX?=
 =?us-ascii?Q?czDqHNGrjumkrlz6nSQHMPp0wORaoosgN3wfgoTFulaHs7Y69olZ4v2WFVlW?=
 =?us-ascii?Q?wHiJQsX98HoM9NXXMhGdB3hyS2hbqY+3w1W9KO4XrPXzkR/8ZvGAfzV5NcRH?=
 =?us-ascii?Q?oddBtJfqDRRPMaE8+qV5lecRi97BpW1FZbO08q9+G+QSUqi71VRMk9b/zdCZ?=
 =?us-ascii?Q?jWs3peMbn4hfjp9P64rERp+gaJdMghk6G4/TGJtqZDQHhzUtHEVVIqFplrlb?=
 =?us-ascii?Q?FIRkn4JWD+Z90pqp/4oaFRbAuPFK3BjF0ZKgorlN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020a5abf-5767-44ef-7ecf-08dbae588f13
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:18.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+tOKtF5PYf5t353wafuWwuyo4FQVHRHPZ6KWbb+KPNN8NhI+2RdzUj10qR3N53NUGSszJKpY43NwFYm7FFxtg==
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

This is master side tty driver for tty over i3c.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/Kconfig  |   6 +
 drivers/tty/serial/Makefile |   1 +
 drivers/tty/serial/ttyi3c.c | 276 ++++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/tty/serial/ttyi3c.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bdc568a4ab669..2ceafe94cd1dc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1578,6 +1578,12 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 	  but you can alter that using a kernel command line option such as
 	  "console=ttyNVTx".
 
+config SERIAL_I3C
+	tristate "tty over i3c"
+	depends on I3C
+	help
+	  Select this options if you'd like use UART over I3C master controller
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 138abbc897381..60c101809cdcf 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
+obj-$(CONFIG_SERIAL_I3C)	+= ttyi3c.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/ttyi3c.c b/drivers/tty/serial/ttyi3c.c
new file mode 100644
index 0000000000000..e2912c8bac87d
--- /dev/null
+++ b/drivers/tty/serial/ttyi3c.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/tty_flip.h>
+
+#define DEVICE_NAME "ttyI3C"
+#define PORT_I3C 124
+
+struct ttyi3c_port {
+	struct uart_port	port;
+	unsigned int		txfifo_size;
+	unsigned int		rxfifo_size;
+	void			*buffer;
+	struct i3c_device	*i3cdev;
+	struct work_struct	work;
+	struct workqueue_struct *workqueue;
+};
+
+static struct uart_driver ttyi3c_reg = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "fsl_ttyi3c",
+	.dev_name	= DEVICE_NAME,
+	.nr		= 1,
+};
+
+static const struct i3c_device_id fsl_tty_i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1000, NULL),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, fsl_tty_i3c_ids);
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
+
+}
+
+static void ttyi3c_break_ctl(struct uart_port *port, int break_state)
+{
+
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
+static const struct uart_ops ttyi3c_pops = {
+	.tx_empty	= ttyi3c_tx_empty,
+	.set_mctrl	= ttyi3c_set_mctrl,
+	.get_mctrl	= ttyi3c_get_mctrl,
+	.stop_tx	= ttyi3c_stop_tx,
+	.start_tx	= ttyi3c_start_tx,
+	.stop_rx	= ttyi3c_stop_rx,
+	.break_ctl	= ttyi3c_break_ctl,
+	.startup	= ttyi3c_startup,
+	.shutdown	= ttyi3c_shutdown,
+	.pm		= ttyi3c_uart_pm,
+	.set_termios	= ttyi3c_set_termios,
+	.type		= ttyi3c_type,
+	.request_port	= ttyi3c_request_port,
+	.release_port	= ttyi3c_release_port,
+	.config_port	= ttyi3c_config_port,
+	.verify_port	= ttyi3c_verify_port,
+	.flush_buffer	= ttyi3c_flush_buffer,
+};
+
+static void
+i3c_controller_irq_handler(struct i3c_device *dev, const struct i3c_ibi_payload *payload)
+{
+
+	struct ttyi3c_port *sport =  dev_get_drvdata(&dev->dev);
+	struct i3c_priv_xfer xfers;
+	int i = 0;
+
+	memset(&xfers, 0, sizeof(xfers));
+
+	xfers.data.in = sport->buffer;
+	xfers.len = 16;
+	xfers.rnw = 1;
+
+	i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+	for (i = 0; i < xfers.actual; i++)
+		if (tty_insert_flip_char(&sport->port.state->port, *(u8 *)(sport->buffer + i), 0)
+		    == 0)
+			sport->port.icount.buf_overrun++;
+
+	tty_flip_buffer_push(&sport->port.state->port);
+}
+
+static void fsl_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct circ_buf *xmit = &sport->port.state->xmit;
+	int cnt = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	struct i3c_priv_xfer xfers;
+	int actual;
+	int ret;
+
+	if (cnt == 0)
+		return;
+
+	if (cnt > 0) {
+		xfers.rnw = 0;
+		xfers.len = ((xmit->tail + cnt) > UART_XMIT_SIZE) ? UART_XMIT_SIZE - xmit->tail :
+								    cnt;
+		xfers.data.out = xmit->buf + xmit->tail;
+
+		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		actual = ret ? xfers.actual : xfers.len;
+
+		uart_xmit_advance(&sport->port, actual);
+
+		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(&sport->port);
+
+		cnt -= actual;
+	}
+
+	if (cnt)
+		queue_work(sport->workqueue, &sport->work);
+}
+
+static int fsl_tty_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *port;
+	struct i3c_ibi_setup req;
+	int ret;
+
+	port = devm_kzalloc(&i3cdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = i3cdev;
+	port->port.ops = &ttyi3c_pops;
+	port->port.type = PORT_I3C;
+	port->port.dev = &i3cdev->dev;
+	port->buffer = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
+
+	req.max_payload_len = 8;
+	req.num_slots = 4;
+	req.handler = &i3c_controller_irq_handler;
+
+	dev_set_drvdata(&i3cdev->dev, port);
+
+	INIT_WORK(&port->work, fsl_tty_i3c_work);
+	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&i3cdev->dev));
+	if (!port->workqueue)
+		return -ENOMEM;
+
+	ret = uart_register_driver(&ttyi3c_reg);
+	if (ret)
+		return ret;
+
+	ret = uart_add_one_port(&ttyi3c_reg, &port->port);
+	if (ret)
+		goto err_add_one_port;
+
+	ret = i3c_device_request_ibi(i3cdev, &req);
+	if (ret)
+		goto err_request_ibi;
+
+	ret = i3c_device_enable_ibi(i3cdev);
+	if (ret)
+		goto  err_enable_ibi;
+
+	return 0;
+
+err_enable_ibi:
+	i3c_device_free_ibi(i3cdev);
+err_request_ibi:
+	uart_remove_one_port(&ttyi3c_reg, &port->port);
+err_add_one_port:
+	uart_unregister_driver(&ttyi3c_reg);
+
+	return ret;
+}
+
+static struct i3c_driver fsl_tty_i3c_driver = {
+	.driver = {
+		.name = "ttyi3c",
+	},
+	.probe = fsl_tty_i3c_probe,
+	.id_table = fsl_tty_i3c_ids,
+};
+
+module_i3c_driver(fsl_tty_i3c_driver);
+MODULE_LICENSE("GPL");
-- 
2.34.1

