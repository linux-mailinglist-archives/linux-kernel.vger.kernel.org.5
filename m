Return-Path: <linux-kernel+bounces-13887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD882143F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2081C20AC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46463A0;
	Mon,  1 Jan 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDYB2RLv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC996116
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704123616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vpYEb5NUo3+0mHNYFGx+DgCH2sY1ty8dlaAO2JnSpSY=;
	b=JDYB2RLvmx9LTYJfZViHfpCjIQOQlzrQ9d5TkE43spZPbTSXiU1k6MH0uQkQ1jtryG5PxM
	2YfGPywhH18FzJfFV9nqB0p3mi4LajEa8jLdpeicVnBl5RdpvheXVV1icdWWyT03NC/Lv5
	lz0beECkI4RK6mjkyIem5jsdVbBVJoU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-uZLyIOXJNRe0C_ZRW-PUtA-1; Mon,
 01 Jan 2024 10:40:13 -0500
X-MC-Unique: uZLyIOXJNRe0C_ZRW-PUtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E03431C04B41;
	Mon,  1 Jan 2024 15:40:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C42151D5;
	Mon,  1 Jan 2024 15:40:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Pass unbyteswapped eof value into SMB2_set_eof()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3349331.1704123610.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jan 2024 15:40:10 +0000
Message-ID: <3349332.1704123610@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Steve,

How about something like the attached?

David
---
cifs: Pass unbyteswapped eof value into SMB2_set_eof()

Change SMB2_set_eof() to take eof as CPU order rather than __le64 and pass
it directly rather than by pointer.  This moves the conversion down into
SMB_set_eof() rather than all of its callers and means we don't need to
undo it for the traceline.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/smb2ops.c   |   37 ++++++++++++++++---------------------
 fs/smb/client/smb2pdu.c   |    6 +++---
 fs/smb/client/smb2proto.h |    2 +-
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 66b310208545..82de0e205607 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1923,7 +1923,6 @@ static int
 smb2_set_file_size(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifsFileInfo *cfile, __u64 size, bool set_alloc)
 {
-	__le64 eof =3D cpu_to_le64(size);
 	struct inode *inode;
 =

 	/*
@@ -1940,7 +1939,7 @@ smb2_set_file_size(const unsigned int xid, struct ci=
fs_tcon *tcon,
 	}
 =

 	return SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
-			    cfile->fid.volatile_fid, cfile->pid, &eof);
+			    cfile->fid.volatile_fid, cfile->pid, size);
 }
 =

 static int
@@ -3324,7 +3323,6 @@ static long smb3_zero_range(struct file *file, struc=
t cifs_tcon *tcon,
 	unsigned long long new_size;
 	long rc;
 	unsigned int xid;
-	__le64 eof;
 =

 	xid =3D get_xid();
 =

@@ -3354,9 +3352,8 @@ static long smb3_zero_range(struct file *file, struc=
t cifs_tcon *tcon,
 	 */
 	new_size =3D offset + len;
 	if (keep_size =3D=3D false && (unsigned long long)i_size_read(inode) < n=
ew_size) {
-		eof =3D cpu_to_le64(new_size);
 		rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
-				  cfile->fid.volatile_fid, cfile->pid, &eof);
+				  cfile->fid.volatile_fid, cfile->pid, new_size);
 		if (rc >=3D 0) {
 			truncate_setsize(inode, new_size);
 			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
@@ -3549,7 +3546,7 @@ static long smb3_simple_falloc(struct file *file, st=
ruct cifs_tcon *tcon,
 	struct cifsFileInfo *cfile =3D file->private_data;
 	long rc =3D -EOPNOTSUPP;
 	unsigned int xid;
-	__le64 eof;
+	loff_t new_eof;
 =

 	xid =3D get_xid();
 =

@@ -3578,14 +3575,14 @@ static long smb3_simple_falloc(struct file *file, =
struct cifs_tcon *tcon,
 		if (cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE)
 			smb2_set_sparse(xid, tcon, cfile, inode, false);
 =

-		eof =3D cpu_to_le64(off + len);
+		new_eof =3D off + len;
 		rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
-				  cfile->fid.volatile_fid, cfile->pid, &eof);
+				  cfile->fid.volatile_fid, cfile->pid, new_eof);
 		if (rc =3D=3D 0) {
-			cifsi->server_eof =3D off + len;
-			cifs_setsize(inode, off + len);
+			cifsi->server_eof =3D new_eof;
+			cifs_setsize(inode, new_eof);
 			cifs_truncate_page(inode->i_mapping, inode->i_size);
-			truncate_setsize(inode, off + len);
+			truncate_setsize(inode, new_eof);
 		}
 		goto out;
 	}
