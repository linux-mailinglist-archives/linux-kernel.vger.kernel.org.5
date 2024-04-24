Return-Path: <linux-kernel+bounces-157816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A03E8B16A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6510EB263C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10116EC11;
	Wed, 24 Apr 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="isdLGzb9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1516EBEF;
	Wed, 24 Apr 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999460; cv=none; b=MaV6nu9fGketJhxhyHWpuCf6uz+kU2wiHe2ncK7uVUkoRLdkyk7z8nGWUlybqteFfygP5J7JN13hCryjMR0fn/IRKlGhc3HK+Wr2E2fstaJHBUgdmaaL5hU1JG6Fl/+C7qP1quob1gaO1ofgV8zmzSKmOs+7/DRT92cDrnco+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999460; c=relaxed/simple;
	bh=dDpQLM/A90V6FHzG8I7BWr+7YixCe0fkfYcU2fZH4m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3ZcpEBMe5rNJKddaZ2vhqoAj0+Ct5/IlAD4BkX/Qvzujm+Dhb/VD1oQfEWSgfBqwOgvxXqQSA0ClIhZYlxgyML2YXr0dO8mI5r6Xy7ZxFWKrkqkyE99MMseVG5Bg+6+9tPvV0gtT+mApI9lrmRy+3qy8MstoDOgumVBG1RA6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=isdLGzb9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/6C2shD4qBCTT7YeBf2iTXjP2N2Wy5ZL4SfFDScrsFE=; b=isdLGzb9DsGv6ujvVfVDJszM0h
	f0WjjfF7KgwVjGH6VHD29bbBaF+mAnPLlwf354oFmGP9JoV7Ilw2/PtXIsaYCyTMcmSe1a2hmR6TH
	fhq2/sJevPoJjGv0OsfkfFGuyzptrHQV0hoiiYaShWW8J1rm6HpfQNKMX3GjJia/5eLkntxSkQUw6
	+yQ0AhoAdH1Cd8o0J3RkMYTkuuOJjwYnJ+D0G+AqxjMZW8WOWcyrBhjPWJpjfrqDODcQm1AGqPhlM
	6oZUE2Z8/Nyb5qATc61CXrN2AIofoe9npQB0LO7OwuijIHw/DuEK+7exmo+Jz6Nmen7E+N+01Ho8E
	P5mfpiZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlYX-00000006IUP-2Zdv;
	Wed, 24 Apr 2024 22:57:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH] mm/huge_memory: move writeback and truncation checks early
Date: Wed, 24 Apr 2024 15:57:36 -0700
Message-ID: <20240424225736.1501030-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We should check as early as possible if we should bail due to writeback
or truncation. This will allow us to add further sanity checks earlier
as well.

This introduces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

While working on min order support for LBS this came up as an improvement
as we can check for the min order early earlier, so this sets the stage
up for that.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 86a8c7b3b8dc..32c701821e0d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3055,8 +3055,17 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	/* Cannot split anonymous THP to order-1 */
-	if (new_order == 1 && folio_test_anon(folio)) {
+	if (folio_test_writeback(folio))
+		return -EBUSY;
+
+	if (!folio_test_anon(folio)) {
+		/* Truncated ? */
+		if (!folio->mapping) {
+			ret = -EBUSY;
+			goto out;
+		}
+	} else if (new_order == 1) {
+		/* Cannot split anonymous THP to order-1 */
 		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
 		return -EINVAL;
 	}
@@ -3079,16 +3088,12 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		}
 	}
 
-
 	is_hzp = is_huge_zero_page(&folio->page);
 	if (is_hzp) {
 		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
 		return -EBUSY;
 	}
 
-	if (folio_test_writeback(folio))
-		return -EBUSY;
-
 	if (folio_test_anon(folio)) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -3111,12 +3116,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 
 		mapping = folio->mapping;
 
-		/* Truncated ? */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		/*
 		 * Do not split if mapping has minimum folio order
 		 * requirement.
-- 
2.43.0


