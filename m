Return-Path: <linux-kernel+bounces-42189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886B83FDAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF741C2276E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236A4436D;
	Mon, 29 Jan 2024 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXvUOtGW"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4D4205B;
	Mon, 29 Jan 2024 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505552; cv=none; b=M9+IfkEm/tyozhrERq60gQJn3xBmMws6YVTm0aIrg+pmmqTm0wdBkhC7IJ4W/x1P5idNv+Abfr54IAMHt3kqeqZwh/w/pe4dREJlhX0lDQptRtfnz4xW0YjYKUW+H2SVaHzcnu9p4S2YOUqSz+7upSCMzVw4psMUuqm7bEwg1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505552; c=relaxed/simple;
	bh=SsqnRaxPcSWLAyOmvuU/fWRqxu6kFrblt0l6TtiZ0hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmnnpt7MktHBiSB1U5u/PIDn1f28tC4zEvjfBFqQAtvC8p+f6ZENb5XLYwfkIFUckD3NkSMU4YNkJHuIlvrn7VLRxwZF6bKWg9Dcfbyc/dDqZ5ef6b5rAPh89LFKC7Jx3S4cczS1dEgPL8rk04pO4BbdskwhOFU72gKrnnwUKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXvUOtGW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55eb1f9d1f0so2624795a12.0;
        Sun, 28 Jan 2024 21:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706505549; x=1707110349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICVSe/AwXm+cw5Tn0+loDdbzGUBAlelr2GwOdEL5v7s=;
        b=KXvUOtGWF1x08WjO7+h/2LrdGa/dKxkmG1Olld55lJMewtmaid2IxG8jC1sbzhRbjJ
         deRAdqirns9IXom3TjakvCwHg52bL2rok0Q+Vc6SAx0og/gcIQjNszK+yYu99/s0wVFK
         +BJRkyEXOZXkpzAqqgAEOGyaLj0ah3ZrzPmDvHAAV/2UYz8TOU82tf1hdzfaC7GYZG3k
         mRCh4yZWVFKwp3VcaeWVo0vDTPqYTUxVVZvC7blqBh0DcuYvi1ZbD0qAbGCXEmmjsMzk
         7JNnSk8OCMKkpY+IiL7x5c0+iPiDg1VUkpp22Q4s21TZJc6qw0W4Uq9LLCQthSglQXvG
         735w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706505549; x=1707110349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICVSe/AwXm+cw5Tn0+loDdbzGUBAlelr2GwOdEL5v7s=;
        b=rvCYQC66flAruup9Nmp9szpCcutAzH31RWeTOAz9Qd5IOJn+UgI/LD3Ypn6XQw3wdc
         /BxNHll4rz4eNNpTQ5pP/CjJUCjfyZzTsYF5NDnfEG0a90yt2af9EgN6+5lPeyhZQTm1
         /HKYR6PHWof2G6V+E/4fXIW2Fz0GRVqwEv3kZuIotGe/Q1pJDVnD5lTiCPzeTvZBRaJi
         9j/xupqBJ4hLt0+fvGhQZ5ZtjRSwpTa+f6OOoL+bnp/Jb+NZIpRXPESPJIbpdC9V6kr7
         tP4ckrPMnrY2jb4C+m5LHo0eveJ+lOQG5ooZE/eNfyWNbIizzfAZBAUq34+O5MdAq09C
         fCDg==
X-Gm-Message-State: AOJu0Yx+A+qRSdcT6HhJPJOc60k0+uEgRGTb+/spbL8kGFYpGFTkFuu9
	5SQzN5pDNJlysdbc3MgTY0VZuzcYqIowB52K594kQlNKXoUaxRjv8X/qEQ/YBgA=
X-Google-Smtp-Source: AGHT+IF/Hk2qV7yQ70GlPBXQxpxstd9ZKXls/l+dHxRG0cQZyAx88vLjEIdfP0mB21cfpI7jpZuecQ==
X-Received: by 2002:a17:906:bf44:b0:a35:922e:2ebe with SMTP id ps4-20020a170906bf4400b00a35922e2ebemr2890009ejb.12.1706505548281;
        Sun, 28 Jan 2024 21:19:08 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.Speedport_W_724V_01011603_07_008 (p200300cddf2975243c92616a59db5942.dip0.t-ipconnect.de. [2003:cd:df29:7524:3c92:616a:59db:5942])
        by smtp.gmail.com with ESMTPSA id vo2-20020a170907a80200b00a352c0bb7basm2659457ejc.81.2024.01.28.21.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 21:19:07 -0800 (PST)
