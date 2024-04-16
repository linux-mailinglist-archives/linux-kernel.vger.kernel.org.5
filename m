Return-Path: <linux-kernel+bounces-146779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D911E8A6ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A179282679
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100B12E1E4;
	Tue, 16 Apr 2024 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns2kEsxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C12DD92;
	Tue, 16 Apr 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269963; cv=none; b=Kvx2ROVKKjI6uLG4wRJjhYFHrgUlBb0KEU7kkL2LwcmmXw1KBxDvpZ84dGvra2U0suzctySkay+zEFQWPSum9/ZcBlpiOK5Mxos2s3PAzKWdaC0USS4rQRlnZapyMA6x/8j03iNWH9WPGgSw5t6aRNeqm9i1iIf+/vkEERkMdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269963; c=relaxed/simple;
	bh=qFxLfOC6BM/8sXva3vqZ6SV10KRZ7qiqW8jMoCoBk1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGmAKOlz5mFqAYy0IgyL2BdhYm7TGrF7CSKDpK6XAw7udXnRcrVC0v5OWexEcx6FKRoWu2pHawxjPEaW+6CyYMyDHNjE58iUMMHa1MmDOUDbR9Z9dfo9yKEPdUAZ7pdAGtQ+DlDlFkDMIIcBZluyloqcHDYZl2K5fQVFu/+mKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns2kEsxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB26C113CE;
	Tue, 16 Apr 2024 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269962;
	bh=qFxLfOC6BM/8sXva3vqZ6SV10KRZ7qiqW8jMoCoBk1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns2kEsxf7zxFuOPdt+V2C3u6gxJMBWHeP20xre1TQ9Wqr/Oe3JQoScJyKGKxivEJX
	 4aPECZFRbLcRyWOX0ct1kL0eIIJ0z6jTgIaG5+cv91XBmooCpZLf1NAhS+FMvwKhs2
	 pd9SC/cveK61yvpbyItvMQtba/Haj7woPgMsiX2Ngw2QEzbLw06Pxmki0leXpIkU0Z
	 42IW4bnPfU3mcbbCXYRf9pAvHs7qZi6H4Q/fOGsoP0jMYZrvTTxmaPiPnABbpUwTK6
	 FivezR6DVf/Mxd2VgwXtw0+MfzCcVUs5rpfHAD+2JbfHUJz8Zmalxb1InhBv0m3g6T
	 6yNlJRk5Z8OBA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/4] kbuild: use $(src) instead of $(srctree)/$(src) for source directory
Date: Tue, 16 Apr 2024 21:18:38 +0900
Message-Id: <20240416121838.95427-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416121838.95427-1-masahiroy@kernel.org>
References: <20240416121838.95427-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kbuild conventionally uses $(obj)/ for generated files, and $(src)/ for
checked-in source files. It is merely a convention without any functional
difference. In fact, $(obj) and $(src) are exactly the same, as defined
in scripts/Makefile.build:

    src := $(obj)

When the kernel is built in a separate output directory, $(src) does
not match the directory in the source tree. It still works because the
top Makefile sets VPATH to $(srctree). However, VPATH does not cover
all cases. There are many places where the exact path to the source
directory is needed. For example, when adding a header search path for
local headers, it is typical to pass -I$(srctree)/$(src) to the compiler.

However, it introduces inconsistency between upstream Makefiles and
downstream Makefiles; when the source directory path is needed,
$(srctree)/$(src) is used in the upstream kernel, while $(src) is used
in external modules.

To resolve the distortion, this commit changes the semantics of $(src)
so that it always points to the directory in the source tree.

Going forward, the variables used in Makefiles will work as follows:

  $(obj)     - directory in the object tree
  $(src)     - directory in the source tree  (changed by this commit!)
  $(objtree) - the top of the kernel object tree
  $(srctree) - the top of the kernel source tree

This is a tweewide Makefile conversion for replacing $(srctree)/$(src)
with $(src).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/Makefile                             |  8 ++++----
 Documentation/devicetree/bindings/Makefile         | 10 +++++-----
 Documentation/kbuild/makefiles.rst                 | 12 ++++++------
 Makefile                                           |  7 +++++++
 arch/arc/boot/dts/Makefile                         |  3 +--
 arch/arm/Kbuild                                    |  2 +-
 arch/arm/boot/Makefile                             |  3 +--
 arch/arm/mach-s3c/Makefile                         |  2 +-
 arch/arm/plat-orion/Makefile                       |  2 +-
 arch/arm/tools/Makefile                            |  2 +-
 arch/arm64/kernel/vdso/Makefile                    |  2 +-
 arch/arm64/kvm/Makefile                            |  4 ++--
 arch/arm64/kvm/hyp/Makefile                        |  2 +-
 arch/csky/boot/dts/Makefile                        |  4 +---
 arch/csky/kernel/vdso/Makefile                     |  2 +-
 arch/loongarch/vdso/Makefile                       |  2 +-
 arch/mips/kernel/syscalls/Makefile                 |  2 +-
 arch/mips/vdso/Makefile                            |  4 ++--
 arch/nios2/boot/dts/Makefile                       |  3 +--
 arch/parisc/kernel/vdso32/Makefile                 |  2 +-
 arch/parisc/kernel/vdso64/Makefile                 |  2 +-
 arch/powerpc/boot/Makefile                         |  6 +++---
 arch/powerpc/boot/dts/Makefile                     |  3 +--
 arch/powerpc/boot/dts/fsl/Makefile                 |  3 +--
 arch/powerpc/kernel/vdso/Makefile                  |  4 ++--
 arch/riscv/kernel/compat_vdso/Makefile             |  2 +-
 arch/riscv/kernel/vdso/Makefile                    |  2 +-
 arch/riscv/kvm/Makefile                            |  2 +-
 arch/s390/kernel/syscalls/Makefile                 |  4 ++--
 arch/s390/kernel/vdso32/Makefile                   |  2 +-
 arch/s390/kernel/vdso64/Makefile                   |  2 +-
 arch/sparc/vdso/Makefile                           |  2 +-
 arch/um/kernel/Makefile                            |  2 +-
 arch/x86/boot/Makefile                             |  2 +-
 arch/x86/entry/vdso/Makefile                       |  2 +-
 arch/x86/kernel/Makefile                           |  2 +-
 arch/x86/kernel/cpu/Makefile                       |  2 +-
 arch/x86/mm/Makefile                               |  2 +-
 arch/x86/um/vdso/Makefile                          |  2 +-
 arch/xtensa/boot/dts/Makefile                      |  3 +--
 certs/Makefile                                     |  4 ++--
 drivers/Makefile                                   |  5 -----
 drivers/crypto/intel/qat/qat_420xx/Makefile        |  2 +-
 drivers/crypto/intel/qat/qat_4xxx/Makefile         |  2 +-
 drivers/crypto/intel/qat/qat_c3xxx/Makefile        |  2 +-
 drivers/crypto/intel/qat/qat_c3xxxvf/Makefile      |  2 +-
 drivers/crypto/intel/qat/qat_c62x/Makefile         |  2 +-
 drivers/crypto/intel/qat/qat_c62xvf/Makefile       |  2 +-
 drivers/crypto/intel/qat/qat_dh895xcc/Makefile     |  2 +-
 drivers/crypto/intel/qat/qat_dh895xccvf/Makefile   |  2 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |  2 +-
 drivers/gpu/drm/arm/display/komeda/Makefile        |  4 ++--
 drivers/gpu/drm/i915/Makefile                      |  4 ++--
 drivers/gpu/drm/msm/Makefile                       |  8 ++++----
 drivers/gpu/drm/nouveau/Kbuild                     | 10 ++++------
 drivers/gpu/drm/xe/Makefile                        | 10 +++++-----
 drivers/hid/amd-sfh-hid/Makefile                   |  2 +-
 drivers/hid/intel-ish-hid/Makefile                 |  2 +-
 drivers/md/dm-vdo/Makefile                         |  2 +-
 drivers/net/ethernet/chelsio/libcxgb/Makefile      |  2 +-
 drivers/net/ethernet/fungible/funeth/Makefile      |  2 +-
 drivers/net/ethernet/hisilicon/hns3/Makefile       |  2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/Makefile  |  4 ++--
 .../broadcom/brcm80211/brcmfmac/bca/Makefile       |  6 +++---
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile       |  6 +++---
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile       |  6 +++---
 .../wireless/broadcom/brcm80211/brcmsmac/Makefile  |  6 +++---
 .../wireless/broadcom/brcm80211/brcmutil/Makefile  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/Makefile    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/Makefile    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile    |  2 +-
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |  2 +-
 .../net/wireless/realtek/rtl818x/rtl8180/Makefile  |  2 +-
 .../net/wireless/realtek/rtl818x/rtl8187/Makefile  |  2 +-
 drivers/scsi/aic7xxx/Makefile                      | 12 ++++++------
 drivers/staging/rtl8723bs/Makefile                 |  2 +-
 fs/iomap/Makefile                                  |  2 +-
 fs/unicode/Makefile                                | 14 +++++++-------
 fs/xfs/Makefile                                    |  4 ++--
 init/Makefile                                      |  2 +-
 lib/Makefile                                       |  6 +++---
 lib/raid6/Makefile                                 |  2 +-
 net/wireless/Makefile                              |  2 +-
 rust/Makefile                                      |  6 +++---
 samples/bpf/Makefile                               |  2 +-
 samples/hid/Makefile                               |  2 +-
 scripts/Kbuild.include                             |  3 +--
 scripts/Makefile.asm-generic                       |  6 +++---
 scripts/Makefile.build                             |  2 +-
 scripts/Makefile.clean                             |  2 +-
 scripts/Makefile.lib                               | 10 +++++-----
 scripts/Makefile.modpost                           |  2 +-
 scripts/dtc/Makefile                               |  6 +++---
 scripts/gdb/linux/Makefile                         |  2 +-
 scripts/genksyms/Makefile                          |  4 ++--
 scripts/kconfig/Makefile                           |  8 ++++----
 security/tomoyo/Makefile                           |  2 +-
 usr/Makefile                                       |  2 +-
 usr/include/Makefile                               |  2 +-
 99 files changed, 172 insertions(+), 181 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b68f8c816897..66d15fff2089 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,22 +76,22 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 #    * dest folder relative to $(BUILDDIR) and
 #    * cache folder relative to $(BUILDDIR)/.doctrees
 # $4 dest subfolder e.g. "man" for man pages at userspace-api/media/man
