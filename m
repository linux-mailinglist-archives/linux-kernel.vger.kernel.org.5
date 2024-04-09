Return-Path: <linux-kernel+bounces-136555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595B89D580
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E8D1C22DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798F81745;
	Tue,  9 Apr 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9lLnck/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976F81216
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654720; cv=none; b=L6dqAXcTC6p+H4tVNeoeYljKt1cVMSiHF4NL6jdtGtjNZQ23rUvWcYuAzFsLWABqlwBvD9eaM5PmQB4L8fbsuMW1kFisXiiowXWVmwrFNtMNMgLcavnXGXAkh0Xh6EcoynErVOgVT9UTZrl+N8HNY3yJIFP1IV7fmDrCaxz1pWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654720; c=relaxed/simple;
	bh=IVhAzlnf/FbFRG9PEnvDGIGtbMw8j3OJiDaE0yo5KvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g08vy0GzrGD1KmLySprFK0a0Qz0jE6lQEBEQEQ9IcZh5RefMClgH9AjEugr9kTahCDgFCOOJ3kLVf1JQPyYxwPyCwlPSMIJX1lbDtWHgkw/RXaZuoEkrdkdjosM5A20zwudCdq4k83jMLQjHkyGFGfvbdKJj7wxqaJrWM5IowV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9lLnck/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8F0C433B2;
	Tue,  9 Apr 2024 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654719;
	bh=IVhAzlnf/FbFRG9PEnvDGIGtbMw8j3OJiDaE0yo5KvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9lLnck/EFYB51Ch65extYs7iz20UjcwqKAleLCh5etxv9i7HDqZ82ImyRakGRseu
	 Pdlzye6w9+SFe5lw0GRFLowvE3JZCKwRDpuDXnI423xC/rQVfyxivcxkonCU2YVLTZ
	 2qe9JsD1kGKPTfSBViXa6XOWcf8pGLz+iiw/9OhSA8ppiaIwqsb6LY/eLX9h8GRGMZ
	 ouoAZrQy0bfnG8+DQJTie69CTdAr7lBswCvZf2lf+z10wMqKOIUAzDDDoQwAq59hxC
	 xcaQY3pEymd7znTG4lG1ZvZvSfQkCx6XZZhrKLUNpbrA93wB6X1eTHGuwUr363y/W0
	 UnqUoiDYz6M2A==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 2/9] mm/ksm: use folio in remove_rmap_item_from_tree
Date: Tue,  9 Apr 2024 17:28:17 +0800
Message-ID: <20240409092826.1733637-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409092826.1733637-1-alexs@kernel.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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


