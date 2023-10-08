Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469F97BCDB6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjJHKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjJHKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:00:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1B124
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:59:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c724577e1fso29195425ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759195; x=1697363995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeHwwvx6SH3XcJwRAg1PkSAufnkCIpxV0RXEsSdCgB0=;
        b=EvojHoHCUHO4ViO+gQhmikLAov2YXM5qNhXaXMfWq1Uaw/HWXHmp1EyFxkEX+GZFDa
         KoNYLqkDFwH+jEKZPbcZx5cTmUtMGF0YngrP/ttWKqk7mHsYitt1i1CAgvxzQe4JWDRy
         aJAXqnWeYfVCg6vHpdq7Kug5ND3eHWR+iPzMqC4DziEtBSAMEEeFkNRxDmFSsYbh6aO1
         KZo/mzdiroxb7cDzD9sIxUKGD1oDrLaCNM2s/NA5+75SwE2vXkR1VujmT6ffaN4J0Z2h
         oet28su5X1XTTrwiYiBIKZ2+QSnmuG6aLoKW9pkbYkeV7luhtcilpd/PsvwfF/K1TDZx
         EMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759195; x=1697363995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeHwwvx6SH3XcJwRAg1PkSAufnkCIpxV0RXEsSdCgB0=;
        b=LhSpEmk0JgzbR1sRsUQYaIb0MmsCyvardWJaj74jUKJEK34K6PsrToL+iTL9d+Dcef
         zYymtUNyNpyN0Me83E4TmdfHexrifogw2SiUpXoUhY9iLb7zkD45FQg11/r8MQfuxDXB
         NHwYtqEJrbg968GRTpJfBrCg0lxsNpK/V05G0CUSYULYF4cLakZhLV0ghTLiU9viYfLl
         /QkDBBbUBfV3YSiz506nJRZcnGvrsykWzCBwWF09YG+K3sdWedMR6pQsVgCBbLtEs5n9
         3Ubu2qwentb2T46gHJCzUqGq6tfpE7WUaqd+8+F9j7UeEUc+3ZwxlLOUjB4cXDezWdPl
         cB4Q==
X-Gm-Message-State: AOJu0Ywz83g5avt/GOojT+5/HjHZ5/UbvuaD3JO+htS4uYdu5UpfgBGi
        gyiqBiHaneAz8avz/VC/nmzb7A==
X-Google-Smtp-Source: AGHT+IHrnfmmCyX9QKMqWl6Nf0hvyf58INr68t4sgGoxBR8FKG5DwoKnb+qN7Ajx1qqq2CKhSPENLQ==
X-Received: by 2002:a17:903:41c1:b0:1c3:c687:478c with SMTP id u1-20020a17090341c100b001c3c687478cmr16587109ple.8.1696759195352;
        Sun, 08 Oct 2023 02:59:55 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:59:55 -0700 (PDT)
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
X-Google-Original-From: Lincheng Yang <lincheng.yang@transsion.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, willy@infradead.org, hughd@google.com,
        peterx@redhat.com, mike.kravetz@oracle.com, jgg@ziepe.ca,
        surenb@google.com, steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wanbin.wang@transsion.com, chunlei.zhuang@transsion.com,
        jinsheng.zhao@transsion.com, jiajun.ling@transsion.com,
        dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: [RFC PATCH 2/5] mm: introduce hot and cold anon page flags
Date:   Sun,  8 Oct 2023 17:59:21 +0800
Message-Id: <20231008095924.1165106-3-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008095924.1165106-1-lincheng.yang@transsion.com>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the anon page is reclaim, the hot anon page is written back to the
zram device, and the cold anon page is written back to the swapfile device.
In this way, when the hot anon page is needed again, it can be quickly
obtained from the zram device, reducing IO operations and increasing read
and write speeds.

and the hot and cold status of the device is displayed in /proc/swaps.

