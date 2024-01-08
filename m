Return-Path: <linux-kernel+bounces-19753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20808272D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94451C22187
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AF537EA;
	Mon,  8 Jan 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw2e20xD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89352F82;
	Mon,  8 Jan 2024 15:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BA6C433AB;
	Mon,  8 Jan 2024 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727114;
	bh=VG1msmn/vAa3BrGkNkxA3mfakhGXdyjY6wcs0iQkjqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aw2e20xDtw9RQ683qg0ekxLYO4OG1FjzW2nn0nt3IBJDiEWIvGZ3414kpFi6uF/Vy
	 Vqk9DNvuncKvymhLaLA3UBt9JV43MuyM2CPRaphfg5aEU9ywCACLffV1KviAtbIfVU
	 3jyASZQJAqTeBcgbqF0MgGCC86ZLxq7oaU860J34CyL1CR+Dl/MDctBMpKyhkaiopR
	 ykPagqHp1F4vhz/EeeZT4TNVlo3fzdPEAuPiaWUTrMqJe4siSlrEAQqq5RrtzhfQzU
	 OjAgGFTVmsUgHcl8iqNUhXfs8fO6mqol2aZ1zlJ4aVF4u0UOKQjprgf+Nk7cysY2Oo
	 T04+24EoMzMjQ==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:23 +0000
Subject: [PATCH v2 7/8] fs/9p: simplify iget to remove unnecessary paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-7-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12689; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=VG1msmn/vAa3BrGkNkxA3mfakhGXdyjY6wcs0iQkjqs=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDAjpubxFmBW2aX/5B0LxcVA88T6kQI3h59
 KhxPQ8+NDyJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mDTkD/42YEQQ+mlf82tVVRvlipphSP5JXeOxo9QgYdwnl7mJRHoTOu8dFynfs5TPxeu98IjK+TG
 tdRX5Iyq1skGLeMJ18mEF5GqmM1Q4V5WaTZ2owk8OiCrbFs7zQYLC61UYskUEvTBV+TKBehfEo6
 N7ePFDzOpq2Q8uWkzw2POs9l1rIpVX4ipRPAkpaDpb9xoMWY57r23LQwr9FhITL9yyrp4SwPQsr
 cJX+LNmfN03YpwbK2kQ6o4QZnxKsOxVXo21xRoYPxISlPyiI5+qxI0mZUs/7jjj7HtLgAxuhNDy
 Xqqslmax7B4viAcaGdPDvkVxQnR3T65zGINtVjBxoso1LE+sdNKLkM6EL8cHnpzG9AvXXdX3fn4
 Db7s7sdgXT32dfdeZu5wMLLkfNaXywVYjYDUG1m9VEdP4oSEaPxHcOJ/xk1UXCHAoan9WeOi8JT
 hjjn+3tFPsbivKMjsqLKMHekfz3V5g6m2vdVoOqZNOjwceFauoI+JSu49rZB1/q6U6t+Vj+2L82
 j4pwSIPNtWWw0sRC5wCYgdsIHMnV8Z3mU2JA5bRusfzIc+bDgrU21kWUD6sJSkEr/5e2fG+Md/L
 m1bbc3hkV136LEgjq2juSFaln0FbgAjxYvPvPFmbdYbmV0xiqBJ1pBo/BLtbqux5y9TdCyPj2Du
 Z58/5DkMYdgyjtg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Remove the additional comparison operators and switch to
