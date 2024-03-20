Return-Path: <linux-kernel+bounces-108552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321BF880C24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18B528329B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35322C695;
	Wed, 20 Mar 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L37WiUcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EF224D1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920267; cv=none; b=AdvsuNoXXK9Ggb3GuNUhaAEKScp70B65mTfqbbP/jbRJ8Bm79OrgRi/VzG7wSLWu8rr9NFzlrvHw9vBhVMSN0N+lDO2oIEzYK68OT6lPvrX6napLXHWVLy3M7/SacU6+rW6pTz+DeRjjqZFJZBqXe+nh5PB9Vk8y55AC6/MoZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920267; c=relaxed/simple;
	bh=QBm6pSuc3VKXpcso3yJosqmwb8/BJ2OoR9I3H0hBrRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNeby5+HYcRNTvXJmc2OVLrxjCWQzkFVNMuM6z+TJ/9VUgUXRwTzL6SfmjBGfc0/h8Op2kGOD+Q/PAjlpB0Vw5tPrKlgcf3FtB/R55D7LlZSEHeId5VO52v+51TIuBYLFc6CcuS5NCgR3qIPiDk1jqULe/2miQ0UFjTdeCrfNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L37WiUcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E33C433C7;
	Wed, 20 Mar 2024 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920266;
	bh=QBm6pSuc3VKXpcso3yJosqmwb8/BJ2OoR9I3H0hBrRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L37WiUcZJsGDbOCHOPrSNTjyO0gSDx/iv+H7FACJLgcKsiZeTGrjxxkD+tePXxwzO
	 WU/+a1n3c+tMsi/tk2O8Gzlwg/FAiUawPXh7x/4BAkeKr8YTmc9fE6ielqPWONuj93
	 Ww0aiZc8FfLVgEa2KjV3ORGARjUO3JItK016YlNbAU6e2v0Dc/fFd8+ab5keQ7xi8S
	 aS9uwYzTy+ZEcrELKJecDguNV5953wDpPrZ+/U6DcP4heEe6vamrHAOEzr8kP02UQt
	 uwZ1NaS2JnE/kpLYI1IEnYWxb+eaRQHQN5SL64g94xDcd63nVvXdoLNlqfqL8bJDhg
	 mrQj1OmnP2LNQ==
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
Subject: [PATCH 03/11] mm/ksm: use a folio in remove_stable_node
Date: Wed, 20 Mar 2024 15:40:39 +0800
Message-ID: <20240320074049.4130552-4-alexs@kernel.org>
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

pages in stable tree are all single normal page, use folios could save
3 calls to compound_head().

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 922e33500875..9ea9b5ac44b4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1107,11 +1107,11 @@ static inline void set_page_stable_node(struct page *page,
  */
 static int remove_stable_node(struct ksm_stable_node *stable_node)
 {
-	struct page *page;
+	struct folio *folio;
 	int err;
 
-	page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
-	if (!page) {
+	folio = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+	if (!folio) {
 		/*
 		 * get_ksm_page did remove_node_from_stable_tree itself.
 		 */
@@ -1124,22 +1124,22 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
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
+		 * This folio might be in an LRU cache waiting to be freed,
 		 * or it might be PageSwapCache (perhaps under writeback),
 		 * or it might have been removed from swapcache a moment ago.
 		 */
-		set_page_stable_node(page, NULL);
+		set_page_stable_node(&folio->page, NULL);
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


