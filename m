Return-Path: <linux-kernel+bounces-111141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14288684E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6161C21710
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D8D1CA8F;
	Fri, 22 Mar 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj4/oAXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD171BC3B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096506; cv=none; b=oGowsEH6U8IjvEFwmCOOQKNfHQyA3yc4HdrLCm1y1OzY+0FjUNrupngYdIHruvsc0STVf7qNHzY/+O3ENYFNkTITNDthqr/jtwAn7jU15/TFTm8UReyOaJZPDvpewhqa5VqLkFpQIzMen3qBiCQ9pJfPrlcykmsvJ0rnBpSn8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096506; c=relaxed/simple;
	bh=58CYkIGbUXi9LAju+yb3HIaI5P0/xOPsOLCuC4bYl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7CaGpKyMaq0RFpYTzaIIMPY6LZztw5F7hFVY+32qHGK+DXNlKVmwzBwoErlBpfKk2kFz12Q4kcHr/uXeLbtI8mNMJMGVb9FxyRw5PFYixxexKNVligSxenCE+vMLmLxZKqOONUd+UYq7GkHNMSUgwEJXndaXvv99xEnESlVvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj4/oAXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DA2C43390;
	Fri, 22 Mar 2024 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096506;
	bh=58CYkIGbUXi9LAju+yb3HIaI5P0/xOPsOLCuC4bYl0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj4/oAXXwJyK+lHuDuYpq+4X/X/wDs8aqMGx/io2Y3zhIpzKnZ2W8eoxDqdGLWBQh
	 HwOg4I/Ld12Y6pOsSFTvCvXolR8RtLGSxIn4SsrsivuZhZg2LXyp979uG+TYpMIO08
	 Zmam5au1soDjXTNv/A6/P1VgSggAI7xIzJ3UxNmqGdXRLrVNqpj0YYKIDl2Oq33eyw
	 FyEneaJRsoSxoubL3WMyaCjxt/SetSyb5la5KpXDdNHkbmk2W1A3g2ojs8q+F1+80Z
	 Z+Z9kFNFmk980SrvTfKIhObMlUuK4Z+77hkFoOHgVGZUOzOnsHGQ3f4zX536gcsn7n
	 sANRg6w7jqrIg==
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
Subject: [PATCH v2 12/14] mm/ksm: return folio for chain series funcs
Date: Fri, 22 Mar 2024 16:36:59 +0800
Message-ID: <20240322083703.232364-13-alexs@kernel.org>
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

Since all caller changed to folios, change their return type to folio
too.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index afcf26510669..15a78a9bab59 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1623,10 +1623,10 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
 	return __is_page_sharing_candidate(stable_node, 0);
 }
 
-static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
-			     struct ksm_stable_node **_stable_node,
-			     struct rb_root *root,
-			     bool prune_stale_stable_nodes)
+static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
+				     struct ksm_stable_node **_stable_node,
+				     struct rb_root *root,
+				     bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
@@ -1769,10 +1769,10 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
  * function and will be overwritten in all cases, the caller doesn't
  * need to initialize it.
  */
-static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
-					struct ksm_stable_node **_stable_node,
-					struct rb_root *root,
-					bool prune_stale_stable_nodes)
+static struct folio *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
+					 struct ksm_stable_node **_stable_node,
+					 struct rb_root *root,
+					 bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *stable_node = *_stable_node;
 	if (!is_stable_node_chain(stable_node)) {
@@ -1791,16 +1791,16 @@ static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
 			       prune_stale_stable_nodes);
 }
 
-static __always_inline void *chain_prune(struct ksm_stable_node **s_n_d,
-						struct ksm_stable_node **s_n,
-						struct rb_root *root)
+static __always_inline struct folio *chain_prune(struct ksm_stable_node **s_n_d,
+						 struct ksm_stable_node **s_n,
+						 struct rb_root *root)
 {
 	return __stable_node_chain(s_n_d, s_n, root, true);
 }
 
-static __always_inline void *chain(struct ksm_stable_node **s_n_d,
-					  struct ksm_stable_node *s_n,
-					  struct rb_root *root)
+static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
+					   struct ksm_stable_node *s_n,
+					   struct rb_root *root)
 {
 	struct ksm_stable_node *old_stable_node = s_n;
 	struct folio *tree_folio;
-- 
2.43.0


