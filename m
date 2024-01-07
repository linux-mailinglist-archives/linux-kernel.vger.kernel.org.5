Return-Path: <linux-kernel+bounces-18961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B128265BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D31F21599
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315410A3F;
	Sun,  7 Jan 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx7WSq98"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D710A35;
	Sun,  7 Jan 2024 19:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6834C433C7;
	Sun,  7 Jan 2024 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704654488;
	bh=mB/ju5FqwluH1Q6U+V+EqkhUi9uWMxvAxqacPLLwFpk=;
	h=From:Date:Subject:To:Cc:From;
	b=Kx7WSq98lOEie9aimeb5kS6MEagXxyUyeTdCebAzBEgqw7vMXnz4eeg27fOoubMfs
	 CPHoHuoM8sn6syPhnJTGm7pAnfjsUu9bjk9y+6+2EvFkz5/XtrqQSg7NGWfOoL/Web
	 mqp5m4t1aMfOiP2pi96r4PoWCiWngMUtbBkMPZv/owYswVr6+nfNRRjCXKJtH6ATOI
	 IIw8/jR/zaSvYYMwLHd6MIy3JXgr5uMHr0NkSEGpZ053kGPbl3lGVKO4e86/oYvgwW
	 WG4nAKqE3N65lMA9gOZ5h4r0Y2wbkZ+v24quv3EU9dNQUs2ppcGjEm58tIkGqeoFNK
	 rCDpnWq9/aBdw==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Sun, 07 Jan 2024 19:07:52 +0000
Subject: [PATCH] fs/9p: fix inode nlink accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIf2mmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNz3bTMCt28nMy8bF2gdAqQka5rnGxgZmKWZppiaWSuBNRYUJQKVAU
 2NDq2thYAA6t+eGQAAAA=
To: linux-kernel@vger.kernel.org
Cc: v9fs@lists.linux.dev, linux_oss@crudebyte.com, asmadeus@codewreck.org, 
 rminnich@gmail.com, lucho@ionkov.net, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=mB/ju5FqwluH1Q6U+V+EqkhUi9uWMxvAxqacPLLwFpk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlmvaXiU+hOEEvb2GXDvlC+ox4f5nAHtb2VUiam
 g8cxdq0S5iJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZr2lwAKCRCI/9X7Sl//
 mDMiD/0dEXrMx0YkOMOcM3EbFGCnFdZsrVo81fZhFjcScOBYVBd0RVGGCJoUnZzklZpP1RrfFtQ
 /+y0JnGIsoJKPk60x2adZ3Lje4eWshx6AbSbHT9U1U8EhZlLOVCoiZqyiV4GIe92vD0kBCgzvAE
 XCIc48eMg5KDlUZ44OktnkC1adVBuT+4MygXec0/SFtGIXt7mL9bTTqnMLlDFROIuGZrsW+ZZUV
 HMWnrDaK8xz0HZiwFZOoTOOGRPQ5pnWufDhtobKcDT38zLhJQgoDizlT7GM5M/fHU+niCj1Yc+U
 cTBrYn9ex5zsWyUdBM36HrJBkxku0zbVAyuf814AsecBYdjbfWy9O1hsSN6I26zuW2zYX68p3Cw
 etCpE7wdDpgrPOJA1g1QR9d7awZcUeCTqLVgUHogVRNLMFhRpITTwjbL2bUcrMUmj+bivNE86KD
 swkTyb0ymLcr1WHcm7nVGRXYk+Qb7W4bx4ssWsjLli8Bmm4lY3wCqRiL/wX3nGlF0wNzlbw5gAv
 GVrlDvquQjNYNVV7XOobN3gQnG1AEvaAtiJWQvfa0P/QRhjDqM1tHvic6CdfmCbz9HBBMH2qBnX
 Aot9gVqgzvtGGHINVZKhESR1gfmkXe+I8Zhv/PzbFjoLg6gRwlLqCU0cpyk/cgIvbInnpeabjzj
 gGSrYILzcYize2Q==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

