Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507D778F323
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347169AbjHaTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbjHaTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:13:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D5DE6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:13:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0bae4da38so7854565ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693509221; x=1694114021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iK6EVwim7jDoafXdUDxWuQQIWFAzKU65AsSWw3Wjc04=;
        b=iddyumzjtAMKQeO7tlefvv1qFjQoZXwKD1LPYChX37X1igYWjHm8EFyM84m9Zbi6AO
         N+DLNAu2A5xR/fhbRIpBAy82pgR0K3ecCPJ6+hidomkhwijSGTGoLp7S3q/3vsFrh1CY
         2FbVps8ENjN26zo9MGKe6txGXI3lpC8mvxRr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509221; x=1694114021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iK6EVwim7jDoafXdUDxWuQQIWFAzKU65AsSWw3Wjc04=;
        b=b03CtM6n6V8tb36sBsNMalKghDPKkL6dMD2YNA7JGXLmw8sCyzt+bn5MAWIbv/8SIr
         xazOWYMJRWQ/JD0Hf5V+pMP3LOQAyDFFBNnYp/sBnvyP7V/8Zw90fWnz28JXjYtVqkSr
         nLbzA4M3b4IVXMUmB2tcRcNs+mh+C57p6EIcThDxr3+hEYPTfVi/E1M6udQnT0C2YN5Z
         7+nNm11yHanx02VLWK3lJ7IBDNhonKsMiVJsQpBcJjwGy7unQfsoPoxNXxrM8xyVn6Ba
         gR7k1IiwVHldVIVZG8BDokUowTflQpFqIh1an8ZNFsnqRCeLoz84FevTMJivsJHZmJq8
         ZQgQ==
X-Gm-Message-State: AOJu0Yzonuuj/6QmMrNrsY3ctpRXDnCS706jbtpmF3UNz+D7agtJUE1G
        5Vp1JEoqs1R5Cq9dFKk2bS7Lrw==
X-Google-Smtp-Source: AGHT+IHWy5qCvXvRwCCU+AouBnW4dazUiYq9g8WzKmoiTKNksgwo7MvfQ9WvCNaOnrbY+2PL1tTNSA==
X-Received: by 2002:a17:902:d34b:b0:1b7:f64b:379b with SMTP id l11-20020a170902d34b00b001b7f64b379bmr429310plk.17.1693509221158;
        Thu, 31 Aug 2023 12:13:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001bf095dfb79sm1568776pld.235.2023.08.31.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:13:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] kbuild: Show marked Kconfig fragments in "help"