-# $5 reST source folder relative to $(srctree)/$(src),
+# $5 reST source folder relative to $(src),
 #    e.g. "userspace-api/media" for the linux-tv book-set at ./Documentation/userspace-api/media
 
 quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
       cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/userspace-api/media $2 && \
 	PYTHONDONTWRITEBYTECODE=1 \
-	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
+	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(src)/$5/$(SPHINX_CONF)) \
 	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
 	$(CONFIG_SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
 	$(SPHINXBUILD) \
 	-b $2 \
-	-c $(abspath $(srctree)/$(src)) \
+	-c $(abspath $(src)) \
 	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
 	-D version=$(KERNELVERSION) -D release=$(KERNELRELEASE) \
 	$(ALLSPHINXOPTS) \
-	$(abspath $(srctree)/$(src)/$5) \
+	$(abspath $(src)/$5) \
 	$(abspath $(BUILDDIR)/$3/$4) && \
 	if [ "x$(DOCS_CSS)" != "x" ]; then \
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 5e08e3a6a97b..676308cb3927 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -25,7 +25,7 @@ quiet_cmd_extract_ex = DTEX    $@
 $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 	$(call if_changed,extract_ex)
 
-find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
+find_all_cmd = find $(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' \)
 
 find_cmd = $(find_all_cmd) | \
@@ -37,11 +37,11 @@ CHK_DT_DOCS := $(shell $(find_cmd))
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) \
-		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+		     $(DT_SCHEMA_LINT) -f parsable -c $(src)/.yamllint >&2) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = ($(find_cmd) | \
-                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
+                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(src)) || true
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
@@ -68,8 +68,8 @@ $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version
 	$(call if_changed_rule,chkdt)
 
 always-y += processed-schema.json
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst $(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index ad118b7a1806..991ce6081e35 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -346,7 +346,7 @@ ccflags-y, asflags-y and ldflags-y
   Example::
 
     #arch/cris/boot/compressed/Makefile
-    ldflags-y += -T $(srctree)/$(src)/decompress_$(arch-y).lds
+    ldflags-y += -T $(src)/decompress_$(arch-y).lds
 
 subdir-ccflags-y, subdir-asflags-y
   The two flags listed above are similar to ccflags-y and asflags-y.
@@ -426,14 +426,14 @@ path to prerequisite files and target files.
 Two variables are used when defining custom rules:
 
 $(src)
-  $(src) is a relative path which points to the directory
-  where the Makefile is located. Always use $(src) when
+  $(src) is the directory where the Makefile is located. Always use $(src) when
   referring to files located in the src tree.
 
 $(obj)
-  $(obj) is a relative path which points to the directory
-  where the target is saved. Always use $(obj) when
-  referring to generated files.
+  $(obj) is the directory where the target is saved. Always use $(obj) when
+  referring to generated files. Use $(obj) for pattern rules that need to work
+  for both generated files and real sources (VPATH will help to find the
+  prerequisites not only in the object tree but also in the source tree).
 
   Example::
 
diff --git a/Makefile b/Makefile
index 59d8a7f95d0a..3e6263f4a578 100644
--- a/Makefile
+++ b/Makefile
@@ -263,7 +263,14 @@ srctree := $(abs_srctree)
 endif
 
 objtree		:= .
+
+VPATH		:=
+
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
 VPATH		:= $(srctree)
+endif
+endif
 
 export building_out_of_srctree srctree objtree VPATH
 
diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 4237aa5de3a3..48704dfdf75c 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -10,8 +10,7 @@ obj-y   += $(builtindtb-y).dtb.o
 dtb-y := $(builtindtb-y).dtb
 
 # for CONFIG_OF_ALL_DTBS test
-dtstree	:= $(srctree)/$(src)
-dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-	:= $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
 
 # board-specific dtc flags
 DTC_FLAGS_hsdk += --pad 20
diff --git a/arch/arm/Kbuild b/arch/arm/Kbuild
index b506622e7e23..69de6b6243c7 100644
--- a/arch/arm/Kbuild
+++ b/arch/arm/Kbuild
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_FPE_NWFPE)		+= nwfpe/
 # Put arch/arm/fastfpe/ to use this.
-obj-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/fastfpe/))
+obj-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(src)/%,%,$(wildcard $(src)/fastfpe/))
 obj-$(CONFIG_VFP)		+= vfp/
 obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_VDSO)		+= vdso/
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index abd6a2889fd0..ba9b9a802469 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -25,8 +25,7 @@ targets := Image zImage xipImage bootpImage uImage
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
 
