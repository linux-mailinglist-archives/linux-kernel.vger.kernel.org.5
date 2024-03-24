Return-Path: <linux-kernel+bounces-115119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D5888D34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B461F29E95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27A2FD877;
	Mon, 25 Mar 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5On6cya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C42181B91;
	Sun, 24 Mar 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324114; cv=none; b=UECGHeTre0JIbAVChfr87x1Yv9waqHmCgdLyLzs3xS0J1xZZfe4+PSWLOnfMKOGCyZBvB7ClHzYYEKX+Hpge/C13/cw5WRLZOVcfBTejcIEIhF0xlbbAgzUCBV4dwy/Z8F5DrNxzCH7KspWJPiFHp8SjCm8qc20ftEeskzzYIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324114; c=relaxed/simple;
	bh=x1NtUxseTfEcrQF83Qqi+L2VnzDZc8ZkZ64G2ZdZTfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnWmQAJPmdVjNQWWFnr2PuwLiSSoQQnA9HqGFEn0PSxZqpzWYG+BDbYildPNtKyyHn39HS6ZP97hBWKlEHRYDoxqk18bI6QGeXbbejG5UYQmOA4io3ZQm9x4llCvB6qWcV8zGuWb2UBLt+7ldRdx7IJlZvUqL+SK6yIohi0kPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5On6cya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302CFC43141;
	Sun, 24 Mar 2024 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324112;
	bh=x1NtUxseTfEcrQF83Qqi+L2VnzDZc8ZkZ64G2ZdZTfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5On6cyaIp+2wLOOjncBK3QT6ZrzCgQOR2xpbQIOeZeeyQkLFys1YUoLJFQGA5x0Y
	 IO8SsMBVfqpaVPA6OCqFNWflZ2ryLRLTGT+EhVNgvoPZAFnm/ucryL+XQ3QfE0fxAP
	 TMrh4aC8DEnAAcDWeP6DX44XGWppg6QGTzws0rSJ4lEudjmwGmoiszJpRKoyPCq2Js
	 uxQKVGW7PhMnAaqmOIWx9ozCHv/LkOoJlqLQCAkGJhew9LTgAxpjtFkykRMV0WR6Da
	 hHaK/zTkhbXWZ8OC8Zu67+W7EaW2RHuuau6+SQzTK0qk/c7dsaEB0uHVxp1eqLPPQE
	 bmRiS4c+FUfNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 111/183] quota: Fix rcu annotations of inode dquot pointers
Date: Sun, 24 Mar 2024 19:45:24 -0400
Message-ID: <20240324234638.1355609-112-sashal@kernel.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit 179b8c97ebf63429589f5afeba59a181fe70603e ]

Dquot pointers in i_dquot array in the inode are protected by
dquot_srcu. Annotate the array pointers with __rcu, perform the locked
dereferences with srcu_dereference_check() instead of plain reads, and
set the array elements with rcu_assign_pointer().

Fixes: b9ba6f94b238 ("quota: remove dqptr_sem")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402061900.rTuYDlo6-lkp@intel.com/
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index c4726a1895582..a7ddb874912d4 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -399,7 +399,7 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 
 /* Dirtify all the dquots - this can block when journalling */
-static inline int mark_all_dquot_dirty(struct dquot * const *dquots)
+static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
 {
 	int ret, err, cnt;
 	struct dquot *dquot;
@@ -997,14 +997,15 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 }
 EXPORT_SYMBOL(dqget);
 
-static inline struct dquot **i_dquot(struct inode *inode)
+static inline struct dquot __rcu **i_dquot(struct inode *inode)
 {
-	return inode->i_sb->s_op->get_dquots(inode);
+	/* Force __rcu for now until filesystems are fixed */
+	return (struct dquot __rcu **)inode->i_sb->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1094,14 +1095,16 @@ static void remove_dquot_ref(struct super_block *sb, int type)
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
-			struct dquot **dquots = i_dquot(inode);
-			struct dquot *dquot = dquots[type];
+			struct dquot __rcu **dquots = i_dquot(inode);
+			struct dquot *dquot = srcu_dereference_check(
+				dquots[type], &dquot_srcu,
+				lockdep_is_held(&dq_data_lock));
 
 #ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
 #endif
-			dquots[type] = NULL;
+			rcu_assign_pointer(dquots[type], NULL);
 			if (dquot)
 				dqput(dquot);
 		}
