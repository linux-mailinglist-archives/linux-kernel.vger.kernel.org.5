Return-Path: <linux-kernel+bounces-106101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCF87E928
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A150B1F23845
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69697381B1;
	Mon, 18 Mar 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhNCPdXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0424381A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763881; cv=none; b=mGw3VNU7GCAcx37z6xAYgRQF5hXNuTCSRj2ZwxwTbzDr2QXKn3L4oJQVfWJMi8tNe13hyXu/9OlrFH6k/dn2FR8MImuxA9B4QvXYrmFIwWUg2N5KQch9gktANW61wdx+jAJu+Cq6xXplDyTDg8sNES6se0FHWERS+vDqNDwfYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763881; c=relaxed/simple;
	bh=JGYfbRVIlHuHoI0NmXjtxepKc6ayun3xXlgDn4j46pw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NKo3AZzvO7yhfo2sfRDADYYnAIENyIEorGGD2pnZSOUFaaI/g433KDP/r0ODHfaHBFStWlt/blHYWw0+KOZIKQR97nrkDLW5dDw87gSwtJ6thpzTNYDiM+9+jokTR/AKGodtRRev1khLdZ1XspHaM8xOxMyXy652bjwQB9HqZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhNCPdXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A178C433F1;
	Mon, 18 Mar 2024 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710763881;
	bh=JGYfbRVIlHuHoI0NmXjtxepKc6ayun3xXlgDn4j46pw=;
	h=From:To:Subject:Date:From;
	b=qhNCPdXYMkprcVdjnMn62xTr1ev9QT80OeSwydB8rxi2JOdRpMbLfbVXABSBeqO/B
	 QNn+lahk2HRco7Ry/mGwVwYXVhIJLQ2+vxjol3pMpexnomkDo1Az+EEj2IG3ZF4el1
	 sZqhtbj56qd+zBEiKBb6DkBfjX3ta6qqWlM7LLsTPx7SdIjd+BVi+MgVNksfGWnS1h
	 SefuNpistEXlrQ3w9/+za8sLv4iS7nnwfoG6Fm89v+IoF1VemtGdNlml6j6rWgq2pY
	 SmDsBHVyqF8tWaY6pj1lYDpJBHglTnCVyTnLA7bG2/QzrvSBqnzl4olfVuaIO022CA
	 ZlvQG2kuW3KxA==
From: alexs@kernel.org
To: kasong@tencent.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/12] mm/ksm: catch tail page abnormal in page_stable_node
Date: Mon, 18 Mar 2024 20:14:30 +0800
Message-ID: <20240318121443.3991104-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
meaning of func page_stable_node() to check the compound head for tail
'page' instead of tail page self.
But seems both semantics are same at results, the func always return NULL
 for tail page. So adding a bug monitor here in case of abnormal.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
To: linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
---
 mm/ksm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..3ff469961927 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1091,7 +1091,12 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
 
 static inline struct ksm_stable_node *page_stable_node(struct page *page)
 {
-	return folio_stable_node(page_folio(page));
+	struct ksm_stable_node *node;
+
+	node = folio_stable_node(page_folio(page));
+	VM_BUG_ON_PAGE(PageTail(page) && node, page);
+
+	return node;
 }
 
 static inline void set_page_stable_node(struct page *page,
-- 
2.43.0


