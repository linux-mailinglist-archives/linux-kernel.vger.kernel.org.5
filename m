Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F647FC8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376433AbjK1VJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376416AbjK1VIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:08:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66231FF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33F5C433B9;
        Tue, 28 Nov 2023 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205656;
        bh=tz2fy1wFzUv+rPMfSlsKCahituKdjK1wB1XaxVeoxno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLnGA/3uLDfOvI8kt4Nc2DWFcdozh+oiI7tWsPbbQJMNQbY0kTunVJZ9fyeT+oGxW
         TqwoKOPE/LS4ML1M8oRvX8WQPUf5m2EPv+0wxMgnMMzDs9kmCxHSh4XXeeWA0NNB1r
         OsQj1yWFM1Qw96AHaiMWiwrMqvYIy/+Fc7pHtuJGttTJO+Hzj5KfPiMfbD4x23T0pg
         RM9KAzsHUSV9YCe46W99G+doUwtsjocIoHbTexChgH91OFf1IZnhdRMLpQO2XRhEop
         avchgdSvIp1rnCD/6W+e7NPbK+XHzVEstu66I5L5+PPfL1oIGvGE0+/at/hAumCmr5
         nQ7kkX5EJ+4rg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 38/40] smb: client: introduce ->parse_reparse_point()
Date:   Tue, 28 Nov 2023 16:05:44 -0500
Message-ID: <20231128210615.875085-38-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 539aad7f14dab7f947e5ab81901c0b20513a50db ]

Parse reparse point into cifs_open_info_data structure and feed it
through cifs_open_info_to_fattr().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  6 ++++--
 fs/smb/client/inode.c    | 23 +++++++++++++---------
 fs/smb/client/smb1ops.c  | 41 ++++++++++++++++++++++------------------
 fs/smb/client/smb2ops.c  | 28 ++++++++++++++-------------
 4 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 02082621d8e07..1f84e302122f6 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -395,8 +395,7 @@ struct smb_version_operations {
 			     struct cifs_tcon *tcon,
 			     struct cifs_sb_info *cifs_sb,
 			     const char *full_path,
-			     char **target_path,
-			     struct kvec *rsp_iov);
+			     char **target_path);
 	/* open a file for non-posix mounts */
 	int (*open)(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
 		    void *buf);
@@ -551,6 +550,9 @@ struct smb_version_operations {
 	bool (*is_status_io_timeout)(char *buf);
 	/* Check for STATUS_NETWORK_NAME_DELETED */
 	bool (*is_network_name_deleted)(char *buf, struct TCP_Server_Info *srv);
+	int (*parse_reparse_point)(struct cifs_sb_info *cifs_sb,
+				   struct kvec *rsp_iov,
+				   struct cifs_open_info_data *data);
 };
 
 struct smb_version_values {
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index d7c302442c1ec..f67080e27d8e5 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -457,8 +457,7 @@ static int cifs_get_unix_fattr(const unsigned char *full_path,
 			return -EOPNOTSUPP;
 		rc = server->ops->query_symlink(xid, tcon,
 						cifs_sb, full_path,
-						&fattr->cf_symlink_target,
-						NULL);
+						&fattr->cf_symlink_target);
 		cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
 	}
 	return rc;
@@ -1029,22 +1028,28 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 		if (!rc)
 			iov = &rsp_iov;
 	}
