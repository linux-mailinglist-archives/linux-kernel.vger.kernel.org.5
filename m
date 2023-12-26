Return-Path: <linux-kernel+bounces-11250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D281E3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5796DB21D13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77D339AC;
	Tue, 26 Dec 2023 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5OtWNz4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D718558132;
	Tue, 26 Dec 2023 00:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD47EC433CA;
	Tue, 26 Dec 2023 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550225;
	bh=nkxnA4C83oN9prUJryj5u6mE48qIMDs9ePu4jYxMODk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5OtWNz4R/Z9XaUJ5qUk9hO4zH9O4E7/MUW7O52dp3PlHdq2hB8pZqSH0hE0SlxeJ
	 apCeS/c4y+iwuH7Gdsw12C9wl+vLWE+Dh+YLnK+7o1PmnDvHzXbFsO+O0eLi7QRxQf
	 ZAWmUK+4K70BeHsfyIsByLsmjbQjuHj7hCqOyw/QNsMdQUQmgf1s2W8nPP+aqsuufD
	 jFuC1leE3WVQIZfBz9ryw7gpZuwmUrnQDSNHbYMU78FURrV2YwtwPDtPCInHfWWOmF
	 gvIxI44Vgh31NmcMP197fN3Q2nfqUBGH3HeVP1Oh4hUwlXjAYFETdGZfte2uViCF34
	 W3zfYuBKZEczQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	j51569436@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 18/24] smb: client: fix potential OOB in smb2_dump_detail()
Date: Mon, 25 Dec 2023 19:22:11 -0500
Message-ID: <20231226002255.5730-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 567320c46a60a3c39b69aa1df802d753817a3f86 ]

Validate SMB message with ->check_message() before calling
->calc_smb_size().

This fixes CVE-2023-6610.

Reported-by: j51569436@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218219
Cc; stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2misc.c | 30 +++++++++++++++---------------
 fs/smb/client/smb2ops.c  |  6 ++++--
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 88942b1fb4318..08ad74f51964f 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -173,6 +173,21 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 	}
 
 	mid = le64_to_cpu(shdr->MessageId);
+	if (check_smb2_hdr(shdr, mid))
+		return 1;
+
+	if (shdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
+		cifs_dbg(VFS, "Invalid structure size %u\n",
+			 le16_to_cpu(shdr->StructureSize));
+		return 1;
+	}
+
+	command = le16_to_cpu(shdr->Command);
+	if (command >= NUMBER_OF_SMB2_COMMANDS) {
+		cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
+		return 1;
+	}
+
 	if (len < pdu_size) {
 		if ((len >= hdr_size)
 		    && (shdr->Status != 0)) {
@@ -193,21 +208,6 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		return 1;
 	}
 
-	if (check_smb2_hdr(shdr, mid))
-		return 1;
-
-	if (shdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
-		cifs_dbg(VFS, "Invalid structure size %u\n",
-			 le16_to_cpu(shdr->StructureSize));
-		return 1;
-	}
-
-	command = le16_to_cpu(shdr->Command);
-	if (command >= NUMBER_OF_SMB2_COMMANDS) {
-		cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
-		return 1;
-	}
-
 	if (smb2_rsp_struct_sizes[command] != pdu->StructureSize2) {
 		if (command != SMB2_OPLOCK_BREAK_HE && (shdr->Status == 0 ||
 		    pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1b3489a2f0db7..a9f84664a7a83 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -398,8 +398,10 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 	cifs_server_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->Id.SyncId.ProcessId);
-	cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
-		 server->ops->calc_smb_size(buf));
+	if (!server->ops->check_message(buf, server->total_read, server)) {
+		cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
+				server->ops->calc_smb_size(buf));
+	}
 #endif
 }
 
-- 
2.43.0


