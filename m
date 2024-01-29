Return-Path: <linux-kernel+bounces-43247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DB841164
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE3D28DC65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029A76052;
	Mon, 29 Jan 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edbcJj8w"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A807603E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550927; cv=none; b=mwv+wnUtuQv8HmgOg+m1Az5KzfqC8l9WJgtdD3gwaxKf4UNFchZqsaG1oZJoi79JMAAP3ET/8bY+iMzKcU6iVA369bRYyn7b8ppWN2pLgynGdAlif7zTtseIc1PrFtBO66fJnZ22gOfbvaFCbGJJ8g80HG1YzhjXB3pOAyX0plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550927; c=relaxed/simple;
	bh=tjHlLFIJDmU300Vj/ROonoglxJFuadD0P5tPsb2UWkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBNBnZLCxwIPJ4by6f2N1cogVTIWFUfeCE9mU6xOxoCUnPV47JvwJaSzLeFrl7TWC9fURsXC8UqsqI4GrnOrzcq6LuzpiKY4ikCl2QpaMkvHW2qRc0T0No3CyVX7bchbHWfrDJI+rLf6KrD8FYXbvrOrk3BNXGa5UAyGEWYDkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edbcJj8w; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd6581bc66so2516433b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550925; x=1707155725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vG41zT4S0no8o7fWFQ9pcIk63IVt4FqG1CDDNkW0Zi0=;
        b=edbcJj8wLCnVlPM0jiIa5RNAuRSa4VHnxBD2FxDfztRed4znWAl3T70bPZlAeGIOaK
         Zm+Oe6SzPxF0gS8r5Q7To/ZkI18wWHVKb9eX3i3FiAbt1VnasVbuv46xygY8Ol3wkjI1
         QqwUjcVa/WqCeTRYGF0mN2tHcLGcK+/MbreopW340qMrefjUXcWujfBlMiVZBT5I0z+5
         Rpy3ZgsQf0TZ6tXaS/VszWlWrBgFQKUzsqyj/wRpcTB6OhVh1m0QLW+tq6M4DrcAuvFD
         L7BNMgODKSKFg6hYAIPgdH3qduQIggCqKXQ/Iilf9fGrXtLavF9kAR7FZCGmYmWXU/GH
         eEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550925; x=1707155725;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vG41zT4S0no8o7fWFQ9pcIk63IVt4FqG1CDDNkW0Zi0=;
        b=ZjYPRY+O3SmvPc5SgTyg+hUDMP9ZXUUDQeECRCDwwaznhRXeBI9BDb2rqf2UnXN4/i
         W32NLuc4QhW5poLO3Y9EysYI/g5pZB/ItNfJ52Eft9carkVmA/9vT72SuOYRNMcLTFhi
         UJSAMfx0Q5AWJShb+lDWBUG67SLc94No4ILRuQ/bMGJgo+P2Z0JMpF3pp/2oA51JN3kF
         KUllURTuU5mjzlkifarUkgUgafJshfaA6Wip9puUaW6r/IjUVhcL2sUbme3ZuFnJ0FMq
         acgMcaBHAQxBSrrLq6EroH9yfl+g/ASjtML6mxRYz55gsIm+zTA++Sl5oqKyMfP2qsQQ
         yOEA==
X-Gm-Message-State: AOJu0YwvIY+w1Zudr3K1rceaQSUi6UhxBRJwU0REvY07UepzzXVbAG2/
	aWyNozeQt9Go5IEkJ5DKNWcCCuu2bqx+Tmpt+cpjQf5mYserCwAp
