Return-Path: <linux-kernel+bounces-136557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3989D582
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29C5284C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22C84D14;
	Tue,  9 Apr 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5Bnq1HO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D083CBB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654725; cv=none; b=iWrVOEdiMbd9MfC1jpxJGTM8mCprsiPyauLT/wSjMLQoNWyXbnqhgL/OGaljgVLiUNa4XvDzyjcqLnOafpeLh9KQkxqsZGzOl5Jl1bTM5+Mi0zEqq5qkve643t7g/P8qGbkyLwwHCMu1Ik6brG3ZrrobjHIwq012zTuNCngBG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654725; c=relaxed/simple;
	bh=75r9vBcHOLP/QZTkSWPs35KE2gnggcdp1NXQWqEu+94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHpXvuBONGIeAAFhHscKf+1UwO5Dollie82mzYnZ7IOIsgb6Uc2tSoUbequREOglSGovOWUHCnTVIi3y13n7EQXFqEnlK6qXCah0nJ1RasMZPrpG25ehmDfoMQ59lTRpJDjvNn4aP8acKYHYOpcZLummpu7yhMtHsWbjwYGAGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5Bnq1HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215C9C433F1;
	Tue,  9 Apr 2024 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654725;
	bh=75r9vBcHOLP/QZTkSWPs35KE2gnggcdp1NXQWqEu+94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5Bnq1HOAUtLmDUOgf30B1us3yYOvoqfbsqdgljPW7tCMagB+HFvKmmnfPuHCqaAA
	 WPbEjJPAWmlTdry8oDNy9VfvJlw3qvFvbmUGQul6e8oP+RnraHBE2TakqzFIhvQuIq
	 gphN4ixndTfyy2XxZ/Ih4+dcjLFX157nljTFeGMVlsqBhy/vxZP0XlmVcr8GIPuJKa
	 g7j8plpLvXti8Y8cI7oq9RyAyMvD0AqSfkFNlBH7UdUQtfuiXx2IH96mDn4IDRkCZo
	 dWGzI82T70q/SMpExS+ufP8Za7G3Te0vL34DVbmTxufVb5E77tIJ5+arJk5Z4eqxrd
	 Gymd/Ri0z08AA==
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
Subject: [PATCH v4 4/9] mm/ksm: use folio in remove_stable_node
Date: Tue,  9 Apr 2024 17:28:19 +0800
Message-ID: <20240409092826.1733637-5-alexs@kernel.org>
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

pages in stable tree are all single normal page, so uses ksm_get_folio()
and folio_set_stable_node(), also saves 3 calls to compound_head().

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c9b7c5701f22..b6ee2bc7646f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1121,11 +1121,11 @@ static inline void folio_set_stable_node(struct folio *folio,
  */
 static int remove_stable_node(struct ksm_stable_node *stable_node)
 {
-	struct page *page;
+	struct folio *folio;
 	int err;
 
-	page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
-	if (!page) {
+	folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
+	if (!folio) {
 		/*
 		 * get_ksm_page did remove_node_from_stable_tree itself.
 		 */
@@ -1138,22 +1138,22 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	 * merge_across_nodes/max_page_sharing be switched.
 	 */
 	err = -EBUSY;
-	if (!page_mapped(page)) {
+	if (!folio_mapped(folio)) {
 		/*
 		 * The stable node did not yet appear stale to get_ksm_page(),
-		 * since that allows for an unmapped ksm page to be recognized
+		 * since that allows for an unmapped ksm folio to be recognized
 		 * right up until it is freed; but the node is safe to remove.
-		 * This page might be in an LRU cache waiting to be freed,
-		 * or it might be PageSwapCache (perhaps under writeback),
+		 * This folio might be in an LRU cache waiting to be freed,
+		 * or it might be in the swapcache (perhaps under writeback),
 		 * or it might have been removed from swapcache a moment ago.
 		 */
-		set_page_stable_node(page, NULL);
+		folio_set_stable_node(folio, NULL);
 		remove_node_from_stable_tree(stable_node);
 		err = 0;
 	}
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.43.0