Date:   Thu, 31 Aug 2023 12:13:39 -0700
Message-Id: <20230831191335.give.534-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11582; i=keescook@chromium.org;
 h=from:subject:message-id; bh=r2lzEobTI2oueJzBA83pjzi2JMLF23GOhlMsRmSj4aM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk8OZicS8b451VlnotjEhofuGltC2UZgLJ9Z7DM
 gcAWx8Ppc2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZPDmYgAKCRCJcvTf3G3A
 JoiSD/4mV2jBtkx28Gp9i/TwILnjqF6/HvZEoDRT98Lk/YoRTEa2yTQ04K716TK1DRv9WnTzf4Q
 c3U5Qr4tmhKULZ4sL5/hrDh9kALE8jL8j2gzD8hI+F0Uk+ohaTeo4XByKrrF0bGHpGMNcPsY5S+
 vRDzsJg4vmBSLWNOKIIgkmVWx+2weEo7Q6zOQzk9GwasdRTjB0LKmoiiWnGzHigVWBDL5Yrvpc9
 2r8wmBCZp14btUMFwsEp0xAgJp/bmERz9MWqrm1SR4VDkhvwbddASMlNvMhzKCNZLmhJ9+GMOX6
 vDatGwqIQIfpCHNtThI1cjtNKDpXjAgWdqO+WAR5o/NyYGhXeC35Cz0oRcVSco4pTPYupraZnol
 mkH+Drr+v7kuWyLK3zBrEhh8V1iQD4idAmyP5aJqyw4VQomArKi9Kn4DeD+vqFdRfDDn7z6gi/c
 KEwsrVx5njHOgNxtPRj3eTPOQXOLMnf37fp2h9Fnl2Hhj6F3WTHPVQSo4YVkFwD/76VCF2fX3F6
 Nix1DSBocxDPPXWJIg9ckt2VakA+EHP7pqHGg1aQ4ed4n6/zBn77QeMGVIroBYxwM5PsKNV93DB
 AjUAGhyWMEdWRp+uf+QkyI+Wu8lTa95KsHDRvsq4NRmV8GL0lhMV39xQAXBcFe2NTDgHi1GSHtH
 ep/kye zOfAxtBAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Kconfig fragments in kernel/configs and arch/*/configs
that aren't used internally aren't discoverable through "make help",
which consists of hard-coded lists of config fragments. Instead, list
all the fragment targets that have a "# Help: " comment prefix so the
targets can be generated dynamically.

Add logic to the Makefile to search for and display the fragment and
comment. Add comments to fragments that are intended to be direct targets.

Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>
---
v3:
- Use Makefile logic from Masahiro Yamada
- Use "# Help: " prefix, but only on desired fragment targets
v2: https://lore.kernel.org/all/20230825194329.gonna.911-kees@kernel.org
v1: https://lore.kernel.org/all/20230824223606.never.762-kees@kernel.org
---
 Makefile                                   |  1 -
 arch/arm/configs/dram_0x00000000.config    |  1 +
 arch/arm/configs/dram_0xc0000000.config    |  1 +
 arch/arm/configs/dram_0xd0000000.config    |  1 +
 arch/arm/configs/lpae.config               |  1 +
 arch/arm64/configs/virt.config             |  1 +
 arch/powerpc/configs/disable-werror.config |  1 +
 arch/powerpc/configs/security.config       |  4 +++-
 arch/riscv/configs/32-bit.config           |  1 +
 arch/riscv/configs/64-bit.config           |  1 +
 arch/s390/configs/btf.config               |  1 +
 arch/s390/configs/kasan.config             |  1 +
 arch/x86/Makefile                          |  4 ----
 kernel/configs/debug.config                |  2 ++
 kernel/configs/kvm_guest.config            |  1 +
 kernel/configs/nopm.config                 |  2 ++
 kernel/configs/rust.config                 |  1 +
 kernel/configs/tiny.config                 |  2 ++
 kernel/configs/x86_debug.config            |  1 +
 kernel/configs/xen.config                  |  2 ++
 scripts/kconfig/Makefile                   | 15 ++++++++++++---
 21 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4739c21a63e2..91c90ce8e0e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1674,7 +1674,6 @@ help:
 	@echo  '  mrproper	  - Remove all generated files + config + various backup files'
 	@echo  '  distclean	  - mrproper + remove editor backup and patch files'
 	@echo  ''
-	@echo  'Configuration targets:'
 	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help
 	@echo  ''
 	@echo  'Other generic targets:'
diff --git a/arch/arm/configs/dram_0x00000000.config b/arch/arm/configs/dram_0x00000000.config
index db96dcb420ce..8803a0f58343 100644
--- a/arch/arm/configs/dram_0x00000000.config
+++ b/arch/arm/configs/dram_0x00000000.config
@@ -1 +1,2 @@
+# Help: DRAM base at 0x00000000
 CONFIG_DRAM_BASE=0x00000000
diff --git a/arch/arm/configs/dram_0xc0000000.config b/arch/arm/configs/dram_0xc0000000.config
index 343d5333d973..aab8f864686b 100644
--- a/arch/arm/configs/dram_0xc0000000.config
+++ b/arch/arm/configs/dram_0xc0000000.config
@@ -1 +1,2 @@
+# Help: DRAM base at 0xc0000000
 CONFIG_DRAM_BASE=0xc0000000
diff --git a/arch/arm/configs/dram_0xd0000000.config b/arch/arm/configs/dram_0xd0000000.config
index 61ba7045f8a1..4aabce4ea3d4 100644
--- a/arch/arm/configs/dram_0xd0000000.config
+++ b/arch/arm/configs/dram_0xd0000000.config
@@ -1 +1,2 @@
+# Help: DRAM base at 0xd0000000
 CONFIG_DRAM_BASE=0xd0000000
diff --git a/arch/arm/configs/lpae.config b/arch/arm/configs/lpae.config
index a6d6f7ab3c01..1ab94da8345d 100644
--- a/arch/arm/configs/lpae.config
+++ b/arch/arm/configs/lpae.config
@@ -1,2 +1,3 @@
+# Help: Enable Large Physical Address Extension mode
 CONFIG_ARM_LPAE=y
 CONFIG_VMSPLIT_2G=y
diff --git a/arch/arm64/configs/virt.config b/arch/arm64/configs/virt.config
index 6865d54e68f8..c47c36f8f67b 100644
--- a/arch/arm64/configs/virt.config
+++ b/arch/arm64/configs/virt.config
@@ -1,3 +1,4 @@
+# Help: Virtualization guest
 #
 # Base options for platforms
 #
diff --git a/arch/powerpc/configs/disable-werror.config b/arch/powerpc/configs/disable-werror.config
index 6ea12a12432c..7776b91da37f 100644
--- a/arch/powerpc/configs/disable-werror.config
+++ b/arch/powerpc/configs/disable-werror.config
@@ -1 +1,2 @@
+# Help: Disable -Werror
 CONFIG_PPC_DISABLE_WERROR=y
diff --git a/arch/powerpc/configs/security.config b/arch/powerpc/configs/security.config
index 1c91a35c6a73..0d54e29e2cdf 100644
--- a/arch/powerpc/configs/security.config
+++ b/arch/powerpc/configs/security.config
@@ -1,3 +1,5 @@
+# Help: Common security options for PowerPC builds
+
 # This is the equivalent of booting with lockdown=integrity
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
@@ -12,4 +14,4 @@ CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 
 # UBSAN bounds checking is very cheap and good for hardening
 CONFIG_UBSAN=y
-# CONFIG_UBSAN_MISC is not set
\ No newline at end of file
+# CONFIG_UBSAN_MISC is not set
diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
index f6af0f708df4..16ee163847b4 100644
--- a/arch/riscv/configs/32-bit.config
+++ b/arch/riscv/configs/32-bit.config
@@ -1,3 +1,4 @@
+# Help: Build a 32-bit image
 CONFIG_ARCH_RV32I=y
 CONFIG_32BIT=y
 # CONFIG_PORTABLE is not set
diff --git a/arch/riscv/configs/64-bit.config b/arch/riscv/configs/64-bit.config
index 313edc554d84..d872a2d533f2 100644
--- a/arch/riscv/configs/64-bit.config
+++ b/arch/riscv/configs/64-bit.config
@@ -1,2 +1,3 @@
+# Help: Build a 64-bit image
 CONFIG_ARCH_RV64I=y
 CONFIG_64BIT=y
diff --git a/arch/s390/configs/btf.config b/arch/s390/configs/btf.config
index 39227b4511af..eb7f84f5925c 100644
--- a/arch/s390/configs/btf.config
+++ b/arch/s390/configs/btf.config
@@ -1 +1,2 @@
+# Help: Enable BTF debug info
 CONFIG_DEBUG_INFO_BTF=y
diff --git a/arch/s390/configs/kasan.config b/arch/s390/configs/kasan.config
index 700a8b25c3ff..84c2b551e992 100644
--- a/arch/s390/configs/kasan.config
+++ b/arch/s390/configs/kasan.config
@@ -1,3 +1,4 @@
+# Help: Enable KASan for debugging
 CONFIG_KASAN=y
 CONFIG_KASAN_INLINE=y
 CONFIG_KASAN_VMALLOC=y
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fdc2e3abd615..c4b2a8a19fc8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -335,9 +335,5 @@ define archhelp
   echo  '			  bzdisk/fdimage*/hdimage/isoimage also accept:'
   echo  '			  FDARGS="..."  arguments for the booted kernel'
   echo  '			  FDINITRD=file initrd for the booted kernel'
