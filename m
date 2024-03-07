Return-Path: <linux-kernel+bounces-95805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCB875302
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43023B29C52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6912EBEE;
	Thu,  7 Mar 2024 15:17:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070212AACC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824678; cv=none; b=ky553s2qFGGQl6rMTsQnkg2c+Ya8geQaZg0rmO0Loh8+GY04ZdigPKNgMmnrvg+73tk/DWI34f3st5s9algy4pjHBRtCoYkfAmbWFKpJoDwVKNkAsjFGNTKnQdRsMByeWXf9iZS0rNTiPuzty7bW4hTMMl4/N2S+R1Hq12CpMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824678; c=relaxed/simple;
	bh=5DWssUIGR3KV6TRdXCF5ssSzXxz005yYj66HEPTdEps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uep1etoP5oaP5vbBSACYih+ky/xvC7dH1y04cEXDZ6+NA0/B/5+9YV7L0tXr0Pfbb/enxQjRTt46XsavrcLcuMVN/4ILrwRQ/qLLzZpJhTL2B5T158ucMFTn46Nks7VTdJ2cf7QLEbMNC4W8JchVHtJqqk/SOJWDfG5sjm996m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TrCZj13sbzbcdY;
	Thu,  7 Mar 2024 23:17:01 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 155A5140134;
	Thu,  7 Mar 2024 23:17:44 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 7 Mar
 2024 23:17:43 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <arnd@arndb.de>, <linux@armlinux.org.uk>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
	<geert+renesas@glider.be>, <corbet@lwn.net>, <rppt@kernel.org>,
	<robh@kernel.org>, <tglx@linutronix.de>, <linus.walleij@linaro.org>,
	<liuyuntao12@huawei.com>
Subject: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date: Thu, 7 Mar 2024 15:12:31 +0000
Message-ID: <20240307151231.654025-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)

The current arm32 architecture does not yet support the
HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
embedded scenarios, and enabling this feature would be beneficial for
reducing the size of the kernel image.

In order to make this work, we keep the necessary tables by annotating
them with KEEP, also it requires further changes to linker script to KEEP
some tables and wildcard compiler generated sections into the right place.

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
---
v2:
   - Support config XIP_KERNEL.
   - Support LLVM compilation.

v1: https://lore.kernel.org/all/20240220081527.23408-1-liuyuntao12@huawei.com/
---
 arch/arm/Kconfig                       |  1 +
 arch/arm/boot/compressed/vmlinux.lds.S |  4 ++--
 arch/arm/include/asm/vmlinux.lds.h     | 18 +++++++++++++++++-
 arch/arm/kernel/vmlinux-xip.lds.S      |  8 ++++++--
 arch/arm/kernel/vmlinux.lds.S          | 10 +++++++---
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0af6709570d1..de78ceb821df 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -113,6 +113,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 3fcb3e62dc56..da21244aa892 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -89,7 +89,7 @@ SECTIONS
      * The EFI stub always executes from RAM, and runs strictly before the
      * decompressor, so we can make an exception for its r/w data, and keep it
      */
-    *(.data.efistub .bss.efistub)
+    *(.data.* .bss.*)
     __pecoff_data_end = .;
 
     /*
@@ -125,7 +125,7 @@ SECTIONS
 
   . = BSS_START;
   __bss_start = .;
-  .bss			: { *(.bss) }
+  .bss			: { *(.bss .bss.*) }
   _end = .;
 
   . = ALIGN(8);		/* the stack must be 64-bit aligned */
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 4c8632d5c432..dfe2b6ad6b51 100644
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
@@ -87,6 +87,22 @@
 		*(.vfp11_veneer)                                        \
 		*(.v4_bx)
 
+/*
+When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled, it is important to
+annotate .vectors sections with KEEP. While linking with ld, it is
+acceptable to directly use KEEP with .vectors sections in ARM_VECTORS.
+However, when using ld.lld for linking, KEEP is not recognized within the
+OVERLAY command; it is treated as a regular string. Hence, it is advisable
+to define a distinct section here that explicitly retains the .vectors
+sections when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is turned on.
+*/
+#define ARM_VECTORS_TEXT						\
+	.vectors.text : {						\
+		KEEP(*(.vectors))					\
+		KEEP(*(.vectors.bhb.loop8))				\
+		KEEP(*(.vectors.bhb.bpiall))				\
+       }
+
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
 		__entry_text_start = .;					\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index c16d196b5aad..035fa18060b3 100644
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
@@ -135,6 +135,10 @@ SECTIONS
 	ARM_TCM
 #endif
 
+#ifdef LD_DEAD_CODE_DATA_ELIMINATION
+	ARM_VECTORS_TEXT
+#endif
+
 	/*
 	 * End of copied data. We need a dummy section to get its LMA.
 	 * Also located before final ALIGN() as trailing padding is not stored
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index bd9127c4b451..2cfb890c93fb 100644
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
 
@@ -134,6 +134,10 @@ SECTIONS
 	ARM_TCM
 #endif
 
+#ifdef LD_DEAD_CODE_DATA_ELIMINATION
+	ARM_VECTORS_TEXT
+#endif
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	. = ALIGN(1<<SECTION_SHIFT);
 #else
-- 
2.34.1


