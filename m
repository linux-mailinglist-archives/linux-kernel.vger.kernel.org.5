Return-Path: <linux-kernel+bounces-116067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1F889548
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A6A1F335D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE4284531;
	Mon, 25 Mar 2024 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ2n/g2M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57C13C673;
	Sun, 24 Mar 2024 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323486; cv=none; b=Sefcofx4BB9W2zay5TjDtb8ets9lg2/sunrIhQbCiu/jSdaTM3eu7ZngMzJEplCoCoo8DQFuOzTe68Fx29sH0YcoYK8T7X1rwEAk8I5l7eoTzOl2+f971qhBsR4sfrHfmAeoq6XGlQJjOnizPTWORiiI3xqD+cR7sqsPbbw6l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323486; c=relaxed/simple;
	bh=fNrT7pe91RDgkLmsl88yxJzI8kcVy6KeYcN5iz2h4wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwa/PO88/OP/qtY6dXl8aj82zswqHq8I3rpKNshvwSvg2ZG4br6GwuEN2N/QI/GmJiMFfVl4qFWJH/MR18JidDTZAfgTuZ+MmFUAuxVont3oL/OKWmeMZay2stbNhyYfnidxBGYcrKbBzuFL4wCNT2uT+lB4Gpgi6gUmZEXV6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ2n/g2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2F7C433B1;
	Sun, 24 Mar 2024 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323486;
	bh=fNrT7pe91RDgkLmsl88yxJzI8kcVy6KeYcN5iz2h4wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJ2n/g2MF5JQQY94yKketUg1F8iO/h6PZ9ngAApAu6LuiAGEvA+swgSsjSqacB+sB
	 MszQ1KCVsMFE0Wo9H8SS+T1m/MhdnpKQcx/hEg1lEuA4Xef+miNOqpnPD71zxVhbpv
	 wavFfFIF6AK782sdYlWrMH3LM1kA2bAQEgPQk3gjoYtwGbxu1ezBzb6H/BkolZkB8K
	 UkxwtBT0QDLhKBDkbZCouLpSMCKrjBTbwIadvI96grJYcItrTbOS3RRAbHBrp6Tum5
	 HScmXnVxIS1f1BbcsVFtfW3J7T1UAo0M8/r02Udpt9f2ErVZVjjsmIwTiVziJCC+zo
	 pdGtjdxLSsNRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wang Jianjian <wangjianjian3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 191/317] quota: Fix potential NULL pointer dereference
Date: Sun, 24 Mar 2024 19:32:51 -0400
Message-ID: <20240324233458.1352854-192-sashal@kernel.org>
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
Stable-dep-of: 179b8c97ebf6 ("quota: Fix rcu annotations of inode dquot pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 98 ++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b7d8cd84df576..041459526abcf 100644
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
@@ -1684,6 +1686,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
 		if (reserve) {
@@ -1703,27 +1706,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
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
@@ -1754,6 +1756,7 @@ int dquot_alloc_inode(struct inode *inode)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
 		return 0;
@@ -1764,17 +1767,19 @@ int dquot_alloc_inode(struct inode *inode)
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
@@ -1796,6 +1801,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
 int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1811,9 +1817,8 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
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
@@ -1838,6 +1843,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1853,9 +1859,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
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
@@ -1882,6 +1887,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1902,17 +1908,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
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
@@ -1937,6 +1944,7 @@ void dquot_free_inode(struct inode *inode)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 	int index;
 
 	if (!inode_quota_active(inode))
@@ -1947,16 +1955,16 @@ void dquot_free_inode(struct inode *inode)
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
@@ -1983,7 +1991,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
-	int cnt, ret = 0;
+	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
 	struct dquot_warn warn_to[MAXQUOTAS];
 	struct dquot_warn warn_from_inodes[MAXQUOTAS];
@@ -2072,8 +2080,16 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
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


