Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCA812CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443642AbjLNKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443647AbjLNKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:32:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ECE126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702549925;
        bh=GGeeLl7/lvdKSOj2aFz5JQVMA3Kqw3o0H/s73FfePTY=;
        h=From:To:Cc:Subject:Date:From;
        b=B2pWi838wrtLIVhJS7mPEbgCabqUp6TppXiowwvt8mhy+oj0T9gHzIG8OxETfWNsY
         ssDE9o9sOnCrm//48vnGkWynayIk3Fc0lokMXIDTDKMn3V2zLB9+rWR9zRu2cO/WKq
         gqkTrzeDlekFCW5/FWmkIoleruWQuLZYTGaRhilQSrwn5Rx2pM7kuLfR7kaSH+J9N+
         FJdCpBQfTOAIZFfneFDSttaPapgCSDNKx3vn4QmU4KTTyT6C/sRRzHDGKB/lJ/Sc8a
         Rrtxl2L0LHrr30/7UVDb91ps9rsJTJ9kEfLzadwevJ6mf2Yr5Xwwr+aJoHXzl5sTI8
         d9cQdLGmht2lw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrTDj5X98z4xPL;
        Thu, 14 Dec 2023 21:32:05 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <christophe.leroy@csgroup.eu>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] of: Add of_machine_compatible_match()
Date:   Thu, 14 Dec 2023 21:31:48 +1100
Message-ID: <20231214103152.12269-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have of_machine_is_compatible() to check if a machine is compatible
with a single compatible string. However some code is able to support
multiple compatible boards, and so wants to check for one of many
compatible strings.

So add of_machine_compatible_match() which takes a NULL terminated
array of compatible strings to check against the root node's
compatible property.

Compared to an open coded match this is slightly more self
documenting, and also avoids the caller needing to juggle the root
node either directly or via of_find_node_by_path().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/base.c  | 21 +++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 27 insertions(+)

v2: Unchanged.

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cd..9020be2eb4d5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -394,6 +394,27 @@ int of_device_compatible_match(const struct device_node *device,
 }
 EXPORT_SYMBOL_GPL(of_device_compatible_match);
 
+/**
+ * of_machine_compatible_match - Test root of device tree against a compatible array
+ * @compats: NULL terminated array of compatible strings to look for in root node's compatible property.
+ *
+ * Returns true if the root node has any of the given compatible values in its
+ * compatible property.
+ */
+bool of_machine_compatible_match(const char *const *compats)
+{
+	struct device_node *root;
+	int rc = 0;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		rc = of_device_compatible_match(root, compats);
+		of_node_put(root);
+	}
+
+	return rc != 0;
+}
+
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..e3418babc203 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -403,6 +403,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 extern int of_machine_is_compatible(const char *compat);
+bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -808,6 +809,11 @@ static inline int of_remove_property(struct device_node *np, struct property *pr
 	return 0;
 }
 
+static inline bool of_machine_compatible_match(const char *const *compats)
+{
+	return false;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;
-- 
2.43.0

