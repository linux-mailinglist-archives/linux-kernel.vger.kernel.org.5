Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27E7CE109
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjJRPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjJRPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:20:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F035E10F;
        Wed, 18 Oct 2023 08:20:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79BC433C9;
        Wed, 18 Oct 2023 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642410;
        bh=Zr2L12JqejcIlTbLLIerbGhqiW1yZZSSNZv8I1yqdSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL059UW4d7zF4SqEOQDHlI9qWMvJTNfpJxRNMVNqZIf3KIUSQ34igV3GhrJx5clcG
         EP49FyFunMCWDuWbJ2Rgtu8IUQLVkRt8/ZT+zRDwiQhZsHOwvyY5v0Lp489rPOkKmY
         GF8TBHcovVrhZr42YPDCjfhdyW5LJ2IRqzQUCD1BZxigG2fCZD8NDLVj1ElMvcTUVH
         UB/pd4w/YRgbME2VUuZNZzzm+zhGK+1gmmY0vh8SuI7roe4HZSuvY/yiJHldr8pFEo
         x3u0Ezxb0numpcnNjRr4dIHd1m0q7Ofxvc7PgHSUlKpJgCT4fupNNTGBArHzlcrWja
         XcJUo4C3bgUgw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Subject: [bpf-next PATCH v2 3/4] kbuild: skip module BTF with one-time check for vmlinux
Date:   Thu, 19 Oct 2023 00:19:49 +0900
Message-Id: <20231018151950.205265-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018151950.205265-1-masahiroy@kernel.org>
References: <20231018151950.205265-1-masahiroy@kernel.org>
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
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

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

