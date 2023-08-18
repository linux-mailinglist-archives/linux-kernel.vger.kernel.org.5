Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69418781464
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380047AbjHRUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380000AbjHRUlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CED3C3C;
        Fri, 18 Aug 2023 13:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6DB6117F;
        Fri, 18 Aug 2023 20:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3533C433C8;
        Fri, 18 Aug 2023 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391280;
        bh=kE1POYgRiSrKokoluBapEwaMEsuHZqNe70xF6nyjMO4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=E2jWWT3WpSUv5OFgd6XzG0CUnhxvucd4DOyME0YWiEPkCn4qTx84hV9dmTmDt3snB
         Fa93Eh1JiPsWCXdeWBgIq7eId2TSk2vz0YwEjlBXJri1nmnULaQlIB6B697qPdpAWt
         9H6xBxj9MvBZQtccewIseClq7rSkiH8dDh2y/1fDZYBkJ1HXUUfuRYldjFq+Qfxpg6
         Tuba2UQXRk0YH9Hq5dKOv+ieMXByE2SqfqJGRellKEJyiC1pX4yjjcDPNc5zIY241H
         FiHnTuV7Fwt4frPT+DBeNSrM2CXgJPNTBFfXWAmrXAVIz91FsoYXu1Kdehz616qkeK
         zasWVNxZqsifQ==
Received: (nullmailer pid 545148 invoked by uid 1000);
        Fri, 18 Aug 2023 20:41:06 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 15:41:01 -0500
Subject: [PATCH v3 6/6] of: Refactor node and property manipulation
 function locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org>
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
v3:
 - Rebase due to changes in prior patch
v2:
 - Re-arrange exit handling
---
 drivers/of/base.c    | 65 ++++++++++++++++++++++++++--------------------------
 drivers/of/dynamic.c | 51 +++++++++++++----------------------------
 2 files changed, 49 insertions(+), 67 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3f9ddd18ff4b..4b24bed894ad 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1551,21 +1551,32 @@ static struct property *__of_remove_property_from_list(struct property **list, s
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
+	int rc = 0;
+	unsigned long flags;
 	struct property **next;
 
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
 	__of_remove_property_from_list(&np->deadprops, prop);
 
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
 
@@ -1576,37 +1587,36 @@ int __of_add_property(struct device_node *np, struct property *prop)
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
 
 int __of_remove_property(struct device_node *np, struct property *prop)
 {
+	unsigned long flags;
+	int rc = -ENODEV;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
 	if (__of_remove_property_from_list(&np->properties, prop)) {
 		/* Found the property, add it to deadprops list */
 		prop->next = np->deadprops;
 		np->deadprops = prop;
-		return 0;
+		rc = 0;
 	}
 
-	return -ENODEV;
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	if (rc)
+		return rc;
+
+	__of_remove_property_sysfs(np, prop);
+	return 0;
 }
 
 /**
@@ -1621,21 +1631,13 @@ int __of_remove_property(struct device_node *np, struct property *prop)
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
@@ -1649,6 +1651,9 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		struct property **oldpropp)
 {
 	struct property **next, *oldprop;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	__of_remove_property_from_list(&np->deadprops, newprop);
 
@@ -1670,6 +1675,10 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 		*next = newprop;
 	}
 
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_update_property_sysfs(np, newprop, oldprop);
+
 	return 0;
 }
 
@@ -1685,21 +1694,13 @@ int __of_update_property(struct device_node *np, struct property *newprop,
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
index d3ad970ad7b8..9252641de507 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -198,6 +198,9 @@ static void __of_attach_node(struct device_node *np)
 {
 	const __be32 *phandle;
 	int sz;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
 
 	if (!of_node_check_flag(np, OF_OVERLAY)) {
 		np->name = __of_get_property(np, "name", NULL);
@@ -220,6 +223,10 @@ static void __of_attach_node(struct device_node *np)
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
 	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_attach_node_sysfs(np);
 }
 
 /**
@@ -229,17 +236,12 @@ static void __of_attach_node(struct device_node *np)
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
@@ -250,13 +252,15 @@ int of_attach_node(struct device_node *np)
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
@@ -273,6 +277,10 @@ void __of_detach_node(struct device_node *np)
 
 	/* race with of_find_node_by_phandle() prevented by devtree_lock */
 	__of_phandle_cache_inv_entry(np->phandle);
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	__of_detach_node_sysfs(np);
 }
 
 /**
@@ -282,17 +290,12 @@ void __of_detach_node(struct device_node *np)
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
@@ -564,12 +567,10 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	of_changeset_action_debug("applying: ", ce->action, ce->np, ce->prop);
 
-	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		__of_attach_node(ce->np);
@@ -590,32 +591,12 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	default:
 		ret = -EINVAL;
 	}
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
 	if (ret) {
 		of_changeset_action_err("apply failed: ", ce->action, ce->np, ce->prop);
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

