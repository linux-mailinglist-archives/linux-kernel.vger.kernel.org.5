Return-Path: <linux-kernel+bounces-124893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE8891D88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FF91F26D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313F233A87;
	Fri, 29 Mar 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5cnniQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AA2319FA;
	Fri, 29 Mar 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716380; cv=none; b=P0vk94Xv27OrDOIvnjiVgqBnsUfg6FqJQ+KZCwQULH7BLnQeuqeuFVJ5ET0d2eBC6ZPx8RL4zJnCZUyKUSVWido6OVdUXTr2rL0fRiQP7mPcPOnA/X5qM34rzML5AuXWFm0Sg17FV53L+5SUI1ogYbhN1XwnZ05mUeP1eluruBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716380; c=relaxed/simple;
	bh=9zcbGf714mmbgRfWNDfxeKQ39HBI/JW23meULrmpD7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfPFFxpTf824ECoaYVH4vF+C7/lQOsMYKLP9bKQo8LwRTywdrsy9Aq2Zt5UkBXiweHikNyxcNM4Q7iNDcyv/YEwi7wSQSRF857DHzH5Yjxf4vHJ8zikhqroewIlsQ0Ntzb57tpANQNBOdH52SxVCki1O1dGt3EpGCNaJxMHvPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5cnniQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B979C43399;
	Fri, 29 Mar 2024 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716380;
	bh=9zcbGf714mmbgRfWNDfxeKQ39HBI/JW23meULrmpD7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5cnniQr0bSNWS/LRikv44+PWgnJSepxXclVf9fz7YyObd9ONpD4NHSFVVpDVqkFr
	 /pHLLpqHOx7J+M0gvAbNAydONQYPq0dKo/IeUtlgXu5e12f0Py0jqa3mLjb6ksafG5
	 ZKotzX3+PkDjsMD4pqrV7kX6hNrNGpy94FK99lt5kzizk7LKEU69KzcOiifXAC1wwh
	 qJK6MGbmQXFgkwPzu9eBS496B9H+R30KGhTA36hpcad2hChgkjtaoL91gAu+qxHVcR
	 YaMcvGA2aSRXbQCHTajsOqb+gY3v6Y8Wx58+dBdr7bSZyTEd1xI4jvLWV0zL+77JgT
	 Nrebf115afvhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wang Jianjian <wangjianjian3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.1 09/52] quota: Fix potential NULL pointer dereference
Date: Fri, 29 Mar 2024 08:45:03 -0400
Message-ID: <20240329124605.3091273-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Wang Jianjian <wangjianjian3@huawei.com>

[ Upstream commit d0aa72604fbd80c8aabb46eda00535ed35570f1f ]

Below race may cause NULL pointer dereference

P1					P2
dquot_free_inode			quota_off
					  drop_dquot_ref
					   remove_dquot_ref
					   dquots = i_dquot(inode)
  dquots = i_dquot(inode)
  srcu_read_lock
  dquots[cnt]) != NULL (1)
					     dquots[type] = NULL (2)
  spin_lock(&dquots[cnt]->dq_dqb_lock) (3)
   ....

If dquot_free_inode(or other routines) checks inode's quota pointers (1)
before quota_off sets it to NULL(2) and use it (3) after that, NULL pointer
dereference will be triggered.

So let's fix it by using a temporary pointer to avoid this issue.

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20240202081852.2514092-1-wangjianjian3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 98 ++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b0cf3869d3bf5..765f1e80e3662 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -399,15 +399,17 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 
 /* Dirtify all the dquots - this can block when journalling */
-static inline int mark_all_dquot_dirty(struct dquot * const *dquot)
+static inline int mark_all_dquot_dirty(struct dquot * const *dquots)
 {
 	int ret, err, cnt;
+	struct dquot *dquot;
 
 	ret = err = 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot)
 			/* Even in case of error we have to continue */
-			ret = mark_dquot_dirty(dquot[cnt]);
+			ret = mark_dquot_dirty(dquot);
 		if (!err)
 			err = ret;
 	}
@@ -1736,6 +1738,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
 		if (reserve) {
@@ -1755,27 +1758,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
 		if (reserve) {
-			ret = dquot_add_space(dquots[cnt], 0, number, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, 0, number, flags, &warn[cnt]);
 		} else {
-			ret = dquot_add_space(dquots[cnt], number, 0, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, number, 0, flags, &warn[cnt]);
 		}
 		if (ret) {
 			/* Back out changes we already did */
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
 				if (reserve)
-					dquot_free_reserved_space(dquots[cnt],
-								  number);
+					dquot_free_reserved_space(dquot, number);
 				else
-					dquot_decr_space(dquots[cnt], number);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+					dquot_decr_space(dquot, number);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			spin_unlock(&inode->i_lock);
 			goto out_flush_warn;
@@ -1806,6 +1808,7 @@ int dquot_alloc_inode(struct inode *inode)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
 		return 0;
@@ -1816,17 +1819,19 @@ int dquot_alloc_inode(struct inode *inode)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		ret = dquot_add_inodes(dquots[cnt], 1, &warn[cnt]);
+		ret = dquot_add_inodes(dquot, 1, &warn[cnt]);
 		if (ret) {
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
 				/* Back out changes we already did */
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquot_decr_inodes(dquots[cnt], 1);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot_decr_inodes(dquot, 1);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			goto warn_put_all;
 		}
@@ -1848,6 +1853,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1863,9 +1869,8 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_rsvspace < number))
 				number = dquot->dq_dqb.dqb_rsvspace;
@@ -1890,6 +1895,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1905,9 +1911,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_curspace < number))
 				number = dquot->dq_dqb.dqb_curspace;
@@ -1934,6 +1939,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1954,17 +1960,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 		int wtype;
 
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_bdq_free(dquots[cnt], number);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_bdq_free(dquot, number);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
+			prepare_warning(&warn[cnt], dquot, wtype);
 		if (reserve)
-			dquot_free_reserved_space(dquots[cnt], number);
+			dquot_free_reserved_space(dquot, number);
 		else
-			dquot_decr_space(dquots[cnt], number);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			dquot_decr_space(dquot, number);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	if (reserve)
 		*inode_reserved_space(inode) -= number;
@@ -1989,6 +1996,7 @@ void dquot_free_inode(struct inode *inode)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 	int index;
 
 	if (!inode_quota_active(inode))
@@ -1999,16 +2007,16 @@ void dquot_free_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		int wtype;
-
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_idq_free(dquots[cnt], 1);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_idq_free(dquot, 1);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
-		dquot_decr_inodes(dquots[cnt], 1);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			prepare_warning(&warn[cnt], dquot, wtype);
+		dquot_decr_inodes(dquot, 1);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	spin_unlock(&inode->i_lock);
 	mark_all_dquot_dirty(dquots);
@@ -2035,7 +2043,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
-	int cnt, ret = 0;
+	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
 	struct dquot_warn warn_to[MAXQUOTAS];
 	struct dquot_warn warn_from_inodes[MAXQUOTAS];
@@ -2124,8 +2132,16 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
 
+	/*
+	 * These arrays are local and we hold dquot references so we don't need
+	 * the srcu protection but still take dquot_srcu to avoid warning in
+	 * mark_all_dquot_dirty().
+	 */
+	index = srcu_read_lock(&dquot_srcu);
 	mark_all_dquot_dirty(transfer_from);
 	mark_all_dquot_dirty(transfer_to);
+	srcu_read_unlock(&dquot_srcu, index);
+
 	flush_warnings(warn_to);
 	flush_warnings(warn_from_inodes);
 	flush_warnings(warn_from_space);
-- 
2.43.0