X-Google-Smtp-Source: AGHT+IESw8A9HzVVYux2+WCOfmmBri6bmvTIsnqEfHR4nt5s9rQPNkemhyM/5eb8SN0HT9K9hl0z2w==
X-Received: by 2002:a05:6808:23ca:b0:3be:453d:e061 with SMTP id bq10-20020a05680823ca00b003be453de061mr4478694oib.6.1706550924927;
        Mon, 29 Jan 2024 09:55:24 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:24 -0800 (PST)
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
Subject: [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem
Date: Tue, 30 Jan 2024 01:54:21 +0800
Message-ID: <20240129175423.1987-7-ryncsn@gmail.com>
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

Currently, shmem uses cluster readahead for all swap backends. Cluster
readahead is not a good solution for ramdisk based device (ZRAM), and
it's better to skip it.

After switching to the new helper, most benchmarks showed a good result:

- Single file sequence read on ramdisk:
  perf stat --repeat 20 dd if=/tmpfs/test of=/dev/null bs=1M count=8192
  (/tmpfs/test is a zero filled file, using brd as swap, 4G memcg limit)
  Before: 22.248 +- 0.549
  After:  22.021 +- 0.684 (-1.1%)

- shmem FIO test 1 on a Ryzen 5900HX:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs --size=960m \
    --ioengine=mmap --rw=randread --random_distribution=zipf:0.5 \
    --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

Before:
  bw (  MiB/s): min= 1167, max= 1732, per=100.00%, avg=1460.82, stdev= 4.38, samples=9536
  iops        : min=298938, max=443557, avg=373964.41, stdev=1121.27, samples=9536
After (+3.5%):
  bw (  MiB/s): min= 1285, max= 1738, per=100.00%, avg=1512.88, stdev= 4.34, samples=9456
  iops        : min=328957, max=445105, avg=387294.21, stdev=1111.15, samples=9456

- shmem FIO test 2 on a Ryzen 5900HX:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs --size=960m \
    --ioengine=mmap --rw=randread --random_distribution=zipf:1.2 \
    --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

Before:
  bw (  MiB/s): min= 5296, max= 7112, per=100.00%, avg=6131.93, stdev=17.09, samples=9536
  iops        : min=1355934, max=1820833, avg=1569769.11, stdev=4375.93, samples=9536
After (+3.1%):
  bw (  MiB/s): min= 5466, max= 7173, per=100.00%, avg=6324.51, stdev=16.66, samples=9521
  iops        : min=1399355, max=1836435, avg=1619068.90, stdev=4263.94, samples=9521

So cluster readahead doesn't help much even for single sequence read,
and for random stress tests, the performance is better without it.

Considering both memory and swap devices will get more fragmented
slowly, and commonly used ZRAM consumes much more CPU than plain
ramdisk, false readahead could occur more frequently and waste
more CPU. Direct SWAP is cheaper, so use the new helper and skip
read ahead for SWP_SYNCHRONOUS_IO device.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     |  2 +-
 mm/shmem.c      | 50 +++++++++++++++++++++++++++++++----------------
 mm/swap.h       | 14 ++++---------
 mm/swap_state.c | 52 +++++++++++++++++++++++++++++++++----------------
 mm/swapfile.c   |  2 +-
 5 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 349946899f8d..51962126a79c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3866,7 +3866,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	if (!folio) {
 		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-				     vmf, &swapcache, shadow);
+				     vmf, NULL, 0, &swapcache, shadow);
 		if (!folio) {
 			/*
 			 * Back out if somebody else faulted in this pte
diff --git a/mm/shmem.c b/mm/shmem.c
index 698a31bf7baa..d3722e25cb32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1565,15 +1565,16 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
 			pgoff_t index, unsigned int order, pgoff_t *ilx);
 
-static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
+static struct folio *shmem_swapin(swp_entry_t swap, gfp_t gfp,
+			struct shmem_inode_info *info, pgoff_t index,
+			struct folio **swapcache, void *shadow)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
 
 	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
-	folio = swap_cluster_readahead(swap, gfp, mpol, ilx);
+	folio = swapin_entry(swap, gfp, NULL, mpol, ilx, swapcache, shadow);
 	mpol_cond_put(mpol);
 
 	return folio;
@@ -1852,8 +1853,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct folio *swapcache = NULL, *folio;
 	struct swap_info_struct *si;
-	struct folio *folio = NULL;
+	void *shadow = NULL;
 	swp_entry_t swap;
 	int error;
 
@@ -1873,8 +1875,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0, NULL);
-	if (!folio) {
+	folio = swap_cache_get_folio(swap, NULL, 0, &shadow);
+	if (folio) {
+		swapcache = folio;
+	} else {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
@@ -1882,7 +1886,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 		/* Here we actually start the io */
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
+		folio = shmem_swapin(swap, gfp, info, index, &swapcache, shadow);
 		if (!folio) {
 			error = -ENOMEM;
 			goto failed;
@@ -1891,17 +1895,21 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
-	if (!folio_test_swapcache(folio) ||
-	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap)) {
+	if (swapcache) {
+		if (!folio_test_swapcache(folio) || folio->swap.val != swap.val) {
+			error = -EEXIST;
+			goto unlock;
+		}
+		if (!folio_test_uptodate(folio)) {
+			error = -EIO;
+			goto failed;
+		}
+		folio_wait_writeback(folio);
+	}
+	if (!shmem_confirm_swap(mapping, index, swap)) {
 		error = -EEXIST;
 		goto unlock;
 	}
-	if (!folio_test_uptodate(folio)) {
-		error = -EIO;
-		goto failed;
-	}
-	folio_wait_writeback(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
@@ -1909,12 +1917,19 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 */
 	arch_swap_restore(swap, folio);
 
-	if (shmem_should_replace_folio(folio, gfp)) {
+	/* If swapcache is bypassed, folio is newly allocated respects gfp flags */
+	if (swapcache && shmem_should_replace_folio(folio, gfp)) {
 		error = shmem_replace_folio(&folio, gfp, info, index);
 		if (error)
 			goto failed;
 	}
 
+	/*
+	 * The expected value checking below should be enough to ensure
+	 * only one up-to-date swapin success. swap_free() is called after
+	 * this, so the entry can't be reused. As long as the mapping still
+	 * has the old entry value, it's never swapped in or modified.
+	 */
 	error = shmem_add_to_page_cache(folio, mapping, index,
 					swp_to_radix_entry(swap), gfp);
 	if (error)
@@ -1925,7 +1940,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
-	delete_from_swap_cache(folio);
+	if (swapcache)
+		delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
 	swap_free(swap);
 	put_swap_device(si);
diff --git a/mm/swap.h b/mm/swap.h
index ca9cb472a263..597a56c7fb02 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -53,10 +53,9 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists);
-struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_entry(swp_entry_t entry, gfp_t flag, struct vm_fault *vmf,
-		struct folio **swapcached, void *shadow);
+		struct mempolicy *mpol, pgoff_t ilx,
+		struct folio **swapcache, void *shadow);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -81,14 +80,9 @@ static inline void show_swap_cache_info(void)
 {
 }
 
-static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
-			gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t ilx)
-{
-	return NULL;
-}
-
 static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf, struct folio **swapcached, void *shadow)
