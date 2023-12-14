Return-Path: <linux-kernel+bounces-171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6963813D06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C880283708
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A812C6B1;
	Thu, 14 Dec 2023 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQh2PXOE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C667213;
	Thu, 14 Dec 2023 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702591366; x=1734127366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lC1aDQ1cQzNR+FGiwgX24ZerPaYmfwh7hY/cl3cf1ew=;
  b=lQh2PXOEVlebDZ2R5Zsv/9uNAS2v/LKz6AZ8jNZxUpzPuLX4EJODNB1x
   Fqn3/W6jlrl0o+gP16IWs9QOn3Se0SKVoqq/QSN0lk27ivwuXelI8CAK6
   sv1zKrxWb/hKIPo6pzMrUYRQqTmhEU7RTFa7+1zsz75vx/vVlBATORNLA
   QZX8s711KAh7EGScFiwz235dsEoCKwNb0a5w+pGPfyDiQU3/23LmT2WGk
   tNaXa7E8kkSOCv85VxcwZVYMGW+ooVnRJgUssEU03PME8rABeOttl9Z72
   JGF1fUkDR/LynwyPRNGdB+S35Vdcvamgz+xB7+rqV9E43sJ5h0b9jxu+j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="397979161"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="397979161"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="767748554"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="767748554"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:02:42 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC] HACK: overlayfs: Optimize overlay/restore creds
Date: Thu, 14 Dec 2023 14:02:22 -0800
Message-ID: <20231214220222.348101-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permission checks in overlayfs also check against the credentials
associated with the superblock, which are assigned at mount() time, so
pretty long lived. So, we can omit the reference counting for this
case.

This (very early) proof of concept does two things:

Add a flag "immutable" (TODO: find a better name) to struct cred to
indicate that it is long lived, and that refcount can be omitted.

Add "guard" helpers, so we can use automatic cleanup to be sure
override/restore are always paired. (I dodn't like that I have
'ovl_cred' to be a container for the credentials, but couldn't think
of other solutions)

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Hi Amir,

Just to know if I am more or less on right track.

This is a different attempt, instead of the local copy idea, I am
using the fact that the credentials associated with the mount() will
be alive for a long time. I think the result is almost the same. But I
could be missing something.

TODO:
 - Add asserts.
 - Replace ovl_override_creds()/revert_Creds() by
   ovl_creator_cred()/guard() everywhere.
 - Probably more.  


 fs/overlayfs/inode.c     |  7 ++++---
 fs/overlayfs/overlayfs.h | 18 ++++++++++++++++++
 fs/overlayfs/params.c    |  4 +++-
 fs/overlayfs/super.c     | 10 +++++++---
 fs/overlayfs/util.c      | 10 ++++++++++
 include/linux/cred.h     | 12 ++++++++++--
 6 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..2c016a3bbe2d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -290,9 +290,9 @@ int ovl_permission(struct mnt_idmap *idmap,
 		   struct inode *inode, int mask)
 {
 	struct inode *upperinode = ovl_inode_upper(inode);
+	struct ovl_cred ovl_cred;
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -310,7 +310,9 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	ovl_cred = ovl_creator_cred(inode->i_sb);
+	guard(ovl_creds)(&ovl_cred);
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
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 05c3dd597fa8..22ea3066376e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -416,6 +416,24 @@ static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
 	return vfs_getattr(path, stat, request_mask, flags);
 }
 
+struct ovl_cred {
+	const struct cred *cred;
+};
+
+static inline struct ovl_cred ovl_creator_cred(struct super_block *sb)
+{
+	struct ovl_fs *ofs = OVL_FS(sb);
+
+	return (struct ovl_cred) { .cred = ofs->creator_cred };
+}
+
+void ovl_override_creds_new(struct ovl_cred *creator_cred);
+void ovl_revert_creds_new(struct ovl_cred *creator_cred);
+
+DEFINE_GUARD(ovl_creds, struct ovl_cred *,
+	     ovl_override_creds_new(_T),
+	     ovl_revert_creds_new(_T));
+
 /* util.c */
 int ovl_get_write_access(struct dentry *dentry);
 void ovl_put_write_access(struct dentry *dentry);
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 3fe2dde1598f..008377b9241a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -770,8 +770,10 @@ void ovl_free_fs(struct ovl_fs *ofs)
 	kfree(ofs->config.lowerdirs);
 	kfree(ofs->config.upperdir);
 	kfree(ofs->config.workdir);
-	if (ofs->creator_cred)
+	if (ofs->creator_cred) {
+		cred_set_immutable(ofs->creator_cred, false);
 		put_cred(ofs->creator_cred);
+	}
 	kfree(ofs);
 }
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0967bb25003..1ffb4f0f8186 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1304,6 +1304,13 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!cred)
 		goto out_err;
 
+	/* Never override disk quota limits or use reserved space */
+	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
+	/* The cred that is going to be associated with the super
+	 * block will not change.
+	 */
+	cred_set_immutable(cred, true);
+
 	err = ovl_fs_params_verify(ctx, &ofs->config);
 	if (err)
 		goto out_err;
@@ -1438,9 +1445,6 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	else if (!ofs->nofh)
 		sb->s_export_op = &ovl_export_fid_operations;
 
-	/* Never override disk quota limits or use reserved space */
-	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
-
 	sb->s_magic = OVERLAYFS_SUPER_MAGIC;
 	sb->s_xattr = ovl_xattr_handlers(ofs);
 	sb->s_fs_info = ofs;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index c3f020ca13a8..9ae9a35a6a7a 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -68,6 +68,16 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_override_creds_new(struct ovl_cred *creator_cred)
+{
+	creator_cred->cred = override_creds(creator_cred->cred);
+}
+
+void ovl_revert_creds_new(struct ovl_cred *creator_cred)
+{
+	revert_creds(creator_cred->cred);
+}
+
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
diff --git a/include/linux/cred.h b/include/linux/cred.h
index af8d353a4b86..06eaedfe48ea 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -151,6 +151,7 @@ struct cred {
 		int non_rcu;			/* Can we skip RCU deletion? */
 		struct rcu_head	rcu;		/* RCU deletion hook */
 	};
+	bool	immutable;
 } __randomize_layout;
 
 extern void __put_cred(struct cred *);
@@ -229,7 +230,8 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
 {
-	atomic_add(nr, &cred->usage);
+	if (!cred->immutable)
+		atomic_add(nr, &cred->usage);
 	return cred;
 }
 
@@ -245,6 +247,12 @@ static inline struct cred *get_new_cred(struct cred *cred)
 	return get_new_cred_many(cred, 1);
 }
 
+static inline void cred_set_immutable(const struct cred *cred, bool imm)
+{
+	struct cred *nonconst_cred = (struct cred *) cred;
+	nonconst_cred->immutable = imm;
+}
+
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference
@@ -313,7 +321,7 @@ static inline void put_cred_many(const struct cred *_cred, int nr)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_sub_and_test(nr, &cred->usage))
+		if (!cred->immutable && atomic_sub_and_test(nr, &cred->usage))
 			__put_cred(cred);
 	}
 }
-- 
2.43.0


