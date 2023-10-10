Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2377C437E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJJWKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJJWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:10:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC4A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696975811;
        bh=a2UTUxNJk7lOIqWe2g18DMZiUG7AF+fyFN4/A/dTfqg=;
        h=From:Date:Subject:To:Cc:From;
        b=B7AKAWOLk2RDACGW4BpamZgdt5F7z+tqvUEfepSEJNMinaW3qJiBraF8hIhGHtsSd
         F1qvDPhuTdJDVKef9OcFSu5CvfrUrwrelvhi57bKhMAAKWL7Pw3GW1zjHtElG4FxgI
         LaVRdPKwOXQpn5oUe9bAmbp/G2Kx9yqc8j6/q5Ew=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 11 Oct 2023 00:10:08 +0200
Subject: [PATCH] misc/pvpanic: deduplicate comomn code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231011-pvpanic-cleanup-v1-1-5c93b05ec331@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAL/LJWUC/x3MTQqAIBBA4avIrBMc+4OuEi3MphoIEyUJxLsnL
 b/FexkiBaYIk8gQKHHk21VgI8Cexh0keasGrXSLClH65I1jK+1Fxj1ejr1F1Os2qLaDWvlAO7/
 /cV5K+QD6EsFWYQAAAA==
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696975811; l=8796;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=a2UTUxNJk7lOIqWe2g18DMZiUG7AF+fyFN4/A/dTfqg=;
 b=gc50K08Xs6uS2583fX+5BLor5kzn3nY9gzpQ/zRx4IrCAGY+Q0AtgTM+08iccHp0eqpBvo6Pd
 aQXTAC3Qo/8Bu9Sjn/+oCqcH7j+NCVtTifFLmewV6PAPwP8IiPzvI5T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/misc/pvpanic/pvpanic-mmio.c | 57 +----------------------------
 drivers/misc/pvpanic/pvpanic-pci.c  | 59 +-----------------------------
 drivers/misc/pvpanic/pvpanic.c      | 72 +++++++++++++++++++++++++++++++++++--
 drivers/misc/pvpanic/pvpanic.h      |  9 +----
 4 files changed, 73 insertions(+), 124 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index eb97167c03fb..833020bc6a50 100644
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
@@ -123,7 +69,6 @@ static struct platform_driver pvpanic_mmio_driver = {
 		.name = "pvpanic-mmio",
 		.of_match_table = pvpanic_mmio_match,
 		.acpi_match_table = pvpanic_device_ids,
-		.dev_groups = pvpanic_mmio_dev_groups,
 	},
 	.probe = pvpanic_mmio_probe,
 };
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 07eddb5ea30f..fe2a2f33d311 100644
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
@@ -102,8 +48,5 @@ static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
-	.driver = {
-		.dev_groups = pvpanic_pci_dev_groups,
-	},
 };
 module_pci_driver(pvpanic_pci_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 049a12006348..001b20528d0b 100644
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
 
@@ -81,11 +89,71 @@ static void pvpanic_remove(void *param)
 	spin_unlock(&pvpanic_lock);
 }
 
-int devm_pvpanic_probe(struct device *dev, struct pvpanic_instance *pi)
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (!pi || !pi->base)
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
 		return -EINVAL;
 
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
+ATTRIBUTE_GROUPS(pvpanic_dev);
+
+int devm_pvpanic_probe(struct device *dev, void __iomem *base)
+{
+	struct pvpanic_instance *pi;
+	int ret;
+
+	if (!base)
+		return -EINVAL;
+
+	ret = devm_device_add_groups(dev, pvpanic_dev_groups);
+	if (ret)
+		return ret;
+
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
index 493545951754..748e7bce048b 100644
--- a/drivers/misc/pvpanic/pvpanic.h
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -8,13 +8,6 @@
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
 
 #endif /* PVPANIC_H_ */

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231011-pvpanic-cleanup-75c112bd6034

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

