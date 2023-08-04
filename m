Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD1770C09
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjHDWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjHDWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61846B3;
        Fri,  4 Aug 2023 15:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB1E62159;
        Fri,  4 Aug 2023 22:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC97C433C8;
        Fri,  4 Aug 2023 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188933;
        bh=gQ4AyC+KFAESrH+STqjHPqsfLxlamqpZ8nc7Nwdra40=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gHuOBsTCvlhIDAOc0px80xbtJZeBjWWiYvzNykPo2fjGCWicQJcPNAJ9Lqrt7Ebmn
         30tc84SAvAFxbyYlzdnoZsuXKncO9m1qHXQddmCYiuYrC+sv2Ow3K3pFfUIAlvbsZh
         ptPKuabveIzhtU7RORPYeP24+Cwo9iaoHKkj3+CHySpUlcZeEKIY49H0ZhhDloXLFL
         xN+IRYXJjpURY1vDNfSciFIC/3IyZnGli26xNLsHbkeSQe+nwMMNMsRtu+J/pze8Z/
         sIfE+0ZQ9XUu4J2CcOwjSKJ0JMSvf9/qNeclcISbTd+/CxwSE4R3tx16Xu7gOEUPg/
         3wDArUmQAeVQQ==
Received: (nullmailer pid 2346983 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Aug 2023 16:41:55 -0600
Subject: [PATCH v2 5/6] of: dynamic: Move dead property list check into
 property add/update functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v2-5-c2b701579dee@kernel.org>
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

The changeset code checks for a property in the deadprops list when
adding/updating a property, but of_add_property() and
of_update_property() do not. As the users of these functions are pretty
simple, they have not hit this scenario or else the property lists
would get corrupted.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add helper to remove property from deadprops list
---
 drivers/of/base.c    | 19 +++++++++++++++++++
 drivers/of/dynamic.c | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e235f3a57ea8..c63a4cde281e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1530,6 +1530,21 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
+static void __of_remove_dead_property(struct device_node *np, struct property *prop)
+{
+	struct property **next;
+
+	/* If the property is in deadprops then it must be removed */
+	for (next = &np->deadprops; *next; next = &(*next)->next) {
+		if (*next != prop)
+			continue;
+
+		*next = prop->next;
+		prop->next = NULL;
+		break;
+	}
+}
+
 /**
  * __of_add_property - Add a property to a node without lock operations
  * @np:		Caller's Device Node
@@ -1539,6 +1554,8 @@ int __of_add_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
 
+	__of_remove_dead_property(np, prop);
+
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
@@ -1641,6 +1658,8 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 {
 	struct property **next, *oldprop;
 
+	__of_remove_dead_property(np, newprop);
+
 	for (next = &np->properties; *next; next = &(*next)->next) {
 		if (of_prop_cmp((*next)->name, newprop->name) == 0)
 			break;
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index fbc7c29896a2..769869e8b847 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -563,7 +563,6 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	struct property **propp;
 	unsigned long flags;
 	int ret = 0;
 
@@ -578,15 +577,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		__of_detach_node(ce->np);
 		break;
 	case OF_RECONFIG_ADD_PROPERTY:
-		/* If the property is in deadprops then it must be removed */
-		for (propp = &ce->np->deadprops; *propp; propp = &(*propp)->next) {
-			if (*propp == ce->prop) {
-				*propp = ce->prop->next;
-				ce->prop->next = NULL;
-				break;
-			}
-		}
-
 		ret = __of_add_property(ce->np, ce->prop);
 		break;
 	case OF_RECONFIG_REMOVE_PROPERTY:
@@ -594,15 +584,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		break;
 
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		/* If the property is in deadprops then it must be removed */
-		for (propp = &ce->np->deadprops; *propp; propp = &(*propp)->next) {
-			if (*propp == ce->prop) {
-				*propp = ce->prop->next;
-				ce->prop->next = NULL;
-				break;
-			}
-		}
-
 		ret = __of_update_property(ce->np, ce->prop, &ce->old_prop);
 		break;
 	default:

-- 
2.40.1

