Return-Path: <linux-kernel+bounces-108551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20368880C23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0014280D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7B224D7;
	Wed, 20 Mar 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxsXOdDy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3EAD49
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920264; cv=none; b=V9hasQVGfj/+qDOVabAOAdx0fjipcYLoFkWQmWIx2lf8msMCG8/jDKjnrL5oPNL0M2zye1nh/z39eGfkSSCI+FMmTI8DalhxwNuz8NoatEZ6hcq4G2CDUtA/9IPkoeX2yCM31UivMbrVFq6CeXjsnV/mO5GqlRNjXvwNEd9Rug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920264; c=relaxed/simple;
	bh=ogVdYvzWIODvepKssBDhcBjAFm2MyCuzb8iad0ikR9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTfK9ThmhNqxmrpKD+85tWn6oow1AgcVwJJU5orNt7JjIVeSzqCgsRhwtVNZcLAEAOwJYWBXGDR0RilGUXBEnNbXODK65c9hN4f8y3k4BOKN1z/dh7XlBxY00+WjneLN3AYdkCryrgDNZLkmrGi4e+lkv1w1vIkj/ZzJr/eks40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxsXOdDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565C8C433F1;
	Wed, 20 Mar 2024 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920263;
	bh=ogVdYvzWIODvepKssBDhcBjAFm2MyCuzb8iad0ikR9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxsXOdDyeQz/LeOFJ5thcrVWPFUWSF0xAf89HiGMSe1y1BQ5CAtLaFvVrMHInOuCX
	 n08x7z24gQKQo1Cys2BHt6sOQ0roKLbru2L4miwJv5QpKzMF0f31/Lm2LEH6kR523t
	 20RATbtX0L90o6l3JGyxonZhk3vkJOCXrcafdQzlPDTPVbAFVtXtB6Tv1vhu/iEyVG
	 G7HhTffwrFbNX6CMK4TGBGryk31ciBggJCmbLm/iNrVqu7JvPkUAnhs0cNnxl4w+p9
	 pej6aCsV5pTOSmF5hEJTHfIxd7MPpkAe3JtPHU6COh7OhEJLXeBnUgbRwgXSco1Jsf
	 EYGDO6JVtUAnw==
From: alexs@kernel.org
To: Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 02/11] mm/ksm: use a folio in remove_rmap_item_from_tree
Date: Wed, 20 Mar 2024 15:40:38 +0800
Message-ID: <20240320074049.4130552-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320074049.4130552-1-alexs@kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Save 2 compound_head calls.

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
index fda291b054c2..922e33500875 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -998,16 +998,16 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & STABLE_FLAG) {
 		struct ksm_stable_node *stable_node;
-		struct page *page;
+		struct folio *folio;
 
 		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
-		if (!page)
+		folio = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
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


