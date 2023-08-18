Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B83781465
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380040AbjHRUly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380018AbjHRUlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FC3C3D;
        Fri, 18 Aug 2023 13:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 360E76117F;
        Fri, 18 Aug 2023 20:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA842C433C8;
        Fri, 18 Aug 2023 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391278;
        bh=H9GV+tg3g3GPDELoA8+aiKstqj5atxl9FDzEGMxPjA0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=s+N6KeRcSBoxKu4UhD0zZ8apA+v9Xqj3O0vBd+lAeU5HsELHKG5jr3WyzCwUZNDZX
         rLmZMCF64bgF4qIZtScxGmHYyGULe8TfAC75cpoI36MYApyNoq6sZXAvUyaOQQYc/V
         XynpZuO9ZUR3wS9v3hmWbtyBFSOtbgG+MDSGXp/Ga8e/1Qx6NO6hmMWYMbUY7cI3+C
         EN+cjJL2MNH3ncSKvozQvFgADzY7lSwDoNvC9gYImVw45zSl1tMJchK8TX1a8qWEzv
         /fYPz2OxmN7icBFGNSDlFjhuE1GLA6ommUawBNo8soOkMXNlGuonM1GmzRJP74qrXk
         AAelAlr0uYVJQ==
Received: (nullmailer pid 545142 invoked by uid 1000);
        Fri, 18 Aug 2023 20:41:06 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 15:40:58 -0500
Subject: [PATCH v3 3/6] of: dynamic: Refactor changeset action printing to
 common helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v3-3-5f0410e007dd@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several places print the changeset action with node and property
details. Refactor these into a common printing helper. The complicating
factor is some prints are debug and some are errors. Solve this with a
bit of preprocessor magic.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Drop printing changeset entry pointers
v2:
 - Split out refactoring from fix in prior patch
 - Avoid pr_cont and relying on pr_debug return value which dynamic
   debug doesn't have
---
 drivers/of/dynamic.c | 53 +++++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 4999636eaa92..17a0727d3f9b 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -72,27 +72,21 @@ static const char *action_names[] = {
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
 
+#define _do_print(func, prefix, action, node, prop, ...) ({	\
+	func("changeset: " prefix "%-15s %pOF%s%s\n",		\
+	     ##__VA_ARGS__, action_names[action], node,		\
+	     prop ? ":" : "", prop ? prop->name : "");		\
+})
+#define of_changeset_action_err(...) _do_print(pr_err, __VA_ARGS__)
+#define of_changeset_action_debug(...) _do_print(pr_debug, __VA_ARGS__)
+
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
 	int rc;
-#ifdef DEBUG
 	struct of_reconfig_data *pr = p;
 
-	switch (action) {
-	case OF_RECONFIG_ATTACH_NODE:
-	case OF_RECONFIG_DETACH_NODE:
-		pr_debug("notify %-15s %pOF\n", action_names[action],
-			pr->dn);
-		break;
-	case OF_RECONFIG_ADD_PROPERTY:
-	case OF_RECONFIG_REMOVE_PROPERTY:
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		pr_debug("notify %-15s %pOF:%s\n", action_names[action],
-			pr->dn, pr->prop->name);
-		break;
+	of_changeset_action_debug("notify: ", action, pr->dn, pr->prop);
 
-	}
-#endif
 	rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
 	return notifier_to_errno(rc);
 }
@@ -503,30 +497,6 @@ static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 	kfree(ce);
 }
 
-#ifdef DEBUG
-static void __of_changeset_entry_dump(struct of_changeset_entry *ce)
-{
-	switch (ce->action) {
-	case OF_RECONFIG_ADD_PROPERTY:
-	case OF_RECONFIG_REMOVE_PROPERTY:
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		pr_debug("cset<%p> %-15s %pOF/%s\n", ce, action_names[ce->action],
-			ce->np, ce->prop->name);
-		break;
-	case OF_RECONFIG_ATTACH_NODE:
-	case OF_RECONFIG_DETACH_NODE:
-		pr_debug("cset<%p> %-15s %pOF\n", ce, action_names[ce->action],
-			ce->np);
-		break;
-	}
-}
-#else
-static inline void __of_changeset_entry_dump(struct of_changeset_entry *ce)
-{
-	/* empty */
-}
-#endif
-
 static void __of_changeset_entry_invert(struct of_changeset_entry *ce,
 					  struct of_changeset_entry *rce)
 {
@@ -598,7 +568,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	unsigned long flags;
 	int ret = 0;
 
-	__of_changeset_entry_dump(ce);
+	of_changeset_action_debug("applying: ", ce->action, ce->np, ce->prop);
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
@@ -642,8 +612,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
 	if (ret) {
-		pr_err("changeset: apply failed: %-15s %pOF:%s\n",
-		       action_names[ce->action], ce->np, ce->prop->name);
+		of_changeset_action_err("apply failed: ", ce->action, ce->np, ce->prop);
 		return ret;
 	}
 

-- 
2.40.1

