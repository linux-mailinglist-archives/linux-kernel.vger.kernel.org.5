Return-Path: <linux-kernel+bounces-124800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF47891CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A8B1F2554E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1D18E0D3;
	Fri, 29 Mar 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX7PSHFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9218D893;
	Fri, 29 Mar 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716158; cv=none; b=S05MVWykpGip0FaSWSxCvEAlAwvcpzUZgWFKAv4WwLB157yPzCB8fo8yLkEeRVONbnl1RVDhl+/f1sCYXNaZViee/6Ax5mo10x9m3fjUwMr4q6RNpi2/nj81pRIiFfh+kOhAXl5LKee1HcfLZO5plXEFt8JkxI9+XJrdzG/Mua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716158; c=relaxed/simple;
	bh=1dFrxW2R+U97JNLhFYnwDX8XmCdyhodtgAIP0L3BQ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYnnCuUqwS+p9maJo6oJD83eDXHP6JXAThDIXy5Y9VDLrDrJowqIof/bYB6/H14mTvv9/1g8y9FOQRXT7v6m+hY7A+8ANQQmDPUJ69IrMOU/1YA0W3LJ8ebkxRP1ZlAbfgzTADHmuFtnc9KGSQQD0LHyVn2o/AhYXt8+PYodNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX7PSHFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95675C43390;
	Fri, 29 Mar 2024 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716157;
	bh=1dFrxW2R+U97JNLhFYnwDX8XmCdyhodtgAIP0L3BQ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SX7PSHFWx1pp4AbchQtuWcHr1/vQf/t7fG2HGPHNktHwpU3nKLA770e5Cz3dngQK1
	 Ou+fWDIy0a4pTIz2uWAwsBwQADbmhzvfvdxzs1LKdJ8i6m7ZhPE7E50MyZ7GBlasww
	 bULhxjVIIWWm0M1gElOVHhl4P0+9xoAMucgxV40nnZNWrLj5uTmAfmvGpjg03umwvJ
	 Siia/DKjW5zcpj6ad3Fz+SwVqJILst+1rUq2EmVJU/YuKpuLLNNM8c/P6ydnzaxC2F
	 vekXHPZan+Z+kzWZXIgntMlq0y5b9oXDX7LcdmasWX6EKrO5HSaM73kbi88GeBMReU
	 uWyIrCHxK8gng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meetakshi Setiya <msetiya@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.8 89/98] smb: client: reuse file lease key in compound operations
Date: Fri, 29 Mar 2024 08:38:00 -0400
Message-ID: <20240329123919.3087149-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

[ Upstream commit 2c7d399e551ccfd87bcae4ef5573097f3313d779 ]

Currently, when a rename, unlink or set path size compound operation
is requested on a file that has a lot of dirty pages to be written
to the server, we do not send the lease key for these requests. As a
result, the server can assume that this request is from a new client, and
send a lease break notification to the same client, on the same
connection. As a response to the lease break, the client can consume
several credits to write the dirty pages to the server. Depending on the
server's credit grant implementation, the server can stop granting more
credits to this connection, and this can cause a deadlock (which can only
be resolved when the lease timer on the server expires).
One of the problems here is that the client is sending no lease key,
even if it has a lease for the file. This patch fixes the problem by
reusing the existing lease key on the file for rename, unlink and set path
size compound operations so that the client does not break its own lease.

A very trivial example could be a set of commands by a client that
maintains open handle (for write) to a file and then tries to copy the
contents of that file to another one, eg.,

tail -f /dev/null > myfile &
mv myfile myfile2

Presently, the network capture on the client shows that the move (or
rename) would trigger a lease break on the same client, for the same file.
With the lease key reused, the lease break request-response overhead is
eliminated, thereby reducing the roundtrips performed for this set of
operations.

The patch fixes the bug described above and also provides perf benefit.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  5 ++--
 fs/smb/client/cifsproto.h |  6 +++--
 fs/smb/client/cifssmb.c   |  4 ++--
 fs/smb/client/inode.c     | 10 ++++----
 fs/smb/client/smb2inode.c | 48 ++++++++++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  6 +++--
 6 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 53c75cfb33ab9..7f18c75991f91 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -371,7 +371,8 @@ struct smb_version_operations {
 			    struct cifs_open_info_data *data);
 	/* set size by path */
 	int (*set_path_size)(const unsigned int, struct cifs_tcon *,
-			     const char *, __u64, struct cifs_sb_info *, bool);
+			     const char *, __u64, struct cifs_sb_info *, bool,
+				 struct dentry *);
 	/* set size by file handle */
 	int (*set_file_size)(const unsigned int, struct cifs_tcon *,
 			     struct cifsFileInfo *, __u64, bool);
