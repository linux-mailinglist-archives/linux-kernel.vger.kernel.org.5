Return-Path: <linux-kernel+bounces-66874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0B8562F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B721C21CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BE12D754;
	Thu, 15 Feb 2024 12:18:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D713FF5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999492; cv=none; b=lpjhcgBbegZBDH6fvMtC1EhPz8qOc7jO1N3ynHk0xONRDvXGUi0ONlMDOAACjdjNqeg7B1RWzoHVXgem5pZs8d5zeD4fKpDjl2Qva0O6KF59P3dD9tf7ItzbbbmrSqcFELNsVK0wSQ15KQRlWucM/tQzD0X+ZeWFnHLjZop8n8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999492; c=relaxed/simple;
	bh=wChUY2n7KOLoXl9tar4y7xF2JR66QrvSAd+bls/t2rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEK2N4GPEX6aELJ8f3hci9ZihDyw5PbQWsAisJcLZ+VvdKZ73ov2Izxa9BW8L9nl9CXO6Wr5pQgQH7lEYJ7LM6N/1tuGp16FczQeQLh0OJ+ENkZSf9iQ3m79N3KJ/bVEeynpDGkGIJLi71Qr+wYDry8JdjAb9BtryV9a/hNZnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B279B1480;
	Thu, 15 Feb 2024 04:18:50 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F853F766;
	Thu, 15 Feb 2024 04:18:07 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/4] mm/gup: Use ptep_get_lockless_norecency()
Date: Thu, 15 Feb 2024 12:17:54 +0000
Message-Id: <20240215121756.2734131-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215121756.2734131-1-ryan.roberts@arm.com>
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gup needs to read ptes locklessly, so it uses ptep_get_lockless().
However, the returned access and dirty bits are unimportant so let's
switch over to ptep_get_lockless_norecency().

The wrinkle is that gup needs to check that the pte hasn't changed once
it has pinned the folio following this model:

    pte = ptep_get_lockless_norecency(ptep)
    ...
    if (!pte_same(pte, ptep_get_lockless(ptep)))
            // RACE!
    ...

And now that pte may not contain correct access and dirty information,
the pte_same() comparison could spuriously fail. So let's introduce a
new pte_same_norecency() helper which will ignore the access and dirty
bits when doing the comparison.

Note that previously, ptep_get() was being used for the comparison; this
is technically incorrect because the PTL is not held. I've also
converted the comparison to use the preferred pmd_same() helper instead
of doing a raw value comparison.

As a side-effect, this new approach removes the possibility of
concurrent read/write to the page causing a spurious fast gup failure,
because the access and dirty bits are no longer used in the comparison.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 18 ++++++++++++++++++
 mm/gup.c                |  7 ++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9dd40fdbd825..8123affa8baf 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -936,6 +936,24 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 }
 #endif

+/**
+ * pte_same_norecency - Compare pte_a and pte_b, ignoring young and dirty bits,
+ *			if the ptes are present.
+ *
+ * @pte_a: First pte to compare.
+ * @pte_b: Second pte to compare.
+ *
+ * Returns 1 if the ptes match, else 0.
+ */
+static inline int pte_same_norecency(pte_t pte_a, pte_t pte_b)
+{
+	if (pte_present(pte_a))
+		pte_a = pte_mkold(pte_mkclean(pte_a));
+	if (pte_present(pte_b))
+		pte_b = pte_mkold(pte_mkclean(pte_b));
+	return pte_same(pte_a, pte_b);
+}
+
 #ifndef __HAVE_ARCH_PTE_UNUSED
 /*
  * Some architectures provide facilities to virtualization guests
diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..0f96d0a5ec09 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2576,7 +2576,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	if (!ptep)
 		return 0;
 	do {
-		pte_t pte = ptep_get_lockless(ptep);
+		pte_t pte = ptep_get_lockless_norecency(ptep);
 		struct page *page;
 		struct folio *folio;

@@ -2617,8 +2617,9 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			goto pte_unmap;
 		}

-		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
-		    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
+		if (unlikely(!pmd_same(pmd, *pmdp)) ||
+		    unlikely(!pte_same_norecency(pte,
+					ptep_get_lockless_norecency(ptep)))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
--
2.25.1


