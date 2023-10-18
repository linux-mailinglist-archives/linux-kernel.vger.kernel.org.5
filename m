Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380217CEA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjJRV7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjJRV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:58:49 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487E139;
        Wed, 18 Oct 2023 14:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMLEcgFaFEDw3oqcl52vtgkf5rW4mPyCM5o6WabN+z/32uwT2ZlkzFh1oxvRTuYUmR3MFUR+BXWA/anuDv5RMXuj/IGgLZlbEfmJBX5DSl0elnqWlmDvgieW2eaavXLQlGADWSBSAV+M6PSC0KzEGk8oYI6MPzw5IR5FVE1pvM35e13qxRNFVXvUXd91w77dBq9bWVTaA2qQNA1JPd4Dmpt6tILj1tXU3P7qQI1Eu2yfBNz2O31bnLhJ28E39qQA9orPtFuMGRqfM+5WxtxXgZTK7qjPFyQ3C2uflArXhMJCdtOjzux+O78YvebZKMHwAWQrnLGN4k/MUqTk0H+bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4twnLJur9ouNfayEnV0lYu44tuhyKc5XuQj935Zr33A=;
 b=U9R/Ye561jw7NfjYWlfHire0geMYN8Yt4+c0UKUiw1pcfoqICLM5/w1sXwEnTfTx5UzaapiKucOf1Lei2WVMcxs3vwUmpmkYcbQaXsIDbSP9UMq4QCTH/PvPscFVLv1hLnqWpzYoc/2spIPDysPrnMEw7l3scsgT1CcmCUCzhjqNsNKa7w7eBXf1TmnmYZfpGo9bYBTceaEcCXBPIQVH0jHMGDb5HnU8nOVyShU2D0EWomncqEPONMNEEyZRJJsHdJpwcIdaZYhf4XVtt/0CeJGtUIoAKR+SrnKP9OC0a+CMOMTO/l6/6hSY3NRDXUWMWnRBvTrJ6ktJeVgSZGCFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4twnLJur9ouNfayEnV0lYu44tuhyKc5XuQj935Zr33A=;
 b=D2kNKaIc0PK5srgCARDuo+byR6O18iApTQaeeJGRUrmcdnq2rEhIA1DlsB2Ih4FNs6FoXMFNzXyBQ+/Uu8yFnh1XxUg4kAEu8pRyv//axYHVj/VECSUaGCnCkLeTvj1gj6dsOwkxvDywAayvpQK5XELrPh73nGW7zAw6rm+jxXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 21:58:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:58:41 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, Frank.Li@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 3/5] i3c: slave: add svc slave controller support
