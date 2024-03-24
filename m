Return-Path: <linux-kernel+bounces-116069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E9889588
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06833298945
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EBD2853EC;
	Mon, 25 Mar 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O24tW1f6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775413C680;
	Sun, 24 Mar 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323487; cv=none; b=E6cOJVbKNqH0s31+Gt2xwrdhEn7cgIP4UbqlYRBUC/RWSKiGbKwexja96ygzVqDw0evoHC3LyuELJEALkasSa8+HFD//ZPsVHf3Iap4WawXF4bo5fGTDKB+s1hLQJYeZLrT/ASyzrKpd/xzId7w21o+K2RSelL2gNy5x2likuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323487; c=relaxed/simple;
	bh=GLuf8cIyLE8OMYgKZlV1Z0o42kAN7UFshQuxKE7KeYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpbAIVNKugNN9tGmV6uDbO/osBRvSz+ic+WyCp85bsrDnI8eyrg4HZDvJrxKapCweIo4rlXg0LrMnFzhijDV4HvOapVFGsNfChVJEmOcwOVrB5Ki+ptZlq+i7dqSD72HKcd3b9GJ+EuKnELYM5rnUROe9X+Pr7VKdipOiBGqigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O24tW1f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CFBC43394;
	Sun, 24 Mar 2024 23:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323487;
	bh=GLuf8cIyLE8OMYgKZlV1Z0o42kAN7UFshQuxKE7KeYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O24tW1f6Hqtayho/TY76Et3LJ9HRgumtVDuY5dajpgYhpOFpa26olSdVx3X7d1ASF
	 LtSYwan58YizDaxSOj3h4yt4+nW55ER1KnSN8mnGDutL9S0vZijcfPnRJtkv9BkJyu
	 mqorm6a600ZqMvbrwgBEAAqxKBDXDiS7O5gZi9rWaAp0iuvg63aN54zXGJTl6DjZy1
	 rXyWcx4uIbD+XLJqpxCWZbBNLAOfjj5wCPh6VEN7kZSAwV3Ne7f/fr7KaRGHl1Ge8O
	 SXH+s9Ta1RwJTDU/ykgmTIcqnatEqeU4ZM1x6q2P6HweWz0xs8rHI2USa0Pz2Srt/0
	 BEVx9rVSd7SDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 192/317] quota: Fix rcu annotations of inode dquot pointers
Date: Sun, 24 Mar 2024 19:32:52 -0400
Message-ID: <20240324233458.1352854-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 041459526abcf..edb414d3fd164 100644
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
@@ -1006,14 +1006,15 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
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
@@ -1103,14 +1104,16 @@ static void remove_dquot_ref(struct super_block *sb, int type)
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
@@ -1463,7 +1466,8 @@ static int inode_quota_active(const struct inode *inode)
 static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
-	struct dquot **dquots, *got[MAXQUOTAS] = {};
+	struct dquot __rcu **dquots;
+	struct dquot *got[MAXQUOTAS] = {};
 	struct super_block *sb = inode->i_sb;
 	qsize_t rsv;
 	int ret = 0;
@@ -1538,7 +1542,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		if (!got[cnt])
 			continue;
 		if (!dquots[cnt]) {
-			dquots[cnt] = got[cnt];
+			rcu_assign_pointer(dquots[cnt], got[cnt]);
 			got[cnt] = NULL;
 			/*
 			 * Make quota reservation system happy if someone
@@ -1546,12 +1550,16 @@ static int __dquot_initialize(struct inode *inode, int type)
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
@@ -1573,7 +1581,7 @@ EXPORT_SYMBOL(dquot_initialize);
 
 bool dquot_initialize_needed(struct inode *inode)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	int i;
 
 	if (!inode_quota_active(inode))
@@ -1598,13 +1606,14 @@ EXPORT_SYMBOL(dquot_initialize_needed);
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
@@ -1612,7 +1621,7 @@ static void __dquot_drop(struct inode *inode)
 
 void dquot_drop(struct inode *inode)
 {
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	int cnt;
 
 	if (IS_NOQUOTA(inode))
@@ -1685,7 +1694,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
@@ -1755,7 +1764,7 @@ int dquot_alloc_inode(struct inode *inode)
 {
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
@@ -1800,7 +1809,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
  */
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1842,7 +1851,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
  */
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int cnt, index;
 
@@ -1886,7 +1895,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot **dquots;
+	struct dquot __rcu **dquots;
 	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
@@ -1943,7 +1952,7 @@ void dquot_free_inode(struct inode *inode)
 {
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
-	struct dquot * const *dquots;
+	struct dquot __rcu * const *dquots;
 	struct dquot *dquot;
 	int index;
 
@@ -1990,6 +1999,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t cur_space;
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
+	struct dquot __rcu **dquots;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
 	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
@@ -2022,6 +2032,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	}
 	cur_space = __inode_get_bytes(inode);
 	rsv_space = __inode_get_rsv_space(inode);
+	dquots = i_dquot(inode);
 	/*
 	 * Build the transfer_from list, check limits, and update usage in
 	 * the target structures.
@@ -2036,7 +2047,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!sb_has_quota_active(inode->i_sb, cnt))
 			continue;
 		is_valid[cnt] = 1;
-		transfer_from[cnt] = i_dquot(inode)[cnt];
+		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
+				&dquot_srcu, lockdep_is_held(&dq_data_lock));
 		ret = dquot_add_inodes(transfer_to[cnt], inode_usage,
 				       &warn_to[cnt]);
 		if (ret)
@@ -2075,7 +2087,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 						  rsv_space);
 			spin_unlock(&transfer_from[cnt]->dq_dqb_lock);
 		}
-		i_dquot(inode)[cnt] = transfer_to[cnt];
+		rcu_assign_pointer(dquots[cnt], transfer_to[cnt]);
 	}
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
@@ -2086,8 +2098,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
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