@@ -401,7 +402,7 @@ struct smb_version_operations {
 		     struct cifs_sb_info *);
 	/* unlink file */
 	int (*unlink)(const unsigned int, struct cifs_tcon *, const char *,
-		      struct cifs_sb_info *);
+		      struct cifs_sb_info *, struct dentry *);
 	/* open, rename and delete file */
 	int (*rename_pending_delete)(const char *, struct dentry *,
 				     const unsigned int);
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a841bf4967fa4..ef98c840791f0 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -402,7 +402,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned int xid,
 				     __u32 pid_of_opener);
 extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 			 const char *file_name, __u64 size,
-			 struct cifs_sb_info *cifs_sb, bool set_allocation);
+			 struct cifs_sb_info *cifs_sb, bool set_allocation,
+			 struct dentry *dentry);
 extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 			      struct cifsFileInfo *cfile, __u64 size,
 			      bool set_allocation);
@@ -438,7 +439,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 			const struct nls_table *nls_codepage,
 			int remap_special_chars);
 extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *name, struct cifs_sb_info *cifs_sb);
+			  const char *name, struct cifs_sb_info *cifs_sb,
+			  struct dentry *dentry);
 int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 		  struct dentry *source_dentry,
 		  const char *from_name, const char *to_name,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01e89070df5ab..301189ee1335b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -738,7 +738,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 
 int
 CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
-	       struct cifs_sb_info *cifs_sb)
+	       struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
 	DELETE_FILE_REQ *pSMB = NULL;
 	DELETE_FILE_RSP *pSMBr = NULL;
@@ -4993,7 +4993,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 int
 CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 	      const char *file_name, __u64 size, struct cifs_sb_info *cifs_sb,
-	      bool set_allocation)
+	      bool set_allocation, struct dentry *dentry)
 {
 	struct smb_com_transaction2_spi_req *pSMB = NULL;
 	struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d02f8ba29cb5b..3073eac989eac 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1846,7 +1846,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 		goto psx_del_no_retry;
 	}
 
-	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb);
+	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry);
 
 psx_del_no_retry:
 	if (!rc) {
@@ -2797,7 +2797,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 
 static int
 cifs_set_file_size(struct inode *inode, struct iattr *attrs,
-		   unsigned int xid, const char *full_path)
+		   unsigned int xid, const char *full_path, struct dentry *dentry)
 {
 	int rc;
 	struct cifsFileInfo *open_file;
@@ -2848,7 +2848,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 	 */
 	if (server->ops->set_path_size)
 		rc = server->ops->set_path_size(xid, tcon, full_path,
-						attrs->ia_size, cifs_sb, false);
+						attrs->ia_size, cifs_sb, false, dentry);
 	else
 		rc = -ENOSYS;
 	cifs_dbg(FYI, "SetEOF by path (setattrs) rc = %d\n", rc);
@@ -2938,7 +2938,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto out;
 	}
@@ -3105,7 +3105,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto cifs_setattr_exit;
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 05818cd6d932e..69f3442c5b963 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -98,7 +98,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    __u32 desired_access, __u32 create_disposition,
 			    __u32 create_options, umode_t mode, struct kvec *in_iov,
 			    int *cmds, int num_cmds, struct cifsFileInfo *cfile,
-			    struct kvec *out_iov, int *out_buftype)
+			    struct kvec *out_iov, int *out_buftype, struct dentry *dentry)
 {
 
 	struct reparse_data_buffer *rbuf;
@@ -115,6 +115,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	int resp_buftype[MAX_COMPOUND];
 	struct smb2_query_info_rsp *qi_rsp = NULL;
 	struct cifs_open_info_data *idata;
+	struct inode *inode = NULL;
 	int flags = 0;
 	__u8 delete_pending[8] = {1, 0, 0, 0, 0, 0, 0, 0};
 	unsigned int size[2];
@@ -152,6 +153,15 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		goto finished;
 	}
 
+	/* if there is an existing lease, reuse it */
+	if (dentry) {
+		inode = d_inode(dentry);
+		if (CIFS_I(inode)->lease_granted && server->ops->get_lease_key) {
+			oplock = SMB2_OPLOCK_LEVEL_LEASE;
+			server->ops->get_lease_key(inode, &fid);
+		}
+	}
+
 	vars->oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
 		.path = full_path,
@@ -747,7 +757,7 @@ int smb2_query_path_info(const unsigned int xid,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      create_options, ACL_NO_MODE, in_iov,
-			      cmds, 1, cfile, out_iov, out_buftype);
+			      cmds, 1, cfile, out_iov, out_buftype, NULL);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -779,7 +789,7 @@ int smb2_query_path_info(const unsigned int xid,
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
 				      create_options, ACL_NO_MODE, in_iov,
-				      cmds, num_cmds, cfile, NULL, NULL);
+				      cmds, num_cmds, cfile, NULL, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -811,7 +821,7 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				CREATE_NOT_FILE, mode,
 				NULL, &(int){SMB2_OP_MKDIR}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 void
