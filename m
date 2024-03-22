Return-Path: <linux-kernel+bounces-111135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE71886847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430A42837F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A993B798;
	Fri, 22 Mar 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZymVidz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13D3A8F0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096489; cv=none; b=ZmeoEloRZePAWnk71PU7H15Wv8DTX/ohvad8yVNb9jISv3A76xGlZR6j+M+jhX3YD5HSF5OlxPf6ZZyQPpmXsW9m9Q+X8V0ONnQ90y10yKTgywBanEeWI1PdTO7BB3NI1qdcdrWyC/DI7Dfl3KA5DrVnlg+PV5/mqt7oVkreI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096489; c=relaxed/simple;
	bh=mMH/7is2PyQdNPPcgd1XKt1tQVN1U+t8U42cK5CGbhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaI+pWQpOcdrwowvf9pduyHmxcjoRLnLe7rexYeJTalgWUkRKOEIhiWmj3Ctjqev7OTtFUG+XVALDnXDbN6EYmEJ0pdZD99Fe64yGahtTruRucGpv+YIE/EMt5Exx1vrTHgiUbHBC2gF+M4AXxQ4JU4/g82PB6CXzFP8AAyD0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZymVidz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61807C433B2;
	Fri, 22 Mar 2024 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096488;
	bh=mMH/7is2PyQdNPPcgd1XKt1tQVN1U+t8U42cK5CGbhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZymVidz3av9KUT6Go6vA7X/x8b1ArdeFvYp18yRZGRi7LFSF5BGygSy2nSAuNS48N
	 oV//U8dnoMVOjWa0BZ4rHVLr0EJ1qsYlNQfQ9RbKxZMY2/ATKY8XT1JCPMhq2ivANK
	 u/nMXB+FYxQ9VgJFCSrQ+X7XAr1LA5u2XDrmtrwHXsB1AFYesR/Vm1xs/IKR5jygoU
	 n2X+VDFIExCWPIFpToJPdrk1bWwaZmv3OEEGmZ96CEje5LCAjnu9xki4q/3PG0umlS
	 B12ZuA20VXl0otZBh8fT6hYqd0DzBi8jxdsBwcVHmIBZBPffkFvku1uFrC1z8tcL0h
	 oikhkdgIYR9Rg==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v2 06/14] mm/ksm: use ksm_get_folio in scan_get_next_rmap_item
Date: Fri, 22 Mar 2024 16:36:53 +0800
Message-ID: <20240322083703.232364-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322083703.232364-1-alexs@kernel.org>
References: <20240322083703.232364-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Save a compound calls.

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
index a1e382ecd501..cd607b942c26 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2611,14 +2611,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		 */
 		if (!ksm_merge_across_nodes) {
 			struct ksm_stable_node *stable_node, *next;
-			struct page *page;
+			struct folio *folio;
 
 			list_for_each_entry_safe(stable_node, next,
 						 &migrate_nodes, list) {
-				page = get_ksm_page(stable_node,
-						    GET_KSM_PAGE_NOLOCK);
-				if (page)
-					put_page(page);
+				folio = ksm_get_folio(stable_node,
+						      GET_KSM_PAGE_NOLOCK);
+				if (folio)
+					folio_put(folio);
 				cond_resched();
 			}
 		}
-- 
2.43.0


