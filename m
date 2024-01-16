Return-Path: <linux-kernel+bounces-26824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89282E69A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CF81F20984
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1961BDEE;
	Tue, 16 Jan 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOO7/otP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061131BDC2;
	Tue, 16 Jan 2024 01:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D8C43394;
	Tue, 16 Jan 2024 01:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367103;
	bh=L9j7kZ7dPoYHxqIOSpC92yy6hgDqsHkLM8Q7Yiayu8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOO7/otPov01Db/k8CCwT70FWONULKYjibyKdaJzb8YjMqFNjd7Mda0NFyH7Ujl25
	 Zb8rEBPa+IayQw3QJoa/GpKzSBm6j/w4K/PeYRKQB0ExYz6wMDzO6qMpZloORZDvZ5
	 2fwRcvIF2OM/YV/3h2D32xOq9HbKlrstZulPHjtoGSNkcOTRcsB1FJHjlUy4FgL2GU
	 ZaS1TKKhLRL438L1cA3OHVwPIfhIj+pqvbhkLbtBRDF1oi6I5Zez55OfmT7FJEPPqQ
	 wIfTntgO9v9WoaBi1Sd3TjiMNRYx8088tYBYSFlUT7+dub+cD8PJuX1W9uT21gifXd
	 I4AMCv7h6TwFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 15/21] smb: client: fix hardlinking of reparse points
Date: Mon, 15 Jan 2024 20:03:52 -0500
Message-ID: <20240116010422.217925-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010422.217925-1-sashal@kernel.org>
References: <20240116010422.217925-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 5408990aa662bcfd6ba894734023a023a16e8729 ]

The client was sending an SMB2_CREATE request without setting
OPEN_REPARSE_POINT flag thus failing the entire hardlink operation.

Fix this by setting OPEN_REPARSE_POINT in create options for
SMB2_CREATE request when the source inode is a repase point.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |  8 +++++---
 fs/smb/client/cifsproto.h |  8 +++++---
 fs/smb/client/cifssmb.c   |  9 +++++----
 fs/smb/client/link.c      |  4 ++--
 fs/smb/client/smb2inode.c | 33 +++++++++++++++++++++------------
 fs/smb/client/smb2proto.h |  8 +++++---
 6 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 4d07b96038d8..942e6ece56b1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -405,9 +405,11 @@ struct smb_version_operations {
 		      const char *from_name, const char *to_name,
 		      struct cifs_sb_info *cifs_sb);
 	/* send create hardlink request */
-	int (*create_hardlink)(const unsigned int, struct cifs_tcon *,
-			       const char *, const char *,
-			       struct cifs_sb_info *);
+	int (*create_hardlink)(const unsigned int xid,
+			       struct cifs_tcon *tcon,
+			       struct dentry *source_dentry,
+			       const char *from_name, const char *to_name,
+			       struct cifs_sb_info *cifs_sb);
 	/* query symlink target */
 	int (*query_symlink)(const unsigned int xid,
 			     struct cifs_tcon *tcon,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 5af921b400d7..9516f5732324 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -443,9 +443,11 @@ extern int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *tcon,
 				 int netfid, const char *target_name,
 				 const struct nls_table *nls_codepage,
 				 int remap_special_chars);
-extern int CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
-			      const char *from_name, const char *to_name,
-			      struct cifs_sb_info *cifs_sb);
+int CIFSCreateHardLink(const unsigned int xid,
+		       struct cifs_tcon *tcon,
+		       struct dentry *source_dentry,
+		       const char *from_name, const char *to_name,
+		       struct cifs_sb_info *cifs_sb);
 extern int CIFSUnixCreateHardLink(const unsigned int xid,
 			struct cifs_tcon *tcon,
 			const char *fromName, const char *toName,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 5bdea01919e8..e9e33b0b3ac4 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2530,10 +2530,11 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-int
-CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
-		   const char *from_name, const char *to_name,
-		   struct cifs_sb_info *cifs_sb)
+int CIFSCreateHardLink(const unsigned int xid,
+		       struct cifs_tcon *tcon,
+		       struct dentry *source_dentry,
+		       const char *from_name, const char *to_name,
+		       struct cifs_sb_info *cifs_sb)
 {
 	int rc = 0;
 	NT_RENAME_REQ *pSMB = NULL;
diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index a1da50e66fbb..3ef34218a790 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -510,8 +510,8 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 			rc = -ENOSYS;
 			goto cifs_hl_exit;
 		}
