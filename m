Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C36757922
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGRKRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRKRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:17:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61060132;
        Tue, 18 Jul 2023 03:17:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974EA2F4;
        Tue, 18 Jul 2023 03:18:27 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706C83F67D;
        Tue, 18 Jul 2023 03:17:42 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] powercap: arm_scmi: Remove recursion while parsing zones
Date:   Tue, 18 Jul 2023 11:17:26 +0100
Message-ID: <20230718101726.1864761-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powercap zones can be defined as arranged in a hierarchy of trees and when
registering a zone with powercap_register_zone(), the kernel powercap
subsystem expects this to happen starting from the root zones down to the
leaves; on the other side, de-registration by powercap_deregister_zone()
must begin from the leaf zones.

Available SCMI powercap zones are retrieved dynamically from the platform
at probe time and, while any defined hierarchy between the zones is
described properly in the zones descriptor, the platform returns the
availables zones with no particular well-defined order: as a consequence,
the trees possibly composing the hierarchy of zones have to be somehow
walked properly to register the retrieved zones from the root.

Currently the ARM SCMI Powercap driver walks the zones using a recursive
algorithm; this approach, even though correct and tested can lead to kernel
stack overflow when processing a returned hierarchy of zones composed by
particularly high trees.

Avoid possible kernel stack overflow by substituting the recursive approach
with an iterative one supported by a dynamically allocated stack-like data
structure.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Fixes: b55eef5226b7 ("powercap: arm_scmi: Add SCMI Powercap based driver")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Was able to cause a kernel stack overflow on arm64 while processing a set
of 256 zones organized in a single list returned by SCMI platform in reversed
order from the last child zone up to the root: this causes 256 recursions and
hits the kernel stack overflow.

v1 --> v2
 - Rebased on v6.5-rc2
---
 drivers/powercap/arm_scmi_powercap.c | 159 ++++++++++++++++-----------
 1 file changed, 92 insertions(+), 67 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 5231f6d52ae3..a081f177e702 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/powercap.h>
 #include <linux/scmi_protocol.h>
+#include <linux/slab.h>
 
 #define to_scmi_powercap_zone(z)		\
 	container_of(z, struct scmi_powercap_zone, zone)
@@ -19,6 +20,8 @@
 static const struct scmi_powercap_proto_ops *powercap_ops;
 
 struct scmi_powercap_zone {
+	bool registered;
+	bool invalid;
 	unsigned int height;
 	struct device *dev;
 	struct scmi_protocol_handle *ph;
@@ -32,6 +35,7 @@ struct scmi_powercap_root {
 	unsigned int num_zones;
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
+	struct list_head scmi_zones;
 };
 
 static struct powercap_control_type *scmi_top_pcntrl;
@@ -271,12 +275,6 @@ static void scmi_powercap_unregister_all_zones(struct scmi_powercap_root *pr)
 	}
 }
 
-static inline bool
-scmi_powercap_is_zone_registered(struct scmi_powercap_zone *spz)
-{
-	return !list_empty(&spz->node);
-}
-
 static inline unsigned int
 scmi_powercap_get_zone_height(struct scmi_powercap_zone *spz)
 {
@@ -295,11 +293,46 @@ scmi_powercap_get_parent_zone(struct scmi_powercap_zone *spz)
 	return &spz->spzones[spz->info->parent_id];
 }
 
+static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
+				       struct scmi_powercap_zone *spz,
+				       struct scmi_powercap_zone *parent)
+{
+	int ret = 0;
+	struct powercap_zone *z;
+
+	if (spz->invalid) {
+		list_del(&spz->node);
+		return -EINVAL;
+	}
+
+	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
+				   parent ? &parent->zone : NULL,
+				   &zone_ops, 1, &constraint_ops);
+	if (!IS_ERR(z)) {
+		spz->height = scmi_powercap_get_zone_height(spz);
+		spz->registered = true;
+		list_move(&spz->node, &pr->registered_zones[spz->height]);
+		dev_dbg(spz->dev, "Registered node %s - parent %s - height:%d\n",
+			spz->info->name, parent ? parent->info->name : "ROOT",
+			spz->height);
+	} else {
+		list_del(&spz->node);
+		ret = PTR_ERR(z);
+		dev_err(spz->dev,
+			"Error registering node:%s - parent:%s - h:%d - ret:%d\n",
+			spz->info->name,
+			parent ? parent->info->name : "ROOT",
+			spz->height, ret);
+	}
+
+	return ret;
+}
+
 /**
- * scmi_powercap_register_zone  - Register an SCMI powercap zone recursively
+ * scmi_zones_register- Register SCMI powercap zones starting from parent zones
  *
+ * @dev: A reference to the SCMI device
  * @pr: A reference to the root powercap zones descriptors
- * @spz: A reference to the SCMI powercap zone to register
  *
  * When registering SCMI powercap zones with the powercap framework we should
  * take care to always register zones starting from the root ones and to
@@ -309,10 +342,10 @@ scmi_powercap_get_parent_zone(struct scmi_powercap_zone *spz)
  * zones provided by the SCMI platform firmware is built to comply with such
  * requirement.
  *
- * This function, given an SCMI powercap zone to register, takes care to walk
- * the SCMI powercap zones tree up to the root looking recursively for
- * unregistered parent zones before registering the provided zone; at the same
- * time each registered zone height in such a tree is accounted for and each
+ * This function, given the set of SCMI powercap zones to register, takes care
+ * to walk the SCMI powercap zones trees up to the root registering any
+ * unregistered parent zone before registering the child zones; at the same
+ * time each registered-zone height in such a tree is accounted for and each
  * zone, once registered, is stored in the @registered_zones array that is
  * indexed by zone height: this way will be trivial, at unregister time, to walk
  * the @registered_zones array backward and unregister all the zones starting
@@ -330,57 +363,55 @@ scmi_powercap_get_parent_zone(struct scmi_powercap_zone *spz)
  *
  * Return: 0 on Success
  */
