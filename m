Return-Path: <linux-kernel+bounces-11222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EB81E35F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F6C1C215F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392F54BC2;
	Tue, 26 Dec 2023 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0BjI/BK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1A54729;
	Tue, 26 Dec 2023 00:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA5DC433C8;
	Tue, 26 Dec 2023 00:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550096;
	bh=JyJL7+g1ECe4rRP3IBy9n2McuHzuQlk2PdDG+2qS3XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0BjI/BKtqeQeltQeeWX/4UMhSt2pagybXIFf9QHg92tVpCLGmZ9Bf0ajyHgNeZst
	 g1tM9iNz4jZmhAyYRwVv1A2xFvXhLcOuhMJVBCM61yjXaM7dwM7bw5LlmhDK/q6eyw
	 XxHLxiseyJAUt27mYMME9ixCSc2CPfhE4uaLatejwmDFq7jlcrurbM6AZRhWtASo/f
	 XKzzManOVwXdrn/3rAf+MjRegZD5mHQOA0zBwIB6Y8pU+R9V/EsbSqTm8tKf5xClMr
	 DHMpsliYHVlu1TOIEI0ZTuUZTVTUgOjYMXuhNnjgql8RypIe8BJIh1eoYJG4lT4e/z
	 eCMekPcA47qZA==
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
Subject: [PATCH AUTOSEL 6.6 29/39] smb: client: fix potential OOB in smb2_dump_detail()
Date: Mon, 25 Dec 2023 19:19:19 -0500
Message-ID: <20231226002021.4776-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
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
index e20b4354e703b..82b84a4941dd2 100644
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
index dbcfdf7bc2704..610783bf52422 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -403,8 +403,10 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
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


