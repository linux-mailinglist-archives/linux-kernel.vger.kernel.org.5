Return-Path: <linux-kernel+bounces-43244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5E84115D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AAF1F2463D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811566F08F;
	Mon, 29 Jan 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg1gEsng"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4356F080
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550915; cv=none; b=ZkxeeHBLthKFEZ843DOkchw6amfUFzwu1SYqsB+/LRV3oMa+msYBkbU0Uomb7wvhWqH6XfxS0/aDuhejcDATqfNfQ88gpci4g8BhyeLyYg87qHIBflhWFZ+M4HyRxOo/MVTGzX5LiM/QAomSW0npWIU4taybKAqw687CRBSvegE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550915; c=relaxed/simple;
	bh=gi+xiGC4W0zt4Y0r8hfjrFyj6k4RkYn5+xN32KMpot8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf+lFvPKW2sIkvTlMpOQFjz40Thf/Yi9Gh7Xe46Rdu0ISs+7AFKGkvUGcP6oBJSDv9zIWuOlcXjNcRHrRfDT30ta8yZSek38Es0uw4NElg2ESd8je5FWnNqZ4SiMbb5MK3SSd6GbF1SvFw425SH+2ROrQtV1PJFu76dwqNsatFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg1gEsng; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6de029f88d8so2204263b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550913; x=1707155713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4HCCIzc96WSKi6JLRF97+BAewUvCrXyaCTHCA/v+eQk=;
        b=Hg1gEsngYLiMRW0UlgeCDbyuqaOl40DHyb/lE8NMItm7E+TDCR6cE41+Mcyfzlwmns
         +F00ARoocMM56w548EklvutM428qn3rkjxvaK5pP6HlxvR8ECEUw24cSrwa2Aisx5arj
         WVAjLb8NsEhI2vAxZJG8b+3kuhh6EwL6dnCDKZz2yRsMOe/Zt8xj6cHR3xkJIvaj6Esy
         sxrONZcbewrQn2cGHiTBe9FH3YDSOI5z1UMON/3/PD94AbCcRgPakyP0AMag9HkJ1Fjc
         AG9dfGXR2Cmza332qvBOZnZ/o2W1JDmByCxoEwNfQ5FB3z+FdJvYz9bfDziZIUwvS9ge
         cqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550913; x=1707155713;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HCCIzc96WSKi6JLRF97+BAewUvCrXyaCTHCA/v+eQk=;
        b=aWTMlBBoBI4SWCbBF+rrvIdjIfNWZdheAM1FlN4xa3w0wHcoh+PyDn/sElMK/2IcCU
         4OW01aj6qfnWPu5sH8LeM6cwiNIFiqjQrHGta88yTgqAyYtzodXvBPXqtxNy8XPInjn8
         /8WZLlKcH9UX49RQhqoSV7mzcKb0OfEeTsvriVvUJ7Pup8ti0NaAedd3pOE5QV1u5334
         G/ZcaocHFGJMPgOLbBbngwTXG2o4LwumJXcs0fPpKTiCpw5ddXX21Leqcm5SR4ACuHp9
         0Rs4f239Oh9Dkl6sg8Zgzs8pTYnPHWn/R2YQM3v7wc1y30HOaU3R9BNmIEyrkknQLqUT
         Y2Rg==
X-Gm-Message-State: AOJu0YzHMlRF4eBpvMB7W9zZ30w+I8tquhxg4jZud5Js+tSiG+HlcumL
	bRg/HNgsZKqL7uiJ6IEynxSVqbELtvK9J84o2QspueTiPJznmWNRBkVgM6euVVquxg==
X-Google-Smtp-Source: AGHT+IFgfEMwLjjlfjYQs4zDPrkINQJQhzD4VfcEfeCzLRYP1ozN1jTtfQN+mykLWdBBe4DQTBUsWg==
X-Received: by 2002:a05:6a20:438d:b0:19c:a398:4a67 with SMTP id i13-20020a056a20438d00b0019ca3984a67mr4049800pzl.55.1706550913483;
        Mon, 29 Jan 2024 09:55:13 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:12 -0800 (PST)
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
Subject: [PATCH v3 3/7] mm/swap: always account swapped in page into current memcg
Date: Tue, 30 Jan 2024 01:54:18 +0800
Message-ID: <20240129175423.1987-4-ryncsn@gmail.com>
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

Currently, mem_cgroup_swapin_charge_folio is always called with
mm == NULL, except in swapin_direct.

swapin_direct is only used when swapin should skip readahead
and swapcache (SWP_SYNCHRONOUS_IO). All other callers of
mem_cgroup_swapin_charge_folio are for swapin that should
not skip readahead and cache.

This could cause swapin charging to behave differently depending
on swap device, which is unexpected.

This is currently not happening because the only caller of
swapin_direct is the direct anon page fault path, where mm always
equals to current->mm, but will no longer be true if swapin_direct
is shared and have other callers (eg, swapoff) to share the
readahead skipping logic.

So make swapin_direct also pass NULL for mm, so swpain charge
will behave consistently and not effected by type of swapin device
or readahead policy.

After this, the second param of mem_cgroup_swapin_charge_folio is
never used now, so it can be safely dropped.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 5 ++---
 mm/swap_state.c            | 7 +++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..540590d80958 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -693,7 +693,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
-int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
+int mem_cgroup_swapin_charge_folio(struct folio *folio,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
@@ -1281,7 +1281,7 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
 }
 
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
-			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
+		gfp_t gfp, swp_entry_t entry)
 {
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..5852742df958 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7306,8 +7306,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
-				  gfp_t gfp, swp_entry_t entry)
+int mem_cgroup_swapin_charge_folio(struct folio *folio, gfp_t gfp, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg;
 	unsigned short id;
@@ -7320,7 +7319,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (!memcg || !css_tryget_online(&memcg->css))
-		memcg = get_mem_cgroup_from_mm(mm);
+		memcg = get_mem_cgroup_from_current();
 	rcu_read_unlock();
 
 	ret = charge_memcg(folio, memcg, gfp);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 645f5bcad123..a450d09fc0db 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -495,7 +495,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
-	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
+	if (mem_cgroup_swapin_charge_folio(folio, gfp_mask, entry))
 		goto fail_unlock;
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
@@ -884,9 +884,8 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
 
-		if (mem_cgroup_swapin_charge_folio(folio,
-					vma->vm_mm, GFP_KERNEL,
-					entry)) {
+		if (mem_cgroup_swapin_charge_folio(folio, GFP_KERNEL,
+						   entry)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			return NULL;
-- 
2.43.0


