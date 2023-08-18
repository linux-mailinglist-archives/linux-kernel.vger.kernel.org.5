Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4E78145E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380024AbjHRUlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380000AbjHRUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D53C3C;
        Fri, 18 Aug 2023 13:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F9F617F0;
        Fri, 18 Aug 2023 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D2C433C8;
        Fri, 18 Aug 2023 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391274;
        bh=GfHSC+os2/e/UBzVMi4/4e2UzAKpnFR59mGA7/NVZZs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HtOmfJzXmLIo2L+NzbkVznKbKi3xZ/uUJn1T5wLSc2QeJGsmU2c31EO5Cbzn+CV26
         I/CE2lJio6gkwnbmeA4GSRwoMsZwBT2/YZ/sGCxwVCZSEn6rKP6QfcZysgMgI6XpIW
         +64hh2e8Z1VyNNPsbJHoBuOm8H0UnbRQKk1KSOsHB3pv3UVUwpnq0+IO7PhEJhWvFx
         25H0rBp2uQzHTkmt1v5sUt+ss66+x/kSRFPajKixQIeVVQqkvT4buM+bS1VIvzRgKo
         HJq4BrurcqN19x86ZwibhposJEeQYDqW3/Fd29V2TcuTIHSjN3UPLNltONlIzdFqdM
         ei55UXTcGedRw==
Received: (nullmailer pid 545140 invoked by uid 1000);
        Fri, 18 Aug 2023 20:41:06 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 15:40:57 -0500
Subject: [PATCH v3 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v3-2-5f0410e007dd@kernel.org>
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

Fix this by moving the printing in __of_changeset_entry_apply() outside
the lock. As the only difference in the the multiple prints is the
action name, use the existing "action_names" to refactor the prints into
a single print.

Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v6 (v3 in this series):
 - Add check on 'action' bounds. As action is only set in
   of_changeset_action(), add the check there.
 - Drop printing the changeset entry pointer
v5 (v2 in this series):
 - Move majority of refactoring to separate patch and minimize the fix
   to just moving the print out of the locked section.
v4:
 - Add missing 'static' reported by 0-day
v3:
 - Re-implement Geert's fix to move the prints rather than move the
   spinlock

v1 and v2 from Geert simply moved the devtree_lock into each case
statement:

https://lore.kernel.org/all/c593d8389352c574b5be69d4ca4810da13326a50.1690533838.git.geert+renesas@glider.be/
---
 drivers/of/dynamic.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index e311d406b170..4999636eaa92 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -63,15 +63,14 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
-#ifdef DEBUG
-const char *action_names[] = {
+static const char *action_names[] = {
+	[0] = "INVALID",
 	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
 	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
 	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
 	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
-#endif
 
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
@@ -620,21 +619,9 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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
@@ -648,20 +635,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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
+		pr_err("changeset: apply failed: %-15s %pOF:%s\n",
+		       action_names[ce->action], ce->np, ce->prop->name);
 		return ret;
+	}
 
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
@@ -947,6 +931,9 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	if (!ce)
 		return -ENOMEM;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);

-- 
2.40.1

