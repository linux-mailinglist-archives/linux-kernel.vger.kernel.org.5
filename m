Return-Path: <linux-kernel+bounces-119744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D346588CCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACD73284BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058713CC7B;
	Tue, 26 Mar 2024 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwT4nCn"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4D13CA8F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479867; cv=none; b=mBLV4tbd6d/yK0dpG4lDfuQjsB9TWMc+ZZAOWNRjqmxsqfb1rRmdHKk6uxEaeKFSc5P6wO9w/eqZnlfR9tH29tx80brnQszEGX/dBJSUpJ5qFXehlS1oTz0oFZv1d7SSdoUCEfZ2sFtonBosKu5fZkTgvNwdxhw589zciaA8Nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479867; c=relaxed/simple;
	bh=/Jl9C/gSXTiCfkBx31wAHLY9fnt3jmNTgN8z7ezxDXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b559qhFHQG8+vz/IJB8D71fDFls1o9U0VjzSpWRsLWyMxx/iAHbGK8qM8++Rqnc+5DOol+2N0SfxPkb1kjhZtI1n1wPBi5FBaQa7TsC+LtXSkNmmbgw3lVnruCyHizKbo/HhuWfkHfAW6w1okY6BIKer/ZWggHXWo1rwub37co0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqwT4nCn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e8f765146fso4514509b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479865; x=1712084665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+iVlYtZOB3fCRmg1hwgLJ8pOWaFPkCTIgs4hiVHBEmU=;
        b=XqwT4nCniUHaTcXPmoK95cenUVRcE6GZ62WNvTEc9APbyqWqiRX5xbVXm/BmFwc2yi
         4fZ4kpLh8uP8kOh4qixWoBblsNMlaOeKDrVdhztJeSFfJfT+b7FbYmBtLMk9yzCNzg9h
         7HlUbn5r1WpyQ3HuB4uX0y18jBW5Zoqv1nmsPOl0xsrzX3m5npIdkZKJbYcKLm+AQTGc
         3rsPH0lPxqm7mkaH5JrBwg4wAMqG+MbsYZNAPozokfTbD22dafoBIvYrCiHLVCt5r95B
         FnOTa+zcaiSmsUWIjSXJW65DKQO6R2qM59beQdq/4NbfZgZTBfhWDi5FbyoNn2Yt8+kO
         DK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479865; x=1712084665;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iVlYtZOB3fCRmg1hwgLJ8pOWaFPkCTIgs4hiVHBEmU=;
        b=AHxVSbHZmZlVo1RJOct4Ur9J0TUB4BnCYAiSpQZqpUSZyziKztZ0lVHh3sSbQISleY
         zDNY2e4PHzf+YiwQ26U6qLZAnLO7K1tN6cEUIDkEm+8EI07REtRnGi/6p/U7x5zECwvK
         EkYcZK5dMvoxqt7eFPIFYuP3izGiP+rKTGI5hnjHBhi994jav587OeCEFH5Eit/8BiyT
         pOPhqtD9lBuach1BVFSL61BHz0A+5TsB2+QtXynbcGEc1Pla67PLjURYNLV1iNHAuXbW
         /ZWhYiPiJ6xbKDjyFtJbXmNKvuuDN89tlawn0Jba+syN4S7HRbROdvp3Vnjg+rFuAYZo
         AmHw==
X-Forwarded-Encrypted: i=1; AJvYcCW09dkbCoEO8mIJpJO2h7ymOnfUQqKCBhYkTVp+q8sJXDy4tsYmH45rVKnk2syRUq17wNVxpCiQN3f2vJNXJZFCUFRrHljJ0QuuWyqj
X-Gm-Message-State: AOJu0YznQmb7f+eWuyAyQQy+FN+mpBaDg3/4dmsNDaucNalR0B7Bh16G
	Rw3lF6Y4VLyNM1199uU5wTflRXQOQTZ4x3yqX42OubTqb46gKapy2C1AWXVpoPMY+gV5
X-Google-Smtp-Source: AGHT+IHasTHngVbHXAAz60DxTdM0n3aSiwZ9Kg40P8vfF4TYZxDB4AbSEHDL00iy0NSqMDT5XDhRaw==
X-Received: by 2002:a05:6a00:21c9:b0:6e9:a70:aa7a with SMTP id t9-20020a056a0021c900b006e90a70aa7amr3745251pfj.19.1711479865567;
        Tue, 26 Mar 2024 12:04:25 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:24 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 02/10] mm/swap: move no readahead swapin code to a stand-alone helper
