Return-Path: <linux-kernel+bounces-130019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D353389734B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885BF28DE2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43C14A4D7;
	Wed,  3 Apr 2024 15:02:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58614A098
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156529; cv=none; b=UBIktQ1z6PEditD5W/57Z27FZiR6WshQ5TUJj46eM/zT3ZSaRQDrHkemfucLCib3LukETeIhCbcSs525ODgTymdR3ndYjTeAHbMyVwV+8zBrC6ECAIKt18JeUAGaNDzwFuCG5IEpCdlKiUo4lavBShBKpddHJFKWf02d5GLVCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156529; c=relaxed/simple;
	bh=6l3ztR+na6fIJOI07vhVnE8PPwhW1EVFzqZBqt5/uwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX++vnHLfcd10lvrD8X/OSDeLukLWDni7w8Vk/GaP9D/KlCw5oohZdL0r1GiykuCmRRoaDF5jyl1oOljZh3VAK5HS5ufgAXwsNwAunO/JyctbCw6BZWBKlsErwBF6tCHR7sSCtXiRe/f9ITjyio4wEMMr9Dzg3bs0isaiwGA7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3E361650;
	Wed,  3 Apr 2024 08:02:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 318DB3F7B4;
	Wed,  3 Apr 2024 08:02:05 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	davem@davemloft.net,
	jarkko@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	will@kernel.org
Subject: [PATCH v2 2/4] kprobes/treewide: Add kprobes_ prefix to insn alloc/free functions
Date: Wed,  3 Apr 2024 16:01:52 +0100
Message-Id: <20240403150154.667649-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240403150154.667649-1-mark.rutland@arm.com>
References: <20240403150154.667649-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alloc_(opt)insn_page() and free_(opt)insn_page() functions are
specific to KPROBES, but their name makes them sound more generic than
they are.

Given them a 'kprobes_' prefix to make it clear that they're part of
kprobes.

This was generated automatically with:

  sed -i 's/alloc_insn_page/kprobes_alloc_insn_page/' $(git grep -l 'alloc_insn_page')
  sed -i 's/free_insn_page/kprobes_free_insn_page/' $(git grep -l 'free_insn_page')
  sed -i 's/alloc_optinsn_page/kprobes_alloc_optinsn_page/' $(git grep -l 'alloc_optinsn_page')
  sed -i 's/free_optinsn_page/kprobes_free_optinsn_page/' $(git grep -l 'free_optinsn_page')

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
---
 arch/arm64/kernel/probes/kprobes.c |  2 +-
 arch/powerpc/kernel/kprobes.c      |  2 +-
 arch/powerpc/kernel/optprobes.c    |  4 ++--
 arch/riscv/kernel/probes/kprobes.c |  2 +-
 arch/s390/kernel/kprobes.c         |  2 +-
 arch/x86/kernel/kprobes/core.c     |  2 +-
 include/linux/kprobes.h            |  6 +++---
 kernel/kprobes.c                   | 20 ++++++++++----------
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 327855a11df2f..4b6ab7b1fa211 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -129,7 +129,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-void *alloc_insn_page(void)
+void *kprobes_alloc_insn_page(void)
 {
 	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
 			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index bbca90a5e2ec0..0b297718d5de6 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -126,7 +126,7 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
 	return (kprobe_opcode_t *)(addr + offset);
 }
 
-void *alloc_insn_page(void)
+void *kprobes_alloc_insn_page(void)
 {
 	void *page;
 
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 004fae2044a3e..0ddbda217073f 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -27,7 +27,7 @@
 
 static bool insn_page_in_use;
 
-void *alloc_optinsn_page(void)
+void *kprobes_alloc_optinsn_page(void)
 {
 	if (insn_page_in_use)
 		return NULL;
@@ -35,7 +35,7 @@ void *alloc_optinsn_page(void)
 	return &optinsn_slot;
 }
 
-void free_optinsn_page(void *page)
+void kprobes_free_optinsn_page(void *page)
 {
 	insn_page_in_use = false;
 }
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 2f08c14a933d0..75201ce721057 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -105,7 +105,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 }
 
 #ifdef CONFIG_MMU
-void *alloc_insn_page(void)
+void *kprobes_alloc_insn_page(void)
 {
 	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
 				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index f0cf20d4b3c58..91ca4d501d4ef 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -34,7 +34,7 @@ struct kretprobe_blackpoint kretprobe_blacklist[] = { };
 
 static int insn_page_in_use;
 
-void *alloc_insn_page(void)
+void *kprobes_alloc_insn_page(void)
 {
 	void *page;
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d0e49bd7c6f3f..7f01bbbfa9e2a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -491,7 +491,7 @@ static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
 }
 
 /* Make page to RO mode when allocate it */
-void *alloc_insn_page(void)
+void *kprobes_alloc_insn_page(void)
 {
 	void *page;
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ff44d6633e33..ad4b561100f9e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -430,10 +430,10 @@ int enable_kprobe(struct kprobe *kp);
 
 void dump_kprobe(struct kprobe *kp);
 
-void *alloc_insn_page(void);
+void *kprobes_alloc_insn_page(void);
 
-void *alloc_optinsn_page(void);
-void free_optinsn_page(void *page);
+void *kprobes_alloc_optinsn_page(void);
+void kprobes_free_optinsn_page(void *page);
 
 int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *sym);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e817928..35adf56430c9b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -110,7 +110,7 @@ enum kprobe_slot_state {
 	SLOT_USED = 2,
 };
 
-void __weak *alloc_insn_page(void)
+void __weak *kprobes_alloc_insn_page(void)
 {
 	/*
 	 * Use module_alloc() so this page is within +/- 2GB of where the
@@ -121,15 +121,15 @@ void __weak *alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
 
-static void free_insn_page(void *page)
+static void kprobes_free_insn_page(void *page)
 {
 	module_memfree(page);
 }
 
 struct kprobe_insn_cache kprobe_insn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
-	.alloc = alloc_insn_page,
-	.free = free_insn_page,
+	.alloc = kprobes_alloc_insn_page,
+	.free = kprobes_free_insn_page,
 	.sym = KPROBE_INSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
@@ -333,21 +333,21 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
 }
 
 #ifdef CONFIG_OPTPROBES
-void __weak *alloc_optinsn_page(void)
+void __weak *kprobes_alloc_optinsn_page(void)
 {
-	return alloc_insn_page();
+	return kprobes_alloc_insn_page();
 }
 
-void __weak free_optinsn_page(void *page)
+void __weak kprobes_free_optinsn_page(void *page)
 {
-	free_insn_page(page);
+	kprobes_free_insn_page(page);
 }
 
 /* For optimized_kprobe buffer */
 struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
-	.alloc = alloc_optinsn_page,
-	.free = free_optinsn_page,
+	.alloc = kprobes_alloc_optinsn_page,
+	.free = kprobes_free_optinsn_page,
 	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
-- 
2.30.2