@@ -836,7 +846,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
 				 &(int){SMB2_OP_SET_INFO}, 1,
-				 cfile, NULL, NULL);
+				 cfile, NULL, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -850,25 +860,26 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 				DELETE, FILE_OPEN, CREATE_NOT_FILE,
 				ACL_NO_MODE, NULL,
 				&(int){SMB2_OP_RMDIR}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 int
 smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
-	    struct cifs_sb_info *cifs_sb)
+	    struct cifs_sb_info *cifs_sb, struct dentry *dentry)
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
 				ACL_NO_MODE, NULL,
 				&(int){SMB2_OP_DELETE}, 1,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, dentry);
 }
 
 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 			      const char *from_name, const char *to_name,
 			      struct cifs_sb_info *cifs_sb,
 			      __u32 create_options, __u32 access,
-			      int command, struct cifsFileInfo *cfile)
+			      int command, struct cifsFileInfo *cfile,
+				  struct dentry *dentry)
 {
 	struct kvec in_iov;
 	__le16 *smb2_to_name = NULL;
@@ -883,7 +894,7 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	in_iov.iov_len = 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
 			      FILE_OPEN, create_options, ACL_NO_MODE,
-			      &in_iov, &command, 1, cfile, NULL, NULL);
+			      &in_iov, &command, 1, cfile, NULL, NULL, dentry);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -902,7 +913,7 @@ int smb2_rename_path(const unsigned int xid,
 	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
 	return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
-				  co, DELETE, SMB2_OP_RENAME, cfile);
+				  co, DELETE, SMB2_OP_RENAME, cfile, source_dentry);
 }
 
 int smb2_create_hardlink(const unsigned int xid,
@@ -915,13 +926,14 @@ int smb2_create_hardlink(const unsigned int xid,
 
 	return smb2_set_path_attr(xid, tcon, from_name, to_name,
 				  cifs_sb, co, FILE_READ_ATTRIBUTES,
-				  SMB2_OP_HARDLINK, NULL);
+				  SMB2_OP_HARDLINK, NULL, NULL);
 }
 
 int
 smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 		   const char *full_path, __u64 size,
-		   struct cifs_sb_info *cifs_sb, bool set_alloc)
+		   struct cifs_sb_info *cifs_sb, bool set_alloc,
+		   struct dentry *dentry)
 {
 	struct cifsFileInfo *cfile;
 	struct kvec in_iov;
@@ -934,7 +946,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 				FILE_WRITE_DATA, FILE_OPEN,
 				0, ACL_NO_MODE, &in_iov,
 				&(int){SMB2_OP_SET_EOF}, 1,
-				cfile, NULL, NULL);
+				cfile, NULL, NULL, dentry);
 }
 
 int
@@ -963,7 +975,7 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
 			      0, ACL_NO_MODE, &in_iov,
 			      &(int){SMB2_OP_SET_INFO}, 1,
-			      cfile, NULL, NULL);
+			      cfile, NULL, NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
 }
@@ -998,7 +1010,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL, NULL);
 		if (!rc) {
 			rc = smb311_posix_get_inode_info(&new, full_path,
 							 data, sb, xid);
@@ -1008,7 +1020,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL, NULL);
 		if (!rc) {
 			rc = cifs_get_inode_info(&new, full_path,
 						 data, sb, xid, NULL);
@@ -1036,7 +1048,7 @@ int smb2_query_reparse_point(const unsigned int xid,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
 			      &(int){SMB2_OP_GET_REPARSE}, 1,
-			      cfile, NULL, NULL);
+			      cfile, NULL, NULL, NULL);
 	if (rc)
 		goto out;
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b3069911e9dd8..221143788a1c0 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -75,7 +75,8 @@ int smb2_query_path_info(const unsigned int xid,
 			 struct cifs_open_info_data *data);
 extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 			      const char *full_path, __u64 size,
-			      struct cifs_sb_info *cifs_sb, bool set_alloc);
+			      struct cifs_sb_info *cifs_sb, bool set_alloc,
+				  struct dentry *dentry);
 extern int smb2_set_file_info(struct inode *inode, const char *full_path,
 			      FILE_BASIC_INFO *buf, const unsigned int xid);
 extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
@@ -91,7 +92,8 @@ extern void smb2_mkdir_setinfo(struct inode *inode, const char *full_path,
 extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
 		      const char *name, struct cifs_sb_info *cifs_sb);
 extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
-		       const char *name, struct cifs_sb_info *cifs_sb);
+		       const char *name, struct cifs_sb_info *cifs_sb,
+			   struct dentry *dentry);
 int smb2_rename_path(const unsigned int xid,
 		     struct cifs_tcon *tcon,
 		     struct dentry *source_dentry,
-- 
2.43.0


