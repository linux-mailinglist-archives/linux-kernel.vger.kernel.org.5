Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE07EC63F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjKOOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:49:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A68E;
        Wed, 15 Nov 2023 06:49:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06AEA66020EE;
        Wed, 15 Nov 2023 14:49:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700059741;
        bh=qGGXsGoucU2E2JHTW5vyO3tG29TOu7dArGxQ01yOOAw=;
        h=From:To:Cc:Subject:Date:From;
        b=g1YN6ixT+qcit0USKdVVlZGcEszUJbamE1pqJJPRTZn5LcNU18XwmIZAGRn/vCii3
         2h0nFgqTlUNYszBGDvLDgPOWyEZdrGKGJL/MYGMBruT5o0HGvtj5cyRzfg0T9ZNMka
         PdjS7AgfuAVqKdB1kKVQyLFZQ64cRb4k2bboeTXkeJMMtNIwFQkSjshk8pG1KemEza
         H6PE6ByMrzgH2qleyWsh2pZ4iws8v9dFQGTTKwRCZZ+rIX+8K6EVk+wXWyHqiRLvDN
         O2aBD3NTQHP3XUYgYrXVSvwk0h010DaTuqCpCZJugAdtD+sRLFYsMMaHDW2nHMK/3Z
         tDmk7xG6FnzHQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] thermal: Add support for device tree thermal zones consumers
Date:   Wed, 15 Nov 2023 15:48:57 +0100
Message-ID: <20231115144857.424005-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to support retrieving thermal zones from device tree nodes:
this will allow a device tree consumer to specify phandles to specific
thermal zone(s), including support for specifying thermal-zone-names.
This is useful, for example, for smart voltage scaling drivers that
need to adjust CPU/GPU/other voltages based on temperature, and for
battery charging drivers that need to scale current based on various
aggregated temperature sensor readings which are board-dependant.

Example:
smart-scaling-driver@10000000 {
	[...]

	thermal-zones = <&cluster_big_tz>, <&gpu_tz>, <&vpu_tz>;
	thermal-zone-names = "cpu", "gpu", "vpu";

	[...]
}

battery-charger@20000000 {
	[...]

	thermal-zones = <&battery_temp>, <&device_skin_temp>;
	thermal-zone-names = "batt-ext-sensor", "skin";

	[...]
}

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
 - Added missing static inline for !CONFIG_OF fallback functions

Background story: while I was cleaning up the MediaTek Smart Voltage Scaling
(SVS) driver, I've found out that there's a lot of commonization to be done.
After a rewrite of "this and that" in that driver, I came across a barrier
that didn't allow me to remove another ~100 lines of code, and that was also
anyway breaking the driver, because the thermal zone names are different
from what was originally intended.

I've been looking for thermal zone handle retrieval around the kernel and
found that there currently are at least four other drivers that could make
use this as a cleanup: charger-manager, which is retrieving a thermal zone
to look for with a "cm-thermal-zone" string property, gpu/drm/tiny/repaper.c
that does the same by checking a "pervasive,thermal-zone" string property,
and ab8500_temp and sdhci-omap which are simply hardcoding a "cpu_thermal"
and "battery-thermal" thermal zone names respectively.

There are a number of other devices (mostly embedded, mostly smartphones)
that don't have an upstream driver and that could make use of this as well.

Cheers!


 drivers/thermal/thermal_of.c | 91 ++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h      | 15 ++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..d8ead456993e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -538,6 +538,97 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	return ERR_PTR(ret);
 }
 
+/**
+ * __thermal_of_get_zone_by_index() - Get thermal zone handle from the DT
+ *				      thermal-zones index
+ * @dev:   Pointer to the consumer device
+ * @index: Index of thermal-zones
+ *
+ * This function will search for a thermal zone in the thermal-zones phandle
+ * array corresponding to the specified index, then will search for its name
+ * into the registered thermal zones through thermal_zone_get_zone_by_name()
+ *
+ * Please note that this function is for internal use only and expects that
+ * all of the sanity checks are performed by its caller.
+ *
+ * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
+ * when the API is disabled or the "thermal-zones" DT property is missing.
+ */
+static struct thermal_zone_device
+*__thermal_of_get_zone_by_index(struct device *dev, int index)
+{
+	struct thermal_zone_device *tzd;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "thermal-zones", index);
+	if (!np)
+		return NULL;
+
+	tzd = thermal_zone_get_zone_by_name(np->name);
+	of_node_put(np);
+
+	return tzd;
+}
+
+/**
+ * thermal_of_get_zone_by_index() - Get thermal zone handle from a DT node
+ *				    based on index
+ * @dev:   Pointer to the consumer device
+ * @index: Index of thermal-zones
+ *
+ * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
+ * when the API is disabled or the "thermal-zones" DT property is missing.
+ */
+struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
+{
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	if (!of_property_present(dev->of_node, "thermal-zones"))
+		return NULL;
+
+	return __thermal_of_get_zone_by_index(dev, index);
+}
+
+/**
+ * thermal_of_get_zone() - Get thermal zone handle from a DT node based
+ *			   on name, or the first handle in list
+ * @dev:   Pointer to the consumer device
+ * @name:  Name as found in thermal-zone-names or NULL
+ *
+ * This function will search for a thermal zone in the thermal-zones phandle
+ * array corresponding to the index of that in the thermal-zone-names array.
+ * If the name is not specified (NULL), it will return the first thermal zone
+ * in the thermal-zones phandle array.
+ *
+ * Return: thermal_zone_device pointer on success, ERR_PTR() on error or NULL
+ * when the API is disabled or the "thermal-zones" DT property is missing.
+ */
+struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
+{
+	int index;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	if (!of_property_present(dev->of_node, "thermal-zones")) {
+		pr_err("thermal zones property not present\n");
+		return NULL;
+	}
+
+	if (name) {
+		index = of_property_match_string(dev->of_node, "thermal-zone-names", name);
+		if (index < 0) {
+			pr_err("thermal zone names property not present\n");
+			return ERR_PTR(index);
+		}
+	} else {
+		index = 0;
+	}
+
+	return __thermal_of_get_zone_by_index(dev, index);
+}
+
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
 {
 	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index cee814d5d1ac..0fceeb7ed08a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -261,6 +261,9 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
+struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index);
+struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name);
+
 #else
 
 static inline
@@ -274,6 +277,18 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
 }
+
+static inline
+struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline
+struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif
 
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-- 
2.42.0

