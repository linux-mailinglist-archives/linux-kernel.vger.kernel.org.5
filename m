Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17F478572D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjHWLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjHWLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129410F4;
        Wed, 23 Aug 2023 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB8B2660A4;
        Wed, 23 Aug 2023 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879EEC433C8;
        Wed, 23 Aug 2023 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791469;
        bh=Qxv/8a7cbDHGce4PkpsCd77nqaf021G/M1emjTuC+4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tx0ESURFqrHydXrybxmIpYZTIhJEuAsKNs3bhXCl9l7/vaNAslvhvZNWOwaVAommV
         HEGWCH2RqW2QflFgnOx4jqY9i4KAmar4UE2HvNfOn4KYG0ZctUdntPF1MfbrOH5Z4g
         GrtgVDXhYrOHkHJQmiKxcVwGxDoodpqmSaRzD+BYliYjoJIMROmJ2iNoRoO1JDNOqq
         nDs6ziyZtaxn4iwXwqAdtkj7Ps4J3G4y1fE6qksLkN9UcwTs3HmsT9sQAgC2Wv53cf
         dLxUJgXUMRHQZrgJ0WvmbGwuHi3pvPSjLbcXDicYD1EGTu0yKz5dyiXL/z5qR51XrO
         s/OjwihEqusig==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 8/8] kbuild: support modules_sign for external modules as well
Date:   Wed, 23 Aug 2023 20:50:48 +0900
Message-Id: <20230823115048.823011-8-masahiroy@kernel.org>
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

The modules_sign target is currently only available for in-tree modules,
but it actually works for external modules as well.

Move the modules_sign rule to the common part.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 32 ++++++++++++++++----------------
 scripts/Makefile.modinst |  4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 82d22debf6c9..87a9eef3fb4b 100644
--- a/Makefile
+++ b/Makefile
@@ -1461,20 +1461,6 @@ modules: modules_prepare
 modules_prepare: prepare
 	$(Q)$(MAKE) $(build)=scripts scripts/module.lds
 
-export modules_sign_only :=
-
-ifeq ($(CONFIG_MODULE_SIG),y)
-PHONY += modules_sign
-modules_sign: modules_install
-	@:
-
-# modules_sign is a subset of modules_install.
-# 'make modules_install modules_sign' is equivalent to 'make modules_install'.
-ifeq ($(filter modules_install,$(MAKECMDGOALS)),)
-modules_sign_only := y
-endif
-endif
-
 endif # CONFIG_MODULES
 
 ###
@@ -1833,10 +1819,24 @@ endif # KBUILD_EXTMOD
 # ---------------------------------------------------------------------------
 # Modules
 
-PHONY += modules modules_install modules_prepare
+PHONY += modules modules_install modules_sign modules_prepare
 
 modules_install:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst \
+	sign-only=$(if $(filter modules_install,$(MAKECMDGOALS)),,y)
+
+ifeq ($(CONFIG_MODULE_SIG),y)
+# modules_sign is a subset of modules_install.
+# 'make modules_install modules_sign' is equivalent to 'make modules_install'.
+modules_sign: modules_install
+	@:
+else
+modules_sign:
+	@echo >&2 '***'
+	@echo >&2 '*** CONFIG_MODULE_SIG is disabled. You cannot sign modules.'
+	@echo >&2 '***'
+	@false
+endif
 
 ifdef CONFIG_MODULES
 
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 33d424a3f265..459cb1fed223 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -13,7 +13,7 @@ install-y :=
 
 PHONY += prepare
 
-ifeq ($(KBUILD_EXTMOD)$(modules_sign_only),)
+ifeq ($(KBUILD_EXTMOD)$(sign-only),)
 
 # Install more files for in-tree modules_install
 
@@ -115,7 +115,7 @@ quiet_cmd_sign = SIGN    $@
       cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
 
-ifeq ($(modules_sign_only),)
+ifeq ($(sign-only),)
 
 # During modules_install, modules are signed only when CONFIG_MODULE_SIG_ALL=y.
 ifndef CONFIG_MODULE_SIG_ALL
-- 
2.39.2

