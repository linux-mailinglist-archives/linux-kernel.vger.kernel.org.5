Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272F7CBF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjJQJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjJQJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:40:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A337F9;
        Tue, 17 Oct 2023 02:39:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014DFC433C8;
        Tue, 17 Oct 2023 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697535598;
        bh=F5RcJpz6n6tELuxNxNyEcSyKRIgUtiYBPAb5RiIKHpo=;
        h=From:To:Cc:Subject:Date:From;
        b=WBnKQWsYpPgp4Opd8VBte4yLHLYA6BqtJOYGvKnkSo9yXD6wc2IK9hRVyglNsbzLo
         Dxx+u8yG4/RaIP+xMn7gOpe9dEOVrPWRyjAyvoQTZ3QDWYDaki6vpUDdxDf0GqYG+i
         1JP9u+azCGiMfXEc2A26TneZGYweKH1ywqRCq+eYW43arz+rQz5XX04A6o9lasP797
         /uWwNcSteBgT547xAlXmfoMyu37e51nLGRNUMNaEa6KuUp6owLL1C90NVP9q7LRpm4
         5YYT4BxqSEfkN9g3M+mUPkiEE4UITBJjCZAVQVfoD/Mf7swrV0Tm+YkrNvRU2EljOZ
         TrrjJI0KUXA3g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] [v2] efi: move screen_info into efi init code
Date:   Tue, 17 Oct 2023 11:39:46 +0200
Message-Id: <20231017093947.3627976-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

After the vga console no longer relies on global screen_info, there are
only two remaining use cases:

 - on the x86 architecture, it is used for multiple boot methods
   (bzImage, EFI, Xen, kexec) to commucate the initial VGA or framebuffer
   settings to a number of device drivers.

 - on other architectures, it is only used as part of the EFI stub,
   and only for the three sysfb framebuffers (simpledrm, simplefb, efifb).

Remove the duplicate data structure definitions by moving it into the
efi-init.c file that sets it up initially for the EFI case, leaving x86
as an exception that retains its own definition for non-EFI boots.

The added #ifdefs here are optional, I added them to further limit the
reach of screen_info to configurations that have at least one of the
users enabled.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix up loongarch code, which has a separate copy of the
efi-init.c file.
---
 arch/arm/kernel/setup.c                       |  4 ----
 arch/arm64/kernel/efi.c                       |  4 ----
 arch/arm64/kernel/image-vars.h                |  2 ++
 arch/loongarch/kernel/efi.c                   |  8 +++++++-
 arch/loongarch/kernel/image-vars.h            |  2 ++
 arch/loongarch/kernel/setup.c                 |  5 -----
 arch/riscv/kernel/image-vars.h                |  2 ++
 arch/riscv/kernel/setup.c                     |  5 -----
 drivers/firmware/efi/efi-init.c               | 14 +++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-entry.c |  8 +++++++-
 10 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c15dfdbe3d5ae..b808712e85981 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -939,10 +939,6 @@ static struct screen_info vgacon_screen_info = {
 };
 #endif
 
