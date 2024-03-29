Return-Path: <linux-kernel+bounces-125101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504B3892021
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DFB289328
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AB1EEE4;
	Fri, 29 Mar 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA8Ze5as"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91511182
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724206; cv=none; b=VviFDdrHbNlTizepYdot5F5VtwdAVFZc18mFEei09oyxYMFSfvxWbtqTteW0oNyWICnOSTMAery0pWuUJ+vJg7sSBKQBLmeNLnQLs+3VInrZhQXGYBPQdrfgS/Rciful4S8EPgnjNYPcNHVGWqpjuA7xkjqsBL5AL6qM9aGVcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724206; c=relaxed/simple;
	bh=CFW26xn5zbTqeC0GyRvzKF/msKnkLmnHrpqB8wrgEo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfrGVe+LlKRfEufgWFnsO3kFwVz8Q5aOpALi0VWsdjHIo0mkkhhepzmdeAJRpO5UOGxJ47l27YfXuXBo+0KsTL9mmJsHojG8I25dw4j3ZJ0hoi/NmR7TnZnqfXE7MJi1pIzKYYASeq4y9FJ07nru9gmQT6zU7qVtoHrYwxZVtvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA8Ze5as; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e38f941c6so67047166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724202; x=1712329002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsUlkYzw442RI4qHF46wvm4R0rzxgWigVON0ueOGsCA=;
        b=HA8Ze5assUHuK5gHXut9D7XUmYrFPrM6yjZ9IbkDP1Xyry+yorEAFq08TUxNwQNBLc
         KhqUEyW37iXjZ6lWJOpnkQmJv+2AEx2IYsb67IvSjprhANWkft03BJSAtc+6ZFX/VVgC
         ebdx8VH1UZnU9VZjGEnC1q5ojDnMLqf33jgTg9Q/miDAPwVWo2VeLDXDQjJRoHlequ9l
         N2IYzU3SK1lMZ/giQKJ65SFrWVxfONBseG8P+gPKavC+m7FWh0M5T18tcE5T6lEQQppt
         1Pp2gLbbTP8G2ewOSOjfsl5h63nCPeqgGK4+bMffdlPSlUVMld7Uaag+b8F5hWfuTpnA
         mlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724202; x=1712329002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsUlkYzw442RI4qHF46wvm4R0rzxgWigVON0ueOGsCA=;
        b=ooOP5QQpf8O9gcogXkF/9vdZBasU0W1ZdscMKiK96n629ooPm5dDVzt4EMzG3EvXrm
         fbwvrMO+RK3C3XUFmqFFxEFO+yVNunxKU4xvcBVRPCt9JJCRFDYC8gPaSV9Z06++v2X6
         ZbfLBbALcmJZYkxI0GCclHfBQcwOnbNLVmFh0yp7GuhBxH3LYxSrFbGw4SEf5YLe+pc+
         EXeDYslu8PgVSBPG/EqxYYjpVY0mAw6f5r3wAIaHHF1670IdcWZss8nRS3H6HEqgITS2
         N/sjWp4oP2BZznGHn8oJo3cvxXLyFnu3KXd2wvRl2LnuueWFpRAAIxK9hfnr4WmlFNtS
         TV/A==
X-Gm-Message-State: AOJu0YwZPpJw0vz3NqrnGj+SJmv+6iczQ0xSlZUEhGBP3r4MMcO48siI
	3ENKy2b5q5iKSzdQOWxHZKAcpqMi0r1fcGFpIBknNauHTMb0MyJl5UBbyOfkM4E=
X-Google-Smtp-Source: AGHT+IH5qjcVDhzFMNsiXL9Tn/9WkDZgTXqvMy4P+gEbuvCuEFLXgADIgfkPH1RvOpCout3gkWLM1Q==
X-Received: by 2002:a17:907:868a:b0:a46:c11d:dd01 with SMTP id qa10-20020a170907868a00b00a46c11ddd01mr2124294ejc.50.1711724202314;
        Fri, 29 Mar 2024 07:56:42 -0700 (PDT)
