Return-Path: <linux-kernel+bounces-160634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCF8B407A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05691285549
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78B224C9;
	Fri, 26 Apr 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuBZFNFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD120319;
	Fri, 26 Apr 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161181; cv=none; b=ie6/QaaTWw9kigJBQSEfeUuDrHw+Dadnnz4QpW/unJPOlf5YtJdZICZB8WrQoa5pOfORmEUGN8GpL51IuCTfnIFCkkyuSKYCHNm8yXPlNO5EccjPFuJ5qcRKhizgfJxSAaQnsa47151MzfYCZ96zTdQFjuNW81rLWW0uDkLi4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161181; c=relaxed/simple;
	bh=q0ougyw7Umb7GSxVQouuuoREw7O7beWYRZUPMMfuCtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVWAT+WXSSnuXkAZLVdGzb6OS8b9xoZHChOWbtRSMLw+cdoDBgivIcIBULc7ht4RZ54969tA9KliDEBnj//SQl3z3CECYZj6lM88xKT4ISYHij3zkkc+/tPxs8llKnFrGeKtBDOr+oDeq/h5nIro6HO+oowGxt0HRq+UCuFWnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuBZFNFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF07C2BD10;
	Fri, 26 Apr 2024 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161180;
	bh=q0ougyw7Umb7GSxVQouuuoREw7O7beWYRZUPMMfuCtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuBZFNFW+n7ysMXFK5xQPz08L8HRsd3vbiGBevHLvdhLazTjRtvHpHpeZTEURwoY6
	 SIKHqPQbzTtOt5nTuqBxLnRdn2+xnW6Sq5Ehcg9D/xOP10v4Uw2VklESDv5RS5kWLK
	 kCdl7iIr1QMfKYlwBMCTiQISFW7CiIBG0jddZemWXJNNTm9HROiQxlqWr6DvdqefiG
	 gvxDL9uuYv4JeU398CZUPWMGostf6585yV9p1rNjCGF4Jeo6Bo7zHe/KZNW8HbrmOd
	 j/jnPzerkABscsKz8LT5yYfJFhEfikGBob9CzFCIJLZY6utDk+rDtETC8OAoshJzCE
	 SZ8jSW88XABLw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 1/7] mm/damon/paddr: implement damon_folio_young()
Date: Fri, 26 Apr 2024 12:52:40 -0700
Message-Id: <20240426195247.100306-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_young() receives physical address, get the folio covering the
address, and show if the folio is accessed since the last check.  A
following commit will reuse the internal logic for checking access to a
given folio.  To avoid duplication of the code, split the internal
logic.  Also, change the rmap walker function's name from
__damon_pa_young() to damon_folio_young_one(), following the change of
the caller's name and the naming rule that more commonly used by other
rmap walkers.

Signed-off-by: SeongJae Park <sj@kernel.org>
Tested-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e6dc312072cd..25c3ba2a9eaf4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -79,8 +79,8 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 	}
 }
 
-static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
-		unsigned long addr, void *arg)
+static bool damon_folio_young_one(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
@@ -111,38 +111,44 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	return *accessed == false;
 }
 
-static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+static bool damon_folio_young(struct folio *folio)
 {
-	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	bool accessed = false;
 	struct rmap_walk_control rwc = {
 		.arg = &accessed,
-		.rmap_one = __damon_pa_young,
+		.rmap_one = damon_folio_young_one,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
-	if (!folio)
-		return false;
-
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		if (folio_test_idle(folio))
-			accessed = false;
+			return false;
 		else
-			accessed = true;
-		goto out;
+			return true;
 	}
 
 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
 	if (need_lock && !folio_trylock(folio))
-		goto out;
+		return false;
 
 	rmap_walk(folio, &rwc);
 
 	if (need_lock)
 		folio_unlock(folio);
 
-out:
+	return accessed;
+}
+
+static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
+{
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
+	bool accessed;
+
+	if (!folio)
+		return false;
+
+	accessed = damon_folio_young(folio);
 	*folio_sz = folio_size(folio);
 	folio_put(folio);
 	return accessed;
-- 
2.39.2