-#if defined(CONFIG_EFI)
-struct screen_info screen_info;
-#endif
-
 static int __init customize_machine(void)
 {
 	/*
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 3f8c9c143552f..0228001347bea 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -71,10 +71,6 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 	return pgprot_val(PAGE_KERNEL_EXEC);
 }
 
-/* we will fill this structure from the stub, so don't put it in .bss */
-struct screen_info screen_info __section(".data");
-EXPORT_SYMBOL(screen_info);
-
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
 	pteval_t prot_val = create_mapping_protection(md);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 35f3c79595137..5e4dc72ab1bda 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -27,7 +27,9 @@ PROVIDE(__efistub__text			= _text);
 PROVIDE(__efistub__end			= _end);
 PROVIDE(__efistub___inittext_end       	= __inittext_end);
 PROVIDE(__efistub__edata		= _edata);
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 PROVIDE(__efistub_screen_info		= screen_info);
+#endif
 PROVIDE(__efistub__ctype		= _ctype);
 
 PROVIDE(__pi___memcpy			= __pi_memcpy);
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 9fc10cea21e10..acb5d3385675c 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -68,6 +68,11 @@ void __init efi_runtime_init(void)
 
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
+#if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
+struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL_GPL(screen_info);
+#endif
+
 static void __init init_screen_info(void)
 {
 	struct screen_info *si;
@@ -115,7 +120,8 @@ void __init efi_init(void)
 
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
-	init_screen_info();
+	if (IS_ENABLED(CONFIG_EFI_EARLYCON) || IS_ENABLED(CONFIG_SYSFB))
+		init_screen_info();
 
 	if (boot_memmap == EFI_INVALID_TABLE_ADDR)
 		return;
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index e561989d02de9..5087416b9678d 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -12,7 +12,9 @@ __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
 __efistub_kernel_fsize		= kernel_fsize;
 __efistub_kernel_offset		= kernel_offset;
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 __efistub_screen_info		= screen_info;
+#endif
 
 #endif
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 0d5edf1f7e4a1..407cd6b49bef6 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -16,7 +16,6 @@
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
-#include <linux/screen_info.h>
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
@@ -57,10 +56,6 @@
 #define SMBIOS_CORE_PACKAGE_OFFSET	0x23
 #define LOONGSON_EFI_ENABLE		(1 << 3)
 
-#ifdef CONFIG_EFI
-struct screen_info screen_info __section(".data");
-#endif
-
 unsigned long fw_arg0, fw_arg1, fw_arg2;
 DEFINE_PER_CPU(unsigned long, kernelsp);
 struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index ea1a10355ce90..3df30dd1c458b 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -28,7 +28,9 @@ __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
 __efistub__edata		= _edata;
 __efistub___init_text_end	= __init_text_end;
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 __efistub_screen_info		= screen_info;
+#endif
 
 #endif
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 0c466a50f1744..0624f44d43eca 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -15,7 +15,6 @@
 #include <linux/memblock.h>
 #include <linux/sched.h>
 #include <linux/console.h>
-#include <linux/screen_info.h>
 #include <linux/of_fdt.h>
 #include <linux/sched/task.h>
 #include <linux/smp.h>
@@ -40,10 +39,6 @@
 
 #include "head.h"
 
-#if defined(CONFIG_EFI)
-struct screen_info screen_info __section(".data");
-#endif
-
 /*
  * The lucky hart to first increment this variable will boot the other cores.
  * This is used before the kernel initializes the BSS so it can't be in the
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index ef0820f1a9246..d4987d0130801 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -55,6 +55,15 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 
 extern __weak const efi_config_table_type_t efi_arch_tables[];
 
+/*
+ * x86 defines its own screen_info and uses it even without EFI,
+ * everything else can get it from here.
+ */
+#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
+struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL_GPL(screen_info);
+#endif
+
 static void __init init_screen_info(void)
 {
 	struct screen_info *si;
@@ -240,5 +249,8 @@ void __init efi_init(void)
 	memblock_reserve(data.phys_map & PAGE_MASK,
 			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
 
-	init_screen_info();
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_SYSFB) ||
+	    IS_ENABLED(CONFIG_EFI_EARLYCON))
+		init_screen_info();
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index 2f1902e5d4075..a6c0498351905 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -13,7 +13,13 @@ struct screen_info *alloc_screen_info(void)
 {
 	if (IS_ENABLED(CONFIG_ARM))
 		return __alloc_screen_info();
-	return (void *)&screen_info + screen_info_offset;
+
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
+	    IS_ENABLED(CONFIG_SYSFB))
+		return (void *)&screen_info + screen_info_offset;
+
+	return NULL;
 }
 
 /*
-- 
2.39.2