Date:   Wed, 18 Oct 2023 17:58:07 -0400
Message-Id: <20231018215809.3477437-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: db58b7a8-2016-4321-086a-08dbd02563f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnT4Pb3HvgvMYj/+Tcua5fDYCnDCbKkuGyGOcqIZ4tSqObzDPMvEXN4x8LsNaYcZ8CaL9fn8JzXH00FTt+pjCMAUmXaiCVwQPwNSZYvT4MJjOoxWHoiLmCnRxMCSpRZ3WW8SKF5T69Y9KWwxE/zMlO0r98G7Z4yKU62PdjtnN70z1bdypye2SqSv8iVEEK1i1HfW+bRgSS4WOaA6MzFc9dy4FgwFnH5bT43DLBSfENVRL5jfS/WZnLU/phQh9ts39WS92kuqwoEOqNFYBgT6yls0CDbMYKpqYJHkWv3ue2Bd8TaNVphx+AsreupzJDZJSZr9hwZXnlq2bUsXqaIFZlgxWDCYXIJ9hfZVVUkV687od1YTMkbPczWGzalN/uG/Ddeez2Wifq8KBA4oE9RZ9mBx2eq1eSYLoFu0lKSePeykyqxPX+WJvjwGXcJoVQn/UeZTiCgoH8vDGJW7x855+B+Q3mCJnfO16H60rauMUylyxbmwY+RsnTtDtgsIr6ktLV9oGDMvpFKzTGbIWPkia/ha4pPdRToPbwpo0Ai34bSA6qCl6UNwCtBSyYUBtDLuQYfPLpEUwzbPACHD1bjJ1Nz8eMYr93Aeo61dDA0AcNjczThm+G22LclrfVEhwluzKnUJTaQYqJkFX2P1Yy3Hvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4326008)(30864003)(2906002)(86362001)(7416002)(38100700002)(2616005)(52116002)(6512007)(1076003)(83380400001)(6506007)(26005)(921005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlqDa1LNT3XhV3PIiP6YG3Gb7xnFYrsD/MkyfIJo9ec2eDS051fAOox/j30W?=
 =?us-ascii?Q?z9W8QliboIjiFFU7Ac5Fj7IyYPprVvHG3s5E4GR+MnA1NMG0GnZa/itjPGvs?=
 =?us-ascii?Q?cIm+w0Cuq8mkUKqpN6lu1VTjs9uwkaZ0kjmZTnZipzqnGrygHiTupXfnoE8s?=
 =?us-ascii?Q?ARMJBSwNUFLKsd3QtiaRS2FRo0mokrGahAo5y73Vr0AlVFbLSOBDr/1gDbG/?=
 =?us-ascii?Q?PQJTgdDmVG8+8hlVy5v4ru2Lcz0qn3QEU/6KFOBEQsAXB8S0RJUCo/C+fQxP?=
 =?us-ascii?Q?EMVCHYLsfp6iL0FUYlKtKAkysmkUoIbTwcPd2t3CfpQKdyU3ArVZqXKDTKDZ?=
 =?us-ascii?Q?XJuypFqVoBEmj85Ec43SjUFYp4Itd4ZX1X/nvhOtFGs7EcZjGXgAUYXticvK?=
 =?us-ascii?Q?VF0IrHL4Xg6+YsNUig291nbzyfaOQRDdyvnXg1w9nU6o7fu/gAev1Sh02BRA?=
 =?us-ascii?Q?AKoAqgx7tkyJRm2BO+V0KeuEhrTBzPDGm9qc7JdoHG96TlqyFmnf64ZME5Ln?=
 =?us-ascii?Q?aex/M2Ge3FN25DOeMDIpJldQRMcXw0xTB5TWbMLQ01vqtIOLz6/xr489Sm1F?=
 =?us-ascii?Q?5AiLs3peCLxT/h5RootUTbfIqr8A/sc1yiLZZXE4gIXgM3n5lAQTxJ0mBhQy?=
 =?us-ascii?Q?oa1i7Er8yQbd9Pukh3NVl5dxgir1ZNjDjv+8ZhATf3dEpQ/hfV4FH+I7shbK?=
 =?us-ascii?Q?yyonXaCvTAjaKxV3bbo0Lxg5z6Y4lLkaS63VYzGbw1vGdrzFc+RZ2KJ+l+vN?=
 =?us-ascii?Q?dJOhoKSHrRHzF5MUZXyS9d/fnGq0WYvSnfy1r234UZuJp0Mliy7cMTnUBGk2?=
 =?us-ascii?Q?+7hP3tVjCgNIZu0su68nOQiVGygNs20WBUeHc/VFzxDlkhdViyvNNEHyopTL?=
 =?us-ascii?Q?NDm+NDhtHOmJ6xt+LkeFgB2bGoRtc0DLTT2zVuSfaCPz9fwclBQe0pESyqlU?=
 =?us-ascii?Q?HkPadsnZGSPqmSrMY/3AZuhUayuxnzFsOLRjIELMJ4+N98sOAwuGhuC8DH10?=
 =?us-ascii?Q?jwIWBDaYJ2q1AQsHhzRPBvHK5QKykhY35iXR2kQyAw3wC656YBHIXsxvaFQE?=
 =?us-ascii?Q?d23c5lnltuDUSlP84dMDF94XjUAnP56jLXtRFB3jPMnyfvpRyXvE1UAzdXIp?=
 =?us-ascii?Q?hufnnspbjqlMoSA+nfVfi6gYjzhWmHNZJJ64EgBc4w1+MunP6ju5TFCESKRQ?=
 =?us-ascii?Q?rk3UZLH6FS1kie78ALLdJhgSCbQAyaT4B2xy6JTTWRc7og/9SxajMEegor/D?=
 =?us-ascii?Q?Hw/z4TwDZgfdyADzGoIU9mw6TN5xaQDGIK4U+wcpeIf6ffBzOGyE0M0tX8hY?=
 =?us-ascii?Q?hLD5hB1mM7HNBxZbnZd91FHXcFOkLI7iQVN8pqIL7GDmVwIXD4wklnj/mRuE?=
 =?us-ascii?Q?s6tsMECwl08tfRHH9mdEBdYaWVt5bThGOdePCzSweJjdID4ra5D0w9S1jt75?=
 =?us-ascii?Q?PPBVE422QPLY+Xk4OtA+aA1T67DpBQnOykXCvP6F/yip55miCRtRczjeBGoP?=
 =?us-ascii?Q?yh485FzzLt4y/kitOPrJsXUlAZaB1KOtaWIGKu6p6A45/o/Rd28ggxyxDE8H?=
 =?us-ascii?Q?cvk3vj0oX4UQsyTcAf1RzKPBsHv14SptZwPjMamP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db58b7a8-2016-4321-086a-08dbd02563f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:58:41.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLL0puCqltKx97ol0+rnLejanqLxCPJQfr3kExV5VxAPJ3bA6HvHUyDKLfgYfzMNG4nOxxW8jEOdBKoJReVhLA==
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

Add Silvaco I3C slave controller support

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig               |   3 +
 drivers/i3c/Makefile              |   1 +
 drivers/i3c/slave/Kconfig         |   9 +
 drivers/i3c/slave/Makefile        |   4 +
 drivers/i3c/slave/svc-i3c-slave.c | 795 ++++++++++++++++++++++++++++++
 5 files changed, 812 insertions(+)
 create mode 100644 drivers/i3c/slave/Kconfig
 create mode 100644 drivers/i3c/slave/Makefile
 create mode 100644 drivers/i3c/slave/svc-i3c-slave.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d5f5ca7cd6a56..802a9b3576f13 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -48,3 +48,6 @@ config I3C_SLAVE_CONFIGFS
 	  the slave function and used to bind the function with a slave
 	  controller.
 
+if I3C_SLAVE
+source "drivers/i3c/slave/Kconfig"
+endif # I3C_SLAVE
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
index 0000000000000..2de741a9e0ff8
--- /dev/null
+++ b/drivers/i3c/slave/svc-i3c-slave.c
@@ -0,0 +1,795 @@
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
+	struct i3c_slave_ctrl_features features;
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
+static void svc_i3c_queue_complete(struct svc_i3c_slave *svc, struct i3c_request *complete)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&svc->cq_lock, flags);
+	list_add_tail(&complete->list, &svc->cq);
+	spin_unlock_irqrestore(&svc->cq_lock, flags);
+	queue_work(svc->workqueue, &svc->work);
+}
+
+static void svc_i3c_fill_txfifo(struct svc_i3c_slave *svc)
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
+
+				spin_lock_irqsave(&svc->txq_lock, flags);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&svc->txq_lock, flags);
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
+
+		spin_lock_irqsave(&svc->txq_lock, flags);
+		if (list_empty(&svc->txq))
+			writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTCLR);
+		spin_unlock_irqrestore(&svc->txq_lock, flags);
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
+static int svc_i3c_hotjoin(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
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
+static int svc_i3c_set_status_format1(struct i3c_slave_ctrl *ctrl, u16 status)
+{
+	struct svc_i3c_slave *svc;
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
+static u16 svc_i3c_get_status_format1(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
+
+	svc = dev_get_drvdata(&ctrl->dev);
+
+	return readl_relaxed(svc->regs + I3C_SCTRL) >> 16;
+}
+
+static u8 svc_i3c_get_addr(struct i3c_slave_ctrl *ctrl)
+{
+	struct svc_i3c_slave *svc;
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
+int svc_i3c_fifo_status(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	struct svc_i3c_slave *svc;
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
+	.hotjoin = svc_i3c_hotjoin,
+	.fifo_status = svc_i3c_fifo_status,
+	.set_status_format1 = svc_i3c_set_status_format1,
+	.get_status_format1 = svc_i3c_get_status_format1,
+	.get_addr = svc_i3c_get_addr,
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
+	spin_lock_init(&svc->ctrl_lock);
+
+	init_completion(&svc->dacomplete);
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
+	{ .compatible = "silvaco,i3c-slave-v1" },
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

