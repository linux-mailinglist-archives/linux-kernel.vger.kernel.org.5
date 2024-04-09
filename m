Return-Path: <linux-kernel+bounces-136276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E914689D22A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB0B2295E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AE7E105;
	Tue,  9 Apr 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NcMbSLG1"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC47D3E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643133; cv=none; b=uqR7D5bw9EHfZ95aWnTB1jhpBN+o2IC/Z9XlNlJAtd6YH7/KojZT/pzXwLE/Z/57nz3+P0lUR4P5xj283ynffiis3fXuONEIwghbwRLVRQh+dtUnw4oXI8ENjBJLByqAFDQrHVHAWyypR9mKe5r5kMwqp6lBchmadeiFEzx0sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643133; c=relaxed/simple;
	bh=GXPEZp/8gKXiorNDdGgsOhgButWgdgv8kuaNcEdkBlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gmy0q6A3H4738bNWNAwfXtHkZ/b6vkLpi30JaYfVdO50Z3lIjYppvE95kcJBPQ/coNRRRyaVGY+/tt2K/8FHJR91zYf+ihUUyE4FGvuzwwfjmQbmSipESmAUX1APV+H4EsNdte+PJ8IfBIKIhWlxLLIqIiRGhFgNAGsV1nGI6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NcMbSLG1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e424bd30fbso12505725ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643131; x=1713247931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNY0RFhYm6lPg3oBhR3wmdSfV39szkEasZZOlUo5Gu4=;
        b=NcMbSLG1IkNw6uTXPhXVgPiZpPewXDnByWEBqziQ9ltMKDiV65wuh7CLlOpTPPfxk5
         LzhtCkMjgqbUQ1KQKYAeLqX/tGWUQks2yyovlxL5y38udYE8SsuSqD7dPHlR5kjliEzl
         ZSfhO6lmK3Ha0B3s2leS+2vqqmg450P9wFZwbms3Dxv1kql59h7UhI50t+vHEJ6/X/Hs
         3Zb9CrhFB0DzEFp+Ue4YrTSkiKEI63sFxWJBkK+a9QX2/uSxH8G/25KYiV4g6IX2LPKy
         TZvgzGhEJRWyDpVN9HomfPX2iqNZXZYVWgmY5lhdJZW4UjNtwfTCEaS9i5Mevx9e7Xcb
         +b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643131; x=1713247931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNY0RFhYm6lPg3oBhR3wmdSfV39szkEasZZOlUo5Gu4=;
        b=eFyuR1lJCvNTS3eGPtDJR1QoFJHEruc+k/heegnDNzNycItw0j57mVvdpv1K7jy3QR
         cj7cCAyiPAIzGyX2wrFldUixx4fLza1IB7eYW2NRxfdDEnV4ctulCV4hPHbBUWNMwr+K
         REVSBzMZVz8lRugpFRCPHd4JKRBHmjWd5rf4Nrro8mSCHWPYn8Tt7081bJ1L2LxDT03j
         8kUOlaR8oozFK81HfYBflFJts6icE7XQObmvYq8DnqAX8qT86Kg1teRon6KcgF6FUwlf
         GWvy76Q9GK6uvzbBYPejm/1hIE6u/e3yjBo2flSgMdDEyOFpwXGx6FXaxbdUpkLXjkqg
         jMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwNyjjJQtYZXe/p58ySUJ0OmVgpGrnQd4nxA27x7YId+YjWsJFDh8mFBJru8+OijJhCphL+rP2GSNgDPd+Ni7U2CpfucPM7QNL8det
X-Gm-Message-State: AOJu0Yy3PHH28HwlrrEfC/b9e48VaqLrAwiziEdz2jUzCNQr1gfIT+H7
	8K0WQ1AVwL/dCeWLNLn8+K2gVPC8TpEpZ4oNgRQimKGs+TlxtQYu8WJvFoR0AgY=
X-Google-Smtp-Source: AGHT+IFZDIZkA5N71LX8YU8JB8f+xPvbHs9xL8jZhoQEYjrihrilZVPxCloqSIoWg5GmlNSe0WLS6g==
X-Received: by 2002:a17:903:40d2:b0:1e2:9676:c326 with SMTP id t18-20020a17090340d200b001e29676c326mr15385084pld.29.1712643131586;
        Mon, 08 Apr 2024 23:12:11 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:11 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 07/12] riscv/mm: prepare shadow stack for init task for kernel cfi
Date: Mon,  8 Apr 2024 23:10:38 -0700
Message-Id: <20240409061043.3269676-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under CONFIG_SHADOW_CALL_STACK, shadow call stack goes into data section.
Although with CONFIG_DYNAMIC_SCS on riscv, hardware assisted shadow stack
are used. Hardware assisted shadow stack on riscv uses PTE.R=0, PTE.W=1 &
PTE.X=0 encodings. Without CONFIG_DYNAMIC_SCS, shadow stack for init is
placed in data section and thus regular read/write encodings are applied
to it. Although with with CONFIG_DYNAMIC_SCS, they need to go into
different section. This change places it into `.shadowstack` section.
As part of this change early boot code (`setup_vm`), applies appropriate
PTE encodings to shadow call stack for init placed in `.shadowstack`
section.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h     |  4 ++++
 arch/riscv/include/asm/sections.h    | 22 +++++++++++++++++++++
 arch/riscv/include/asm/thread_info.h | 10 ++++++++--
 arch/riscv/kernel/vmlinux.lds.S      | 12 ++++++++++++
 arch/riscv/mm/init.c                 | 29 +++++++++++++++++++++-------
 5 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9f8ea0e33eb1..3409b250390d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -197,6 +197,10 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
 					 | _PAGE_EXEC)
 
