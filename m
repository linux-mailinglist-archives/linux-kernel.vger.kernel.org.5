Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2957CEA89
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjJRV7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbjJRV6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:58:52 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D611C;
        Wed, 18 Oct 2023 14:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDCCyFtK++lBPRYsBmfmy+Z7YktHKr3obxCXkjVbSa6AX2fPkn4evHSdsH0oKbK2HXImFbTH9BNjmZspLxdMtDrGdp7dcsQoPLeZv35eCd5s1Rsfe0+4mBDptstMx+Y02kfFXY44KLvj0njJalC3hVnuExCS251Ps1GBjyKR0zXQ/Bufd1QGx9BCDbavIGEXuRJPCF8ARyr6z7fwG5+ZgceVJyNNb7mAU2N0U6kYU1Zi1dCo6IquuFUGzjs4YRO6AIIBP21N5PR6XrO3ssalipVAhysK96NmIaVmx6TneG0b0NSQMEIqZLz0HEt2FxCn7PAqASUli9dfBQhIQtMEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRPg3ZAAzqjPrdoK4+1RF+xDwAfq/WQ+nzB00HHSd3w=;
 b=Dp4AdxvzvitHn6fNdM2Yxhj5PO01bv+RfBvZphJ32JQ3CANcXdIWSnmJfncCKFsWBE6Ou/hEh5T1jJ3GPhK++zAIB0kERP+qVr1aT/YKlRTAx8Vzj3h/QV5IA8YCfqxJM16AVN/y6PxjS4FDcXu9erE7UgEMC7Cr6EjZ6reOxQcykzlONrfINnyqDgT3V8dfm2uIrp5u3W0reaGy2g+5KNuBtuHY5MU7olo4B5B5hZJopKVwE+jeA/wtQhV623D/G30t+p55XIt3DtY4vK9LA3omNkc+1m2vgZgc6kDHgxsrUuD34wRs7LWcNNCBc4PxrBZe7KOCEypyQVNVRyNHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRPg3ZAAzqjPrdoK4+1RF+xDwAfq/WQ+nzB00HHSd3w=;
 b=JIvTBSSUfZ/6N2UVd8zBTk92KZFaGByDLS7ycDze+fnY+IDexy8pt6wrg+omA4I4rUrm8wK6kzMzQi2ZK2Gtn+5Sk+hG5ZHtwgC3b5GOGpM89hYes4nnrxCAQcaiBiRvDypfJQE7tdTYckoBl6RpkbHpuy9CHbvUjVP8CP/MRtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 21:58:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:58:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, Frank.Li@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 4/5] i3c: slave: func: add tty driver
