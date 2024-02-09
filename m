Return-Path: <linux-kernel+bounces-59346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C784F5A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C21C2211C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815D381A4;
	Fri,  9 Feb 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TISZ/GRi"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855173838B;
	Fri,  9 Feb 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484598; cv=none; b=Vyck/SzA6NzYLz5ooZuNsVllsf3mvxOE43j5qHuYABOLDYiUKY2V/K8HHywjj2LGohxye5D1fNnxfYSSJ0lMae1Ou9Le3hYUreu+8uDdLahyKWefQ2lRUqVqoMJ1ycarsQC4DgEhctSqy8hyJv9VWqbZ0ed3oou8KZHwEI5mOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484598; c=relaxed/simple;
	bh=mlbyP/hGrhAG5lydCe0HnnMzTUIJQkv1pUt80jvevLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UILGNpApNuz0iPrIpnGJ6iBIP0mFelSA4fGqkHRTm7MLN4c5d4daHzAtgbeKtFP8tzR6Pgxblcv2pCcoSTS2GmGEamIKcw/opioXuOUBJvLFsQrkiLEjBP5ra9FHcv9vz9BeRWRRpMkVR6y3jP9raz05l4j7ICUV1KfS14w2H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TISZ/GRi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8df34835aso736966a12.0;
        Fri, 09 Feb 2024 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707484596; x=1708089396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ERbNxLdk3eu5PTJj3FXF/TXouUoeq2Q9p3QCLY8PJA=;
        b=TISZ/GRiAhnk7mVdPaD1w/oaZEP64WoKOhqg8FVRJIb1vZYpbn3MZbK/H7FGMNnn52
         CkDtvrTV8T6BHX56kCbRHcT0RXjfA6pI0ntHpV7rxovWuJlL0j27OPmt/fOuoxgDqTqv
         quyP5wcclnvdb4kQQa8E9nIrSf+d17gLnGg4U9bUwIL61hRRcxCcDf82f24OfDwvasBi
         bTV9wtiXowwMOYFZvrprf6BVlZFtLhB5NT4Q1o/X92wWVmcLTeUL9gNzy3XWlV5ApRwr
         GohvLFdyZ9nHCn6zCCGldxitzWvsJYd4zu/2/liSVmKxubvZ2BpdVC113IwfERB/o49Q
         3a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484596; x=1708089396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ERbNxLdk3eu5PTJj3FXF/TXouUoeq2Q9p3QCLY8PJA=;
        b=McIIrw1fMQmGHn7q58vrttgIYIRCpGtg2/hWy0zg+McggTs6mE+glhngpTYW19zdqu
         AFNpSGpwPy9FCbCzIVNvS6ltWJDH3lfhRrHzIu/Uzs9JEUD4NFgXUfAKNNeTHE7rCYzC
         Tp2QORTrSAX5NToUPNY0JGwr05h9gaZFxyFKj8H74sbRh5DJlK3IJKBTfPbzF8muHskg
         QYeQlF1XT2DGQGUhTMFeXODVrzdHl+R1bREuj5GBZ8Agk5Sx39/De6JamxRTdG7zS3nR
         Yxjv9u6YemLKbZBlMcwM9h32/mVtX03/rTDWEhYjqp0D76NXW7uTxO8NI1rbgMr0Behb
         /Sfg==
X-Forwarded-Encrypted: i=1; AJvYcCV2/UTu27uG4h30SDZW40JRfik1E3Wizo0E/xLI45upm0Ykg+MKyYmYDgCCIMsqxESQKQm8moiFJp3685pUsfYXZtxfRTJotHu+5yzN/3uc1tgR5uV50Wzz6OtR5yK7j+8Vkom7YR3tWA==
X-Gm-Message-State: AOJu0YwqGhK65vdio3RD93Wa0XcNeTa0hqWqyZjMu5eULR/Nksq8DELL
	kxpl+UDwKuqcK9/oHMheGzrJypx9eeM6YjBEHcDSk4FuoPph2CrSKPaOOs9sITU=
