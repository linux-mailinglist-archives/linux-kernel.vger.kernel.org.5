Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA57076BFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjHAVzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHAVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A31268C;
        Tue,  1 Aug 2023 14:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF1A61717;
        Tue,  1 Aug 2023 21:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8C2C433C8;
        Tue,  1 Aug 2023 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926923;
        bh=j035GzdMWI78hJ6xt3QYyUQ7BSA2USCCzXpQCLzuaQQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AkuLzquPcKwKmyHz45oa81zSrNbECRKfvP510Ls5d6u95yQthyCw0+nJy4U+HnG0Q
         fx4TMGZSuMERk+kjrqYF3AxEmrFYD+znh+S6J0TkhfV8VE94pMCL7Lj0XQ5CHQckiB
         h4s0pjmx9Z/45Ui3QnKUrMG5l+BQSWLlO3AoPaXrjEmOEfavHiDxcOSdNAQ8vmL+3C
         WtLkbtWnJkErhCS6x/Z6PijlJQxJ58892rEB7EbA3RA8DocX022M31CUTHSjea5xhm
         /7h6N3w2M+EBg8Y/idCmfZ6wHQPyH+bqq4RVfyVhnUGvYi6MM41RfbURq5SoQxNg4v
         RrM+bIpWqdQig==
Received: (nullmailer pid 2469343 invoked by uid 1000);
        Tue, 01 Aug 2023 21:55:14 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 01 Aug 2023 15:54:47 -0600
Subject: [PATCH 4/5] of: dynamic: Move dead property list check into
 property add/update functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v1-4-b5203e3fc22f@kernel.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c    | 17 +++++++++++++++++
 drivers/of/dynamic.c | 19 -------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 166fb7d75337..99c07f3cbf10 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1538,6 +1538,14 @@ int __of_add_property(struct device_node *np, struct property *prop)
 {
 	struct property **next;
 
+	/* If the property is in deadprops then it must be removed */
+	for (next = &np->deadprops; *next; next = &(*next)->next) {
+		if (*next == prop) {
+			*next = prop->next;
+			break;
+		}
+	}
+
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
@@ -1640,6 +1648,15 @@ int __of_update_property(struct device_node *np, struct property *newprop,
 {
 	struct property **next, *oldprop;
 
+	/* If the property is in deadprops then it must be removed */
+	for (next = &np->deadprops; *next; next = &(*next)->next) {
+		if (*next == newprop) {
+			*next = newprop->next;
+			newprop->next = NULL;
+			break;
+		}
+	}
+
 	for (next = &np->properties; *next; next = &(*next)->next) {
 		if (of_prop_cmp((*next)->name, newprop->name) == 0)
 			break;
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 31603b5a4ffc..4fd3699691b6 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -565,7 +565,6 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	struct property **propp;
 	unsigned long flags;
 	int ret = 0;
 
@@ -581,15 +580,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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
@@ -597,15 +587,6 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
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

