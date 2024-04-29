Return-Path: <linux-kernel+bounces-162360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C88B59CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80321F2502F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CD6A00B;
	Mon, 29 Apr 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqgzuNpG"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A136745C0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397017; cv=none; b=myiB4PaQ2olni5HidGiUCUZXG8taieZVS9uwNMdddmc4mLUeG9Ur4UviTHy1Qpj5x/CbTa0pp2bcKqg8sVxx4jnXGUrIX4gR/4dnEz3g7K5G/v2u1fg/Kp7yLysjYxtWV/ppc75+m4SBLZ08cnHdOy9rSIvv6J5BnEIZ5u6nPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397017; c=relaxed/simple;
	bh=PNAY2B0twHR0g+eIobtMmiBXo8e2//D9L4cS+khsXzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHlXdUaCHi9XfeQiSJ93q7anLtm0jeeFXvNsAhVnDNE4BSy2VqoBcN+3/Shgk0WPk1A98o/YvS78zhfx6fJemuDeaHi5wZxT6wwHbgfeYISX/87/jko+yXfrivHPiO+oE3sHuoS/M52U2L0v1tm45Pcxtji2l5QGwb7JgzndwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqgzuNpG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b18e829acfso710840a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397015; x=1715001815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyi8NgAotG2uQx5M1DNlDhdviU8akK6rE5R0Kl6KUlU=;
        b=aqgzuNpGTtBVAjFAjAwndHNo/Z91G+kntT3ltydIVQ3p63/A+bWUv81SNGEAOcv628
         7dHJMUbzxJ0OoNYn7b+nH4v8Lzph5vPcUFlai8kJoPyO9aFcdzslS75z7DFe/2arX9DY
         EQtSwMXDiOJHjgAKyxrNiT1jxgOKbfdbQSKbLMId8MytjVGpKkqEcLlsFvZvP9fRl58E
         ZZum5vqW3HFZIvuJ5eDZBQELAX6WNGpkqqF6MSJccaFsaOJK25mz7tzs97YJUlgvUSy3
         bpAD2hIDQq/Vy7LA6lSRAeFYbATLmoiVlXZoAdNMZIPXo6UjbEf+l6O+RBzCUGGODitU
         n8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397016; x=1715001816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yyi8NgAotG2uQx5M1DNlDhdviU8akK6rE5R0Kl6KUlU=;
        b=rTzAuLCXLwWXv5gqlxhmzWKQfP7gGYQwo0vb1UamiP7JOL9lQyp0sXhxVIxwzP6eZZ
         vVVeqd13Pt5mmtVc6HoAAbnYF4eRTF5SLA/MtO3KUSMAP2pb7FeqpBQtpNTeyDDatO55
         yYTmLh/lYiDZTOgaYTRBIze9vuA3aFhl9yhBtcG02/YbflVO+wp9kPzeWwK9unk88Gnf
         44znrn3msvuYlbrB29BtXYbqVdSkg9MWbIZoZ2uNCEhQYH24q+zGB1A3BR+vy2IrK09f
         RywtlIF+M2jPNPfLP0KRGr/nQkNba63aOVebid0RBAZzCMTM3KpsvLlzg2NEQSFENFTv
         5q5g==
X-Forwarded-Encrypted: i=1; AJvYcCUENx1dSMCLUXiowDN93fFbY/S0N8Oyf4fGb8kq+UiYjrK/D0izmn88PB16D3gYr2c39yfDyzO4Hn3lE9BUOs6FJa5e39Nh2uKAakam
X-Gm-Message-State: AOJu0YzIXN+BpwbFsAJabSMLqOnhr1lMlc2JdVwum5C1ulsVKZxBMRF5
	jRC7bixlpYvu/aTSBH3bCtKUv2ApQNqqR4JlHIxInEmKsiEQr/zs
X-Google-Smtp-Source: AGHT+IE3glKHvTVXbEue7ZJjzMdZwSs4YepE3f+DkJR5stamEyLLZPKJxPWIl3KdJI4v7bdaHehPKw==
X-Received: by 2002:a17:90a:654c:b0:2a0:215f:dc9c with SMTP id f12-20020a17090a654c00b002a0215fdc9cmr9546775pjs.35.1714397015463;
        Mon, 29 Apr 2024 06:23:35 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b002b113ad5f10sm3562203pjb.12.2024.04.29.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:23:35 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Mon, 29 Apr 2024 21:23:08 +0800
Message-Id: <20240429132308.38794-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240429132308.38794-1-ioworker0@gmail.com>
References: <20240429132308.38794-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user no longer requires the pages, they would use
madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
typically would not re-write to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are
both still marked as clean and there are no unexpected references
(such as GUP), so we can just discard the memory lazily, improving the
efficiency of memory reclamation in this case.

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

Suggested-by: Zi Yan <ziy@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  2 ++
 mm/huge_memory.c        | 75 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               |  3 ++
 3 files changed, 80 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2daadfcc6776..fd330f72b4f3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -38,6 +38,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    unsigned long cp_flags);
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 145505a1dd05..d35d526ed48f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2690,6 +2690,81 @@ static void unmap_folio(struct folio *folio)
 	try_to_unmap_flush();
 }
 
+static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
+				       unsigned long addr, pmd_t *pmdp,
+				       struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int ref_count, map_count;
+	pmd_t orig_pmd = *pmdp;
+	struct mmu_gather tlb;
+	struct page *page;
+
+	if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
+		return false;
+	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
+		return false;
+
+	page = pmd_page(orig_pmd);
+	if (unlikely(page_folio(page) != folio))
+		return false;
+
+	tlb_gather_mmu(&tlb, mm);
+	orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
+	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
+
+	/*
+	 * Syncing against concurrent GUP-fast:
+	 * - clear PMD; barrier; read refcount
+	 * - inc refcount; barrier; read PMD
+	 */
+	smp_mb();
+
+	ref_count = folio_ref_count(folio);
+	map_count = folio_mapcount(folio);
+
+	/*
+	 * Order reads for folio refcount and dirty flag
+	 * (see comments in __remove_mapping()).
+	 */
+	smp_rmb();
+
+	/*
+	 * If the PMD or folio is redirtied at this point, or if there are
+	 * unexpected references, we will give up to discard this folio
+	 * and remap it.
+	 *
+	 * The only folio refs must be one from isolation plus the rmap(s).
+	 */
+	if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
+	    pmd_dirty(orig_pmd)) {
+		set_pmd_at(mm, addr, pmdp, orig_pmd);
+		return false;
+	}
+
+	folio_remove_rmap_pmd(folio, page, vma);
+	zap_deposited_table(mm, pmdp);
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	folio_put(folio);
+
+	return true;
+}
+
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
+		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
+#endif
+
+	return false;
+}
+
 static void remap_page(struct folio *folio, unsigned long nr)
 {
 	int i = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index e42f436c7ff3..ab37af4f47aa 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1677,6 +1677,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
+			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
+						  folio))
+				goto walk_done;
 			/*
 			 * We temporarily have to drop the PTL and start once
 			 * again from that now-PTE-mapped page table.
-- 
2.33.1


