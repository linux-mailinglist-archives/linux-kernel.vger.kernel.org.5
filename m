Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0E79310D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244375AbjIEVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjIEVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:39:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B01715
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc80I5Ps3yXcOSKva6rA2S01cjK5KXlU0p3QwPSB+XbSeECiXYPkn8gYwfa8+nla4pMaQLOP0EdrBd5MnsVLfzruLuntQ89aVQca8rcJsdswF5k02VTjrjTG53eXjhdLNsg37UPmomT5uLflwe2vLAlCuoa10CKUHBMSRLjE5v1eLok4WN4Go/xNrWgzS7kmBaxvnBVwikfhCs5YDh7267UEMPpVThXTwN44iDOtT3j7UqE6NQdMNMSONadABj7us81C4G22aDdydeOgle/zujUjdOpHAW1Gsfw/pAeIqkJFE/DryF/lpvzOJMlPWsii14N7yfNyOurWuR2KJt1ALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE9x/i/BtqK61JFzQblLOpV/r/FT6UyuGUCJUR8vRsQ=;
 b=NYMBUtjWEVAQc4zKOr5M+L4fFN30FCkCJHDCZffYHNr5EbRBuaPtTUhR8NrL3s6eDpjctobXX0dMqm9cGLdmBFl3lfRGRQpnW/aR0TZsiC6yz2eeoNpJ32gU/od0tXyO4Rf9q74Veu0qWsgLKcqlkn6a3h3yvxk8NJXdUva5SbDQEmmZZEPNvfBulkBgmvlWT3o22COPvK0RRjEeYO5C/GP5mLQtA0GEXOV5Xby37Wk8dkKQKs+EqRQSnn8MZ/M8mfCbS8jv/KpxMABcwDmq31iqnDpJjXnjkFfRvQYEOvoWbhFAhZwUZpWhjKUT5DIOvJeYVzfHB4lSHJXrsUucXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE9x/i/BtqK61JFzQblLOpV/r/FT6UyuGUCJUR8vRsQ=;
 b=cvuivyjid9d+RiWsZMq76JSkhSvkTNKuUOnGZfHeJxjxsb/Niwa9RBpbx2uMPBVJyQ7nB+Rgemltfj8tI7KchHGhZA00hPZHlg70EKwmqyPIxk3ulGktRpRjXdesCqEtjA0XRsUjzRL74P7BQupXxAQU0NLmgTG+hV0hsP3GxCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/9] i3c: slave: add svc slave controller support
