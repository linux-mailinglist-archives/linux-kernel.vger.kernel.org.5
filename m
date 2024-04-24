Return-Path: <linux-kernel+bounces-156867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF2F8B0972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372E1282AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE715B150;
	Wed, 24 Apr 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKsbiQbw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADB15ADAE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961602; cv=none; b=nrFoUCdi4vPZi6Wl0RZ1H3z+Pp0YQEjO8uj1rEVSA4R7Emx23b3W86LkFjTe6z2jTmOwNEgx8FTShO1j+UdwhA7gJlNEgVEAAP/AeHCFpEvVfQQ6NRK4qsparRnxQ2FE3JdHR0cZ5w+nBWGMncVpztITg1TfS/XC2WYIsPZeKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961602; c=relaxed/simple;
	bh=MuZ+eCQWIxMfoH9uM3eWnGzNEQfRPjqnmhBrfa4frX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4hJHPpkjrO5pQSnXlQAdx9yyVp620kbPrRtTLqz+2dDolpE8naGsmdAcP22yR8yBOj8xjHJmXv0BwNTnUqMs0sWTu+NZ4cjlorAqfz9tvOKG/JsWdJ4SD/Y5w0CXlXpJXVxoskHFH2czkVlStVTM5vd9KLKMU9Bd2WoAGNLBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKsbiQbw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713961599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ga3+hfqpq7kefWMT7+hfg1368I6jLzziyLojN0hllE8=;
	b=UKsbiQbwi3GPnHeXy3IsfoBd/+DG1veii1ST4f+W3/rzrQAxRVQ0lOB5G6KEnP5tFwzAV7
	94o+Ondd2ZS72Q2kYMlPPNF11Myo03jg3QPkr6M7WjPvbuzWh14Wf4WgnPsHYbahMVHfbE
	ue0hlAASYJfZeTq0/ULryuN80JOAgYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-UF0W_gDvMVSSUKrV-5iNYQ-1; Wed, 24 Apr 2024 08:26:35 -0400
X-MC-Unique: UF0W_gDvMVSSUKrV-5iNYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0C88DCFC0;
	Wed, 24 Apr 2024 12:26:35 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEE052166B34;
	Wed, 24 Apr 2024 12:26:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Yang Shi <yang.shi@linux.alibaba.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v1] mm/khugepaged: replace page_mapcount() check by folio_likely_mapped_shared()
Date: Wed, 24 Apr 2024 14:26:30 +0200
Message-ID: <20240424122630.495788-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

We want to limit the use of page_mapcount() to places where absolutely
required, to prepare for kernel configs where we won't keep track of
per-page mapcounts in large folios.

khugepaged is one of the remaining "more challenging" page_mapcount()
users, but we might be able to move away from page_mapcount() without
resulting in a significant behavior change that would warrant
special-casing based on kernel configs.

