Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666487FFEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377190AbjK3WpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjK3Wot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:49 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03CF170D;
        Thu, 30 Nov 2023 14:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahWYx3686Sb84A4KwBFL9gW10GwWIg0xTm/RaDMFusCjNdUNKOQay7RELnMbWNIpuu7W/E9q2rLTtrnjY3dYmRmPSx863NKOxCdM9v668JybhVtg10CeLdtQHow/Fy3c3Ku14uGsn9VzZPhaxLEQG4Ghx7BJrBWbM4rKT8aF6ij8oUBkZvNQ+pCIhLa/9mbksJX4mFtAuuA+0TcNnfHV3B7AA8LIHI0D32c9EOtx59gAzX9oj1Edesf7D7DbrrYKSvcKDIQDGDvBR0gvTit4MBeRqREJdPlaHfHyTtaz5X2FuSAkdPll6nwk4OBOSko+zRR584t/m5gpkSQMA5QOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVwdPYrdC9yolJaLwxvjAv/rL0dBVumdMjDodYqNwX0=;
 b=oXst0re/eFkosVVqyD6UCjYaEI9gcOZe8/h+sbitLPNtO6XOE5mfPm1doJiamJgKR6Y1KA2oOqnfSMad5Cxo+YXz88bYJdWMKslL2YXj9XBAZZsWB/3vw0p+ZNwcCjqp8zj8xljr5SE2fKZKPjm0e9UQye4l+76s2r0V0FLZ+yp1ypj/fJOEatr+qFFfXsBa+cuknPZTpqLR4er4bIJ4WevwrE9ZxAlK5X90Y2gr7lIbPX3fMTUdbTbqSU+KIs8IQLeSFUPaXU1u3Ct1hYdB+W42U/vwpTAc4Q76+OdfNe8+ceb263yRlu9hwYgk94GFNfhUZrstN7Xo3BUYaIKt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVwdPYrdC9yolJaLwxvjAv/rL0dBVumdMjDodYqNwX0=;
 b=I6eILvFj1tnR7rnSsZPg0Xc9GT+HxZAJZmXsv7b+izeZTnA9rvoGXGnvb/ygKC1Co7xV/xTv1N679IUdxXPEIs4MfzYiAlOh8dWoP4HFPYmleim6e/tfvh72a2Fprz5/WJvgNEDkezvN8PBUqfgvisy9+8qUTbWs9DF1UewuSOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 7/7] tty: i3c: add TTY over I3C master support