@@ -3676,8 +3673,7 @@ static long smb3_collapse_range(struct file *file, s=
truct cifs_tcon *tcon,
 	struct inode *inode =3D file_inode(file);
 	struct cifsFileInfo *cfile =3D file->private_data;
 	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
-	__le64 eof;
-	loff_t old_eof;
+	loff_t old_eof, new_eof;
 =

 	xid =3D get_xid();
 =

@@ -3702,9 +3698,9 @@ static long smb3_collapse_range(struct file *file, s=
truct cifs_tcon *tcon,
 	if (rc < 0)
 		goto out_2;
 =

-	eof =3D cpu_to_le64(old_eof - len);
+	new_eof =3D old_eof - len;
 	rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
-			  cfile->fid.volatile_fid, cfile->pid, &eof);
+			  cfile->fid.volatile_fid, cfile->pid, new_eof);
 	if (rc < 0)
 		goto out_2;
 =

@@ -3728,8 +3724,7 @@ static long smb3_insert_range(struct file *file, str=
uct cifs_tcon *tcon,
 	unsigned int xid;
 	struct cifsFileInfo *cfile =3D file->private_data;
 	struct inode *inode =3D file_inode(file);
-	__le64 eof;
-	__u64  count, old_eof;
+	__u64 count, old_eof, new_eof;
 =

 	xid =3D get_xid();
 =

@@ -3742,20 +3737,20 @@ static long smb3_insert_range(struct file *file, s=
truct cifs_tcon *tcon,
 	}
 =

 	count =3D old_eof - off;
-	eof =3D cpu_to_le64(old_eof + len);
+	new_eof =3D old_eof + len;
 =

 	filemap_invalidate_lock(inode->i_mapping);
-	rc =3D filemap_write_and_wait_range(inode->i_mapping, off, old_eof + len=
 - 1);
+	rc =3D filemap_write_and_wait_range(inode->i_mapping, off, new_eof - 1);
 	if (rc < 0)
 		goto out_2;
 	truncate_pagecache_range(inode, off, old_eof);
 =

 	rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
-			  cfile->fid.volatile_fid, cfile->pid, &eof);
+			  cfile->fid.volatile_fid, cfile->pid, new_eof);
 	if (rc < 0)
 		goto out_2;
 =

-	truncate_setsize(inode, old_eof + len);
+	truncate_setsize(inode, new_eof);
 	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
 =

 	rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4f971c1061f0..bd25c34dc398 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5347,18 +5347,18 @@ send_set_info(const unsigned int xid, struct cifs_=
tcon *tcon,
 =

 int
 SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon, u64 persiste=
nt_fid,
-	     u64 volatile_fid, u32 pid, __le64 *eof)
+	     u64 volatile_fid, u32 pid, loff_t new_eof)
 {
 	struct smb2_file_eof_info info;
 	void *data;
 	unsigned int size;
 =

-	info.EndOfFile =3D *eof;
+	info.EndOfFile =3D cpu_to_le64(new_eof);
 =

 	data =3D &info;
 	size =3D sizeof(struct smb2_file_eof_info);
 =

-	trace_smb3_set_eof(xid, persistent_fid, tcon->tid, tcon->ses->Suid, le64=
_to_cpu(*eof));
+	trace_smb3_set_eof(xid, persistent_fid, tcon->tid, tcon->ses->Suid, new_=
eof);
 =

 	return send_set_info(xid, tcon, persistent_fid, volatile_fid,
 			pid, FILE_END_OF_FILE_INFORMATION, SMB2_O_INFO_FILE,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 0e371f7e2854..95e5ca69fdf3 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -205,7 +205,7 @@ extern int SMB2_query_directory_init(unsigned int xid,=
 struct cifs_tcon *tcon,
 extern void SMB2_query_directory_free(struct smb_rqst *rqst);
 extern int SMB2_set_eof(const unsigned int xid, struct cifs_tcon *tcon,
 			u64 persistent_fid, u64 volatile_fid, u32 pid,
-			__le64 *eof);
+			loff_t new_eof);
 extern int SMB2_set_info_init(struct cifs_tcon *tcon,
 			      struct TCP_Server_Info *server,
 			      struct smb_rqst *rqst,