simply lookup by inode number (aka qid.path).

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs.h           | 31 +++-------------
 fs/9p/v9fs_vfs.h       |  2 +-
 fs/9p/vfs_inode.c      | 98 +++++++++++---------------------------------------
 fs/9p/vfs_inode_dotl.c | 92 +++++++++--------------------------------------
 fs/9p/vfs_super.c      |  2 +-
 5 files changed, 45 insertions(+), 180 deletions(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 698c43dd5dc8..9defa12208f9 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -179,16 +179,13 @@ extern int v9fs_vfs_rename(struct mnt_idmap *idmap,
 			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
-extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
-					 struct p9_fid *fid,
-					 struct super_block *sb, int new);
+extern struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid);
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern const struct netfs_request_ops v9fs_req_ops;
-extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
-					      struct p9_fid *fid,
-					      struct super_block *sb, int new);
+extern struct inode *v9fs_fid_iget_dotl(struct super_block *sb,
+					struct p9_fid *fid);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -230,27 +227,9 @@ v9fs_get_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 			struct super_block *sb)
 {
 	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 0);
+		return v9fs_fid_iget_dotl(sb, fid);
 	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 0);
-}
-
-/**
- * v9fs_get_new_inode_from_fid - Helper routine to populate an inode by
- * issuing a attribute request
- * @v9ses: session information
- * @fid: fid to issue attribute request for
- * @sb: superblock on which to create inode
- *
- */
-static inline struct inode *
-v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			    struct super_block *sb)
-{
-	if (v9fs_proto_dotl(v9ses))
-		return v9fs_inode_from_fid_dotl(v9ses, fid, sb, 1);
-	else
-		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
+		return v9fs_fid_iget(sb, fid);
 }
 
 #endif
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 507dc1389e07..3e9e7df14112 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -41,7 +41,7 @@ extern struct kmem_cache *v9fs_inode_cache;
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, umode_t mode, dev_t rdev);
+		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
 #if (BITS_PER_LONG == 32)
 #define QID2INO(q) ((ino_t) (((q)->path+2) ^ (((q)->path) >> 32)))
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3b6c9172b40e..498d6b7257d3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -253,9 +253,12 @@ static void v9fs_set_netfs_context(struct inode *inode)
 }
 
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
-		    struct inode *inode, umode_t mode, dev_t rdev)
+		    struct inode *inode, struct p9_qid *qid, umode_t mode, dev_t rdev)
 {
 	int err = 0;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+
+	memcpy(&v9inode->qid, qid, sizeof(struct p9_qid));
 
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_blocks = 0;
@@ -359,80 +362,40 @@ void v9fs_evict_inode(struct inode *inode)
 #endif
 }
 
-static int v9fs_test_inode(struct inode *inode, void *data)
-{
-	int umode;
-	dev_t rdev;
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
-
-	umode = p9mode2unixmode(v9ses, st, &rdev);
-	/* don't match inode of different type */
-	if (inode_wrong_type(inode, umode))
-		return 0;
-
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
-	if (v9inode->qid.type != st->qid.type)
-		return 0;
-
-	if (v9inode->qid.path != st->qid.path)
-		return 0;
-	return 1;
-}
-
-static int v9fs_test_new_inode(struct inode *inode, void *data)
-{
-	return 0;
-}
-
-static int v9fs_set_inode(struct inode *inode,  void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
-
-	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
-	return 0;
-}
-
-static struct inode *v9fs_qid_iget(struct super_block *sb,
-				   struct p9_qid *qid,
-				   struct p9_wstat *st,
-				   int new)
+struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)
 {
 	dev_t rdev;
 	int retval;
 	umode_t umode;
 	struct inode *inode;
+	struct p9_wstat *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
-	int (*test)(struct inode *inode, void *data);
-
-	if (new)
-		test = v9fs_test_new_inode;
-	else
-		test = v9fs_test_inode;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode, st);
-	if (!inode)
+	inode = iget_locked(sb, QID2INO(&fid->qid));
+	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
+
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = QID2INO(qid);
+	st = p9_client_stat(fid);
+	if (IS_ERR(st)) {
+		retval = PTR_ERR(st);
+		goto error;
+	}
+
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	retval = v9fs_init_inode(v9ses, inode, umode, rdev);
+	retval = v9fs_init_inode(v9ses, inode, &fid->qid, umode, rdev);
+	v9fs_stat2inode(st, inode, sb, 0);
+	p9stat_free(st);
+	kfree(st);
 	if (retval)
 		goto error;
 
