Return-Path: <linux-kernel+bounces-156150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB798AFE90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A593F1F23B76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56083CB8;
	Wed, 24 Apr 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzprxf8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CA29429;
	Wed, 24 Apr 2024 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926486; cv=none; b=XjTALdhppeMsmwVUjrK8yFKmigGxlJ9slWbYWTokwlWBsdhYx/NGhX+STEpQyD6OxqGHAvH8C5RMhqxvvct3NI1g8uCSlC+7Yw9tXFpqIlCUpiHEGRUlLM9Imxl1myv6O7GYMlXdIw0PuCccvMdIUAReNVD4vYDxt0pEwNPfKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926486; c=relaxed/simple;
	bh=cM21uIYga7OOJDL9MRldxEYsagtKqU6T2kRjdYuzQec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N4VzwWlpqpmjtPBc3KtEGq6oPz9/08Z/wjMiacBeaYftOxM87/U7I0H5AkyzYh/zoR+5f5IXBAyQ+/iG0rRRU7ggbNSidOa+7YecIECPEOWqHnGI5iiFA6MJcTGPX3ITs94SyqDNBwwmv1FUfv3MQzwPV67R8gW7PcrL+3dSc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzprxf8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A84C116B1;
	Wed, 24 Apr 2024 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713926485;
	bh=cM21uIYga7OOJDL9MRldxEYsagtKqU6T2kRjdYuzQec=;
	h=Date:From:To:Cc:Subject:From;
	b=Kzprxf8WVblGZ4b+hqz0o2ImgizI8i3CnAtNPB36ufBPfqhcNFTJaJ3QzXrSM/Sgu
	 pDXKuD9qjk/jiu6Nb9mP/4MItueYqfFd+ipDzJZga2LpmaH+uw6SMAnbFXPnv/zUhS
	 TOxfdruG0wWM4riVD2nXuVDLUfa9z9f9pFr8Unj1UTb3vO3uIK/z2h+VU8KGs8xLLz
	 WBjpnVcgR8ySFBr+VBRX45ZDiFcF1ro1irHLZB09acyHOtdHIHL4yQuRCDh58tPPoT
	 MxlLUtBf0REi533tRvKIhDjWFBWV4mL+A+TP+iVw0hX17mrtttLCaMJDo97S8x1YOq
	 0QjBCd8J4UdYA==
Date: Tue, 23 Apr 2024 20:41:22 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] smb: client: Fix struct_group() usage in __packed
 structs
Message-ID: <ZihxUuQOkZ6Zz363@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use struct_group_attr() in __packed structs, instead of struct_group().

Below you can see the pahole output before/after changes:

pahole -C smb2_file_network_open_info fs/smb/client/smb2ops.o
struct smb2_file_network_open_info {
	union {
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le64     AllocationSize;       /*    32     8 */
			__le64     EndOfFile;            /*    40     8 */
			__le32     Attributes;           /*    48     4 */
		};                                       /*     0    56 */
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le64     AllocationSize;       /*    32     8 */
			__le64     EndOfFile;            /*    40     8 */
			__le32     Attributes;           /*    48     4 */
		} network_open_info;                     /*     0    56 */
	};                                               /*     0    56 */
	__le32                     Reserved;             /*    56     4 */

	/* size: 60, cachelines: 1, members: 2 */
	/* last cacheline: 60 bytes */
} __attribute__((__packed__));

pahole -C smb2_file_network_open_info fs/smb/client/smb2ops.o
struct smb2_file_network_open_info {
	union {
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le64     AllocationSize;       /*    32     8 */
			__le64     EndOfFile;            /*    40     8 */
			__le32     Attributes;           /*    48     4 */
		} __attribute__((__packed__));           /*     0    52 */
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le64     AllocationSize;       /*    32     8 */
			__le64     EndOfFile;            /*    40     8 */
			__le32     Attributes;           /*    48     4 */
		} __attribute__((__packed__)) network_open_info;       /*     0    52 */
	};                                               /*     0    52 */
	__le32                     Reserved;             /*    52     4 */

	/* size: 56, cachelines: 1, members: 2 */
	/* last cacheline: 56 bytes */
};

pahole -C smb_com_open_rsp fs/smb/client/cifssmb.o
struct smb_com_open_rsp {
	...

