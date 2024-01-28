Return-Path: <linux-kernel+bounces-41746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B208C83F745
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369011F24AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18918657BB;
	Sun, 28 Jan 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ/ADdLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DF657DC;
	Sun, 28 Jan 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458437; cv=none; b=HK2QS8vysKr/QRJDe64D6Wdr1ujgPXOthkFrNjUVtXg7ZG10rO7lheyBTOVUfsieXP1YWwpIb2UKg3d9+p+ymBu1LQrSYNWcoAhM8bNfGy1u6iFuxDbNp/HXpFZhWd5KqxXX6sJKnEzFqttvEwLszDedcvHqD0sfKdlx8MQFr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458437; c=relaxed/simple;
	bh=+tz46MaXGXaNAhV+LKQZqBPN9T29kafpRdmIUMP/QwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL1DdaLDWUje964fGzvWq/CbOOpuMxSWuqMOJvBFRCp827L4Jg53CjrQzkByX2kAfND2uZc181RiISwMBI0NM1mAi2LOdq6aX8O4/2keZ9uK4msiMp0Y4UViF/lifiS6bQ/6yOX5jdvPOjWhmtmG70X+WKZY1PzW9PFS9cRFumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ/ADdLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF497C433F1;
	Sun, 28 Jan 2024 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458436;
	bh=+tz46MaXGXaNAhV+LKQZqBPN9T29kafpRdmIUMP/QwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQ/ADdLsaAxd5uXggrZYobHIIjFMndFXp/bolHKrM2hRDNSislMJnwbPuKE/J+X+l
	 BErIJ2w9RT+CH0AYG9Zow3YJL01qol/GBNoC5BTr4yWssBZZpOBqtAf7VXFh95vzXy
	 1TTdhYndy8wBU7wQE7w85q52EXu3RyBTIJRC8/08DA6+z2/ZyUMvdvPyBf0n0P4L3H
	 7cZcJXIP5L0tWxjf4lze5CPBaSIjvl3gCVj5os4w6yW6uCTuJp1TtjcF0A0VEiSKES
	 Hrj7Nqsos5drPLqTjRPCx45B31hbdE+XQYsSRVO/iVlg2hVwu6XmYNzR7kT3tv2m4D
	 EXvhQsnE7D3IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenchao Hao <haowenchao2@huawei.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/31] ceph: fix invalid pointer access if get_quota_realm return ERR_PTR
Date: Sun, 28 Jan 2024 11:12:55 -0500
Message-ID: <20240128161315.201999-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Wenchao Hao <haowenchao2@huawei.com>

[ Upstream commit 0f4cf64eabc6e16cfc2704f1960e82dc79d91c8d ]

This issue is reported by smatch that get_quota_realm() might return
ERR_PTR but we did not handle it. It's not a immediate bug, while we
still should address it to avoid potential bugs if get_quota_realm()
is changed to return other ERR_PTR in future.

Set ceph_snap_realm's pointer in get_quota_realm()'s to address this
issue, the pointer would be set to NULL if get_quota_realm() failed
to get struct ceph_snap_realm, so no ERR_PTR would happen any more.

[ xiubli: minor code style clean up ]

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/quota.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index f7fcf7f08ec6..ca4932e6f71b 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -194,10 +194,10 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
 }
 
 /*
- * This function walks through the snaprealm for an inode and returns the
- * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
+ * This function walks through the snaprealm for an inode and set the
+ * realmp with the first snaprealm that has quotas set (max_files,
  * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
- * reached, return the root ceph_snap_realm instead.
+ * reached, set the realmp with the root ceph_snap_realm instead.
  *
  * Note that the caller is responsible for calling ceph_put_snap_realm() on the
  * returned realm.
@@ -208,18 +208,19 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
  * this function will return -EAGAIN; otherwise, the snaprealms walk-through
  * will be restarted.
  */
-static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
-					       struct inode *inode,
-					       enum quota_get_realm which_quota,
-					       bool retry)
+static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
+			   enum quota_get_realm which_quota,
+			   struct ceph_snap_realm **realmp, bool retry)
 {
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
 	struct inode *in;
 	bool has_quota;
 
+	if (realmp)
+		*realmp = NULL;
 	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return NULL;
+		return 0;
 
 restart:
 	realm = ceph_inode(inode)->i_snap_realm;
@@ -245,7 +246,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 				break;
 			ceph_put_snap_realm(mdsc, realm);
 			if (!retry)
-				return ERR_PTR(-EAGAIN);
+				return -EAGAIN;
 			goto restart;
 		}
 
@@ -254,8 +255,11 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 		iput(in);
 
 		next = realm->parent;
-		if (has_quota || !next)
-		       return realm;
+		if (has_quota || !next) {
+			if (realmp)
+				*realmp = realm;
+			return 0;
+		}
 
 		ceph_get_snap_realm(mdsc, next);
 		ceph_put_snap_realm(mdsc, realm);
@@ -264,7 +268,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 	if (realm)
 		ceph_put_snap_realm(mdsc, realm);
 
-	return NULL;
+	return 0;
 }
 
 bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
@@ -272,6 +276,7 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old->i_sb);
 	struct ceph_snap_realm *old_realm, *new_realm;
 	bool is_same;
+	int ret;
 
 restart:
 	/*
@@ -281,9 +286,9 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	 * dropped and we can then restart the whole operation.
 	 */
 	down_read(&mdsc->snap_rwsem);
-	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
-	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
-	if (PTR_ERR(new_realm) == -EAGAIN) {
+	get_quota_realm(mdsc, old, QUOTA_GET_ANY, &old_realm, true);
+	ret = get_quota_realm(mdsc, new, QUOTA_GET_ANY, &new_realm, false);
+	if (ret == -EAGAIN) {
 		up_read(&mdsc->snap_rwsem);
 		if (old_realm)
 			ceph_put_snap_realm(mdsc, old_realm);
@@ -485,8 +490,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	bool is_updated = false;
 
 	down_read(&mdsc->snap_rwsem);
-	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
-				QUOTA_GET_MAX_BYTES, true);
+	get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYTES,
+			&realm, true);
 	up_read(&mdsc->snap_rwsem);
 	if (!realm)
 		return false;
-- 
2.43.0