-	v9fs_stat2inode(st, inode, sb, 0);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
 	return inode;
@@ -442,23 +405,6 @@ static struct inode *v9fs_qid_iget(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-		    struct super_block *sb, int new)
-{
-	struct p9_wstat *st;
-	struct inode *inode = NULL;
-
-	st = p9_client_stat(fid);
-	if (IS_ERR(st))
-		return ERR_CAST(st);
-
-	inode = v9fs_qid_iget(sb, &st->qid, st, new);
-	p9stat_free(st);
-	kfree(st);
-	return inode;
-}
-
 /**
  * v9fs_at_to_dotl_flags- convert Linux specific AT flags to
  * plan 9 AT flag.
@@ -605,7 +551,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -733,10 +679,8 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 61811cf5d9ff..4d3ae108ac7e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -52,76 +52,33 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 	return current_fsgid();
 }
 
-static int v9fs_test_inode_dotl(struct inode *inode, void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
-
-	/* don't match inode of different type */
-	if (inode_wrong_type(inode, st->st_mode))
-		return 0;
-
-	if (inode->i_generation != st->st_gen)
-		return 0;
-
-	/* compare qid details */
-	if (memcmp(&v9inode->qid.version,
-		   &st->qid.version, sizeof(v9inode->qid.version)))
-		return 0;
-
-	if (v9inode->qid.type != st->qid.type)
-		return 0;
-
-	if (v9inode->qid.path != st->qid.path)
-		return 0;
-	return 1;
-}
-
-/* Always get a new inode */
-static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
-{
-	return 0;
-}
-
-static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
-{
-	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
-
-	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
-	inode->i_generation = st->st_gen;
-	return 0;
-}
-
-static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
-					struct p9_qid *qid,
-					struct p9_fid *fid,
-					struct p9_stat_dotl *st,
-					int new)
+struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 {
 	int retval;
 	struct inode *inode;
+	struct p9_stat_dotl *st;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
-	int (*test)(struct inode *inode, void *data);
-
-	if (new)
-		test = v9fs_test_new_inode_dotl;
-	else
-		test = v9fs_test_inode_dotl;
 
-	inode = iget5_locked(sb, QID2INO(qid), test, v9fs_set_inode_dotl, st);
-	if (!inode)
+	inode = iget_locked(sb, QID2INO(&fid->qid));
+	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW))
 		return inode;
+
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
 	 * later.
 	 */
-	inode->i_ino = QID2INO(qid);
-	retval = v9fs_init_inode(v9ses, inode,
+	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
+	if (IS_ERR(st)) {
+		retval = PTR_ERR(st);
+		goto error;
+	}
+
+	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
+	kfree(st);
 	if (retval)
 		goto error;
 
@@ -132,6 +89,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 		goto error;
 
 	unlock_new_inode(inode);
+
 	return inode;
 error:
 	iget_failed(inode);
@@ -139,22 +97,6 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 }
 
-struct inode *
-v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses, struct p9_fid *fid,
-			 struct super_block *sb, int new)
-{
-	struct p9_stat_dotl *st;
-	struct inode *inode = NULL;
-
-	st = p9_client_getattr_dotl(fid, P9_STATS_BASIC | P9_STATS_GEN);
-	if (IS_ERR(st))
-		return ERR_CAST(st);
-
-	inode = v9fs_qid_iget_dotl(sb, &st->qid, fid, st, new);
-	kfree(st);
-	return inode;
-}
-
 struct dotl_openflag_map {
 	int open_flag;
 	int dotl_flag;
@@ -304,7 +246,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n", err);
 		goto out;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -399,7 +341,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -834,7 +776,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 			 err);
 		goto error;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_fid_iget_dotl(dir->i_sb, fid);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 8d14cc0b3916..6d9a98c57185 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -139,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
+	inode = v9fs_get_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;

-- 
2.41.0