-cmd_deflate_xip_data = $(CONFIG_SHELL) -c \
-	'$(srctree)/$(src)/deflate_xip_data.sh $< $@'
+cmd_deflate_xip_data = $(CONFIG_SHELL) -c '$(src)/deflate_xip_data.sh $< $@'
 
 ifeq ($(CONFIG_XIP_DEFLATED_DATA),y)
 quiet_cmd_mkxip = XIPZ    $@
diff --git a/arch/arm/mach-s3c/Makefile b/arch/arm/mach-s3c/Makefile
index 713827bef831..988c49672715 100644
--- a/arch/arm/mach-s3c/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright 2009 Simtec Electronics
 
-include $(srctree)/$(src)/Makefile.s3c64xx
+include $(src)/Makefile.s3c64xx
 
 # Objects we always build independent of SoC choice
 
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 830b0be038c6..e8c7580df8ca 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-y := -I$(srctree)/$(src)/include
+ccflags-y := -I$(src)/include
 
 orion-gpio-$(CONFIG_GPIOLIB)      += gpio.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 81f13bdf32f2..28b6da8ac5f6 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -9,7 +9,7 @@ gen := arch/$(ARCH)/include/generated
 kapi := $(gen)/asm
 uapi := $(gen)/uapi/asm
 syshdr := $(srctree)/scripts/syscallhdr.sh
-sysnr := $(srctree)/$(src)/syscallnr.sh
+sysnr := $(src)/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 syscall := $(src)/syscall.tbl
 
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 8818287f1095..53e86d3bc159 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -68,7 +68,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index c0c050e53157..ab474d444cef 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
-ccflags-y += -I $(srctree)/$(src)
+ccflags-y += -I $(src)
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
@@ -30,7 +30,7 @@ define rule_gen_hyp_constants
 	$(call filechk,offsets,__HYP_CONSTANTS_H__)
 endef
 
-CFLAGS_hyp-constants.o = -I $(srctree)/$(src)/hyp/include
+CFLAGS_hyp-constants.o = -I $(src)/hyp/include
 $(obj)/hyp-constants.s: $(src)/hyp/hyp-constants.c FORCE
 	$(call if_changed_dep,cc_s_c)
 
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index a38dea6186c9..d61e44642f98 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
-incdir := $(srctree)/$(src)/include
+incdir := $(src)/include
 subdir-asflags-y := -I$(incdir)
 subdir-ccflags-y := -I$(incdir)
 
diff --git a/arch/csky/boot/dts/Makefile b/arch/csky/boot/dts/Makefile
index 5f1f55e911ad..aabffc1912e8 100644
--- a/arch/csky/boot/dts/Makefile
+++ b/arch/csky/boot/dts/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-dtstree	:= $(srctree)/$(src)
-
-dtb-y := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-y := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 24a01c22293e..e79a725f5075 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -57,4 +57,4 @@ quiet_cmd_vdsold = VDSOLD  $@
 # Extracts symbol offsets from the VDSO, converting them into an assembly file
 # that contains the same symbols at the same offsets.
 quiet_cmd_so2s = SO2S    $@
-      cmd_so2s = $(NM) -D $< | $(srctree)/$(src)/so2s.sh > $@
+      cmd_so2s = $(NM) -D $< | $(src)/so2s.sh > $@
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 75c6726382c3..cdfc4c793e2c 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -52,7 +52,7 @@ quiet_cmd_vdsoas_o_S = AS       $@
       cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
       cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index e6b21de65cca..56f6f093bb88 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -5,7 +5,7 @@ uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 $(shell mkdir -p $(uapi) $(kapi))
 
 syshdr := $(srctree)/scripts/syscallhdr.sh
-sysnr := $(srctree)/$(src)/syscallnr.sh
+sysnr := $(src)/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index eb56581f6d73..40b839e91806 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -43,8 +43,8 @@ CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
 # config-n32-o32-env.c prepares the environment to build a 32bit vDSO
 # library on a 64bit kernel.
 # Note: Needs to be included before than the generic library.
