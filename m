Return-Path: <linux-kernel+bounces-109338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 444A48817CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3FA1F230DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FB85639;
	Wed, 20 Mar 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byvHiINb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1E85297
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962660; cv=none; b=qnvGNs+W5TLzBeEt7A7MnsH0q0hJOl9jHsKWCtlVyfaR7lW1p75tzHgOnvpbrlQWFomweA/fvUqvhs6fkc4s+FYQL2KgU4zU23a8MrNoOWq1Owcot8UKFELGMp420S4LLTn7PxsR2IfDI+CBIxPlk5OicaUTu2O0dgiugCOjRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962660; c=relaxed/simple;
	bh=lMA43VdEHBqBP72UIiAFn6zFxgBbJ+OBQ7Zro7YY/U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOXlBVl5Dx53ysmDLsQrJmhuMBMBG6BHVmgKAzwDRA6nTRme2Er+qcj61ScnjJwFh85/RrWli7gxBkDSzz8nokGPrishFt6UCwhQ3WdbU1J6l75z+bENQwLkCSCeVKax/fHnErr0Uph55/SQTeOFfTjATZnMAAfUhhVLW5jpxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byvHiINb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ccAdZs1oCvHFT7nKITQ3hrVOSJeKubMiKC4AFoVzgBU=; b=byvHiINb/6kUw/Z0D8woz4k1ly
	NJWWYgGBamMpIwUbhyfMDy+/VEQkmJ4Pc5Z1KB9/7p4Qg3fit7ScNmLgdUXsELpnDSpzbOkafLAF3
	ugbLme2b2gfr/gmqQ00VZldC9bGfwJONto3go8Xavz843ysH21d3cnqZUmlFwLRuAqZ4jG+HfnITg
	VoRZQuu7Bq4/+ml7yCnL7dNMvm3CP5Bt5CzMlLobhF+b7pHWyxmComZK10FG6jx7jMUDnNdQzRE3n
	KybnjSXI5k1NgFL866OZcw+n+tOE9Ty7rNYUFUUm52r8jupy5PvmLeH03UvC9JUu7BgKM3MwAYF4z
	6vbb2iUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn1Xp-00000004xgA-3HDt;
	Wed, 20 Mar 2024 19:24:13 +0000
Date: Wed, 20 Mar 2024 19:24:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Svetly Todorov <svetly.todorov@memverge.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregory.price@memverge.com, wangkefeng.wang@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	naoya.horiguchi@linux.dev
Subject: Re: [PATCH v3] kpageflags: respect folio head-page flag placement
Message-ID: <Zfs33TNtHvnjDX3J@casper.infradead.org>
References: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>

On Wed, Mar 20, 2024 at 10:28:09AM -0700, Svetly Todorov wrote:
> Page flags are now stored per-folio. Change kpageflags to report these
> per-folio flags where appropriate.

I have a somewhat different patch for this.  Let me know what you think.
It depends on a few other patches in my tree, so probably won't compile
for you.

From 42b20425c8b9b94f1273a410462babd4363622df Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 5 Mar 2024 05:38:33 +0000
Subject: [PATCH] proc: Rewrite stable_page_flags()

Reduce the usage of PageFlag tests and reduce the number of
compound_head() calls.  We also no longer need to check PageSlab before
checking page_mapped() as slub does not reuse the mapcount field.

For multi-page folios, we'll now show all pages as having the flags,
eg if it's locked, all pages will have the locked bit set instead of
just the head page.  The mapped bit is still per page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/page.c             | 63 ++++++++++++++++++--------------------
 include/linux/page-flags.h |  2 +-
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..0f9ef5866c0d 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -107,10 +107,13 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 	return ((kflags >> kbit) & 1) << ubit;
 }
 
