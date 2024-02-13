Return-Path: <linux-kernel+bounces-62710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D78524A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23083286367
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95983A15;
	Tue, 13 Feb 2024 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtSd0z/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA322EE4;
	Tue, 13 Feb 2024 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783801; cv=none; b=HoUgZUjDG+IsR6cA5zsX6Ho1TFc5VfsqAxnac3YsBcT6vaG8lG0M7M37u597qIK16GTlp11wvJC5cg7l6qQ+rp8g9l1grzbY7/cvNghkt9rMZyjkX73a02S6i3O2oPh/LjywU3OmFtBFOjP5Fe9gZWoekv8eO0iwLEyql//d0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783801; c=relaxed/simple;
	bh=lg8Lw1w8lD303Ba5+M9irf+AqfB0Qx21xaSCyNWgxDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJSGiEP4xcb1R8FrqrM9BPsqkdIOLn6013n9qHW7PuUvCnwaZsZ3TAvuBwN/IIZJcB6s03M8TI3OPy2MFlJ3938rkEOnwKq+zxUVfgARK6s3aGWbBmcRov/VU2n+8/Yv2mcuNcxAh84PDgveryhjVHm6N/SlA+rjO2rgfXB94Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtSd0z/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5EC43394;
	Tue, 13 Feb 2024 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783800;
	bh=lg8Lw1w8lD303Ba5+M9irf+AqfB0Qx21xaSCyNWgxDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtSd0z/2aQ6s/YeK1r7KoMxj1nvORARCv1jZWuB86Iwo++8l6zgPvBUoDZzv6tcjq
	 EElqJLlsuIiu63uLnwH7l2n5Eyv9HfNQYCjWX0RjRtxbNqUdKCZVr9jcBGmLiyKvB7
	 5xwqkYQv58/OnwYWLH6YJHjXO8nFxxAyAqUBqXnqKrqzRUWqWBjWh6IZbgVqqxUr09
	 jHtOsZ8plsCeaS1YNVN2UAk8zikgozlEU6VYtwscX9baw+CFGx1C4v/tP6rJMvMK+X
	 y9jaUkCBTQlVwmKrVG1yY8kljfaE9B5x7hP0LBcI2hEFAd++J7TyQNGvmTQQFhinHA
	 vc5WS3otmsv0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 26/28] smb: client: set correct d_type for reparse points under DFS mounts
Date: Mon, 12 Feb 2024 19:22:24 -0500
Message-ID: <20240213002235.671934-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 2d75ba5aaa8a..5990bdbae598 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -304,14 +304,16 @@ cifs_dir_info_to_fattr(struct cifs_fattr *fattr, FILE_DIRECTORY_INFO *info,
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
 
@@ -425,7 +427,7 @@ _initiate_cifs_search(const unsigned int xid, struct file *file,
 	} else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
 	} else /* not srvinos - BB fixme add check for backlevel? */ {
-		cifsFile->srch_inf.info_level = SMB_FIND_FILE_DIRECTORY_INFO;
+		cifsFile->srch_inf.info_level = SMB_FIND_FILE_FULL_DIRECTORY_INFO;
 	}
 
 	search_flags = CIFS_SEARCH_CLOSE_AT_END | CIFS_SEARCH_RETURN_RESUME;
@@ -1019,10 +1021,9 @@ static int cifs_filldir(char *find_entry, struct file *file,
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
index e65f998ea4cf..f760189dd870 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4991,6 +4991,9 @@ int SMB2_query_directory_init(const unsigned int xid,
 	case SMB_FIND_FILE_POSIX_INFO:
 		req->FileInformationClass = SMB_FIND_FILE_POSIX_INFO;
 		break;
+	case SMB_FIND_FILE_FULL_DIRECTORY_INFO:
+		req->FileInformationClass = FILE_FULL_DIRECTORY_INFORMATION;
+		break;
 	default:
 		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			info_level);
@@ -5060,6 +5063,9 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
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


