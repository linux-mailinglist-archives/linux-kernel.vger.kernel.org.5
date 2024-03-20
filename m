Return-Path: <linux-kernel+bounces-108560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94083880C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45FF1C227EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28C3FB3E;
	Wed, 20 Mar 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJwpJSdF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B53F9F8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920291; cv=none; b=leuMkqiQ626VIvLrh7LnB2Wy+pdNx4oLAkLuqodGIQwUU/K0E3n05gkz8ANVbU1xKkiW93+RyaFeg91PSU5uLFtjZvq85e8HXHDRTvJXN/m0ylE13TDGbG2mqof60DnrldDy6VYkuWQ9IAVzlHU5kXSm4iNCXmwDCM3bIzQvZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920291; c=relaxed/simple;
	bh=2eCzaBD/FPlVUCW+3c3mpz0T6iG1rGJcXt6EJeYetoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1PbvLfQ+9ZZP+F75HJFkcErbYnjeVynlmAzasJr3KAPG4LawavGrMADQsk/NAXPGnqWJiHXEuEkUEfj1DDW7vnvCHGDOsc5SFeE2KFP+vzRvXqxj1IaDAhSW7yDPw/3QKfm2P/omkLgPUI1eF1MpEstqkErTl4fgbNRIoWgx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJwpJSdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DADC43399;
	Wed, 20 Mar 2024 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920291;
	bh=2eCzaBD/FPlVUCW+3c3mpz0T6iG1rGJcXt6EJeYetoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJwpJSdF8PMQwKdjVsH6aJlrbH9++/7WiZkEWLeurmSr+JfpMJKrW+x4hDWfZCJfn
	 dnRIC5q3bejKL1Rdjecw3lZ9mQfSrOecTOhXOsUmFmCHmT3nzZdOxZglTE6xGXFO7c
	 jXeNkxlgkQZ5SMTxR8JJmBr2KNActnCXSpXBACqkNiERLUIZslmxWTpMsWwLpIjOeQ
	 NXmB9l0gy1Jr+wUf/lw+AMatfNFMp0xfp0CdxVBc+c1jcuJS66HpsTnovaxLpVG+/k
	 CXUcwj2LgYj6pkUzNz7WZ7VHtMwZEUn3E7O+PeCIqK7vRhs2kjEoEK5Mn7mwWr/nLx
	 nLX9yNep5BLJA==
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
Subject: [PATCH 11/11] mm/ksm: return folio for chain series funcs
Date: Wed, 20 Mar 2024 15:40:47 +0800
Message-ID: <20240320074049.4130552-12-alexs@kernel.org>
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
index 806ad4d2693b..74cf6c028380 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1615,10 +1615,10 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
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
@@ -1761,10 +1761,10 @@ static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stabl
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
@@ -1783,16 +1783,16 @@ static void *__stable_node_chain(struct ksm_stable_node **_stable_node_dup,
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


