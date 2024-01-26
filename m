Return-Path: <linux-kernel+bounces-40574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC283E2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36FD1C23755
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372624B22;
	Fri, 26 Jan 2024 19:32:18 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123D23758;
	Fri, 26 Jan 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297537; cv=none; b=HCeiLQz7ERpD0sIOnPBu0ZWibCdFAn9UyfdjJmqwitHNk2cacpZ4yH/3DIO7GsImdlH2yseCKCYkBC5cLBcqbS2at/pXLcvnOPhxW0S5fWn/TBlj4Nfx/YGXf6nCVjwft3/06KbgHgWF4dzEdd4kEHfXyF8Y2RsSMah/Na8r47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297537; c=relaxed/simple;
	bh=mLtfa9rwa4Wd1aOztK+WeQOfWlOnVbtGjfUfZIKPPZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHPJFMNK0ueA9m5GWjTZKErkrDZ48+5l/wnj2Wln8+VQ++/nhbjY4euMVGTx0lrALAvNSVD4dTe3hNU5we5nZbuCsa7HyZYSVClZb4QcQ3jwbjTRR3hs4zxYnSwiuTo7ZJRr0qaVQYNTkVoO2Sig5/2JYTygjhESyAxCgHQ4/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 157FB2F20236; Fri, 26 Jan 2024 19:32:12 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 3EFD22F2023B;
	Fri, 26 Jan 2024 19:32:06 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: keescook@chromium.org,
	sfrench@samba.org,
	corbet@lwn.net,
	natechancellor@gmail.com,
	ndesaulniers@google.com,
	kovalev@altlinux.org,
	Paulo Alcantara <pc@cjr.nz>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with flex-arrays
Date: Fri, 26 Jan 2024 22:31:43 +0300
Message-Id: <20240126193143.245122-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240126193143.245122-1-kovalev@altlinux.org>
References: <20240126193143.245122-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

commit eb3e28c1e89b4984308777231887e41aa8a0151f upstream.

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

Replace the trailing 1-element array with a flexible array in the
following structures:

        struct smb2_err_rsp
        struct smb2_tree_connect_req
        struct smb2_negotiate_rsp
        struct smb2_sess_setup_req
        struct smb2_sess_setup_rsp
        struct smb2_read_req
        struct smb2_read_rsp
        struct smb2_write_req
        struct smb2_write_rsp
        struct smb2_query_directory_req
        struct smb2_query_directory_rsp
        struct smb2_set_info_req
        struct smb2_change_notify_rsp
        struct smb2_create_rsp
        struct smb2_query_info_req
        struct smb2_query_info_rsp

Replace the trailing 1-element array with a flexible array, but leave
the existing structure padding:

        struct smb2_file_all_info
        struct smb2_lock_req

Adjust all related size calculations to match the changes to sizeof().

No machine code output or .data section differences are produced after
these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/cifs/smb2misc.c |  2 +-
 fs/cifs/smb2ops.c  | 14 +++++++-------
 fs/cifs/smb2pdu.c  | 13 ++++++-------
 fs/cifs/smb2pdu.h  | 42 ++++++++++++++++++++++++------------------
 4 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index b98bba887f84b0..660e00eb42060a 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -117,7 +117,7 @@ static __u32 get_neg_ctxt_len(struct smb2_sync_hdr *hdr, __u32 len,
 	} else if (nc_offset + 1 == non_ctxlen) {
 		cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
 		size_of_pad_before_neg_ctxts = 0;
-	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE)
+	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE + 1)
 		/* has padding, but no SPNEGO blob */
 		size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen + 1;
 	else
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 26edaeb4245d8c..84850a55c8b7e7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5561,7 +5561,7 @@ struct smb_version_values smb20_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5583,7 +5583,7 @@ struct smb_version_values smb21_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5604,7 +5604,7 @@ struct smb_version_values smb3any_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5625,7 +5625,7 @@ struct smb_version_values smbdefault_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5646,7 +5646,7 @@ struct smb_version_values smb30_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5667,7 +5667,7 @@ struct smb_version_values smb302_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5688,7 +5688,7 @@ struct smb_version_values smb311_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 76679dc4e63288..4aec01841f0f26 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1261,7 +1261,7 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
 	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req) - 1 /* pad */);
+		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
 	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
@@ -1760,8 +1760,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	iov[0].iov_len = total_len - 1;
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req)
-			- 1 /* pad */);
+	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
 	req->PathLength = cpu_to_le16(unc_path_len - 2);
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
@@ -4676,7 +4675,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	memcpy(bufptr, &asteriks, len);
 
 	req->FileNameOffset =
