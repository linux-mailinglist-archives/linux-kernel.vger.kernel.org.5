Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869927D1370
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377846AbjJTQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377833AbjJTQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:00:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E9D4C;
        Fri, 20 Oct 2023 09:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8PDm1A5e18BAwdK8RMjeEYSrzzNxkcyWabljL1qQTCZwJFomTrOu1Sn+Obhae3UxF0xCTf5Vg9rsgldKN8BSR4/JIwAY897mb/7lI9fL/xdWskiJau0hUVZH2HNP1o4DaCknG3569iPjqYbtTQxxgbkpULo+vbMq3McuPJBEUMpqJKwhX+j/dbTC7uKUz5viKIEt7ZsleNBTt9xP8whK3pzX4hr9tQ8a4SxTDpEk1i5gjeGMG8BSV7ltF/uxaHM7V6aVM4lmIK+11LUj/uK1+/C+v9Ngvrw8Z8zOc7ap4g4hHxEPVYUIv8xVbKkpNmj1ZJMXaMzk0jeWW2297S4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUpxPo+cIzQGKRx7O68+E5muR38ltWm33tnC3QvfRjg=;
 b=OMIpqiTbZbKOCNWc2Aqs6N3BmUVGbyJBW8oETcsPR6ZJGyY0u0+h68gpq9pcF2fKMe5N9r+Ddu9SLxUF6wNmJ4v9hELiVN29ZIbAIT4BCTufQU3eHpzR6EOEX95Lb4/n97M63IB/T4dfgnUntezjhhhvSYMhnOb3G4Sh0c11krO0bglmVdoxjiLbasLB05qmgAP42KLiqhKiec7fEGuVcYxOgvfZxxbEiRNP4DNaBsvZ3DHtqJVCGAOiy+ZrdZSg2Suu6oMxsTDWPKAEXk/cZhAYEFLMgGyyJ2F8yyoppWOIwLh26jMQk4UqC3SBDU+Ztm1c3zNvB974th7dzYHB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUpxPo+cIzQGKRx7O68+E5muR38ltWm33tnC3QvfRjg=;
 b=UN/Bi7r+/GPD1pX5YKVr34yqVEnfuZsj+OiuAsrQQePUb3FTas3qahBJUCgfLmUZctEgOfnVUpsIJ1Q7BNAOLpRiKD/tFT2eWSfg2PVa5BMk9kfmYib/z9tZTB5wOgPGSWmAQ5fdUpNKcJguTjBxQAW5jeLOjPjKVB3PTvsyySQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6879.eurprd04.prod.outlook.com (2603:10a6:803:132::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 16:00:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 16:00:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Date:   Fri, 20 Oct 2023 12:00:27 -0400
Message-Id: <20231020160027.3663772-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: b54dc00a-23f4-42e2-c609-08dbd185b7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWmaxYqVBQrzNbaTfTRIEu+HwtnrMcjiygVpMSua6JeJ5+IUXGCyUEofkxAzjBtPjCD2DIOb6/c5bHIhAjldTD0Elh0p8nD6yYq1YI8zSFFgzI7wIM6ugR+yNdH86GXK4BNzm69RYevmna7rRfH990RIwBPeZztnl7S09REeX/QMCjsOwMZHLz7BQK214ybBmmalUQB+laDM49AoPDik7CXXaP4Pt+MtZSMm5YrNCXnQwB6b35gfBFhdSPNxfRzsUCHkoQPh7hEjA7Euf/gmK58jLd2OUW/xkWIyQnsdFYxMfRZxU8SYGJAPkZPlSIK1lhgs8GLIaDJO37m5j63BC4AvQxohB2Bhr+MZWdlILnSj3FdWIJwX3elIfhF7aM04EYg0mnwUgHcZCAZi/SKyWRMjVujyen8IBOTVw2HrL0JukYnJCcCzYdLMuNxeZ1H3LddNs5arr8WBEmQPN25p67ycQ4tmkX5mWZlzIeQXoPrk2flxFPUq/lz09AKiLMuF+UFTJLeI34m/8Qrhe6ikT6JUpJbM/80cHzM1m1c0HnfMr5OhWakY5YZhy/WOlNJgMav5qdF5twvdHn/oEXAJAn2g92G1P1hOegxtFbYyaEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38350700005)(86362001)(2616005)(30864003)(38100700002)(8676002)(41300700001)(4326008)(5660300002)(2906002)(7416002)(1076003)(6512007)(26005)(83380400001)(6506007)(52116002)(8936002)(36756003)(478600001)(966005)(6486002)(66476007)(66946007)(6916009)(316002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qwdxeXBJxX8nv3tN8F+tvJg2hcIUPeKeEkjMHDa1a47mJMK8NAG2VtycUdu8?=
 =?us-ascii?Q?ywPeVNtr9nNSchmEPN0P8oD2vvHCcnPz8/f6iPPbXmhThgGzeLXSPh16rQDJ?=
 =?us-ascii?Q?ZgUrcxNBvfoN00QgQvjaa5sOj27o765npoNL01Zvu7YZ0Qi/OHwHpe5WViC/?=
 =?us-ascii?Q?+epZ0R6emAQLAxfi6syq55doLOKyTcVEQiPiNeV3qRi+5iABmsH4DXKOp5Zs?=
 =?us-ascii?Q?dIoptnqsV14oGJ9TEHld4nfZITTeI10T3gzDgsCIBRK5YBhw3xhGrW7LLakH?=
 =?us-ascii?Q?BctcbGEcWGvisWDyOBx3HB63rEB9SGEWDdoquH7arbw3CQ4ywspUUlv0tFD9?=
 =?us-ascii?Q?w8Nj2nViI+BFQZvMoYO+UWLuJ8c+etbtPPtCruHh7fJv3PunX7O/C50AJACe?=
 =?us-ascii?Q?+ocbPuOzYSThrXILnJY+mWGkgilUBZ4ENw7wlz+xS9jnucNQzxV+p6JBmtxK?=
 =?us-ascii?Q?8/eFhecOB9ah57dSU2L+wotGp6bX3TWRtdNmCwKB+xFS0BGq7XAxOVkOhOZ5?=
 =?us-ascii?Q?/fPS+ef7nDRex80pd3D8PrLKXZErwK2vskx24LCcCkSbUdEntyaowvIYF2Bt?=
 =?us-ascii?Q?/piLjAacM2KsFGqFh3sUNlfebjPTd1qpUK9Ke4EXSbvlDRpG+Ef8vQaff/T7?=
 =?us-ascii?Q?ekb+DR2roP0bqlRaBYa2o+dO3XooSP45Yju7o7x2PVK+pLXCe2dwWVwHM2+7?=
 =?us-ascii?Q?nomYtFxR+IvYxTmUoUDCf/m0YfTMjv1QGAQyKtir9EXmyBPTGZGnuygZ34nl?=
 =?us-ascii?Q?N8Ae5mHLLZ5nDVnNPzOqI4n1O1tuOfjyGlRkF+Z2CXz4ou+jZdp+Cz180UwW?=
 =?us-ascii?Q?flLugnb0XQdr/XUlfC2YUCOEQJTKAGojXASifZlhIgiOjjtwXCGC6IdUU9R3?=
 =?us-ascii?Q?TlRgpCj0rB+T56t9Vqzz/li5TD1e/xPcEvp/Mis5nXWdKsXzn3e0R7agV5z0?=
 =?us-ascii?Q?CSwUFvRaKC3UvjJBC3SeZw9YnlAAtbI9zxyYXLglpt4QeQ7/vU5mn5nG1zSW?=
 =?us-ascii?Q?HdIjA6edkgBCuIFZM/DC97sxV8AdU/MXsg/oagwWk0kpCj887Oh4qjY1AAAH?=
 =?us-ascii?Q?CqzkdxZ81akcRubcLq3iKcPoRE7aqnYvon8CVcY+x/QIck6dxflThE/OMWDP?=
 =?us-ascii?Q?9KHI0yJj8VrxFbptq4tJhYxdZT0ZjDulS4NnNQImFk9uEVUX0eaIpy/SnW60?=
 =?us-ascii?Q?OAbe1w29mIPLNefdQrCGPusWu3IoNBbUiI8KEjmyNODFKLG/YoqNt0eUQHea?=
 =?us-ascii?Q?5cg3P19nGT9TjgiMybVp3E3U9eVhEDnY07PyjcX6KEomJHPyGv2dfkEVXJkR?=
 =?us-ascii?Q?8+zyGP3arozPGZzeyS5G2EPYYXzgQJWNSMoW9RvE0cLtEpSlvy6NeKMNbuQt?=
 =?us-ascii?Q?OdT5ZVqNsSW2VDs2R0omCNH0DeLucohFhnvL8N6tRmRgMCk/nMJUTVZwywSV?=
 =?us-ascii?Q?2w8CXWLla1R3fWheVp0lKqWT4eyTSKcbWSqVD8h7A8atw654xRrB3U6zbN0m?=
 =?us-ascii?Q?pN0vZkRVURdugnUIAYoorune9rPkkS0Xyp7AdafdiBTCVnDScXnU7dX7+MJM?=
 =?us-ascii?Q?voyPa3GqGUiDlkaaW4fEoixYHxMeYKHUb+KrgXUM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54dc00a-23f4-42e2-c609-08dbd185b7a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:00:44.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtxeorsEYDAZ5hqVLnKp0TJ5Yj6YhSw2pF+cHsMMqhiueYUl087BYb/QKKF2adX4loyNney8VILptZOZhjYCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In typical embedded Linux systems, UART consoles require at least two pins,
TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
present, we can save these two pins by using this driver. Pins is crucial
resources, especially in small chip packages.

This introduces support for using the I3C bus to transfer console tty data,
effectively replacing the need for dedicated UART pins. This not only
conserves valuable pin resources but also facilitates testing of I3C's
advanced features, including early termination, in-band interrupt (IBI)
support, and the creation of more complex data patterns. Additionally,
it aids in identifying and addressing issues within the I3C controller
driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    This patch depend on
    https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t
    
    Change from v1 to v2
    - update commit message.
    - using goto for err handle
    - using one working queue for all tty-i3c device
    - fixed typo found by js
    - update kconfig help
    - using kfifo
    
    Some idea about i3c tty in future
    1. early console support
       - early console is useful to debug boot problem. It requires as simple
    as possible.
        i3c SDR mode, 9th bit is parity. I3C target can't block master send out
    data. so never block kernel boot even without any expected target connected.
    i3c master may send out a boardcast message as early console to every
    target devices. Only a "i3c-usb-acm" can show it to host's minicom.  And
    this "i3c-usb-acm" can plug in at any time. Write a boardcast message is
    quite simple at I3C controller. After kernel system boot to certain phase,
    switch to this driver.
    
    2. multi port supports. create multi virtual uart ports, so firmware, such
    as arm trust firmware can dump message to difference virtual ports.
    
    3. compatible with UART network adaptor, which defined at MIPI DEBUG for
    I3C spec.
    
    This driver is just first step.
    
    This patch depend on
    https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t

 drivers/tty/Kconfig   |  13 ++
 drivers/tty/Makefile  |   1 +
 drivers/tty/i3c_tty.c | 443 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/tty/i3c_tty.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd9..b13645f2d72bc 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -412,6 +412,19 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config I3C_TTY
+	tristate "TTY over I3C"
+	depends on I3C
+	help
+	  Select this options if you'd like use TTY over I3C master controller
+
+	  This makes it possible for user-space programs to send and receive
+	  data as a standard tty protocol. I3C provide relatively higher data
+	  transfer rate and less pin numbers, SDA/SCL are shared with other
+	  devices.
+
+	  If unsure, say N
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55d..f329f9c7d308a 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_I3C_TTY)		+= i3c_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/i3c_tty.c b/drivers/tty/i3c_tty.c
new file mode 100644
index 0000000000000..1497759cddb76
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/tty_flip.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+static DEFINE_MUTEX(i3c_tty_minors_lock);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		256
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_RX_STOP		0
+#define I3C_TTY_RETRY		20
+#define I3C_TTY_YIELD_US	100
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	spinlock_t xlock; /* protect xmit */
+	char tx_buff[I3C_TTY_TRANS_SIZE];
+	char rx_buff[I3C_TTY_TRANS_SIZE];
+	struct i3c_device *i3cdev;
+	struct work_struct txwork;
+	struct work_struct rxwork;
+	struct completion txcomplete;
+	unsigned long status;
+	int buf_overrun;
+};
+
+struct workqueue_struct *workqueue;
+
+static const struct i3c_device_id i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1000, NULL),
+	{ /* sentinel */ },
+};
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	int ret;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret < 0)
+		return ret;
+
+	sport->status = 0;
+
+	ret = i3c_device_enable_ibi(sport->i3cdev);
+	if (ret) {
+		tty_port_free_xmit_buf(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+	tty_port_free_xmit_buf(port);
+	kfree(sport->tx_buff);
+	kfree(sport->rx_buff);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport =
+		container_of(port, struct ttyi3c_port, port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(workqueue, &sport->txwork);
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
+
+	queue_work(workqueue, &sport->txwork);
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
+	clear_bit(I3C_TTY_RX_STOP, &sport->status);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	set_bit(I3C_TTY_RX_STOP, &sport->status);
+
+	queue_work(workqueue, &sport->rxwork);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+
+	tty->driver_data = sport;
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
+
+	wait_for_completion_timeout(&sport->txcomplete, timeout);
+	reinit_completion(&sport->txcomplete);
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
+static void i3c_controller_irq_handler(struct i3c_device *dev,
+				       const struct i3c_ibi_payload *payload)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	/* i3c_unthrottle also queue the work to fetch pending data in target side */
+	queue_work(workqueue, &sport->rxwork);
+}
+
+static void tty_i3c_rxwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
+	struct i3c_priv_xfer xfers;
+	int retry = I3C_TTY_RETRY;
+	u16 status = BIT(0);
+	int ret;
+
+	memset(&xfers, 0, sizeof(xfers));
+	xfers.data.in = sport->rx_buff;
+	xfers.len = I3C_TTY_TRANS_SIZE;
+	xfers.rnw = 1;
+
+	do {
+		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
+			break;
+
+		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		if (xfers.actual_len) {
+			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
+						     xfers.actual_len);
+			if (ret < xfers.actual_len)
+				sport->buf_overrun++;
+
+			retry = I3C_TTY_RETRY;
+			continue;
+		}
+
+		status = BIT(0);
+		i3c_device_getstatus_format1(sport->i3cdev, &status);
+		/*
+		 * Target side needs some time to fill data into fifo. Target side may not
+		 * have hardware update status in real time. Software update status always
+		 * needs some delays.
+		 *
+		 * Generally, target side have circular buffer in memory, it will be moved
+		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
+		 * there are gap, especially CPU have not response irq to fill FIFO in time.
+		 * So xfers.actual will be zero, wait for little time to avoid flood
+		 * transfer in i3c bus.
+		 */
+		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+		retry--;
+
+	} while (retry && (status & BIT(0)));
+
+	tty_flip_buffer_push(&sport->port);
+}
+
+static void tty_i3c_txwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
+	struct i3c_priv_xfer xfers;
+	int retry = I3C_TTY_RETRY;
+	unsigned long flags;
+	int ret;
+
+	xfers.rnw = 0;
+	xfers.data.out = sport->tx_buff;
+
+	while (!kfifo_is_empty(&sport->port.xmit_fifo) && retry) {
+		xfers.len = kfifo_len(&sport->port.xmit_fifo);
+		xfers.len = min_t(u16, I3C_TTY_TRANS_SIZE, xfers.len);
+
+		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
+
+		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+		if (ret) {
+			/*
+			 * Target side may not move data out of FIFO. delay can't resolve problem,
+			 * just reduce some possiblity. Target can't end I3C SDR mode write
+			 * transfer, discard data is reasonable when FIFO overrun.
+			 */
+			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+			retry--;
+		} else {
+			retry = I3C_TTY_RETRY;
+			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
+		}
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		complete(&sport->txcomplete);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static int i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	struct i3c_ibi_setup req;
+	int minor;
+	int ret;
+
+	sport = devm_kzalloc(&i3cdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	sport->i3cdev = i3cdev;
+
+	dev_set_drvdata(&i3cdev->dev, sport);
+
+	req.max_payload_len = 8;
+	req.num_slots = 4;
+	req.handler = &i3c_controller_irq_handler;
+
+	ret = i3c_device_request_ibi(i3cdev, &req);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	if (minor < 0) {
+		ret = -EINVAL;
+		goto err_idr_alloc;
+	}
+
+	spin_lock_init(&sport->xlock);
+	INIT_WORK(&sport->txwork, tty_i3c_txwork);
+	INIT_WORK(&sport->rxwork, tty_i3c_rxwork);
+	init_completion(&sport->txcomplete);
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &i3cdev->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_tty_port_register;
+	}
+
+	sport->minor = minor;
+
+	return 0;
+
+err_tty_port_register:
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+err_idr_alloc:
+	i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+void i3c_remove(struct i3c_device *dev)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+	cancel_work_sync(&sport->txwork);
+
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	i3c_device_free_ibi(sport->i3cdev);
+}
+
+static struct i3c_driver i3c_driver = {
+	.driver = {
+		.name = "ttyi3c",
+	},
+	.probe = i3c_probe,
+	.remove = i3c_remove,
+	.id_table = i3c_ids,
+};
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
+					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttyI3C";
+	i3c_tty_driver->name = "ttyI3C";
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
+		goto err_tty_register_driver;
+
+	ret = i3c_driver_register(&i3c_driver);
+	if (ret)
+		goto err_i3c_driver_register;
+
+	workqueue = alloc_workqueue("ttyI3C", 0, 0);
+	if (!workqueue) {
+		ret = PTR_ERR(workqueue);
+		goto err_alloc_workqueue;
+	}
+
+	return 0;
+
+err_alloc_workqueue:
+	i3c_driver_unregister(&i3c_driver);
+
+err_i3c_driver_register:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_tty_register_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_driver_unregister(&i3c_driver);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