	union {
		struct {
			__le64     CreationTime;         /*    48     8 */
			__le64     LastAccessTime;       /*    56     8 */
			/* --- cacheline 1 boundary (64 bytes) --- */
			__le64     LastWriteTime;        /*    64     8 */
			__le64     ChangeTime;           /*    72     8 */
			__le32     FileAttributes;       /*    80     4 */
		};                                       /*    48    40 */
		struct {
			__le64     CreationTime;         /*    48     8 */
			__le64     LastAccessTime;       /*    56     8 */
			/* --- cacheline 1 boundary (64 bytes) --- */
			__le64     LastWriteTime;        /*    64     8 */
			__le64     ChangeTime;           /*    72     8 */
			__le32     FileAttributes;       /*    80     4 */
		} common_attributes;                     /*    48    40 */
	};                                               /*    48    40 */

	...

	/* size: 111, cachelines: 2, members: 14 */
	/* last cacheline: 47 bytes */
} __attribute__((__packed__));

pahole -C smb_com_open_rsp fs/smb/client/cifssmb.o
struct smb_com_open_rsp {
	...

	union {
		struct {
			__le64     CreationTime;         /*    48     8 */
			__le64     LastAccessTime;       /*    56     8 */
			/* --- cacheline 1 boundary (64 bytes) --- */
			__le64     LastWriteTime;        /*    64     8 */
			__le64     ChangeTime;           /*    72     8 */
			__le32     FileAttributes;       /*    80     4 */
		} __attribute__((__packed__));           /*    48    36 */
		struct {
			__le64     CreationTime;         /*    48     8 */
			__le64     LastAccessTime;       /*    56     8 */
			/* --- cacheline 1 boundary (64 bytes) --- */
			__le64     LastWriteTime;        /*    64     8 */
			__le64     ChangeTime;           /*    72     8 */
			__le32     FileAttributes;       /*    80     4 */
		} __attribute__((__packed__)) common_attributes;       /*    48    36 */
	};                                               /*    48    36 */

	...

	/* size: 107, cachelines: 2, members: 14 */
	/* last cacheline: 43 bytes */
} __attribute__((__packed__));

pahole -C FILE_ALL_INFO fs/smb/client/cifssmb.o
typedef struct {
	union {
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le32     Attributes;           /*    32     4 */
		};                                       /*     0    40 */
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le32     Attributes;           /*    32     4 */
		} common_attributes;                     /*     0    40 */
	};                                               /*     0    40 */

	...

	/* size: 113, cachelines: 2, members: 17 */
	/* last cacheline: 49 bytes */
} __attribute__((__packed__)) FILE_ALL_INFO;

pahole -C FILE_ALL_INFO fs/smb/client/cifssmb.o
typedef struct {
	union {
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le32     Attributes;           /*    32     4 */
		} __attribute__((__packed__));           /*     0    36 */
		struct {
			__le64     CreationTime;         /*     0     8 */
			__le64     LastAccessTime;       /*     8     8 */
			__le64     LastWriteTime;        /*    16     8 */
			__le64     ChangeTime;           /*    24     8 */
			__le32     Attributes;           /*    32     4 */
		} __attribute__((__packed__)) common_attributes;       /*     0    36 */
	};                                               /*     0    36 */

	...

	/* size: 109, cachelines: 2, members: 17 */
	/* last cacheline: 45 bytes */
} __attribute__((__packed__)) FILE_ALL_INFO;

Fixes: 0015eb6e1238 ("smb: client, common: fix fortify warnings")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/smb/client/cifspdu.h | 4 ++--
 fs/smb/client/smb2pdu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index c0513fbb8a59..c46d418c1c0c 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -882,7 +882,7 @@ typedef struct smb_com_open_rsp {
 	__u8 OplockLevel;
 	__u16 Fid;
 	__le32 CreateAction;
-	struct_group(common_attributes,
+	struct_group_attr(common_attributes, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
@@ -2266,7 +2266,7 @@ typedef struct {
 /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer formats */
 /******************************************************************************/
 typedef struct { /* data block encoding of response to level 263 QPathInfo */
-	struct_group(common_attributes,
+	struct_group_attr(common_attributes, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index c72a3b2886b7..2fccf0d4f53d 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -320,7 +320,7 @@ struct smb2_file_reparse_point_info {
 } __packed;
 
 struct smb2_file_network_open_info {
-	struct_group(network_open_info,
+	struct_group_attr(network_open_info, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
-- 
2.34.1