Date:   Thu, 30 Nov 2023 17:44:08 -0500
Message-Id: <20231130224408.3591288-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f5fbdc-4f32-41d4-44d8-08dbf1f5f619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9P7xxkFG9o00fIQw2uewAq3mhKWAbwEQNHMC7++2dJpIgyXFPBGPgUU1cA4uvs5FaETpeFixGpGV8aEmPY01IQ14l9Z9Uh165VuHzE6091F0Mq1GI/TOmjdSXaY6z2qIzsh9iDuYWZYdgX1Zwoem30uRl5uieJqlnYOmU+M+6T+hgpGIrBhSz1EpMUq9PTp/R5jrrUrIlD9nRAxDS8hBCHBwZgcCmnr44X+mna+y45qYzgaHv6tlgPvEdCWoSR2VbVc4hdxtlJclKV2ZoHtfk9YUMbw3ANOLkpDZ0Foi/P0izes9KCUeSS3FvN/GLLyaOK93wNvE0+B78A+AZYusXJ2jsrTC7Z90RQvpL54OAZgo19k+kJXmr0b9/7qdwiO1OZcELrRhfGSoVXhF1rsZI5FY7VxxgGjyqyXKAJYw/lgDk5NWGrZ9Hp5VWG2slG79A2RxPc+3E43h5FQ4dyUzHA/yjWmp/UfButjrqE5ccURRDAEbqoDd+8ZOhtRd58N6mUc2B6/wv6bhBLwkuPzHMxy804YPTPyr6bnhDFutNQCKhc4VMyo2wleB+YLXJlmPsnbgGtxVY5+rxnK7E+84YS7LhvhYzY1VyVhIrwKkqZHvB6HzKJ5Gj05Ps2xusW/K9p7vvevT6gElq0V5uCzRfGtBjokQnlTIDAa/5SNIdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(30864003)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJGaz2WghYT23b++ymyVbKY8a6o3tGhcSt0JBsE6nreD8exZnnrf3l0n1pTB?=
 =?us-ascii?Q?dKWgVyjKG4YTScotIRolXK1BxLvB46seNpxmgWbDErj+WGNaS0wSN6yIIiv0?=
 =?us-ascii?Q?GjmY3vox0YJb1mJqpUJKX+QPd4cu8S1nH8Hk4Wkq+pz+GGf8l71CqV2RjXhb?=
 =?us-ascii?Q?WEKtD3wZ99M7Kw1x8Ay9YDnv9rFo2p4fBa5YF6EEw2cK3kQlvCIbulAbzJOp?=
 =?us-ascii?Q?rCayZB78/xyXXqyz3lL2K4vdTZ1KZkjuCYZAdMB/VY7S2Es0Y8dVfja1Zc6W?=
 =?us-ascii?Q?R1u0R+mY3C8A4sCDPmHZm2op37LVori0sp3XQmDDv3L6fCQW7tEMA296k9/i?=
 =?us-ascii?Q?pe1kdOU+NgSgPqxHpCVnP2Y3gcMpdwgjFCLBJ+0nzBqVse7MmCZ3kCqwLPrm?=
 =?us-ascii?Q?/s8nb5Q4oYOGUmimv5PeamP4mKIRd8In51xU7PxnWyMx4N513rjfoRNQO6M5?=
 =?us-ascii?Q?i0UIKC9camouiqoMFcx/zfjz57V8Ohdsv7Ohcuu3oQ51D70o7lrYqzYtm5+D?=
 =?us-ascii?Q?0FZZtkeRLvc3RQ599hAeIav268p7HgvG5oaMviWKtEgDwvWjcN1U7oYT1sZJ?=
 =?us-ascii?Q?t0sdKKdALhgnHzE3tby445huREm+LUygQnh4HuOxUus+WUHvlc/niL5+Hk/d?=
 =?us-ascii?Q?K5cMi2RttRvoYCyhfPvwqFnqe68yYz6dvWJvTmtujQQug4WkiSWXbE3shQZa?=
 =?us-ascii?Q?zqiGBtP6g4G/07V+2lMF5Hd9KjiDGqpGhcjMMo2I/kloBj+DqbeCOJZ7iFrG?=
 =?us-ascii?Q?yojjv/Rps7WF0H0xPXUHaCOKc+OfGoK3cLlRaRIDDqO8GG1nsp07iQZgE1hN?=
 =?us-ascii?Q?cSMcABHbQN5zcSxYzQI4yE97UPPK52qqE1INbK28Mgz5yWsVWb6dY6q1Xwpj?=
 =?us-ascii?Q?MtdqHkJn6Bn9DxuRaqUYEyfhtdus0EdvDRdLu8s3fVRRuRg2cpK2ua1TrT59?=
 =?us-ascii?Q?hwZr8auow0bGan+sdy6xPeq6wq4TSQLbTNuleSWbsMtnmEtBlLqDEp7sS4np?=
 =?us-ascii?Q?F3KoItP9kEgRdBESU8R1ySCX6w4usr4vBrCldQfQG29m93WdGsPeUpFTL36U?=
 =?us-ascii?Q?qdmdssNfO3tyCLRyRNDQ50/PM9it+oafhgiumbsZTdyR63OCtugs/WVQnLHi?=
 =?us-ascii?Q?W3CTXJ8iJAjo+vXmStouatf6vFa0vEg9IfQwMqaFXmtUO2LDHqLmp6v4bKU8?=
 =?us-ascii?Q?zvgL5oc9U//Rbfv7+1Ixg5Lf+WtNozybVoZSBmQ8T5TwNIqPSbwX+xY4nl2o?=
 =?us-ascii?Q?Cb6LvmP5yGD1rWHdhGC/juv6IMH5aQisklStrJZDutaVX2Y1yr1l/+k5rBMG?=
 =?us-ascii?Q?sojz0ZEBLHxTLU//zGxJWlKf8gXQQS+fnOZyeWesIVRRf9U5Qu6gRhRvsUjj?=
 =?us-ascii?Q?iBGupZWy44c6KI1l5chNeUMc7MR47OKaI7/gVtplg8ZhUNfdAkUlnnzn292U?=
 =?us-ascii?Q?sMaFgPcT2s6b7J0uQzlnC+q4atIJ5vM4H2T/uunu5LQeCSx7F8F7QVX8AgpZ?=
 =?us-ascii?Q?WhjFrXQ+6kgr7YlQDV2TYMYdVvYU57UgPH1sflOr5/7xD6FmhO+l1v2UXTpL?=
 =?us-ascii?Q?OEBCOo4x0HxkNt5JeAn9qLe+i9ki1hCXyF+26bS7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f5fbdc-4f32-41d4-44d8-08dbf1f5f619
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:50.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv5tjaCEsfKI1jO+uv6dxGI3/YQP7nOLTC7Fp/E3KW+egOuI8bmO8ohYSMmrR9KA2OLKIr1nHMFjRSc5NochEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
    Change from v4 to v5
    - send in i3c improvememtn patches.
    
    Change from v2 to v4
    - none
    
    Change from v1 to v2
    - update commit message.
    - using goto for err handle
    - using one working queue for all tty-i3c device
    - fixed typo found by js
    - update kconfig help
    - using kfifo
    
    Still below items not be fixed (according to Jiri Slaby's comments)
    - rxwork thread: need trigger from two position.
    - common thread queue: need some suggestion
    
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

