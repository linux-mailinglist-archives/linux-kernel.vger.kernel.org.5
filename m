Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AB7BCDB8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjJHKA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbjJHKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:00:23 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3AF18D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:00:04 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e59894d105so1267047fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759203; x=1697364003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHpftGgJpPJeFInwMMKebLEtcyR6XaWIULyACDAXxLA=;
        b=dRmxUR67IV238IjwoMX8sW9EYjnWUGkF8zaFuxJF8a4KPHS4SS7z+ZCKYg3wk75ZdL
         yerKI+XoOID3JAb1sKDG/19e991hlf373I+SXepC2BlMbuGQTyIbKOCWEaYyCR0BXCpq
         7ORTMEMKhyeGIaiLylT27ahgA/m8pJV5WipksB+GkubR0PB7ikCpcTWYUbw1noGvk7Ym
         Ji9SVvyq4w5ffKvfykyoYua/4QcbWzv/3UpLUgym0uh/YOQe+r6KXIG8l2DsAx0q/qDQ
         qEfLd26Ehm6Ui7nMXzy6VDiQ+GNBkOvPu60vrErhbfE/COi50YDrWmPmUVd4NpojKECW
         LwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759203; x=1697364003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHpftGgJpPJeFInwMMKebLEtcyR6XaWIULyACDAXxLA=;
        b=jn+M1FE92BPkm3yrJyosK6IbV90FmkaAoEjwvV7ve6VuuWH8LJyzRjiSjS5fkfKmkB
         dAedrf73dqYgohLGjvlVnaxLcNDR1BEDU31zrqYT0LSPp17UJggsOpbi/IdegDNI9CG+
         iMayQkk3+K1v8ArJIGNIlEFTzGABVCq7ZG4izGt+I9ZDAfWxATjdXTjQQfP4gKOC4ya3
         g+3fe/RY+oTCXqq2NfZcdHQRJQSP+raE7Zpym26rOYZrE+4hQijsBsnj3vk/dzeYERLi
         jD+sA7zVd7lJOBKry+nxSQBHlUBVOG03Ngksd8FbqMZ6t0USXhNqoSgjaLPskHRw3Ocn
         zVfg==
X-Gm-Message-State: AOJu0YxgQRKzK8u3mGSBCLFOdaeiCebrGR2nyN/jw2BBulIDE6dY70vP
        2iedkuNKv3UcuwujEQJsZWapvw==
X-Google-Smtp-Source: AGHT+IH+dw9wDlop3g74gocjONYEfTQzfX26YMTVaCymJgcCLMHrHnISgQwx5SbtIJFa0TTFDzfKmQ==
X-Received: by 2002:a05:6870:160f:b0:1da:ed0f:9c84 with SMTP id b15-20020a056870160f00b001daed0f9c84mr16018389oae.52.1696759202678;
        Sun, 08 Oct 2023 03:00:02 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:00:02 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] mm: add VMA hot flag
Date:   Sun,  8 Oct 2023 17:59:22 +0800
Message-Id: <20231008095924.1165106-4-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008095924.1165106-1-lincheng.yang@transsion.com>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the VMA is executable/stack/lock, or the number of VMA PGFAULTs
exceeds twice the number of pages in the entire VMA address range, or
the number of VMA PGMAJFAULTs exceeds half the number of pages in the
entire VMA address range, it means that the VMA is hot. Therefore, all
anon pages of this VMA are hot pages. When memory reclaim is performed,
they are written back to zram.

and the number of Faults and MajFaults is displayed in /proc/<pid>/smaps.

Signed-off-by: Lincheng Yang <lincheng.yang@transsion.com>
---
 fs/proc/task_mmu.c             |  3 +++
 include/linux/mm.h             | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h       |  1 +
 include/linux/mm_types_task.h  | 10 ++++++++++
 include/linux/swap.h           |  6 +++---
 include/trace/events/mmflags.h |  1 +
 mm/memory.c                    |  2 ++
 mm/rmap.c                      |  3 +++
 mm/shmem.c                     |  2 +-
 mm/swap.h                      |  4 ++--
 mm/swap_slots.c                |  4 ++--
 mm/swap_state.c                |  4 ++--
 mm/swapfile.c                  |  5 ++++-
 mm/vmscan.c                    | 10 ++++++++--
 14 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fafff1bd34cd..dc2c53eb759a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -871,6 +871,9 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
