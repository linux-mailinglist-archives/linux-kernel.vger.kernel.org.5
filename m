Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2E785729
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHWLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjHWLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D49E7C;
        Wed, 23 Aug 2023 04:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0301864B5F;
        Wed, 23 Aug 2023 11:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39E8C433C9;
        Wed, 23 Aug 2023 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791465;
        bh=wFUASYLi3QguTEkF0la7u7GiwBTMM+3rNu1Qw/Z6zxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4Kx9V4+sIMX88xrczTyop2w+DSwwF0R9aJVWzO3tODOykestZcECIYKTJEsNm3Bg
         U9yxJmIqcZ4Xju47rDyTJFcBZMkMYYuvD34N93BGjZWfJZ24fZpQVf4EtvfCuGJbB/
         XJA9C/1wh+JODoqWOSiS1g8Cn1KyGMWhW7d0yjzMO1eWck+3tlCo77sUBxVbz216TQ
         aG7iCAMRWxPXa0HS49X5DOyk4xquNQfZtb848XhHyIaDd9ABwFy1rXdLSI47G9zNer
         6+0uCGSEV1gwvffzBnp3ANka8ccyjE+wD7QfCal0WOz8QG5CYlrnah1bChXtQ93Pk1
         m9Br/qS6OARvA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 6/8] kbuild: move more module installation code to scripts/Makefile.modinst
Date:   Wed, 23 Aug 2023 20:50:46 +0900
Message-Id: <20230823115048.823011-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move more relevant code to scripts/Makefile.modinst.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 34 +++++++--------------------------
 scripts/Makefile.modinst | 41 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 7d9cab3d2186..82d22debf6c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1477,24 +1477,6 @@ endif
 
 endif # CONFIG_MODULES
 
-modinst_pre :=
-ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
-modinst_pre := __modinst_pre
-endif
-
-modules_install: $(modinst_pre)
-PHONY += __modinst_pre
-__modinst_pre:
-	@rm -rf $(MODLIB)/kernel
-	@rm -f $(MODLIB)/build
-	@mkdir -p $(MODLIB)
-ifdef CONFIG_MODULES
-	@ln -s $(CURDIR) $(MODLIB)/build
-	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
-endif
-	@cp -f modules.builtin $(MODLIB)/
-	@cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
-
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1836,12 +1818,15 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
+ifndef CONFIG_MODULES
+modules modules_install: __external_modules_error
 __external_modules_error:
 	@echo >&2 '***'
 	@echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
 	@echo >&2 '*** You cannot build or install external modules.'
 	@echo >&2 '***'
 	@false
+endif
 
 endif # KBUILD_EXTMOD
 
@@ -1850,6 +1835,9 @@ endif # KBUILD_EXTMOD
 
 PHONY += modules modules_install modules_prepare
 
+modules_install:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+
 ifdef CONFIG_MODULES
 
 $(MODORDER): $(build-dir)
@@ -1866,17 +1854,9 @@ PHONY += modules_check
 modules_check: $(MODORDER)
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
 
-modules_install:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
-
 else # CONFIG_MODULES
 
-# Modules not configured
-# ---------------------------------------------------------------------------
-
-PHONY += __external_modules_error
-
-modules modules_install: __external_modules_error
+modules:
 	@:
 
 KBUILD_MODULES :=
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 5d687a453d90..dc7c54669082 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -13,9 +13,41 @@ install-y :=
 
 PHONY += prepare
 
+ifeq ($(KBUILD_EXTMOD)$(modules_sign_only),)
+
+# Install more files for in-tree modules_install
+
+prepare:
+	$(Q)rm -fr $(MODLIB)/kernel $(MODLIB)/build
+	$(Q)mkdir -p $(sort $(dir $(install-y)))
+
+install-$(CONFIG_MODULES) += $(addprefix $(MODLIB)/, build modules.order)
+
+$(MODLIB)/build: FORCE
+	$(call cmd,symlink)
+
+quiet_cmd_symlink = SYMLINK $@
+      cmd_symlink = ln -s $(CURDIR) $@
+
+$(MODLIB)/modules.order: modules.order FORCE
+	$(call cmd,install_modorder)
+
+quiet_cmd_install_modorder = INSTALL $@
+      cmd_install_modorder = sed 's:^\(.*\)\.o$$:kernel/\1.ko:' $< > $@
+
+# Install modules.builtin(.modinfo) even when CONFIG_MODULES is disabled.
+install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo)
+
+$(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo): $(MODLIB)/%: % FORCE
+	$(call cmd,install)
+
+else
+
 prepare:
 	$(Q)mkdir -p $(sort $(dir $(install-y)))
 
+endif
+
 modules := $(call read-file, $(MODORDER))
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -34,9 +66,10 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
 
 modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
-install-y += $(modules)
 
-__modinst: $(modules)
+install-$(CONFIG_MODULES) += $(modules)
+
+__modinst: $(install-y)
 	@:
 
 #
@@ -94,14 +127,16 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
 	$(call cmd,strip)
 	$(call cmd,sign)
 
+ifdef CONFIG_MODULES
 __modinst: depmod
 
 PHONY += depmod
-depmod: $(modules)
+depmod: $(install-y)
 	$(call cmd,depmod)
 
 quiet_cmd_depmod = DEPMOD  $(MODLIB)
       cmd_depmod = $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
+endif
 
 $(install-y): prepare
 
-- 
2.39.2

