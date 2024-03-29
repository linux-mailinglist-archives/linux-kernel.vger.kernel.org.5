Return-Path: <linux-kernel+bounces-124452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B08891834
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C021F22B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D341208;
	Fri, 29 Mar 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfn/jh2r"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28A2A1A5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713323; cv=none; b=FmXhS5nep7XxZ6OS+2/Pnu9Dm5ydr+v69c80GKj9bnEhb42d3vmPp3/7cuhnu6rKfBs8HVFZI3zxEpU7R5Zba9hlpoBOXtqRV3J5ZSqrbbhNnHA+AsfwRs8441Dnj/SDAlYyXShVM/APma+lMI8c84y/G1RSsk5mRNa8LkS99fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713323; c=relaxed/simple;
	bh=NInR/f6NTTEjGmCpKb6+AeIl217vxPsQiu3S6fH5cQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOsCX+tLR4KCWN2yCWrD6ZxFr1ywQScIkCCvVBc4yVxzA0g0ezhfXCoi4Jlgss89OlIDGOnz0SSqjUqhnNsVflu+JQNlryL2ZQyVMUMKR14ltXhlbApHlp3v9KPGPNn6ewinANOCIFX9gBR+hccNGafkizNf0XfsSy4XbiqMIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfn/jh2r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4e28b10a53so152207366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711713320; x=1712318120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIxw1PcXGefM3kdpxyhMRDNDxZIx4eG1CWgE8oLWWJs=;
        b=Lfn/jh2rXlQwCNAlHTf+11OYej5n5V2iK/GVM2N7x4VY5H91aAwmESgaAr/bDNo/v7
         BZfzFNzpuecg+Ow3eKL2zpQwFzomzsxmXXxjiNEASYshTslObMPwj3eA7nQh2DN42/9/
         fw8gdNIGuv9n1HrdptZlt1Z4B91KlGgddfxds+USASiNyddYdoQuFrWSkg2gdyrTKaB0
         jL1DtBoCQM4g4eBG5Qp/KJ1anXHXQ8qLhdb1iVe8t7Sv0rdA4E49qDUj54wqRy0L5UOx
         F0jtn14RQ+Wc9sHaG+6KC4Q3OTDOuCDoL0gZG8etIF7aoH8YJ5ulIJRIn03OzFWQOXa4
         OQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711713320; x=1712318120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIxw1PcXGefM3kdpxyhMRDNDxZIx4eG1CWgE8oLWWJs=;
        b=nEglZk11n4mf8wxt8TmocRq6jMtJ5GYcgeEziXMRfC9184PA8ScDjqcwhMXzg1BTAn
         eDDTG7x8BMkXECjsj0CZkoiMDNfOx+E7WF9eee/Sd217toVNlmYEWATaU54c/EdcqsRg
         lxE/9hnwBZwvRZ/AqC9UVkumxEjFDOZhSdnrPC//rOcpOq03FwmIrvuKfCSklJAxQzx5
         mArkW8QVZVoodcNBAoQIgKRm9ZdbJVSfAwbt50at+Bz35hE2Dt8WHXMAPyc6ETbp2uaq
         9KJZK/FsNWSAKg9jwf76bB8UaMpoRbgW5Lxl9ZTRdNYbFuwMVlYkaKIvDq+JpJmBL5mf
         s8eQ==
X-Gm-Message-State: AOJu0YwdkRCYsIfJae1xf2vWlXl7rJed9EGPeegjEF297ldvY5sLcDuO
	j1aoGnciI5H1uYDIU0dI8FCsb2sN8mjs+mxvG/lcBFNVmYyhe5+2
X-Google-Smtp-Source: AGHT+IG9zVoRV47w2xMtdfOHPvRAA4Up+2xDXK5mDuSQe4CXd5hCfUHD+L4MCoQDkigY4XPkmPYQ+g==
X-Received: by 2002:a17:906:a043:b0:a4e:287c:255a with SMTP id bg3-20020a170906a04300b00a4e287c255amr1279274ejb.12.1711713319307;
        Fri, 29 Mar 2024 04:55:19 -0700 (PDT)
Received: from yjn-Lenovo-V14-G2-ITL.fritz.box (p200300dcbf1966000d807ab11579b0e4.dip0.t-ipconnect.de. [2003:dc:bf19:6600:d80:7ab1:1579:b0e4])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906590600b00a46e56c8764sm1843529ejq.114.2024.03.29.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:55:18 -0700 (PDT)
From: York Jasper Niebuhr <yjnworkstation@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@linux.intel.com,
	linux-mm@kvack.org,
	York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: init_mlocked_on_free_v3
Date: Fri, 29 Mar 2024 12:54:46 +0100
Message-Id: <20240329115446.424923-1-yjnworkstation@gmail.com>
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
index 36191a9c799c..861d93c3e444 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1506,6 +1506,12 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		if (unlikely(page_mapcount(page) < 0))
 			print_bad_pte(vma, addr, ptent, page);
 	}
+
+	if (want_init_mlocked_on_free() && folio_test_mlocked(folio)
+		&& !delay_rmap && folio_test_anon(folio)) {
+		kernel_init_pages(page, 1);
+	}
+
 	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
 		*force_flush = true;
 		*force_break = true;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e3450f12d79a..d99b3e21686d 100644
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
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early
+		|| _init_mlocked_on_free_enabled_early) &&
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
+	if (IS_ENABLED(CONFIG_KMSAN) && (_init_on_alloc_enabled_early
+		|| _init_on_free_enabled_early || _init_mlocked_on_free_enabled_early))
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


