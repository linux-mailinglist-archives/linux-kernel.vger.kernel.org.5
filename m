Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53B7F5ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKWJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:05:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBDD101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:05:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4651AC433C8;
        Thu, 23 Nov 2023 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700730353;
        bh=+S0QOs7zuWZpTFZyFLS6YyVha4vuoTNTbVeQoPbXayw=;
        h=From:To:Cc:Subject:Date:From;
        b=nUimwDIM3kEWMXTLYyaNe/kIGqot2BYZsI6KSDQeNRxirqfA1rFhNYqJ7/Fmef+eU
         kk6/GvIJ7HWifHJcEhO/IhcUFO2+mBVDGtNDdF3OncQo2D1rqscuvZ8plDM8zGzHsb
         KPsLyNlk3yys5ww6DinYnQ7z7BfL3cFC7uI4avn0qt2bNt3Xj+vCbP7HW2tv2K8w6V
         IFhFtv/HUJZsZ05KrRkh0eyOsan/yxlmfsZ+h8I+Uizih29sD3f87bZo3FLH0kAY06
         eEu9rpBFvx3SDe13u1U10KRm8YlvDKx9DgKBLcaTaQdynfq61QpVuNQ4r4DWyU3zXY
         Me8WYYTdxn8Gg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: support W=c and W=e shorthands for Kconfig
Date:   Thu, 23 Nov 2023 18:05:40 +0900
Message-Id: <20231123090540.485309-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCONFIG_WARN_UNKNOWN_SYMBOLS=1 and KCONFIG_WERROR=1 are descriptive
and suitable in scripting, but it is tedious to type them from the
command line.

Associate them with KBUILD_EXTRA_WARN (and the W= shorthand).

Support a new letter 'c' for KBUILD_EXTRA_WARN to enable extra checks
in Kconfig. You can still manage compiler warnings (W=1) and Kconfig
warnings (W=c) independently.

Reuse the letter 'e' to turn Kconfig warnings into errors.

As usual, you can combine multiple letters in KCONFIG_EXTRA_WARN.

  $ KCONFIG_WARN_UNKNOWN_SYMBOLS=1 KCONFIG_WERROR=1 make defconfig

can be shortened to:

  $ KBUILD_EXTRA_WARN=ce make defconfig

or, even shorter:

  $ make W=ce defconfig

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                   | 10 ++++++++++
 scripts/Makefile.extrawarn |  9 ---------
 scripts/kconfig/Makefile   |  8 ++++++++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index f128a1a1b1a0..91947f722b77 100644
--- a/Makefile
+++ b/Makefile
@@ -155,6 +155,15 @@ endif
 
 export KBUILD_EXTMOD
 
+# backward compatibility
+KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
+
+ifeq ("$(origin W)", "command line")
+  KBUILD_EXTRA_WARN := $(W)
+endif
+
+export KBUILD_EXTRA_WARN
+
 # Kbuild will save output files in the current working directory.
 # This does not need to match to the root of the kernel source tree.
 #
@@ -1659,6 +1668,7 @@ help:
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
+	@echo  '		c: extra checks in the configuration stage (Kconfig)'
 	@echo  '		e: warnings are being treated as errors'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
 	@$(if $(dtstree), \
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2fe6f2828d37..3f94915fab37 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -80,15 +80,6 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
-# backward compatibility
-KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
-
-ifeq ("$(origin W)", "command line")
-  KBUILD_EXTRA_WARN := $(W)
-endif
-
-export KBUILD_EXTRA_WARN
-
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 4eee155121a8..322c061b464d 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -27,6 +27,14 @@ KCONFIG_DEFCONFIG_LIST += \
 endif
 KCONFIG_DEFCONFIG_LIST += arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)
 
+ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
+export KCONFIG_WARN_UNKNOWN_SYMBOLS=1
+endif
+
+ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
+export KCONFIG_WERROR=1
+endif
+
 # We need this, in case the user has it in its environment
 unexport CONFIG_
 
-- 
2.40.1

