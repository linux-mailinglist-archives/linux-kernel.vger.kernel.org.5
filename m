Return-Path: <linux-kernel+bounces-163110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DC8B65DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1861C212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5B7441F;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOVb+7he"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776F2561F;
	Mon, 29 Apr 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430698; cv=none; b=hB+H8CsmXfdKiObRlUcifHJhmv41gFOE3n1uAanFA7Rr31jbHDxvuMM9v1T1DeXg83BfA5ftYuCW3WG8TMVc+0OIPpCQmZMM2iGgjSoFEQUMuy6RyIod799blz6+gmrQ+8LfaL/n8nOpS5u3yZpidmbyiuFdtCwfWZJFxcIGpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430698; c=relaxed/simple;
	bh=mENk5G88cYd3MXH884J6VW2xQ20zMe3RoStwvahKaVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENXXgzRVRvJ2Tpbx+VEJh1TnLpsUIDyTfxTagMfCobS32jTN+rPafo+siuKzJmg2mnpsyvaXo1PdlyBAtGdJRUOD8QwXtHTFFlU3KgpI+uHdbVbhN+NJx07SKbPp8GCnEsHUgHGNIPC5lmLf2js2lRxXkY5ULpfosi0QjhlEta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOVb+7he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F9C4AF17;
	Mon, 29 Apr 2024 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430697;
	bh=mENk5G88cYd3MXH884J6VW2xQ20zMe3RoStwvahKaVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOVb+7heQ3WwXvk0thHVAc7hGwVjDLKdY428VNMOlvAawCnraFMZ0bP6PGHp99LhZ
	 hvAu47Dmw1GvdyEgaauwyfO6N1mvn5cAfOMnRlhjGrlakozgB3teDCh7qZky88clEn
	 3bSqWAtgJ5UuXhKIV3wgyZ6ZaOgT93do2h5RpKPP3eFkhxeFFs3AYTYu3RdK6uGcgY
	 Ex7qzWG/3oXzRskceqor3/3YlKh7M6lTHaDwoMLaD7YEIN5LrUFKlR6yZAB7C6DOy3
	 FK6X8WGP22G23fWyeHJ2nGSg1JoqWGHMnnQ/A6W9pOFHOJ2Gwk3hO3iwqJBK+Ixfhs
	 9PFN4V67WZj1g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm/damon/paddr: avoid unnecessary page level access check for pageout DAMOS action
Date: Mon, 29 Apr 2024 15:44:48 -0700
Message-Id: <20240429224451.67081-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429224451.67081-1-sj@kernel.org>
References: <20240429224451.67081-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'pageout' DAMOS action implementation of 'paddr' asks reclaim_pages() to
do the page level access check.  User could ask DAMOS to do the page
level access check on its own using 'young page' type DAMOS filter.  In
the case, pageout DAMOS action unnecessarily asks reclaim_pages() to do
the check again.  Ask the page level access check only if the scheme is
not having the filter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5685ba485097..d5f2f7ddf863 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -244,6 +244,16 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
+	bool ignore_references = false;
+	struct damos_filter *filter;
+
+	/* respect user's page level reference check handling request */
+	damos_for_each_filter(filter, s) {
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			ignore_references = true;
+			break;
+		}
+	}
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
@@ -265,7 +275,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list, false);
+	applied = reclaim_pages(&folio_list, ignore_references);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
-- 
2.39.2