Date:   Tue,  5 Sep 2023 17:38:39 -0400
Message-Id: <20230905213842.3035779-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e14e45f8-3068-4976-4632-08dbae588c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ut3gnDzcOIlEdANwJ+7iawAYO7tvG3sQAJCgA0gJHY0W+WF3QTuwV9v7/wDpy9GxsGo4A/UaaV2Z8AFEERBgNWdAE8QNEP2RE389d2FINTargt4nsQON5Nwh76rVBqynwxzKgbq0FszR7JLcJh5gJxw2af0lVJyxyv6lMsL8MFhHaV/7A1RAPNWnq+ewypfiU+oXe2t0vjYJ57G6WBIjohH9cQkrTaSS21+rXY3zWAqaeYkXTqhWgJecQKebmV1MpXPQ+HExnmZK9/jkEH5KzPzrXYcaVUDK28zPyUuVACvI/SQCAMIAVjSMO99sP0mhDv+2lDa2jigWw8jri6fg7jGV6zaZW5/MzhOM+NrDSOjZX+ToMx2/ApHV4HMIgOnBk4Z/qwDXFdZrHGBjJwwpbol4rG3WRan0JAYNgmuKeEydUBut/l18vbbfW8cDxJW+Bnyr2FIHrlYuXcTDQFdVJS3YryJ5UkmXOFBRBTjs5Q+x/zWpdbnLf3zuKq2yjonuo6vPtP2YTK5a+n0pBSKEy7lvKJ7YUX8kiZZ9k70NwJDRd7I+KtW7m35fUcs8FJwiqk98nPsw1hsYskdPYZqZ8H8dex2m8adx5bMayuXE3oaLS9M8EC3Qnbwd7xYVtWOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(30864003)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6qPLjB3nYAfA0LLUuMR6SAtxKfJ++V/M2wBhg1bBJj+Yw6QcLETwJfhvKtr?=
 =?us-ascii?Q?VGOvr2LdFszzA4U/XN3yiGZxFQiR7d3Qk4aqhaLRYm0nTfuiHJxL8d9juM43?=
 =?us-ascii?Q?0lxZvQH7a4RxP5OBjco5MmrwBvDbw00rqnxY0I9JEnfgW9DC5X/0PpJUiyzT?=
 =?us-ascii?Q?EXmpr6oQbA8wADlDPd7KdKZ6vvfZ1yJ3LESWX8OM+ZCJSvD2nrYvs3goafpw?=
 =?us-ascii?Q?msuMsYoYUeqrqKFBYAExO3xr0bPEGWbqz8cZAyLumltdJufDEb8g3gY7efbO?=
 =?us-ascii?Q?a0IQ2jaE4kjZiqwe0PGR8ivoFVat5Tzv+UHCa3Eroq3f368G1Vl5EXmqt5A9?=
 =?us-ascii?Q?kVj4TtjAuIvfgLqza8YGd3rfUrG8lp0PGd/bmghigrwka+I9EQxPS0oeeW+B?=
 =?us-ascii?Q?UcpVAHTYQly9rhXkNyAqOFRvzX6vge2Na/AOh3LVCAYnfQ8vsIqVNV3GPep/?=
 =?us-ascii?Q?tqgXJHFBXJv9xa2vBNr7k8gI268tIwUC8Nz/ksxygoU3GO2dMrR8UyHd3igO?=
 =?us-ascii?Q?2PwBoQdaTZNp8siduevS0xD/Z7Fz+Lwhb/43N8eArhqeTV3hZD4K0dUT5ttw?=
 =?us-ascii?Q?CLlYsoY1re8tnomwQei5NrsPMTH0mdaUMzCI3wtgRIL0Y8LETcc1oWAuHb2S?=
 =?us-ascii?Q?XCHztspVJa1fJfowzFGEiJ6WLSWPlvT36JfrsxouBc/1WhXExe+szdml96is?=
 =?us-ascii?Q?sxkH5jbUYKLXBduwG9p+TnSNJNuYPuMxcLBir2GPzR+NpSDJ7/DtTUjZWAzK?=
 =?us-ascii?Q?TXRkb4sH7ARM609RP4WV6i2bCAbMW92abss0CjVnbPjArgSEOAYWBigDGtRv?=
 =?us-ascii?Q?LTQpXgLNWVClLDB7ZNQblmONd38L+oKo3rvI4/zKpEqyk5yfNNffFWJnIZJ7?=
 =?us-ascii?Q?fLov2c6xwyV6yNlURkb42UUl+63E0BnE5B8gHUaGeXqI6ePHX3VmXyWDvELe?=
 =?us-ascii?Q?gTN4fGhsHO7WGV/5YmtKkkqUq311Gq4UrYSaesn8dTriDTjNaNf2aqdevxYQ?=
 =?us-ascii?Q?TgZ8onlA7/2Jnl79tioeSBXi9KT3OSvjG7ora+MqYA/UJg1GExC4dVA3t9OL?=
 =?us-ascii?Q?GGGxOiMgHaghU9+SiT5YdbqQmiioswgbDlKoUB9owVlZVN5BP0JQqURS9RVZ?=
 =?us-ascii?Q?cskTuMYzpmZg1z1o6yY7vB/ztMRnOVXjY0M0StrABA/1oMYOfnrTO6+2B3Gy?=
 =?us-ascii?Q?WKYX7Ylp0VDPLrLQt+Kty9kaGeHUx+rvByTpv2apxZPbfYFWLlaRgVOPoRZr?=
 =?us-ascii?Q?sSRCn3BMIoR4+81WJKFQb4IYrHYZ8GCBWxMPVZv0sm6nbfCHuezRHWKmxeLx?=
 =?us-ascii?Q?OCVPSVqAjltpBSBA0BWfC+eDN6yIovL0vzWHjkA6l3e47AyBam+sJ2pLV3Cu?=
 =?us-ascii?Q?jDivrgaZUjmHP4HlS3HxoCTOSeNPTRmirxsB8e2B9gKGGuZpDG4GOEOXSI+s?=
 =?us-ascii?Q?3qEjt483Dn4640VmToZaxZY08/JVQKGmN3AhiVolzxMByQsFV+zaVefTvzQ7?=
 =?us-ascii?Q?gXjinZ/OKyoLIFBgMoI/hA4ZeGh2aI3yxdDjl+XQz1S5r7qa3cjE6kzaUl/6?=
 =?us-ascii?Q?p9OeQ1O+JMjSp4Tdec6YRIbyrNmEeUGWMjBFWWZu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14e45f8-3068-4976-4632-08dbae588c86
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:14.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpdfp1GUwyyz492Q98SQWj4p4nso6v30gY8QKorT6pUtMoPkU1VXUymlHPC9T2PllB207tgOPWbobS5/lfX8ow==
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

