Return-Path: <linux-kernel+bounces-114496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FEA888AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C360E1F25C54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA4180B6C;
	Sun, 24 Mar 2024 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyfG2yZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA8157A52;
	Sun, 24 Mar 2024 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321945; cv=none; b=qc9uesnvgvPR0tlMt1tiC+xRHKqQm/cDayPDsldzEaUH/ysaU8cL/XmdVWavc/drv6z4o+/8qsEgSSVVYqr3WgGOIDRg9d3+5wHa34PTdy8r+V0g8fjFzyAo7KPIoQ8AchvjY2N4a1OHos1hJOg3MZRzwGtxs1cLCoLfQZ3uM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321945; c=relaxed/simple;
	bh=dhG+I//QLSVrc05cbQfZl/VhpbNR7ZcT9TStqH/um/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyzYi4aTbqS+xxYKQ3yWkmElc2ylGR9N+jUcXCCyI2YKo+gjz80MeDimI4nqg1VTeqlkUyT3h12xRoOqer880xdmoT4St0kKqfSEDPvIBH05dm5xYZ1ck33K/WEE4XWOfuDv0uVqrgufaRdxsBEfl3s0FPB0ueyDhsmwsnwPyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyfG2yZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2714FC43399;
	Sun, 24 Mar 2024 23:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321943;
	bh=dhG+I//QLSVrc05cbQfZl/VhpbNR7ZcT9TStqH/um/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyfG2yZkTrLjVeT6YbNW51fDaxkMQBs1p2ydkaaC8qz5lsZGRIVKqfH/vItfwRZPL
	 kNMv0GyTHaJ0KXWnhuYdq7TpWlUmpHJdGpjLqbnrdxBv/TN0M4d8wyoTxF8oR2OHCw
	 ZtQzOrgKS1FH+/Kc8mtBPcAzRg/wCXrGcEtNckPTjzesfRjQ3EsI6l6dsYAohWqD5N
	 42Dgv+uuTMpQ/LBqy6VSmcU9QS75BvlrnYmhzvZRK7AGY7hSbx8JXZuIgMEWs+kY9H
	 3q93SeWw9MrxVI9ip7WFNpVJ9LVfvf9f/lwHaS2xR93XVHaQ7JHDIz300XMuyH1e/m
	 9kAbkSV6XZOkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/451] nfsd: simplify the delayed disposal list code
Date: Sun, 24 Mar 2024 19:04:51 -0400
Message-ID: <20240324231207.1351418-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 92e4a6733f922f0fef1d0995f7b2d0eaff86c7ea ]

When queueing a dispose list to the appropriate "freeme" lists, it
pointlessly queues the objects one at a time to an intermediate list.

Remove a few helpers and just open code a list_move to make it more
clear and efficient. Better document the resulting functions with
kerneldoc comments.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 64 ++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2f0b2d964cbb1..f40d8f3b35a4c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -402,49 +402,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	}
 }
 
-static void
-nfsd_file_list_remove_disposal(struct list_head *dst,
-		struct nfsd_fcache_disposal *l)
-{
-	spin_lock(&l->lock);
-	list_splice_init(&l->freeme, dst);
-	spin_unlock(&l->lock);
-}
-
-static void
-nfsd_file_list_add_disposal(struct list_head *files, struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	spin_lock(&l->lock);
-	list_splice_tail_init(files, &l->freeme);
-	spin_unlock(&l->lock);
-	queue_work(nfsd_filecache_wq, &l->work);
-}
-
-static void
-nfsd_file_list_add_pernet(struct list_head *dst, struct list_head *src,
-		struct net *net)
-{
-	struct nfsd_file *nf, *tmp;
-
-	list_for_each_entry_safe(nf, tmp, src, nf_lru) {
-		if (nf->nf_net == net)
-			list_move_tail(&nf->nf_lru, dst);
-	}
-}
-
+/**
+ * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
+ * @dispose: list of nfsd_files to be disposed
+ *
+ * Transfers each file to the "freeme" list for its nfsd_net, to eventually
+ * be disposed of by the per-net garbage collector.
+ */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	LIST_HEAD(list);
-	struct nfsd_file *nf;
-
 	while(!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
-		nfsd_file_list_add_disposal(&list, nf->nf_net);
+		struct nfsd_file *nf = list_first_entry(dispose,
+						struct nfsd_file, nf_lru);
+		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
+
+		spin_lock(&l->lock);
+		list_move_tail(&nf->nf_lru, &l->freeme);
+		spin_unlock(&l->lock);
+		queue_work(nfsd_filecache_wq, &l->work);
 	}
 }
 
@@ -665,8 +642,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
  * nfsd_file_delayed_close - close unused nfsd_files
  * @work: dummy
  *
- * Walk the LRU list and destroy any entries that have not been used since
- * the last scan.
+ * Scrape the freeme list for this nfsd_net, and then dispose of them
+ * all.
  */
 static void
 nfsd_file_delayed_close(struct work_struct *work)
@@ -675,7 +652,10 @@ nfsd_file_delayed_close(struct work_struct *work)
 	struct nfsd_fcache_disposal *l = container_of(work,
 			struct nfsd_fcache_disposal, work);
 
-	nfsd_file_list_remove_disposal(&head, l);
+	spin_lock(&l->lock);
+	list_splice_init(&l->freeme, &head);
+	spin_unlock(&l->lock);
+
 	nfsd_file_dispose_list(&head);
 }
 
-- 
2.43.0


