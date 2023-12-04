Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23108803FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346325AbjLDUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjLDUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:36:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448081996
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707FBC433CB;
        Mon,  4 Dec 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722094;
        bh=OV2/GjLIOmKTXGj8NQpd4Q0W8e9u0iVMPLsfgcZWfl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brfU5SoSwhkHkQGlNp1H3yGsFAXp2gTIq7OkKLpbxysS9dSNZHOHW+wjvrEfrXPhB
         q374iEeq5FB4BCscpLNUWdvsPrgsqvLl5VO+AvcpqbGg9Rys6iJ7rB9cLC9YOF7CQ9
         c3xht+a/bjWMmlHpmFUMcfZd2uFD/f6TW3DdF6+NHjPchkzVJmj9MyCzEiSKCKrOvu
         l1wet7mkXUGW2Dc5vXTNd+3Igrg+++iJu6ivPofurfa3v6cCBRlPRhPQwAKZTE7StV
         NsrXk8no0bbDc14bGs76TFSDwkZ2aVOPXFDNgZbdp4E4Tx5FSUPBAv1WhzKhdKSOsU
         zA+6uWVu6KUaA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 29/32] smb: client, common: fix fortify warnings
Date:   Mon,  4 Dec 2023 15:32:49 -0500
Message-ID: <20231204203317.2092321-29-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 0015eb6e12384ff1c589928e84deac2ad1ceb236 ]

When compiling with gcc version 14.0.0 20231126 (experimental)
and CONFIG_FORTIFY_SOURCE=y, I've noticed the following:

In file included from ./include/linux/string.h:295,
                 from ./include/linux/bitmap.h:12,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/cpuid.h:62,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:9,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from fs/smb/client/smb2pdu.c:18:
In function 'fortify_memcpy_chk',
    inlined from '__SMB2_close' at fs/smb/client/smb2pdu.c:3480:4:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and:

In file included from ./include/linux/string.h:295,
                 from ./include/linux/bitmap.h:12,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:17,
                 from ./arch/x86/include/asm/cpuid.h:62,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:9,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from fs/smb/client/cifssmb.c:17:
In function 'fortify_memcpy_chk',
    inlined from 'CIFS_open' at fs/smb/client/cifssmb.c:1248:3:
./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Wattribute-warning]
  588 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In both cases, the fortification logic inteprets calls to 'memcpy()' as an
attempts to copy an amount of data which exceeds the size of the specified
field (i.e. more than 8 bytes from __le64 value) and thus issues an overread
warning. Both of these warnings may be silenced by using the convenient
'struct_group()' quirk.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifspdu.h | 24 ++++++++++++++----------
 fs/smb/client/cifssmb.c |  6 ++++--
 fs/smb/client/smb2pdu.c |  8 +++-----
 fs/smb/client/smb2pdu.h | 16 +++++++++-------
 fs/smb/common/smb2pdu.h | 17 ++++++++++-------
 5 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index a75220db5c1e1..11081492d9436 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -882,11 +882,13 @@ typedef struct smb_com_open_rsp {
 	__u8 OplockLevel;
 	__u16 Fid;
 	__le32 CreateAction;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le32 FileAttributes;
+	struct_group(common_attributes,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le32 FileAttributes;
+	);
 	__le64 AllocationSize;
 	__le64 EndOfFile;
 	__le16 FileType;
@@ -2264,11 +2266,13 @@ typedef struct {
 /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer formats */
 /******************************************************************************/
 typedef struct { /* data block encoding of response to level 263 QPathInfo */
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le32 Attributes;
+	struct_group(common_attributes,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le32 Attributes;
+	);
 	__u32 Pad1;
 	__le64 AllocationSize;
 	__le64 EndOfFile;	/* size ie offset to first free byte in file */
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 25503f1a4fd21..09e66ceb38a25 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1244,8 +1244,10 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 		*oplock |= CIFS_CREATE_ACTION;
 
 	if (buf) {
-		/* copy from CreationTime to Attributes */
-		memcpy((char *)buf, (char *)&rsp->CreationTime, 36);
+		/* copy commonly used attributes */
+		memcpy(&buf->common_attributes,
+		       &rsp->common_attributes,
+		       sizeof(buf->common_attributes));
 		/* the file_info buf is endian converted by caller */
 		buf->AllocationSize = rsp->AllocationSize;
 		buf->EndOfFile = rsp->EndOfFile;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c75a80bb6d9ee..3e388c6cb5c25 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3377,12 +3377,10 @@ __SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
 	} else {
 		trace_smb3_close_done(xid, persistent_fid, tcon->tid,
 				      ses->Suid);
-		/*
-		 * Note that have to subtract 4 since struct network_open_info
-		 * has a final 4 byte pad that close response does not have
-		 */
 		if (pbuf)
-			memcpy(pbuf, (char *)&rsp->CreationTime, sizeof(*pbuf) - 4);
+			memcpy(&pbuf->network_open_info,
+			       &rsp->network_open_info,
+			       sizeof(pbuf->network_open_info));
 	}
 
 	atomic_dec(&tcon->num_remote_opens);
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 220994d0a0f7f..db08194484e06 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -319,13 +319,15 @@ struct smb2_file_reparse_point_info {
 } __packed;
 
 struct smb2_file_network_open_info {
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;
-	__le64 EndOfFile;
-	__le32 Attributes;
+	struct_group(network_open_info,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		__le64 AllocationSize;
+		__le64 EndOfFile;
+		__le32 Attributes;
+	);
 	__le32 Reserved;
 } __packed; /* level 34 Query also similar returned in close rsp and open rsp */
 
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 319fb9ffc6a03..7d676e7fa5b1a 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -700,13 +700,16 @@ struct smb2_close_rsp {
 	__le16 StructureSize; /* 60 */
 	__le16 Flags;
 	__le32 Reserved;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
-	__le64 EndOfFile;
-	__le32 Attributes;
+	struct_group(network_open_info,
+		__le64 CreationTime;
+		__le64 LastAccessTime;
+		__le64 LastWriteTime;
+		__le64 ChangeTime;
+		/* Beginning of FILE_STANDARD_INFO equivalent */
+		__le64 AllocationSize;
+		__le64 EndOfFile;
+		__le32 Attributes;
+	);
 } __packed;
 
 
-- 
2.42.0

