Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F587A4E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjIRQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIRQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:19:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A14219
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:11:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38IFLpNf021488;
        Mon, 18 Sep 2023 11:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=d
        o0kUd/xLRnHPvG9yNEyG6NRtmmHDM29t1A6717Hh40=; b=HSt963jiUVBtexqM5
        02fI9MoLQzgVRFacT2vzaZsCY03kxhNrNchdnQdwDKAnucdR6JHk4E5GBwcUkmsO
        TQqsAqkrKeE2L2YgGUqA8oQ/gHMjXEcJtplWq5maylP0LaLsqOhi0L9k6u2XXlnb
        LfQQIYVaZDhxyXcE+swKJaXYb9h3VW3ofQVyJKEYAT7h1JbprYPkQmR4RDGvl6ka
        yH0Lgs42quhphQhv7qU6YIUoFiXBbvWc5uyjEvC/YfeiNQF3K9k75nClj2QsELgi
        OJ0TJvZPLRH7/s2gP+3hgR+QU4qcw6fmKK0HTN7CR8L5ygZo+FjguM91XmA5EfVW
        J9HwQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t58sht22u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:10:28 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 17:10:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 17:10:27 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05025458;
        Mon, 18 Sep 2023 16:10:27 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <rdunlap@infradead.org>
Subject: [PATCH] soundwire: bus: Make IRQ handling conditionally built
Date:   Mon, 18 Sep 2023 17:10:26 +0100
Message-ID: <20230918161026.472405-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: f0H0xnYTV3YKxGagOPo52fVUW1Xd2rO6
X-Proofpoint-ORIG-GUID: f0H0xnYTV3YKxGagOPo52fVUW1Xd2rO6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire has provisions for a simple callback for the IRQ handling so
has no hard dependency on IRQ_DOMAIN, but the recent addition of IRQ
handling was causing builds without IRQ_DOMAIN to fail. Resolve this by
moving the IRQ handling into its own file and only add it to the build
when IRQ_DOMAIN is included in the kernel.

Fixes: 12a95123bfe1 ("soundwire: bus: Allow SoundWire peripherals to register IRQ handlers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309150522.MoKeF4jx-lkp@intel.com/
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/Makefile   |  4 +++
 drivers/soundwire/bus.c      | 31 +++----------------
 drivers/soundwire/bus_type.c | 11 +++----
 drivers/soundwire/irq.c      | 59 ++++++++++++++++++++++++++++++++++++
 drivers/soundwire/irq.h      | 43 ++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 33 deletions(-)
 create mode 100644 drivers/soundwire/irq.c
 create mode 100644 drivers/soundwire/irq.h

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index c3d3ab3262d3a..657f5888a77b0 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -15,6 +15,10 @@ ifdef CONFIG_DEBUG_FS
 soundwire-bus-y += debugfs.o
 endif
 
+ifdef CONFIG_IRQ_DOMAIN
+soundwire-bus-y += irq.o
+endif
+
 #AMD driver
 soundwire-amd-y :=	amd_manager.o
 obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1720031f35a35..0e7bc3c40f9df 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -3,13 +3,13 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
+#include "irq.h"
 #include "sysfs_local.h"
 
 static DEFINE_IDA(sdw_bus_ida);
@@ -25,23 +25,6 @@ static int sdw_get_id(struct sdw_bus *bus)
 	return 0;
 }
 
-static int sdw_irq_map(struct irq_domain *h, unsigned int virq,
-		       irq_hw_number_t hw)
-{
-	struct sdw_bus *bus = h->host_data;
-
-	irq_set_chip_data(virq, bus);
-	irq_set_chip(virq, &bus->irq_chip);
-	irq_set_nested_thread(virq, 1);
-	irq_set_noprobe(virq);
-
-	return 0;
-}
-
-static const struct irq_domain_ops sdw_domain_ops = {
-	.map	= sdw_irq_map,
-};
-
 /**
  * sdw_bus_master_add() - add a bus Master instance
  * @bus: bus instance
@@ -168,13 +151,9 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 	bus->params.curr_bank = SDW_BANK0;
 	bus->params.next_bank = SDW_BANK1;
 
-	bus->irq_chip.name = dev_name(bus->dev);
-	bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
-					       &sdw_domain_ops, bus);
-	if (!bus->domain) {
-		dev_err(bus->dev, "Failed to add IRQ domain\n");
-		return -EINVAL;
-	}
+	ret = sdw_irq_create(bus, fwnode);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -213,7 +192,7 @@ void sdw_bus_master_delete(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
 
-	irq_domain_remove(bus->domain);
+	sdw_irq_delete(bus);
 
 	sdw_master_device_del(bus);
 
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index fafbc284e82da..9fa93bb923d70 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -7,6 +7,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
+#include "irq.h"
 #include "sysfs_local.h"
 
 /**
@@ -122,11 +123,8 @@ static int sdw_drv_probe(struct device *dev)
 	if (drv->ops && drv->ops->read_prop)
 		drv->ops->read_prop(slave);
 
-	if (slave->prop.use_domain_irq) {
-		slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
-		if (!slave->irq)
-			dev_warn(dev, "Failed to map IRQ\n");
-	}
+	if (slave->prop.use_domain_irq)
+		sdw_irq_create_mapping(slave);
 
 	/* init the sysfs as we have properties now */
 	ret = sdw_slave_sysfs_init(slave);