+	seq_printf(m, "Faults:    %ld\n", get_vma_counter(vma, VMA_PGFAULT));
+	seq_printf(m, "MajFaults:    %ld\n", get_vma_counter(vma, VMA_PGMAJFAULT));
+
 	seq_printf(m, "THPeligible:    %d\n",
 		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34f9dba17c1a..5dbe5a5c49c8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -282,6 +282,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_HOT		0x00000800
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
@@ -763,6 +764,7 @@ static inline void vma_mark_detached(struct vm_area_struct *vma,
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	static const struct vm_operations_struct dummy_vm_ops = {};
+	int i;
 
 	memset(vma, 0, sizeof(*vma));
 	vma->vm_mm = mm;
@@ -770,6 +772,9 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
+
+	for (i = 0; i < NR_VMA_EVENTS; i++)
+		atomic_long_set(&vma->events_stat.count[i], 0);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
@@ -2515,6 +2520,33 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 {
 	return get_user_pages_fast_only(addr, 1, gup_flags, pagep) == 1;
 }
+
+static inline void count_vma_counter(struct vm_area_struct *vma, int member)
+{
+	atomic_long_inc(&vma->events_stat.count[member]);
+}
+
+static inline unsigned long get_vma_counter(struct vm_area_struct *vma, int member)
+{
+	return atomic_long_read(&vma->events_stat.count[member]);
+}
+
+static inline bool vma_hot(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_EXEC | VM_STACK | VM_LOCKED))
+		return true;
+
+	if (get_vma_counter(vma, VMA_PGFAULT) >
+			(vma->vm_end - vma->vm_start) >> (PAGE_SHIFT - 1))
+		return true;
+
+	if (get_vma_counter(vma, VMA_PGMAJFAULT) >
+			(vma->vm_end - vma->vm_start) >> (PAGE_SHIFT + 1))
+		return true;
+
+	return false;
+}
+
 /*
  * per-process(per-mm_struct) statistics.
  */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e5cf457a236..863c54f2e165 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -585,6 +585,7 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	struct vma_events_stat events_stat;
 } __randomize_layout;
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 5414b5c6a103..604107222306 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -36,6 +36,16 @@ enum {
 	NR_MM_COUNTERS
 };
 
+enum {
+	VMA_PGFAULT,
+	VMA_PGMAJFAULT,
+	NR_VMA_EVENTS
+};
+
+struct vma_events_stat {
+	atomic_long_t count[NR_VMA_EVENTS];
+};
+
 struct page_frag {
 	struct page *page;
 #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 70678dbd9a3a..a4c764eca0cc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -477,12 +477,12 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-swp_entry_t folio_alloc_swap(struct folio *folio);
+swp_entry_t folio_alloc_swap(struct folio *folio, bool hotness);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size, bool hot);
-bool swap_folio_hot(struct folio *folio);
+bool swap_folio_hot(struct folio *folio, bool hotness);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
@@ -583,7 +583,7 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline swp_entry_t folio_alloc_swap(struct folio *folio)
+static inline swp_entry_t folio_alloc_swap(struct folio *folio, bool hotness)
 {
 	swp_entry_t entry;
 	entry.val = 0;
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 2bbef50d80a8..f266f92c41c6 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -179,6 +179,7 @@ IF_HAVE_PG_ARCH_X(arch_3)
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
+	{VM_HOT,			"hot"		},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/mm/memory.c b/mm/memory.c
index ef41e65b1075..907e13933567 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3836,6 +3836,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
+		count_vma_counter(vma, VMA_PGMAJFAULT);
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 	} else if (PageHWPoison(page)) {
@@ -5288,6 +5289,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			mem_cgroup_oom_synchronize(false);
 	}
 out:
+	count_vma_counter(vma, VMA_PGFAULT);
 	mm_account_fault(mm, regs, address, flags, ret);
 
 	return ret;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0c0d8857dfce..9b439280f430 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -857,6 +857,9 @@ static bool folio_referenced_one(struct folio *folio,
 		pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
 	}
 
+	if (vma_hot(vma))
+		pra->vm_flags |= VM_HOT;
+
 	if (!pra->mapcount)
 		return false; /* To break the loop */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index d963c747dabc..28350a38d169 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1412,7 +1412,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_mark_uptodate(folio);
 	}
 
