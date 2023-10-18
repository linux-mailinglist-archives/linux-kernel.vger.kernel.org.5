Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113E7CEA86
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjJRV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjJRV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:58:43 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE77120;
        Wed, 18 Oct 2023 14:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLTywtyeALqPKu6AVLHI1o7RxUZhvrXVhDMRByhEs4r3oSGDnf6NWHEi7KK0B0W+rdvyW34bTI+36ZB6lgZ4r6q6wSiY5OCPYwPJ+G1tQkIWcIWVynFjS0eT1UJzE03JcCytt+TijVCFGlOZ3V04JKjvirg2YtwvfDLACeS4MCTnaU3cOOLkppt+XcemRCRtRuJlHqikDWKqHsPJiuX7tvFsDrHzXqswZMG5UhA3dLsXcQoDYqjeDFedKACoRkqHhr30/CEz/3sP1mJ0WtzAQpQTl/+CUaoWy17d8+IUS9p3dEn+1GvXOZPcIFGMsIj5NA2AClKsM3hEgwp26FYJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE42CLXPcC9MBAr6uBFfjcOSAX6gKN3X9WxWNVV9KOE=;
 b=j8E5Hx+Alvm/rGhzoNIdbUgxSDPM7l3T4NANjbb7V+t9BBakuQdJ8GqkJK/DGibML5docpD86KNLMY6eoJC0TyXFHBmtCxs/gyGP5froyi2ulq8XmDESG2eVYUN/iOYV/ntEKkl4+1pi6aCXqI2OFoKUHrQEgOTOjP7HthefcGXa2H9Icwth/dBTmOmR/A/PUvDvzBeoHSy4otENZynw208FYe5ii5uT6gM/hiSuQAK6UowJtY8SunUzN3wy/LfMAu0n8XWC9DHzOjy7FizAZ3KfrzwN6Chun14Ex2xGoTN6YLuSmXkQYHor5ThgRdD9cnvifnQjTZ2LqyhGXWN49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE42CLXPcC9MBAr6uBFfjcOSAX6gKN3X9WxWNVV9KOE=;
 b=EWwmfiYlnb6OVnPnV2gmdKEgO8AUIcF+jRiL46vWn9/mBW2jhRyA8QZA9YPlotPCLydYt5jXvYRN1/z7goMIdSvhoWamBTe8CoeXpRCBjsifcTnx4U4rKphAZdgQOuHqjCVKJxgyRJSAHY/9i2++QVzK7688PaDr4S49snBV+ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 21:58:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:58:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, Frank.Li@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/5] i3c: add slave mode support
Date:   Wed, 18 Oct 2023 17:58:05 -0400
Message-Id: <20231018215809.3477437-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0ce8efa-7fcd-421b-bad0-08dbd0255ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evv4dQhobJsGELjkNMw5sBnjfp1IEpIuqu+M/xae1uHyIATmi03QCprZBCXb2fMkucTT03xXejvB4xrIqlr6VYjfPYN8H2scFaIfhIah1UMYjIXessZW243YBZZbm9knZJxyQW/qGr8VFTUWP2OCLz2UPUEHK+zB2mIl+6jiueJl+9pBX9duumn3g879UIm69FBvFAexPfKQRRUFX8wBARdZ8fHlHz0PqVeMtuz7E0RJ93Ql18N9+CojNY1J4tqgrmNg4um5fg4Muf06Rjng+OI9ges0ywHmT5FU4RsY2cmymub7PsHLlD3sqSVNaOOt/BlU3N0ldkCI9g4sSTnwiVWb6zj84QxbVX8Zzcgd2/djBY2feRDS5yKPIoB1DRC9S4ieUbaLl7sFGQ5aapF11bB1AGWdgxEiY/zrZynJjS6cAZiFsZjWfMOclMk3wDpDwQnJj/bk8Cdund+HmmLD3o75vyEKdtAR8pBnJ59sRw77nFgTBZ4yA5RcJsYnJCTkh2nCDNFUvTO8SHQAL3pTlEoWfVQhZfzGQ6Wxh9Huxia6IA8ug3h/7nWKZJBRh/tFi/ycuJdo3C1kkd06eZhaUuoV+Zk/HgY1QJrkpRgW2TaR27w/msXrDeBJCkmbhLlt+viCZUhj0ECXIkWeEGXrdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4326008)(30864003)(2906002)(86362001)(7416002)(38100700002)(2616005)(52116002)(6512007)(1076003)(83380400001)(6506007)(26005)(921005)(38350700005)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YGK8b2WP+elXsYezShrZhtLCMlPPNYzl9jSbDDYf3HIutVrVLjfCgwFGREu5?=
 =?us-ascii?Q?tv+tAz7of+IiwoceaFNZCoOKqeLsDyN57pBcIwk6hqRpiy4xuxJSoYM3kE+O?=
 =?us-ascii?Q?YMY1Hj2BBViZlzNxL6SY6DwKRIzxWGgHBOO1UL3bIdXk3cpQvzU5cHRz514a?=
 =?us-ascii?Q?hs19O9UG+WnASW8Bq5WMKwn+pXWqVqiX5UknCdLcG2Vv3OB47po0EyTeIXx6?=
 =?us-ascii?Q?T/JSu1nvg1MbBHDkpbQ17o62jvECzomo8b7z7VzoOfpHFEmRGaeJRpJ05/rI?=
 =?us-ascii?Q?nf6YmzHTcFP3mAMWGcbvcsJ8mCyl27ZGLc1ZNj+l6gzUk983zh49caULW8X+?=
 =?us-ascii?Q?GtXV3aYR60rp5/7gSCexOszsprH6M6p0IZBAotxsT3RiPMt/SiK4wHLhzJvO?=
 =?us-ascii?Q?oQI6o1YHfLlCN9OxmuBLpSFBI1IO3zHeRm5LKVWDOHT15x6Vw6/z8fCvzHBn?=
 =?us-ascii?Q?sBvucBYIWO74fIAPqr56YgqnHAgGD008bvP+BcEMVN+hCEMfyTWhf6clTu1K?=
 =?us-ascii?Q?SHoLFuqgaXx4b9FR+Eu02134h9SFVgI6y1xyDs8+De+RuFtZmOhRDhutc9wi?=
 =?us-ascii?Q?rMOUWStmpwUdoYYX40M8KY1TyoYQqUFt8r1/VrBAVlxYpQG4tdujfPfJx1Iv?=
 =?us-ascii?Q?Q/XUgTCO6431bik93Ha2P74L/i16I4AOkCIyogIKpt8FSCYCbYVCflnkmNFd?=
 =?us-ascii?Q?zRxML2qVjJq4w9kntTG0sKF7PR3VVi95ydQIKo4ux6BRq84mTF8gJYkSezCp?=
 =?us-ascii?Q?uRgcm10OsesQr5yo9SAZmqnnnuDvoORZpsYtdvfOpqC0uij0j1K8IQm6uINz?=
 =?us-ascii?Q?Miu5i15zBsF5A0E1RBZgaH48qxoLcMZNu5OJWe/S4zM6gWKaVTs+yuvMm6BZ?=
 =?us-ascii?Q?bA+FFY/eliM2MHrqrd6EqjO8Em9eRWauoghpHEiLwAAovA1EFu89I/BnUN5Q?=
 =?us-ascii?Q?SXxG5fEWMUIssfFaK9PWeD2gRuorPdi94ufjTGkD+hLlPr2UMz45YphQiJ/f?=
 =?us-ascii?Q?sy4r4DPV1sIJ4w5x3Pn5ewQsANv4fMGF3GHETK/kO0wg3CHknSIA30PixPrD?=
 =?us-ascii?Q?KV2HGqsXIbZFeUl+keLGTrwn/pFnM1yExwxbxEFKlvnX+12gJ1yUIm6ic14t?=
 =?us-ascii?Q?KVQLGE2VjHoyPZJikl/eXiu+hDz6lfOQSAR5X8YbfWXnvEvAyF5GwKCk5Ihu?=
 =?us-ascii?Q?Qe6fFAaRtWGEQZHMnQ0VDEvelPwhI5cfY9t89PIevgDar2hoRy1TXBGPdbFe?=
 =?us-ascii?Q?cxDYrDBnVHUJpIIlL6cTIuI0rUA8/YD9wuiAL8GVx36LbLk4APQho9wB4Mh4?=
 =?us-ascii?Q?UWajstuG3tXqWAkjX2VuoKjH3slTqbdCFci3o2WF6ioy7QTtxzEftZxxmnu4?=
 =?us-ascii?Q?3uLisLH1DGra5Wuw5e0Gwct9mIXDk1cvXnUSPO9s/zAuowlLEDH/jJGjy3xb?=
 =?us-ascii?Q?55QbNmdegShbl9ys7Opevd4n1JEYUsJ0aPegjmCW/x4KBqN1pJzmHMAAx7Ow?=
 =?us-ascii?Q?QZ8RTrvxc8yB6qXY5k8m+/ObYZZgS2Dbx5d0p7imtHy5b8lQiDsruBFwwP/K?=
 =?us-ascii?Q?0tUUiql4j9uwNgCIKo0yFO8zyfiP9/Za6+gWOJqp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce8efa-7fcd-421b-bad0-08dbd0255ef1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:58:33.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDnKadh8Dkm2zB3G29ciVkvcbYXveOX+49JQUvqWhV0C3Y3J0QPADVXiNur4ghbkwqR593SXcJtuXKZ1Fb8O+Q==
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