@@ -176,8 +174,7 @@ static int sdw_drv_remove(struct device *dev)
 	slave->probed = false;
 
 	if (slave->prop.use_domain_irq)
-		irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
-						     slave->dev_num));
+		sdw_irq_dispose_mapping(slave);
 
 	mutex_unlock(&slave->sdw_dev_lock);
 
diff --git a/drivers/soundwire/irq.c b/drivers/soundwire/irq.c
new file mode 100644
index 0000000000000..0c08cebb1235c
--- /dev/null
+++ b/drivers/soundwire/irq.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2023 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/soundwire/sdw.h>
+#include "irq.h"
+
+static int sdw_irq_map(struct irq_domain *h, unsigned int virq,
+		       irq_hw_number_t hw)
+{
+	struct sdw_bus *bus = h->host_data;
+
+	irq_set_chip_data(virq, bus);
+	irq_set_chip(virq, &bus->irq_chip);
+	irq_set_nested_thread(virq, 1);
+	irq_set_noprobe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sdw_domain_ops = {
+	.map	= sdw_irq_map,
+};
+
+int sdw_irq_create(struct sdw_bus *bus,
+		   struct fwnode_handle *fwnode)
+{
+	bus->irq_chip.name = dev_name(bus->dev);
+
+	bus->domain = irq_domain_create_linear(fwnode, SDW_MAX_DEVICES,
+					       &sdw_domain_ops, bus);
+	if (!bus->domain) {
+		dev_err(bus->dev, "Failed to add IRQ domain\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void sdw_irq_delete(struct sdw_bus *bus)
+{
+	irq_domain_remove(bus->domain);
+}
+
+void sdw_irq_create_mapping(struct sdw_slave *slave)
+{
+	slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
+	if (!slave->irq)
+		dev_warn(&slave->dev, "Failed to map IRQ\n");
+}
+
+void sdw_irq_dispose_mapping(struct sdw_slave *slave)
+{
+	irq_dispose_mapping(irq_find_mapping(slave->bus->domain, slave->dev_num));
+}
diff --git a/drivers/soundwire/irq.h b/drivers/soundwire/irq.h
new file mode 100644
index 0000000000000..b6de49419fdf5
--- /dev/null
+++ b/drivers/soundwire/irq.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef __SDW_IRQ_H
+#define __SDW_IRQ_H
+
+#include <linux/soundwire/sdw.h>
+#include <linux/fwnode.h>
+
+#if IS_ENABLED(CONFIG_IRQ_DOMAIN)
+
+int sdw_irq_create(struct sdw_bus *bus,
+		   struct fwnode_handle *fwnode);
+void sdw_irq_delete(struct sdw_bus *bus);
+void sdw_irq_create_mapping(struct sdw_slave *slave);
+void sdw_irq_dispose_mapping(struct sdw_slave *slave);
+
+#else // CONFIG_IRQ_DOMAIN
+
+static inline int sdw_irq_create(struct sdw_bus *bus,
+				 struct fwnode_handle *fwnode)
+{
+	return 0;
+}
+
+static inline void sdw_irq_delete(struct sdw_bus *bus)
+{
+}
+
+static inline void sdw_irq_create_mapping(struct sdw_slave *slave)
+{
+}
+
+static inline void sdw_irq_dispose_mapping(struct sdw_slave *slave)
+{
+}
+
+#endif // CONFIG_IRQ_DOMAIN
+
+#endif // __SDW_IRQ_H
-- 
2.39.2

