Return-Path: <linux-kernel+bounces-39434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65A83D112
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74256294F34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63978130E35;
	Thu, 25 Jan 2024 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+8V+tpH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D81B278;
	Thu, 25 Jan 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227061; cv=none; b=syDwzh3Z813LQGR11+bBC6WcIhAvH7IdoUFtuD5XzqDf3TBsD5wWGF6TdDjqneOrVmdutcXzsxq5u5LpUyRrVE8TEktiavGsj7jdoxHeaI7FDo/BFTIMCIasKlqbBvzCUsi4yQzpnZFoQJvC5Fgq8TwB9zDaIMNEyKF0F8KhT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227061; c=relaxed/simple;
	bh=oXu8e8sl63m8R+FJnn7qQsxLgGdBr5LYwt69wUkKx08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1uebOqPFa8klVmXiCv1CXGTbmbl/nbUTGntMmlL7ZWjWFmjjV4TqrlbG70+d7OfUJBua/X5y6Nv03VItdChOsOaKigOfoIFSpIGlNfw+k95FFNLshCZXaO4gt1Y3Se8amING67hxrgKDYrsPTAuQU7/I6TOq0JDZ6sHjyFigrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+8V+tpH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227058; x=1737763058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oXu8e8sl63m8R+FJnn7qQsxLgGdBr5LYwt69wUkKx08=;
  b=k+8V+tpH7qKY5HGUzKQ1cS59kvMSjgtGWdxXNgkk+WgJpIDsizyZNWWE
   iJFD7VjbSeF6ggYz43I09HqqhNj6ejYUDTKJQYIs3zEN13mJpWYzB95MV
   MBk2VN7gNWRQDvWS1RXOX/XTd+c++VHJhB2jcb3Ncsuk6HV8gF+lFZMNo
   ds5PlSBUMrT+qVYDQEe09qK12aFX8ifxmF9J21NCCJKlsVPBu4aQeOqrL
   XrTJPLqD+kFhvb2AFNsWHxwzpbs8ScA75b6T6tRKMentt6/324AAfEMqK
   EXgJtARgYaTk7A2pv80RnBH90/47a4uwGHxmlr2kqfzT1zo8WVzsPrL/G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15867571"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15867571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930191104"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930191104"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:36 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v2 3/4] overlayfs: Optimize credentials usage
Date: Thu, 25 Jan 2024 15:57:22 -0800
Message-ID: <20240125235723.39507-4-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125235723.39507-1-vinicius.gomes@intel.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File operations in overlayfs also check against the credentials of the
mounter task, stored in the superblock, this credentials will outlive
most of the operations. For these cases, use the recently introduced
guard statements to guarantee that override/revert_creds() are paired.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/copy_up.c |  4 +--
 fs/overlayfs/dir.c     | 22 +++++++------
 fs/overlayfs/file.c    | 70 ++++++++++++++++++++++--------------------
 fs/overlayfs/inode.c   | 60 +++++++++++++++++++-----------------
 fs/overlayfs/namei.c   | 21 ++++++-------
 fs/overlayfs/readdir.c | 18 +++++------
 fs/overlayfs/util.c    | 23 +++++++-------
 fs/overlayfs/xattrs.c  | 34 ++++++++++----------
 8 files changed, 130 insertions(+), 122 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b8e25ca51016..55d1f2b60775 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1202,7 +1202,8 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1227,7 +1228,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f8b4a719237..5aa43a3a7b3e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -687,9 +687,9 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -894,12 +894,13 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (!lower_positive)
-		err = ovl_remove_upper(dentry, is_dir, &list);
-	else
-		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred) {
+		if (!lower_positive)
+			err = ovl_remove_upper(dentry, is_dir, &list);
+		else
+			err = ovl_remove_and_whiteout(dentry, &list);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1146,7 +1147,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
+	old_cred = ovl_creds(old->d_sb);
+	old_cred = override_creds_light(old_cred);
 
 	if (!list_empty(&list)) {
 		opaquedir = ovl_clear_empty(new, &list);
@@ -1279,7 +1281,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 05536964d37f..482bf78555e2 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -42,7 +42,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_creds(inode->i_sb);
+	guard(cred)(old_cred);
 	real_idmap = mnt_idmap(realpath->mnt);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
@@ -54,7 +55,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(&file->f_path, flags, realpath,
 					     current_cred());
 	}
-	revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -214,9 +214,9 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(inode->i_sb);
+	scoped_guard(cred, old_cred)
+		ret = vfs_llseek(real.file, offset, whence);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -388,7 +388,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -401,9 +400,11 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		const struct cred *old_cred;
+
+		old_cred = ovl_creds(file_inode(file)->i_sb);
+		guard(cred)(old_cred);
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
 	}
 
 	fdput(real);
