Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C5770C12
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjHDWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHDWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CE4EFA;
        Fri,  4 Aug 2023 15:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9DD062161;
        Fri,  4 Aug 2023 22:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738B1C433CA;
        Fri,  4 Aug 2023 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188940;
        bh=opEsAI2Xe5riNxll2Ve+4XTHqIK5b0EkHyP6PSvHTMw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JDmdzwkiI1HihK9Rl/8E+fZSaeZPwqYB12wp44YfdHh6MGK1H7D+aqBhib3VOm3qt
         iMuFSWRXHEa9ub8z+ZlauXFHS26FMdSZL1XFJYQlH+b6RQDDS/VIKydgGUuOBjILq0
         /cKfr6srFy29IBuDJvyTqx361KSi0v1zO83QBhycJ2YtZqfX2AG44MvZQ7P60R8JUi
         b0QlM4G1GogznZi/1Y9VDey0ZrAwb/mdoghwdn2Bku2wjmeiks1O5NiEcH5ztvXhhb
         OTnJA3iQd8H3La2hCEY7AyINOze1vPuGztLV/TmwUYDyeXv4X7jD/9RHDCZY8nFrp9
         EOCvnb3sTQK3w==
Received: (nullmailer pid 2346979 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Aug 2023 16:41:53 -0600
Subject: [PATCH v2 3/6] of: dynamic: Refactor changeset action printing to
 common helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v2-3-c2b701579dee@kernel.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 - Split out refactoring from fix in prior patch
 - Avoid pr_cont and relying on pr_debug return value which dynamic
   debug doesn't have
---
 drivers/of/dynamic.c | 53 +++++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 2f0eb0053773..6eaa66b11a02 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -71,27 +71,21 @@ static const char *action_names[] = {
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
@@ -502,30 +496,6 @@ static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
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
@@ -597,7 +567,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	unsigned long flags;
 	int ret = 0;
 
-	__of_changeset_entry_dump(ce);
+	of_changeset_action_debug("applying: cset<%p> ", ce->action, ce->np, ce->prop, ce);
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	switch (ce->action) {
@@ -641,8 +611,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
 	if (ret) {
-		pr_err("changeset: apply failed: cset<%p> %-15s %pOF:%s\n",
-		       ce, action_names[ce->action], ce->np, ce->prop->name);
+		of_changeset_action_err("apply failed: cset<%p> ", ce->action, ce->np, ce->prop, ce);
 		return ret;
 	}
 

-- 
2.40.1