From: York Jasper Niebuhr <yjnworkstation@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@linux.intel.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: init_mlocked_on_free_v2
Date: Mon, 29 Jan 2024 06:18:07 +0100
Message-Id: <20240129051807.308318-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the "init_mlocked_on_free" boot option. When this boot option
is enabled, any mlock'ed pages are zeroed on munmap, exit or exec. If
the pages are munlock'ed beforehand, no initialization will take place.
This boot option is meant to combat the performance hit of
"init_on_free" as reported in commit 6471384af2a6 ("mm: security:
introduce init_on_alloc=1 and init_on_free=1 boot options"). With
"init_mlocked_on_free=1" only relevant data is freed while everything
else is left untouched by the kernel. Correspondingly, this patch
introduces no performance hit for unmapping non-mlock'ed memory. The
unmapping overhead for purely mlocked memory was measured to be
approximately 13%. Realistically, most systems mlock only a fraction of
the total memory so the real-world system overhead should be close to
zero.

Optimally, userspace programs clear any key material or other
confidential memory before exit and munlock the according memory
regions. If a program crashes, userspace key managers fail to do this
job. Accordingly, no munlock operations are performed so the data is
caught and zeroed by the kernel. Should the program not crash, all
memory will ideally be munlocked so no overhead is caused.

CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON can be set to enable
"init_mlocked_on_free" by default.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 include/linux/mm.h                            |  9 +++-
 mm/internal.h                                 |  1 +
 mm/memory.c                                   |  7 +++
 mm/mm_init.c                                  | 43 ++++++++++++++++---
 mm/page_alloc.c                               | 22 +++++-----
 security/Kconfig.hardening                    | 15 +++++++
 7 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2e76c3476e2a..65dc1d6a20b4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2107,6 +2107,12 @@
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
 
+	init_mlocked_on_free=	[MM] Fill freed userspace memory with zeroes if
+				it was mlock'ed and not explicitly munlock'ed
+				afterwards.
+				Format: 0 | 1
+				Default set by CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON
+
 	init_pkru=	[X86] Specify the default memory protection keys rights
 			register contents for all processes.  0x55555554 by
 			default (disallow access to all but pkey 0).  Can
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..a64dd29e4bb6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3702,7 +3702,14 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
 	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
-				   &init_on_free);
+				&init_on_free);
+}
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
+static inline bool want_init_mlocked_on_free(void)
+{
+	return static_branch_maybe(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON,
+				&init_mlocked_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..f8668d2d53f4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -397,6 +397,7 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
+extern void kernel_init_pages(struct page *page, int numpages);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..8799bf3a93a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1462,6 +1462,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 			folio = page_folio(page);
 			delay_rmap = 0;
+
 			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
 					folio_set_dirty(folio);
@@ -1479,6 +1480,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				if (unlikely(page_mapcount(page) < 0))
 					print_bad_pte(vma, addr, ptent, page);
 			}
+
+			if (want_init_mlocked_on_free() && folio_test_mlocked(folio)
+					&& !delay_rmap && folio_test_anon(folio)) {
+				kernel_init_pages(page, 1);
+			}
+
 			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 89dc29f1e6c6..032364c1d2d3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2580,6 +2580,9 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
+EXPORT_SYMBOL(init_mlocked_on_free);
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -2597,6 +2600,15 @@ static int __init early_init_on_free(char *buf)
 }
 early_param("init_on_free", early_init_on_free);
 