In 2020, we first added support to khugepaged for collapsing COW-shared
pages via commit 9445689f3b61 ("khugepaged: allow to collapse a page shared
across fork"), followed by support for collapsing PTE-mapped THP in commit
5503fbf2b0b8 ("khugepaged: allow to collapse PTE-mapped compound pages")
and limiting the memory waste via the "page_count() > 1" check in commit
71a2c112a0f6 ("khugepaged: introduce 'max_ptes_shared' tunable").

As a default, khugepaged will allow up to half of the PTEs to map shared
pages: where page_mapcount() > 1. MADV_COLLAPSE ignores the khugepaged
setting.

khugepaged does currently not care about swapcache page references, and
does not check under folio lock: so in some corner cases the "shared vs.
exclusive" detection might be a bit off, making us detect "exclusive" when
it's actually "shared".

Most of our anonymous folios in the system are usually exclusive. We
frequently see sharing of anonymous folios for a short period of time,
after which our short-lived suprocesses either quit or exec().

There are some famous examples, though, where child processes exist for a
long time, and where memory is COW-shared with a lot of processes
(webservers, webbrowsers, sshd, ...) and COW-sharing is crucial for
reducing the memory footprint. We don't want to suddenly change the
behavior to result in a significant increase in memory waste.

Interestingly, khugepaged will only collapse an anonymous THP if at least
one PTE is writable. After fork(), that means that something (usually a
page fault) populated at least a single exclusive anonymous THP in that PMD
range.

So ... what happens when we switch to "is this folio mapped shared"
instead of "is this page mapped shared" by using
folio_likely_mapped_shared()?

For "not-COW-shared" folios, small folios and for THPs (large
folios) that are completely mapped into at least one process,
switching to folio_likely_mapped_shared() will not result in a change.

We'll only see a change for COW-shared PTE-mapped THPs that are
partially mapped into all involved processes.

There are two cases to consider:

(A) folio_likely_mapped_shared() returns "false" for a PTE-mapped THP

  If the folio is detected as exclusive, and it actually is exclusive,
  there is no change: page_mapcount() == 1. This is the common case
  without fork() or with short-lived child processes.

  folio_likely_mapped_shared() might currently still detect a folio as
  exclusive although it is shared (false negatives): if the first page is
  not mapped multiple times and if the average per-page mapcount is smaller
  than 1, implying that (1) the folio is partially mapped and (2) if we are
  responsible for many mapcounts by mapping many pages others can't
  ("mostly exclusive") (3) if we are not responsible for many mapcounts by
  mapping little pages ("mostly shared") it won't make a big impact on the
  end result.

  So while we might now detect a page as "exclusive" although it isn't,
  it's not expected to make a big difference in common cases.

(B) folio_likely_mapped_shared() returns "true" for a PTE-mapped THP

  folio_likely_mapped_shared() will never detect a large anonymous folio
  as shared although it is exclusive: there are no false positives.

  If we detect a THP as shared, at least one page of the THP is mapped by
  another process. It could well be that some pages are actually exclusive.
  For example, our child processes could have unmapped/COW'ed some pages
  such that they would now be exclusive to out process, which we now
  would treat as still-shared.

  Examples:
  (1) Parent maps all pages of a THP, child maps some pages. We detect
      all pages in the parent as shared although some are actually
      exclusive.
  (2) Parent maps all but some page of a THP, child maps the remainder.
      We detect all pages of the THP that the parent maps as shared
      although they are all exclusive.

  In (1) we wouldn't collapse a THP right now already: no PTE
  is writable, because a write fault would have resulted in COW of a
  single page and the parent would no longer map all pages of that THP.

  For (2) we would have collapsed a THP in the parent so far, now we
  wouldn't as long as the child process is still alive: unless the child
  process unmaps the remaining THP pages or we decide to split that THP.

  Possibly, the child COW'ed many pages, meaning that it's likely that
  we can populate a THP for our child first, and then for our parent.

  For (2), we are making really bad use of the THP in the first
  place (not even mapped completely in at least one process). If the
  THP would be completely partially mapped, it would be on the deferred
  split queue where we would split it lazily later.

  For short-running child processes, we don't particularly care. For
  long-running processes, the expectation is that such scenarios are
  rather rare: further, a THP might be best placed if most data in the
  PMD range is actually written, implying that we'll have to COW more
  pages first before khugepaged would collapse it.

To summarize, in the common case, this change is not expected to matter
much. The more common application of khugepaged operates on
exclusive pages, either before fork() or after a child quit.

Can we improve (A)? Yes, if we implement more precise tracking of "mapped
shared" vs. "mapped exclusively", we could get rid of the false
negatives completely.

Can we improve (B)? We could count how many pages of a large folio we map
inside the current page table and detect that we are responsible for most
of the folio mapcount and conclude "as good as exclusive", which might help
in some cases. ... but likely, some other mechanism should detect that
the THP is not a good use in the scenario (not even mapped completely in
a single process) and try splitting that folio lazily etc.

We'll move the folio_test_anon() check before our "shared" check, so we
might get more expressive results for SCAN_EXCEED_SHARED_PTE: this order
of checks now matches the one in __collapse_huge_page_isolate(). Extend
documentation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

How much time can one spend writing a patch description? Unbelievable. But
it was likely time well spend to have a clear picture of the impact.

This really needs the folio_likely_mapped_shared() optimization [1] that
resides in mm-unstable, I think, to reduce "false negatives".

The khugepage MM selftests keep working as expected, including:

	Run test: collapse_max_ptes_shared (khugepaged:anon)
	Allocate huge page... OK
	Share huge page over fork()... OK
	Trigger CoW on page 255 of 512... OK
	Maybe collapse with max_ptes_shared exceeded.... OK
	Trigger CoW on page 256 of 512... OK
	Collapse with max_ptes_shared PTEs shared.... OK
	Check if parent still has huge page... OK

Where we check that collapsing in the parent behaves as expected after
COWing a lot of pages in the parent: a sane scenario that is essentially
unchanged and which does not depend on any action in the child process
(compared to the cases discussed in (B) above).

[1] https://lkml.kernel.org/r/20240409192301.907377-6-david@redhat.com

---
 Documentation/admin-guide/mm/transhuge.rst |  3 ++-
 mm/khugepaged.c                            | 22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index f82300b9193fe..076443cc10a6c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -278,7 +278,8 @@ collapsed, resulting fewer pages being collapsed into
 THPs, and lower memory access performance.
 
 ``max_ptes_shared`` specifies how many pages can be shared across multiple
-processes. Exceeding the number would block the collapse::
+processes. khugepaged might treat pages of THPs as shared if any page of
+that THP is shared. Exceeding the number would block the collapse::
 
 	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_shared
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2f73d2aa9ae84..cf518fc440982 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -583,7 +583,8 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		folio = page_folio(page);
 		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
 
-		if (page_mapcount(page) > 1) {
+		/* See hpage_collapse_scan_pmd(). */
+		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
@@ -1317,8 +1318,20 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
+		folio = page_folio(page);
 
-		if (page_mapcount(page) > 1) {
+		if (!folio_test_anon(folio)) {
+			result = SCAN_PAGE_ANON;
+			goto out_unmap;
+		}
+
+		/*
+		 * We treat a single page as shared if any part of the THP
+		 * is shared. "False negatives" from
+		 * folio_likely_mapped_shared() are not expected to matter
+		 * much in practice.
+		 */
+		if (folio_likely_mapped_shared(folio)) {
 			++shared;
 			if (cc->is_khugepaged &&
 			    shared > khugepaged_max_ptes_shared) {
@@ -1328,7 +1341,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
-		folio = page_folio(page);
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
@@ -1349,10 +1361,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			result = SCAN_PAGE_LOCK;
 			goto out_unmap;
 		}
-		if (!folio_test_anon(folio)) {
-			result = SCAN_PAGE_ANON;
-			goto out_unmap;
-		}
 
 		/*
 		 * Check if the page has any GUP (or other external) pins.
-- 
2.44.0


