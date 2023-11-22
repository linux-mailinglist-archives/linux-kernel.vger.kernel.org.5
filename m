Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B57F5512
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbjKVXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjKVXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:55:40 -0500
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128C110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:55:36 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=APd5R7wj7h+UmDndBcpcrIZgyAl8kblJEa7hsW1VzXE=;
        b=Fr7LKUrQ1+DPyV59aRzL3jODD/CLS6w6QtYL7iNfwY43PhntlV2CnZKhxbzNFOmlLBi4SO
        q/aFPu3vTEVHuChpUq6NShLz2quOOZh/wFX/lb+bTnnZ+Dw4sLO0OWd2YBvoSKoAlmsb8F
        Hv3l1Yk8Wxh1XvSZjFlhrcEx5+wnTsc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Allow gcov to be enabled on the command line
Date:   Wed, 22 Nov 2023 18:55:27 -0500
Message-ID: <20231122235527.180507-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows gcov to be enabled for a particular kernel source
subdirectory on the command line, without editing makefiles, like so:

  make GCOV_PROFILE_fs_bcachefs=y

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 scripts/Kbuild.include | 10 ++++++++++
 scripts/Makefile.lib   |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7778cc97a4e0..5341736f2e30 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -277,3 +277,13 @@ ifneq ($(and $(filter notintermediate, $(.FEATURES)),$(filter-out 4.4,$(MAKE_VER
 else
 .SECONDARY:
 endif
+
+ # expand_parents(a/b/c) = a/b/c a/b a
+expand_parents2 = $(if $(subst .,,$(1)),$(call expand_parents,$(1)),)
+expand_parents  = $(1) $(call expand_parents2,$(patsubst %/,%,$(dir $(1))))
+
+# flatten_dirs(a/b/c) = a_b_c a_b a
+flatten_dirs = $(subst /,_,$(call expand_parents,$(1)))
+
+# eval_vars(X_,a/b/c) = $(X_a_b_c) $(X_a_b) $(X_a)
+eval_vars = $(foreach var,$(call flatten_dirs,$(2)),$($(1)$(var)))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e01..0b4581a8bc33 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -148,7 +148,7 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)
 #
 ifeq ($(CONFIG_GCOV_KERNEL),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(GCOV_PROFILE_$(basetarget).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
+		$(GCOV_PROFILE_$(basetarget).o)$(call eval_vars,GCOV_PROFILE_,$(src))$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
 		$(CFLAGS_GCOV))
 endif
 
-- 
2.42.0