+#ifdef CONFIG_DYNAMIC_SCS
+#define PAGE_KERNEL_SHADOWSTACK __pgprot(_PAGE_KERNEL & ~(_PAGE_READ | _PAGE_EXEC))
+#endif
+
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index a393d5035c54..4c4154d0021e 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -14,6 +14,10 @@ extern char __init_data_begin[], __init_data_end[];
 extern char __init_text_begin[], __init_text_end[];
 extern char __alt_start[], __alt_end[];
 extern char __exittext_begin[], __exittext_end[];
+#ifdef CONFIG_DYNAMIC_SCS
+extern char __init_shstk_start[], __init_shstk_end[];
+#endif
+extern char __end_srodata[];
 
 static inline bool is_va_kernel_text(uintptr_t va)
 {
@@ -31,4 +35,22 @@ static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
 	return va >= start && va < end;
 }
 
+#ifdef CONFIG_DYNAMIC_SCS
+static inline bool is_va_init_shadow_stack_early(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_start));
+	uintptr_t end = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_end));
+
+	return va >= start && va < end;
+}
+
+static inline bool is_va_init_shadow_stack(uintptr_t va)
+{
+	uintptr_t start = (uintptr_t)(__init_shstk_start);
+	uintptr_t end = (uintptr_t)(__init_shstk_end);
+
+	return va >= start && va < end;
+}
+#endif
+
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..7ae28d627f84 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -63,12 +63,18 @@ struct thread_info {
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
+#ifdef CONFIG_DYNAMIC_SCS
 #define INIT_SCS							\
-	.scs_base	= init_shadow_call_stack,			\
+	.scs_base	= init_shadow_call_stack,	\
+	.scs_sp		= &init_shadow_call_stack[SCS_SIZE / sizeof(long)],
+#else
+#define INIT_SCS							\
+	.scs_base	= init_shadow_call_stack,	\
 	.scs_sp		= init_shadow_call_stack,
+#endif /* CONFIG_DYNAMIC_SCS */
 #else
 #define INIT_SCS
-#endif
+#endif /* CONFIG_SHADOW_CALL_STACK */
 
 /*
  * macros/functions for gaining access to the thread information structure
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 002ca58dd998..cccc51f845ab 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -126,6 +126,18 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	. = ALIGN(SECTION_ALIGN);
+	__end_srodata = .;
+
+#ifdef CONFIG_DYNAMIC_SCS
+	.shadowstack : AT(ADDR(.shadowstack) - LOAD_OFFSET){
+		__init_shstk_start = .;
+		KEEP(*(.shadowstack..init))
+		. = __init_shstk_start + PAGE_SIZE;
+		__init_shstk_end = .;
+	}
+#endif
+
 	. = ALIGN(SECTION_ALIGN);
 	_data = .;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..5b6f0cfa5719 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -713,14 +713,22 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
 		return PAGE_KERNEL_READ;
 
+#ifdef CONFIG_DYNAMIC_SCS
+	/* If init task's shadow stack va, return write only page protections */
+	if (IS_ENABLED(CONFIG_64BIT) && is_va_init_shadow_stack(va)) {
+		pr_info("Shadow stack protections are being applied to for init\n");
+		return PAGE_KERNEL_SHADOWSTACK;
+	}
+#endif
+
 	return PAGE_KERNEL;
 }
 
 void mark_rodata_ro(void)
 {
-	set_kernel_memory(__start_rodata, _data, set_memory_ro);
+	set_kernel_memory(__start_rodata, __end_srodata, set_memory_ro);
 	if (IS_ENABLED(CONFIG_64BIT))
-		set_kernel_memory(lm_alias(__start_rodata), lm_alias(_data),
+		set_kernel_memory(lm_alias(__start_rodata), lm_alias(__end_srodata),
 				  set_memory_ro);
 }
 #else
@@ -913,14 +921,21 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 {
 	uintptr_t va, end_va;
+	pgprot_t prot;
 
 	end_va = kernel_map.virt_addr + kernel_map.size;
-	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
+	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE) {
+		prot = PAGE_KERNEL_EXEC;
+#ifdef CONFIG_DYNAMIC_SCS
+		if (early && is_va_init_shadow_stack_early(va))
+			prot = PAGE_KERNEL_SHADOWSTACK;
+#endif
 		create_pgd_mapping(pgdir, va,
-				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
-				   PMD_SIZE,
-				   early ?
-					PAGE_KERNEL_EXEC : pgprot_from_va(va));
+					kernel_map.phys_addr + (va - kernel_map.virt_addr),
+					PMD_SIZE,
+					early ?
+					prot : pgprot_from_va(va));
+	}
 }
 #endif
 
-- 
2.43.2


