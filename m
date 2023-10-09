Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BD7BDC88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376578AbjJIMmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376527AbjJIMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:42:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8EAF;
        Mon,  9 Oct 2023 05:42:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB14C433CC;
        Mon,  9 Oct 2023 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696855349;
        bh=1y3Z0ybgVnT139Ea2wGLabPi6t4btQ4exj7ZMYEX5yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=du9iK3pJkdkc5FcCSV4lnHvPu/UQlv8Sp1yRjQrZhUcF4+cgF0RwU5rF2smqKjP8h
         prIZCh7eRKNP5Qr0ZKV451N1jqgeIwfmTYEHWcAwCYKf03yfBMMjMR0rvoDH7Bku6b
         xpWxasXqFR9DHlVd3EcECXwISuL7wvQKpIEjZ8cxTJQ67f03wdWCI1ZGEB8SGJKCyi
         1KVpiu4JWu2yjFz7RiAeyBC3ScedizRNbaG1zKgw4HPX2UqaKtJnJbFnxPvqIvVlKT
         bhe6QZyXRDuYTShBkZ4aSLMbrMyPn5/E/2eA4twgxeT39HZcIccyL7iP9S0OVIUSUv
         hmvKvPKSy3P4A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: [PATCH 4/5] kbuild: unify vdso_install rules
Date:   Mon,  9 Oct 2023 21:42:09 +0900
Message-Id: <20231009124210.1064021-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
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

