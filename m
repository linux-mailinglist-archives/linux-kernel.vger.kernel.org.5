Return-Path: <linux-kernel+bounces-105037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B087D800
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34301C21242
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87D4C7C;
	Sat, 16 Mar 2024 02:44:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40494C61
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710557088; cv=none; b=PaMX98xpJ7u1ZikA+rgA3B2WJBJuvIGkOO13HHQikpsJhQDOibq4CeHwvgpe2wdpvwzcYl4kymf2F2WYE2pOPInpN+v8Ua5epigI4mrbS5zqUcK5g+OqecA+Ddz/I5dFzXAr+8FpM9coZSkNYCvr039H/FBpPBtI7v0B+RPVmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710557088; c=relaxed/simple;
	bh=Jm4aKAWDjE+q969G/2wwzwl4NboEBX2wKFJi6ZuKQGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qITuyVKw2kDBaKCgeCVqwkR0cBW6L2OHS9AIu2uMSTV+t7MeFEIMeQsOpKsRl7XXNhIMqZAHL1ZochWGUVMIRegU7siMxDD0CVDnJL80Fv2u2tzSN6sDmIO1weKQJQuyza5tKNEdL/16F6loYZVBZC2VGkC/0YBlckDfLKOYrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TxQPc1529z1h2NK;
	Sat, 16 Mar 2024 10:42:12 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F1DA1A016C;
	Sat, 16 Mar 2024 10:44:41 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Sat, 16 Mar
 2024 10:44:41 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <arnd@arndb.de>, <ardb@kernel.org>, <geert@linux-m68k.org>,
	<linux@armlinux.org.uk>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<kirill.shutemov@linux.intel.com>, <geert+renesas@glider.be>,
	<corbet@lwn.net>, <rppt@kernel.org>, <robh@kernel.org>, <tglx@linutronix.de>,
	<linus.walleij@linaro.org>, <maskray@google.com>, <liuyuntao12@huawei.com>
Subject: [PATCH-next v4] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date: Sat, 16 Mar 2024 02:39:32 +0000
Message-ID: <20240316023932.700685-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100004.china.huawei.com (7.185.36.20)

The current arm32 architecture does not yet support the
HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
embedded scenarios, and enabling this feature would be beneficial for
reducing the size of the kernel image.

In order to make this work, we keep the necessary tables by annotating
them with KEEP, also it requires further changes to linker script to KEEP
some tables and wildcard compiler generated sections into the right place.
When using ld.lld for linking, KEEP is not recognized within the OVERLAY
command, and Ard proposed a concise method to solve this problem.

It boots normally with defconfig, vexpress_defconfig and tinyconfig.

The size comparison of zImage is as follows:
defconfig       vexpress_defconfig      tinyconfig
5137712         5138024                 424192          no dce
5032560         4997824                 298384          dce
2.0%            2.7%                    29.7%           shrink

When using smaller config file, there is a significant reduction in the
size of the zImage.

We also tested this patch on a commercially available single-board
computer, and the comparison is as follows:
a15eb_config
2161384         no dce
2092240         dce
3.2%            shrink

The zImage size has been reduced by approximately 3.2%, which is 70KB on
2.1M.

Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
v4:
   - remove -fdata-sections flag from KBUILD_CFLAGS_KERNEL in drivers/firmware/efi/libstub/Makefile

v3:
   - A better way to KEEP .vectors section for ld.lld linking.
   - https://lore.kernel.org/all/20240315063154.696633-1-liuyuntao12@huawei.com/

v2:
   - Support config XIP_KERNEL.
   - Support LLVM compilation.
   - https://lore.kernel.org/all/20240307151231.654025-1-liuyuntao12@huawei.com/

v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
---
 arch/arm/Kconfig                       | 1 +
 arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
 arch/arm/include/asm/vmlinux.lds.h     | 2 +-
 arch/arm/kernel/entry-armv.S           | 3 +++
 arch/arm/kernel/vmlinux-xip.lds.S      | 4 ++--
 arch/arm/kernel/vmlinux.lds.S          | 6 +++---
 drivers/firmware/efi/libstub/Makefile  | 4 ++++
 7 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17ab..45f25f6e7a62 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -114,6 +114,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 3fcb3e62dc56..d411abd4310e 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -125,7 +125,7 @@ SECTIONS
 
   . = BSS_START;
   __bss_start = .;
-  .bss			: { *(.bss) }
+  .bss			: { *(.bss .bss.*) }
   _end = .;
 
   . = ALIGN(8);		/* the stack must be 64-bit aligned */
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 4c8632d5c432..d60f6e83a9f7 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -42,7 +42,7 @@
 #define PROC_INFO							\
 		. = ALIGN(4);						\
 		__proc_info_begin = .;					\
-		*(.proc.info.init)					\
+		KEEP(*(.proc.info.init))				\
 		__proc_info_end = .;
 
 #define IDMAP_TEXT							\
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 6150a716828c..f01d23a220e6 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1065,6 +1065,7 @@ vector_addrexcptn:
 	.globl	vector_fiq
 
 	.section .vectors, "ax", %progbits
+	.reloc  .text, R_ARM_NONE, .
 	W(b)	vector_rst
 	W(b)	vector_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_swi		)
@@ -1078,6 +1079,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_swi		)
 
 #ifdef CONFIG_HARDEN_BRANCH_HISTORY
 	.section .vectors.bhb.loop8, "ax", %progbits
+	.reloc  .text, R_ARM_NONE, .
 	W(b)	vector_rst
 	W(b)	vector_bhb_loop8_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_loop8_swi	)
@@ -1090,6 +1092,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_bhb_loop8_swi	)
 	W(b)	vector_bhb_loop8_fiq
 
 	.section .vectors.bhb.bpiall, "ax", %progbits
+	.reloc  .text, R_ARM_NONE, .
 	W(b)	vector_rst
 	W(b)	vector_bhb_bpiall_und
 ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_bpiall_swi	)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index c16d196b5aad..5eddb75a7174 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -63,7 +63,7 @@ SECTIONS
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
-		ARM_MMU_KEEP(*(__ex_table))
+		ARM_MMU_KEEP(KEEP(*(__ex_table)))
 		__stop___ex_table = .;
 	}
 
@@ -83,7 +83,7 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index bd9127c4b451..de373c6c2ae8 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -74,7 +74,7 @@ SECTIONS
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
-		ARM_MMU_KEEP(*(__ex_table))
+		ARM_MMU_KEEP(KEEP(*(__ex_table)))
 		__stop___ex_table = .;
 	}
 
@@ -99,7 +99,7 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
@@ -116,7 +116,7 @@ SECTIONS
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 31eb1e287ce1..619f1f9d9ba9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -56,6 +56,10 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
+# The .data section would be renamed to .data.efistub, therefore, remove
+# `-fdata-sections` flag from KBUILD_CFLAGS_KERNEL
+KBUILD_CFLAGS_KERNEL := $(filter-out -fdata-sections, $(KBUILD_CFLAGS_KERNEL))
+
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
-- 
2.34.1


