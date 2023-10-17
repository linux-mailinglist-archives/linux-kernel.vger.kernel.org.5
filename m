Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413837CC0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbjJQKiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbjJQKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:38:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868BFF;
        Tue, 17 Oct 2023 03:38:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C7CC433CA;
        Tue, 17 Oct 2023 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539097;
        bh=RUBKVlsGzVBXGtjDnQ7Enr6nWmXXOHg87V2AX3JQHyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBbWpDWRQqxCKAh8ALF7WRA18h7wWeqp0dama8SsxwSVZ0Qata3wtLLrNjItPEsXX
         uWKKGnMYDHGyiTMthJys+FRlJvBWsTlF/dL3hJC09E6G7N+SiujmzH7JBJoHzDj+Zu
         DsBpdUomgRKbBrSknU7UNuM91a1oUi/WITbpfoQ5i9uLZRUbub25ILQHLNik1SMY6W
         ckOp9eVScbOkTqe3MJgfCL9tsuJAZO6sJApVmyNq1/W3gRgBY8sOCsmqfOOSgUUrvk
         BUvmPH1ko+HOs7YOh9+SDZfst0PBLNNb8ZkjpYO3iGvn9Q95Xg2mUgP4KEs4l+3Gwi
         5vPMdu/FLYGfQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/4] kbuild: refactor module BTF rule
Date:   Tue, 17 Oct 2023 19:37:42 +0900
Message-Id: <20231017103742.130927-4-masahiroy@kernel.org>
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

newer_prereqs_except and if_changed_except are ugly hacks of the
newer_prereqs and if_changed in scripts/Kbuild.include.

Remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modfinal | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 9fd7a26e4fe9..6ab10dba05c7 100644
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
 	+$(call if_changed_except,ld_ko_o,vmlinux)
-ifdef vmlinux
-	+$(if $(newer-prereqs),$(call cmd,btf_ko))
-endif
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
 
-- 
2.40.1

