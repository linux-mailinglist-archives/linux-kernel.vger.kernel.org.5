Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAC7CE10B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjJRPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJRPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF8114;
        Wed, 18 Oct 2023 08:20:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED347C433CA;
        Wed, 18 Oct 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642412;
        bh=64NbOJwL+HDqWyuM6JoXFyBcAlHXP3zz+QUuLv6Cm7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTIyxfwrpTY5bgbva8rPbkcGlgqoZai0aO3PkJiKLsjwlaQN26q9Yhf7zRd2wjkRW
         WZduFe/lFbU/q+9u4epT/mVv1LqRuauO0bz5OWF23Kd8JMxngIYbgEwwc+f4kmivhh
         VJTyepbpLsgfF5FtZVGl8dMHPuvoQ8QD6No7cMYjk689j0+PdrMxAx2gcLvk6LY2TW
         Ety129FzUIr6FfwD15PVqI3wl9DSL9mvUBfMHnmNmKqGI6SnKNxfdm/eFbapyE1BFX
         gpiFW89j2Z6bS6GGInAnAKbVxMu33QTPYYdJA91bLmvH3+wqGmgTWgilv6JfdU0Nwc
         KdvBwAIq+VCYg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, bpf@vger.kernel.org
Subject: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
Date:   Thu, 19 Oct 2023 00:19:50 +0900
Message-Id: <20231018151950.205265-4-masahiroy@kernel.org>
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

newer_prereqs_except and if_changed_except are ugly hacks of the
newer-prereqs and if_changed in scripts/Kbuild.include.

Remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix if_changed_except to if_changed

 scripts/Makefile.modfinal | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 9fd7a26e4fe9..fc07854bb7b9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -19,6 +19,9 @@ vmlinux :=
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 ifneq ($(wildcard vmlinux),)
 vmlinux := vmlinux
+cmd_btf = ; \
+	LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
+	$(RESOLVE_BTFIDS) -b vmlinux $@
 else
 $(warning Skipping BTF generation due to unavailability of vmlinux)
 endif
@@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^)
+		-T scripts/module.lds -o $@ $(filter %.o, $^)		\
+	$(cmd_btf)
 
-quiet_cmd_btf_ko = BTF [M] $@
-      cmd_btf_ko = 							\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@
-
-# Same as newer-prereqs, but allows to exclude specified extra dependencies
-newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
-
-# Same as if_changed, but allows to exclude specified extra dependencies
-if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
-	$(cmd);                                                              \
-	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
-
-# Re-generate module BTFs if either module's .ko or vmlinux changed
 %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,vmlinux)
-ifdef vmlinux
-	+$(if $(newer-prereqs),$(call cmd,btf_ko))
-endif
+	+$(call if_changed,ld_ko_o)
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
 
-- 
2.40.1

