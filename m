Return-Path: <linux-kernel+bounces-72581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3485B586
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC71C21470
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C585D905;
	Tue, 20 Feb 2024 08:39:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF5D8EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418356; cv=none; b=sNCYtodrhviamFLL53zYvBCbOx+Fw5l05urcukrW7YrU0SVN7uZMISUnJzB7cRt6p47IdO66B/fWxuJvWsPxSyuNh3OE+FcwcisjkdcJDM4OA6LqIZO1z7DCRMs5FQoG/hwDwPS1TND4UdFx56v07E2wBdpVdKcJfao4DdPOH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418356; c=relaxed/simple;
	bh=eARWGRfRDmOm0P/pwF6ioHyIv/3ArkeboFaDCJ2mAEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgbH9UVXlVgzDWUwpaAi/TMQEfYL2HhI7IT9NvQSP45ZgUVcXEq5NET4/kICO8IN8G7kn1JyFzH/u5rzPqPunyFHVtag6nkcDsdkEzSF9+Tq0nf1iYrq4+Md4ZRqac7B+qeFg0GGPpfYu1REFEpjsvFYqT7pL059ZFSVAff7yhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TfC2r4hVpzvVnw;
	Tue, 20 Feb 2024 16:18:12 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id DADAC140154;
	Tue, 20 Feb 2024 16:20:13 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 20 Feb
 2024 16:20:13 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
	<geert+renesas@glider.be>, <corbet@lwn.net>, <rppt@kernel.org>,
	<eric.devolder@oracle.com>, <robh@kernel.org>, <tglx@linutronix.de>,
	<linus.walleij@linaro.org>, <liuyuntao12@huawei.com>
Subject: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date: Tue, 20 Feb 2024 08:15:27 +0000
Message-ID: <20240220081527.23408-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 arch/arm/Kconfig                       | 1 +
 arch/arm/boot/compressed/vmlinux.lds.S | 4 ++--
 arch/arm/include/asm/vmlinux.lds.h     | 8 ++++----
 arch/arm/kernel/vmlinux.lds.S          | 6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)

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
index 4c8632d5c432..f2ff79f740ab 100644
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
@@ -125,13 +125,13 @@
 	__vectors_lma = .;						\
 	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
 		.vectors {						\
-			*(.vectors)					\
+			KEEP(*(.vectors))				\
 		}							\
 		.vectors.bhb.loop8 {					\
-			*(.vectors.bhb.loop8)				\
+			KEEP(*(.vectors.bhb.loop8))			\
 		}							\
 		.vectors.bhb.bpiall {					\
-			*(.vectors.bhb.bpiall)				\
+			KEEP(*(.vectors.bhb.bpiall))			\
 		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
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
 
-- 
2.34.1


