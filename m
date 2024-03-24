Return-Path: <linux-kernel+bounces-115116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FD889316
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FD2935EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFA13E6A9;
	Mon, 25 Mar 2024 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncXy0MI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDB181499;
	Sun, 24 Mar 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324111; cv=none; b=SU9voJ/bCtucBGUO1d1sItOkhz+50Ec14XMH/2AA7uSZ3JiDO7bTYiaTWXqjaUu23W/Lf+uwe5U+xEr6x1kOanx450IJEC22qAEjFSqSii2gBx6/xfbScpFNEX3J00E7HTwJEVvFJEpRVY5jPSIWpqtRqT6PWMzwUAZHXMjYAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324111; c=relaxed/simple;
	bh=Qmy2O76SxTVOnVSlPMGH7+wL9AlatR2WSG/HN+h72xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0oXFFp3Lc7GbNz0UhQ4yiyIIOXpSQymcqQ/VS4pG8QukCo6logTGlB/roAIQxjxeQJb4D6ahcpU/mJeIdOy1WyZ/K39F81+azLVJ8Tw+yK8WhwL0NjDHKkHFCS2zWExcj3ho7PDPyJE8RdUNa7dLVeQrc7AliuNZh1fTtAeo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncXy0MI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9CAC43390;
	Sun, 24 Mar 2024 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324110;
	bh=Qmy2O76SxTVOnVSlPMGH7+wL9AlatR2WSG/HN+h72xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncXy0MI4thfY7AL5SIlrIr2yEJG6pR6CVmKHjJS6zTnA3m0nsncdLds8YYbh+XrJ0
	 X63a2F1cq7Je9oP9GSelWSCKepiwb+6haXxBpPkqJ95KOyFwRbn4B3oAhJF0GxG1Fg
	 aDrd2g1X8FDSDDiSJZP+R3KQV0UzWsdexyJVvTtULYZ3QwkWMtLWVB1p8mesBgpeLy
	 yGEN0M1X9vEitwrB+eQ7W/txyN6sRQq2r8Sl+1ZAV6VnNiAv0GgL8gnOHlg5OtlYDu
	 Hr2D0THTijxbaf9rl5Oetx0ftn8J6tSQ1s5ot/u2jkTKwN0Km9SGVkQJyajQWKA5IJ
	 R5D2nyShLG8GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/183] quota: simplify drop_dquot_ref()
Date: Sun, 24 Mar 2024 19:45:22 -0400
Message-ID: <20240324234638.1355609-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 7bce48f0fec602b3b6c335963b26d9eefa417788 ]

As Honza said, remove_inode_dquot_ref() currently does not release the
last dquot reference but instead adds the dquot to tofree_head list. This
is because dqput() can sleep while dropping of the last dquot reference
(writing back the dquot and calling ->release_dquot()) and that must not
happen under dq_list_lock. Now that dqput() queues the final dquot cleanup
into a workqueue, remove_inode_dquot_ref() can call dqput() unconditionally
and we can significantly simplify it.

Here we open code the simplified code of remove_inode_dquot_ref() into
remove_dquot_ref() and remove the function put_dquot_list() which is no
longer used.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230630110822.3881712-6-libaokun1@huawei.com>
Stable-dep-of: 179b8c97ebf6 ("quota: Fix rcu annotations of inode dquot pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 70 +++++++-----------------------------------------
 1 file changed, 9 insertions(+), 61 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index d9da4a8c4317c..08ca5b1a5fba5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1075,59 +1075,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-/*
- * Remove references to dquots from inode and add dquot to list for freeing
- * if we have the last reference to dquot
- */
-static void remove_inode_dquot_ref(struct inode *inode, int type,
-				   struct list_head *tofree_head)
-{
-	struct dquot **dquots = i_dquot(inode);
-	struct dquot *dquot = dquots[type];
-
-	if (!dquot)
-		return;
-
-	dquots[type] = NULL;
-	if (list_empty(&dquot->dq_free)) {
-		/*
-		 * The inode still has reference to dquot so it can't be in the
-		 * free list
-		 */
-		spin_lock(&dq_list_lock);
-		list_add(&dquot->dq_free, tofree_head);
-		spin_unlock(&dq_list_lock);
-	} else {
-		/*
-		 * Dquot is already in a list to put so we won't drop the last
-		 * reference here.
-		 */
-		dqput(dquot);
-	}
-}
-
-/*
- * Free list of dquots
- * Dquots are removed from inodes and no new references can be got so we are
- * the only ones holding reference
- */
-static void put_dquot_list(struct list_head *tofree_head)
-{
-	struct list_head *act_head;
-	struct dquot *dquot;
-
-	act_head = tofree_head->next;
-	while (act_head != tofree_head) {
-		dquot = list_entry(act_head, struct dquot, dq_free);
-		act_head = act_head->next;
-		/* Remove dquot from the list so we won't have problems... */
-		list_del_init(&dquot->dq_free);
-		dqput(dquot);
-	}
-}
-
-static void remove_dquot_ref(struct super_block *sb, int type,
-		struct list_head *tofree_head)
+static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
 #ifdef CONFIG_QUOTA_DEBUG
@@ -1144,11 +1092,16 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
+			struct dquot **dquots = i_dquot(inode);
+			struct dquot *dquot = dquots[type];
+
 #ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
 #endif
-			remove_inode_dquot_ref(inode, type, tofree_head);
+			dquots[type] = NULL;
+			if (dquot)
+				dqput(dquot);
 		}
 		spin_unlock(&dq_data_lock);
 	}
@@ -1165,13 +1118,8 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 /* Gather all references from inodes and drop them */
 static void drop_dquot_ref(struct super_block *sb, int type)
 {
-	LIST_HEAD(tofree_head);
-
-	if (sb->dq_op) {
-		remove_dquot_ref(sb, type, &tofree_head);
-		synchronize_srcu(&dquot_srcu);
-		put_dquot_list(&tofree_head);
-	}
+	if (sb->dq_op)
+		remove_dquot_ref(sb, type);
 }
 
 static inline
-- 
2.43.0