-  echo  ''
-  echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
-  echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
-  echo  '  x86_debug.config	- Enable tip tree debugging options for testing'
 
 endef
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e8db8d938661..4722b998a324 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -1,3 +1,5 @@
+# Help: Debugging for CI systems and finding regressions
+#
 # The config is based on running daily CI for enterprise Linux distros to
 # seek regressions on linux-next builds on different bare-metal and virtual
 # platforms. It can be used for example,
diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
index 208481d91090..d0877063d925 100644
--- a/kernel/configs/kvm_guest.config
+++ b/kernel/configs/kvm_guest.config
@@ -1,3 +1,4 @@
+# Help: Bootable as a KVM guest
 CONFIG_NET=y
 CONFIG_NET_CORE=y
 CONFIG_NETDEVICES=y
diff --git a/kernel/configs/nopm.config b/kernel/configs/nopm.config
index 81ff07863576..ebfdc3d8aa9a 100644
--- a/kernel/configs/nopm.config
+++ b/kernel/configs/nopm.config
@@ -1,3 +1,5 @@
+# Help: Disable Power Management
+
 CONFIG_PM=n
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
diff --git a/kernel/configs/rust.config b/kernel/configs/rust.config
index 38a7c5362c9c..2c6e001a7284 100644
--- a/kernel/configs/rust.config
+++ b/kernel/configs/rust.config
@@ -1 +1,2 @@
+# Help: Enable Rust
 CONFIG_RUST=y
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 00009f7d0835..60a4b6d80b36 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -1,3 +1,5 @@
+# Help: Size-optimized kernel image
+#
 # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_KERNEL_GZIP is not set
diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
index 6fac5b405334..35f48671b8d5 100644
--- a/kernel/configs/x86_debug.config
+++ b/kernel/configs/x86_debug.config
@@ -1,3 +1,4 @@
+# Help: Debugging options for tip tree testing
 CONFIG_X86_DEBUG_FPU=y
 CONFIG_LOCK_STAT=y
 CONFIG_DEBUG_VM=y
diff --git a/kernel/configs/xen.config b/kernel/configs/xen.config
index 436f806aa1ed..6878b9a49be8 100644
--- a/kernel/configs/xen.config
+++ b/kernel/configs/xen.config
@@ -1,3 +1,5 @@
+# Help: Bootable as a Xen guest
+#
 # global stuff - these enable us to allow some
 # of the not so generic stuff below for xen
 CONFIG_PARAVIRT=y
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index af1c96198f49..4eee155121a8 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -93,11 +93,13 @@ endif
 %_defconfig: $(obj)/conf
 	$(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$@ $(Kconfig)
 
-configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/configs/$@)
+configfiles = $(wildcard $(srctree)/kernel/configs/$(1) $(srctree)/arch/$(SRCARCH)/configs/$(1))
+all-config-fragments = $(call configfiles,*.config)
+config-fragments = $(call configfiles,$@)
 
 %.config: $(obj)/conf
-	$(if $(call configfiles),, $(error No configuration exists for this target on this architecture))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(configfiles)
+	$(if $(config-fragments),, $(error $@ fragment does not exists on this architecture))
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(config-fragments)
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 PHONY += tinyconfig
@@ -115,6 +117,7 @@ clean-files += tests/.cache
 
 # Help text used by make help
 help:
+	@echo  'Configuration targets:'
 	@echo  '  config	  - Update current config utilising a line-oriented program'
 	@echo  '  nconfig         - Update current config utilising a ncurses menu based program'
 	@echo  '  menuconfig	  - Update current config utilising a menu based program'
@@ -141,6 +144,12 @@ help:
 	@echo  '                    default value without prompting'
 	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
 	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and pytest)'
+	@echo  ''
+	@echo  'Configuration topic targets:'
+	@$(foreach f, $(all-config-fragments), \
+		if help=$$(grep -m1 '^# Help: ' $(f)); then \
+			printf '  %-25s - %s\n' '$(notdir $(f))' "$${help#*: }"; \
+		fi;)
 
 # ===========================================================================
 # object files used by all kconfig flavours
-- 
2.34.1

