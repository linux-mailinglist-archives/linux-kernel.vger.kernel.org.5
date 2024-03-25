Return-Path: <linux-kernel+bounces-117034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDD88A659
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710BD2E3D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B76BB50;
	Mon, 25 Mar 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVV1IaWV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF956DCE8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370750; cv=none; b=mS07L1bnnf/BvE/LeLzTEO4w4zoOv0tZ0EUfKRflqbbkoCGGj6GCf6B6ZCxca5SzG12Mw87RHYFc3d5qAZR4iKxj0co2eHsJlLdOEtoOKG8xfTCK04t63QfRM03qNkEHSliqh4BfW5wURg9zC8o3EhFvbM0lDds0xQXpU7HWRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370750; c=relaxed/simple;
	bh=u2CpON+ylVsyq590GuxgPX8aACtNcQ54tsZFdjhyaWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swd9LtkCYUiGlFkoWysT+oUfWLbOcLjYTiluVD5eMhSYNbku3UUxKb9utONjtXddk3kz2qffDhH3sG8GHOkI1nsie9cq5OFscexiNu2NwgKcT2yfT4PVWW9qbzUynuJpTFz9mHcp8u1280E7ylAiRkhHIusjD7ALySMgO9qWops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVV1IaWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3302FC43394;
	Mon, 25 Mar 2024 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370750;
	bh=u2CpON+ylVsyq590GuxgPX8aACtNcQ54tsZFdjhyaWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVV1IaWV9vRcxYwQUums5xqSP5Wq1JaDlgBpGgCe+m6yPpVz9ksbPoP0pmrHEZuu0
	 v6WWcfakc0/tzBGby00uzvkxjcOBYM6cHLDbWRpFTq94slZHx4TcMPDwKpMzYzzNz0
	 BMidSuGaNRhfTXfWCVNvqoZqUh4twz18njVGGXwvDUBvTVjq/UvN6fFPsMhX3Vrt7z
	 aY3IAz2QpBy1FzTmFMmrd3Uzk8u+vLRLScq0kqqqEtzy66GpBwBQSuYmEXIScNvKzt
	 52cbGX7TGYSEhHydw6YfGvD4iY7cColqeIklQDrrLO+owD9mzzFk40BeiXE0DAfH40
	 jkgADT0ieNvdw==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v3 02/14] mm/ksm: use folio in remove_rmap_item_from_tree
Date: Mon, 25 Mar 2024 20:48:49 +0800
Message-ID: <20240325124904.398913-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325124904.398913-1-alexs@kernel.org>
References: <20240325124904.398913-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

To save 2 compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ac080235b002..ea3dabf71e47 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1006,16 +1006,16 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & STABLE_FLAG) {
 		struct ksm_stable_node *stable_node;
-		struct page *page;
+		struct folio *folio;
 
 		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
-		if (!page)
+		folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
+		if (!folio)
 			goto out;
 
 		hlist_del(&rmap_item->hlist);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (!hlist_empty(&stable_node->hlist))
 			ksm_pages_sharing--;
-- 
2.43.0


