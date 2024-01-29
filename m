Return-Path: <linux-kernel+bounces-43243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A9841159
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A828C07D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C976F073;
	Mon, 29 Jan 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS7gb/RH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED196F06A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550912; cv=none; b=WZsZXT7V8bVToFlAznZrVEpbvr4lGgvdXgwpAYnYumUxzm2EdUWW+B2MGA7jtQf537WdcrLXJZGjw4nAzbmeoA9sIYr8+eQCcBjSPYkzulhg8Lkf59v8RsJvg80bkWCcMSLUNXhFiKhq1Qe7AE4ggbxlLZpcY4xyt/x7rvGYMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550912; c=relaxed/simple;
	bh=ybejsy/GXIw9/hKLCEWjCQvkSuJ7x1aDmtjjWidoh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RImAKdc8oTx/r0Yp4WjMUWbUoBvIxs/vOtx++4E7qpRFGGh/hc0+ZKxXoqWv7oJbBZU9DInzCiuaIKeMH2kizwLf0Ly5pXwtOmHaRJUkTaD8qRR7fL/xliWhm/JHn8ey/IPZEswia4VWA0USh1UMpKSmBlvmT9OKSCN+MicBbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS7gb/RH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddce722576so1365803b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550910; x=1707155710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+Pb9pW7pRGXoZWLwVdMMxRSRMr0QxM87xvWg4BF/x0=;
        b=QS7gb/RH+8J1fENzDBRjBw/JSsnaXq1AonzZ0B4wcFwu0d4IjbOXwSYwA4qPM0x+L0
         kIBB8xgkGB/OQD/pHIkYgHwzepN8Q+OV3FQoBMF3wAy5JZ45ZoHC1nQ49KrAh5w8+LGu
         gx6H/fc6ZOZBonifwv57Yn+NgBhCc+MV7T+n892zL3x0oegkSEVt2Vij0xdun0HwLwrj
         A7SA19FGvRAoEVwS8srUSQphcL2dc8rX4H1uBS5ivSYe5pzxEBjd5hQxgiwl8iPBDp5A
         pOKkT1r1mFK2PdZVENtuQHP+fAzZarq8iowOMRpGAK5Wumh0JAIgqpuaHG6j9/4Hxuq4
         bX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550910; x=1707155710;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+Pb9pW7pRGXoZWLwVdMMxRSRMr0QxM87xvWg4BF/x0=;
        b=WIhSHRSIDD3aYIYtW1Tnex5Jw8c96jKnn9E5Z8y0SZXVDSS41P4rr14nDtjMpWynh9
         A92Gm7rx1Fs3wSxEzpJ58e5lS4/9cvQuR2eezwZ/+dZAnSUIauLVpQvaryD6v7iFrTjE
         XfXTQtiM880VwWo1pmRpr0vcbcwskz+vffbp8ysgGkaa62DP89iG+maEhxhcsHrWjpC6
         bb0jSoYtj1eplLN3k24dnPx2BI/zL/XCDgLpyp9d1+mXzUcnW23BWGc5CiPgOdhcfy79
         84OVc22KLb+6VxRIXwk9Twx0NPMPIAMFatn2LJZFwmVNfUS1rhS5HOxbAWEVooTqFcm7
         XdVQ==
X-Gm-Message-State: AOJu0Yz6/RgxScFeg25kvbUsz6UPPB6FqIbC+bbMS26d69V1uUZecRdN
	LvmSOAuhjKaupZQ7PxMDSh+4RbYnaBREs4jlN5COGJ6V5fq1UjT/
X-Google-Smtp-Source: AGHT+IGbEgLtee7lvyw4iD4o6YyT7UJepc/uZ6izKXgvLtPBgmrhSNa0jHfm+bBxa5TucYAtg4TF4g==
X-Received: by 2002:a05:6a00:3ccf:b0:6da:cb36:6c00 with SMTP id ln15-20020a056a003ccf00b006dacb366c00mr3552820pfb.15.1706550909761;
        Mon, 29 Jan 2024 09:55:09 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:09 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 2/7] mm/swap: move no readahead swapin code to a stand-alone helper
Date: Tue, 30 Jan 2024 01:54:17 +0800
Message-ID: <20240129175423.1987-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129175423.1987-1-ryncsn@gmail.com>
References: <20240129175423.1987-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

No feature change, simply move the routine to a standalone function to
be re-used later. The error path handling is copied from the "out_page"
label, to make the code change minimized for easier reviewing.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 32 ++++----------------------------
 mm/swap.h       |  8 ++++++++
 mm/swap_state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..81dc9d467f4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3803,7 +3803,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
-	void *shadow = NULL;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -3867,33 +3866,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
-			page = &folio->page;
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
+			/* skip swapcache and readahead */
+			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
+			if (folio)
+				page = &folio->page;
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						vmf);
diff --git a/mm/swap.h b/mm/swap.h
index 758c46ca671e..83eab7b67e77 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -56,6 +56,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
+struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			    struct vm_fault *vmf);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -86,6 +88,12 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
+struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			struct vm_fault *vmf)
+{
+	return NULL;
+}
+
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..645f5bcad123 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -861,6 +861,53 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	return folio;
 }
 
+/**
+ * swapin_direct - swap in a folio skipping swap cache and readahead
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
+	/* skip swapcache */
+	folio = vma_alloc_folio(gfp_mask, 0,
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


