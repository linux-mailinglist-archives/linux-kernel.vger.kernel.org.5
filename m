Return-Path: <linux-kernel+bounces-140909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F38A198D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E21D1C23F60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710016D9D4;
	Thu, 11 Apr 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIvBX9cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC851649D3;
	Thu, 11 Apr 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849746; cv=none; b=cLsOanCzh+gc9KR8k2YL+AToBqsLrutxw5vErkzj5ACYeNMnpOWidDHJQE9GvH5nz86XaoJ9VmOAevw41N5n1Mte8O+//KH3fdu3URMggjj4TWltb9HrpOYwLvrVSa8pEcn6oC4sWJU9I3mLh+oqNeHAV+Ts7paqyJrw9iQEXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849746; c=relaxed/simple;
	bh=BkVLzO5ab9hdqdrtlid2lBANXaXcdaYaXGzsDD/ESxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hCO1X9NHk7cpu6kyXx4o5UOLQWaFSrxmZ6eUVd0iwAyn6BDn2d/PMuKBubJ4FB/AVJ3KSFtq14anxxkd6pxZZnAdZfR2DmXYwET7vbISvkZkZ3qm2hJYM4Vx1A/lHQXLDKETz7uY8YVU6C6/y9RR0z4L78H0HdqP4gTMm8gmCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIvBX9cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BAAC072AA;
	Thu, 11 Apr 2024 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849745;
	bh=BkVLzO5ab9hdqdrtlid2lBANXaXcdaYaXGzsDD/ESxY=;
	h=Date:From:To:Cc:Subject:From;
	b=DIvBX9czkfrLh7m/HK/UjJH61NULoTIeAeWLYc5bn9LpZvbCmboTIDNHxNheNzwlo
	 AssMoufN2ujwMpdkzLmYIHYeAf78UGopCO9csScJvxvKy0DGvtwEyQbzIAvvPX4PIz
	 fmLw4ioeRL3p/lq4SIKjZoQ1Oeep9Ksa/wsFpft5jNPSusA9y0e/gGTdeeDrAzY96s
	 7y+N5frso/yEJQre3G6QiYydrzDeapMo+2PNQ3LapJ4sHpc4mYVCWjJXd5cpmClc9e
	 XO3TOmJLoX74helwu+LHdvu9aWOlTy5PLWahVY4xQE9/ycefb7sMlowdyH5YOFrDpQ
	 /mRNM5U/8JOqw==
