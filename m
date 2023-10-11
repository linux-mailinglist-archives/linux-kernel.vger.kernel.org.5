Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C156F7C4B96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbjJKHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbjJKHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:18:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7B8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697008723;
        bh=KIoz5Wpi2lzxMYBllV17ORqZ8OYry3KayOJDeq5yjB0=;
        h=From:Date:Subject:To:Cc:From;
        b=qLrt9QTUZStMyAI7WKHeN6M8TfREy7Ja9bIJNXsUL1LD8roKS/rZvIHPUpyccQd/1
         cCPLEJvC0O4ojAW2U0irO9+RrPNRdXMKhD8oMLCnTNen3qsN9H5OIj97yS4mGtczrA
         X18xFouftN0zczdw/4pWayFDlQ2TLBTRakRl1BU8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 11 Oct 2023 09:18:27 +0200
Subject: [PATCH v2] misc/pvpanic: deduplicate comomn code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-pvpanic-cleanup-v2-1-4b21d56f779f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEJMJmUC/3WNQQrCMBBFr1JmbSSTWEVX3kO6SKejGZA0JG1US
 u9u7N7le/DfXyBzEs5waRZIXCTLGCqYXQPkXXiwkqEyGG0sakQVS3RBSNGTXZijOrWEaPrhqO0
 B6iomvst7K966yl7yNKbPdlDwZ/+3CipULZ1tr1sma/H6Ysk5k5/9PvAE3bquX5qtEXCzAAAA
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697008723; l=9189;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KIoz5Wpi2lzxMYBllV17ORqZ8OYry3KayOJDeq5yjB0=;
 b=VO+Qjya/dEcLfkJ3xaOI2W0E5BLtwEgmACUB/CgQfIHokGkj0MwIIAkA5sfmto21K5/VddNMA
 3WsZEPhMTPBBvy7cHELSdkk14t5E+ezynVMF9cWlyz/qjkOxC0NZXUT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pvpanic-mmio.c and pvpanic-pci.c share a lot of code.
Refactor it into pvpanic.c where it doesn't have to be kept in sync
manually and where the core logic can be understood more easily.

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Switch back to creating attributes race-free via driver->dev_groups
- Link to v1: https://lore.kernel.org/r/20231011-pvpanic-cleanup-v1-1-5c93b05ec331@weissschuh.net
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 58 +---------------------------
 drivers/misc/pvpanic/pvpanic-pci.c  | 58 +---------------------------
 drivers/misc/pvpanic/pvpanic.c      | 76 ++++++++++++++++++++++++++++++++++++-
 drivers/misc/pvpanic/pvpanic.h      | 10 +----
 4 files changed, 80 insertions(+), 122 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index eb97167c03fb..9715798acce3 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -24,52 +24,9 @@ MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic-mmio device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->capability);
-}
-static DEVICE_ATTR_RO(capability);
-
-static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->events);
-}
-
-static ssize_t events_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-	unsigned int tmp;
-	int err;
-
-	err = kstrtouint(buf, 16, &tmp);
-	if (err)
-		return err;
-
-	if ((tmp & pi->capability) != tmp)
-		return -EINVAL;
-
-	pi->events = tmp;
-
-	return count;
-}
-static DEVICE_ATTR_RW(events);
-
-static struct attribute *pvpanic_mmio_dev_attrs[] = {
-	&dev_attr_capability.attr,
-	&dev_attr_events.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pvpanic_mmio_dev);
-
 static int pvpanic_mmio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct pvpanic_instance *pi;
 	struct resource *res;
 	void __iomem *base;
 
