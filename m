Return-Path: <linux-kernel+bounces-19752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E034E8272D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4466CB22BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44E52F86;
	Mon,  8 Jan 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LScFmDDD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761E4C3D2;
	Mon,  8 Jan 2024 15:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BFBC433CB;
	Mon,  8 Jan 2024 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727113;
	bh=nfwOOOK2pwf/NrR+X2ST2ZNa4AO++I52x4e4LpY2uAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LScFmDDDK9PDVBgCOXBgoIaMwsyJDyaQJPHDOPLoYY8MWyrVqzA5FhQpjbOdKCGQh
	 T7VOcGA44rMcBXYfp16hhshu0j3XnBgJJDYTrGyw4vy6aXHZzat++LtbrtbDIN61KW
	 wzx7PodKmuyZ0UWgtAn4b80lgmMHRmEIGwGTe/AnhaKRPZA1MygWOn5KeJjWAJh+IL
	 gaykrOfQOhdfrKpA9YRxg0jO9gZ82h6OlUuFw4Nak+ZWOE3xHT6wHLSWs96NcnfCVj
	 AYIMXhhRpGFJfAGYAR38DxkCaW0sK8p2E4QHuKdl4Wj7jDLiJGigbZTYzkTacaXEYq
	 /SySuNyZ3STtQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:22 +0000
Subject: [PATCH v2 6/8] fs/9p: rework qid2ino logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-6-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4755; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=nfwOOOK2pwf/NrR+X2ST2ZNa4AO++I52x4e4LpY2uAM=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDzoai4yhzhbvpdV6ENdiD1DeYCU42U0S0V
 Qo9xlnWdfyJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mGakEACq2rn5Fp6smzLIJWrFYcK3RkMLVwV6gdWby5HIC3jErEU+8k/X2z5rKfi39kJ+S3wXZYh
 +DVzLz1Fm3RSxKVtS8qIIJN54OHXC37wbhW5jizWK5dK+lR9cPaPY0Od4aGqgnclHXd6wPHCJjZ
 sgoEnQ43fn4Qr0lA+zNDg3lDezHfcMG705augWQbKZxjVBBpoEeRodj/rQT2wI+XlVumBXsSj/E
 GqFweeq2GNYVT5wuAfKYM3QGGCYShwQe3esgMullB5Sm1sOVIWOkFbg/u7hLTUq1KQ+V1Iq6s/N
 3K5JT9lxJXeJnq4H2vUGpG2DFlJ+WdRdMjst6lELbwy6F2zrIzoTssc9c2+tvVjN5LgUcczl0U7
 O32ZWStEFc4Oj9MW+3UMbvvHT7QPrZd3nAz+FC7JwtTu2mSYLbOLnThoYoQJTdTjbA6XUFppUoB
 s7Z7dd6DIr76FjIm3T0pn5VSpiDY1cEMW17bTIiCbB79lLQ0qkTBycMO5WdLeWC+0fvrzdDf+d4
 7tfENvTyAhxi0WAIUHL/TJgI00VC2ks2CEub/ZxHRhSayrO4FkgpIebVjruyX5N+jCNsBmK2vBm
 NxOmHxNhQEzR2AGH3la9XU1ECEqNZ0yNKd2T8bYMeXb6iu9zDH7Mprh851yrI/9DJ6azSzhO8Gt
 2Emq6wGzttXkaOQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

This changes from a function to a macro because we can
figure out if we are 32 or 64 bit at compile time.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs_vfs.h       |  7 ++++++-
 fs/9p/vfs_dir.c        |  4 ++--
 fs/9p/vfs_inode.c      | 26 ++------------------------
 fs/9p/vfs_inode_dotl.c |  6 ++----
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index ad0310deb6c8..507dc1389e07 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -43,7 +43,12 @@ void v9fs_free_inode(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
-ino_t v9fs_qid2ino(struct p9_qid *qid);
+#if (BITS_PER_LONG == 32)
+#define QID2INO(q) ((ino_t) (((q)->path+2) ^ (((q)->path) >> 32)))
+#else
+#define QID2INO(q) ((ino_t) ((q)->path+2))
+#endif
+
 void v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 		      struct super_block *sb, unsigned int flags);
 void v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 4102759a5cb5..e0d34e4e9076 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -127,7 +127,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			}
 
 			over = !dir_emit(ctx, st.name, strlen(st.name),
-					 v9fs_qid2ino(&st.qid), dt_type(&st));
+					QID2INO(&st.qid), dt_type(&st));
 			p9stat_free(&st);
 			if (over)
 				return 0;
@@ -184,7 +184,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			if (!dir_emit(ctx, curdirent.d_name,
 				      strlen(curdirent.d_name),
-				      v9fs_qid2ino(&curdirent.qid),
+				      QID2INO(&curdirent.qid),
 				      curdirent.d_type))
 				return 0;
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0d06dca353aa..3b6c9172b40e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -407,7 +407,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	dev_t rdev;
 	int retval;
 	umode_t umode;
-	unsigned long i_ino;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
@@ -417,8 +416,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	else
 		test = v9fs_test_inode;
 
-	i_ino = v9fs_qid2ino(qid);
-	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode, st);
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -428,7 +426,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = i_ino;
+	inode->i_ino = QID2INO(qid);
 	umode = p9mode2unixmode(v9ses, st, &rdev);
 	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
 	if (retval)
@@ -1159,26 +1157,6 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 	v9inode->cache_validity &= ~V9FS_INO_INVALID_ATTR;
 }
 
-/**
- * v9fs_qid2ino - convert qid into inode number
- * @qid: qid to hash
- *
- * BUG: potential for inode number collisions?
- */
-
-ino_t v9fs_qid2ino(struct p9_qid *qid)
-{
-	u64 path = qid->path + 2;
-	ino_t i = 0;
-
-	if (sizeof(ino_t) == sizeof(path))
-		memcpy(&i, &path, sizeof(ino_t));
-	else
-		i = (ino_t) (path ^ (path >> 32));
-
-	return i;
-}
-
 /**
  * v9fs_vfs_get_link - follow a symlink path
  * @dentry: dentry for symlink
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ddc3cfdcc13b..61811cf5d9ff 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -100,7 +100,6 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 					int new)
 {
 	int retval;
-	unsigned long i_ino;
 	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	int (*test)(struct inode *inode, void *data);
@@ -110,8 +109,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	else
 		test = v9fs_test_inode_dotl;
 
-	i_ino = v9fs_qid2ino(qid);
-	inode = iget5_locked(sb, i_ino, test, v9fs_set_inode_dotl, st);
+	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
@@ -121,7 +119,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = i_ino;
+	inode->i_ino = QID2INO(qid);
 	retval = v9fs_init_inode(v9ses, inode,
 				 st->st_mode, new_decode_dev(st->st_rdev));
 	if (retval)

-- 
2.41.0