-		cpu_to_le16(sizeof(struct smb2_query_directory_req) - 1);
+		cpu_to_le16(sizeof(struct smb2_query_directory_req));
 	req->FileNameLength = cpu_to_le16(len);
 	/*
 	 * BB could be 30 bytes or so longer if we used SMB2 specific
@@ -4873,7 +4872,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->AdditionalInformation = cpu_to_le32(additional_info);
 
 	req->BufferOffset =
-			cpu_to_le16(sizeof(struct smb2_set_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_set_info_req));
 	req->BufferLength = cpu_to_le32(*size);
 
 	memcpy(req->Buffer, *data, *size);
@@ -5105,9 +5104,9 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	req->VolatileFileId = volatile_fid;
 	/* 1 for pad */
 	req->InputBufferOffset =
-			cpu_to_le16(sizeof(struct smb2_query_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_query_info_req));
 	req->OutputBufferLength = cpu_to_le32(
-		outbuf_len + sizeof(struct smb2_query_info_rsp) - 1);
+		outbuf_len + sizeof(struct smb2_query_info_rsp));
 
 	iov->iov_base = (char *)req;
 	iov->iov_len = total_len;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 89a732b31390ea..eaa873175318a0 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -220,7 +220,7 @@ struct smb2_err_rsp {
 	__le16 StructureSize;
 	__le16 Reserved; /* MBZ */
 	__le32 ByteCount;  /* even if zero, at least one byte follows */
-	__u8   ErrorData[1];  /* variable length */
+	__u8   ErrorData[];  /* variable length */
 } __packed;
 
 #define SYMLINK_ERROR_TAG 0x4c4d5953
@@ -464,7 +464,7 @@ struct smb2_negotiate_rsp {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Flags */
@@ -481,7 +481,7 @@ struct smb2_sess_setup_req {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__u64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Currently defined SessionFlags */
@@ -494,7 +494,7 @@ struct smb2_sess_setup_rsp {
 	__le16 SessionFlags;
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 struct smb2_logoff_req {
@@ -520,7 +520,7 @@ struct smb2_tree_connect_req {
 	__le16 Flags; /* Reserved MBZ for dialects prior to SMB3.1.1 */
 	__le16 PathOffset;
 	__le16 PathLength;
-	__u8   Buffer[1];	/* variable length */
+	__u8   Buffer[];	/* variable length */
 } __packed;
 
 /* See MS-SMB2 section 2.2.9.2 */
@@ -828,7 +828,7 @@ struct smb2_create_rsp {
 	__u64  VolatileFileId; /* opaque endianness */
 	__le32 CreateContextsOffset;
 	__le32 CreateContextsLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct create_context {
@@ -1289,7 +1289,7 @@ struct smb2_read_plain_req {
 	__le32 RemainingBytes;
 	__le16 ReadChannelInfoOffset;
 	__le16 ReadChannelInfoLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Read flags */
@@ -1304,7 +1304,7 @@ struct smb2_read_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* For write request Flags field below the following flags are defined: */
@@ -1324,7 +1324,7 @@ struct smb2_write_req {
 	__le16 WriteChannelInfoOffset;
 	__le16 WriteChannelInfoLength;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_write_rsp {
@@ -1335,7 +1335,7 @@ struct smb2_write_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Reserved2;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* notify flags */
@@ -1371,7 +1371,7 @@ struct smb2_change_notify_rsp {
 	__le16	StructureSize;  /* Must be 9 */
 	__le16	OutputBufferOffset;
 	__le32	OutputBufferLength;
-	__u8	Buffer[1]; /* array of file notify structs */
+	__u8	Buffer[]; /* array of file notify structs */
 } __packed;
 
 #define SMB2_LOCKFLAG_SHARED_LOCK	0x0001
@@ -1394,7 +1394,10 @@ struct smb2_lock_req {
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
 	/* Followed by at least one */
-	struct smb2_lock_element locks[1];
+	union {
+		struct smb2_lock_element lock;
+		DECLARE_FLEX_ARRAY(struct smb2_lock_element, locks);
+	};
 } __packed;
 
 struct smb2_lock_rsp {
@@ -1434,7 +1437,7 @@ struct smb2_query_directory_req {
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_directory_rsp {
@@ -1442,7 +1445,7 @@ struct smb2_query_directory_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Possible InfoType values */
@@ -1483,7 +1486,7 @@ struct smb2_query_info_req {
 	__le32 Flags;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_info_rsp {
@@ -1491,7 +1494,7 @@ struct smb2_query_info_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /*
@@ -1514,7 +1517,7 @@ struct smb2_set_info_req {
 	__le32 AdditionalInformation;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_set_info_rsp {
@@ -1716,7 +1719,10 @@ struct smb2_file_all_info { /* data block encoding of response to level 18 */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char   FileName[1];
+	union {
+		char __pad;     /* Legacy structure padding */
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __packed; /* level 18 Query */
 
 struct smb2_file_eof_info { /* encoding of request for level 10 */
-- 
2.33.8


