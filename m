Return-Path: <linux-kernel+bounces-136734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF789D7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3512E1C21C87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6185C66;
	Tue,  9 Apr 2024 11:18:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4384D02
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661533; cv=none; b=Qy5PCJ3pN+4QyzEjCoBJb9rwvofzlQ9BdEL9j8X0MIjCHPnM2LxyQ1PA/Ah9d1KzD7EUxHZGtkTGubIccNY8XH2DypiBgMHq6S5OFn0D47qODx6Nb1YGTswtmgGPlxSVVSLHY2ksc8wnRXfwG2FVo7Ot0CTUScX992CTMHt4kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661533; c=relaxed/simple;
	bh=C8XSHHbZdaZmK277E+clDOVcF2WeEwCbBp5BARHmHz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByOyg1bmhfb91hoEd3fdt2usAyKvVaUBErEo3cKdp7uii7mhi/rN2aKlmuLvotA4ehNttnHgDCYQGjl4Utl6ClRG8yEeL8GXqI4GA1OivSlQgWnjzFliXHTeM3VO/7xmr2Ol97s1Loxd4K/A+bqA2XB+emsJyapX3DHgcy4Fo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9940D1007;
	Tue,  9 Apr 2024 04:19:21 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87B523F766;
	Tue,  9 Apr 2024 04:18:49 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] FIXUP: mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
Date: Tue,  9 Apr 2024 12:18:40 +0100
Message-Id: <20240409111840.3173122-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408183946.2991168-3-ryan.roberts@arm.com>
References: <20240408183946.2991168-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Could you please squash this into commit "mm: swap:
free_swap_and_cache_nr() as batched free_swap_and_cache()", which is
already in mm-unstable?

It fixes a build warning on parisc [1] due to their implementation of
__swp_entry_to_pte() not correctly putting the macro args in
parenthisis. But it turns out that a bunch of other arches are also
faulty in this regard.

I'm also adding an extra statement to the documentation for
pte_next_swp_offset() as suggested by David.

[1] https://lore.kernel.org/all/202404091749.ScNPJ8j4-lkp@intel.com/

Thanks,
Ryan

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/internal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9d3250b4a08a..22152e0c8494 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -202,7 +202,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,

 /**
  * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; is_swap_pte(pte) must be true.
+ * @pte: The initial pte state; is_swap_pte(pte) must be true and
+ *	 non_swap_entry() must be false.
  *
  * Increments the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
@@ -211,7 +212,7 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
 {
 	swp_entry_t entry = pte_to_swp_entry(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
-						   swp_offset(entry) + 1));
+						   (swp_offset(entry) + 1)));

 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
--
2.25.1


