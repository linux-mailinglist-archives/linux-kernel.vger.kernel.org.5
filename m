Return-Path: <linux-kernel+bounces-117041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BB88A662
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7C1F3C295
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DAE15EFBF;
	Mon, 25 Mar 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6AU0w0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FD15EFB3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370767; cv=none; b=KnN9ClpG3suHQela3qbH3vZZ6o55uYJIIvHGa577axp310k8ubgRnKD/PlNGotFXbeZOdK7d4/yhRrtDBA5y8whH+57A6LE8cgkD3UKX8kFZXxFSWubTtzs47JaB4qA0dEJjoIJEBtlEjgAbu05Aqwzw6g5MCpPoDf6bkzFi/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370767; c=relaxed/simple;
	bh=1FMqhrTGzv5mI88ql04GgunChyuiZ5EvE2fgo8IbQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVQej9VM4x1cD/m8Hjr1FnDIAztOpwXvScaZd7qGbcx1BF0hUeIwTpyNjHq6vKMXaedkwr9+iT5VehGzldvJv2o1UzS5AQTRYgp0KUIGIdjbAQgTytjFBF98MpH/Fmg28xJ8LHi+8mxNLLEn46aOh+pE8rkagtZ5MAA+zCjzcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6AU0w0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F09C433C7;
	Mon, 25 Mar 2024 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370767;
	bh=1FMqhrTGzv5mI88ql04GgunChyuiZ5EvE2fgo8IbQMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6AU0w0G/erVGHeJFCX8w/EJeqQFE15Jq05PpOfDQBhQz0mLQRG3ULcPNL3SLertO
	 hm4n2HJMGH+yHfEe8vGRHIR/elq9l+W/2TbpJZ2GhGaruVJ01wKwR0R7Cmca21hYkV
	 xFOaBsAKY2ZQPFpe4yhgc4Rzny2PfvvMx/gv6TAdu0j3fMV7kgXUoDoZaBVb4GU+2y
	 /aPGy4PlY/7p0uinoDfWfyGGQWsWOd+zgrV+h+f2TvnIx5fTUhmTu7a4xO7oracQtb
	 ZQnNvcIT7N/spzY9RL0DCzzdiFMFj8Q99B+mVOCimWgsSOHsYZEdx6ErXYixa63Cz6
	 YAE22wFF72Aog==
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
Subject: [PATCH v3 08/14] mm/ksm: Convert chain series funcs to use folio
Date: Mon, 25 Mar 2024 20:48:55 +0800
Message-ID: <20240325124904.398913-9-alexs@kernel.org>
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
index 5d1f62e7462a..7188997437d3 100644
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