-CFLAGS_vgettimeofday-o32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
-CFLAGS_vgettimeofday-n32.o = -include $(srctree)/$(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
+CFLAGS_vgettimeofday-o32.o = -include $(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
+CFLAGS_vgettimeofday-n32.o = -include $(src)/config-n32-o32-env.c -include $(c-gettimeofday-y)
 endif
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index e9e31bb40df8..1a2e8996bec7 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -2,5 +2,4 @@
 
 obj-y := $(patsubst %.dts,%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
 
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/Makefile
index 60dc708a0f80..1350d50c6306 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -40,7 +40,7 @@ quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vdso64/Makefile
index 0982f3099ae2..0b1c1cc4c2c7 100644
--- a/arch/parisc/kernel/vdso64/Makefile
+++ b/arch/parisc/kernel/vdso64/Makefile
@@ -40,7 +40,7 @@ quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 968aee2025b8..a0b3b5cc14cd 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -218,7 +218,7 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/empty.c:
 	$(Q)touch $@
 
-$(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
+$(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(src)/%.S
 	$(Q)cp $< $@
 
 clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
@@ -252,9 +252,9 @@ targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a) zImage.lds
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
-dtstree		:= $(srctree)/$(src)/dts
+dtstree		:= $(src)/dts
 
-wrapper		:=$(srctree)/$(src)/wrapper
+wrapper		:= $(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
 			$(wrapper) FORCE
 
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..0cd0d8558b47 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -2,5 +2,4 @@
 
 subdir-y += fsl
 
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index 3bae982641e9..d3ecdf14bc42 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index a14eab366993..7d66b6e07993 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -90,10 +90,10 @@ $(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 # Generate VDSO offsets using helper script
-gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
+gen-vdso32sym := $(src)/gen_vdso32_offsets.sh
 quiet_cmd_vdso32sym = VDSO32SYM $@
       cmd_vdso32sym = $(NM) $< | $(gen-vdso32sym) | LC_ALL=C sort > $@
-gen-vdso64sym := $(srctree)/$(src)/gen_vdso64_offsets.sh
+gen-vdso64sym := $(src)/gen_vdso64_offsets.sh
 quiet_cmd_vdso64sym = VDSO64SYM $@
       cmd_vdso64sym = $(NM) $< | $(gen-vdso64sym) | LC_ALL=C sort > $@
 
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 3df4cb788c1f..362208dfa7ee 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -58,7 +58,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # Generate VDSO offsets using helper script
-gen-compat_vdsosym := $(srctree)/$(src)/gen_compat_vdso_offsets.sh
+gen-compat_vdsosym := $(src)/gen_compat_vdso_offsets.sh
 quiet_cmd_compat_vdsosym = VDSOSYM $@
 	cmd_compat_vdsosym = $(NM) $< | $(gen-compat_vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 272c431ac5b9..25f0ee629971 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -60,7 +60,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index c9646521f113..c2cacfbc06a0 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for RISC-V KVM support
 #
 
-ccflags-y += -I $(srctree)/$(src)
+ccflags-y += -I $(src)
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index fb85e797946d..1bb78b9468e8 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -4,8 +4,8 @@ gen	:= arch/$(ARCH)/include/generated
 kapi	:= $(gen)/asm
 uapi	:= $(gen)/uapi/asm
 
-syscall	:= $(srctree)/$(src)/syscall.tbl
-systbl	:= $(srctree)/$(src)/syscalltbl
+syscall	:= $(src)/syscall.tbl
+systbl	:= $(src)/syscalltbl
 
 gen-y := $(kapi)/syscall_table.h
 kapi-hdrs-y := $(kapi)/unistd_nr.h
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 70e9949c2612..c263b91adfb1 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -62,7 +62,7 @@ quiet_cmd_vdso32cc = VDSO32C $@
       cmd_vdso32cc = $(CC) $(c_flags) -c -o $@ $<
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 2b3617b6d162..9566bed7d5b2 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -72,7 +72,7 @@ quiet_cmd_vdso64cc = VDSO64C $@
       cmd_vdso64cc = $(CC) $(c_flags) -c -o $@ $<
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+gen-vdsosym := $(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 	cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index e8aef2c8ae99..0fe134abbcf1 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -103,7 +103,7 @@ quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
+		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic
 GCOV_PROFILE := n
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 811188be954c..f8567b933ffa 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -47,7 +47,7 @@ $(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
 	$(call if_changed,quote2)
 
 quiet_cmd_mkcapflags = MKCAP   $@
-      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/../../x86/kernel/cpu/mkcapflags.sh $@ $^
+      cmd_mkcapflags = $(CONFIG_SHELL) $(src)/../../x86/kernel/cpu/mkcapflags.sh $@ $^
 
 cpufeature = $(src)/../../x86/include/asm/cpufeatures.h
 vmxfeature = $(src)/../../x86/include/asm/vmxfeatures.h
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3cece19b7473..29cda98c65f8 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -129,7 +129,7 @@ targets += mtools.conf
 # genimage.sh requires bash, but it also has a bunch of other
 # external dependencies.
 quiet_cmd_genimage = GENIMAGE $3
-cmd_genimage = $(BASH) $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
+      cmd_genimage = $(BASH) $(src)/genimage.sh $2 $3 $(obj)/bzImage \
 		$(obj)/mtools.conf '$(FDARGS)' $(FDINITRD)
 
 PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3d64bcc403cf..c003452dba8c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -176,7 +176,7 @@ quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
+		 sh $(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 74077694da7d..8a9fc9ec69d3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -40,7 +40,7 @@ KMSAN_SANITIZE_sev.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
-CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
+CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
 obj-y			+= head$(BITS).o
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index eb4dbcdf41f1..a02bba0ed6b9 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 obj-$(CONFIG_DEBUG_FS)			+= debugfs.o
 
 quiet_cmd_mkcapflags = MKCAP   $@
-      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
+      cmd_mkcapflags = $(CONFIG_SHELL) $(src)/mkcapflags.sh $@ $^
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
 vmxfeature = $(src)/../../include/asm/vmxfeatures.h
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 428048e73bd2..8d3a00e5c528 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -34,7 +34,7 @@ obj-y				+= pat/
 CFLAGS_physaddr.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
-CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
+CFLAGS_fault.o := -I $(src)/../include/asm/trace
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b86d634730b2..2303fa59971c 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -63,7 +63,7 @@ quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(CC) -nostdlib -o $@ \
 		       $(CC_FLAGS_LTO) $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
+		 sh $(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
 GCOV_PROFILE := n
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index 720628c0d8b9..d6408c16d74e 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -10,5 +10,4 @@
 obj-$(CONFIG_OF) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
 
 # for CONFIG_OF_ALL_DTBS test
-dtstree	:= $(srctree)/$(src)
-dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-	:= $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68a..1094e3860c2a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o := -I $(obj)
 quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
       cmd_check_and_copy_blacklist_hash_list = \
 	$(if $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST), \
-	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
+	$(AWK) -f $(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
 	{ cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST); echo $(comma) NULL; } > $@, \
 	echo NULL > $@)
 
@@ -55,7 +55,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
 targets += signing_key.pem
 
 quiet_cmd_copy_x509_config = COPY    $@
-      cmd_copy_x509_config = cat $(srctree)/$(src)/default_x509.genkey > $@
+      cmd_copy_x509_config = cat $(src)/default_x509.genkey > $@
 
 # You can provide your own config file. If not present, copy the default one.
 $(obj)/x509.genkey:
diff --git a/drivers/Makefile b/drivers/Makefile
index 3bf5cab4b451..fe9ceb0d2288 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,11 +6,6 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-# Some driver Makefiles miss $(srctree)/ for include directive.
-ifdef building_out_of_srctree
-MAKEFLAGS += --include-dir=$(srctree)
-endif
-
 obj-y				+= cache/
 obj-y				+= irqchip/
 obj-y				+= bus/
diff --git a/drivers/crypto/intel/qat/qat_420xx/Makefile b/drivers/crypto/intel/qat/qat_420xx/Makefile
index a90fbe00b3c8..45728659fbc4 100644
--- a/drivers/crypto/intel/qat/qat_420xx/Makefile
+++ b/drivers/crypto/intel/qat/qat_420xx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_420XX) += qat_420xx.o
 qat_420xx-objs := adf_drv.o adf_420xx_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_4xxx/Makefile b/drivers/crypto/intel/qat/qat_4xxx/Makefile
index ff9c8b5897ea..9ba202079a22 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/Makefile
+++ b/drivers/crypto/intel/qat/qat_4xxx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_4XXX) += qat_4xxx.o
 qat_4xxx-objs := adf_drv.o adf_4xxx_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_c3xxx/Makefile b/drivers/crypto/intel/qat/qat_c3xxx/Makefile
index 92ef416ccc78..7a06ad519bfc 100644
--- a/drivers/crypto/intel/qat/qat_c3xxx/Makefile
+++ b/drivers/crypto/intel/qat/qat_c3xxx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXX) += qat_c3xxx.o
 qat_c3xxx-objs := adf_drv.o adf_c3xxx_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_c3xxxvf/Makefile b/drivers/crypto/intel/qat/qat_c3xxxvf/Makefile
index b6d76825a92c..7ef633058c4f 100644
--- a/drivers/crypto/intel/qat/qat_c3xxxvf/Makefile
+++ b/drivers/crypto/intel/qat/qat_c3xxxvf/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_C3XXXVF) += qat_c3xxxvf.o
 qat_c3xxxvf-objs := adf_drv.o adf_c3xxxvf_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_c62x/Makefile b/drivers/crypto/intel/qat/qat_c62x/Makefile
index d581f7c87d6c..cc9255b3b198 100644
--- a/drivers/crypto/intel/qat/qat_c62x/Makefile
+++ b/drivers/crypto/intel/qat/qat_c62x/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62X) += qat_c62x.o
 qat_c62x-objs := adf_drv.o adf_c62x_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_c62xvf/Makefile b/drivers/crypto/intel/qat/qat_c62xvf/Makefile
index 446c3d638605..256786662d60 100644
--- a/drivers/crypto/intel/qat/qat_c62xvf/Makefile
+++ b/drivers/crypto/intel/qat/qat_c62xvf/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_C62XVF) += qat_c62xvf.o
 qat_c62xvf-objs := adf_drv.o adf_c62xvf_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/Makefile b/drivers/crypto/intel/qat/qat_dh895xcc/Makefile
index 38d6f8e1624a..cfd3bd757715 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/Makefile
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCC) += qat_dh895xcc.o
 qat_dh895xcc-objs := adf_drv.o adf_dh895xcc_hw_data.o
diff --git a/drivers/crypto/intel/qat/qat_dh895xccvf/Makefile b/drivers/crypto/intel/qat/qat_dh895xccvf/Makefile
index 0153c85ce743..64b54e92b2b4 100644
--- a/drivers/crypto/intel/qat/qat_dh895xccvf/Makefile
+++ b/drivers/crypto/intel/qat/qat_dh895xccvf/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../qat_common
+ccflags-y := -I $(src)/../qat_common
 obj-$(CONFIG_CRYPTO_DEV_QAT_DH895xCCVF) += qat_dh895xccvf.o
 qat_dh895xccvf-objs := adf_drv.o adf_dh895xccvf_hw_data.o
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4536c8ad0e11..e568e89283c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-FULL_AMD_PATH=$(srctree)/$(src)/..
+FULL_AMD_PATH=$(src)/..
 DISPLAY_FOLDER_NAME=display
 FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 
diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
index 1931a7fa1a14..cf5287fcbbc2 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ccflags-y := \
-	-I $(srctree)/$(src)/../include \
-	-I $(srctree)/$(src)
+	-I $(src)/../include \
+	-I $(src)
 
 komeda-y := \
 	komeda_drv.o \
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index fba73c38e235..2220448ed07f 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -41,7 +41,7 @@ CFLAGS_display/intel_fbdev.o = -Wno-override-init
 # drivers. Define I915 when building i915.
 subdir-ccflags-y += -DI915
 
-subdir-ccflags-y += -I$(srctree)/$(src)
+subdir-ccflags-y += -I$(src)
 
 # Please keep these build lists sorted!
 
@@ -434,7 +434,7 @@ no-header-test := \
 
 always-$(CONFIG_DRM_I915_WERROR) += \
 	$(patsubst %.h,%.hdrtest, $(filter-out $(no-header-test), \
-		$(shell cd $(srctree)/$(src) && find * -name '*.h')))
+		$(shell cd $(src) && find * -name '*.h')))
 
 quiet_cmd_hdrtest = HDRTEST $(patsubst %.hdrtest,%.h,$@)
       cmd_hdrtest = $(CC) $(filter-out $(CFLAGS_GCOV), $(c_flags)) -S -o /dev/null -x c /dev/null -include $<; \
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index b21ae2880c71..b8cc007fc1b9 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I $(srctree)/$(src)
-ccflags-y += -I $(srctree)/$(src)/disp/dpu1
-ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
-ccflags-$(CONFIG_DRM_MSM_DP) += -I $(srctree)/$(src)/dp
+ccflags-y := -I $(src)
+ccflags-y += -I $(src)/disp/dpu1
+ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(src)/dsi
+ccflags-$(CONFIG_DRM_MSM_DP) += -I $(src)/dp
 
 msm-y := \
 	adreno/adreno_device.o \
diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index cf6b3a80c0c8..c32c01827c1d 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -1,10 +1,8 @@
-NOUVEAU_PATH ?= $(srctree)
-
 # SPDX-License-Identifier: MIT
-ccflags-y += -I $(NOUVEAU_PATH)/$(src)/include
-ccflags-y += -I $(NOUVEAU_PATH)/$(src)/include/nvkm
-ccflags-y += -I $(NOUVEAU_PATH)/$(src)/nvkm
-ccflags-y += -I $(NOUVEAU_PATH)/$(src)
+ccflags-y += -I $(src)/include
+ccflags-y += -I $(src)/include/nvkm
+ccflags-y += -I $(src)/nvkm
+ccflags-y += -I $(src)
 
 # NVKM - HW resource manager
 #- code also used by various userspace tools/tests
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index c29a850859ad..8162a522222b 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -32,7 +32,7 @@ endif
 # Enable -Werror in CI and development
 subdir-ccflags-$(CONFIG_DRM_XE_WERROR) += -Werror
 
-subdir-ccflags-y += -I$(obj) -I$(srctree)/$(src)
+subdir-ccflags-y += -I$(obj) -I$(src)
 
 # generated sources
 hostprogs := xe_gen_wa_oob
@@ -43,7 +43,7 @@ quiet_cmd_wa_oob = GEN     $(notdir $(generated_oob))
       cmd_wa_oob = mkdir -p $(@D); $^ $(generated_oob)
 
 $(obj)/generated/%_wa_oob.c $(obj)/generated/%_wa_oob.h: $(obj)/xe_gen_wa_oob \
-		 $(srctree)/$(src)/xe_wa_oob.rules
+		 $(src)/xe_wa_oob.rules
 	$(call cmd,wa_oob)
 
 uses_generated_oob := \
@@ -166,8 +166,8 @@ endif
 
 # i915 Display compat #defines and #includes
 subdir-ccflags-$(CONFIG_DRM_XE_DISPLAY) += \
-	-I$(srctree)/$(src)/display/ext \
-	-I$(srctree)/$(src)/compat-i915-headers \
+	-I$(src)/display/ext \
+	-I$(src)/compat-i915-headers \
 	-I$(srctree)/drivers/gpu/drm/i915/display/ \
 	-Ddrm_i915_gem_object=xe_bo \
 	-Ddrm_i915_private=xe_device
@@ -310,7 +310,7 @@ ifneq ($(CONFIG_DRM_XE_DISPLAY),y)
 endif
 
 always-$(CONFIG_DRM_XE_WERROR) += \
-	$(patsubst %.h,%.hdrtest, $(shell cd $(srctree)/$(src) && find * -name '*.h' $(hdrtest_find_args)))
+	$(patsubst %.h,%.hdrtest, $(shell cd $(src) && find * -name '*.h' $(hdrtest_find_args)))
 
 quiet_cmd_hdrtest = HDRTEST $(patsubst %.hdrtest,%.h,$@)
       cmd_hdrtest = $(CC) -DHDRTEST $(filter-out $(CFLAGS_GCOV), $(c_flags)) -S -o /dev/null -x c /dev/null -include $<; touch $@
diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
index 0222170ab7ad..106514b54d16 100644
--- a/drivers/hid/amd-sfh-hid/Makefile
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -13,4 +13,4 @@ amd_sfh-objs += sfh1_1/amd_sfh_init.o
 amd_sfh-objs += sfh1_1/amd_sfh_interface.o
 amd_sfh-objs += sfh1_1/amd_sfh_desc.o
 
-ccflags-y += -I $(srctree)/$(src)/
+ccflags-y += -I $(src)/
diff --git a/drivers/hid/intel-ish-hid/Makefile b/drivers/hid/intel-ish-hid/Makefile
index f0a82b1c7cb9..db4974c43431 100644
--- a/drivers/hid/intel-ish-hid/Makefile
+++ b/drivers/hid/intel-ish-hid/Makefile
@@ -23,4 +23,4 @@ intel-ishtp-hid-objs += ishtp-hid-client.o
 obj-$(CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER) += intel-ishtp-loader.o
 intel-ishtp-loader-objs += ishtp-fw-loader.o
 
-ccflags-y += -I $(srctree)/$(src)/ishtp
+ccflags-y += -I $(src)/ishtp
diff --git a/drivers/md/dm-vdo/Makefile b/drivers/md/dm-vdo/Makefile
index 33e09abc6acd..9476957bfbf4 100644
--- a/drivers/md/dm-vdo/Makefile
+++ b/drivers/md/dm-vdo/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-ccflags-y := -I$(srctree)/$(src) -I$(srctree)/$(src)/indexer
+ccflags-y := -I$(src) -I$(src)/indexer
 
 obj-$(CONFIG_DM_VDO) += dm-vdo.o
 
diff --git a/drivers/net/ethernet/chelsio/libcxgb/Makefile b/drivers/net/ethernet/chelsio/libcxgb/Makefile
index aa79264e72ba..fbedc31674b3 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/Makefile
+++ b/drivers/net/ethernet/chelsio/libcxgb/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-y := -I $(srctree)/$(src)/../cxgb4
+ccflags-y := -I $(src)/../cxgb4
 
 obj-$(CONFIG_CHELSIO_LIB) += libcxgb.o
 
diff --git a/drivers/net/ethernet/fungible/funeth/Makefile b/drivers/net/ethernet/fungible/funeth/Makefile
index 646d69595b4f..d51e4c2b4a1a 100644
--- a/drivers/net/ethernet/fungible/funeth/Makefile
+++ b/drivers/net/ethernet/fungible/funeth/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 
-ccflags-y += -I$(srctree)/$(src)/../funcore -I$(srctree)/$(src)
+ccflags-y += -I$(src)/../funcore -I$(src)
 
 obj-$(CONFIG_FUN_ETH) += funeth.o
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index e214bfaece1f..8e9293e57bfd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the HISILICON network device drivers.
 #
 
-ccflags-y += -I$(srctree)/$(src)
+ccflags-y += -I$(src)
 ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3pf
 ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3vf
 ccflags-y += -I$(srctree)/drivers/net/ethernet/hisilicon/hns3/hns3_common
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index dc6d27a36faa..e5ca0f511822 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -6,8 +6,8 @@
 #
 
 ccflags-y += \
-	-I $(srctree)/$(src) \
-	-I $(srctree)/$(src)/../include
+	-I $(src) \
+	-I $(src)/../include
 
 obj-$(CONFIG_BRCMFMAC) += brcmfmac.o
 brcmfmac-objs += \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
index 46098705e236..5e37c638f966 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/Makefile
@@ -3,9 +3,9 @@
 # Copyright (c) 2022 Broadcom Corporation
 
 ccflags-y += \
-	-I $(srctree)/$(src) \
-	-I $(srctree)/$(src)/.. \
-	-I $(srctree)/$(src)/../../include
+	-I $(src) \
+	-I $(src)/.. \
+	-I $(src)/../../include
 
 obj-m += brcmfmac-bca.o
 brcmfmac-bca-objs += \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
index 5e1fddaff79e..33e86724ba14 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/Makefile
@@ -3,9 +3,9 @@
 # Copyright (c) 2022 Broadcom Corporation
 
 ccflags-y += \
-	-I $(srctree)/$(src) \
-	-I $(srctree)/$(src)/.. \
-	-I $(srctree)/$(src)/../../include
+	-I $(src) \
+	-I $(src)/.. \
+	-I $(src)/../../include
 
 obj-m += brcmfmac-cyw.o
 brcmfmac-cyw-objs += \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
index 7f455a19a2b1..3db4cce44f42 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/Makefile
@@ -3,9 +3,9 @@
 # Copyright (c) 2022 Broadcom Corporation
 
 ccflags-y += \
-	-I $(srctree)/$(src) \
-	-I $(srctree)/$(src)/.. \
-	-I $(srctree)/$(src)/../../include
+	-I $(src) \
+	-I $(src)/.. \
+	-I $(src)/../../include
 
 obj-m += brcmfmac-wcc.o
 brcmfmac-wcc-objs += \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
index 090757730ba6..ffdd17eabe1d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile
@@ -16,9 +16,9 @@
 # CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
 ccflags-y := \
-	-I $(srctree)/$(src) \
-	-I $(srctree)/$(src)/phy \
-	-I $(srctree)/$(src)/../include
+	-I $(src) \
+	-I $(src)/phy \
+	-I $(src)/../include
 
 brcmsmac-y := \
 	mac80211_if.o \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmutil/Makefile
index 7a82d615ba2a..f9b40cab766c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/Makefile
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2011 Broadcom Corporation
 #
-ccflags-y := -I $(srctree)/$(src)/../include
+ccflags-y := -I $(src)/../include
 
 obj-$(CONFIG_BRCMUTIL)	+= brcmutil.o
 brcmutil-objs	= utils.o d11.o
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/Makefile b/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
index 0486b17d7c41..6109d64006db 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/Makefile
@@ -11,4 +11,4 @@ iwldvm-objs		+= rxon.o devices.o
 iwldvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwldvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o
 
-ccflags-y += -I $(srctree)/$(src)/../
+ccflags-y += -I $(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/Makefile b/drivers/net/wireless/intel/iwlwifi/mei/Makefile
index 8e3ef0347db7..e05f9421be4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mei/Makefile
@@ -5,4 +5,4 @@ iwlmei-y += net.o
 iwlmei-$(CONFIG_IWLWIFI_DEVICE_TRACING) += trace.o
 CFLAGS_trace.o := -I$(src)
 
-ccflags-y += -I $(srctree)/$(src)/../
+ccflags-y += -I $(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 593fe28d89cf..764ba73cde1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -15,4 +15,4 @@ iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
 iwlmvm-$(CONFIG_IWLMEI) += vendor-cmd.o
 
-ccflags-y += -I $(srctree)/$(src)/../
+ccflags-y += -I $(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
index 5658471bdf0a..84491488f589 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/tests/Makefile
@@ -2,6 +2,6 @@
 
 iwlwifi-tests-y += module.o devinfo.o
 
-ccflags-y += -I$(srctree)/$(src)/../
+ccflags-y += -I$(src)/../
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlwifi-tests.o
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/Makefile b/drivers/net/wireless/realtek/rtl818x/rtl8180/Makefile
index 565a9a114134..1044105c2557 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/Makefile
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/Makefile
@@ -3,4 +3,4 @@ rtl818x_pci-objs	:= dev.o rtl8225.o sa2400.o max2820.o grf5101.o rtl8225se.o
 
 obj-$(CONFIG_RTL8180)	+= rtl818x_pci.o
 
-ccflags-y += -I $(srctree)/$(src)/..
+ccflags-y += -I $(src)/..
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/Makefile b/drivers/net/wireless/realtek/rtl818x/rtl8187/Makefile
index 0bf64dfb233a..3deded2c05b6 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/Makefile
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/Makefile
@@ -3,4 +3,4 @@ rtl8187-objs		:= dev.o rtl8225.o leds.o rfkill.o
 
 obj-$(CONFIG_RTL8187)	+= rtl8187.o
 
-ccflags-y += -I $(srctree)/$(src)/..
+ccflags-y += -I $(src)/..
diff --git a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
index e0188ecd85b2..853c72a81ae0 100644
--- a/drivers/scsi/aic7xxx/Makefile
+++ b/drivers/scsi/aic7xxx/Makefile
@@ -55,9 +55,9 @@ aicasm-7xxx-opts-$(CONFIG_AIC7XXX_REG_PRETTY_PRINT) := \
 
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
 $(obj)/aic7xxx_seq.h: $(src)/aic7xxx.seq $(src)/aic7xxx.reg $(obj)/aicasm/aicasm
-	$(obj)/aicasm/aicasm -I$(srctree)/$(src) -r $(obj)/aic7xxx_reg.h \
+	$(obj)/aicasm/aicasm -I $(src) -r $(obj)/aic7xxx_reg.h \
 			      $(aicasm-7xxx-opts-y) -o $(obj)/aic7xxx_seq.h \
-			      $(srctree)/$(src)/aic7xxx.seq
+			      $(src)/aic7xxx.seq
 
 $(aic7xxx-gen-y): $(objtree)/$(obj)/aic7xxx_seq.h
 	@true
@@ -73,9 +73,9 @@ aicasm-79xx-opts-$(CONFIG_AIC79XX_REG_PRETTY_PRINT) := \
 
 ifeq ($(CONFIG_AIC79XX_BUILD_FIRMWARE),y)
 $(obj)/aic79xx_seq.h: $(src)/aic79xx.seq $(src)/aic79xx.reg $(obj)/aicasm/aicasm
-	$(obj)/aicasm/aicasm -I$(srctree)/$(src) -r $(obj)/aic79xx_reg.h \
+	$(obj)/aicasm/aicasm -I $(src) -r $(obj)/aic79xx_reg.h \
 			      $(aicasm-79xx-opts-y) -o $(obj)/aic79xx_seq.h \
-			      $(srctree)/$(src)/aic79xx.seq
+			      $(src)/aic79xx.seq
 
 $(aic79xx-gen-y): $(objtree)/$(obj)/aic79xx_seq.h
 	@true
@@ -83,5 +83,5 @@ else
 $(obj)/aic79xx_reg_print.c: $(src)/aic79xx_reg_print.c_shipped
 endif
 
-$(obj)/aicasm/aicasm: $(srctree)/$(src)/aicasm/*.[chyl]
-	$(MAKE) -C $(srctree)/$(src)/aicasm OUTDIR=$(shell pwd)/$(obj)/aicasm/
+$(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
+	$(MAKE) -C $(src)/aicasm OUTDIR=$(shell pwd)/$(obj)/aicasm/
diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 590bde02058c..7f5067e89295 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -62,4 +62,4 @@ r8723bs-y = \
 
 obj-$(CONFIG_RTL8723BS) := r8723bs.o
 
-ccflags-y += -I$(srctree)/$(src)/include -I$(srctree)/$(src)/hal
+ccflags-y += -I$(src)/include -I$(src)/hal
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index fc070184b7fa..381d76c5c232 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -4,7 +4,7 @@
 # All Rights Reserved.
 #
 
-ccflags-y += -I $(srctree)/$(src)		# needed for trace events
+ccflags-y += -I $(src)		# needed for trace events
 
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 0e51c0025a16..e309afe2b2bb 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -18,13 +18,13 @@ ifdef REGENERATE_UTF8DATA
 
 quiet_cmd_utf8data = GEN     $@
       cmd_utf8data = $< \
-		-a $(srctree)/$(src)/DerivedAge.txt \
-		-c $(srctree)/$(src)/DerivedCombiningClass.txt \
-		-p $(srctree)/$(src)/DerivedCoreProperties.txt \
-		-d $(srctree)/$(src)/UnicodeData.txt \
-		-f $(srctree)/$(src)/CaseFolding.txt \
-		-n $(srctree)/$(src)/NormalizationCorrections.txt \
-		-t $(srctree)/$(src)/NormalizationTest.txt \
+		-a $(src)/DerivedAge.txt \
+		-c $(src)/DerivedCombiningClass.txt \
+		-p $(src)/DerivedCoreProperties.txt \
+		-d $(src)/UnicodeData.txt \
+		-f $(src)/CaseFolding.txt \
+		-n $(src)/NormalizationCorrections.txt \
+		-t $(src)/NormalizationTest.txt \
 		-o $@
 
 $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 76674ad5833e..c5a35e32adf0 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -4,8 +4,8 @@
 # All Rights Reserved.
 #
 
-ccflags-y += -I $(srctree)/$(src)		# needed for trace events
-ccflags-y += -I $(srctree)/$(src)/libxfs
+ccflags-y += -I $(src)		# needed for trace events
+ccflags-y += -I $(src)/libxfs
 
 obj-$(CONFIG_XFS_FS)		+= xfs.o
 
diff --git a/init/Makefile b/init/Makefile
index cbac576c57d6..3c48d97538c1 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -52,7 +52,7 @@ CFLAGS_version.o := -include $(obj)/utsversion-tmp.h
 # Build version-timestamp.c with final UTS_VERSION
 #
 
-include/generated/utsversion.h: build-version-auto = $(shell $(srctree)/$(src)/build-version)
+include/generated/utsversion.h: build-version-auto = $(shell $(src)/build-version)
 include/generated/utsversion.h: build-timestamp-auto = $(shell LC_ALL=C date)
 include/generated/utsversion.h: FORCE
 	$(call filechk,uts_version)
diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45..27baa6e6daa8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -352,7 +352,7 @@ $(obj)/oid_registry_data.c: $(srctree)/include/linux/oid_registry.h \
 	$(call cmd,build_OID_registry)
 
 quiet_cmd_build_OID_registry = GEN     $@
-      cmd_build_OID_registry = perl $(srctree)/$(src)/build_OID_registry $< $@
+      cmd_build_OID_registry = perl $(src)/build_OID_registry $< $@
 
 clean-files	+= oid_registry_data.c
 
@@ -412,8 +412,8 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
 
 # FORTIFY_SOURCE compile-time behavior tests
-TEST_FORTIFY_SRCS = $(wildcard $(srctree)/$(src)/test_fortify/*-*.c)
-TEST_FORTIFY_LOGS = $(patsubst $(srctree)/$(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))
+TEST_FORTIFY_SRCS = $(wildcard $(src)/test_fortify/*-*.c)
+TEST_FORTIFY_LOGS = $(patsubst $(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))
 TEST_FORTIFY_LOG = test_fortify.log
 
 quiet_cmd_test_fortify = TEST    $@
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 385a94aa0b99..8785353c6140 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -53,7 +53,7 @@ endif
 endif
 
 quiet_cmd_unroll = UNROLL  $@
-      cmd_unroll = $(AWK) -v N=$* -f $(srctree)/$(src)/unroll.awk < $< > $@
+      cmd_unroll = $(AWK) -v N=$* -f $(src)/unroll.awk < $< > $@
 
 targets += int1.c int2.c int4.c int8.c
 $(obj)/int%.c: $(src)/int.uc $(src)/unroll.awk FORCE
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 72074fd36df4..1d49cc8b6da1 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -25,7 +25,7 @@ ifneq ($(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR),)
 cfg80211-y += extra-certs.o
 endif
 
-$(obj)/shipped-certs.c: $(sort $(wildcard $(srctree)/$(src)/certs/*.hex))
+$(obj)/shipped-certs.c: $(sort $(wildcard $(src)/certs/*.hex))
 	@$(kecho) "  GEN     $@"
 	$(Q)(echo '#include "reg.h"'; \
 	  echo 'const u8 shipped_regdb_certs[] = {'; \
diff --git a/rust/Makefile b/rust/Makefile
index 846e6ab9d5a9..85e46dde2a5b 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -239,7 +239,7 @@ quiet_cmd_rustsysroot = RUSTSYSROOT
 	rm -rf $(objtree)/$(obj)/test; \
 	mkdir -p $(objtree)/$(obj)/test; \
 	cp -a $(rustc_sysroot) $(objtree)/$(obj)/test/sysroot; \
-	cp -r $(srctree)/$(src)/alloc/* \
+	cp -r $(src)/alloc/* \
 		$(objtree)/$(obj)/test/sysroot/lib/rustlib/src/rust/library/alloc/src; \
 	echo '\#!/bin/sh' > $(objtree)/$(obj)/test/rustc_sysroot; \
 	echo "$(RUSTC) --sysroot=$(abspath $(objtree)/$(obj)/test/sysroot) \"\$$@\"" \
@@ -340,7 +340,7 @@ quiet_cmd_bindgen = BINDGEN $@
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
-    $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
     sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
@@ -348,7 +348,7 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
 	$(call if_changed_dep,bindgen)
 
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
-    $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 933f6c3fe6b0..f054e0828f13 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_SAMPLES_PATH ?= $(abspath $(srctree)/$(src))
+BPF_SAMPLES_PATH ?= $(abspath $(src))
 TOOLS_PATH := $(BPF_SAMPLES_PATH)/../../tools
 
 pound := \#
diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index 9f7fe29dd749..c128ccd49974 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-HID_SAMPLES_PATH ?= $(abspath $(srctree)/$(src))
+HID_SAMPLES_PATH ?= $(abspath $(src))
 TOOLS_PATH := $(HID_SAMPLES_PATH)/../../tools
 
 pound := \#
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2f331879816b..faf37bafa3f8 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -62,8 +62,7 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
 
 ###
 # The path to Kbuild or Makefile. Kbuild has precedence over Makefile.
-kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+kbuild-file = $(or $(wildcard $(src)/Kbuild),$(src)/Makefile)
 
 ###
 # Read a file, replacing newlines with spaces
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 8d01b37b7677..1486abf34c7c 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -9,7 +9,7 @@
 PHONY := all
 all:
 
-src := $(subst /generated,,$(obj))
+src := $(srctree)/$(subst /generated,,$(obj))
 
 include $(srctree)/scripts/Kbuild.include
 -include $(kbuild-file)
@@ -20,14 +20,14 @@ include $(srctree)/$(generic)/Kbuild
 endif
 
 redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
-redundant += $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$(src)/$(f)),$(f)))
+redundant += $(foreach f, $(generic-y), $(if $(wildcard $(src)/$(f)),$(f)))
 redundant := $(sort $(redundant))
 $(if $(redundant),\
 	$(warning redundant generic-y found in $(src)/Kbuild: $(redundant)))
 
 # If arch does not implement mandatory headers, fallback to asm-generic ones.
 mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
-generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
+generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(src)/$(f)),,$(f)))
 
 generic-y   := $(addprefix $(obj)/, $(generic-y))
 generated-y := $(addprefix $(obj)/, $(generated-y))
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 067c93fa76c2..3a74963a25b1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -3,7 +3,7 @@
 # Building
 # ==========================================================================
 
-src := $(obj)
+src := $(if $(VPATH),$(VPATH)/)$(obj)
 
 PHONY := $(obj)/
 $(obj)/:
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index f2cb4d7ffd96..4fcfab40ed61 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -3,7 +3,7 @@
 # Cleaning up
 # ==========================================================================
 
-src := $(obj)
+src := $(if $(VPATH),$(VPATH)/)$(obj)
 
 PHONY := __clean
 __clean:
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3179747cbd2c..c53d2f168801 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -209,13 +209,13 @@ _c_flags += $(if $(patsubst n%,, \
 	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
-# $(srctree)/$(src) for including checkin headers from generated source files
-# $(objtree)/$(obj) for including generated headers from checkin source files
+# $(src) for including checkin headers from generated source files
+# $(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
-_c_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
-_a_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
-_cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
+_c_flags   += -I $(src) -I $(obj)
+_a_flags   += -I $(src) -I $(obj)
+_cpp_flags += -I $(src) -I $(obj)
 endif
 endif
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 739402f45509..68c4f9ee0c90 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -112,7 +112,7 @@ else
 
 # set src + obj - they may be used in the modules's Makefile
 obj := $(KBUILD_EXTMOD)
-src := $(obj)
+src := $(if $(VPATH),$(VPATH)/)$(obj)
 
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
 include $(kbuild-file)
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 4d32b9497da9..a18657072541 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -16,12 +16,12 @@ libfdt		= $(addprefix libfdt/,$(libfdt-objs))
 fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 
 # Source files need to get at the userspace version of libfdt_env.h to compile
-HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
+HOST_EXTRACFLAGS += -I $(src)/libfdt
 HOST_EXTRACFLAGS += -DNO_YAML
 
 # Generated files need one more search path to include headers in source tree
-HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
-HOSTCFLAGS_dtc-parser.tab.o := -I $(srctree)/$(src)
+HOSTCFLAGS_dtc-lexer.lex.o := -I $(src)
+HOSTCFLAGS_dtc-parser.tab.o := -I $(src)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index 48941faa6ea6..d77ad9079d0f 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -2,7 +2,7 @@
 
 ifdef building_out_of_srctree
 
-symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
+symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
       cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index d6a422a63b6a..312edccda736 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -23,8 +23,8 @@ $(obj)/pars%.tab.c $(obj)/pars%.tab.h: $(src)/pars%.y FORCE
 endif
 
 # -I needed for generated C source to include headers in source tree
-HOSTCFLAGS_parse.tab.o := -I $(srctree)/$(src)
-HOSTCFLAGS_lex.lex.o := -I $(srctree)/$(src)
+HOSTCFLAGS_parse.tab.o := -I $(src)
+HOSTCFLAGS_lex.lex.o := -I $(src)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/lex.lex.o: $(obj)/parse.tab.h
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ea1bf3b3dbde..a0a0be38cbdc 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -57,7 +57,7 @@ $(foreach c, config menuconfig nconfig gconfig xconfig, $(eval $(call config_rul
 
 PHONY += localmodconfig localyesconfig
 localyesconfig localmodconfig: $(obj)/conf
-	$(Q)$(PERL) $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
+	$(Q)$(PERL) $(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 				\
 		cmp -s .tmp.config .config ||			\
 		(mv -f .config .config.old.1;			\
@@ -118,7 +118,7 @@ tinyconfig:
 # CHECK: -o cache_dir=<path> working?
 PHONY += testconfig
 testconfig: $(obj)/conf
-	$(Q)$(PYTHON3) -B -m pytest $(srctree)/$(src)/tests \
+	$(Q)$(PYTHON3) -B -m pytest $(src)/tests \
 	-o cache_dir=$(abspath $(obj)/tests/.cache) \
 	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=no)
 clean-files += tests/.cache
@@ -165,8 +165,8 @@ common-objs	:= confdata.o expr.o lexer.lex.o menu.o parser.tab.o \
 		   preprocess.o symbol.o util.o
 
 $(obj)/lexer.lex.o: $(obj)/parser.tab.h
-HOSTCFLAGS_lexer.lex.o	:= -I $(srctree)/$(src)
-HOSTCFLAGS_parser.tab.o	:= -I $(srctree)/$(src)
+HOSTCFLAGS_lexer.lex.o	:= -I $(src)
+HOSTCFLAGS_parser.tab.o	:= -I $(src)
 
 # conf: Used for defconfig, oldconfig and related targets
 hostprogs	+= conf
diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 884ff155edc3..55c67b9846a9 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -11,7 +11,7 @@ quiet_cmd_policy = POLICY  $@
 	printf '\t"";\n';) \
 	} > $@
 
-$(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(srctree)/$(src)/policy/*.conf.default) FORCE
+$(obj)/builtin-policy.h: $(wildcard $(obj)/policy/*.conf $(src)/policy/*.conf.default) FORCE
 	$(call if_changed,policy)
 
 ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
diff --git a/usr/Makefile b/usr/Makefile
index f8e1ad19e05c..132ef7e96e6d 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -22,7 +22,7 @@ cpio-data :=
 # If CONFIG_INITRAMFS_SOURCE is empty, generate a small initramfs with the
 # default contents.
 ifeq ($(ramfs-input),)
-ramfs-input := $(srctree)/$(src)/default_cpio_list
+ramfs-input := $(src)/default_cpio_list
 endif
 
 ifeq ($(words $(ramfs-input)),1)
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 338c81f1fcf3..771e32872b2a 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -78,7 +78,7 @@ quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -fsyntax-only -x c /dev/null \
 			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
-		$(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
+		$(PERL) $(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
 		touch $@
 
 $(obj)/%.hdrtest: $(obj)/%.h FORCE
-- 
2.40.1


