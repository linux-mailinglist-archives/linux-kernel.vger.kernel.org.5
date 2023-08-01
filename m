Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A876BFA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjHAVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHAVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B326A3;
        Tue,  1 Aug 2023 14:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A5C61735;
        Tue,  1 Aug 2023 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF998C433C9;
        Tue,  1 Aug 2023 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926925;
        bh=UWkbtTwArpfxA+PVVNq82HZpmdGnmNashPrlejXB09k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=X7bRXlm/M/np1MHpLVS4xJ8NWtnSZ1zJMJUGU6InEuIVydMCltMRWhqg40qL2vZ8x
         tIxthPtUvRMG5TcGyrcJIKIurni4ZTrTX1I4XftP/uDxf5P83kRQ4dKyTAtIcwiCX8
         TSpPi9V3rNAE7cjy9THYUUts0CAN+igAC8Vi5LasuaXVcEpbQAgSoMHPQQ/LwyYtJn
         HUJUVa7CbMjpRatKFh8vsV9pcuP0ZwqbnYCvHt2tpof25Hh2samO9RiEPLVfU74GA1
         9ixnza/pJAaJ5wk0tK1YG4qU008sUroHYkjoffXYCk+spnxnatcDHaGv9Su4gsUX9P
         k5gieFs26hIOA==
Received: (nullmailer pid 2469345 invoked by uid 1000);
        Tue, 01 Aug 2023 21:55:14 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 01 Aug 2023 15:54:48 -0600
Subject: [PATCH 5/5] of: Refactor node and property manipulation function
 locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v1-5-b5203e3fc22f@kernel.org>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/of/base.c    | 69 ++++++++++++++++++++++++++--------------------------
 drivers/of/dynamic.c | 51 ++++++++++++--------------------------
 2 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 99c07f3cbf10..4ee050ace11e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1536,8 +1536,12 @@ EXPORT_SYMBOL(of_count_phandle_with_args);
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
+	int rc = 0;
+	unsigned long flags;
 	struct property **next;
 
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
 	/* If the property is in deadprops then it must be removed */
 	for (next = &np->deadprops; *next; next = &(*next)->next) {
 		if (*next == prop) {
@@ -1549,15 +1553,21 @@ int __of_add_property(struct device_node *np, struct property *prop)
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
-		if (strcmp(prop->name, (*next)->name) == 0)
+		if (strcmp(prop->name, (*next)->name) == 0) {
 			/* duplicate ! don't insert it */
-			return -EEXIST;
-
+			rc = -EEXIST;
+			goto out;
+		}
 		next = &(*next)->next;
 	}
 	*next = prop;
 
-	return 0;
+out:
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	if (!rc)
+		__of_add_property_sysfs(np, prop);
+
+	return rc;
 }
 
 /**
@@ -1567,23 +1577,12 @@ int __of_add_property(struct device_node *np, struct property *prop)
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
@@ -1591,20 +1590,29 @@ EXPORT_SYMBOL_GPL(of_add_property);
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
+		goto out;
+	}
 	/* found the node */
 	*next = prop->next;
 	prop->next = np->deadprops;
 	np->deadprops = prop;
 
-	return 0;
+out:
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	if (!rc)
+		__of_remove_property_sysfs(np, prop);
+	return rc;
 }
 
 /**
@@ -1619,21 +1627,13 @@ int __of_remove_property(struct device_node *np, struct property *prop)
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
@@ -1647,6 +1647,9 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		struct property **oldpropp)
 {
 	struct property **next, *oldprop;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	/* If the property is in deadprops then it must be removed */
 	for (next = &np->deadprops; *next; next = &(*next)->next) {
@@ -1675,6 +1678,10 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		*next = newprop;
 	}
 
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_update_property_sysfs(np, newprop, oldprop);
+
 	return 0;
 }
 
@@ -1690,21 +1697,13 @@ int __of_update_property(struct device_node *np, struct property *newprop,
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
index 4fd3699691b6..c59f581792f1 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -199,6 +199,9 @@ static void __of_attach_node(struct device_node *np)
 {
 	const __be32 *phandle;
 	int sz;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	if (!of_node_check_flag(np, OF_OVERLAY)) {
 		np->name = __of_get_property(np, "name", NULL);
@@ -221,6 +224,10 @@ static void __of_attach_node(struct device_node *np)
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
 	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_attach_node_sysfs(np);
 }
 
 /**
@@ -230,17 +237,12 @@ static void __of_attach_node(struct device_node *np)
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
@@ -251,13 +253,15 @@ int of_attach_node(struct device_node *np)
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
@@ -274,6 +278,10 @@ void __of_detach_node(struct device_node *np)
 
 	/* race with of_find_node_by_phandle() prevented by devtree_lock */
 	__of_phandle_cache_inv_entry(np->phandle);
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_detach_node_sysfs(np);
 }
 
 /**
@@ -283,17 +291,12 @@ void __of_detach_node(struct device_node *np)
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
@@ -565,13 +568,11 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	if (pr_debug("changeset: applying: cset<%p> ", ce))
 		of_changeset_action_print(ce->action, ce->np, ce->prop ? ce->prop->name : NULL);
 
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		__of_attach_node(ce->np);
@@ -592,7 +593,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	default:
 		ret = -EINVAL;
 	}
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
 	if (ret) {
 		pr_err("changeset: apply failed: cset<%p> ", ce);
@@ -600,25 +600,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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