-	swap = folio_alloc_swap(folio);
+	swap = folio_alloc_swap(folio, true);
 	if (!swap.val)
 		goto redirty;
 
diff --git a/mm/swap.h b/mm/swap.h
index 7c033d793f15..470b8084b036 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -29,7 +29,7 @@ extern struct address_space *swapper_spaces[];
 		>> SWAP_ADDRESS_SPACE_SHIFT])
 
 void show_swap_cache_info(void);
-bool add_to_swap(struct folio *folio);
+bool add_to_swap(struct folio *folio, bool hotness);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
 int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 		      gfp_t gfp, void **shadowp);
@@ -110,7 +110,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	return filemap_get_folio(mapping, index);
 }
 
-static inline bool add_to_swap(struct folio *folio)
+static inline bool add_to_swap(struct folio *folio, bool hotness)
 {
 	return false;
 }
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index dff98cf4d2e5..4707347599ce 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -357,14 +357,14 @@ static int __folio_alloc_swap(struct swap_slots_cache *cache, swp_entry_t *entry
 	return !!entry->val;
 }
 
-swp_entry_t folio_alloc_swap(struct folio *folio)
+swp_entry_t folio_alloc_swap(struct folio *folio, bool hotness)
 {
 	swp_entry_t entry;
 	struct swap_slots_cache *cache;
 	bool hot;
 
 	entry.val = 0;
-	hot = swap_folio_hot(folio);
+	hot = swap_folio_hot(folio, hotness);
 
 	if (folio_test_large(folio)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f8ea7015bad4..5766fa5ac21e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -174,7 +174,7 @@ void __delete_from_swap_cache(struct folio *folio,
  * Context: Caller needs to hold the folio lock.
  * Return: Whether the folio was added to the swap cache.
  */
-bool add_to_swap(struct folio *folio)
+bool add_to_swap(struct folio *folio, bool hotness)
 {
 	swp_entry_t entry;
 	int err;
@@ -182,7 +182,7 @@ bool add_to_swap(struct folio *folio)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
 
-	entry = folio_alloc_swap(folio);
+	entry = folio_alloc_swap(folio, hotness);
 	if (!entry.val)
 		return false;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ada28c0ce569..5378f70d330d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -118,8 +118,11 @@ static inline bool swap_info_hot(struct swap_info_struct *si)
 	return !!(si->flags & SWP_HOT);
 }
 
-bool swap_folio_hot(struct folio *folio)
+bool swap_folio_hot(struct folio *folio, bool hotness)
 {
+	if (hotness)
+		return true;
+
 	if (folio_test_swapbacked(folio) && folio_test_hot(folio))
 		return true;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f496e1abea76..11d175d9fe0c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -155,6 +155,8 @@ struct scan_control {
 	/* Number of pages freed so far during a call to shrink_zones() */
 	unsigned long nr_reclaimed;
 
+	bool hotness;
+
 	struct {
 		unsigned int dirty;
 		unsigned int unqueued_dirty;
@@ -1532,6 +1534,8 @@ static enum folio_references folio_check_references(struct folio *folio,
 					   &vm_flags);
 	referenced_folio = folio_test_clear_referenced(folio);
 
+	sc->hotness = !!(vm_flags & VM_HOT);
+
 	/*
 	 * The supposedly reclaimable folio was found to be in a VM_LOCKED vma.
 	 * Let the folio, now marked Mlocked, be moved to the unevictable list.
@@ -1745,6 +1749,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		/* Account the number of base pages */
 		sc->nr_scanned += nr_pages;
 
+		sc->hotness = !ignore_references;
+
 		if (unlikely(!folio_evictable(folio)))
 			goto activate_locked;
 
@@ -1916,7 +1922,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 				}
-				if (!add_to_swap(folio)) {
+				if (!add_to_swap(folio, sc->hotness)) {
 					if (!folio_test_large(folio))
 						goto activate_locked_split;
 					/* Fallback to swap normal pages */
@@ -1926,7 +1932,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
-					if (!add_to_swap(folio))
+					if (!add_to_swap(folio, sc->hotness))
 						goto activate_locked_split;
 				}
 			}
-- 
2.34.1