-u64 stable_page_flags(struct page *page)
+u64 stable_page_flags(const struct page *page)
 {
-	u64 k;
-	u64 u;
+	const struct folio *folio;
+	unsigned long k;
+	unsigned long mapping;
+	bool is_anon;
+	u64 u = 0;
 
 	/*
 	 * pseudo flag: KPF_NOPAGE
@@ -118,52 +121,46 @@ u64 stable_page_flags(struct page *page)
 	 */
 	if (!page)
 		return 1 << KPF_NOPAGE;
+	folio = page_folio(page);
 
-	k = page->flags;
-	u = 0;
+	k = folio->flags;
+	mapping = (unsigned long)folio->mapping;
+	is_anon = mapping & PAGE_MAPPING_ANON;
 
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
-	 *
-	 * Note that page->_mapcount is overloaded in SLAB, so the
-	 * simple test in page_mapped() is not enough.
 	 */
-	if (!PageSlab(page) && page_mapped(page))
+	if (page_mapped(page))
 		u |= 1 << KPF_MMAP;
-	if (PageAnon(page))
+	if (is_anon)
 		u |= 1 << KPF_ANON;
-	if (PageKsm(page))
+	if (mapping & PAGE_MAPPING_KSM)
 		u |= 1 << KPF_KSM;
 
 	/*
 	 * compound pages: export both head/tail info
 	 * they together define a compound page's start/end pos and order
 	 */
-	if (PageHead(page))
-		u |= 1 << KPF_COMPOUND_HEAD;
-	if (PageTail(page))
+	if (page == &folio->page)
+		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
+	else
 		u |= 1 << KPF_COMPOUND_TAIL;
-	if (PageHuge(page))
+	if (folio_test_hugetlb(folio))
 		u |= 1 << KPF_HUGE;
 	/*
-	 * PageTransCompound can be true for non-huge compound pages (slab
-	 * pages or pages allocated by drivers with __GFP_COMP) because it
-	 * just checks PG_head/PG_tail, so we need to check PageLRU/PageAnon
+	 * We need to check PageLRU/PageAnon
 	 * to make sure a given page is a thp, not a non-huge compound page.
 	 */
-	else if (PageTransCompound(page)) {
-		struct page *head = compound_head(page);
-
-		if (PageLRU(head) || PageAnon(head))
+	else if (folio_test_large(folio)) {
+		if ((k & PG_lru) || is_anon)
 			u |= 1 << KPF_THP;
-		else if (is_huge_zero_page(head)) {
+		else if (is_huge_zero_folio(folio)) {
 			u |= 1 << KPF_ZERO_PAGE;
 			u |= 1 << KPF_THP;
 		}
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= 1 << KPF_ZERO_PAGE;
 
-
 	/*
 	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
 	 * on the head page.
@@ -178,15 +175,15 @@ u64 stable_page_flags(struct page *page)
 	if (PageTable(page))
 		u |= 1 << KPF_PGTABLE;
 
-	if (page_is_idle(page))
+#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
+	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
+#else
+	if (folio_test_idle(folio))
 		u |= 1 << KPF_IDLE;
+#endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(page))
-		u |= 1 << KPF_SLAB;
-
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
@@ -197,7 +194,8 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
-	if (PageSwapCache(page))
+#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
+	if ((k & SWAPCACHE) == SWAPCACHE)
 		u |= 1 << KPF_SWAPCACHE;
 	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
@@ -231,7 +229,6 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
-	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
@@ -248,9 +245,9 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 		 * TODO: ZONE_DEVICE support requires to identify
 		 * memmaps that were actually initialized.
 		 */
-		ppage = pfn_to_online_page(pfn);
+		struct page *page = pfn_to_online_page(pfn);
 
-		if (put_user(stable_page_flags(ppage), out)) {
+		if (put_user(stable_page_flags(page), out)) {
 			ret = -EFAULT;
 			break;
 		}
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 068c9bd43ebf..92a64faa851c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -716,7 +716,7 @@ static __always_inline bool PageKsm(const struct page *page)
 TESTPAGEFLAG_FALSE(Ksm, ksm)
 #endif
 
-u64 stable_page_flags(struct page *page);
+u64 stable_page_flags(const struct page *page);
 
 /**
  * folio_xor_flags_has_waiters - Change some folio flags.
-- 
2.43.0


