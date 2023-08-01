Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3304076BF9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjHAVza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjHAVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:55:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC842134;
        Tue,  1 Aug 2023 14:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E0161750;
        Tue,  1 Aug 2023 21:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AABC433C9;
        Tue,  1 Aug 2023 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926920;
        bh=0701bJOBg95miRQteud7cUM6mXMgwl0E9IlK6sWteVY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WRQx49Oeiy26fg7ZSa6GSgPSjjD7/P8HOJH+OgvWj1VNuw7bW+FbfZfWfOiEb2NgO
         +v9txqQqn0H3ZMQQrXiglgUgOVAEi56waMkWb+fNANp6VKtLyBDs+cWkyngmSmtv9l
         Q5F6j7Tw0xFsjc0tiMjzI9vF8oXdpkkmIMbL8WH4QUGSJrib1HbIhqmR7OoUGDsckZ
         1IJx0DamqpX/f7sbfP96y0yJS6Kcu3I39EJNhvvFWlou/FUk8rLpVm94VWFBO6yx9W
         SXT9Dy15dpeBs/R0QjBSEIP2r8NAIXKELcY/AUS3xhvDiCxbl2sFgp/TFFmQEsQOZO
         yZGU9VukGuFWQ==
Received: (nullmailer pid 2469341 invoked by uid 1000);
        Tue, 01 Aug 2023 21:55:14 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 01 Aug 2023 15:54:46 -0600
Subject: [PATCH 3/5] of: dynamic: Fix race in getting old property when
 updating property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v1-3-b5203e3fc22f@kernel.org>
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

__of_update_property() returns the existing property if there is one, but
that value is never added to the changeset. Updates work because the
existing property is also retrieved in of_changeset_action(), but that is
racy as of_changeset_action() doesn't hold any locks. The property could
be changed before the changeset is applied.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/dynamic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index aa3821836937..31603b5a4ffc 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -565,7 +565,7 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	struct property *old_prop, **propp;
+	struct property **propp;
 	unsigned long flags;
 	int ret = 0;
 
@@ -606,7 +606,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 			}
 		}
 
-		ret = __of_update_property(ce->np, ce->prop, &old_prop);
+		ret = __of_update_property(ce->np, ce->prop, &ce->old_prop);
 		break;
 	default:
 		ret = -EINVAL;
@@ -908,9 +908,6 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	ce->np = of_node_get(np);
 	ce->prop = prop;
 
-	if (action == OF_RECONFIG_UPDATE_PROPERTY && prop)
-		ce->old_prop = of_find_property(np, prop->name, NULL);
-
 	/* add it to the list */
 	list_add_tail(&ce->node, &ocs->entries);
 	return 0;

-- 
2.40.1

