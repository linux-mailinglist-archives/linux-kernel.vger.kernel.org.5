Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809C770C10
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjHDWma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjHDWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21284EE7;
        Fri,  4 Aug 2023 15:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F058562158;
        Fri,  4 Aug 2023 22:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B8BC433C8;
        Fri,  4 Aug 2023 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188938;
        bh=XV5U4RAiGWQ2P3Dd0SD54QZTwqv55+/YNgiA55fi47g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XC1NGwgD+z/NQJIqzJUtEqL7Zi3OudVrKz6SXwQFsiCaNejoa1Yfbceu3Lhk+Q2Go
         +1Mvk8Nh/+stAt3bPKN5RbO6quXWO0KNJywyU40q+EoxMdCoE77re7UbNSC0NAS3ng
         Fwa85cKOq4khyo3u1Hcpao8BkOSMv8sBdnKf7eqNZkUcUR78qD55mvdcoyx9bfdTRf
         RL0e2AmtTrMO1SLco8+qs9B5NXsjLaU95E8PV3LIh4oCuwprTnIr06XcQhv+Nc0nig
         VgX6ramvoA+N55xfBhYX49vYMtp0ARQirG0ntYR0ijhD+sLkK/eqGHS/9vP/5vIO3c
         lzFtvEAq2hgsQ==
Received: (nullmailer pid 2346985 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Aug 2023 16:41:56 -0600
Subject: [PATCH v2 6/6] of: Refactor node and property manipulation
 function locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v2-6-c2b701579dee@kernel.org>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of __of_{add,remove,update}_property() and
__of_{attach,detach}_node() wrap the call with the devtree_lock
spinlock. Let's move the spinlock into the functions. This allows moving
the sysfs update functions into those functions as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Re-arrange exit handling
---
 drivers/of/base.c    | 68 +++++++++++++++++++++++++++-------------------------
 drivers/of/dynamic.c | 51 +++++++++++++--------------------------
 2 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index c63a4cde281e..3ec134429f11 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1552,21 +1552,32 @@ static void __of_remove_dead_property(struct device_node *np, struct property *p
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
+	int rc = 0;
+	unsigned long flags;
 	struct property **next;
 
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
 	__of_remove_dead_property(np, prop);
 
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
-		if (strcmp(prop->name, (*next)->name) == 0)
+		if (strcmp(prop->name, (*next)->name) == 0) {
 			/* duplicate ! don't insert it */
-			return -EEXIST;
-
+			rc = -EEXIST;
+			goto out_unlock;
+		}
 		next = &(*next)->next;
 	}
 	*next = prop;
 
+out_unlock:
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	if (rc)
+		return rc;
+
+	__of_add_property_sysfs(np, prop);
 	return 0;
 }
 
@@ -1577,23 +1588,12 @@ int __of_add_property(struct device_node *np, struct property *prop)
  */
 int of_add_property(struct device_node *np, struct property *prop)
 {
-	unsigned long flags;
 	int rc;
 
 	mutex_lock(&of_mutex);
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	rc = __of_add_property(np, prop);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!rc)
-		__of_add_property_sysfs(np, prop);
-
 	mutex_unlock(&of_mutex);
 
-	if (!rc)
-		of_property_notify(OF_RECONFIG_ADD_PROPERTY, np, prop, NULL);
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_add_property);
@@ -1601,19 +1601,30 @@ EXPORT_SYMBOL_GPL(of_add_property);
 int __of_remove_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
+	unsigned long flags;
+	int rc = 0;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	for (next = &np->properties; *next; next = &(*next)->next) {
 		if (*next == prop)
 			break;
 	}
-	if (*next == NULL)
-		return -ENODEV;
-
+	if (*next == NULL) {
+		rc = -ENODEV;
+		goto out_unlock;
+	}
 	/* found the node */
 	*next = prop->next;
 	prop->next = np->deadprops;
 	np->deadprops = prop;
 
+out_unlock:
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	if (rc)
+		return rc;
+
+	__of_remove_property_sysfs(np, prop);
 	return 0;
 }
 
