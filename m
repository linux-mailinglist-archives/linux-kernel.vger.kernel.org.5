Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6797AC94E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjIXNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIXN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:29:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A44489;
        Sun, 24 Sep 2023 06:19:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBB3C4339A;
        Sun, 24 Sep 2023 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561580;
        bh=Zw9+n8J3r8+aZa4uEDefj50qOMgyiy51H4x2YVGDqSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyFVKF00Vk/w92qAEzD2byCDkSobpdmeJXiXfa+bTp0yWK9saXLOi7EswIhaL+lD4
         cZzWZFQcy2zt20fpaKUnwjvBRrUQaw+nndZHQrmolAA45qqsQ9f8ksc1RdLYZAUL2k
         OrbDv3SvGEzQp/fVeR+KYEqCIk07SkipRl7HvgxM5HfdfiKpPEfcUtIZ17ndj6OUgR
         AR3WP3Nk+PIQoL4QUC1LzZpKUU7gjT8bXLPfIWvH+FFTH3ng04DQ5+9eupB1xDkU8J
         MnQ2X0A7kJLf2JeMd0Ipp70c9AOrwCXSawgup089lLilbM8yoHrVyRPHgSUyzyGRb3
         TdZniZ1oXP/ww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        dchinner@redhat.com, brauner@kernel.org, vl@samba.org,
        chenxiaosong2@huawei.com, pc@manguebit.com, sprasad@microsoft.com,
        lsahlber@redhat.com, bharathsm@microsoft.com,
        abelova@astralinux.ru, ematsumiya@suse.de, dhowells@redhat.com
Subject: [PATCH AUTOSEL 5.15 17/18] smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP
Date:   Sun, 24 Sep 2023 09:18:54 -0400
Message-Id: <20230924131857.1276330-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit ebc3d4e44a7e05457825e03d0560153687265523 ]

checkpatch flagged a few places with:
     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
Also fixed minor typo

Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c   | 2 +-
 fs/cifs/smb2ops.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 82848412ad852..30a9a89c141bb 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2531,7 +2531,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
 	}
 
 	cifsFileInfo_put(cfile);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 int cifs_truncate_page(struct address_space *mapping, loff_t from)
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 560c4ababfe1a..d8ce079ba9091 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -266,7 +266,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
 				credits->value, new_val);
 
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	spin_lock(&server->req_lock);
@@ -1308,7 +1308,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 			/* Use a fudge factor of 256 bytes in case we collide
 			 * with a different set_EAs command.
 			 */
-			if(CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+			if (CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
 			   MAX_SMB2_CLOSE_RESPONSE_SIZE - 256 <
 			   used_len + ea_name_len + ea_value_len + 1) {
 				rc = -ENOSPC;
@@ -4822,7 +4822,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	if (shdr->Command != SMB2_READ) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (server->ops->is_session_expired &&
-- 
2.40.1