Currently, there is no standard implementation for vdso_install,
leading to various issues:

 1. Code duplication

    Many architectures duplicate similar code just for copying files
    to the install destination.

    Some architectures (arm, sparc, x86) create build-id symlinks,
    introducing more code duplication.

 2. Accidental updates of in-tree build artifacts

    The vdso_install rule depends on the vdso files to install.
    It may update in-tree build artifacts. This can be problematic,
    as explained in commit 19514fc665ff ("arm, kbuild: make
    "make install" not depend on vmlinux").

 3. Broken code in some architectures

    Makefile code is often copied from one architecture to another
    without proper adaptation or testing.

    The previous commits removed broken code from csky, UML, and parisc.

    Another issue is that 'make vdso_install' for ARCH=s390 installs
    vdso64, but not vdso32.

To address these problems, this commit introduces the generic vdso_install.

Architectures that support vdso_install need to define vdso-install-y
in arch/*/Makefile.

vdso-install-y lists the files to install. For example, arch/x86/Makefile
looks like this:

  vdso-install-$(CONFIG_X86_64)           += arch/x86/entry/vdso/vdso64.so.dbg
  vdso-install-$(CONFIG_X86_X32_ABI)      += arch/x86/entry/vdso/vdsox32.so.dbg
  vdso-install-$(CONFIG_X86_32)           += arch/x86/entry/vdso/vdso32.so.dbg
  vdso-install-$(CONFIG_IA32_EMULATION)   += arch/x86/entry/vdso/vdso32.so.dbg

These files will be installed to $(MODLIB)/vdso/ with the .dbg suffix,
if exists, stripped away.

vdso-install-y can optionally take the second field after the colon
separator. This is needed because some architectures install vdso
files as a different base name.

The following is a snippet from arch/arm64/Makefile.

  vdso-install-$(CONFIG_COMPAT_VDSO)      += arch/arm64/kernel/vdso32/vdso.so.dbg:vdso32.so

This will rename vdso.so.dbg to vdso32.so during installation. If such
architectures change their implementation so that the file names match,
this workaround will go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                               |  9 ++++++
 arch/arm/Makefile                      |  7 +---
 arch/arm/vdso/Makefile                 | 25 --------------
 arch/arm64/Makefile                    |  9 ++----
 arch/arm64/kernel/vdso/Makefile        | 10 ------
 arch/arm64/kernel/vdso32/Makefile      | 10 ------
 arch/loongarch/Makefile                |  4 +--
 arch/loongarch/vdso/Makefile           | 10 ------
 arch/riscv/Makefile                    |  9 ++----
 arch/riscv/kernel/compat_vdso/Makefile | 10 ------
 arch/riscv/kernel/vdso/Makefile        | 10 ------
 arch/s390/Makefile                     |  6 ++--
 arch/s390/kernel/vdso32/Makefile       | 10 ------
 arch/s390/kernel/vdso64/Makefile       | 10 ------
 arch/sparc/Makefile                    |  5 ++-
 arch/sparc/vdso/Makefile               | 27 ----------------
 arch/x86/Makefile                      |  7 ++--
 arch/x86/entry/vdso/Makefile           | 27 ----------------
 scripts/Makefile.vdsoinst              | 45 ++++++++++++++++++++++++++
 19 files changed, 71 insertions(+), 179 deletions(-)
 create mode 100644 scripts/Makefile.vdsoinst

diff --git a/Makefile b/Makefile
index 373649c7374e..2170d56630e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1317,6 +1317,14 @@ scripts_unifdef: scripts_basic
 quiet_cmd_install = INSTALL $(INSTALL_PATH)
       cmd_install = unset sub_make_done; $(srctree)/scripts/install.sh
 
+# ---------------------------------------------------------------------------
+# vDSO install
+
+PHONY += vdso_install
+vdso_install: export INSTALL_FILES = $(vdso-install-y)
+vdso_install:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vdsoinst
+
 # ---------------------------------------------------------------------------
 # Tools
 
@@ -1560,6 +1568,7 @@ help:
 	@echo  '* vmlinux	  - Build the bare kernel'
 	@echo  '* modules	  - Build all modules'
 	@echo  '  modules_install - Install all modules to INSTALL_MOD_PATH (default: /)'
+	@echo  '  vdso_install    - Install unstripped vdso to INSTALL_MOD_PATH (default: /)'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'
 	@echo  '  dir/file.ll     - Build the LLVM assembly file'
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 547e5856eaa0..5ba42f69f8ce 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -304,11 +304,7 @@ $(INSTALL_TARGETS): KBUILD_IMAGE = $(boot)/$(patsubst %install,%Image,$@)
 $(INSTALL_TARGETS):
 	$(call cmd,install)
 
-PHONY += vdso_install
-vdso_install:
-ifeq ($(CONFIG_VDSO),y)
-	$(Q)$(MAKE) $(build)=arch/arm/vdso $@
-endif
+vdso-install-$(CONFIG_VDSO) += arch/arm/vdso/vdso.so.dbg
 
 # My testing targets (bypasses dependencies)
 bp:;	$(Q)$(MAKE) $(build)=$(boot) $(boot)/bootpImage
@@ -331,7 +327,6 @@ define archhelp
   echo  '                  Install using (your) ~/bin/$(INSTALLKERNEL) or'
   echo  '                  (distribution) /sbin/$(INSTALLKERNEL) or'
   echo  '                  install to $$(INSTALL_PATH) and run lilo'
-  echo  '  vdso_install  - Install unstripped vdso.so to $$(INSTALL_MOD_PATH)/vdso'
   echo
   echo  '  multi_v7_lpae_defconfig     - multi_v7_defconfig with CONFIG_ARM_LPAE enabled'
 endef
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 515ca33b854c..d761bd2e2f40 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -63,28 +63,3 @@ quiet_cmd_vdsold_and_vdso_check = LD      $@
 
 quiet_cmd_vdsomunge = MUNGE   $@
       cmd_vdsomunge = $(objtree)/$(obj)/vdsomunge $< $@
-
-#
-# Install the unstripped copy of vdso.so.dbg.  If our toolchain
-# supports build-id, install .build-id links as well.
-#
-# Cribbed from arch/x86/vdso/Makefile.
-#
-quiet_cmd_vdso_install = INSTALL $<
-define cmd_vdso_install
-	cp $< "$(MODLIB)/vdso/vdso.so"; \
-	if readelf -n $< | grep -q 'Build ID'; then \
-	  buildid=`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build ID: \(.*\)$$/\1/'`; \
-	  first=`echo $$buildid | cut -b-2`; \
-	  last=`echo $$buildid | cut -b3-`; \
-	  mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
-	  ln -sf "../../vdso.so" "$(MODLIB)/vdso/.build-id/$$first/$$last.debug"; \
-	fi
-endef
-
-$(MODLIB)/vdso: FORCE
-	@mkdir -p $(MODLIB)/vdso
-
-PHONY += vdso_install
-vdso_install: $(obj)/vdso.so.dbg $(MODLIB)/vdso
-	$(call cmd,vdso_install)
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2d49aea0ff67..4bd85cc0d32b 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -169,12 +169,6 @@ install: KBUILD_IMAGE := $(boot)/Image
 install zinstall:
 	$(call cmd,install)
 
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
-	$(if $(CONFIG_COMPAT_VDSO), \
-		$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 $@)
-
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm64/tools kapi
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
@@ -205,6 +199,9 @@ ifdef CONFIG_COMPAT_VDSO
 endif
 endif
 
+vdso-install-y				+= arch/arm64/kernel/vdso/vdso.so.dbg
+vdso-install-$(CONFIG_COMPAT_VDSO)	+= arch/arm64/kernel/vdso32/vdso.so.dbg:vdso32.so
+
 include $(srctree)/scripts/Makefile.defconf
 
 PHONY += virtconfig
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index fe7a53c6781f..8818287f1095 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -78,13 +78,3 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 # Actual build commands
 quiet_cmd_vdsold_and_vdso_check = LD      $@
       cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
-
-# Install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso.so: $(obj)/vdso.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso.so
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 2f73e5bca213..1f911a76c5af 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -172,13 +172,3 @@ gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 # The AArch64 nm should be able to read an AArch32 binary
       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
-
-# Install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL32 $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
-
-vdso.so: $(obj)/vdso.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso.so
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index fb0fada43197..b86f2ff31659 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -136,9 +136,7 @@ vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/loongarch/vdso include/generated/vdso-offsets.h
 endif
 
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/loongarch/vdso $@
+vdso-install-y += arch/loongarch/vdso/vdso.so.dbg
 
 all:	$(notdir $(KBUILD_IMAGE))
 
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 5c97d1463328..c74c9921304f 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -83,13 +83,3 @@ $(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
 obj-y += vdso.o
 
 $(obj)/vdso.o : $(obj)/vdso.so
-
-# install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso.so: $(obj)/vdso.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso.so
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 1329e060c548..18a47b4d6795 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -131,12 +131,6 @@ endif
 libs-y += arch/riscv/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
-	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
-		$(build)=arch/riscv/kernel/compat_vdso compat_$@)
-
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
@@ -148,6 +142,9 @@ vdso_prepare: prepare0
 endif
 endif
 
+vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
+vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
+
 ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index b86e5e2c3aea..62fa393b2eb2 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -76,13 +76,3 @@ quiet_cmd_compat_vdsold = VDSOLD  $@
 # actual build commands
 quiet_cmd_compat_vdsoas = VDSOAS $@
       cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<
-
-# install commands for the unstripped file
-quiet_cmd_compat_vdso_install = INSTALL $@
-      cmd_compat_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/compat_vdso/$@
-
-compat_vdso.so: $(obj)/compat_vdso.so.dbg
-	@mkdir -p $(MODLIB)/compat_vdso
-	$(call cmd,compat_vdso_install)
-
-compat_vdso_install: compat_vdso.so
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 6b1dba11bf6d..e8aa7c380007 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -73,13 +73,3 @@ quiet_cmd_vdsold = VDSOLD  $@
       cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp
-
-# install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso.so: $(obj)/vdso.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso.so
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index a53a36ee0731..73873e451686 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -138,9 +138,6 @@ bzImage: vmlinux
 zfcpdump:
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/$(ARCH)/kernel/vdso64 $@
-
 archheaders:
 	$(Q)$(MAKE) $(build)=$(syscalls) uapi
 
@@ -160,6 +157,9 @@ vdso_prepare: prepare0
 	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
 		$(build)=arch/s390/kernel/vdso32 include/generated/vdso32-offsets.h)
 
+vdso-install-y			+= arch/s390/kernel/vdso64/vdso64.so.dbg
+vdso-install-$(CONFIG_COMPAT)	+= arch/s390/kernel/vdso32/vdso32.so.dbg
+
 ifdef CONFIG_EXPOLINE_EXTERN
 modules_prepare: expoline_prepare
 expoline_prepare: scripts
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 23e868b79a6c..caec7db6f966 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -61,16 +61,6 @@ quiet_cmd_vdso32as = VDSO32A $@
 quiet_cmd_vdso32cc = VDSO32C $@
       cmd_vdso32cc = $(CC) $(c_flags) -c -o $@ $<
 
-# install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso32.so: $(obj)/vdso32.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso32.so
-
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index fc1c6ff8178f..e3c9085f8fa7 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -70,16 +70,6 @@ quiet_cmd_vdso64as = VDSO64A $@
 quiet_cmd_vdso64cc = VDSO64C $@
       cmd_vdso64cc = $(CC) $(c_flags) -c -o $@ $<
 
-# install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso64.so: $(obj)/vdso64.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso64.so
-
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 7417345c6639..5f6035936131 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -76,9 +76,8 @@ install:
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/sparc/kernel/syscalls all
 
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/sparc/vdso $@
+vdso-install-$(CONFIG_SPARC64)	+= arch/sparc/vdso/vdso64.so.dbg
+vdso-install-$(CONFIG_COMPAT)	+= arch/sparc/vdso/vdso32.so.dbg
 
 # This is the image used for packaging
 KBUILD_IMAGE := $(boot)/zImage
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 77d7b9032158..d08c3a0443f3 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -116,30 +116,3 @@ quiet_cmd_vdso = VDSO    $@
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic
 GCOV_PROFILE := n
-
-#
-# Install the unstripped copies of vdso*.so.  If our toolchain supports
-# build-id, install .build-id links as well.
-#
-quiet_cmd_vdso_install = INSTALL $(@:install_%=%)
-define cmd_vdso_install
-	cp $< "$(MODLIB)/vdso/$(@:install_%=%)"; \
-	if readelf -n $< |grep -q 'Build ID'; then \
-	  buildid=`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build ID: \(.*\)$$/\1/'`; \
-	  first=`echo $$buildid | cut -b-2`; \
-	  last=`echo $$buildid | cut -b3-`; \
-	  mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
-	  ln -sf "../../$(@:install_%=%)" "$(MODLIB)/vdso/.build-id/$$first/$$last.debug"; \
-	fi
-endef
-
-vdso_img_insttargets := $(vdso_img_sodbg:%.dbg=install_%)
-
-$(MODLIB)/vdso: FORCE
-	@mkdir -p $(MODLIB)/vdso
-
-$(vdso_img_insttargets): install_%: $(obj)/%.dbg $(MODLIB)/vdso FORCE
-	$(call cmd,vdso_install)
-
-PHONY += vdso_install $(vdso_img_insttargets)
-vdso_install: $(vdso_img_insttargets) FORCE
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5bfe5caaa444..3ff53a2d4ff0 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -291,9 +291,10 @@ PHONY += install
 install:
 	$(call cmd,install)
 
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/x86/entry/vdso $@
+vdso-install-$(CONFIG_X86_64)		+= arch/x86/entry/vdso/vdso64.so.dbg
+vdso-install-$(CONFIG_X86_X32_ABI)	+= arch/x86/entry/vdso/vdsox32.so.dbg
+vdso-install-$(CONFIG_X86_32)		+= arch/x86/entry/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_IA32_EMULATION)	+= arch/x86/entry/vdso/vdso32.so.dbg
 
 archprepare: checkbin
 checkbin:
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 6a1821bd7d5e..c197efd82922 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -190,31 +190,4 @@ GCOV_PROFILE := n
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
 
-#
-# Install the unstripped copies of vdso*.so.  If our toolchain supports
-# build-id, install .build-id links as well.
-#
-quiet_cmd_vdso_install = INSTALL $(@:install_%=%)
-define cmd_vdso_install
-	cp $< "$(MODLIB)/vdso/$(@:install_%=%)"; \
-	if readelf -n $< |grep -q 'Build ID'; then \
-	  buildid=`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build ID: \(.*\)$$/\1/'`; \
-	  first=`echo $$buildid | cut -b-2`; \
-	  last=`echo $$buildid | cut -b3-`; \
-	  mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
-	  ln -sf "../../$(@:install_%=%)" "$(MODLIB)/vdso/.build-id/$$first/$$last.debug"; \
-	fi
-endef
-
-vdso_img_insttargets := $(vdso_img_sodbg:%.dbg=install_%)
-
-$(MODLIB)/vdso: FORCE
-	@mkdir -p $(MODLIB)/vdso
-
-$(vdso_img_insttargets): install_%: $(obj)/%.dbg $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-PHONY += vdso_install $(vdso_img_insttargets)
-vdso_install: $(vdso_img_insttargets)
-
 clean-files := vdso32.so vdso32.so.dbg vdso64* vdso-image-*.c vdsox32.so*
diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
new file mode 100644
index 000000000000..1022d9fdd976
--- /dev/null
+++ b/scripts/Makefile.vdsoinst
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# ==========================================================================
+# Install unstripped copies of vDSO
+# ==========================================================================
+
+PHONY := __default
+__default:
+	@:
+
+include $(srctree)/scripts/Kbuild.include
+
+install-dir := $(MODLIB)/vdso
+
+define gen_install_rules
+
+src := $$(firstword $$(subst :,$(space),$(1)))
+dest := $(install-dir)/$$(or $$(word 2,$$(subst :,$(space),$(1))),$$(patsubst %.dbg,%,$$(notdir $(1))))
+
+__default: $$(dest)
+$$(dest): $$(src) FORCE
+	$$(call cmd,install)
+
+# Some architectures create .build-id symlinks
+ifneq ($(filter arm sparc x86, $(SRCARCH)),)
+link := $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+
+__default: $$(link)
+$$(link): $$(dest) FORCE
+	$$(call cmd,symlink)
+endif
+
+endef
+
+$(foreach x, $(sort $(INSTALL_FILES)), $(eval $(call gen_install_rules,$(x))))
+
+quiet_cmd_install = INSTALL $@
+      cmd_install = mkdir -p $(dir $@); cp $< $@
+
+quiet_cmd_symlink = SYMLINK $@
+      cmd_symlink = mkdir -p $(dir $@); ln -sf --relative $< $@
+
+PHONY += FORCE
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.39.2

