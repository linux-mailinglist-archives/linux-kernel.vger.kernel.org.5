Return-Path: <linux-kernel+bounces-139833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C278A083A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753112823BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97013E023;
	Thu, 11 Apr 2024 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8rhinow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AD13DDD8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816082; cv=none; b=RwnqeM+SmQigE5XiOGMA+j2VEvBIyesMZ0i03QJySllWRKKvF5nUNxQxiDeCyA/tn5InQ6Jxlh9oJVI1NQYUjIuT/GTdq2vuEhl3wmHGoIG/iqh22v4MKkr5/uDZQRjLTedtFB5RNzQiopTADvk+l+zH6atydCHo3/vGP/jHdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816082; c=relaxed/simple;
	bh=2BbBT91rO5EKEsTUfQ1HnSSvv2jhr/Cd5b48tiAufmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB1oygyXhkWwvG80KiDCShrOJXAg/P+tcwU8Tg8Npl9hQ5luZTxld97ab35L/CGApvyDfuyNa+Jk7eMkXhuxIW3RNlQj0eNCoEQCAorvLfSuhcTVeeWmPD8rvjrAVL/tp2nKja3I9nwK0dIQKesM7daAM05bCyinuByzKSjyd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8rhinow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C97C433C7;
	Thu, 11 Apr 2024 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816082;
	bh=2BbBT91rO5EKEsTUfQ1HnSSvv2jhr/Cd5b48tiAufmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8rhinowpXykMIv8xrZeYQ4/sM/rBmUtzroByI24TOcabbu/AkuHzwOo+wLvLyBpS
	 ei0r0IEsaUt6MiLYL78P4HxgT4D0qn7aVE0oPYB+vS8d+2JgmWR7RC6mVVCbCYkxJS
	 d96sO+9dyG3l6GtE7RAf2pH1a4qCulOXq6jesyBIpnKlqbyvXaujgi2UkUOtJ9tsME
	 3vjChWTYULjRrUtk/iQvsOXiOwgV8vZobvEoLodOJdwvRydog0NJLVNYYyq2vcvoi2
	 U4GARspuxshWeFuJK3WhJGdkBjbfZ05BoReePvWFmPG2XqxozAr9Nz/Z39EAWC3ew+
	 x5SoVAJSv6oPA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 10/10] mm/ksm: replace set_page_stable_node by folio_set_stable_node
Date: Thu, 11 Apr 2024 14:17:11 +0800
Message-ID: <20240411061713.1847574-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Only single page could be reached where we set stable node after write
protect, so use folio converted func to replace page's. And remove the
unused func set_page_stable_node().

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 662fdaaf3ea3..486c9974f8e2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1094,17 +1094,11 @@ static inline struct ksm_stable_node *page_stable_node(struct page *page)
 	return folio_stable_node(page_folio(page));
 }
 
-static inline void set_page_stable_node(struct page *page,
-					struct ksm_stable_node *stable_node)
-{
-	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
-	set_page_stable_node(&folio->page, stable_node);
+	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
+	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
 #ifdef CONFIG_SYSFS
@@ -1519,7 +1513,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
 			 * stable_tree_insert() will update stable_node.
 			 */
-			set_page_stable_node(page, NULL);
+			folio_set_stable_node(page_folio(page), NULL);
 			mark_page_accessed(page);
 			/*
 			 * Page reclaim just frees a clean page with no dirty
-- 
2.43.0