+static bool _init_mlocked_on_free_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON);
+
+static int __init early_init_mlocked_on_free(char *buf)
+{
+	return kstrtobool(buf, &_init_mlocked_on_free_enabled_early);
+}
+early_param("init_mlocked_on_free", early_init_mlocked_on_free);
+
 DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
 /*
@@ -2624,12 +2636,21 @@ static void __init mem_debugging_and_hardening_init(void)
 	}
 #endif
 
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early
+				|| _init_mlocked_on_free_enabled_early) &&
 	    page_poisoning_requested) {
 		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-			"will take precedence over init_on_alloc and init_on_free\n");
+			"will take precedence over init_on_alloc, init_on_free "
+			"and init_mlocked_on_free\n");
 		_init_on_alloc_enabled_early = false;
 		_init_on_free_enabled_early = false;
+		_init_mlocked_on_free_enabled_early = false;
+	}
+
+	if (_init_mlocked_on_free_enabled_early && _init_on_free_enabled_early) {
+		pr_info("mem auto-init: init_on_free is on, "
+			"will take precedence over init_mlocked_on_free\n");
+		_init_mlocked_on_free_enabled_early = false;
 	}
 
 	if (_init_on_alloc_enabled_early) {
@@ -2646,9 +2667,18 @@ static void __init mem_debugging_and_hardening_init(void)
 		static_branch_disable(&init_on_free);
 	}
 
+	if (_init_mlocked_on_free_enabled_early) {
+		want_check_pages = true;
+		static_branch_enable(&init_mlocked_on_free);
+	} else {
+		static_branch_disable(&init_mlocked_on_free);
+	}
+
 	if (IS_ENABLED(CONFIG_KMSAN) &&
-	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
-		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early
+	     || _init_mlocked_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc, init_on_free and "
+				"init_mlocked_on_free are disabled when running KMSAN\n");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
@@ -2687,9 +2717,10 @@ static void __init report_meminit(void)
 	else
 		stack = "off";
 
-	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s, mlocked free:%s\n",
 		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
-		want_init_on_free() ? "on" : "off");
+		want_init_on_free() ? "on" : "off",
+		want_init_mlocked_on_free() ? "on" : "off");
 	if (want_init_on_free())
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5be4cd8f6b5a..1454eb1be450 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1069,17 +1069,6 @@ static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
 	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
 }
 
-static void kernel_init_pages(struct page *page, int numpages)
-{
-	int i;
-
-	/* s390's use of memset() could override KASAN redzones. */
-	kasan_disable_current();
-	for (i = 0; i < numpages; i++)
-		clear_highpage_kasan_tagged(page + i);
-	kasan_enable_current();
-}
-
 static __always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order, fpi_t fpi_flags)
 {
@@ -1281,6 +1270,17 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	__count_vm_events(PGFREE, 1 << order);
 }
 
+void kernel_init_pages(struct page *page, int numpages)
+{
+	int i;
+
+	/* s390's use of memset() could override KASAN redzones. */
+	kasan_disable_current();
+	for (i = 0; i < numpages; i++)
+		clear_highpage_kasan_tagged(page + i);
+	kasan_enable_current();
+}
+
 void __free_pages_core(struct page *page, unsigned int order)
 {
 	unsigned int nr_pages = 1 << order;
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 2cff851ebfd7..effbf5982be1 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -255,6 +255,21 @@ config INIT_ON_FREE_DEFAULT_ON
 	  touching "cold" memory areas. Most cases see 3-5% impact. Some
 	  synthetic workloads have measured as high as 8%.
 
+config INIT_MLOCKED_ON_FREE_DEFAULT_ON
+	bool "Enable mlocked memory zeroing on free"
+	depends on !KMSAN
+	help
+	  This config has the effect of setting "init_mlocked_on_free=1"
+	  on the kernel command line. If it is enabled, all mlocked process
+	  memory is zeroed when freed. This restriction to mlocked memory
+	  improves performance over "init_on_free" but can still be used to
+	  protect confidential data like key material from content exposures
+	  to other processes, as well as live forensics and cold boot attacks.
+	  Any non-mlocked memory is not cleared before it is reassigned. This
+	  configuration can be overwritten by setting "init_mlocked_on_free=0"
+	  on the command line. The "init_on_free" boot option takes
+	  precedence over "init_mlocked_on_free".
+
 config CC_HAS_ZERO_CALL_USED_REGS
 	def_bool $(cc-option,-fzero-call-used-regs=used-gpr)
 	# https://github.com/ClangBuiltLinux/linux/issues/1766

base-commit: bffdfd2e7e63175ae261131a620f809d946cf9a7
-- 
2.34.1