+			struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx,
+			struct folio *swapcache, void *shadow);
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e41a137a6123..20c206149be4 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -316,6 +316,18 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 	release_pages(pages, nr);
 }
 
+static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
+{
+	int count;
+
+	if (!data_race(si->flags & SWP_SYNCHRONOUS_IO))
+		return false;
+
+	count = __swap_count(entry);
+
+	return (count == 1 || count == SWAP_MAP_SHMEM);
+}
+
 static inline bool swap_use_vma_readahead(void)
 {
 	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
@@ -635,8 +647,8 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are used for every page of the readahead: neighbouring pages on swap
  * are fairly likely to have been swapped out from the same node.
  */
-struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				    struct mempolicy *mpol, pgoff_t ilx)
+static struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
+					    struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
 	unsigned long entry_offset = swp_offset(entry);
@@ -876,14 +888,13 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * in.
  */
 static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-				  struct vm_fault *vmf, void *shadow)
+				   struct mempolicy *mpol, pgoff_t ilx,
+				   void *shadow)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 
-	/* skip swapcache */
-	folio = vma_alloc_folio(gfp_mask, 0,
-				vma, vmf->address, false);
+	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0,
+			mpol, ilx, numa_node_id());
 	if (folio) {
 		__folio_set_locked(folio);
 		__folio_set_swapbacked(folio);
@@ -916,6 +927,10 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
  * @swapcache: set to the swapcache folio if swapcache is used
+ * @mpol: NUMA memory alloc policy to be applied,
+ *        not needed if vmf is not NULL
+ * @targ_ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE,
+ *            not needed if vmf is not NULL
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
@@ -924,26 +939,29 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * or vma-based(ie, virtual address based on faulty address) readahead,
  * or skip the readahead(ie, ramdisk based swap device).
  */
-struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
-			   struct vm_fault *vmf, struct folio **swapcache, void *shadow)
+struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask, struct vm_fault *vmf,
+			   struct mempolicy *mpol, pgoff_t ilx,
+			   struct folio **swapcache, void *shadow)
 {
-	struct mempolicy *mpol;
+	bool mpol_put = false;
 	struct folio *folio;
-	pgoff_t ilx;
 
-	if (data_race(swp_swap_info(entry)->flags & SWP_SYNCHRONOUS_IO) &&
-	    __swap_count(entry) == 1) {
-		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
-	} else {
+	if (!mpol) {
 		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-		if (swap_use_vma_readahead())
+		mpol_put = true;
+	}
+	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
+		folio = swapin_direct(entry, gfp_mask, mpol, ilx, shadow);
+	} else {
+		if (vmf && swap_use_vma_readahead())
 			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
 		else
 			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-		mpol_cond_put(mpol);
 		if (swapcache)
 			*swapcache = folio;
 	}
+	if (mpol_put)
+		mpol_cond_put(mpol);
 
 	return folio;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index aac26f5a6cec..7ff05aaf6925 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1875,7 +1875,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			};
 
 			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-					    &vmf, NULL, NULL);
+					    &vmf, NULL, 0, NULL, NULL);
 		}
 		if (!folio) {
 			/*
-- 
2.43.0