Signed-off-by: Lincheng Yang <lincheng.yang@transsion.com>
---
 include/linux/mm_types.h       |  1 +
 include/linux/page-flags.h     |  6 ++++
 include/linux/swap.h           |  4 ++-
 include/linux/swap_slots.h     |  2 +-
 include/trace/events/mmflags.h |  4 ++-
 mm/filemap.c                   |  2 ++
 mm/madvise.c                   |  6 ++--
 mm/memory.c                    | 42 ++++++++++++++++++++++++++++
 mm/migrate.c                   |  4 +++
 mm/swap_slots.c                | 48 ++++++++++++++++++++------------
 mm/swapfile.c                  | 51 ++++++++++++++++++++++++++++++----
 mm/vmscan.c                    |  9 ++++++
 12 files changed, 151 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7d30dc4ff0ff..5e5cf457a236 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1203,6 +1203,7 @@ enum fault_flag {
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 	FAULT_FLAG_VMA_LOCK =		1 << 12,
+	FAULT_FLAG_SWAP =		1 << 13,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..a2c83c0100aa 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -136,6 +136,8 @@ enum pageflags {
 	PG_arch_2,
 	PG_arch_3,
 #endif
+	PG_hot,
+	PG_cold,
 	__NR_PAGEFLAGS,
 
 	PG_readahead = PG_reclaim,
@@ -476,6 +478,10 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
+PAGEFLAG(Hot, hot, PF_HEAD)
+	TESTCLEARFLAG(Hot, hot, PF_HEAD)
+PAGEFLAG(Cold, cold, PF_HEAD)
+	TESTCLEARFLAG(Cold, cold, PF_HEAD)
 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 456546443f1f..70678dbd9a3a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -219,6 +219,7 @@ enum {
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
 					/* add others here before... */
+	SWP_HOT		= (1 << 13),	/* hot swap device */
 	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
 };
 
@@ -480,7 +481,8 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
+extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size, bool hot);
+bool swap_folio_hot(struct folio *folio);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..b876b1f935a2 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -24,7 +24,7 @@ struct swap_slots_cache {
 void disable_swap_slots_cache_lock(void);
 void reenable_swap_slots_cache_unlock(void);
 void enable_swap_slots_cache(void);
-void free_swap_slot(swp_entry_t entry);
+void free_swap_slot(swp_entry_t entry, bool hot);
 
 extern bool swap_slot_cache_enabled;
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 1478b9dd05fa..2bbef50d80a8 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -118,7 +118,9 @@
 	DEF_PAGEFLAG_NAME(mappedtodisk),				\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(hot),						\
+	DEF_PAGEFLAG_NAME(cold)						\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
diff --git a/mm/filemap.c b/mm/filemap.c
index 9e44a49bbd74..3bcd67d48fd1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1435,6 +1435,8 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
 	}
+
+	folio_set_hot(folio);
 }
 #endif
 
diff --git a/mm/madvise.c b/mm/madvise.c
index ec30f48f8f2e..a5c19bb3f392 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -513,10 +513,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio_test_clear_young(folio);
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
+				if (folio_test_unevictable(folio)) {
 					folio_putback_lru(folio);
-				else
+				} else {
 					list_add(&folio->lru, &folio_list);
+					folio_set_cold(folio);
+				}
 			}
 		} else
 			folio_deactivate(folio);
diff --git a/mm/memory.c b/mm/memory.c
index cdc4d4c1c858..ef41e65b1075 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3103,6 +3103,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			delayacct_wpcopy_end();
 			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
+
+		if (vmf->flags & FAULT_FLAG_SWAP)
+			folio_set_hot(new_folio);
+
 		kmsan_copy_page_meta(&new_folio->page, vmf->page);
 	}
 
@@ -3966,6 +3970,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
+	vmf->flags |= FAULT_FLAG_SWAP;
+
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	pte = mk_pte(page, vma->vm_page_prot);
@@ -3999,6 +4005,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
 	}
 
