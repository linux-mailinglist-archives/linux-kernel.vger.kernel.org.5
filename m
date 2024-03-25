Return-Path: <linux-kernel+bounces-117037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC188A65C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DADD2E74BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD16EB60;
	Mon, 25 Mar 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCXCMsav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADA15D5D4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370756; cv=none; b=sq2UuyhJeuspmrljSCg+NZhMvWV9iti43R98eCly95Oxf3ppREvPfQ/PijfTyWYR7aKGXadYu/TFMBlNSECEj+QNZx3qGvWIDn5imNXWNGY1nLusFUMiWSBiZ1JZ9IzOvhU/q3D+E13whSmbGkQUT1SVEkBn6gCMMBz/hFTrMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370756; c=relaxed/simple;
	bh=k8zytA2A5T1rgDUiIACZ6hBdX8Fv5Jcn+9QWsQNKn6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/1tBH1XEH+sNrer0LkXOYmaT7utNCotodOXZ6I9JS7dqTfvNKytZ+0QZD6pxd+W8I1PZwpBswjHv1/STLo369EjiH1CzAAoIzkXrvCr52floQomqvh6eb20fnIMQMwdz6RNlOayZLghdRBKMXiuTzhEy6cd07u4VZDGxW21+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCXCMsav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9649C433A6;
	Mon, 25 Mar 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370756;
	bh=k8zytA2A5T1rgDUiIACZ6hBdX8Fv5Jcn+9QWsQNKn6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCXCMsavhNOpAhZ7kJ53WdZwQKpuR2F7J0ZTZC1rzgutAlE5WiOGa7PrxTMOnMARa
	 JfPhPX9LQJiY8vbNiLiDBSY6pLZYbUANi5Je+jK5qa/nFXX8ERQS33vHjuNT83yyfT
	 2KMDNRZMHC5XZLJy4fUp8FjLNBwJsWRLvM+MebUe2K1BC+RHZCpaZiKwO6xFuGXiqW
	 JZeggEJVwxFI1pFShlUUjpQTX4BZNY7UDVuzH6arWZhTGgCsUftr2vbwZUvooZ2RvS
	 unmUy6JT9yoDSORyeY3EJoi02k2S0QsMfzHfpptaoaMcaebfat8W39e3t33np53eYi
	 qMyO3pObODdMw==
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
Subject: [PATCH v3 04/14] mm/ksm: use folio in remove_stable_node
Date: Mon, 25 Mar 2024 20:48:51 +0800
Message-ID: <20240325124904.398913-5-alexs@kernel.org>
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