Received: from yjn-Lenovo-V14-G2-ITL.fritz.box (p200300dcbf196600f6ba6208ca0ed095.dip0.t-ipconnect.de. [2003:dc:bf19:6600:f6ba:6208:ca0e:d095])
        by smtp.gmail.com with ESMTPSA id q16-20020a1709060e5000b00a47531764fdsm2011866eji.65.2024.03.29.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:56:41 -0700 (PDT)
From: York Jasper Niebuhr <yjnworkstation@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: init_mlocked_on_free_v3
Date: Fri, 29 Mar 2024 15:56:05 +0100
Message-Id: <20240329145605.149917-1-yjnworkstation@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the "init_mlocked_on_free" boot option. When this boot option
is enabled, any mlock'ed pages are zeroed on free. If
the pages are munlock'ed beforehand, no initialization takes place.
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
 mm/memory.c                                   |  6 +++
 mm/mm_init.c                                  | 43 ++++++++++++++++---
 mm/page_alloc.c                               |  2 +-
 security/Kconfig.hardening                    | 15 +++++++
 7 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c14b2f6..34bdbf29aaf9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2148,6 +2148,12 @@
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
index 8eccaabe44ee..a216489aef2b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3751,7 +3751,14 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
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
index 8e11f7b2da21..8ec85b5e62e6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -506,6 +506,7 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
+extern void kernel_init_pages(struct page *page, int numpages);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
diff --git a/mm/memory.c b/mm/memory.c
index 36191a9c799c..706361b9d1af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1506,6 +1506,12 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		if (unlikely(page_mapcount(page) < 0))
 			print_bad_pte(vma, addr, ptent, page);
 	}
+
+	if (want_init_mlocked_on_free() && folio_test_mlocked(folio) &&
+	    !delay_rmap && folio_test_anon(folio)) {
+		kernel_init_pages(page, folio_nr_pages(folio));
+	}
+
 	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
 		*force_flush = true;
 		*force_break = true;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e3450f12d79a..bede28e8d7cc 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2515,6 +2515,9 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
+EXPORT_SYMBOL(init_mlocked_on_free);
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -2532,6 +2535,14 @@ static int __init early_init_on_free(char *buf)
 }
 early_param("init_on_free", early_init_on_free);
 
+static bool _init_mlocked_on_free_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON);
+static int __init early_init_mlocked_on_free(char *buf)
+{
+	return kstrtobool(buf, &_init_mlocked_on_free_enabled_early);
+}
+early_param("init_mlocked_on_free", early_init_mlocked_on_free);
+
 DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
 /*
@@ -2559,12 +2570,21 @@ static void __init mem_debugging_and_hardening_init(void)
 	}
 #endif
 
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early ||
+	    _init_mlocked_on_free_enabled_early) &&
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
@@ -2581,9 +2601,17 @@ static void __init mem_debugging_and_hardening_init(void)
 		static_branch_disable(&init_on_free);
 	}
 
-	if (IS_ENABLED(CONFIG_KMSAN) &&
-	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
-		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+	if (_init_mlocked_on_free_enabled_early) {
+		want_check_pages = true;
+		static_branch_enable(&init_mlocked_on_free);
+	} else {
+		static_branch_disable(&init_mlocked_on_free);
+	}
+
+	if (IS_ENABLED(CONFIG_KMSAN) && (_init_on_alloc_enabled_early ||
+	    _init_on_free_enabled_early || _init_mlocked_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc, init_on_free and "
+			"init_mlocked_on_free are disabled when running KMSAN\n");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
@@ -2622,9 +2650,10 @@ static void __init report_meminit(void)
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
index 5b8ab1bfb9d5..8a8ca555b9d6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1038,7 +1038,7 @@ static inline bool should_skip_kasan_poison(struct page *page)
 	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
 }
 
-static void kernel_init_pages(struct page *page, int numpages)
+void kernel_init_pages(struct page *page, int numpages)
 {
 	int i;
 
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

base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
-- 
2.34.1