+	if (!(vmf->flags & FAULT_FLAG_WRITE) && !folio_test_clear_cold(folio))
+		folio_set_hot(folio);
+
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
@@ -4887,6 +4896,36 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+static inline void __do_access_page(struct folio *folio)
+{
+	if (folio_test_cold(folio))
+		folio_clear_cold(folio);
+	else
+		folio_set_hot(folio);
+}
+
+static inline void do_access_page(struct vm_fault *vmf)
+{
+	struct folio *folio;
+
+	vmf->page = vm_normal_page(vmf->vma, vmf->address, vmf->orig_pte);
+	if (!vmf->page)
+		return;
+
+	folio = page_folio(vmf->page);
+	if (!folio_test_anon(folio))
+		return;
+
+	if (folio_trylock(folio)) {
+		__do_access_page(folio);
+		folio_unlock(folio);
+	} else {
+		folio_get(folio);
+		__do_access_page(folio);
+		folio_put(folio);
+	}
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -4974,6 +5013,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
 						     vmf->pte);
 	}
+
+	do_access_page(vmf);
+
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return 0;
diff --git a/mm/migrate.c b/mm/migrate.c
index 24baad2571e3..9f97744bb0a8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -561,6 +561,10 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_unevictable(newfolio);
 	if (folio_test_workingset(folio))
 		folio_set_workingset(newfolio);
+	if (folio_test_hot(folio))
+		folio_set_hot(newfolio);
+	if (folio_test_cold(folio))
+		folio_set_cold(newfolio);
 	if (folio_test_checked(folio))
 		folio_set_checked(newfolio);
 	/*
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index bb41c8460b62..dff98cf4d2e5 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -35,7 +35,8 @@
 #include <linux/mutex.h>
 #include <linux/mm.h>
 
-static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots);
+static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots_hot);
+static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots_cold);
 static bool	swap_slot_cache_active;
 bool	swap_slot_cache_enabled;
 static bool	swap_slot_cache_initialized;
@@ -158,15 +159,22 @@ static int __alloc_swap_slot_cache(struct swap_slots_cache *cache)
 
 static int alloc_swap_slot_cache(unsigned int cpu)
 {
-	struct swap_slots_cache *cache;
+	struct swap_slots_cache *cache_hot, *cache_cold;
 
 	mutex_lock(&swap_slots_cache_mutex);
-	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots || cache->slots_ret)   /* cache already allocated */
-		cache = NULL;
+
+	cache_hot = &per_cpu(swp_slots_hot, cpu);
+	if (cache_hot->slots || cache_hot->slots_ret)   /* cache already allocated */
+		cache_hot = NULL;
+
+	cache_cold = &per_cpu(swp_slots_cold, cpu);
+	if (cache_cold->slots || cache_cold->slots_ret) /* cache already allocated */
+		cache_cold = NULL;
+
 	mutex_unlock(&swap_slots_cache_mutex);
 
-	__alloc_swap_slot_cache(cache);
+	__alloc_swap_slot_cache(cache_hot);
+	__alloc_swap_slot_cache(cache_cold);
 
 	return 0;
 }
@@ -205,7 +213,10 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 {
 	struct swap_slots_cache *cache;
 
-	cache = &per_cpu(swp_slots, cpu);
+	cache = &per_cpu(swp_slots_hot, cpu);
+	__drain_slots_cache_cpu(cache, type, free_slots);
+
+	cache = &per_cpu(swp_slots_cold, cpu);
 	__drain_slots_cache_cpu(cache, type, free_slots);
 }
 
@@ -269,7 +280,7 @@ void enable_swap_slots_cache(void)
 }
 
 /* called with swap slot cache's alloc lock held */