X-Google-Smtp-Source: AGHT+IE8WtpaDlyspsHyczZ4PLUpUSajf6lqBHC8xJ1yXD8k8myRj54gcfatidtponY4sTE6jj9Aew==
X-Received: by 2002:a17:90a:b398:b0:296:2865:cc17 with SMTP id e24-20020a17090ab39800b002962865cc17mr1341223pjr.20.1707484595676;
        Fri, 09 Feb 2024 05:16:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUBIZoE+grvZG15GctK26AFrv37nxN1XJ6ZUX1OoKjmwYsl8FKR8wL54vmuaqk67eszK3Id+OUsE3XICeJoJnr93dN+tSg2rjvplGn7xxwURzShARLeBAzpEFpr+QNFx5Y+GcsOom5gIDl5SABJ2Hv2nDffeBiXbk3DxAO3loJHhMSDUfYfpAU+a/qokRKUZ5WEYj63fdcAOXIwJ+2guz8k5w1kAkRxOpU+iOEp7j0uNARccD+F0nirR0HiQmcZA8q0xkQj418O9GHcOuzhrnQwIGgUMb+Ch6gtA8aRDvDrJ9HIOWmt/D/9eIsJuzvr8/lmb0Lt+h0EF35A2LHiF2AvikyxE5HTxTvQpHHgA==
Received: from met-Virtual-Machine.. ([131.107.1.159])
        by smtp.gmail.com with ESMTPSA id sk12-20020a17090b2dcc00b00296540086a5sm1713246pjb.23.2024.02.09.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:16:35 -0800 (PST)
From: meetakshisetiyaoss@gmail.com
To: sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	nspmangalore@gmail.com,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	samba-technical@lists.samba.org,
	bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Subject: [PATCH 2/3] smb: client: reuse file lease key in compound operations
Date: Fri,  9 Feb 2024 08:15:51 -0500
Message-Id: <20240209131552.471765-2-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

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
---
 fs/smb/client/cifsglob.h  |  5 ++--
 fs/smb/client/cifsproto.h |  6 +++--
 fs/smb/client/cifssmb.c   |  4 ++--
 fs/smb/client/inode.c     | 10 ++++----
 fs/smb/client/smb2inode.c | 48 ++++++++++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  6 +++--
 6 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index f6b4acdcdeb3..baeed01d356b 100644
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
index f995b766b177..e108964950b5 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -406,7 +406,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned int xid,
 				     __u32 pid_of_opener);
 extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 			 const char *file_name, __u64 size,
-			 struct cifs_sb_info *cifs_sb, bool set_allocation);
+			 struct cifs_sb_info *cifs_sb, bool set_allocation,
+			 struct dentry *dentry);
 extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
 			      struct cifsFileInfo *cfile, __u64 size,
 			      bool set_allocation);
@@ -442,7 +443,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
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
index 01e89070df5a..301189ee1335 100644
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
index 8121b5b1aa22..c3e86876a2a8 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1846,7 +1846,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 		goto psx_del_no_retry;
 	}
 
-	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb);
+	rc = server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry);
 
 psx_del_no_retry:
 	if (!rc) {
@@ -2799,7 +2799,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 
 static int
 cifs_set_file_size(struct inode *inode, struct iattr *attrs,
-		   unsigned int xid, const char *full_path)
+		   unsigned int xid, const char *full_path, struct dentry *dentry)
 {
 	int rc;
 	struct cifsFileInfo *open_file;
@@ -2850,7 +2850,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 	 */
 	if (server->ops->set_path_size)
 		rc = server->ops->set_path_size(xid, tcon, full_path,
-						attrs->ia_size, cifs_sb, false);
+						attrs->ia_size, cifs_sb, false, dentry);
 	else
 		rc = -ENOSYS;
 	cifs_dbg(FYI, "SetEOF by path (setattrs) rc = %d\n", rc);
@@ -2940,7 +2940,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto out;
 	}
@@ -3107,7 +3107,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
-		rc = cifs_set_file_size(inode, attrs, xid, full_path);
+		rc = cifs_set_file_size(inode, attrs, xid, full_path, direntry);
 		if (rc != 0)
 			goto cifs_setattr_exit;
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 05818cd6d932..69f3442c5b96 100644
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
index b3069911e9dd..221143788a1c 100644
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
2.39.2