@@ -1629,21 +1640,13 @@ int __of_remove_property(struct device_node *np, struct property *prop)
  */
 int of_remove_property(struct device_node *np, struct property *prop)
 {
-	unsigned long flags;
 	int rc;
 
 	if (!prop)
 		return -ENODEV;
 
 	mutex_lock(&of_mutex);
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	rc = __of_remove_property(np, prop);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!rc)
-		__of_remove_property_sysfs(np, prop);
-
 	mutex_unlock(&of_mutex);
 
 	if (!rc)
@@ -1657,6 +1660,9 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		struct property **oldpropp)
 {
 	struct property **next, *oldprop;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	__of_remove_dead_property(np, newprop);
 
@@ -1678,6 +1684,10 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		*next = newprop;
 	}
 
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_update_property_sysfs(np, newprop, oldprop);
+
 	return 0;
 }
 
@@ -1693,21 +1703,13 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 int of_update_property(struct device_node *np, struct property *newprop)
 {
 	struct property *oldprop;
-	unsigned long flags;
 	int rc;
 
 	if (!newprop->name)
 		return -EINVAL;
 
 	mutex_lock(&of_mutex);
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	rc = __of_update_property(np, newprop, &oldprop);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	if (!rc)
-		__of_update_property_sysfs(np, newprop, oldprop);
-
 	mutex_unlock(&of_mutex);
 
 	if (!rc)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 769869e8b847..715365fbb8ea 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -197,6 +197,9 @@ static void __of_attach_node(struct device_node *np)
 {
 	const __be32 *phandle;
 	int sz;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	if (!of_node_check_flag(np, OF_OVERLAY)) {
 		np->name = __of_get_property(np, "name", NULL);
@@ -219,6 +222,10 @@ static void __of_attach_node(struct device_node *np)
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
 	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_attach_node_sysfs(np);
 }
 
 /**
@@ -228,17 +235,12 @@ static void __of_attach_node(struct device_node *np)
 int of_attach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
-	unsigned long flags;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
 
 	mutex_lock(&of_mutex);
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	__of_attach_node(np);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	__of_attach_node_sysfs(np);
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_ATTACH_NODE, &rd);
@@ -249,13 +251,15 @@ int of_attach_node(struct device_node *np)
 void __of_detach_node(struct device_node *np)
 {
 	struct device_node *parent;
+	unsigned long flags;
 
-	if (WARN_ON(of_node_check_flag(np, OF_DETACHED)))
-		return;
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	parent = np->parent;
-	if (WARN_ON(!parent))
+	if (WARN_ON(of_node_check_flag(np, OF_DETACHED) || !parent)) {
+		raw_spin_unlock_irqrestore(&devtree_lock, flags);
 		return;
+	}
 
 	if (parent->child == np)
 		parent->child = np->sibling;
@@ -272,6 +276,10 @@ void __of_detach_node(struct device_node *np)
 
 	/* race with of_find_node_by_phandle() prevented by devtree_lock */
 	__of_phandle_cache_inv_entry(np->phandle);
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_detach_node_sysfs(np);
 }
 
 /**
@@ -281,17 +289,12 @@ void __of_detach_node(struct device_node *np)
 int of_detach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
-	unsigned long flags;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
 
 	mutex_lock(&of_mutex);
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	__of_detach_node(np);
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	__of_detach_node_sysfs(np);
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
@@ -563,12 +566,10 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	of_changeset_action_debug("applying: cset<%p> ", ce->action, ce->np, ce->prop, ce);
 
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		__of_attach_node(ce->np);
@@ -589,32 +590,12 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	default:
 		ret = -EINVAL;
 	}
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
 	if (ret) {
 		of_changeset_action_err("apply failed: cset<%p> ", ce->action, ce->np, ce->prop, ce);
 		return ret;
 	}
 
-	switch (ce->action) {
-	case OF_RECONFIG_ATTACH_NODE:
-		__of_attach_node_sysfs(ce->np);
-		break;
-	case OF_RECONFIG_DETACH_NODE:
-		__of_detach_node_sysfs(ce->np);
-		break;
-	case OF_RECONFIG_ADD_PROPERTY:
-		/* ignore duplicate names */
-		__of_add_property_sysfs(ce->np, ce->prop);
-		break;
-	case OF_RECONFIG_REMOVE_PROPERTY:
-		__of_remove_property_sysfs(ce->np, ce->prop);
-		break;
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		__of_update_property_sysfs(ce->np, ce->prop, ce->old_prop);
-		break;
-	}
-
 	return 0;
 }
 

-- 
2.40.1