I was running some regressions and noticed a (race-y) kernel warning that
happens when nlink becomes less than zero.  Looking through the code
it looks like we aren't good about protecting the inode lock when
manipulating nlink and some code that was added several years ago to
protect against bugs in underlying file systems nlink handling didn't
look quite right either.  I took a look at what NFS was doing and tried to
follow similar approaches in the 9p code.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode.c      | 32 ++++++++++++++++++++++++--------
 fs/9p/vfs_inode_dotl.c |  2 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..9723c3cbae38 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -508,9 +508,12 @@ static int v9fs_at_to_dotl_flags(int flags)
 /**
  * v9fs_dec_count - helper functon to drop i_nlink.
  *
- * If a directory had nlink <= 2 (including . and ..), then we should not drop
- * the link count, which indicates the underlying exported fs doesn't maintain
- * nlink accurately. e.g.
+ * Put a guards around this so we are only dropping nlink
+ * if it would be valid.  This prevents bugs from an underlying
+ * filesystem implementations from triggering kernel WARNs.  We'll
+ * still print 9p debug messages if the underlying filesystem is wrong.
+ * 
+ * known underlying filesystems which might exhibit this issue:
  * - overlayfs sets nlink to 1 for merged dir
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
@@ -519,8 +522,13 @@ static int v9fs_at_to_dotl_flags(int flags)
  */
 static void v9fs_dec_count(struct inode *inode)
 {
-	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
+	spin_lock(&inode->i_lock);
+	if (inode->i_nlink > 0)
 		drop_nlink(inode);
+	else
+		p9_debug(P9_DEBUG_ERROR, "WARNING: nlink is already 0 inode %p\n", 
+			inode);
+	spin_unlock(&inode->i_lock);
 }
 
 /**
@@ -566,8 +574,9 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 		 * link count
 		 */
 		if (flags & AT_REMOVEDIR) {
+			spin_lock(&inode->i_lock);
 			clear_nlink(inode);
-			v9fs_dec_count(dir);
+			spin_unlock(&inode->i_lock);
 		} else
 			v9fs_dec_count(inode);
 
@@ -713,7 +722,9 @@ static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		err = PTR_ERR(fid);
 		fid = NULL;
 	} else {
+		spin_lock(&dir->i_lock);
 		inc_nlink(dir);
+		spin_unlock(&dir->i_lock);
 		v9fs_invalidate_inode_attr(dir);
 	}
 
@@ -962,14 +973,19 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 error_locked:
 	if (!retval) {
 		if (new_inode) {
-			if (S_ISDIR(new_inode->i_mode))
+			if (S_ISDIR(new_inode->i_mode)) {
+				spin_lock(&new_inode->i_lock);
 				clear_nlink(new_inode);
-			else
+				spin_unlock(&new_inode->i_lock);
+			} else
 				v9fs_dec_count(new_inode);
 		}
 		if (S_ISDIR(old_inode->i_mode)) {
-			if (!new_inode)
+			if (!new_inode) {
+				spin_lock(&new_dir->i_lock);
 				inc_nlink(new_dir);
+				spin_unlock(&new_dir->i_lock);
+			}
 			v9fs_dec_count(old_dir);
 		}
 		v9fs_invalidate_inode_attr(old_inode);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c7319af2f471..6cc037f726e7 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -427,7 +427,9 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 		v9fs_set_create_acl(inode, fid, dacl, pacl);
 		d_instantiate(dentry, inode);
 	}
+	spin_lock(&dir->i_lock);
 	inc_nlink(dir);
+	spin_unlock(&dir->i_lock);
 	v9fs_invalidate_inode_attr(dir);
 error:
 	p9_fid_put(fid);

---
base-commit: 5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
change-id: 20240107-fix-nlink-handling-3c0646f5d927

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>


