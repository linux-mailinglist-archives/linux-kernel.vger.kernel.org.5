Return-Path: <linux-kernel+bounces-163111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916638B65E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D9EB21055
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7668126F07;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny6osMgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B92E3E8;
	Mon, 29 Apr 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430698; cv=none; b=F5Irr09iDScoNZnFRsd8Vwo9l8W+8sNMAY9S+I1gOF97++YTdR7M/kLebIDwwph8YalL50TZqVtwuvdTnCNzL0mk35DjcJBYxXhVXvBxmBqTF98jIT0g/hSs0fDdPGG9zdD/yQXqn3BkGGHXtbScUMFjD/hDpgigE3PKSFu56mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430698; c=relaxed/simple;
	bh=AH03oSjW6IlmpdP3TkCfshDEgNgfP3nlydglW7MDGsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEFrpd2/C0+nlY6onlGXS8jFjPT1Gkkr++lgsCMU0+RKFkPmpUz1MG4ykhaEalPKV5RitOyIOfrp/NXSvU9W5ILGJCITs1HufWfEkn1MAZY+rbfZdtNPUx7CKzb7uSUJg7SMMVwRVVmnEpO2pBgq70IDw/xbX9i9Q1d/DmYcKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny6osMgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6FFC4AF1B;
	Mon, 29 Apr 2024 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430698;
	bh=AH03oSjW6IlmpdP3TkCfshDEgNgfP3nlydglW7MDGsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny6osMgl45sRK1kTdOdB6auEHpoy9gyum6G8OViYWxx5YHF2tI09BaNYiUiQcM1XE
	 CwsnkaXlQWiDC4fyWrn1I+XwFkdEwvX5dKhuKg/nm+9bdGn0y7PKJAyKCFUuyklO9D
	 dvDeBNzrSWTFQOx08wMh6KdfBsiQbT+oMRUzz0/87a37KlHyp2AjnGZqCxPAsg0LSU
	 NF6ze2KTg100UJ2SoPwg/gpn6iM4fjetutiBmcJ6PYtj9f3UKD3nPGU5Q9DHSrgW74
	 rFUA74TFGHpHWd8ilXj58w3CIyNERfRMxsz02cOVqB4FhMBaBy9mceOVkTlgZpeCax
	 FjpYOOiaKPSjQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm/damon/paddr: do page level access check for pageout DAMOS action on its own
Date: Mon, 29 Apr 2024 15:44:49 -0700
Message-Id: <20240429224451.67081-3-sj@kernel.org>
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

'pageout' DAMOS action implementation of 'paddr' DAMON operations set
asks reclaim_pages() to do page level access check if the user is not
asking DAMOS to do that on its own.  Simplify the logic by making the
check always be done by 'paddr'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d5f2f7ddf863..974edef1740d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -244,16 +244,22 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
-	bool ignore_references = false;
+	bool install_young_filter = true;
 	struct damos_filter *filter;
 
-	/* respect user's page level reference check handling request */
+	/* check access in page level again by default */
 	damos_for_each_filter(filter, s) {
 		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
-			ignore_references = true;
+			install_young_filter = false;
 			break;
 		}
 	}
+	if (install_young_filter) {
+		filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true);
+		if (!filter)
+			return 0;
+		damos_add_filter(s, filter);
+	}
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
@@ -275,7 +281,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list, ignore_references);
+	if (install_young_filter)
+		damos_destroy_filter(filter);
+	applied = reclaim_pages(&folio_list, true);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
-- 
2.39.2