@@ -441,9 +442,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(file_inode(file)->i_sb);
+	scoped_guard(cred, old_cred)
+		ret = vfs_fallocate(real.file, mode, offset, len);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -466,9 +467,9 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(file_inode(file)->i_sb);
+	scoped_guard(cred, old_cred)
+		ret = vfs_fadvise(real.file, offset, len, advice);
 
 	fdput(real);
 
@@ -509,25 +510,25 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
-	switch (op) {
-	case OVL_COPY:
-		ret = vfs_copy_file_range(real_in.file, pos_in,
-					  real_out.file, pos_out, len, flags);
-		break;
+	old_cred = ovl_creds(file_inode(file_out)->i_sb);
+	scoped_guard(cred, old_cred)
+		switch (op) {
+		case OVL_COPY:
+			ret = vfs_copy_file_range(real_in.file, pos_in,
+						  real_out.file, pos_out, len, flags);
+			break;
 
-	case OVL_CLONE:
-		ret = vfs_clone_file_range(real_in.file, pos_in,
-					   real_out.file, pos_out, len, flags);
-		break;
+		case OVL_CLONE:
+			ret = vfs_clone_file_range(real_in.file, pos_in,
+						   real_out.file, pos_out, len, flags);
+			break;
 
-	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
-						real_out.file, pos_out, len,
-						flags);
-		break;
-	}
-	revert_creds(old_cred);
+		case OVL_DEDUPE:
+			ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
+							real_out.file, pos_out, len,
+							flags);
+			break;
+		}
 
 	/* Update size */
 	ovl_file_modified(file_out);
@@ -579,7 +580,6 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int err;
 
 	err = ovl_real_fdget(file, &real);
@@ -587,9 +587,11 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return err;
 
 	if (real.file->f_op->flush) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		const struct cred *old_cred;
+
+		old_cred = ovl_creds(file_inode(file)->i_sb);
+		guard(cred)(old_cred);
 		err = real.file->f_op->flush(real.file, id);
-		revert_creds(old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..9047f245ba0b 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -79,9 +79,10 @@ int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_put_write;
 
 		inode_lock(upperdentry->d_inode);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = ovl_do_notify_change(ofs, upperdentry, attr);
-		revert_creds(old_cred);
+		old_cred = ovl_creds(dentry->d_sb);
+		scoped_guard(cred, old_cred)
+			err = ovl_do_notify_change(ofs, upperdentry, attr);
+
 		if (!err)
 			ovl_copyattr(dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -170,7 +171,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	metacopy_blocks = ovl_is_metacopy_dentry(dentry);
 
 	type = ovl_path_real(dentry, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	err = ovl_do_getattr(&realpath, stat, request_mask, flags);
 	if (err)
 		goto out;
@@ -281,8 +283,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
-
 	return err;
 }
 
@@ -310,7 +310,9 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_creds(inode->i_sb);
+	guard(cred)(old_cred);
+
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -318,7 +320,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -333,9 +334,10 @@ static const char *ovl_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+
 	return p;
 }
 
@@ -468,9 +470,9 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 	} else {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		old_cred = ovl_creds(inode->i_sb);
+		guard(cred)(old_cred);
 		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		revert_creds(old_cred);
 	}
 
 	return acl;
@@ -496,10 +498,11 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 		struct posix_acl *real_acl;
 
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
-				       acl_name);
-		revert_creds(old_cred);
+		old_cred = ovl_creds(dentry->d_sb);
+		scoped_guard(cred, old_cred)
+			real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
+					       acl_name);
+
 		if (IS_ERR(real_acl)) {
 			err = PTR_ERR(real_acl);
 			goto out;
@@ -519,12 +522,13 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (acl)
-		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
-	else
-		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred) {
+		if (acl)
+			err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+		else
+			err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	}
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -599,9 +603,9 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_creds(inode->i_sb);
+	guard(cred)(old_cred);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -661,7 +665,8 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		old_cred = ovl_creds(inode->i_sb);
+		guard(cred)(old_cred);
 		/*
 		 * Store immutable/append-only flags in xattr and clear them
 		 * in upper fileattr (in case they were set by older kernel)
@@ -672,7 +677,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
 		ovl_drop_write(dentry);
 
 		/*
@@ -731,10 +735,10 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_creds(inode->i_sb);
+	guard(cred)(old_cred);
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 984ffdaeed6c..0b0258c582a0 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -946,13 +946,12 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_creds(dentry->d_sb);
+		guard(cred)(old_cred);
 
 		err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
-
-		revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
@@ -984,9 +983,10 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred)
+		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
+
 	if (err)
 		goto out_err;
 
@@ -1052,7 +1052,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
 		d.mnt = ovl_upper_mnt(ofs);
@@ -1331,7 +1332,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
 
-	revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1355,7 +1355,6 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1379,7 +1378,8 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	/* Positive upper -> have to look up lower to see whether it exists */
 	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 		struct dentry *this;
