Return-Path: <linux-kernel+bounces-161086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C58B46DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41D51F22548
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606717BA1;
	Sat, 27 Apr 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZFFE+RZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D40BA5E;
	Sat, 27 Apr 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714232014; cv=none; b=Wqh4asrG7iBpdlRVVdb2hC25+Cvex5qRRqreflPll1q3R/fIUmcpA+QP2xrvJY3UD//aAQvN09NhWlhP7wK8QBIaUlZoU3Hpi5MO6IuKrkEJ01/oQa5m7tm80IRx4Bl4QH7B2DRp8SXPStNSLNk+mM0o8toattcAnZhRs3qcZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714232014; c=relaxed/simple;
	bh=y/X5XzE38pKMNGYqF0kWZp87CwlmRX4eyAcALVQZaU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM7gp6ONptKf0oVNuqNOe2daPkKBPPyHWXlV9TmaUnKgQ0wqPPzpDN6GmQma0fZJrUWDm9mOFyWExgDEYQgHKfSq7YlZBQZDR0D7/Ahsc2zGgQ3maHNAzfR16Xy6FYqsis+aEdELkJVpv/ajF49Ofm4SnTEUi6Ef4nCG7MiCyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZFFE+RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E532EC2BD10;
	Sat, 27 Apr 2024 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714232014;
	bh=y/X5XzE38pKMNGYqF0kWZp87CwlmRX4eyAcALVQZaU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZFFE+RZYRkrTy+tY+nQHSdBURQJRvR2Ma5uXYg3kg38XYKrOwRPM6jZJOtdW8vws
	 N9dYBhtbLqf24pOjH/LiJGadHErf2idqLdUIgJwBI1IN9KfqIlaaJLNZrCgVxfGpmT
	 RMApeChLxmZTYjfHbySVUCTjO1NumcCK/Ahzm7f1Uxo0oP0w9riOCzejc7o8bcWGK6
	 PswSnyGhiZlQ9hBz1Hl6/cU4nhfpEIFr4QZwXmtb0u7ih4fwfQr/TbeYF9ykKjjFAN
	 hgLb/FuufS7g+I0EvasrYc2P2zyYZnHj/H8sVPqLucA0pMUn76QMef5yLl08j25aU0
	 xGbgCUjup0orQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] kbuild: add 'private' to target-specific variables
Date: Sun, 28 Apr 2024 00:32:53 +0900
Message-Id: <20240427153253.2809911-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240427153253.2809911-1-masahiroy@kernel.org>
References: <20240427153253.2809911-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, Kbuild produces inconsistent results in some cases.

You can do an interesting experiment using the --shuffle option, which
is supported by GNU Make 4.4 or later.

Set CONFIG_KVM_INTEL=y and CONFIG_KVM_AMD=m (or vice versa), and repeat
incremental builds w/wo --shuffle=reverse.

  $ make
    [ snip ]
    CC      arch/x86/kvm/kvm-asm-offsets.s

  $ make --shuffle=reverse
    [ snip ]
    CC [M]  arch/x86/kvm/kvm-asm-offsets.s

  $ make
    [ snip ]
    CC      arch/x86/kvm/kvm-asm-offsets.s

arch/x86/kvm/kvm-asm-offsets.s is rebuilt every time w/wo the [M] marker.

arch/x86/kvm/kvm-asm-offsets.s is built as built-in when it is built as
a prerequisite of arch/x86/kvm/kvm-intel.o, which is built-in.

arch/x86/kvm/kvm-asm-offsets.s is built as modular when it is built as
a prerequisite of arch/x86/kvm/kvm-amd.o, which is a module.

Another odd example is single target builds.

When CONFIG_LKDTM=m, drivers/misc/lkdtm/rodata.o can be built as
built-in or modular, depending on how it is built.

  $ make drivers/misc/lkdtm/lkdtm.o
    [ snip ]
    CC [M]  drivers/misc/lkdtm/rodata.o

  $ make drivers/misc/lkdtm/rodata.o
    [ snip ]
    CC      drivers/misc/lkdtm/rodata.o

drivers/misc/lkdtm/rodata.o is built as modular when it is built as a
prerequisite of another, but built as built-in when it is a final
target.

The same thing happens to drivers/memory/emif-asm-offsets.s when
CONFIG_TI_EMIF_SRAM=m.

  $ make drivers/memory/ti-emif-sram.o
    [ snip ]
    CC [M]  drivers/memory/emif-asm-offsets.s

  $ make drivers/memory/emif-asm-offsets.s
    [ snip ]
    CC      drivers/memory/emif-asm-offsets.s

This is because the part-of-module=y flag defined for the modules is
inherited by its prerequisites.

Target-specific variables are likely intended only for local use.
This commit adds 'private' to them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 8 ++++----
 scripts/Makefile.build | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 62557fabfee5..25dcc7ead330 100644
--- a/Makefile
+++ b/Makefile
@@ -1255,8 +1255,8 @@ define filechk_version.h
 	echo \#define LINUX_VERSION_SUBLEVEL $(SUBLEVEL)
 endef
 
-$(version_h): PATCHLEVEL := $(or $(PATCHLEVEL), 0)
-$(version_h): SUBLEVEL := $(or $(SUBLEVEL), 0)
+$(version_h): private PATCHLEVEL := $(or $(PATCHLEVEL), 0)
+$(version_h): private SUBLEVEL := $(or $(SUBLEVEL), 0)
 $(version_h): FORCE
 	$(call filechk,version.h)
 
@@ -1500,7 +1500,7 @@ MRPROPER_FILES += include/config include/generated          \
 
 # clean - Delete most, but leave enough to build external modules
 #
-clean: rm-files := $(CLEAN_FILES)
+clean: private rm-files := $(CLEAN_FILES)
 
 PHONY += archclean vmlinuxclean
 
@@ -1512,7 +1512,7 @@ clean: archclean vmlinuxclean resolve_btfids_clean
 
 # mrproper - Delete all generated files, including .config
 #
-mrproper: rm-files := $(MRPROPER_FILES)
+mrproper: private rm-files := $(MRPROPER_FILES)
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
 PHONY += $(mrproper-dirs) mrproper
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 43b71c3d0ff6..c9c07a6144eb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -216,7 +216,7 @@ endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
 is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(target-stem).o)$(OBJECT_FILES_NON_STANDARD)n),y)
 
-$(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
+$(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
 
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
@@ -437,8 +437,8 @@ define rule_ld_multi_m
 	$(call cmd,gen_objtooldep)
 endef
 
-$(multi-obj-m): objtool-enabled := $(delay-objtool)
-$(multi-obj-m): part-of-module := y
+$(multi-obj-m): private objtool-enabled := $(delay-objtool)
+$(multi-obj-m): private part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed_rule,ld_multi_m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
-- 
2.40.1


