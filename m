Return-Path: <linux-kernel+bounces-116066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA76889545
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF3297644
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CDD282A87;
	Mon, 25 Mar 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERfjF/ia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCF1774ED;
	Sun, 24 Mar 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323486; cv=none; b=o8xu01W7Ex0xyV51W/iput1lLd6bgNCEAWIyxTyjQ8ePRJ/pIq/Hhd1FCF3NUd3d+NV4QTadZbYOei9uvC1z4CfpN+peq0FNMCdoqWN+OZQ0oaDm7xI/s5x6GPDpayKOeDF4DBMv3WhoQioY0Kj2l11jJIWpKKM9DPV7bPB3ALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323486; c=relaxed/simple;
	bh=BH/Oe6Za7hwJSjCNdDO1HHW6sU+06qst04XA7RxXClw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBE3OWUoaD9GUc5PbmgAk3D3Gt2X84SZmAgCVOdy8R2/LSBkxrhUapeo5WD+3Px0vLthV5fOzplY7+PyOlAXLmrBKPt7fEa3cpUjEsfc5SgGdsFQAcJmWe0gZRpMnSCsEcQ9tJaRKCIRWN1eldqmR53K6lUpweRHB7uhovsdM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERfjF/ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79FEC43390;
	Sun, 24 Mar 2024 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323485;
	bh=BH/Oe6Za7hwJSjCNdDO1HHW6sU+06qst04XA7RxXClw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERfjF/ia6pPCjyscUNTzBzYaUCJqTE3v+nvKlXAumwYy3lzJaqW+9P5tMytQmUEz1
	 grblSTqeDXZrTSLkbP8i+TrVSdcL41jVPBoxCYn0m3b6H+fgZ7gQBNXVip5N6fPyZW
	 7M7SPOd7P7Qmq/pns1K4eYtmSMlNLKi3ssGEr9e7gjaguxqwoAIg4gxY8zURLBV/Rn
	 rGEATx+ejrg5+r+3+doHWS5yBr7x0LbHyTEf9AiDAeE4OSnIEjloP62XnlpH5bzhiz
	 7tegW+2O8slpgICb8DQDin2+Jc90rK9DJizBzRPRD04lVdeL7iRl0q+y5RuIZ0jIjR
	 XcndrAu62WAcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 190/317] quota: simplify drop_dquot_ref()
Date: Sun, 24 Mar 2024 19:32:50 -0400
Message-ID: <20240324233458.1352854-191-sashal@kernel.org>
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
index 75e593b1c03e8..b7d8cd84df576 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1084,59 +1084,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
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
@@ -1153,11 +1101,16 @@ static void remove_dquot_ref(struct super_block *sb, int type,
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
@@ -1174,13 +1127,8 @@ static void remove_dquot_ref(struct super_block *sb, int type,
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


