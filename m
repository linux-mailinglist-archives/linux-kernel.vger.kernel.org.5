Return-Path: <linux-kernel+bounces-154521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E878ADD14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D41C21917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D865208A8;
	Tue, 23 Apr 2024 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4F4bHP1"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140F1B966
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849546; cv=none; b=qLWoGcheoqwzpFDcmpr1IONeCo9XNtN3CFscGhqCf2WOEyVnV6j+MW3afEuOUjG+1tZ5yKVEpRmmSfgYDDkCCo7tKsOVznk0ZieJ8KKQMxLIjpQLiQPTwFCYhwpLGTXFLE20xm4UBq1FuFJNLlWQ7VrZxanxMIuSTaPl6wHtFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849546; c=relaxed/simple;
	bh=eiXcrRuZw4LtEHNUEA4exwXwssnNKo06rp7vQRI3atg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6HSOHcIdOSZQ5arMvYM0Vh7T5yyJCzbuSJJ5T2f8CKYWpF5PAYfQ0WuPOfP/Dnw0EOD36YDSryG9U+HJWJsgCI7SP8K5QCrGTB7IR4hBWDcJcX6+CXTOeix9cvZ92kZvD1mdL3QsLHiG6dgcQNfHIFe6YFWgORLZt5ms/uepLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4F4bHP1; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713849540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmlC5V1svJt9xuRUdyZMky0nyZvqteAMmSbcGNRQ+Ug=;
	b=I4F4bHP1pHL9StE0oEfUCq18gVSk6V5wUHsNH2r4mbFqr3BWQqPEZJK6aDP5C5HBbpIZbm
	7qNg7St16OMmZI9IF5XHvpKb6ahSRJqZ0Zorrf3bW8J+CXso/2RX9xjYMLMCnj2Tim11hK
	zgXSePbl3UN1y1lt9gtQCIJB2FGhKJk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at start
Date: Mon, 22 Apr 2024 22:18:23 -0700
Message-ID: <20240423051826.791934-2-shakeel.butt@linux.dev>
In-Reply-To: <20240423051826.791934-1-shakeel.butt@linux.dev>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment the memcg stats are sized based on the size of enum
node_stat_item but not all fields in node_stat_item corresponds to memcg
stats. So, rearrage the contents of node_stat_item such that all the
memcg specific stats are at the top and then the later patches will make
sure that the memcg code will not waste space for non-memcg stats.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/mmzone.h | 25 +++++++++++++------------
 mm/vmstat.c            | 24 ++++++++++++------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f9c9590a42c..989ca97402c6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -166,9 +166,6 @@ enum node_stat_item {
 	NR_UNEVICTABLE,		/*  "     "     "   "       "         */
 	NR_SLAB_RECLAIMABLE_B,
 	NR_SLAB_UNRECLAIMABLE_B,
-	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
-	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
-	WORKINGSET_NODES,
 	WORKINGSET_REFAULT_BASE,
 	WORKINGSET_REFAULT_ANON = WORKINGSET_REFAULT_BASE,
 	WORKINGSET_REFAULT_FILE,
@@ -179,39 +176,43 @@ enum node_stat_item {
 	WORKINGSET_RESTORE_ANON = WORKINGSET_RESTORE_BASE,
 	WORKINGSET_RESTORE_FILE,
 	WORKINGSET_NODERECLAIM,
+	NR_PAGETABLE,		/* used for pagetables */
+	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
+	NR_KERNEL_STACK_KB,	/* measured in KiB */
 	NR_ANON_MAPPED,	/* Mapped anonymous pages */
 	NR_FILE_MAPPED,	/* pagecache pages mapped into pagetables.
 			   only modified from process context */
 	NR_FILE_PAGES,
+#ifdef CONFIG_SWAP
+	NR_SWAPCACHE,
+#endif
 	NR_FILE_DIRTY,
 	NR_WRITEBACK,
-	NR_WRITEBACK_TEMP,	/* Writeback using temporary buffers */
 	NR_SHMEM,		/* shmem pages (included tmpfs/GEM pages) */
 	NR_SHMEM_THPS,
-	NR_SHMEM_PMDMAPPED,
 	NR_FILE_THPS,
-	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	/* No memcg stats for the following fields. */
+	NR_SHMEM_PMDMAPPED,
+	NR_FILE_PMDMAPPED,
+	NR_WRITEBACK_TEMP,	/* Writeback using temporary buffers */
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
+	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
+	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
+	WORKINGSET_NODES,
 	NR_DIRTIED,		/* page dirtyings since bootup */
 	NR_WRITTEN,		/* page writings since bootup */
 	NR_THROTTLED_WRITTEN,	/* NR_WRITTEN while reclaim throttled */
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
-	NR_PAGETABLE,		/* used for pagetables */
-	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
 #ifdef CONFIG_IOMMU_SUPPORT
 	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
 #endif
-#ifdef CONFIG_SWAP
-	NR_SWAPCACHE,
-#endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..4eac2f6322a3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1206,9 +1206,6 @@ const char * const vmstat_text[] = {
 	"nr_unevictable",
 	"nr_slab_reclaimable",
 	"nr_slab_unreclaimable",
-	"nr_isolated_anon",
-	"nr_isolated_file",
-	"workingset_nodes",
 	"workingset_refault_anon",
 	"workingset_refault_file",
 	"workingset_activate_anon",
@@ -1216,38 +1213,41 @@ const char * const vmstat_text[] = {
 	"workingset_restore_anon",
 	"workingset_restore_file",
 	"workingset_nodereclaim",
+	"nr_page_table_pages",
+	"nr_sec_page_table_pages",
+	"nr_kernel_stack",
 	"nr_anon_pages",
 	"nr_mapped",
 	"nr_file_pages",
+#ifdef CONFIG_SWAP
+	"nr_swapcached",
+#endif
 	"nr_dirty",
 	"nr_writeback",
-	"nr_writeback_temp",
 	"nr_shmem",
 	"nr_shmem_hugepages",
-	"nr_shmem_pmdmapped",
 	"nr_file_hugepages",
-	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
+	"nr_shmem_pmdmapped",
+	"nr_file_pmdmapped",
+	"nr_writeback_temp",
 	"nr_vmscan_write",
 	"nr_vmscan_immediate_reclaim",
+	"nr_isolated_anon",
+	"nr_isolated_file",
+	"workingset_nodes",
 	"nr_dirtied",
 	"nr_written",
 	"nr_throttled_written",
 	"nr_kernel_misc_reclaimable",
 	"nr_foll_pin_acquired",
 	"nr_foll_pin_released",
-	"nr_kernel_stack",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	"nr_shadow_call_stack",
 #endif
-	"nr_page_table_pages",
-	"nr_sec_page_table_pages",
 #ifdef CONFIG_IOMMU_SUPPORT
 	"nr_iommu_pages",
 #endif
-#ifdef CONFIG_SWAP
-	"nr_swapcached",
-#endif
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
-- 
2.43.0