@@ -92,18 +49,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pi = devm_kmalloc(dev, sizeof(*pi), GFP_KERNEL);
-	if (!pi)
-		return -ENOMEM;
-
-	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-
-	/* initialize capability by RDPT */
-	pi->capability &= ioread8(base);
-	pi->events = pi->capability;
-
-	return devm_pvpanic_probe(dev, pi);
+	return devm_pvpanic_probe(dev, base);
 }
 
 static const struct of_device_id pvpanic_mmio_match[] = {
@@ -123,7 +69,7 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
 		.acpi_match_table = pvpanic_device_ids,
-		.dev_groups = pvpanic_mmio_dev_groups,
+		.dev_groups = pvpanic_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
 };
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 07eddb5ea30f..689af4c28c2a 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -22,51 +22,8 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->capability);
-}
-static DEVICE_ATTR_RO(capability);
-
-static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%x\n", pi->events);
-}
-
-static ssize_t events_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct pvpanic_instance *pi = dev_get_drvdata(dev);
-	unsigned int tmp;
-	int err;
-
-	err = kstrtouint(buf, 16, &tmp);
-	if (err)
-		return err;
-
-	if ((tmp & pi->capability) != tmp)
-		return -EINVAL;
-
-	pi->events = tmp;
-
-	return count;
-}
-static DEVICE_ATTR_RW(events);
-
-static struct attribute *pvpanic_pci_dev_attrs[] = {
-	&dev_attr_capability.attr,
-	&dev_attr_events.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pvpanic_pci_dev);
-
 static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct pvpanic_instance *pi;
 	void __iomem *base;
 	int ret;
 
@@ -78,18 +35,7 @@ static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *e
 	if (!base)
 		return -ENOMEM;
 
-	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_KERNEL);
-	if (!pi)
-		return -ENOMEM;
-
-	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
-
-	/* initlize capability by RDPT */
-	pi->capability &= ioread8(base);
-	pi->events = pi->capability;
-
-	return devm_pvpanic_probe(&pdev->dev, pi);
+	return devm_pvpanic_probe(&pdev->dev, base);
 }
 
 static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
@@ -103,7 +49,7 @@ static struct pci_driver pvpanic_pci_driver = {
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
 	.driver = {
-		.dev_groups = pvpanic_pci_dev_groups,
+		.dev_groups = pvpanic_dev_groups,
 	},
 };
 module_pci_driver(pvpanic_pci_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 049a12006348..305b367e0ce3 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2021 Oracle.
  */
 
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
@@ -26,6 +27,13 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
+struct pvpanic_instance {
+	void __iomem *base;
+	unsigned int capability;
+	unsigned int events;
+	struct list_head list;
+};
+
 static struct list_head pvpanic_list;
 static spinlock_t pvpanic_lock;
 
@@ -81,11 +89,75 @@ static void pvpanic_remove(void *param)
 	spin_unlock(&pvpanic_lock);
 }
 
-int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->capability);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", pi->events);
+}
+
+static ssize_t events_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pvpanic_instance *pi = dev_get_drvdata(dev);
+	unsigned int tmp;
+	int err;
+
+	err = kstrtouint(buf, 16, &tmp);
+	if (err)
+		return err;
+
+	if ((tmp & pi->capability) != tmp)
+		return -EINVAL;
+
+	pi->events = tmp;
+
+	return count;
+}
+static DEVICE_ATTR_RW(events);
+
+static struct attribute *pvpanic_dev_attrs[] = {
+	&dev_attr_capability.attr,
+	&dev_attr_events.attr,
+	NULL
+};
+
+static const struct attribute_group pvpanic_dev_group = {
+	.attrs = pvpanic_dev_attrs,
+};
+
+const struct attribute_group *pvpanic_dev_groups[] = {
+	&pvpanic_dev_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(pvpanic_dev_groups);
+
+int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 {
-	if (!pi || !pi->base)
+	struct pvpanic_instance *pi;
+
+	if (!base)
 		return -EINVAL;
 
+	pi = devm_kmalloc(dev, sizeof(*pi), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->base = base;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+
+	/* initlize capability by RDPT */
+	pi->capability &= ioread8(base);
+	pi->events = pi->capability;
+
 	spin_lock(&pvpanic_lock);
 	list_add(&pi->list, &pvpanic_list);
 	spin_unlock(&pvpanic_lock);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
index 493545951754..46ffb10438ad 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,13 +8,7 @@
 #ifndef PVPANIC_H_
 #define PVPANIC_H_
 
-struct pvpanic_instance {
-	void __iomem *base;
-	unsigned int capability;
-	unsigned int events;
-	struct list_head list;
-};
-
-int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi);
+int devm_pvpanic_probe(struct device *dev, void __iomem *base);
+extern const struct attribute_group *pvpanic_dev_groups[];
 
 #endif /* PVPANIC_H_ */

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231011-pvpanic-cleanup-75c112bd6034

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