+
+	rc = -EOPNOTSUPP;
 	switch ((data->reparse_tag = tag)) {
 	case 0: /* SMB1 symlink */
-		iov = NULL;
-		fallthrough;
-	case IO_REPARSE_TAG_NFS:
-	case IO_REPARSE_TAG_SYMLINK:
-		if (!data->symlink_target && server->ops->query_symlink) {
+		if (server->ops->query_symlink) {
 			rc = server->ops->query_symlink(xid, tcon,
 							cifs_sb, full_path,
-							&data->symlink_target,
-							iov);
+							&data->symlink_target);
 		}
 		break;
 	case IO_REPARSE_TAG_MOUNT_POINT:
 		cifs_create_junction_fattr(fattr, sb);
+		rc = 0;
 		goto out;
+	default:
+		if (data->symlink_target) {
+			rc = 0;
+		} else if (server->ops->parse_reparse_point) {
+			rc = server->ops->parse_reparse_point(cifs_sb,
+							      iov, data);
+		}
+		break;
 	}
 
 	cifs_open_info_to_fattr(fattr, data, sb);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 6b4d8effa79df..0dd599004e042 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -976,32 +976,36 @@ static int cifs_query_symlink(const unsigned int xid,
 			      struct cifs_tcon *tcon,
 			      struct cifs_sb_info *cifs_sb,
 			      const char *full_path,
-			      char **target_path,
-			      struct kvec *rsp_iov)
+			      char **target_path)
 {
-	struct reparse_data_buffer *buf;
-	TRANSACT_IOCTL_RSP *io = rsp_iov->iov_base;
-	bool unicode = !!(io->hdr.Flags2 & SMBFLG2_UNICODE);
-	u32 plen = le16_to_cpu(io->ByteCount);
 	int rc;
 
 	cifs_tcon_dbg(FYI, "%s: path=%s\n", __func__, full_path);
 
-	/* Check for unix extensions */
-	if (cap_unix(tcon->ses)) {
-		rc = CIFSSMBUnixQuerySymLink(xid, tcon, full_path, target_path,
-					     cifs_sb->local_nls,
-					     cifs_remap(cifs_sb));
-		if (rc == -EREMOTE)
-			rc = cifs_unix_dfs_readlink(xid, tcon, full_path,
-						    target_path,
-						    cifs_sb->local_nls);
-		return rc;
-	}
+	if (!cap_unix(tcon->ses))
+		return -EOPNOTSUPP;
+
+	rc = CIFSSMBUnixQuerySymLink(xid, tcon, full_path, target_path,
+				     cifs_sb->local_nls, cifs_remap(cifs_sb));
+	if (rc == -EREMOTE)
+		rc = cifs_unix_dfs_readlink(xid, tcon, full_path,
+					    target_path, cifs_sb->local_nls);
+	return rc;
+}
+
+static int cifs_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+				    struct kvec *rsp_iov,
+				    struct cifs_open_info_data *data)
+{
+	struct reparse_data_buffer *buf;
+	TRANSACT_IOCTL_RSP *io = rsp_iov->iov_base;
+	bool unicode = !!(io->hdr.Flags2 & SMBFLG2_UNICODE);
+	u32 plen = le16_to_cpu(io->ByteCount);
 
 	buf = (struct reparse_data_buffer *)((__u8 *)&io->hdr.Protocol +
 					     le32_to_cpu(io->DataOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, unicode, target_path);
+	return parse_reparse_point(buf, plen, cifs_sb, unicode,
+				   &data->symlink_target);
 }
 
 static bool
@@ -1200,6 +1204,7 @@ struct smb_version_operations smb1_operations = {
 	.rename = CIFSSMBRename,
 	.create_hardlink = CIFSCreateHardLink,
 	.query_symlink = cifs_query_symlink,
+	.parse_reparse_point = cifs_parse_reparse_point,
 	.open = cifs_open_file,
 	.set_fid = cifs_set_fid,
 	.close = cifs_close_file,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index abc0792698349..33b20e43372d0 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2941,6 +2941,12 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 		return parse_reparse_symlink(
 			(struct reparse_symlink_data_buffer *)buf,
 			plen, unicode, target_path, cifs_sb);
+	case IO_REPARSE_TAG_LX_SYMLINK:
+	case IO_REPARSE_TAG_AF_UNIX:
+	case IO_REPARSE_TAG_LX_FIFO:
+	case IO_REPARSE_TAG_LX_CHR:
+	case IO_REPARSE_TAG_LX_BLK:
+		return 0;
 	default:
 		cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x%08x\n",
 			 le32_to_cpu(buf->ReparseTag));
@@ -2948,22 +2954,18 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 	}
 }
 
-static int smb2_query_symlink(const unsigned int xid,
-			      struct cifs_tcon *tcon,
-			      struct cifs_sb_info *cifs_sb,
-			      const char *full_path,
-			      char **target_path,
-			      struct kvec *rsp_iov)
+static int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+				    struct kvec *rsp_iov,
+				    struct cifs_open_info_data *data)
 {
 	struct reparse_data_buffer *buf;
 	struct smb2_ioctl_rsp *io = rsp_iov->iov_base;
 	u32 plen = le32_to_cpu(io->OutputCount);
 
-	cifs_tcon_dbg(FYI, "%s: path: %s\n", __func__, full_path);
-
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, true, target_path);
+	return parse_reparse_point(buf, plen, cifs_sb,
+				   true, &data->symlink_target);
 }
 
 static int smb2_query_reparse_point(const unsigned int xid,
@@ -5192,7 +5194,7 @@ struct smb_version_operations smb20_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5294,7 +5296,7 @@ struct smb_version_operations smb21_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5399,7 +5401,7 @@ struct smb_version_operations smb30_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5513,7 +5515,7 @@ struct smb_version_operations smb311_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
-- 
2.42.0