Add Silvaco I3C slave controller support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Makefile              |   1 +
 drivers/i3c/slave/Kconfig         |   9 +
 drivers/i3c/slave/Makefile        |   4 +
 drivers/i3c/slave/svc-i3c-slave.c | 600 ++++++++++++++++++++++++++++++
 4 files changed, 614 insertions(+)
 create mode 100644 drivers/i3c/slave/Kconfig
 create mode 100644 drivers/i3c/slave/Makefile
 create mode 100644 drivers/i3c/slave/svc-i3c-slave.c

diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 6407ddec3a4a9..ef1acbe13fe60 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C)		+= master/
 obj-$(CONFIG_I3C_SLAVE)		+= slave.o
 obj-$(CONFIG_I3C_SLAVE_CONFIGFS)	+= i3c-cfs.o
+obj-$(CONFIG_I3C_SLAVE)		+= slave/
diff --git a/drivers/i3c/slave/Kconfig b/drivers/i3c/slave/Kconfig
new file mode 100644
index 0000000000000..e385dbdea193b
--- /dev/null
+++ b/drivers/i3c/slave/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_SLAVE_CTRL_SVC
+	tristate "Silvaco I3C Dual-Role Slave driver"
+	depends on I3C
+	depends on HAS_IOMEM
+	depends on !(ALPHA || PARISC)
+	help
+	  Support for Silvaco I3C Dual-Role Slave Controller.
diff --git a/drivers/i3c/slave/Makefile b/drivers/i3c/slave/Makefile
new file mode 100644
index 0000000000000..612be24536311
--- /dev/null
+++ b/drivers/i3c/slave/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-${CONFIG_I3C_SLAVE_CTRL_SVC} += svc-i3c-slave.o
+
diff --git a/drivers/i3c/slave/svc-i3c-slave.c b/drivers/i3c/slave/svc-i3c-slave.c
new file mode 100644
index 0000000000000..01824913bfbc4
--- /dev/null
+++ b/drivers/i3c/slave/svc-i3c-slave.c
@@ -0,0 +1,600 @@
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
+#include <linux/i3c/slave.h>
+#include <linux/i3c/slave.h>
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
+enum i3c_clks {
+	PCLK,
+	FCLK,
+	SCLK,
+	MAXCLK,
+};
+
+struct svc_i3c_slave {
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+	struct clk_bulk_data clks[MAXCLK];
+
+	struct list_head txq;
+	spinlock_t txq_lock;
+	struct list_head rxq;
+	spinlock_t rxq_lock;
+	struct list_head cq;
+	spinlock_t cq_lock;
+
+	struct work_struct work;
+	struct workqueue_struct *workqueue;
+
+	struct i3c_slave_ctrl_features features;
+};
+
+#define I3C_SCONFIG	0x4
+#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
+#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
+
+#define I3C_SSTATUS	0x8
+#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
+#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
+#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
+
+#define I3C_SCTRL	0xc
+#define   I3C_SCTRL_EVENT_MASK		GENMASK(1, 0)
+#define	  I3C_SCTRL_EVENT_IBI		0x1
+#define   I3C_SCTRL_EXTDATA_MASK	BIT(3)
+#define   I3C_SCTRL_IBIDATA_MASK	GENMASK(15, 8)
+
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
+#define   I3C_SDATACTRL_FLUSHFB_MASK	BIT(1)
+#define   I3C_SDATACTRL_FLUSHTB_MASK	BIT(0)
+
+#define I3C_SWDATAB	0x30
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
+static int svc_i3c_slave_enable(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
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
+static int svc_i3c_slave_disable(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
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
+static int svc_i3c_slave_set_config(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
+{
+	struct svc_i3c_slave *svc;
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
+const struct i3c_slave_ctrl_features *svc_i3c_get_features(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	if (!svc)
+		return NULL;
+
+	return &svc->features;
+}
+
+static int svc_i3c_slave_queue(struct i3c_request *req, gfp_t)
+{
+	struct svc_i3c_slave *svc;
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
+		writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTSET);
+	else
+		writel_relaxed(I3C_SINT_RXPEND, svc->regs + I3C_SINTSET);
+
+	return 0;
+}
+
+static int svc_i3c_dequeue(struct i3c_request *req)
+{
+	struct svc_i3c_slave *svc;
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
+static void svc_i3c_slave_fifo_flush(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_slave *svc;
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
+svc_i3c_slave_raise_ibi(struct i3c_slave_ctrl *ctrl, void *p, u8 size)
+{
+	struct svc_i3c_slave *svc;
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
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 10000);
+	if (ret) {
+		dev_err(&ctrl->dev, "Timeout when polling for NO event pending");
+		return -ENAVAIL;
+	}
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
+
+	ret = readl_relaxed_poll_timeout(svc->regs + I3C_SCTRL, val,
+					 !(val & I3C_SCTRL_EVENT_MASK), 0, 10000);
+	if (ret) {
+		dev_err(&ctrl->dev, "Timeout when polling for IBI finish\n");
+		return -ENAVAIL;
+	}
+
+	return 0;
+}
+
+static void svc_i3c_slave_complete(struct work_struct *work)
+{
+	struct svc_i3c_slave *svc = container_of(work, struct svc_i3c_slave, work);
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
+static irqreturn_t svc_i3c_slave_irq_handler(int irq, void *dev_id)
+{
+	struct i3c_request *req, *complete = NULL;
+	struct svc_i3c_slave *svc = dev_id;
+	unsigned long flags;
+	u32 statusFlags;
+
+	statusFlags = readl(svc->regs + I3C_SSTATUS);
+	writel(statusFlags, svc->regs + I3C_SSTATUS);
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
+
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
+
+		complete = NULL;
+		spin_lock_irqsave(&svc->txq_lock, flags);
+		req = list_first_entry_or_null(&svc->txq, struct i3c_request, list);
+		if (!req) {
+			writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTCLR);
+		} else {
+			while (!(readl_relaxed(svc->regs + I3C_SDATACTRL)
+					& I3C_SDATACTRL_TXFULL_MASK)) {
+
+				if (req->actual + 1 == req->length)
+					writel_relaxed(*(u8 *)(req->buf + req->actual),
+						       svc->regs + I3C_SWDATAE);
+				else
+					writel_relaxed(*(u8 *)(req->buf + req->actual),
+						       svc->regs + I3C_SWDATAB);
+
+				req->actual++;
+
+				if (req->actual == req->length) {
+					list_del(&req->list);
+					complete = req;
+					break;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&svc->txq_lock, flags);
+		if (complete)
+			complete->complete(complete);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void svc_i3c_cancel_all_reqs(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_slave *svc;
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
+	while (list_empty(q)) {
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
+static struct i3c_slave_ctrl_ops svc_i3c_slave_ops = {
+	.set_config = svc_i3c_slave_set_config,
+	.enable = svc_i3c_slave_enable,
+	.disable = svc_i3c_slave_disable,
+	.queue = svc_i3c_slave_queue,
+	.dequeue = svc_i3c_dequeue,
+	.raise_ibi = svc_i3c_slave_raise_ibi,
+	.fifo_flush = svc_i3c_slave_fifo_flush,
+	.cancel_all_reqs = svc_i3c_cancel_all_reqs,
+	.get_features = svc_i3c_get_features,
+};
+
+static int svc_i3c_slave_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i3c_slave_ctrl *slave;
+	struct svc_i3c_slave *svc;
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
+
+	INIT_WORK(&svc->work, svc_i3c_slave_complete);
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
+	ret = devm_request_irq(dev, svc->irq, svc_i3c_slave_irq_handler, 0, "svc-i3c-irq", svc);
+	if (ret)
+		return -ENOENT;
+
+	slave = devm_i3c_slave_ctrl_create(dev, &svc_i3c_slave_ops);
+	if (!slave)
+		return -ENOMEM;
+
+	dev_set_drvdata(&slave->dev, svc);
+
+	return 0;
+}
+
+static int svc_i3c_slave_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id svc_i3c_slave_of_match_tbl[] = {
+	{ .compatible = "silvaco,i3c-slave" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, svc_i3c_slave_of_match_tbl);
+
+static struct platform_driver svc_i3c_slave = {
+	.probe = svc_i3c_slave_probe,
+	.remove = svc_i3c_slave_remove,
+	.driver = {
+		.name = "silvaco-i3c-slave",
+		.of_match_table = svc_i3c_slave_of_match_tbl,
+		//.pm = &svc_i3c_pm_ops,
+	},
+};
+module_platform_driver(svc_i3c_slave);
+
+MODULE_DESCRIPTION("Silvaco dual-role I3C slave driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

