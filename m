Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ABB7FDD44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjK2Qhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjK2Qhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:37:35 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F4D5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:37:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89061C0003;
        Wed, 29 Nov 2023 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701275860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etuea1hYns3mh9gfNWVfF9L9O5bOXs1ej6kKA06ZjoU=;
        b=JeAPBSJOH3r6FB/6/MlthKOFO5psrg4lKC5DX3X3ek/xb8vIfqN1h4bgde7jcXSZDbSca2
        CTYibRIos6A+lmEYVdER6vKP+EutUMLUo90WWakj3bgGelnfg6ERpZBJCVhQk9QSVt47MV
        kmHgX9zvB1n3T0kN88a5DMYSoOfrVwbW73akrDWAEhDecyaS87aQTkVkxqftqhqJGlFXP4
        mPYRWJbjm3YJeJ/CvixSsgNEGhH9+CZsySaZxPR5FdyPYL/WIOQgxC7PWnGUYRpeZmynZX
        +3TLE8VCsiDVmL/eE/WyAzb7jvESDArX+PBiMyYBG/CHA+tam5AiRGpmo3+s+A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v14 1/8] of: device: Export of_device_make_bus_id()
Date:   Wed, 29 Nov 2023 17:37:30 +0100
Message-Id: <20231129163737.698317-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is really handy to create unique device names based on their
device tree path, we may need it outside of the OF core (in the NVMEM
subsystem) so let's export it. As this helper has nothing patform
specific, let's move it to of/device.c instead of of/platform.c so we
can add its prototype to of_device.h.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c       | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c     | 40 --------------------------------------
 include/linux/of_device.h |  6 ++++++
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1ca42ad9dd15..6e9572c4af83 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -304,3 +304,44 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+/**
+ * of_device_make_bus_id - Use the device node data to assign a unique name
+ * @dev: pointer to device structure that is linked to a device tree node
+ *
+ * This routine will first try using the translated bus address to
+ * derive a unique name. If it cannot, then it will prepend names from
+ * parent nodes until a unique name can be derived.
+ */
+void of_device_make_bus_id(struct device *dev)
+{
+	struct device_node *node = dev->of_node;
+	const __be32 *reg;
+	u64 addr;
+	u32 mask;
+
+	/* Construct the name, using parent nodes if necessary to ensure uniqueness */
+	while (node->parent) {
+		/*
+		 * If the address can be translated, then that is as much
+		 * uniqueness as we need. Make it the first component and return
+		 */
+		reg = of_get_property(node, "reg", NULL);
+		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
+			if (!of_property_read_u32(node, "mask", &mask))
+				dev_set_name(dev, dev_name(dev) ? "%llx.%x.%pOFn:%s" : "%llx.%x.%pOFn",
+					     addr, ffs(mask) - 1, node, dev_name(dev));
+
+			else
+				dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
+					     addr, node, dev_name(dev));
+			return;
+		}
+
+		/* format arguments only used if dev_name() resolves to NULL */
+		dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
+			     kbasename(node->full_name), dev_name(dev));
+		node = node->parent;
+	}
+}
+EXPORT_SYMBOL_GPL(of_device_make_bus_id);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..c39e49a1eba0 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -97,46 +97,6 @@ static const struct of_device_id of_skipped_node_table[] = {
  * mechanism for creating devices from device tree nodes.
  */
 
-/**
- * of_device_make_bus_id - Use the device node data to assign a unique name
- * @dev: pointer to device structure that is linked to a device tree node
- *
- * This routine will first try using the translated bus address to
- * derive a unique name. If it cannot, then it will prepend names from
- * parent nodes until a unique name can be derived.
- */
-static void of_device_make_bus_id(struct device *dev)
-{
-	struct device_node *node = dev->of_node;
-	const __be32 *reg;
-	u64 addr;
-	u32 mask;
-
-	/* Construct the name, using parent nodes if necessary to ensure uniqueness */
-	while (node->parent) {
-		/*
-		 * If the address can be translated, then that is as much
-		 * uniqueness as we need. Make it the first component and return
-		 */
-		reg = of_get_property(node, "reg", NULL);
-		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
-			if (!of_property_read_u32(node, "mask", &mask))
-				dev_set_name(dev, dev_name(dev) ? "%llx.%x.%pOFn:%s" : "%llx.%x.%pOFn",
-					     addr, ffs(mask) - 1, node, dev_name(dev));
-
-			else
-				dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
-					     addr, node, dev_name(dev));
-			return;
-		}
-
-		/* format arguments only used if dev_name() resolves to NULL */
-		dev_set_name(dev, dev_name(dev) ? "%s:%s" : "%s",
-			     kbasename(node->full_name), dev_name(dev));
-		node = node->parent;
-	}
-}
-
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 2c7a3d4bc775..a72661e47faa 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -40,6 +40,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return of_dma_configure_id(dev, np, force_dma, NULL);
 }
+
+void of_device_make_bus_id(struct device *dev);
+
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -82,6 +85,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return 0;
 }
+
+static inline void of_device_make_bus_id(struct device *dev) {}
+
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
2.34.1

