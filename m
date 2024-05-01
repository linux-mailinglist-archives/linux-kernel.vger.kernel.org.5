Return-Path: <linux-kernel+bounces-164915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02C8B84D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381491C22460
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E1446D9;
	Wed,  1 May 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzXtF7jS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2034437A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537647; cv=none; b=ZGSDP7vZtyAQwcB/snAwEHj25InIbUh5Hf2CH89NZiXfBOW9u7T8IH/KczKLNrwZ81R7exevQYekWDWRAvUDW1UGcXCsJPncyeGMmL2VG3o7oKNx4xSxq21cLSJeT9o96g+KAzVCQwnDuDoFyDTsLjYPjW+cfCV2FvpX87OQj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537647; c=relaxed/simple;
	bh=6sHQDtC40RV0vFu1QW1zzKktIZ+5vhLAKVpXfbHtYwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJ1MHZ+Jhmod9ADH/VewtQD6zQXyclYbvGiNFe9PHZVWS0/GLeI9jTQeEIyALpL2M0wTkenIRnmmvEjIWp0uXHIUYZzyQrlo6K5RoSkzq9Ag2TkM7Ms014r+vpVeVhZzXeXIKqL4rAF9tjm9mAj6yiRgFquTZiHji+KcqHg6y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzXtF7jS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso5124486b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537645; x=1715142445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOzQapCM9/nhQFCiXcuQFHHgx8BSo7e2vP87qJAgbT0=;
        b=TzXtF7jSBWuz5DdzLV2xfFUR7FmxjpR6jaRMJhPqVQFvSPT4QlAmvn1Hcz1r7yCcIk
         NUuzfFCRlSjufrXQN/bETS94gY43dc7F45yP4A7VGNHJY4p3otguqQUDEQnqLyqM2Quu
         JwLU5nOVz7kuIpPjhLhyaSfcygUbZ1L7khq8KW/1d4LI2sHMcypbeGtG91WcCVn2xn5Q
         MCzBzC3TwIuPOPVWkBv0LoPvMnsqtXUbJkU/YlJJx9EwD5y3MvLGkjef7kLtJmkxtT3J
         yS4+aKhSj5iN95eR8bRKCtFdVBJd9oFZ3uHTeG3T84DjvZA5heP1gQqxRbOM6TE4PlWO
         VgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537645; x=1715142445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOzQapCM9/nhQFCiXcuQFHHgx8BSo7e2vP87qJAgbT0=;
        b=H+KIXkzpuFyjCbRsbDLpLNvVdJ8E0InzP73DlTocipG2ZvI8iP0ZBETxejvYYinia6
         xDqpCfEKrTAblA+SZ3GK9qFznOW416DVa6TEuqsmF8jdx19MhCAT9hedvy2FNQKHl3hu
         ocMPuoOAp05UrGKkA6C3q+msLSjYmSnPWA/sD+el7Dqxo4/sxGGPpqQsQwrJVkiEtkkK
         q0QR2AZBVNuMJuMff+a40JlsdZhLRj3h+eFxLlg7Cn3bFjrkmCbmTg8dxlXkgq2jtG39
         MDHlE0BrkN2p0DM3xtF0an/ufqpDjOo1UrXX6kxuFCpFv3jv5fNX7xjd9am7frUaG/sc
         GH+w==
X-Forwarded-Encrypted: i=1; AJvYcCWUJXNuuWUjxSG9w2EA6myMiz5Vg2wOsGN2/EmJFU4ofjXnX5LDoiJgLd7/xnLSVDYPp5WW4Oy4vlpkHFn6Bjsc5xT+kkvutcz3Ii+A
X-Gm-Message-State: AOJu0Yy3eDWUE7dSSEIm4jR0pXyPZA/9XA0JTOY7JNCa57Cel4ZlImXt
	INaNhlx4ATs66Hx7qGaXFkJqaXr8aS/5euSTZVm0u5Hs8ynD7GOk
X-Google-Smtp-Source: AGHT+IExH8/mQKcC+a0yuiE7nJbe/y3Zn478CUKsgvKf8sffmUuOcVVFi/q1aIYi5BB/0pju90QCCg==
X-Received: by 2002:a05:6a00:2345:b0:6ed:d8d2:503d with SMTP id j5-20020a056a00234500b006edd8d2503dmr2150218pfj.20.1714537644912;
        Tue, 30 Apr 2024 21:27:24 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b005dc4806ad7dsm19165970pgu.40.2024.04.30.21.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:27:24 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
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
Subject: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Wed,  1 May 2024 12:27:00 +0800
Message-Id: <20240501042700.83974-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240501042700.83974-1-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
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
efficiency of memory reclamation in this case.  On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
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
 include/linux/huge_mm.h |  9 +++++
 mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               |  3 ++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 38c4b5537715..017cee864080 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 static inline void align_huge_pmd_range(struct vm_area_struct *vma,
 					unsigned long *start,
@@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_area_struct *vma,
 					unsigned long *start,
 					unsigned long *end) {}
 
+static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long addr, pmd_t *pmdp,
+					 struct folio *folio)
+{
+	return false;
+}
+
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 145505a1dd05..90fdef847a88 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
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
+	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
+		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
+
+	return false;
+}
+
 static void remap_page(struct folio *folio, unsigned long nr)
 {
 	int i = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 432601154583..1d3d30cb752c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1675,6 +1675,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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


