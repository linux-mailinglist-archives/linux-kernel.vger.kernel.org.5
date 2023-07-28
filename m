Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873F7678DF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjG1XUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjG1XT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099730CF;
        Fri, 28 Jul 2023 16:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555126220F;
        Fri, 28 Jul 2023 23:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE3C433C7;
        Fri, 28 Jul 2023 23:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690586397;
        bh=Wmvrhsi2R8px/p9KZeL9XwfWiVDPSupv0EHaOaT/ABg=;
        h=From:To:Cc:Subject:Date:From;
        b=hO4yly3eUrPiHF3Zo43Tqk+YOC1rOCcVc7Vim7ubK1gIugJ7HRzIizLB7vrKk0Sl0
         lBiDRb1s+Bi8v9luFrtfjwXonza3++idplv6ggjxGYC4EW+/qeY3UkcOKvxblAuvM+
         a/n2h6aX2lXBF0lnrM9kEyFyBD0fbOn7VafzQscWcXuwiFtAuvtb1J3sNpR57IKhmA
         hdW8zPoDS59UTTUGjRfrDhNRjNMsYXuPQOkPBUfI3Zq1ZMQj7wxzc3prSrla96q40i
         rEeGmFesr7YafvAA43eJYA6Li012s1YI1fbOFV6kuKIDZG+W/OudKnjEbSqGSiW423
         BSQx7CupYOr+A==
Received: (nullmailer pid 1619204 invoked by uid 1000);
        Fri, 28 Jul 2023 23:19:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
Date:   Fri, 28 Jul 2023 17:19:50 -0600
Message-Id: <20230728231950.1619073-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While originally it was fine to format strings using "%pOF" while
holding devtree_lock, this now causes a deadlock.  Lockdep reports:

    of_get_parent from of_fwnode_get_parent+0x18/0x24
    ^^^^^^^^^^^^^
    of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
    fwnode_count_parents from fwnode_full_name_string+0x18/0xac
    fwnode_full_name_string from device_node_string+0x1a0/0x404
    device_node_string from pointer+0x3c0/0x534
    pointer from vsnprintf+0x248/0x36c
    vsnprintf from vprintk_store+0x130/0x3b4

To fix this, move the printing in __of_changeset_entry_apply() outside the
lock. As there's already similar printing of the same changeset actions,
refactor all of them to use a common action print function. This has the
side benefit of getting rid of some ifdefs.

Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v1 and v2 from Geert simply moved the devtree_lock into each case
statement:

https://lore.kernel.org/all/c593d8389352c574b5be69d4ca4810da13326a50.1690533838.git.geert+renesas@glider.be/
---
 drivers/of/dynamic.c | 79 ++++++++++----------------------------------
 1 file changed, 17 insertions(+), 62 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..6edb084e928a 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -63,37 +63,30 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
-#ifdef DEBUG
-const char *action_names[] = {
+static const char *action_names[] = {
 	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
 	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
 	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
 	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
-#endif
+
+void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
+{
+	if (prop_name)
+		pr_cont("%-15s %pOF:%s\n", action_names[action], np, prop_name);
+	else
+		pr_cont("%-15s %pOF\n", action_names[action], np);
+}
 
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
+	if (pr_debug("notify "))
+		of_changeset_action_print(action, pr->dn, pr->prop ? pr->prop->name : NULL);
 
-	}
-#endif
 	rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
 	return notifier_to_errno(rc);
 }
@@ -504,30 +497,6 @@ static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
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
@@ -599,7 +568,8 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	unsigned long flags;
 	int ret = 0;
 
-	__of_changeset_entry_dump(ce);
+	if (pr_debug("changeset: applying: cset<%p> ", ce))
+		of_changeset_action_print(ce->action, ce->np, ce->prop ? ce->prop->name : NULL);
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
@@ -620,21 +590,9 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_add_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: add_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	case OF_RECONFIG_REMOVE_PROPERTY:
 		ret = __of_remove_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: remove_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 
 	case OF_RECONFIG_UPDATE_PROPERTY:
@@ -648,20 +606,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_update_property(ce->np, ce->prop, &old_prop);
-		if (ret) {
-			pr_err("changeset: update_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	default:
 		ret = -EINVAL;
 	}
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
-	if (ret)
+	if (ret) {
+		pr_err("changeset: apply failed: cset<%p> ", ce);
+		of_changeset_action_print(ce->action, ce->np, ce->prop ? ce->prop->name : NULL);
 		return ret;
+	}
 
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
-- 
2.40.1

