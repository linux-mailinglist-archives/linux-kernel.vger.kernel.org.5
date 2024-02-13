Return-Path: <linux-kernel+bounces-62679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48585244F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B39B1F2455E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D669D1B;
	Tue, 13 Feb 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPvsj0lG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82C10F5;
	Tue, 13 Feb 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783740; cv=none; b=rIGbc3gQsm7tiEAX+JHKWxjBFVPuzrZzkAUgXNGAxb711PhNDePog/6buspONEsIJ2KUm72wfgEe6ao68U4rO5nWttE/zu5XskukG8ptU/hFka3FV4MQjfeuhG0mcYEkB5PSoG7tXQkUAfrN0muIafnhCIuOr8YGciPGOJBNwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783740; c=relaxed/simple;
	bh=ui3CxEU90r00z7qIItBRftOAkWzgenjEHY/ojM5WoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf+BGn7BkVCVb4mb4bSNrVKmlboYVTBzE6LbhjZZXfku7iSbDVMrLg4AGLRc4szS80wiLvrtZlGZLXT05UW1d3cWLrHftGfMm6iSdHNh0TlnpH9wR3RAXcszrx4YbOLpK1lS5sG/CVgvrJgS43w2GVDOti1GM9nZB5+ljZIOSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPvsj0lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4EDC433F1;
	Tue, 13 Feb 2024 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783739;
	bh=ui3CxEU90r00z7qIItBRftOAkWzgenjEHY/ojM5WoFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPvsj0lGkDhbaB15zNf/LX8WvorJtE/nxIiKxl+ct++4CYlskzEFewTRTOb4UcXsp
	 ubZ3PkDffGrhkzjwL3EAQQ2LfWhmObb+HRATv1cS8IrHC8Qlgz5ILuEMaGpG57xCxk
	 HMrirmkv3Si3QzolswVu4inNlXj+dHlS+YfuLrlyg+68wAcEX8K7fW70IVgOvevVV9
	 XcpceaFHorMzaGfnt+OkHlDovbDBqP/zp63obSSlhYPJWH6bSmjj4fUApv9nrHuMn4
	 ahYkPOVNkN201DhH1nUK6VmQ0aWVimxZsCOJOF01rsZ5cvvROA3nD78ShjpKfs4Xcc
	 VHLd50Sr8tBTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 47/51] smb: client: set correct d_type for reparse points under DFS mounts
Date: Mon, 12 Feb 2024 19:20:24 -0500
Message-ID: <20240213002052.670571-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 55c7788c37242702868bfac7861cdf0c358d6c3d ]

Send query dir requests with an info level of
SMB_FIND_FILE_FULL_DIRECTORY_INFO rather than
SMB_FIND_FILE_DIRECTORY_INFO when the client is generating its own
inode numbers (e.g. noserverino) so that reparse tags still
can be parsed directly from the responses, but server won't
send UniqueId (server inode number)

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/readdir.c | 15 ++++++++-------
 fs/smb/client/smb2pdu.c |  6 ++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index d30ea2005eb3..e23cd216bffb 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -299,14 +299,16 @@ cifs_dir_info_to_fattr(struct cifs_fattr *fattr, FILE_DIRECTORY_INFO *info,
 }
 
 static void cifs_fulldir_info_to_fattr(struct cifs_fattr *fattr,
-				       SEARCH_ID_FULL_DIR_INFO *info,
+				       const void *info,
 				       struct cifs_sb_info *cifs_sb)
 {
+	const FILE_FULL_DIRECTORY_INFO *di = info;
+
 	__dir_info_to_fattr(fattr, info);
 
-	/* See MS-FSCC 2.4.19 FileIdFullDirectoryInformation */
+	/* See MS-FSCC 2.4.14, 2.4.19 */
 	if (fattr->cf_cifsattrs & ATTR_REPARSE)
-		fattr->cf_cifstag = le32_to_cpu(info->EaSize);
+		fattr->cf_cifstag = le32_to_cpu(di->EaSize);
 	cifs_fill_common_info(fattr, cifs_sb);
 }
 
@@ -420,7 +422,7 @@ _initiate_cifs_search(const unsigned int xid, struct file *file,
 	} else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
 	} else /* not srvinos - BB fixme add check for backlevel? */ {
-		cifsFile->srch_inf.info_level = SMB_FIND_FILE_DIRECTORY_INFO;
+		cifsFile->srch_inf.info_level = SMB_FIND_FILE_FULL_DIRECTORY_INFO;
 	}
 
 	search_flags = CIFS_SEARCH_CLOSE_AT_END | CIFS_SEARCH_RETURN_RESUME;
@@ -1014,10 +1016,9 @@ static int cifs_filldir(char *find_entry, struct file *file,
 				       (FIND_FILE_STANDARD_INFO *)find_entry,
 				       cifs_sb);
 		break;
+	case SMB_FIND_FILE_FULL_DIRECTORY_INFO:
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
-		cifs_fulldir_info_to_fattr(&fattr,
-					   (SEARCH_ID_FULL_DIR_INFO *)find_entry,
-					   cifs_sb);
+		cifs_fulldir_info_to_fattr(&fattr, find_entry, cifs_sb);
 		break;
 	default:
 		cifs_dir_info_to_fattr(&fattr,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f5006aa97f5b..c84d65dba813 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5076,6 +5076,9 @@ int SMB2_query_directory_init(const unsigned int xid,
 	case SMB_FIND_FILE_POSIX_INFO:
 		req->FileInformationClass = SMB_FIND_FILE_POSIX_INFO;
 		break;
+	case SMB_FIND_FILE_FULL_DIRECTORY_INFO:
+		req->FileInformationClass = FILE_FULL_DIRECTORY_INFORMATION;
+		break;
 	default:
 		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			info_level);
@@ -5145,6 +5148,9 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 		/* note that posix payload are variable size */
 		info_buf_size = sizeof(struct smb2_posix_info);
 		break;
+	case SMB_FIND_FILE_FULL_DIRECTORY_INFO:
+		info_buf_size = sizeof(FILE_FULL_DIRECTORY_INFO);
+		break;
 	default:
 		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			 srch_inf->info_level);
-- 
2.43.0