Date: Wed, 27 Mar 2024 02:50:24 +0800
Message-ID: <20240326185032.72159-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326185032.72159-1-ryncsn@gmail.com>
References: <20240326185032.72159-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Simply move the routine to a standalone function, having a cleaner
split and avoid helpers being referenced corss multiple files.

Basically no feature change, but the error path is very slightly
different. Previously a mem_cgroup_swapin_charge_folio fail will cause
direct OOM, now we go through the error checking path in do_swap_pte, if
the page is already there, just return as the page fault was handled.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 42 +++-------------------------------
 mm/swap.h       |  8 +++++++
 mm/swap_state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..e42fadc25268 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3937,7 +3937,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
-	void *shadow = NULL;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4001,47 +4000,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/*
-			 * Prevent parallel swapin from proceeding with
-			 * the cache flag. Otherwise, another thread may
-			 * finish swapin first, free the entry, and swapout
-			 * reusing the same entry. It's undetectable as
-			 * pte_same() returns true due to entry reuse.
-			 */
-			if (swapcache_prepare(entry)) {
-				/* Relax a bit to prevent rapid repeated page faults */
-				schedule_timeout_uninterruptible(1);
+			/* skip swapcache and readahead */
+			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
+			if (PTR_ERR(folio) == -EBUSY)
 				goto out;
-			}
 			need_clear_cache = true;
-
-			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
 			page = &folio->page;
-			if (folio) {
-				__folio_set_locked(folio);
-				__folio_set_swapbacked(folio);
-
-				if (mem_cgroup_swapin_charge_folio(folio,
-							vma->vm_mm, GFP_KERNEL,
-							entry)) {
-					ret = VM_FAULT_OOM;
-					goto out_page;
-				}
-				mem_cgroup_swapin_uncharge_swap(entry);
-
-				shadow = get_shadow_from_swap_cache(entry);
-				if (shadow)
-					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
-
-				/* To provide entry to swap_read_folio() */
-				folio->swap = entry;
-				swap_read_folio(folio, true, NULL);
-				folio->private = NULL;
-			}
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						vmf);
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..40e902812cc5 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -55,6 +55,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
+struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			    struct vm_fault *vmf);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
 
@@ -87,6 +89,12 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
+static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			struct vm_fault *vmf)
+{
+	return NULL;
+}
+
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index bfc7e8c58a6d..0a3fa48b3893 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -879,6 +879,66 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	return folio;
 }
 
+/**
+ * swapin_direct - swap in folios skipping swap cache and readahead
+ * @entry: swap entry of this memory
+ * @gfp_mask: memory allocation flags
+ * @vmf: fault information
+ *
+ * Returns the struct folio for entry and addr after the swap entry is read
+ * in.
+ */
+struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
+			    struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	void *shadow = NULL;
+
+	/*
+	 * Prevent parallel swapin from proceeding with
+	 * the cache flag. Otherwise, another thread may
+	 * finish swapin first, free the entry, and swapout
+	 * reusing the same entry. It's undetectable as
+	 * pte_same() returns true due to entry reuse.
+	 */
+	if (swapcache_prepare(entry)) {
+		/* Relax a bit to prevent rapid repeated page faults */
+		schedule_timeout_uninterruptible(1);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* skip swapcache */
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
+				vma, vmf->address, false);
+	if (folio) {
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		if (mem_cgroup_swapin_charge_folio(folio,
+					vma->vm_mm, GFP_KERNEL,
+					entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return NULL;
+		}
+		mem_cgroup_swapin_uncharge_swap(entry);
+
+		shadow = get_shadow_from_swap_cache(entry);
+		if (shadow)
+			workingset_refault(folio, shadow);
+
+		folio_add_lru(folio);
+
+		/* To provide entry to swap_read_folio() */
+		folio->swap = entry;
+		swap_read_folio(folio, true, NULL);
+		folio->private = NULL;
+	}
+
+	return folio;
+}
+
 /**
  * swapin_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
-- 
2.43.0


