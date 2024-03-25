Return-Path: <linux-kernel+bounces-117046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06988A667
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B631F3D649
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93667139CF2;
	Mon, 25 Mar 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rff8wy/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5D15F411
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370779; cv=none; b=XlPcehJNeiOgXPfSpTsoWiVNS1KFx9Uy6YIyuSV7YBURGG75nog5FNnsysOPOsJ1lTDuFEUV3VMd4E5+UwCo8VqzXtvLyXa+FOIFqbEJGVb9CRhaxYF/07iwemJsFgw+h1FBTZHDjxbf92+dRvuD6VzBc3i9Jj6Fs3XPiEE0MG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370779; c=relaxed/simple;
	bh=arZB3IpTCMJ2LTtZkVucxq3hez+AmaxlVxPKhMFKVEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3QV3oP6++iGHAatS3ltGTJOAgpI6Kocc9v7RfAIEBTAFdVsK5c08FOvr9SY7siP1lL3I2dHIJAOOZtj9VnVaTeFPOAFZbrah+DH/87jiBi+kEsoxcU11++TshJdlwNV88SrHq6tqwIIn8yNU1MTp2+/lLB9arZP6bTIaf2HneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rff8wy/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D82C433A6;
	Mon, 25 Mar 2024 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370779;
	bh=arZB3IpTCMJ2LTtZkVucxq3hez+AmaxlVxPKhMFKVEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rff8wy/gttXaTtUeASAh+hMee0l3Szue+pd80LQ7k9jBYU7wpVMjckiX7PPi/CCDY
	 JmtuOZ96Z9NiUesHdgS7I/17APw8F8a6shAI8Hx0MOMOvcotCH045NHl0562JFdUyM
	 uR63wRqfAstz1MfVQh4UgDxGwrvMYSPNgwH8m5jXkWM2VQXmwhd81SQ4FTsCp/J4Zi
	 ASIM7LKrdIOomYptlMN/ZXGzrO2+KbvRDrzVxpWKq6zTzqlN44ppN7BDBeNUcjUeaf
	 +s7Q5kySAFuGKdy+Puod7mj35GfQEifImvDyWAVmGQxwyF0PB0kNQk7JtWv3EfKXTS
	 QBdN/da9IUlNA==
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
Subject: [PATCH v3 12/14] mm/ksm: return folio for chain series funcs
Date: Mon, 25 Mar 2024 20:48:59 +0800
Message-ID: <20240325124904.398913-13-alexs@kernel.org>
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

Since all caller changed to folios, change their return type to folio
too.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0ad02524e363..15a78a9bab59 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1623,10 +1623,10 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
 	return __is_page_sharing_candidate(stable_node, 0);
 }
 
-static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
-				    struct ksm_stable_node **_stable_node,
-				    struct rb_root *root,
-				    bool prune_stale_stable_nodes)
+static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
+				     struct ksm_stable_node **_stable_node,
+				     struct rb_root *root,
+				     bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
@@ -1739,7 +1739,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	}
 
 	*_stable_node_dup = found;
-	return &tree_folio->page;
+	return tree_folio;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
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


