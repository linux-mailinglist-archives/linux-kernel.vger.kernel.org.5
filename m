Return-Path: <linux-kernel+bounces-111137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461688684A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133ED1F22A59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FA20326;
	Fri, 22 Mar 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSqvlKnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35E1B7EF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096495; cv=none; b=goo4azYaamFpw3io2TdZ08kFKRaNVkZ/EAcxZUrRTJBdH9nmA781K9FsjH8aaJpxqd1Zt9ownRYSaWWYiJ5271eq4edAF772omJLR5rMY1SftrOg6WG1YTnxoMsf3t2pCuMTAbQVaKgA6W3vz/Ek/jCWaZiowStOp48YmSNnNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096495; c=relaxed/simple;
	bh=Czj2cXDjtWaQ7qWM/ntpEjf7pxB7Zlc771aFb0A0Wn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7anrIuR4+nuwhWwq/bhqDwcBEV72LxdE8jOZKLt7hNL+dA9pE2s/lrpEyeyEAvgwZhJGME6dqVctAadgc5Z/Gfcep+k3mhAsGCYr0z19Q0B3i+W7IdBIJQ332OBz6BNX/IX8+A4zXdJ38jZ4mDA1ZMHzwzqJVwaMvBEU2DPuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSqvlKnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45184C43399;
	Fri, 22 Mar 2024 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096494;
	bh=Czj2cXDjtWaQ7qWM/ntpEjf7pxB7Zlc771aFb0A0Wn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSqvlKnQKbuzNlo/1UqKPoPip2scXPO84E9+9X8dNblrtlYt2FWgou2idLr2Cf624
	 8JDv38d4rMAdgz4MTUUko9xkN20vVseInMkafo4ridyT8QrSEK6mUIMSW1s2bGoCWb
	 2oA1/SD9crmzZec6ZPZSk2pUNViw39caL5q+bQOFPvg7lP7aJp0rZC7ZSkDGyd6tr1
	 fZxBXpnGQ83pK0lK/Su/GbJrSrPEaS2sLnmOcnErBD6joRlbQsbF4sqsMRfph6EfUs
	 EJCIbyKNVbuK1tMDzHm/u1kuRYEqAnEIsJ/orGgHG7dy/Yqe89xaP0SuprV37NcFFC
	 2Stk7Cot+7HvA==
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
Subject: [PATCH v2 08/14] mm/ksm: Convert chain series funcs to use folio
Date: Fri, 22 Mar 2024 16:36:55 +0800
Message-ID: <20240322083703.232364-9-alexs@kernel.org>
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

In ksm stable tree all page are single, let's convert them to use folios.
Change return type to void is ugly, but for a series funcs, it's still a
bit simpler than adding new funcs. And they will be changed to 'struct
folio' soon.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f41491cf13c6..30570e1f68ec 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1777,7 +1777,7 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
  * function and will be overwritten in all cases, the caller doesn't
  * need to initialize it.
  */
-static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
+static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
 					struct ksm_stable_node **_stable_node,
 					struct rb_root *root,
 					bool prune_stale_stable_nodes)
@@ -1799,24 +1799,24 @@ static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_du
 			       prune_stale_stable_nodes);
 }
 
-static __always_inline struct page *chain_prune(struct ksm_stable_node **s_n_d,
+static __always_inline void *chain_prune(struct ksm_stable_node **s_n_d,
 						struct ksm_stable_node **s_n,
 						struct rb_root *root)
 {
 	return __stable_node_chain(s_n_d, s_n, root, true);
 }
 
-static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
+static __always_inline void *chain(struct ksm_stable_node **s_n_d,
 					  struct ksm_stable_node *s_n,
 					  struct rb_root *root)
 {
 	struct ksm_stable_node *old_stable_node = s_n;
-	struct page *tree_page;
+	struct folio *tree_folio;
 
-	tree_page = __stable_node_chain(s_n_d, &s_n, root, false);
+	tree_folio = __stable_node_chain(s_n_d, &s_n, root, false);
 	/* not pruning dups so s_n cannot have changed */
 	VM_BUG_ON(s_n != old_stable_node);
-	return tree_page;
+	return tree_folio;
 }
 
 /*
-- 
2.43.0


