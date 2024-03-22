Return-Path: <linux-kernel+bounces-111133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993E886845
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA571F2170C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B42837F;
	Fri, 22 Mar 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imVmTgVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75E249FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096483; cv=none; b=Wip+CpcuPqV8s0uqH9Dwy4OymN5o29I8/LLD2RhhZAbOSM8NJl+Lfo1vOTjYK15fQ9yU9OrDRxUPWHv+MwBNqVQmEBjAHNfF95il0cKDCuTZA2ICq09fDTC+J4O6i9aI2PuD3LMQj+UE4wMTszaMDCuoJo+aMMxJeH9xLrinPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096483; c=relaxed/simple;
	bh=k8zytA2A5T1rgDUiIACZ6hBdX8Fv5Jcn+9QWsQNKn6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWJgjO0M6FncJ+jqgzi0jMNTyjNPqJyc0xPV4BN2BTcrIzN9nA6zfMTlNVxCJYY7S7Eptl7af1HPolLzR0DCzv1AUsKs8wAnS1iReU+2ppUgf0OB/HkeRDM8iZJjRWOkTs0aY8V6IGlcajC2GBEl2f4oucbta2UTfzkdHthON3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imVmTgVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AF0C433F1;
	Fri, 22 Mar 2024 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096482;
	bh=k8zytA2A5T1rgDUiIACZ6hBdX8Fv5Jcn+9QWsQNKn6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imVmTgVqlm+AmLk8Z+ZTMWUVNgNEq2BRlwccjhVyXLCB5qbeGmW6fnWIQVCdNlzid
	 06QraqFqwlS6y3vmnpi4Ap+WlLV/fStE6rPaOVtdHzI8NrNZ42fTJC9XPUrPp6ir+c
	 GV4rj/JQSVNeSlk0ugfN6JCQ1XDjD1pSqTglUpse/EvLUm2T2jWrtq9YXKNEu9fuzn
	 t69uwVBV97Ya9HH95qLpXX8br7iG5co6wHQvXztAm3v6yEEo3yOuQ4k31/8fwPTdEs
	 MBLkSjMg134iZq1KJzMzfVW8NG/QHXg85sUGpSMLwN1pLXyxCrtZ7TX+M/Nl8s3kO0
	 7Uingur0uvApA==
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
Subject: [PATCH v2 04/14] mm/ksm: use folio in remove_stable_node
Date: Fri, 22 Mar 2024 16:36:51 +0800
Message-ID: <20240322083703.232364-5-alexs@kernel.org>
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

pages in stable tree are all single normal page, so uses ksm_get_folio()
and folio_set_stable_node(), also saves 3 calls to compound_head().

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
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


