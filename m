Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9F7AC976
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjIXNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjIXNb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:31:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D98359A;
        Sun, 24 Sep 2023 06:18:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA57C433B6;
        Sun, 24 Sep 2023 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561533;
        bh=hxUgnyLDhYuq1whbWQpkXlGwl9tEvE9qr7pNrMEYKGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sy/y6NywvfSLYhZxsuQi6r/eRkgHNtBbaGKpcp0U8FTsi1mmqtbWWfNtEq8ip4rKt
         dt5JbCpz87fbAasC5Kn54IyYzYzkK051OEuhWTIfkA6uPlYSHvCqPAbhVN4txZr42s
         vI7alORA2G7d6v4CWUoqjdIfe3APeysN0C3bs/+P0fLoVHteJ7LteE4K4lioKX38DZ
         OAunPdvLcawCP6StdvUXlkl8y6D0Ob25GjNEnKK4LSw6+O7bZnoLjYXNAvG7xD3lDN
         91HkR8gXjknj5HAYt54AmCysfz8P8tsVJopY5CtTI0w7nriue6gTdsg1r8rsPS72WM
         u3uBbJExp480g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 27/28] smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP
Date:   Sun, 24 Sep 2023 09:17:44 -0400
Message-Id: <20230924131745.1275960-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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
 fs/smb/client/inode.c   | 2 +-
 fs/smb/client/smb2ops.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 92c1ed9304be7..9531ea2430899 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2605,7 +2605,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
 	}
 
 	cifsFileInfo_put(cfile);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 int cifs_truncate_page(struct address_space *mapping, loff_t from)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1387d5126f53b..efff7137412b4 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -292,7 +292,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
 				credits->value, new_val);
 
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	spin_lock(&server->req_lock);
@@ -1155,7 +1155,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 			/* Use a fudge factor of 256 bytes in case we collide
 			 * with a different set_EAs command.
 			 */
-			if(CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+			if (CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
 			   MAX_SMB2_CLOSE_RESPONSE_SIZE - 256 <
 			   used_len + ea_name_len + ea_value_len + 1) {
 				rc = -ENOSPC;
@@ -4721,7 +4721,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	if (shdr->Command != SMB2_READ) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (server->ops->is_session_expired &&
-- 
2.40.1

