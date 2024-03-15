Return-Path: <linux-kernel+bounces-104198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECD87CA91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5980FB209B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8617BBF;
	Fri, 15 Mar 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LJR7X1s0"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F017736
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494336; cv=none; b=iAbazUdK3CrOvh0TZbzpmj1jzVgwsr9rA49m4PkryOt2w5R3I/ZfilGiiiSsOthyfTshTodJmegT9q0WogBOnI8LvZuBPgGjlT3QY+zKb5bmR7qkZVKXlLmd/0hr6BMuDcul0WPoSAUuAEmHcRUEELePaUsGbrLmjeL+Fna0/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494336; c=relaxed/simple;
	bh=AY8f/nbyNpOFIeuR8YkxcdtDKtWXHxPOmvqmatzn3N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDQN1H67xd6XZjwxTGYP6xLt0M+qNLDK2CbZfwF+PeLjMvmRtp6Xa6LMdx2qsdD6mmSOG2muwLwkWMTmXNSlCqfZ7m7XRVyuYUxpAzoeJrAoOjw/gRvalIGOpUcVknBk58puuOQnnRCJtllENVR0gDL+FDcf3jmgOqh/J6Co1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LJR7X1s0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710494330; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=97D5T+0qgCM53qnfwUSxUE2IuUc3aYh/5mhyW+Pe1Ds=;
	b=LJR7X1s0KgxeW9yAqoejyoV8JkXRvAbWEMQqzANDkB42n06kIB3fs+St7YpvAUK1LU0FqkSTVKUf5BtkD/JHzevGNRJivZ7uOJX6K1fKVSemljtuY8v4pBkdCp/bL8/VDyb4F0E3EKOFX0RiCLzMf+3cKLt+065RxhKruQiWYE4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W2W474o_1710494328;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2W474o_1710494328)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 17:18:49 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mgorman@techsingularity.net,
	wangkefeng.wang@huawei.com,
	jhubbard@nvidia.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] mm: support multi-size THP numa balancing
Date: Fri, 15 Mar 2024 17:18:14 +0800
Message-Id: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the anonymous page allocation already supports multi-size THP (mTHP),
but the numa balancing still prohibits mTHP migration even though it is an
exclusive mapping, which is unreasonable. Thus let's support the exclusive
mTHP numa balancing firstly.

Allow scanning mTHP:
Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
pages") skips shared CoW pages' NUMA page migration to avoid shared data
segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
NUMA-migrate COW pages that have other uses") change to use page_count()
to avoid GUP pages migration, that will also skip the mTHP numa scaning.
Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
issue, although there is still a GUP race, the issue seems to have been
resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
to skip shared CoW pages though this is not a precise sharers count. To
check if the folio is shared, ideally we want to make sure every page is
mapped to the same process, but doing that seems expensive and using
the estimated mapcount seems can work when running autonuma benchmark.

Allow migrating mTHP:
As mentioned in the previous thread[1], large folios are more susceptible
to false sharing issues, leading to pages ping-pong back and forth during
numa balancing, which is currently hard to resolve. Therefore, as a start to
support mTHP numa balancing, only exclusive mappings are allowed to perform
numa migration to avoid the false sharing issues with large folios. Similarly,
use the estimated mapcount to skip shared mappings, which seems can work
in most cases (?), and we've used folio_estimated_sharers() to skip shared
mappings in migrate_misplaced_folio() for numa balancing, seems no real
complaints.

Performance data:
Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
Base: 2024-3-15 mm-unstable branch
Enable mTHP=64K to run autonuma-benchmark

Base without the patch:
numa01
222.97
numa01_THREAD_ALLOC
115.78
numa02
13.04
numa02_SMT
14.69

Base with the patch:
numa01
125.36
numa01_THREAD_ALLOC
44.58
numa02
9.22
numa02_SMT
7.46

[1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from RFC v1:
 - Add some preformance data per Huang, Ying.
 - Allow mTHP scanning per David Hildenbrand.
 - Avoid sharing mapping for numa balancing to avoid false sharing.
 - Add more commit message.
---
 mm/memory.c   | 9 +++++----
 mm/mprotect.c | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..b9d5d88c5a76 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5059,7 +5059,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	int flags = 0;
+	int flags = 0, nr_pages = 0;
 
 	/*
 	 * The pte cannot be used safely until we verify, while holding the page
@@ -5089,8 +5089,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/* TODO: handle PTE-mapped THP */
-	if (folio_test_large(folio))
+	/* Avoid large folio false sharing */
+	if (folio_test_large(folio) && folio_estimated_sharers(folio) > 1)
 		goto out_map;
 
 	/*
@@ -5112,6 +5112,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
+	nr_pages = folio_nr_pages(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
@@ -5148,7 +5149,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 out:
 	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, 1, flags);
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
 	return 0;
 out_map:
 	/*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index f8a4544b4601..f0b9c974aaae 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 				/* Also skip shared copy-on-write pages */
 				if (is_cow_mapping(vma->vm_flags) &&
-				    folio_ref_count(folio) != 1)
+				    (folio_maybe_dma_pinned(folio) ||
+				     folio_estimated_sharers(folio) > 1))
 					continue;
 
 				/*
-- 
2.39.3


