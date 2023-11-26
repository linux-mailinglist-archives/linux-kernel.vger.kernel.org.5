Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF67F91B9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjKZHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 02:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 02:19:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D39D101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 23:19:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383C9C433C7;
        Sun, 26 Nov 2023 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700983164;
        bh=8gd0dMckeTvfrJbqiPZ2qHzROw5OCFMp48suO82vyAs=;
        h=From:To:Cc:Subject:Date:From;
        b=l8eJqj2qVxYSd0kyCthbRdsjJWwv8BkOprPhHQWVhjZE77suqM6bLD/BiLU/E1itB
         nACkUvUzYVBu3EyM6bJxFONeF6hruY82B1HyUWGAqbzqn5EaniAbbi53yeV58r0imt
         zT8dHSlB/WuMWZB8tEJRbgv06wvUmqrw/n6IMOcbv0EFj4KG/VELuhXNdO3LOvOoRM
         gdEalE+TZ+Hb+Mx2qjdTAU2T1C9ZblxQTHsNWYLM6r0sHpHh3kbiz/wTHdnDO6ixYb
         K9QP7W9tZsUkVb6Fgs4bujgAZiZhIiS/CsPQkrcKnTWsgJE3wKIeomXu98uMlhSZYy
         FGRtjHj4xOqww==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-modules@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init: move THIS_MODULE from <linux/export.h> to <linux/init.h>
Date:   Sun, 26 Nov 2023 16:19:14 +0900
Message-Id: <20231126071914.932241-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f50169324df4 ("module.h: split out the EXPORT_SYMBOL into
export.h") appropriately separated EXPORT_SYMBOL into <linux/export.h>
because modules and EXPORT_SYMBOL are orthogonal; modules are symbol
consumers, while EXPORT_SYMBOL are used by symbol providers, which
may not be necessarily a module.

However, that commit also relocated THIS_MODULE. As explained in the
commit description, the intention was to define THIS_MODULE in a
lightweight header, but I do not believe <linux/export.h> was the
suitable location because EXPORT_SYMBOL and THIS_MODULE are unrelated.

Move it to another lightweight header, <linux/init.h>. The reason for
choosing <linux/init.h> is to make <linux/moduleparam.h> self-contained
without relying on <linux/linkage.h> incorrectly including
<linux/export.h>.

With this adjustment, the role of <linux/export.h> becomes clearer as
it only defines EXPORT_SYMBOL.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/export.h | 18 ------------------
 include/linux/init.h   |  7 +++++++
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 9911508a9604..0bbd02fd351d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -6,15 +6,6 @@
 #include <linux/linkage.h>
 #include <linux/stringify.h>
 
-/*
- * Export symbols from the kernel to modules.  Forked from module.h
- * to reduce the amount of pointless cruft we feed to gcc when only
- * exporting a simple symbol or two.
- *
- * Try not to add #includes here.  It slows compilation and makes kernel
- * hackers place grumpy comments in header files.
- */
-
 /*
  * This comment block is used by fixdep. Please do not remove.
  *
@@ -23,15 +14,6 @@
  * side effect of the *.o build rule.
  */
 
-#ifndef __ASSEMBLY__
-#ifdef MODULE
-extern struct module __this_module;
-#define THIS_MODULE (&__this_module)
-#else
-#define THIS_MODULE ((struct module *)0)
-#endif
-#endif /* __ASSEMBLY__ */
-
 #ifdef CONFIG_64BIT
 #define __EXPORT_SYMBOL_REF(sym)			\
 	.balign 8				ASM_NL	\
diff --git a/include/linux/init.h b/include/linux/init.h
index 01b52c9c7526..3fa3f6241350 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -179,6 +179,13 @@ extern void (*late_time_init)(void);
 
 extern bool initcall_debug;
 
+#ifdef MODULE
+extern struct module __this_module;
+#define THIS_MODULE (&__this_module)
+#else
+#define THIS_MODULE ((struct module *)0)
+#endif
+
 #endif
   
 #ifndef MODULE
-- 
2.40.1

