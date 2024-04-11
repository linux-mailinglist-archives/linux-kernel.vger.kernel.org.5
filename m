Return-Path: <linux-kernel+bounces-139827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2F8A0834
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B516B26BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1413D601;
	Thu, 11 Apr 2024 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtcW68Rk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6F13D528
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816066; cv=none; b=nLd12UheKWr8VPoUczTwBMcUKRJ96u9osEJLaKG2l1OKXCX6TekflVsOEl7vxNoxwgutyhX099wHXTxOwhztrbVgydip6/J+5TMjnCf2zyV1Wza/M0PUC5N1MsVyavXuxZsd4Wo3i+5NgLm0QEHZU4GdIUOs5is9yP+jkNUPzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816066; c=relaxed/simple;
	bh=Psjp2Yi0v76d8BNfvxYBx/0pfRjAkX6bKnyisDETHPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW10POnAIT6CUDlZaWq0MU6OAwrTr+vey0oS9SXsMZARX/Avkf3JBxtPcNki+zUEAKQuERGACdcWu6FnXbHNrB6kuGmv8g3x70pYIEvuAVXbn3ouMf1VjUr4CLRMBpmcoixbdzXtazKvBmf4OvMhR6DhZOcdlms0OweawtxikhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtcW68Rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740FCC43394;
	Thu, 11 Apr 2024 06:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816065;
	bh=Psjp2Yi0v76d8BNfvxYBx/0pfRjAkX6bKnyisDETHPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtcW68Rk2WAP6ax3CbHdN4r9JSIXDouQiaVp9hG8moEE+5MKD9ffWBUO5Tn/KJyGa
	 NfMqOSI1Kg9SLWaCAt4mINhEpg8uA7V7AKNHrWSJYnO/ytFtlTDCyhvBN+CTNRELWd
	 0W7pOuXj7+4Qz1Yrt9MI3dBZ++m5FTGRNZwXgaBy7O6ENdkgvPdaLIokjOEX0Y1vEg
	 sbXCZW8tv+k9RUzc3/1RDiZxV2ZLzjVu1im7P69RmdYadEdObhiNkPKUKPxbdSRiXH
	 GTO+PjJ/hF0piGutbC7coJxsH5pq0KB1O1RE/qRF9ayCTCpxB/q5W/pf8Klp/KRFgE
	 rF3mDjkj6WvAg==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 04/10] mm/ksm: use folio in remove_stable_node
Date: Thu, 11 Apr 2024 14:17:05 +0800
Message-ID: <20240411061713.1847574-5-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
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

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 3c52bf9df84c..1a7b13004589 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1121,13 +1121,13 @@ static inline void folio_set_stable_node(struct folio *folio,
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
-		 * get_ksm_page did remove_node_from_stable_tree itself.
+		 * ksm_get_folio did remove_node_from_stable_tree itself.
 		 */
 		return 0;
 	}
@@ -1138,22 +1138,22 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	 * merge_across_nodes/max_page_sharing be switched.
 	 */
 	err = -EBUSY;
-	if (!page_mapped(page)) {
+	if (!folio_mapped(folio)) {
 		/*
-		 * The stable node did not yet appear stale to get_ksm_page(),
-		 * since that allows for an unmapped ksm page to be recognized
+		 * The stable node did not yet appear stale to ksm_get_folio(),
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