Introduce a new slave core layer in order to support slave functions in
linux kernel. This comprises the controller library and function library.
Controller library implements functions specific to an slave controller
and function library implements functions specific to an slave function.

Introduce a new configfs entry to configure the slave function configuring
and bind the slave function with slave controller.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/Kconfig       |  26 ++
 drivers/i3c/Makefile      |   2 +
 drivers/i3c/i3c-cfs.c     | 389 +++++++++++++++++++++++++++++
 drivers/i3c/slave.c       | 453 ++++++++++++++++++++++++++++++++++
 include/linux/i3c/slave.h | 503 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 1373 insertions(+)
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/slave.c
 create mode 100644 include/linux/i3c/slave.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a441506f61c..d5f5ca7cd6a56 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -22,3 +22,29 @@ menuconfig I3C
 if I3C
 source "drivers/i3c/master/Kconfig"
 endif # I3C
+
+config I3C_SLAVE
+	bool "I3C Slave Support"
+	help
+	  Support I3C Slave Mode.
+
+	  Enable this configuration option to support configurable I3C slave.
+	  This should be enabled if the platform has a I3C controller that can
+	  operate in slave mode.
+
+	  Enabling this option will build the I3C slave library, which includes
+	  slave controller library and slave function library.
+
+	  If in doubt, say "N" to disable slave support.
+
+config I3C_SLAVE_CONFIGFS
+	bool "I3C Slave Configfs Support"
+	depends on I3C_SLAVE
+	select CONFIGFS_FS
+	help
+	  Configfs entry for slave function and controller.
+
+	  This will enable the configfs entry that can be used to configure
+	  the slave function and used to bind the function with a slave
+	  controller.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982efbc6d91..6407ddec3a4a9 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,5 @@
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C)		+= master/
+obj-$(CONFIG_I3C_SLAVE)		+= slave.o
+obj-$(CONFIG_I3C_SLAVE_CONFIGFS)	+= i3c-cfs.o
diff --git a/drivers/i3c/i3c-cfs.c b/drivers/i3c/i3c-cfs.c
new file mode 100644
index 0000000000000..35e07da50ebb0
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
+#include <linux/i3c/slave.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(functions_mutex);
+static struct config_group *functions_group;
+static struct config_group *controllers_group;
+
+struct i3c_slave_func_group {
+	struct config_group group;
+	struct i3c_slave_func *func;
+};
+
+struct i3c_slave_ctrl_group {
+	struct config_group group;
+	struct i3c_slave_ctrl *ctrl;
+};
+
+static inline struct i3c_slave_func_group *to_i3c_slave_func_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct i3c_slave_func_group, group);
+}
+
+static inline struct i3c_slave_ctrl_group *to_i3c_slave_ctrl_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct i3c_slave_ctrl_group, group);
+}
+
+static int i3c_slave_ctrl_func_link(struct config_item *ctrl_cfg, struct config_item *func_cfg)
+{
+	struct i3c_slave_func_group *func_group = to_i3c_slave_func_group(func_cfg);
+	struct i3c_slave_ctrl_group *ctrl_group = to_i3c_slave_ctrl_group(ctrl_cfg);
+	struct i3c_slave_ctrl *ctrl = ctrl_group->ctrl;
+	struct i3c_slave_func *func = func_group->func;
+	int ret;
+
+	ret = i3c_slave_ctrl_add_func(ctrl, func);
+	if (ret)
+		return ret;
+
+	ret = i3c_slave_func_bind(func);
+	if (ret) {
+		i3c_slave_ctrl_remove_func(ctrl, func);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_slave_ctrl_func_unlink(struct config_item *ctrl_cfg, struct config_item *func_cfg)
+{
+	struct i3c_slave_func_group *func_group = to_i3c_slave_func_group(func_cfg->ci_parent);
+	struct i3c_slave_ctrl_group *ctrl_group = to_i3c_slave_ctrl_group(ctrl_cfg);
+	struct i3c_slave_ctrl *ctrl = ctrl_group->ctrl;
+	struct i3c_slave_func *func = func_group->func;
+
+	i3c_slave_func_unbind(func);
+	i3c_slave_ctrl_remove_func(ctrl, func);
+}
+
+static ssize_t i3c_slave_ctrl_hotjoin_store(struct config_item *item, const char *page, size_t len)
+{
+	struct i3c_slave_ctrl_group *ctrl_group = to_i3c_slave_ctrl_group(item);
+	struct i3c_slave_ctrl *ctrl;
+	int ret;
+
+	ctrl = ctrl_group->ctrl;
+
+	ret = i3c_slave_ctrl_hotjoin(ctrl);
+	if (ret) {
+		dev_err(&ctrl->dev, "failed to hotjoin i3c slave controller\n");
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+static ssize_t i3c_slave_ctrl_hotjoin_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%d\n", 0);
+}
+
+CONFIGFS_ATTR(i3c_slave_ctrl_, hotjoin);
+
+static struct configfs_item_operations i3c_slave_ctrl_item_ops = {
+	.allow_link     = i3c_slave_ctrl_func_link,
+	.drop_link      = i3c_slave_ctrl_func_unlink,
+};
+
+static struct configfs_attribute *i3c_slave_ctrl_attrs[] = {
+	&i3c_slave_ctrl_attr_hotjoin,
+	NULL,
+};
+
+static const struct config_item_type i3c_slave_ctrl_type = {
+	.ct_item_ops    = &i3c_slave_ctrl_item_ops,
+	.ct_attrs	= i3c_slave_ctrl_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+/**
+ * i3c_slave_cfs_add_ctrl_group() - add I3C slave controller group
+ * @ctrl: I3C slave controller device
+ *
+ * Return: Pointer to struct config_group
+ */
+struct config_group *i3c_slave_cfs_add_ctrl_group(struct i3c_slave_ctrl *ctrl)
+{
+	struct i3c_slave_ctrl_group *ctrl_group;
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
+	config_group_init_type_name(group, dev_name(&ctrl->dev), &i3c_slave_ctrl_type);
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
+EXPORT_SYMBOL(i3c_slave_cfs_add_ctrl_group);
+
+/**
+ * i3c_slave_cfs_remove_ctrl_group() - remove I3C slave controller group
+ * @group: the group to be removed
+ */
+void i3c_slave_cfs_remove_ctrl_group(struct config_group *group)
+{
+	struct i3c_slave_ctrl_group *ctrl_group;
+
+	if (!group)
+		return;
+
+	ctrl_group = container_of(group, struct i3c_slave_ctrl_group, group);
+	i3c_slave_ctrl_put(ctrl_group->ctrl);
+	configfs_unregister_group(&ctrl_group->group);
+	kfree(ctrl_group);
+}
+EXPORT_SYMBOL(i3c_slave_cfs_remove_ctrl_group);
+
+#define I3C_SLAVE_ATTR_R(_name)                                                \
+static ssize_t i3c_slave_func_##_name##_show(struct config_item *item, char *page)    \
+{                                                                              \
+	struct i3c_slave_func *func = to_i3c_slave_func_group(item)->func;                     \
+	return sysfs_emit(page, "0x%04x\n", func->_name);               \
+}
+
+#define I3C_SLAVE_ATTR_W(_name, _u)                                            \
+static ssize_t i3c_slave_func_##_name##_store(struct config_item *item,               \
+				       const char *page, size_t len)           \
+{                                                                              \
+	_u val;                                                               \
+	struct i3c_slave_func *func = to_i3c_slave_func_group(item)->func;                     \
+	if (kstrto##_u(page, 0, &val) < 0)                                      \
+		return -EINVAL;                                                \
+	func->_name = val;                                              \
+	return len;                                                            \
+}
+
+I3C_SLAVE_ATTR_R(vendor_id);
+I3C_SLAVE_ATTR_W(vendor_id, u16);
+CONFIGFS_ATTR(i3c_slave_func_, vendor_id);
+
+I3C_SLAVE_ATTR_R(vendor_info);
+I3C_SLAVE_ATTR_W(vendor_info, u16);
+CONFIGFS_ATTR(i3c_slave_func_, vendor_info);
+
+I3C_SLAVE_ATTR_R(part_id);
+I3C_SLAVE_ATTR_W(part_id, u16);
+CONFIGFS_ATTR(i3c_slave_func_, part_id);
+
+I3C_SLAVE_ATTR_R(instance_id);
+I3C_SLAVE_ATTR_W(instance_id, u8);
+CONFIGFS_ATTR(i3c_slave_func_, instance_id);
+
+I3C_SLAVE_ATTR_R(ext_id);
+I3C_SLAVE_ATTR_W(ext_id, u16);
+CONFIGFS_ATTR(i3c_slave_func_, ext_id);
+
+I3C_SLAVE_ATTR_R(max_write_len);
+I3C_SLAVE_ATTR_W(max_write_len, u16);
+CONFIGFS_ATTR(i3c_slave_func_, max_write_len);
+
+I3C_SLAVE_ATTR_R(max_read_len);
+I3C_SLAVE_ATTR_W(max_read_len, u16);
+CONFIGFS_ATTR(i3c_slave_func_, max_read_len);
+
+I3C_SLAVE_ATTR_R(bcr);
+I3C_SLAVE_ATTR_W(bcr, u8);
+CONFIGFS_ATTR(i3c_slave_func_, bcr);
+
+I3C_SLAVE_ATTR_R(dcr);
+I3C_SLAVE_ATTR_W(dcr, u8);
+CONFIGFS_ATTR(i3c_slave_func_, dcr);
+
+static struct configfs_attribute *i3c_slave_func_attrs[] = {
+	&i3c_slave_func_attr_vendor_id,
+	&i3c_slave_func_attr_vendor_info,
+	&i3c_slave_func_attr_part_id,
+	&i3c_slave_func_attr_instance_id,
+	&i3c_slave_func_attr_ext_id,
+	&i3c_slave_func_attr_max_write_len,
+	&i3c_slave_func_attr_max_read_len,
+	&i3c_slave_func_attr_bcr,
+	&i3c_slave_func_attr_dcr,
+	NULL,
+};
+
+static const struct config_item_type i3c_slave_func_type = {
+	.ct_attrs       = i3c_slave_func_attrs,
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct config_group *i3c_slave_func_make(struct config_group *group, const char *name)
+{
+	struct i3c_slave_func_group *func_group;
+	struct i3c_slave_func *func;
+	int err;
+
+	func_group = kzalloc(sizeof(*func_group), GFP_KERNEL);
+	if (!func_group)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&func_group->group, name, &i3c_slave_func_type);
+
+	func = i3c_slave_func_create(group->cg_item.ci_name, name);
+	if (IS_ERR(func)) {
+		pr_err("failed to create i3c slave function device\n");
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
+static void i3c_slave_func_drop(struct config_group *group, struct config_item *item)
+{
+	config_item_put(item);
+}
+
+static struct configfs_group_operations i3c_slave_func_group_ops = {
+	.make_group     = &i3c_slave_func_make,
+	.drop_item      = &i3c_slave_func_drop,
+};
+
+static const struct config_item_type i3c_slave_func_group_type = {
+	.ct_group_ops   = &i3c_slave_func_group_ops,
+	.ct_owner       = THIS_MODULE,
+};
+
+/**
+ * i3c_slave_cfs_add_func_group() - add I3C slave function group
+ * @name: group name
+ *
+ * Return: Pointer to struct config_group
+ */
+struct config_group *i3c_slave_cfs_add_func_group(const char *name)
+{
+	struct config_group *group;
+
+	group = configfs_register_default_group(functions_group, name,
+						&i3c_slave_func_group_type);
+	if (IS_ERR(group))
+		pr_err("failed to register configfs group for %s function\n",
+		       name);
+
+	return group;
+}
+EXPORT_SYMBOL(i3c_slave_cfs_add_func_group);
+
+/**
+ * i3c_slave_cfs_remove_func_group() - add I3C slave function group
+ * @group: group to be removed
+ */
+void i3c_slave_cfs_remove_func_group(struct config_group *group)
+{
+	if (IS_ERR_OR_NULL(group))
+		return;
+
+	configfs_unregister_default_group(group);
+}
+EXPORT_SYMBOL(i3c_slave_cfs_remove_func_group);
+
+static const struct config_item_type i3c_slave_controllers_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static const struct config_item_type i3c_slave_functions_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static const struct config_item_type i3c_slave_type = {
+	.ct_owner       = THIS_MODULE,
+};
+
+static struct configfs_subsystem i3c_slave_cfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "i3c_slave",
+			.ci_type = &i3c_slave_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(i3c_slave_cfs_subsys.su_mutex),
+};
+
+static int __init i3c_slave_cfs_init(void)
+{
+	int ret;
+	struct config_group *root = &i3c_slave_cfs_subsys.su_group;
+
+	config_group_init(root);
+
+	ret = configfs_register_subsystem(&i3c_slave_cfs_subsys);
+	if (ret) {
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret, root->cg_item.ci_namebuf);
+		goto err;
+	}
+
+	functions_group = configfs_register_default_group(root, "functions",
+							  &i3c_slave_functions_type);
+	if (IS_ERR(functions_group)) {
+		ret = PTR_ERR(functions_group);
+		pr_err("Error %d while registering functions group\n",
+		       ret);
+		goto err_functions_group;
+	}
+
+	controllers_group =
+		configfs_register_default_group(root, "controllers",
+						&i3c_slave_controllers_type);
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
+	configfs_unregister_subsystem(&i3c_slave_cfs_subsys);
+
+err:
+	return ret;
+}
+module_init(i3c_slave_cfs_init);
+
+MODULE_DESCRIPTION("I3C FUNC CONFIGFS");
+MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
diff --git a/drivers/i3c/slave.c b/drivers/i3c/slave.c
new file mode 100644
index 0000000000000..4d2cea1d09299
--- /dev/null
+++ b/drivers/i3c/slave.c
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
+#include <linux/module.h>
+#include <linux/i3c/slave.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(func_lock);
+static struct class *i3c_slave_ctrl_class;
+
+static void i3c_slave_func_dev_release(struct device *dev)
+{
+	struct i3c_slave_func *func = to_i3c_slave_func(dev);
+
+	kfree(func->name);
+	kfree(func);
+}
+
+static const struct device_type i3c_slave_func_type = {
+	.release        = i3c_slave_func_dev_release,
+};
+
+static int i3c_slave_func_match_driver(struct device *dev, struct device_driver *drv)
+{
+	return !strncmp(dev_name(dev), drv->name, strlen(drv->name));
+}
+
+static int i3c_slave_func_device_probe(struct device *dev)
+{
+	struct i3c_slave_func *func = to_i3c_slave_func(dev);
+	struct i3c_slave_func_driver *driver = to_i3c_slave_func_driver(dev->driver);
+
+	if (!driver->probe)
+		return -ENODEV;
+
+	func->driver = driver;
+
+	return driver->probe(func);
+}
+
+static void i3c_slave_func_device_remove(struct device *dev)
+{
+	struct i3c_slave_func *func = to_i3c_slave_func(dev);
+	struct i3c_slave_func_driver *driver = to_i3c_slave_func_driver(dev->driver);
+
+	if (driver->remove)
+		driver->remove(func);
+	func->driver = NULL;
+}
+
+static const struct bus_type i3c_slave_func_bus_type = {
+	.name = "i3c_slave_func",
+	.probe = i3c_slave_func_device_probe,
+	.remove = i3c_slave_func_device_remove,
+	.match = i3c_slave_func_match_driver,
+};
+
+static void i3c_slave_ctrl_release(struct device *dev)
+{
+	kfree(to_i3c_slave_ctrl(dev));
+}
+
+static void devm_i3c_slave_ctrl_release(struct device *dev, void *res)
+{
+	struct i3c_slave_ctrl *ctrl = *(struct i3c_slave_ctrl **)res;
+
+	i3c_slave_ctrl_destroy(ctrl);
+}
+
+struct i3c_slave_ctrl *
+__devm_i3c_slave_ctrl_create(struct device *dev, const struct i3c_slave_ctrl_ops *ops,
+			     struct module *owner)
+{
+	struct i3c_slave_ctrl **ptr, *ctrl;
+
+	ptr = devres_alloc(devm_i3c_slave_ctrl_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	ctrl = __i3c_slave_ctrl_create(dev, ops, owner);
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
+static int devm_i3c_slave_ctrl_match(struct device *dev, void *res, void *match_data)
+{
+	struct i3c_slave_ctrl **ptr = res;
+
+	return *ptr == match_data;
+}
+
+/**
+ * __i3c_slave_ctrl_create() - create a new slave controller device
+ * @dev: device that is creating the new slave controller
+ * @ops: function pointers for performing slave controller  operations
+ * @owner: the owner of the module that creates the slave controller device
+ *
+ * Return: Pointer to struct i3c_slave_ctrl
+ */
+struct i3c_slave_ctrl *
+__i3c_slave_ctrl_create(struct device *dev, const struct i3c_slave_ctrl_ops *ops,
+			struct module *owner)
+{
+	struct i3c_slave_ctrl *ctrl;
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
+	ctrl->dev.class = i3c_slave_ctrl_class;
+	ctrl->dev.parent = dev;
+	ctrl->dev.release = i3c_slave_ctrl_release;
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
+	ctrl->group = i3c_slave_cfs_add_ctrl_group(ctrl);
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
+EXPORT_SYMBOL_GPL(__i3c_slave_ctrl_create);
+
+/**
+ * devm_i3c_slave_ctrl_destroy() - destroy the slave controller device
+ * @dev: device that is creating the new slave controller device
+ * @ops: function pointers for performing slave controller operations
+ * @owner: the owner of the module that creates the slave controller device
+ *
+ * Invoke to create a new slave controller device and add it to i3c_slave class. While at that, it
+ * also associates the device with the i3c_slave using devres. On driver detach, release function is
+ * invoked on the devres data, then devres data is freed.
+ */
+void devm_i3c_slave_ctrl_destroy(struct device *dev, struct i3c_slave_ctrl *ctrl)
+{
+	int r;
+
+	r = devres_destroy(dev, devm_i3c_slave_ctrl_release, devm_i3c_slave_ctrl_match,
+			   ctrl);
+	dev_WARN_ONCE(dev, r, "couldn't find I3C controller resource\n");
+}
+EXPORT_SYMBOL_GPL(devm_i3c_slave_ctrl_destroy);
+
+/**
+ * i3c_slave_ctrl_destroy() - destroy the slave controller device
+ * @ctrl: the slave controller device that has to be destroyed
+ *
+ * Invoke to destroy the I3C slave device
+ */
+void i3c_slave_ctrl_destroy(struct i3c_slave_ctrl *ctrl)
+{
+	i3c_slave_cfs_remove_ctrl_group(ctrl->group);
+	device_unregister(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_destroy);
+
+/**
+ * i3c_slave_ctrl_add_func() - bind I3C slave function to an slave controller
+ * @ctrl: the controller device to which the slave function should be added
+ * @func: the slave function to be added
+ *
+ * An I3C slave device can have only one functions.
+ */
+int i3c_slave_ctrl_add_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
+{
+	if (ctrl->func)
+		return -EBUSY;
+
+	ctrl->func = func;
+	func->ctrl = ctrl;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_add_func);
+
+/**
+ * i3c_slave_ctrl_remove_func() - unbind I3C slave function to an slave controller
+ * @ctrl: the controller device to which the slave function should be removed
+ * @func: the slave function to be removed
+ *
+ * An I3C slave device can have only one functions.
+ */
+void i3c_slave_ctrl_remove_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
+{
+	ctrl->func = NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_remove_func);
+
+/**
+ * i3c_slave_ctrl() - get the I3C slave controller
+ * @name: device name of the slave controller
+ *
+ * Invoke to get struct i3c_slave_ctrl * corresponding to the device name of the
+ * slave controller
+ */
+struct i3c_slave_ctrl *i3c_slave_ctrl_get(const char *name)
+{
+	int ret = -EINVAL;
+	struct i3c_slave_ctrl *ctrl;
+	struct device *dev;
+	struct class_dev_iter iter;
+
+	class_dev_iter_init(&iter, i3c_slave_ctrl_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		if (strcmp(name, dev_name(dev)))
+			continue;
+
+		ctrl = to_i3c_slave_ctrl(dev);
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
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_get);
+
+/**
+ * i3c_slave_ctrl_put() - release the I3C endpoint controller
+ * @ctrl: slave controller returned by pci_slave_get()
+ *
+ * release the refcount the caller obtained by invoking i3c_slave_ctrl_get()
+ */
+void i3c_slave_ctrl_put(struct i3c_slave_ctrl *ctrl)
+{
+	if (!ctrl || IS_ERR(ctrl))
+		return;
+
+	module_put(ctrl->ops->owner);
+	put_device(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_put);
+
+/**
+ * i3c_slave_ctrl_hotjoin() - trigger device hotjoin
+ * @ctrl:  slave controller
+ *
+ * return: 0: success, others failure
+ */
+int i3c_slave_ctrl_hotjoin(struct i3c_slave_ctrl *ctrl)
+{
+	if (!ctrl || IS_ERR(ctrl))
+		return -EINVAL;
+
+	if (!ctrl->ops->hotjoin)
+		return -EINVAL;
+
+	return ctrl->ops->hotjoin(ctrl);
+}
+EXPORT_SYMBOL_GPL(i3c_slave_ctrl_hotjoin);
+
+/**
+ * i3c_slave_func_bind() - Notify the function driver that the function device has been bound to a
+ *			   controller device
+ * @func: the function device which has been bound to the controller device
+ *
+ * Invoke to notify the function driver that it has been bound to a controller device
+ */
+int i3c_slave_func_bind(struct i3c_slave_func *func)
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
+EXPORT_SYMBOL_GPL(i3c_slave_func_bind);
+
+/**
+ * i3c_slave_func_unbind() - Notify the function driver that the binding between the function device
+ *			     and controller device has been lost
+ * @func: the function device which has lost the binding with the controller device
+ *
+ * Invoke to notify the function driver that the binding between the function device and controller
+ * device has been lost.
+ */
+void i3c_slave_func_unbind(struct i3c_slave_func *func)
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
+EXPORT_SYMBOL_GPL(i3c_slave_func_unbind);
+
+/**
+ * i3c_slave_func_create() - create a new I3C function device
+ * @drv_name: the driver name of the I3C function device.
+ * @name: the name of the function device.
+ *
+ * Invoke to create a new I3C function device by providing the name of the function device.
+ */
+struct i3c_slave_func *i3c_slave_func_create(const char *drv_name, const char *name)
+{
+	struct i3c_slave_func *func;
+	struct device *dev;
+	int ret;
+
+	func = kzalloc(sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &func->dev;
+	device_initialize(dev);
+	dev->bus = &i3c_slave_func_bus_type;
+	dev->type = &i3c_slave_func_type;
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
+EXPORT_SYMBOL_GPL(i3c_slave_func_create);
+
+/**
+ * __i3c_slave_func_register_driver() - register a new I3C function driver
+ * @driver: structure representing I3C function driver
+ * @owner: the owner of the module that registers the I3C function driver
+ *
+ * Invoke to register a new I3C function driver.
+ */
+int __i3c_slave_func_register_driver(struct i3c_slave_func_driver *driver, struct module *owner)
+{
+	int ret = -EEXIST;
+
+	if (!driver->ops)
+		return -EINVAL;
+
+	if (!driver->ops->bind || !driver->ops->unbind)
+		return -EINVAL;
+
+	driver->driver.bus = &i3c_slave_func_bus_type;
+	driver->driver.owner = owner;
+
+	ret = driver_register(&driver->driver);
+	if (ret)
+		return ret;
+
+	i3c_slave_cfs_add_func_group(driver->driver.name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__i3c_slave_func_register_driver);
+
+/**
+ * i3c_slave_func_unregister_driver() - unregister the I3C function driver
+ * @driver: the I3C function driver that has to be unregistered
+ *
+ * Invoke to unregister the I3C function driver.
+ */
+void i3c_slave_func_unregister_driver(struct i3c_slave_func_driver *fd)
+{
+	mutex_lock(&func_lock);
+	mutex_unlock(&func_lock);
+}
+EXPORT_SYMBOL_GPL(i3c_slave_func_unregister_driver);
+
+static int __init i3c_slave_init(void)
+{
+	int ret;
+
+	i3c_slave_ctrl_class = class_create("i3c_slave");
+	if (IS_ERR(i3c_slave_ctrl_class)) {
+		pr_err("failed to create i3c slave class --> %ld\n", PTR_ERR(i3c_slave_ctrl_class));
+		return PTR_ERR(i3c_slave_ctrl_class);
+	}
+
+	ret = bus_register(&i3c_slave_func_bus_type);
+	if (ret) {
+		class_destroy(i3c_slave_ctrl_class);
+		pr_err("failed to register i3c slave func bus --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(i3c_slave_init);
+
+static void __exit i3c_slave_exit(void)
+{
+	class_destroy(i3c_slave_ctrl_class);
+	bus_unregister(&i3c_slave_func_bus_type);
+}
+module_exit(i3c_slave_exit);
+
diff --git a/include/linux/i3c/slave.h b/include/linux/i3c/slave.h
new file mode 100644
index 0000000000000..19eb71cfa81f2
--- /dev/null
+++ b/include/linux/i3c/slave.h
@@ -0,0 +1,503 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef I3C_SLAVE_H
+#define I3C_SLAVE_H
+
+#include <linux/device.h>
+
+struct i3c_slave_func;
+struct i3c_slave_ctrl;
+
+/**
+ * struct i3c_slave_func_ops - set of function pointers for performing i3c slave function operations
+ * @bind: ops to perform when a controller device has been bound to function device
+ * @unbind: ops to perform when a binding has been lost between a controller device and function
+ *	    device
+ */
+struct i3c_slave_func_ops {
+	int (*bind)(struct i3c_slave_func *func);
+	void (*unbind)(struct i3c_slave_func *func);
+};
+
+/**
+ * struct i3c_slave_func_driver - represents the I3C function driver
+ * @probe: ops to perform when a new function device has been bound to the function driver
+ * @remove: ops to perform when the binding between the function device and function driver is
+ *	    broken
+ * @driver: I3C Function driver
+ * @ops: set of function pointers for performing function operations
+ * @owner: the owner of the module that registers the I3C function driver
+ * @epf_group: list of configfs group corresponding to the I3C function driver
+ */
+struct i3c_slave_func_driver {
+	int (*probe)(struct i3c_slave_func *func);
+	void (*remove)(struct i3c_slave_func *func);
+
+	char *name;
+	struct device_driver driver;
+	struct i3c_slave_func_ops *ops;
+	struct module *owner;
+};
+
+/**
+ * struct i3c_slave_func - represents the I3C function device
+ * @dev: the I3C function device
+ * @name: the name of the I3C function device
+ * @driver: the function driver to which this function device is bound
+ * @group: configfs group associated with the EPF device
+ * @lock: mutex to protect i3c_slave_func_ops
+ * @ctrl: binded I3C controller device
+ * @is_bound: indicates if bind notification to function driver has been invoked
+ * @vednor_id: vendor id
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
+struct i3c_slave_func {
+	struct device dev;
+	char *name;
+	struct i3c_slave_func_driver *driver;
+	struct config_group *group;
+	/* mutex to protect against concurrent access of i3c_slave_func_ops */
+	struct mutex lock;
+	struct i3c_slave_ctrl *ctrl;
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
+ * @status: transfer status
+ * @actual: how much actually transferred
+ * @ctrl: I3C slave controller associate with this request
+ * @tx: transfer direction, 1: slave to master, 0: master to slave
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
+	struct i3c_slave_ctrl *ctrl;
+	bool tx;
+};
+
+/**
+ * struct i3c_slave_ctrl_features - represents I3C slave controller features.
+ * @tx_fifo_sz: tx hardware fifo size
+ * @rx_fifo_sz: rx hardware fifo size
+ */
+struct i3c_slave_ctrl_features {
+	u32 tx_fifo_sz;
+	u32 rx_fifo_sz;
+};
+
+/**
+ * struct i3c_slave_ctrl_ops - set of function pointers for performing controller operations
+ * @set_config: set I3C controller configuration
+ * @enable: enable I3C controller
+ * @disable: disable I3C controller
+ * @raise_ibi: rasie IBI interrupt to master
+ * @queue: queue an I3C transfer
+ * @dequeue: dequeue an I3C transfer
+ * @cancel_all_reqs: call all pending requests
+ * @fifo_status: current FIFO status
+ * @fifo_flush: flush hardware FIFO
+ * @get_features: ops to get the features supported by the I3C slave controller
+ * @owner: the module owner containing the ops
+ */
+struct i3c_slave_ctrl_ops {
+	int (*set_config)(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func);
+	int (*enable)(struct i3c_slave_ctrl *ctrl);
+	int (*disable)(struct i3c_slave_ctrl *ctrl);
+	int (*raise_ibi)(struct i3c_slave_ctrl *ctrl, void *p, u8 size);
+
+	struct i3c_request *(*alloc_request)(struct i3c_slave_ctrl *ctrl, gfp_t gfp_flags);
+	void (*free_request)(struct i3c_request *req);
+
+	int (*queue)(struct i3c_request *req, gfp_t gfp_flags);
+	int (*dequeue)(struct i3c_request *req);
+
+	void (*cancel_all_reqs)(struct i3c_slave_ctrl *ctrl, bool tx);
+
+	int (*fifo_status)(struct i3c_slave_ctrl *ctrl, bool tx);
+	void (*fifo_flush)(struct i3c_slave_ctrl *ctrl, bool tx);
+	int (*hotjoin)(struct i3c_slave_ctrl *ctrl);
+	int (*set_status_format1)(struct i3c_slave_ctrl *ctrl, u16 status);
+	u16 (*get_status_format1)(struct i3c_slave_ctrl *ctrl);
+	u8  (*get_addr)(struct i3c_slave_ctrl *ctrl);
+	const struct i3c_slave_ctrl_features *(*get_features)(struct i3c_slave_ctrl *ctrl);
+	struct module *owner;
+};
+
+/**
+ * struct i3c_slave_ctrl - represents the I3C slave device
+ * @dev: I3C slave device
+ * @ops: function pointers for performing endpoint operations
+ * @func: slave functions present in this controller device
+ * @group: configfs group representing the I3C controller device
+ */
+struct i3c_slave_ctrl {
+	struct device dev;
+	const struct i3c_slave_ctrl_ops *ops;
+	struct i3c_slave_func *func;
+	struct config_group *group;
+};
+
+/**
+ * i3c_slave_ctrl_raise_ibi() - Raise IBI to master
+ * @ctrl: I3C slave controller
+ * @p: optional data for IBI
+ * @size: size of optional data
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int i3c_slave_ctrl_raise_ibi(struct i3c_slave_ctrl *ctrl, void *p, u8 size)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->raise_ibi)
+		return ctrl->ops->raise_ibi(ctrl, p, size);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_slave_ctrl_cancel_all_reqs() - Cancel all pending request
+ * @ctrl: I3C slave controller
+ * @tx: Transfer diretion queue
+ * @size: size of optional data
+ */
+static inline void i3c_slave_ctrl_cancel_all_reqs(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->cancel_all_reqs)
+		ctrl->ops->cancel_all_reqs(ctrl, tx);
+}
+
+/**
+ * i3c_slave_ctrl_set_config() - Set controller configuration
+ * @ctrl: I3C slave controller device
+ * @func: Function device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_set_config(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->set_config)
+		return ctrl->ops->set_config(ctrl, func);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_slave_ctrl_enable() - Enable I3C controller
+ * @ctrl: I3C slave controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_enable(struct i3c_slave_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->enable)
+		return ctrl->ops->enable(ctrl);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_slave_ctrl_disable() - Disable I3C controller
+ * @ctrl: I3C slave controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_disable(struct i3c_slave_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->disable)
+		return ctrl->ops->disable(ctrl);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_slave_ctrl_alloc_request() - Alloc an I3C transfer
+ * @ctrl: I3C slave controller device
+ * gfp_flags: additional gfp flags used when allocating the buffers
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline struct i3c_request *
+i3c_slave_ctrl_alloc_request(struct i3c_slave_ctrl *ctrl, gfp_t gfp_flags)
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
+ * i3c_slave_ctrl_free_request() - Free an I3C transfer
+ * @ctrl: I3C slave controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline void
+i3c_slave_ctrl_free_request(struct i3c_request *req)
+{
+	struct i3c_slave_ctrl *ctrl;
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
+ * i3c_slave_ctrl_queue() - Queue an I3C transfer
+ * @ctrl: I3C slave controller device
+ * gfp_flags: additional gfp flags used when allocating the buffers
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_queue(struct i3c_request *req, gfp_t gfp_flags)
+{
+	struct i3c_slave_ctrl *ctrl;
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
+ * i3c_slave_ctrl_dequeue() - Dequeue an I3C transfer
+ * @ctrl: I3C slave controller device
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_dequeue(struct i3c_request *req)
+{
+	struct i3c_slave_ctrl *ctrl;
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
+ * i3c_slave_ctrl_fifo_status() - Get controller FIFO status
+ * @ctrl: I3C slave controller device
+ * @tx: 1: Slave to master, 0: master to slave
+ *
+ * Returns: How much data in FIFO
+ */
+static inline int
+i3c_slave_ctrl_fifo_status(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->fifo_status)
+		return ctrl->ops->fifo_status(ctrl, tx);
+
+	return 0;
+}
+
+/**
+ * i3c_slave_ctrl_fifo_flush() - Flush controller FIFO
+ * @ctrl: I3C slave controller device
+ * @tx: 1: Slave to master, 0: master to slave
+ *
+ */
+static inline void
+i3c_slave_ctrl_fifo_flush(struct i3c_slave_ctrl *ctrl, bool tx)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->fifo_flush)
+		return ctrl->ops->fifo_flush(ctrl, tx);
+}
+
+/**
+ * i3c_slave_ctrl_get_features() - Get controller supported features
+ * @ctrl: I3C slave controller device
+ *
+ * Returns: The pointer to struct i3c_slave_ctrl_features
+ */
+static inline const struct i3c_slave_ctrl_features*
+i3c_slave_ctrl_get_features(struct i3c_slave_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_features)
+		return ctrl->ops->get_features(ctrl);
+
+	return NULL;
+}
+
+/**
+ * i3c_slave_set_status_format1() - Set controller supported features
+ * &ctrl: I3C slave controller device
+ * &status: I3C GETSTATUS format1
+ *
+ * Returns: Zero for success, or an error code in case of failure
+ */
+static inline int
+i3c_slave_ctrl_set_status_format1(struct i3c_slave_ctrl *ctrl, u16 status)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->set_status_format1)
+		return ctrl->ops->set_status_format1(ctrl, status);
+
+	return -EINVAL;
+}
+
+/**
+ * i3c_slave_get_status_format1() - Get controller supported features
+ * &ctrl: I3C slave controller device
+ *
+ * Return: I3C GETSTATUS format1
+ */
+static inline u16
+i3c_slave_ctrl_get_status_format1(struct i3c_slave_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_status_format1)
+		return ctrl->ops->get_status_format1(ctrl);
+
+	return 0;
+}
+
+/**
+ * i3c_slave_ctrl_get_addr() - Get controller address
+ * &ctrl: I3C slave controller device
+ *
+ * Return: address
+ */
+static inline u8 i3c_slave_ctrl_get_addr(struct i3c_slave_ctrl *ctrl)
+{
+	if (ctrl && ctrl->ops && ctrl->ops->get_addr)
+		return ctrl->ops->get_addr(ctrl);
+
+	return 0;
+}
+
+#define to_i3c_slave_ctrl(device) container_of((device), struct i3c_slave_ctrl, dev)
+
+#define to_i3c_slave_func(func_dev) container_of((func_dev), struct i3c_slave_func, dev)
+#define to_i3c_slave_func_driver(drv) (container_of((drv), struct i3c_slave_func_driver, driver))
+
+#define i3c_slave_ctrl_create(dev, ops) \
+		__i3c_slave_ctrl_create((dev), (ops), THIS_MODULE)
+#define devm_i3c_slave_ctrl_create(dev, ops) \
+		__devm_i3c_slave_ctrl_create((dev), (ops), THIS_MODULE)
+
+struct i3c_slave_ctrl *
+__devm_i3c_slave_ctrl_create(struct device *dev, const struct i3c_slave_ctrl_ops *ops,
+			     struct module *owner);
+struct i3c_slave_ctrl *
+__i3c_slave_ctrl_create(struct device *dev, const struct i3c_slave_ctrl_ops *ops,
+			struct module *owner);
+
+void devm_i3c_slave_ctrl_destroy(struct device *dev, struct i3c_slave_ctrl *epc);
+void i3c_slave_ctrl_destroy(struct i3c_slave_ctrl *epc);
+
+int i3c_slave_ctrl_add_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func);
+void i3c_slave_ctrl_remove_func(struct i3c_slave_ctrl *ctrl, struct i3c_slave_func *func);
+int i3c_slave_ctrl_hotjoin(struct i3c_slave_ctrl *ctrl);
+
+struct config_group *i3c_slave_cfs_add_ctrl_group(struct i3c_slave_ctrl *ctrl);
+
+void i3c_slave_cfs_remove_ctrl_group(struct config_group *group);
+struct config_group *i3c_slave_cfs_add_func_group(const char *name);
+void i3c_slave_cfs_remove_func_group(struct config_group *group);
+struct i3c_slave_ctrl *i3c_slave_ctrl_get(const char *name);
+void i3c_slave_ctrl_put(struct i3c_slave_ctrl *ctrl);
+
+int i3c_slave_func_bind(struct i3c_slave_func *func);
+void i3c_slave_func_unbind(struct i3c_slave_func *func);
+struct i3c_slave_func *i3c_slave_func_create(const char *drv_name, const char *name);
+
+#define i3c_slave_func_register_driver(drv) \
+	__i3c_slave_func_register_driver(drv, THIS_MODULE)
+
+int __i3c_slave_func_register_driver(struct i3c_slave_func_driver *drv, struct module *owner);
+void i3c_slave_func_unregister_driver(struct i3c_slave_func_driver *drv);
+
+#define DECLARE_I3C_SLAVE_FUNC(_name, _probe, _remove, _ops)			\
+	static struct i3c_slave_func_driver _name ## i3c_func = {		\
+		.driver.name = __stringify(_name),				\
+		.owner  = THIS_MODULE,						\
+		.probe = _probe,						\
+		.remove = _remove,						\
+		.ops = _ops							\
+	};									\
+	MODULE_ALIAS("i3cfunc:" __stringify(_name))
+
+#define DECLARE_I3C_SLAVE_INIT(_name, _probe, _remove, _ops)			\
+	DECLARE_I3C_SLAVE_FUNC(_name, _probe, _remove, _ops);			\
+	static int __init _name ## mod_init(void)				\
+	{									\
+		return i3c_slave_func_register_driver(&_name ## i3c_func);	\
+	}									\
+	static void __exit _name ## mod_exit(void)				\
+	{									\
+		i3c_slave_func_unregister_driver(&_name ## i3c_func);		\
+	}									\
+	module_init(_name ## mod_init);						\
+	module_exit(_name ## mod_exit)
+
+#endif
-- 
2.34.1