-		rc = server->ops->create_hardlink(xid, tcon, from_name, to_name,
-						  cifs_sb);
+		rc = server->ops->create_hardlink(xid, tcon, old_file,
+						  from_name, to_name, cifs_sb);
 		if ((rc == -EIO) || (rc == -EINVAL))
 			rc = -EOPNOTSUPP;
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index c3e28673e0cd..6cac0b107a2d 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -35,6 +35,18 @@ free_set_inf_compound(struct smb_rqst *rqst)
 		SMB2_close_free(&rqst[2]);
 }
 
+static inline __u32 file_create_options(struct dentry *dentry)
+{
+	struct cifsInodeInfo *ci;
+
+	if (dentry) {
+		ci = CIFS_I(d_inode(dentry));
+		if (ci->cifsAttrs & ATTR_REPARSE)
+			return OPEN_REPARSE_POINT;
+	}
+	return 0;
+}
+
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -809,15 +821,9 @@ int smb2_rename_path(const unsigned int xid,
 		     const char *from_name, const char *to_name,
 		     struct cifs_sb_info *cifs_sb)
 {
-	struct cifsInodeInfo *ci;
 	struct cifsFileInfo *cfile;
-	__u32 co = 0;
+	__u32 co = file_create_options(source_dentry);
 
-	if (source_dentry) {
-		ci = CIFS_I(d_inode(source_dentry));
-		if (ci->cifsAttrs & ATTR_REPARSE)
-			co |= OPEN_REPARSE_POINT;
-	}
 	drop_cached_dir_by_name(xid, tcon, from_name, cifs_sb);
 	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
@@ -825,13 +831,16 @@ int smb2_rename_path(const unsigned int xid,
 				  co, DELETE, SMB2_OP_RENAME, cfile);
 }
 
-int
-smb2_create_hardlink(const unsigned int xid, struct cifs_tcon *tcon,
-		     const char *from_name, const char *to_name,
-		     struct cifs_sb_info *cifs_sb)
+int smb2_create_hardlink(const unsigned int xid,
+			 struct cifs_tcon *tcon,
+			 struct dentry *source_dentry,
+			 const char *from_name, const char *to_name,
+			 struct cifs_sb_info *cifs_sb)
 {
+	__u32 co = file_create_options(source_dentry);
+
 	return smb2_set_path_attr(xid, tcon, from_name, to_name,
-				  cifs_sb, 0, FILE_READ_ATTRIBUTES,
+				  cifs_sb, co, FILE_READ_ATTRIBUTES,
 				  SMB2_OP_HARDLINK, NULL);
 }
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 7cbf1a76b42d..a8084ce7fcbd 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -85,9 +85,11 @@ int smb2_rename_path(const unsigned int xid,
 		     struct dentry *source_dentry,
 		     const char *from_name, const char *to_name,
 		     struct cifs_sb_info *cifs_sb);
-extern int smb2_create_hardlink(const unsigned int xid, struct cifs_tcon *tcon,
-				const char *from_name, const char *to_name,
-				struct cifs_sb_info *cifs_sb);
+int smb2_create_hardlink(const unsigned int xid,
+			 struct cifs_tcon *tcon,
+			 struct dentry *source_dentry,
+			 const char *from_name, const char *to_name,
+			 struct cifs_sb_info *cifs_sb);
 extern int smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			struct cifs_sb_info *cifs_sb, const unsigned char *path,
 			char *pbuf, unsigned int *pbytes_written);
-- 
2.43.0