Date:   Wed, 18 Oct 2023 17:58:08 -0400
Message-Id: <20231018215809.3477437-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215809.3477437-1-Frank.Li@nxp.com>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: da267885-dddc-4eb2-fdcb-08dbd0256670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjjFDqtAnuOUw8qpuLzWGCidVTRxmuhS9xiI7sagQs0WewmVuOBq+SuR1xQH3JrldUgjbYPACyCO/nGUip28VZ6JcdengYxOL71fYJKjvzrbYlC0n1vOl2Bw/VSpnNE0J5qRcgALNyELzcE/SGuEcZgg1+igwqR5YA1TiA8LKKSYVf6OwgsLp2B42YPcNiEvrlubMcziVrSR7W83eBsEXtitkGwOQdQahK65f2dqtPzxzOWBtoJXq7MNKeHtM5G8xJ8wCnL9g0YFquMw+i/mKBkvig8cjd37QOHF7m7G/ryyDyzbFqKZ45psORrsGUnhwjot/VAxFVHeIwM/02lh+VPt1q7jW5imry91lRD0YcB2RqY6Yfoi4FBlWxh7+4aAm5zoMnmUixnFUBZyeKNI4uUuMlCZB6UrRvbICgrN6al5crZzEsgJJWwNy0XtD6M0wOsSRXL0g9e6c98hdQuFAppB7hwod2yNbTZ6GqlIaCDgt2NyIuHXIAUGVo0M6EkHd9SHHf/lJzCJGTiOWuLmSTJ4QxG6M8NsyAbDMH1xvtxyAJ/91HXmtxDZF+PQziEr1tGRlNfXfSeUvSRBLGeWr9PGupl2I6D/iVjZ0v5+NLgqniXh7HMQ760yU1dy2HINa5r4EZc6Z4DOYSUEHwUG6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4326008)(30864003)(2906002)(86362001)(7416002)(38100700002)(2616005)(52116002)(6512007)(1076003)(83380400001)(6506007)(26005)(921005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmIQHfkrDEXQwzUBidAsLqgYl65CUUY9OeK1/it4EMp0qElxZRtnkdmcYCs2?=
 =?us-ascii?Q?3ZT1Q4gGUX5F6jKV3Ii/ennRvPhVjz7wOMybR+XVle+DNoQQ8w4AxgggtpRC?=
 =?us-ascii?Q?BKumV2nCs4oXLPQmqma6xDPeNyH0Mgy1Oa5vskNCnSvVDIhHutIM5rJvWUbB?=
 =?us-ascii?Q?5/7LGf3iiUvBaljfYP3TpCp3IJRTk2spJRhZKgSj47ifOsBS1TpmNaqtToxU?=
 =?us-ascii?Q?iaxwd/cktlSXrixgMmJMEKXurPhYBfLRqv+UE15i4YebyBQvcvhNBud7YohM?=
 =?us-ascii?Q?KWOsBPmeqbt4eBO7CXMYEiKCTs0wqVbhBMvqH0O8YpCybq7Zil8wem0aGvCh?=
 =?us-ascii?Q?jh6mQEtAEPiShqdjx/2cqBFVq6xuFoxb4DSdgYENHR0ycVoAf7zgvZrPkFbt?=
 =?us-ascii?Q?qqIxFbV11LJ4rREnP0HQsWytqtwWnuXPXmIh6kfqnRu1E9jVnI8E9iXyNOPA?=
 =?us-ascii?Q?7k7JupRpsdKEtvYfbHYciNRIJrcnCcL0txycLY6en2hhyLFdn+l8BN/OZVpV?=
 =?us-ascii?Q?GKj1hjoZlZU1MqNuoUBkvy61650cLrjd9Yp6rcWvJcW4uGkBU22lQYgK6W6W?=
 =?us-ascii?Q?HwW0CmQ3YKS9aLs8A/blLYJRRFM84LaizCSVuah8xThxEz+UwZC4RXFVaE4K?=
 =?us-ascii?Q?2sfgHza06iEM/b3I3cFO8F7y5VBOVOyfGVTFus7ARJQBZutnORHJ1c7mpFQH?=
 =?us-ascii?Q?yf+4Iva6oi0+zqssbI3rjXMZyM7PUbIb7oj4n3zTCKSKqwMx2FXzlgxN6cMk?=
 =?us-ascii?Q?6wR93QP2eFcnulDQCpR/ryKsgXeKZcrM1rSZWN2XZypTMBRa2TtZNL8y5dGY?=
 =?us-ascii?Q?lt61X2pmc7K4IcItKOiF16z7/vUeQByQ0JZeBTeVHnt+dtpGu2KeDOVzEX+Z?=
 =?us-ascii?Q?wSTEqIhIY/50743R8cFdTNzl1T4IRpLbO04o/D12EuZtb06XGQ+LzptIZc88?=
 =?us-ascii?Q?wPgD4mWYPVj8IChNjZswq+hV2OI3NnJBjO24NsDQGDEutSw13tSb6u5xJJjs?=
 =?us-ascii?Q?xMXVjSkm6+n5Eyd1F0QfEmNUH9lvsrraGDdKpZ3Wahub1fmRMQ7FFqUQZh+V?=
 =?us-ascii?Q?Kd8TRJ3d/ClRZwdWXca7WEHG+foieegjId0kOgObwWBdrxg4SciVpmASTaNG?=
 =?us-ascii?Q?Rj93HBf0MEiW8DxNWAU7/nSp5Yo6Ds7GL8EO+1a01DR+l56jyLGlzK8wUqKz?=
 =?us-ascii?Q?1TQclwxLLfbM3SyaveLnqkcZ40GnSJK3kvm5Dgv3uItoVLl9ULCjT4kZXObv?=
 =?us-ascii?Q?Jb+JDATyFzSvQEubPF+6zHL3p7XV2mDZPmNQgPs80IiVD5GzfccqNkEEuEDx?=
 =?us-ascii?Q?vKTmssmkXpyNj/OnrsYmc2qiYHK/FtshlcgAmecSmnKl5USNkaejz/nv2Sh+?=
 =?us-ascii?Q?0C+06ZGyxKVw4iVMSZZcMH+3vHDTJzLL1vaX+u2GPBqejJrn0F3ESwqwRmIY?=
 =?us-ascii?Q?ktnOlAujZHA2IcZvkPd8NXfjbQPY8sUJn28njVNqAwJIWZQ0YMZQ6Xia3bdM?=
 =?us-ascii?Q?NBQCgvSSNaoi2V0wNTPAcNCaHfWuxHhu/8RUWJrYk3v5uc5IArdXFdt1OA+L?=
 =?us-ascii?Q?sKUyb631jcLoBM13nzskHKSqkP6ny6sxKmZ/T8D3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da267885-dddc-4eb2-fdcb-08dbd0256670
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:58:45.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JrJ9EdRnx0wSKF7IL4PCKP4wvJk65/Q50FLAGIQkHs7I6B7nTNYvIhTsJnM/zJrgCA0kXD2r5F9XGhmN6P91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750
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
 drivers/i3c/func/tty.c    | 548 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 562 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 802a9b3576f13..9b87cb4a84d85 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -50,4 +50,5 @@ config I3C_SLAVE_CONFIGFS
 
 if I3C_SLAVE
 source "drivers/i3c/slave/Kconfig"
+source "drivers/i3c/func/Kconfig"
 endif # I3C_SLAVE
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
index 0000000000000..3ebf5bd2592a2
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_SLAVE_FUNC_TTY
+	tristate "PCI Endpoint Test driver"
+	depends on I3C_SLAVE
+	help
+	  I3C Slave TTY Function Driver.
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
index 0000000000000..ea48db49b2764
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/iopoll.h>
+#include <linux/i3c/slave.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+static DEFINE_MUTEX(i3c_tty_minors_lock);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		256
+
+#define I3C_TX_NOEMPTY		BIT(0)
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_IBI_TX		BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	struct i3c_slave_func *i3cdev;
+	struct circ_buf xmit;
+	int tail_in_queue;
+	struct completion txcomplete;
+	spinlock_t xlock;
+	void *buffer;
+	struct work_struct work;
+	struct workqueue_struct	*workqueue;
+	u16 status;
+};
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
+	for (int i = 0; i < req->actual; i++)
+		tty_insert_flip_char(&port->port, *(u8 *)(req->buf + i), 0);
+
+	tty_flip_buffer_push(&port->port);
+	req->actual = 0;
+	req->status = 0;
+	i3c_slave_ctrl_queue(req, GFP_KERNEL);
+}
+
+static void i3c_slave_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *sport = req->context;
+	struct circ_buf *xmit = &sport->xmit;
+	unsigned long flags;
+	int cnt;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_slave_ctrl_free_request(req);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	xmit->tail = (xmit->tail + req->actual) & (UART_XMIT_SIZE - 1);
+	cnt = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	if (cnt == 0)
+		complete(&sport->txcomplete);
+	else
+		queue_work(sport->workqueue, &sport->work);
+
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (cnt < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+
+	i3c_slave_ctrl_free_request(req);
+}
+
+static void i3c_slave_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct circ_buf *xmit = &sport->xmit;
+	int cnt = CIRC_CNT(xmit->head, sport->tail_in_queue, UART_XMIT_SIZE);
+	u8 ibi;
+
+	if (cnt == 0)
+		return;
+
+	while (cnt > 0) {
+		struct i3c_request *req = i3c_slave_ctrl_alloc_request(sport->i3cdev->ctrl,
+								       GFP_KERNEL);
+		if (!req)
+			return;
+
+		req->length = CIRC_CNT_TO_END(xmit->head, sport->tail_in_queue, UART_XMIT_SIZE);
+
+		req->buf =  xmit->buf + sport->tail_in_queue;
+		req->complete = i3c_slave_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_slave_ctrl_queue(req, GFP_KERNEL))
+			return;
+
+		sport->tail_in_queue += req->length;
+		sport->tail_in_queue &= UART_XMIT_SIZE - 1;
+
+		cnt = CIRC_CNT(xmit->head, sport->tail_in_queue, UART_XMIT_SIZE);
+	}
+
+	ibi = I3C_TTY_IBI_TX;
+	i3c_slave_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+}
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	const struct i3c_slave_ctrl_features *feature;
+	struct i3c_slave_func *func = sport->i3cdev;
+	struct i3c_request *req;
+	int rxfifo_size;
+	int offset = 0;
+
+	feature = i3c_slave_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = I3C_TTY_TRANS_SIZE;
+
+	do {
+		req = i3c_slave_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+		if (!req)
+			goto err;
+
+		req->buf = (void *) (sport->buffer + offset);
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_slave_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_slave_ctrl_queue(req, GFP_KERNEL))
+			goto err;
+	} while (req && (offset + rxfifo_size) < UART_XMIT_SIZE);
+
+	reinit_completion(&sport->txcomplete);
+
+	return 0;
+err:
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, false);
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
+	i3c_slave_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, true);
+	i3c_slave_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+
+	sport->xmit.tail = sport->tail_in_queue = sport->xmit.head;
+
+	i3c_slave_ctrl_fifo_flush(sport->i3cdev->ctrl, true);
+	i3c_slave_ctrl_fifo_flush(sport->i3cdev->ctrl, false);
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
+static int i3c_slave_tty_bind(struct i3c_slave_func *func)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	int minor;
+	int ret;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	if (i3c_slave_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failure set i3c config\n");
+		return -EINVAL;
+	}
+
+	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->buffer)
+		return -ENOMEM;
+
+	sport->xmit.buf = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->xmit.buf)
+		goto err_alloc_xmit;
+
+
+	spin_lock_init(&sport->xlock);
+	init_completion(&sport->txcomplete);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	ret = minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
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
+	ret = i3c_slave_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+err_register_port:
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+err_idr_alloc:
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, false);
+	free_page((unsigned long)sport->xmit.buf);
+err_alloc_xmit:
+	free_page((unsigned long)sport->buffer);
+
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_slave_tty_unbind(struct i3c_slave_func *func)
+{
+	struct ttyi3c_port *sport;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_slave_ctrl_disable(func->ctrl);
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_slave_ctrl_cancel_all_reqs(func->ctrl, 1);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+
+	free_page((unsigned long)sport->buffer);
+}
+
+static struct i3c_slave_func_ops i3c_func_ops = {
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
+static struct ttyi3c_port *i3c_get_by_minor(unsigned int minor)
+{
+	struct ttyi3c_port *sport;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	sport = idr_find(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	return sport;
+}
+
+static int i3c_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport;
+	int ret;
+
+	sport = i3c_get_by_minor(tty->index);
+	if (!sport)
+		return -ENODEV;
+
+	ret = tty_standard_install(driver, tty);
+	if (ret)
+		return ret;
+
+	tty->driver_data = sport;
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int c, ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	while (1) {
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+		if (c <= 0)
+			break;
+
+		memcpy(circ->buf + circ->head, buf, c);
+		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+	i3c_slave_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status | I3C_TX_NOEMPTY);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (circ->head != circ->tail)
+		queue_work(sport->workqueue, &sport->work);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+
+	if (sport && CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE) != 0) {
+		circ->buf[circ->head] = ch;
+		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
+		ret = 1;
+	}
+
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE))
+		queue_work(sport->workqueue, &sport->work);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_slave_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
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
+	struct ttyi3c_port *sport = tty->driver_data;
+	int ret;
+
+	if (!i3c_slave_ctrl_get_addr(sport->i3cdev->ctrl)) {
+		dev_info(&sport->i3cdev->dev, "No slave addr assigned, try hotjoin");
+		ret = i3c_slave_ctrl_hotjoin(sport->i3cdev->ctrl);
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
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	if (!sport)
+		return;
+
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	struct circ_buf *circ = &sport->xmit;
+	int val;
+	int ret;
+	u8 ibi = I3C_TTY_IBI_TX;
+	int retry = 100;
+
+	if (circ->head != circ->tail) {
+
+		do {
+			ret = wait_for_completion_timeout(&sport->txcomplete, timeout / 100);
+			if (ret)
+				break;
+			i3c_slave_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+		} while (retry--);
+
+		reinit_completion(&sport->txcomplete);
+	}
+
+	read_poll_timeout(i3c_slave_ctrl_fifo_status, val, !val, 100, timeout, false,
+			  sport->i3cdev->ctrl, true);
+
+	i3c_slave_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & (~I3C_TX_NOEMPTY));
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.install = i3c_install,
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
+DECLARE_I3C_SLAVE_FUNC(tty, i3c_tty_probe, i3c_tty_remove, &i3c_func_ops);
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
+	if (ret) {
+		tty_driver_kref_put(i3c_tty_driver);
+		return ret;
+	}
+
+	ret = i3c_slave_func_register_driver(&ttyi3c_func);
+	if (ret) {
+		tty_unregister_driver(i3c_tty_driver);
+		tty_driver_kref_put(i3c_tty_driver);
+	}
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_slave_func_unregister_driver(&ttyi3c_func);
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