@@ -1454,7 +1457,8 @@ static int inode_quota_active(const struct inode *inode)
 static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
-	struct dquot **dquots, *got[MAXQUOTAS] = {};
+	struct dquot __rcu **dquots;
+	struct dquot *got[MAXQUOTAS] = {};
 	struct super_block *sb = inode->i_sb;
 	qsize_t rsv;
 	int ret = 0;
@@ -1529,7 +1533,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!got[cnt])
 			continue;
 		if (!dquots[cnt]) {
-			dquots[cnt] = got[cnt];
+			rcu_assign_pointer(dquots[cnt], got[cnt]);
 			got[cnt] = NULL;
 			/*
 			 * Make quota reservation system happy if someone
@@ -1537,12 +1541,16 @@ static int __dquot_initialize(struct inode *inode, int type)
 			 */
 			rsv = inode_get_rsv_space(inode);
 			if (unlikely(rsv)) {
+				struct dquot *dquot = srcu_dereference_check(
+					dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+
 				spin_lock(&inode->i_lock);
 				/* Get reservation again under proper lock */
 				rsv = __inode_get_rsv_space(inode);
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquots[cnt]->dq_dqb.dqb_rsvspace += rsv;
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot->dq_dqb.dqb_rsvspace += rsv;
+				spin_unlock(&dquot->dq_dqb_lock);
 				spin_unlock(&inode->i_lock);
 			}
 		}
@@ -1564,7 +1572,7 @@ EXPORT_SYMBOL(dquot_initialize);
 
 bool dquot_initialize_needed(struct inode *inode)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	int i;
 
 	if (!inode_quota_active(inode))
@@ -1589,13 +1597,14 @@ EXPORT_SYMBOL(dquot_initialize_needed);
 static void __dquot_drop(struct inode *inode)
 {
 	int cnt;
-	struct dquot **dquots = i_dquot(inode);
+	struct dquot __rcu **dquots = i_dquot(inode);
 	struct dquot *put[MAXQUOTAS];
 
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		put[cnt] = dquots[cnt];
-		dquots[cnt] = NULL;
+		put[cnt] = srcu_dereference_check(dquots[cnt], &dquot_srcu,
+					lockdep_is_held(&dq_data_lock));
+		rcu_assign_pointer(dquots[cnt], NULL);
 	}
 	spin_unlock(&dq_data_lock);
 	dqput_all(put);
@@ -1603,7 +1612,7 @@ static void __dquot_drop(struct inode *inode)
 
 void dquot_drop(struct inode *inode)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1676,7 +1685,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
@@ -1746,7 +1755,7 @@ int dquot_alloc_inode(struct inode *inode)
 {
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
@@ -1791,7 +1800,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
  */
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1833,7 +1842,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
  */
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1877,7 +1886,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
@@ -1934,7 +1943,7 @@ void dquot_free_inode(struct inode *inode)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 	int index;
 
@@ -1981,6 +1990,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t cur_space;
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
+	struct dquot __rcu **dquots;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
 	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
@@ -2013,6 +2023,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	}
 	cur_space = __inode_get_bytes(inode);
 	rsv_space = __inode_get_rsv_space(inode);
+	dquots = i_dquot(inode);
 	/*
 	 * Build the transfer_from list, check limits, and update usage in
 	 * the target structures.
@@ -2027,7 +2038,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!sb_has_quota_active(inode->i_sb, cnt))
 			continue;
 		is_valid[cnt] = 1;
-		transfer_from[cnt] = i_dquot(inode)[cnt];
+		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
+				&dquot_srcu, lockdep_is_held(&dq_data_lock));
 		ret = dquot_add_inodes(transfer_to[cnt], inode_usage,
 				       &warn_to[cnt]);
 		if (ret)
@@ -2066,7 +2078,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 						  rsv_space);
 			spin_unlock(&transfer_from[cnt]->dq_dqb_lock);
 		}
-		i_dquot(inode)[cnt] = transfer_to[cnt];
+		rcu_assign_pointer(dquots[cnt], transfer_to[cnt]);
 	}
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
@@ -2077,8 +2089,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	 * mark_all_dquot_dirty().
 	 */
 	index = srcu_read_lock(&dquot_srcu);
-	mark_all_dquot_dirty(transfer_from);
-	mark_all_dquot_dirty(transfer_to);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
+	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
 	srcu_read_unlock(&dquot_srcu, index);
 
 	flush_warnings(warn_to);
-- 
2.43.0


