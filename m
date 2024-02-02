Return-Path: <linux-kernel+bounces-50201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE238475B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340131F2D08E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC77414A089;
	Fri,  2 Feb 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krh/ceDN"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046B148FFA;
	Fri,  2 Feb 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893545; cv=none; b=JNuu6Fl5tAkCii+Bg7TdMWKGknp8eZrNoddJAaAcUkUa8pjrNhVQBeW6Nx06EruNoEpbD72wOZcIbQDszJsKJlhV46e+Xy+mxvkT8QXT2F04OIG0idZlzNyVFdX/MUU9yB793aZ/ZfVFzjxYrEnxPlo7U6bJIYrD0222A8CTVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893545; c=relaxed/simple;
	bh=1hIL4mSTKJT+AAr8pT4RzEea879USXO5oUMnigC+ImY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=e6YX55fZp+vmQgJPLPxIsOuvCNzeFwnDhGogEDpu/H1/Q28i6kwU3Ece3ge64Bjl9p012awY5RltDOK24hen8Q/UcvchfnLaJ6L12pk0Kt4l9KZhoeb5S9RovYORhKeu2BVCAHC2jNr8Fk1EPrtc3AX5/skQ7fF/ZfFQ0PjjKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krh/ceDN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de3141f041so1747788b3a.0;
        Fri, 02 Feb 2024 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893543; x=1707498343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga4spIWUqD57gB8XeACdHXH06LV4IwcDijbO8q+HZ8A=;
        b=krh/ceDNsR95XjxO1cHeo5qhyRK/NTQkYbSujF7jyPgsGUyw2H4qNnIT3PMHhMqcBc
         T5Xw+S5oxQl+eVAc+BugXNrxEyNGi3zdJkIi2TcH0uymbSib4y9oN5H3AMQKgIw2CVWo
         qvX942nzK4wLfnutKX68/EV2kduXJumhCe1My/uh83ynnxMr5PqFAxoFSG/MUCoCol6v
         XJONWcNapOm/bl+p9Stfjcj7tNXMMq8nc3DUvnJESdVqnbjLTV3SXAJ0bhZH0OpSkGBZ
         XEFt1mHhlOTFuISIzd/5OA4V0exYEWy1QPoNTRI6wm+jEuOMQlQIVb+i1aNB6PoESZCj
         aE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893543; x=1707498343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga4spIWUqD57gB8XeACdHXH06LV4IwcDijbO8q+HZ8A=;
        b=V9TqvKjpqmT6tMu5EintqOhGxMAYmNRzW9X4PCjlu3PPNZbYNT56VU1cxdfQo8dXBD
         FrfcKKbTmW+8Z0eqjBCAjRbiDRmZli0YZQH/nEwePbzGNlkMYOJY8gyNurhIfwmpywyO
         WzhHUmh9Ca3ZC9fW+epkEpyLPDzToI61bhmJR5F/BbpDmpPljyTSfqS9FQH0KsjpTBox
         vrvZtS65vDh1+Y0lO8APcQrJ/iAtkjjC/uMY+iqnlXdYKEzd1NtN/MawxcQnO26tmOCr
         MDEdqWI/DBkt6BMjhxWJ3t9pK64If2N3qbGTve+HqQr+MTlT+FU6evbfMLjHRCSutf8h
         r6DQ==
X-Gm-Message-State: AOJu0YxmW/GkjES3Maf0ne+gtHk8UoF3vUTQYpQf4Ke7rDFeKg6ki/pP
	4kNI4dO8HPzws4Fq5XtKVxlkNUdLn1GT7sGOul8DQPrxRPWTJ97GNzJRxVasQ+8=