Date: Thu, 11 Apr 2024 09:35:42 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] smb: smb2pdu.h: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZhgDTj1nwLEtSd9h@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()` helper
to separate the flexible array from the rest of the members in the
flexible structure, and use the tagged `struct create_context_hdr`
instead of `struct create_context`.

So, with these changes, fix 51 of the following warnings[1]:

fs/smb/client/../common/smb2pdu.h:1225:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://gist.github.com/GustavoARSilva/772526a39be3dd4db39e71497f0a9893 [1]
Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/smb/client/smb2pdu.h | 12 ++++++------
 fs/smb/common/smb2pdu.h | 33 ++++++++++++++++++---------------
 fs/smb/server/smb2pdu.h | 18 +++++++++---------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index c72a3b2886b7..1a02bd9e0c00 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -145,7 +145,7 @@ struct durable_context_v2 {
 } __packed;
 
 struct create_durable_v2 {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct durable_context_v2 dcontext;
 } __packed;
@@ -167,7 +167,7 @@ struct durable_reconnect_context_v2_rsp {
 } __packed;
 
 struct create_durable_handle_reconnect_v2 {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct durable_reconnect_context_v2 dcontext;
 	__u8   Pad[4];
@@ -175,7 +175,7 @@ struct create_durable_handle_reconnect_v2 {
 
 /* See MS-SMB2 2.2.13.2.5 */
 struct crt_twarp_ctxt {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8	Name[8];
 	__le64	Timestamp;
 
@@ -183,12 +183,12 @@ struct crt_twarp_ctxt {
 
 /* See MS-SMB2 2.2.13.2.9 */
 struct crt_query_id_ctxt {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8	Name[8];
 } __packed;
 
 struct crt_sd_ctxt {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8	Name[8];
 	struct smb3_sd sd;
 } __packed;
@@ -415,7 +415,7 @@ struct smb2_posix_info_parsed {
 };
 
 struct smb2_create_ea_ctx {
-	struct create_context ctx;
+	struct create_context_hdr ctx;
 	__u8 name[8];
 	struct smb2_file_full_ea_info ea;
 } __packed;
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 1b594307c9d5..eab9d49c63ba 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1171,12 +1171,15 @@ struct smb2_server_client_notification {
 #define SMB2_CREATE_FLAG_REPARSEPOINT 0x01
 
 struct create_context {
-	__le32 Next;
-	__le16 NameOffset;
-	__le16 NameLength;
-	__le16 Reserved;
-	__le16 DataOffset;
-	__le32 DataLength;
+	/* New members must be added within the struct_group() macro below. */
+	__struct_group(create_context_hdr, hdr, __packed,
+		__le32 Next;
+		__le16 NameOffset;
+		__le16 NameLength;
+		__le16 Reserved;
+		__le16 DataOffset;
+		__le32 DataLength;
+	);
 	__u8 Buffer[];
 } __packed;
 
@@ -1222,7 +1225,7 @@ struct smb2_create_rsp {
 } __packed;
 
 struct create_posix {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8    Name[16];
 	__le32  Mode;
 	__u32   Reserved;
@@ -1230,7 +1233,7 @@ struct create_posix {
 
 /* See MS-SMB2 2.2.13.2.3 and MS-SMB2 2.2.13.2.4 */
 struct create_durable {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	union {
 		__u8  Reserved[16];
@@ -1243,14 +1246,14 @@ struct create_durable {
 
 /* See MS-SMB2 2.2.13.2.5 */
 struct create_mxac_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le64 Timestamp;
 } __packed;
 
 /* See MS-SMB2 2.2.14.2.5 */
 struct create_mxac_rsp {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le32 QueryStatus;
 	__le32 MaximalAccess;
@@ -1286,13 +1289,13 @@ struct lease_context_v2 {
 } __packed;
 
 struct create_lease {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct lease_context lcontext;
 } __packed;
 
 struct create_lease_v2 {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct lease_context_v2 lcontext;
 	__u8   Pad[4];
@@ -1300,7 +1303,7 @@ struct create_lease_v2 {
 
 /* See MS-SMB2 2.2.14.2.9 */
 struct create_disk_id_rsp {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le64 DiskFileId;
 	__le64 VolumeId;
@@ -1309,7 +1312,7 @@ struct create_disk_id_rsp {
 
 /* See MS-SMB2 2.2.13.2.13 */
 struct create_app_inst_id {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8 Name[16];
 	__le32 StructureSize; /* Must be 20 */
 	__u16 Reserved;
@@ -1318,7 +1321,7 @@ struct create_app_inst_id {
 
 /* See MS-SMB2 2.2.13.2.15 */
 struct create_app_inst_id_vers {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8 Name[16];
 	__le32 StructureSize; /* Must be 24 */
 	__u16 Reserved;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index bd1d2a0e9203..643f5e1cfe35 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -64,7 +64,7 @@ struct preauth_integrity_info {
 #define SMB2_SESSION_TIMEOUT		(10 * HZ)
 
 struct create_durable_req_v2 {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le32 Timeout;
 	__le32 Flags;
@@ -73,7 +73,7 @@ struct create_durable_req_v2 {
 } __packed;
 
 struct create_durable_reconn_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	union {
 		__u8  Reserved[16];
@@ -85,7 +85,7 @@ struct create_durable_reconn_req {
 } __packed;
 
 struct create_durable_reconn_v2_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct {
 		__u64 PersistentFileId;
@@ -96,13 +96,13 @@ struct create_durable_reconn_v2_req {
 } __packed;
 
 struct create_alloc_size_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le64 AllocationSize;
 } __packed;
 
 struct create_durable_rsp {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	union {
 		__u8  Reserved[8];
@@ -114,7 +114,7 @@ struct create_durable_rsp {
 /* Flags */
 #define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
 struct create_durable_v2_rsp {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	__le32 Timeout;
 	__le32 Flags;
@@ -122,7 +122,7 @@ struct create_durable_v2_rsp {
 
 /* equivalent of the contents of SMB3.1.1 POSIX open context response */
 struct create_posix_rsp {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8    Name[16];
 	__le32 nlink;
 	__le32 reparse_tag;
@@ -381,13 +381,13 @@ struct smb2_ea_info {
 } __packed; /* level 15 Query */
 
 struct create_ea_buf_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct smb2_ea_info ea;
 } __packed;
 
 struct create_sd_buf_req {
-	struct create_context ccontext;
+	struct create_context_hdr ccontext;
 	__u8   Name[8];
 	struct smb_ntsd ntsd;
 } __packed;
-- 
2.34.1


