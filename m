Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD077CC0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbjJQKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbjJQKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:38:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AAA2;
        Tue, 17 Oct 2023 03:38:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDCC433C8;
        Tue, 17 Oct 2023 10:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539096;
        bh=waFeOWzoowEXA/GGZGLjVsE0MWpxTTUslAmqc2q+E5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USa0Dj7IBbk3ONmbe6o+cZSZlTH0OD99mqtxWorNSzHyZZzpt1oTDK7PtaXoILlBh
         4QXfEPc9h6tLJHHOtLmZPJt/+Q7eEOpe5eUJfaHRdzAIEO1okzvPitXyHR+ZBqB6c5
         AmjlW/jjH2V1D5CVgt938CcUGJNb+ImtWyotSjKl1+uSYi97C25PRlSHYEJnt10Aya
         mpzBko3H4mtuqni0/otbiZul77lDtDvt3ZAdKWKk9pRmI5p4K/HbOlyK4DoLIPsncu
         pHdjm6Tq/aSI6VL31dh4bYOES1mrs6WwX1nHNEoTpuUjfOh72nczyNWgBaSJphi8s6
         c98gpJG0vV4dg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/4] kbuild: skip module BTF with one-time check for vmlinux
Date:   Tue, 17 Oct 2023 19:37:41 +0900
Message-Id: <20231017103742.130927-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017103742.130927-1-masahiroy@kernel.org>
References: <20231017103742.130927-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_INFO_BTF_MODULES is enabled, vmlinux presence is
checked in every module build, resulting in repetitive warning
messages if vmlinux is missing.

Check vmlinux and print a warning just once.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modfinal | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..9fd7a26e4fe9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -14,6 +14,15 @@ include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
 modules := $(call read-file, $(MODORDER))
+vmlinux :=
+
+ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+ifneq ($(wildcard vmlinux),)
+vmlinux := vmlinux
+else
+$(warning Skipping BTF generation due to unavailability of vmlinux)
+endif
+endif
 
 __modfinal: $(modules:%.o=%.ko)
 	@:
@@ -36,12 +45,8 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f vmlinux ]; then					\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
-	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
-	fi;
+		$(RESOLVE_BTFIDS) -b vmlinux $@
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
 newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
@@ -52,9 +57,9 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
+%.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
-ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+ifdef vmlinux
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-- 
2.40.1