@@ -1412,7 +1412,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e71156baa7bc..58ea942921fc 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -275,7 +275,8 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 	struct dentry *dentry, *dir = path->dentry;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(rdd->dentry->d_sb);
+	old_cred = ovl_creds(rdd->dentry->d_sb);
+	guard(cred)(old_cred);
 
 	err = down_write_killable(&dir->d_inode->i_rwsem);
 	if (!err) {
@@ -290,7 +291,6 @@ static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
 
 	return err;
 }
@@ -755,7 +755,8 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	const struct cred *old_cred;
 	int err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -807,7 +808,6 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
 	return err;
 }
 
@@ -857,9 +857,9 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 	struct file *res;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	old_cred = ovl_creds(file_inode(file)->i_sb);
+	guard(cred)(old_cred);
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
 
 	return res;
 }
@@ -984,9 +984,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	struct rb_root root = RB_ROOT;
 	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred)
+		err = ovl_dir_read_merged(dentry, list, &root);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 0217094c23ea..7ba8449d920e 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1157,15 +1157,16 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	/*
-	 * The overlay inode nlink should be incremented/decremented IFF the
-	 * upper operation succeeds, along with nlink change of upper inode.
-	 * Therefore, before link/unlink/rename, we store the union nlink
-	 * value relative to the upper inode nlink in an upper inode xattr.
-	 */
-	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred) {
+		/*
+		 * The overlay inode nlink should be incremented/decremented IFF the
+		 * upper operation succeeds, along with nlink change of upper inode.
+		 * Therefore, before link/unlink/rename, we store the union nlink
+		 * value relative to the upper inode nlink in an upper inode xattr.
+		 */
+		err = ovl_set_nlink_upper(dentry);
+	}
 	if (err)
 		goto out_drop_write;
 
@@ -1188,9 +1189,9 @@ void ovl_nlink_end(struct dentry *dentry)
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
 		const struct cred *old_cred;
 
-		old_cred = ovl_override_creds(dentry->d_sb);
+		old_cred = ovl_creds(dentry->d_sb);
+		guard(cred)(old_cred);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 383978e4663c..921a7d086fa1 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -45,9 +45,9 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 
 	if (!value && !upperdentry) {
 		ovl_path_lower(dentry, &realpath);
-		old_cred = ovl_override_creds(dentry->d_sb);
-		err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		old_cred = ovl_creds(dentry->d_sb);
+		scoped_guard(cred, old_cred)
+			err = vfs_getxattr(mnt_idmap(realpath.mnt), realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out;
 	}
@@ -64,15 +64,16 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	if (value) {
-		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
-				      flags);
-	} else {
-		WARN_ON(flags != XATTR_REPLACE);
-		err = ovl_do_removexattr(ofs, realdentry, name);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred) {
+		if (value) {
+			err = ovl_do_setxattr(ofs, realdentry, name, value, size,
+					      flags);
+		} else {
+			WARN_ON(flags != XATTR_REPLACE);
+			err = ovl_do_removexattr(ofs, realdentry, name);
+		}
 	}
-	revert_creds(old_cred);
 	ovl_drop_write(dentry);
 
 	/* copy c/mtime */
@@ -89,9 +90,9 @@ static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
+	old_cred = ovl_creds(dentry->d_sb);
+	guard(cred)(old_cred);
 	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	revert_creds(old_cred);
 	return res;
 }
 
@@ -119,9 +120,9 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	old_cred = ovl_creds(dentry->d_sb);
+	scoped_guard(cred, old_cred)
+		res = vfs_listxattr(realdentry, list, size);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -268,4 +269,3 @@ const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *ofs)
 	return ofs->config.userxattr ? ovl_user_xattr_handlers :
 		ovl_trusted_xattr_handlers;
 }
-
-- 
2.43.0


