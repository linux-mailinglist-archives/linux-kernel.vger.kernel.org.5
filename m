Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D08812CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443634AbjLNKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443649AbjLNKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:32:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C11118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702549926;
        bh=O/o9QbjKiENBQBWvJbXtJwhr2ssAm9bGM38u9QD4iZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/6bDQV2iPr1GiUNCyIXnzRtSQNhDbG3/OGhfzVpYJSmwu9Gt7Fl5ZhHhScJU0OiB
         iSaHVPVIpvHig+sjQZkfmpi1tyTBsCWtmXiJUel68hCraxyYL/vF9JYomdHKPMB5BQ
         culcMruEy52Pxsd+RzfqVS3v44hc6NVfsrPSuK97RJwTt8sz0t6VuDeUyFGwd53xAJ
         LKRLjjsK8PJUBhgNXMH0eWLqmHNC8D2jNGx5NwQqIsEkWSJhuspMzQKPWvG25DFyAh
         6wbTzOuJV5jIV7z6BBR98S1BPaOIpfaXyOoWRnHoC6eGAhJm6Oos0+w37BXnH27GOE
         FpW5QjuSt2r3g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrTDk4sV7z4xPY;
        Thu, 14 Dec 2023 21:32:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <christophe.leroy@csgroup.eu>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] of: Reimplement of_machine_is_compatible() using of_machine_compatible_match()
Date:   Thu, 14 Dec 2023 21:31:50 +1100
Message-ID: <20231214103152.12269-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214103152.12269-1-mpe@ellerman.id.au>
References: <20231214103152.12269-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

of_machine_compatible_match() works with a table of strings.
of_machine_is_compatible() is a simplier version with only one string.

Re-implement of_machine_is_compatible() by setting a table of strings
with a single string then using of_machine_compatible_match().

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/base.c  | 21 +--------------------
 include/linux/of.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 21 deletions(-)

v2: Unchanged.

diff --git a/drivers/of/base.c b/drivers/of/base.c
index c82c8b77badc..73c3a754bad1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -414,26 +414,7 @@ bool of_machine_compatible_match(const char *const *compats)
 
 	return rc != 0;
 }
-
-/**
- * of_machine_is_compatible - Test root of device tree for a given compatible value
- * @compat: compatible string to look for in root node's compatible property.
- *
- * Return: true if the root node has the given value in its compatible property.
- */
-bool of_machine_is_compatible(const char *compat)
-{
-	struct device_node *root;
-	int rc = 0;
-
-	root = of_find_node_by_path("/");
-	if (root) {
-		rc = of_device_is_compatible(root, compat);
-		of_node_put(root);
-	}
-	return rc;
-}
-EXPORT_SYMBOL(of_machine_is_compatible);
+EXPORT_SYMBOL(of_machine_compatible_match);
 
 /**
  *  __of_device_is_available - check if a device is available for use
diff --git a/include/linux/of.h b/include/linux/of.h
index c5c663a7fb77..03ed4e37ca57 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -402,9 +402,21 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
-extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
+/**
+ * of_machine_is_compatible - Test root of device tree for a given compatible value
+ * @compat: compatible string to look for in root node's compatible property.
+ *
+ * Return: true if the root node has the given value in its compatible property.
+ */
+static inline bool of_machine_is_compatible(const char *compat)
+{
+	const char *compats[] = { compat, NULL };
+
+	return of_machine_compatible_match(compats);
+}
+
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
 extern int of_update_property(struct device_node *np, struct property *newprop);
-- 
2.43.0

