Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A76770C13
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHDWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjHDWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220035249;
        Fri,  4 Aug 2023 15:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 988F362179;
        Fri,  4 Aug 2023 22:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDEEC433BA;
        Fri,  4 Aug 2023 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188942;
        bh=8peVQkAUMgH6YYwSmql7OBIk0sITKpX/yuaqGHaDXB4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=J08bLM+ZIWZyOUIzecJOud+FY5i8wr9eDNnSKKs8j8Lt6897mCjFm3GwPUBlT4b5B
         QmvBd/vCnAOoj/14mm6KDcbgd3IuPxp1BNtG4F2L6Gw0SUa7+0MfKGAkeL5MB1/PEm
         8+Mg25fqrvIqw4ICodp4w/CD2bdTNuIonurUPuAVenTaWAwTZUXzfSRC0Nxu5h/SOs
         oMj/243kUx2DYjVmY7uNpZJgb9KsQSCDEU//q5rBKLXNnD/Af3odc9UB3/HzWHqF/e
         Fgdk7yKx1YlB3fJrA5X5pS1yxm8BRiwkrU348u/p8Wq7b3yiFPWNr3u8ABOQtCs+JF
         gNYURO1nv1EFg==
Received: (nullmailer pid 2346981 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Aug 2023 16:41:54 -0600
Subject: [PATCH v2 4/6] of: dynamic: Fix race in getting old property when
 updating property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v2-4-c2b701579dee@kernel.org>
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
index 6eaa66b11a02..fbc7c29896a2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -563,7 +563,7 @@ static int __of_changeset_entry_notify(struct of_changeset_entry *ce,
 
 static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 {
-	struct property *old_prop, **propp;
+	struct property **propp;
 	unsigned long flags;
 	int ret = 0;
 
@@ -603,7 +603,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 			}
 		}
 
-		ret = __of_update_property(ce->np, ce->prop, &old_prop);
+		ret = __of_update_property(ce->np, ce->prop, &ce->old_prop);
 		break;
 	default:
 		ret = -EINVAL;
@@ -904,9 +904,6 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
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