X-Google-Smtp-Source: AGHT+IH8im4e7S3C8x3jYvknu3fpU+0nl4Jx8Hr0aMRWeyc7OiJnhhk7XfQwu+c2MHsX3XVxvoWR8w==
X-Received: by 2002:a62:a50f:0:b0:6dc:7794:62c with SMTP id v15-20020a62a50f000000b006dc7794062cmr5401412pfm.13.1706893542943;
        Fri, 02 Feb 2024 09:05:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUeXMDnNYAXZyhX9pMmqNqUoi3+O4EYvzT3IjjurCUKr9x9lbLcU9FAx5S7rww9rLjjxw3GboGg4NPSbMZRJD40OBTTtQuAXGHhPvURgvGN9TyZRdSLrQ9ndfA36DOJvdjFeEDwyFL85YiTkxNAJhwROZMrGwKeiizDImlBnbgiD++TEat4LkJQjDjlkAFBmNORgFiKIbDiK0gxu/Rf8g7hEa2lyZU/asNZ5w3TtS/Vnwnn9558Zj6XYq/8ZG8oN/ClwuVXPneDtug+TP9T6Bhmw+OsWQcJn5BJ7yWyCt4chwgI4xjuZZYWnORGU2ed+UAZiqAPYJWkvvJDKHS9eclidCwfNR3SYDJ0HIaAknjvdFRFPAX8pQcIyyC60Qs1yQMWKLT
Received: from met-Virtual-Machine.. ([131.107.174.31])
        by smtp.gmail.com with ESMTPSA id r4-20020aa78b84000000b006dbc4cb72ebsm1857490pfd.201.2024.02.02.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:05:42 -0800 (PST)
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
	bharathsm.hsk@gmail.com,
	msetiya@microsoft.com
Subject: [PATCH] smb: client: do not defer close open handles to deleted files
Date: Fri,  2 Feb 2024 12:05:37 -0500
Message-Id: <20240202170537.409508-1-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meetakshi Setiya <msetiya@microsoft.com>

When a file/dentry has been deleted before closing all its open
handles, currently, closing them can add them to the deferred close
list. This can lead to problems in creating file with the same name
when the file is re-created before the deferred close completes. This
issue was seen while reusing a client's already existing lease on a
file for compound operations and xfstest 591 failed because of the
deferred close handle that remained valid even after the file was
deleted and was being reused to create a file with the same name. The
server in this case returns an error on open with
STATUS_DELETE_PENDING. Recreating the file would fail till the
deferred handles are closed (duration specified in closetimeo).

This patch fixes the issue by flagging all open handles for the
deleted file (file path to be precise) with FILE_DELETED at the end
of the unlink operation. When doing close in cifs_close for each of
these handles, check the flag and do not defer close these handles if
the corresponding filepath has been deleted.

Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/smb/client/cifsglob.h  |  1 +
 fs/smb/client/cifsproto.h |  4 ++++
 fs/smb/client/file.c      |  2 +-
 fs/smb/client/inode.c     |  2 ++
 fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index decf80131bbe..826da216a9e1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1399,6 +1399,7 @@ struct cifs_fid_locks {
 	struct list_head locks;		/* locks held by fid above */
 };
 
+#define FILE_DELETED	0x550
 struct cifsFileInfo {
 	/* following two lists are protected by tcon->open_file_lock */
 	struct list_head tlist;	/* pointer to next fid owned by tcon */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 770db9026850..67f75497db02 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -292,6 +292,10 @@ extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
 
 extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
 				const char *path);
+
+extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
+				*cifs_tcon, const char *path);
+
 extern struct TCP_Server_Info *
 cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b75282c204da..4c87ddbe8a5a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
 		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
-		    dclose) {
+		    dclose && !(cfile->f_flags & FILE_DELETED)) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 24489e1e238a..be5bc01319d8 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1822,6 +1822,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
+	if (rc == 0)
+		cifs_mark_open_handles_for_deleted_file(tcon, full_path);
 	free_dentry_path(page);
 	kfree(attrs);
 	free_xid(xid);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 0748d7b757b9..ebc867bfc034 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 	free_dentry_path(page);
 }
 
+/*
+ * If a dentry has been deleted, all corresponding open handles should know the
+ * same, so that we do not defer close them.
+ */
+void
+cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon, const char
+*path)
+{
+	struct cifsFileInfo *cfile;
+	void *page;
+	const char *full_path;
+
+	page = alloc_dentry_path();
+	spin_lock(&tcon->open_file_lock);
+	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
+		full_path = build_path_from_dentry(cfile->dentry, page);
+		if (strcmp(full_path, path) == 0)
+			cfile->f_flags |= FILE_DELETED;
+	}
+	spin_unlock(&tcon->open_file_lock);
+}
+
 /* parses DFS referral V3 structure
  * caller is responsible for freeing target_nodes
  * returns:
-- 
2.39.2