-static int refill_swap_slots_cache(struct swap_slots_cache *cache)
+static int refill_swap_slots_cache(struct swap_slots_cache *cache, bool hot)
 {
 	if (!use_swap_slot_cache)
 		return 0;
@@ -277,7 +288,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	cache->cur = 0;
 	if (swap_slot_cache_active)
 		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
-					   cache->slots, 1);
+					   cache->slots, 1, hot);
 
 	return cache->nr;
 }
@@ -309,15 +320,16 @@ static void __free_swap_slot(struct swap_slots_cache *cache, swp_entry_t entry)
 	}
 }
 
-void free_swap_slot(swp_entry_t entry)
+void free_swap_slot(swp_entry_t entry, bool hot)
 {
 	struct swap_slots_cache *cache;
 
-	cache = raw_cpu_ptr(&swp_slots);
+	cache = hot ? raw_cpu_ptr(&swp_slots_hot) : raw_cpu_ptr(&swp_slots_cold);
 	__free_swap_slot(cache, entry);
 }
 
-static int __folio_alloc_swap(struct swap_slots_cache *cache, swp_entry_t *entry)
+static int __folio_alloc_swap(struct swap_slots_cache *cache, swp_entry_t *entry,
+			      bool hot)
 {
 	if (unlikely(!check_cache_active() || !cache->slots))
 		return -EINVAL;
@@ -337,7 +349,7 @@ static int __folio_alloc_swap(struct swap_slots_cache *cache, swp_entry_t *entry
 		*entry = cache->slots[cache->cur];
 		cache->slots[cache->cur++].val = 0;
 		cache->nr--;
-	} else if (refill_swap_slots_cache(cache)) {
+	} else if (refill_swap_slots_cache(cache, hot)) {
 		goto repeat;
 	}
 	mutex_unlock(&cache->alloc_lock);
@@ -349,18 +361,20 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_entry_t entry;
 	struct swap_slots_cache *cache;
+	bool hot;
 
 	entry.val = 0;
+	hot = swap_folio_hot(folio);
 
 	if (folio_test_large(folio)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
-			get_swap_pages(1, &entry, folio_nr_pages(folio));
+			get_swap_pages(1, &entry, folio_nr_pages(folio), hot);
 		goto out;
 	}
 
-	cache = raw_cpu_ptr(&swp_slots);
-	if (__folio_alloc_swap(cache, &entry))
-		get_swap_pages(1, &entry, 1);
+	cache = hot ? raw_cpu_ptr(&swp_slots_hot) : raw_cpu_ptr(&swp_slots_cold);
+	if (__folio_alloc_swap(cache, &entry, hot))
+		get_swap_pages(1, &entry, 1, hot);
 
 out:
 	if (mem_cgroup_try_charge_swap(folio, entry)) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b15112b1f1a8..ada28c0ce569 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -113,6 +113,22 @@ static struct swap_info_struct *swap_type_to_swap_info(int type)
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
 
+static inline bool swap_info_hot(struct swap_info_struct *si)
+{
+	return !!(si->flags & SWP_HOT);
+}
+
+bool swap_folio_hot(struct folio *folio)
+{
+	if (folio_test_swapbacked(folio) && folio_test_hot(folio))
+		return true;
+
+	if (folio_test_cold(folio))
+		folio_clear_cold(folio);
+
+	return false;
+}
+
 static inline unsigned char swap_count(unsigned char ent)
 {
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
@@ -1045,7 +1061,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
 
-int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
+int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size, bool hot)
 {
 	unsigned long size = swap_entry_size(entry_size);
 	struct swap_info_struct *si, *next;
@@ -1075,6 +1091,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		spin_lock(&si->lock);
+
+		if (hot != swap_info_hot(si)) {
+			spin_lock(&swap_avail_lock);
+			spin_unlock(&si->lock);
+			goto nextsi;
+		}
+
 		if (!si->highest_bit || !(si->flags & SWP_WRITEOK)) {
 			spin_lock(&swap_avail_lock);
 			if (plist_node_empty(&si->avail_lists[node])) {
@@ -1119,6 +1142,11 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			goto start_over;
 	}
 
+	if (!hot) {
+		hot = true;
+		goto start_over;
+	}
+
 	spin_unlock(&swap_avail_lock);
 
 check_out:
@@ -1300,7 +1328,7 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
 	usage = __swap_entry_free_locked(p, offset, 1);
 	unlock_cluster_or_swap_info(p, ci);
 	if (!usage)
-		free_swap_slot(entry);
+		free_swap_slot(entry, swap_info_hot(p));
 
 	return usage;
 }
@@ -1376,7 +1404,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	for (i = 0; i < size; i++, entry.val++) {
 		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
 			unlock_cluster_or_swap_info(si, ci);
-			free_swap_slot(entry);
+			free_swap_slot(entry, swap_info_hot(si));
 			if (i == size - 1)
 				return;
 			lock_cluster_or_swap_info(si, offset);
@@ -1560,6 +1588,8 @@ static bool folio_swapped(struct folio *folio)
  */
 bool folio_free_swap(struct folio *folio)
 {
+	struct swap_info_struct *si = page_swap_info(folio_page(folio, 0));
+
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (!folio_test_swapcache(folio))
@@ -1589,6 +1619,10 @@ bool folio_free_swap(struct folio *folio)
 
 	delete_from_swap_cache(folio);
 	folio_set_dirty(folio);
+
+	if (swap_info_hot(si))
+		folio_set_hot(folio);
+
 	return true;
 }
 
@@ -2628,7 +2662,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	unsigned long bytes, inuse;
 
 	if (si == SEQ_START_TOKEN) {
-		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
+		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\tType\n");
 		return 0;
 	}
 
@@ -2637,13 +2671,14 @@ static int swap_show(struct seq_file *swap, void *v)
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
-	seq_printf(swap, "%*s%s\t%lu\t%s%lu\t%s%d\n",
+	seq_printf(swap, "%*s%s\t%lu\t%s%lu\t%s%d\t\t%s\n",
 			len < 40 ? 40 - len : 1, " ",
 			S_ISBLK(file_inode(file)->i_mode) ?
 				"partition" : "file\t",
 			bytes, bytes < 10000000 ? "\t" : "",
 			inuse, inuse < 10000000 ? "\t" : "",
-			si->prio);
+			si->prio,
+			(si->flags & SWP_HOT) ? "hot" : "cold");
 	return 0;
 }
 
@@ -3069,6 +3104,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
+	if ((p->flags & SWP_BLKDEV) &&
+	    !strncmp(strrchr(name->name, '/'), "/zram", 5))
+		p->flags |= SWP_HOT;
+
 	if (p->bdev && bdev_synchronous(p->bdev))
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2fe4a11d63f4..f496e1abea76 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1519,6 +1519,7 @@ enum folio_references {
 	FOLIOREF_RECLAIM_CLEAN,
 	FOLIOREF_KEEP,
 	FOLIOREF_ACTIVATE,
+	FOLIOREF_ANON_ACCESS,
 };
 
 static enum folio_references folio_check_references(struct folio *folio,
@@ -1543,6 +1544,9 @@ static enum folio_references folio_check_references(struct folio *folio,
 		return FOLIOREF_KEEP;
 
 	if (referenced_ptes) {
+		if (folio_test_swapbacked(folio))
+			return FOLIOREF_ANON_ACCESS;
+
 		/*
 		 * All mapped folios start out with page table
 		 * references from the instantiating fault, so we need
@@ -1861,6 +1865,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			references = folio_check_references(folio, sc);
 
 		switch (references) {
+		case FOLIOREF_ANON_ACCESS:
+			if (folio_test_cold(folio))
+				folio_clear_cold(folio);
+			else
+				folio_set_hot(folio);
 		case FOLIOREF_ACTIVATE:
 			goto activate_locked;
 		case FOLIOREF_KEEP:
-- 
2.34.1

