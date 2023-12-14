Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56A812CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443654AbjLNKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443630AbjLNKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:32:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138A11A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702549926;
        bh=RoCUu1mXewEDtm43Qq0pBWgiYLguorwyr3zE9+lEq2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCEU2AUr0ZA04uTWvKS/i3ZVnJa0VyDib+4PiyGCQg7iYXZ0YGOJGDur97P5pyzAJ
         ZDtG+cH7Qm4T+X/9B8J01Tj1odsNEBX7Zv7jVYv2UGg/igHIajr64YmluEtiDAktbJ
         FYNzi99K+px1npcA6NnqaXreto/JcbyQnFH3ZgWLhJhkphXGPb0d8FRzCMmA5OYoTE
         mi2ltw6Peioc0GwLpqNoOvumthQnpVxfsByUQS6ELu2c/csI87q8kODmX4phBHrPBG
         geRxOfCFC/OBotVhANnyzFeit42L1QHw+6Blf+5bqiU+1uuONyJ2OrSuNgPt6FhPFz
         cMuyAa7oMqijg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrTDk1lzGz4xPQ;
        Thu, 14 Dec 2023 21:32:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <christophe.leroy@csgroup.eu>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] of: Change of_machine_is_compatible() to return bool
Date:   Thu, 14 Dec 2023 21:31:49 +1100
Message-ID: <20231214103152.12269-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214103152.12269-1-mpe@ellerman.id.au>
References: <20231214103152.12269-1-mpe@ellerman.id.au>
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

of_machine_is_compatible() currently returns a positive integer if it
finds a match. However none of the callers ever check the value, they
all treat it as a true/false.

So change of_machine_is_compatible() to return bool, which will allow
the implementation to be changed in a subsequent patch.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/base.c  | 5 ++---
 include/linux/of.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

v2: New.

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9020be2eb4d5..c82c8b77badc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -419,10 +419,9 @@ bool of_machine_compatible_match(const char *const *compats)
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Return: A positive integer if the root node has the given value in its
- * compatible property.
+ * Return: true if the root node has the given value in its compatible property.
  */
-int of_machine_is_compatible(const char *compat)
+bool of_machine_is_compatible(const char *compat)
 {
 	struct device_node *root;
 	int rc = 0;
diff --git a/include/linux/of.h b/include/linux/of.h
index e3418babc203..c5c663a7fb77 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -402,7 +402,7 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
-extern int of_machine_is_compatible(const char *compat);
+extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
-- 
2.43.0