-static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
-				       struct scmi_powercap_zone *spz)
+static int scmi_zones_register(struct device *dev,
+			       struct scmi_powercap_root *pr)
 {
 	int ret = 0;
-	struct scmi_powercap_zone *parent;
-
-	if (!spz->info)
-		return ret;
+	unsigned int sp = 0, reg_zones = 0;
+	struct scmi_powercap_zone *spz, **zones_stack;
 
-	parent = scmi_powercap_get_parent_zone(spz);
-	if (parent && !scmi_powercap_is_zone_registered(parent)) {
-		/*
-		 * Bail out if a parent domain was marked as unsupported:
-		 * only domains participating as leaves can be skipped.
-		 */
-		if (!parent->info)
-			return -ENODEV;
+	zones_stack = kcalloc(pr->num_zones, sizeof(spz), GFP_KERNEL);
+	if (!zones_stack)
+		return -ENOMEM;
 
-		ret = scmi_powercap_register_zone(pr, parent);
-		if (ret)
-			return ret;
-	}
+	spz = list_first_entry_or_null(&pr->scmi_zones,
+				       struct scmi_powercap_zone, node);
+	while (spz) {
+		struct scmi_powercap_zone *parent;
 
-	if (!scmi_powercap_is_zone_registered(spz)) {
-		struct powercap_zone *z;
-
-		z = powercap_register_zone(&spz->zone,
-					   scmi_top_pcntrl,
-					   spz->info->name,
-					   parent ? &parent->zone : NULL,
-					   &zone_ops, 1, &constraint_ops);
-		if (!IS_ERR(z)) {
-			spz->height = scmi_powercap_get_zone_height(spz);
-			list_add(&spz->node,
-				 &pr->registered_zones[spz->height]);
-			dev_dbg(spz->dev,
-				"Registered node %s - parent %s - height:%d\n",
-				spz->info->name,
-				parent ? parent->info->name : "ROOT",
-				spz->height);
-			ret = 0;
+		parent = scmi_powercap_get_parent_zone(spz);
+		if (parent && !parent->registered) {
+			zones_stack[sp++] = spz;
+			spz = parent;
 		} else {
-			ret = PTR_ERR(z);
-			dev_err(spz->dev,
-				"Error registering node:%s - parent:%s - h:%d - ret:%d\n",
-				 spz->info->name,
-				 parent ? parent->info->name : "ROOT",
-				 spz->height, ret);
+			ret = scmi_powercap_register_zone(pr, spz, parent);
+			if (!ret) {
+				reg_zones++;
+			} else if (sp) {
+				/* Failed to register a non-leaf zone.
+				 * Bail-out.
+				 */
+				dev_err(dev,
+					"Failed to register non-leaf zone - ret:%d\n",
+					ret);
+				scmi_powercap_unregister_all_zones(pr);
+				reg_zones = 0;
+				goto out;
+			}
+			/* Pick next zone to process */
+			if (sp)
+				spz = zones_stack[--sp];
+			else
+				spz = list_first_entry_or_null(&pr->scmi_zones,
+							       struct scmi_powercap_zone,
+							       node);
 		}
 	}
 
+out:
+	kfree(zones_stack);
+	dev_info(dev, "Registered %d SCMI Powercap domains !\n", reg_zones);
+
 	return ret;
 }
 
@@ -424,6 +455,8 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (!pr->registered_zones)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&pr->scmi_zones);
+
 	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
 		/*
 		 * Powercap domains are validate by the protocol layer, i.e.
@@ -438,6 +471,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		INIT_LIST_HEAD(&spz->node);
 		INIT_LIST_HEAD(&pr->registered_zones[i]);
 
+		list_add_tail(&spz->node, &pr->scmi_zones);
 		/*
 		 * Forcibly skip powercap domains using an abstract scale.
 		 * Note that only leaves domains can be skipped, so this could
@@ -448,7 +482,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 			dev_warn(dev,
 				 "Abstract power scale not supported. Skip %s.\n",
 				 spz->info->name);
-			spz->info = NULL;
+			spz->invalid = true;
 			continue;
 		}
 	}
@@ -457,21 +491,12 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	 * Scan array of retrieved SCMI powercap domains and register them
 	 * recursively starting from the root domains.
 	 */
-	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
-		ret = scmi_powercap_register_zone(pr, spz);
-		if (ret) {
-			dev_err(dev,
-				"Failed to register powercap zone %s - ret:%d\n",
-				spz->info->name, ret);
-			scmi_powercap_unregister_all_zones(pr);
-			return ret;
-		}
-	}
+	ret = scmi_zones_register(dev, pr);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, pr);
 
-	dev_info(dev, "Registered %d SCMI Powercap domains !\n", pr->num_zones);
-
 	return ret;
 }
 
-- 
2.41.0

