Return-Path: <linux-kernel+bounces-108556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA0880C28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA21C227DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23143BBCF;
	Wed, 20 Mar 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhCa2Ax5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE893BB2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920279; cv=none; b=qH036doOWnetpeGeesjZUUUm9eLcF/iSapvaBsigszCXiuEH6Yw8ic+1+o1gNAOXpUt76MDFoUnAuXJ6tVyrngd3dFBEr+dwdS4Y36SMvq5WaNewH4Cr8MoT8o/mxofkmPc6ShqzUcoDSXGXT7EbKzTE5JAqEOdCArRDKIaSLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920279; c=relaxed/simple;
	bh=1ed6BHhGoxgGo7EGuh+4C4k7rhnha86RpFOxOMhqKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmxPaHkIgcuHANNqAG3pBmc8vjKlVxCZKMeGfnk99IAAaD4AWOYe9rQmeu8/db1EMH+tEVkDnIFNWDLt/cmWgVhYRbjed01T/fPFBUAc+OdXxZlZEFZP3ui06AlceOha9Lz/IGPp6qQyHyv2dcqOe5Ir1k8OR9js10AaulidPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhCa2Ax5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD8FC433A6;
	Wed, 20 Mar 2024 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920279;
	bh=1ed6BHhGoxgGo7EGuh+4C4k7rhnha86RpFOxOMhqKzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhCa2Ax5ueUSpXQj0Ttzhxb1k/1JVJoGcXSZZKbOYPU0aS/96v+eP5ke/tSy7N662
	 6DPmG+505PRZFGCUnmZSCvPx3WlBVs1RRA0XcpitnGkrM4XpfG2+lYZchImhrASWGO
	 EcWQvcNxlf6/hHiuh7IQY1B9Ic3LnWLnJ1jLpMPMW2/8EzOLrr2wPG/KRvzYgT9yHn
	 CpugyVk7CXv2ky9jyU8gzOp79le3M7KmVcTXdeeeBhTuDBXOVcTN2YtpAL+FUBdK0T
	 PdRNe9PQZwHr24y72ln6sr4/2fihO/p3mT3hoZdMOUfNrybuYUqoerKx9wGy2IoKy0
	 Y13qi1nGB8Gbw==
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
Subject: [PATCH 07/11] mm/ksm: Convert chain series funcs to use folio
Date: Wed, 20 Mar 2024 15:40:43 +0800
Message-ID: <20240320074049.4130552-8-alexs@kernel.org>
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

In ksm stable tree all page are single, let's convert them to use folios.

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
index ad3a0294a2ec..648fa695424b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1761,7 +1761,7 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
  * function and will be overwritten in all cases, the caller doesn't
  * need to initialize it.
  */
-static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
+static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
 					struct ksm_stable_node **_stable_node,
 					struct rb_root *root,
 					bool prune_stale_stable_nodes)
@@ -1783,24 +1783,24 @@ static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_du
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


