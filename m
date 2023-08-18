Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55385781459
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380019AbjHRUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379997AbjHRUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F13C3C;
        Fri, 18 Aug 2023 13:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483D660201;
        Fri, 18 Aug 2023 20:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E166BC433C7;
        Fri, 18 Aug 2023 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692391270;
        bh=KNeygD7b0invSgMAHHcJ7ByINYFALCfTCNGcUBotyfg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Uvo5jm+e+1bUypvaZ2KvUMW6pAt2i+X3PNu+D7I7UI8o82GHQp0wyWTmqJbEQQh4c
         O5OeHT+LsZJHQfiimLj03Xu5/oE51yN2XgzgWpwnwq4d1EGnvKb+x6f8aU3uYxkxdW
         9mArTFrP6EzhEkqVCQS+zY/i+OL3tTanDZDyYww1peZG3AQOZXpocfdOTOggD/UODN
         otnzzc/bujHK1y20xdiHP1umlC4f8487vgIMNfss4LpPxRrEQvya15t03d6XbJZlIk
         RQyKOgPgu4Xmkxg2HOA8VNofyBQ6hcDgGvan35mr2DvLkNdjpQ+k2BJoDcmvjHoF+9
         MrG0v3tOtCTyQ==
Received: (nullmailer pid 545146 invoked by uid 1000);
        Fri, 18 Aug 2023 20:41:06 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 15:41:00 -0500
Subject: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
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

The changeset code checks for a property in the deadprops list when
adding/updating a property, but of_add_property() and
of_update_property() do not. As the users of these functions are pretty
simple, they have not hit this scenario or else the property lists
would get corrupted.

With this there are 3 cases of removing a property from either deadprops
or properties lists, so add a helper to find and remove a matching
property.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Make the helper remove a property from either deadprops or properties
   lists
 - Keep existing style in deadprops loop
v2:
 - Add helper to remove property from deadprops list
---
 drivers/of/base.c    | 37 ++++++++++++++++++++++++-------------
 drivers/of/dynamic.c | 19 -------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e235f3a57ea8..3f9ddd18ff4b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1530,6 +1530,20 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
+static struct property *__of_remove_property_from_list(struct property **list, struct property *prop)
+{
+	struct property **next;
+
+	for (next = list; *next; next = &(*next)->next) {
+		if (*next == prop) {
+			*next = prop->next;
+			prop->next = NULL;
+			return prop;
+		}
+	}
+	return NULL;
+}
+
 /**
  * __of_add_property - Add a property to a node without lock operations
  * @np:		Caller's Device Node
@@ -1539,6 +1553,8 @@ int __of_add_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
 
+	__of_remove_property_from_list(&np->deadprops, prop);
+
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
@@ -1583,21 +1599,14 @@ EXPORT_SYMBOL_GPL(of_add_property);
 
 int __of_remove_property(struct device_node *np, struct property *prop)
 {
-	struct property **next;
-
-	for (next = &np->properties; *next; next = &(*next)->next) {
-		if (*next == prop)
-			break;
+	if (__of_remove_property_from_list(&np->properties, prop)) {
+		/* Found the property, add it to deadprops list */
+		prop->next = np->deadprops;
+		np->deadprops = prop;
+		return 0;
 	}
-	if (*next == NULL)
-		return -ENODEV;
-
-	/* found the node */
-	*next = prop->next;
-	prop->next = np->deadprops;
-	np->deadprops = prop;
 
-	return 0;
+	return -ENODEV;
 }
 
 /**
@@ -1641,6 +1650,8 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 {
 	struct property **next, *oldprop;
 
+	__of_remove_property_from_list(&np->deadprops, newprop);
+
 	for (next = &np->properties; *next; next = &(*next)->next) {
 		if (of_prop_cmp((*next)->name, newprop->name) == 0)
 			break;
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 1876af5b01fc..d3ad970ad7b8 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -564,7 +564,6 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	struct property **propp;
 	unsigned long flags;
 	int ret = 0;
 
@@ -579,15 +578,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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
@@ -595,15 +585,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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

