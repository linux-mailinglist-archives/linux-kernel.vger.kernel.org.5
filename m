Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3D7AC8BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjIXNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIXNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C064CF2;
        Sun, 24 Sep 2023 06:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73128C433C7;
        Sun, 24 Sep 2023 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561460;
        bh=kwGhq/jUBxws69w81OE6uQ3pV9yKd0Lpu3TYKrh2uDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+yjsfftlorx7pPvjxJnAXaiagYbawTh9e9efeIHKThw0Qcd9bFzZWAzedieeA+yE
         cA9zw2iy+uPB7XtuzNW8boSWHdOuLk9vrF89mT1zujo0QEMePnGMtz/1i1+I4enCHX
         DQFWXgeF2y1+TKG2bdmoWp34s6sEmIHoaOPQKhU64YYuUn/5zpcvD89P/W1pb/JQDv
         BvcJmPwvKFARxB4XOvxniexV7M4pJjRBOYtYcBgfXip+DJxvBbnqE1sWRkOJdRVesZ
         SOgNdUtMsvO6bzxracuU5jh7mP73Q26Wvo8GRDzeNsUHhZ3yAcSDpDeBmV+G7SzxPf
         neNjXZagzdYOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.5 39/41] smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP
Date:   Sun, 24 Sep 2023 09:15:27 -0400
Message-Id: <20230924131529.1275335-39-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
index c3eeae07e1390..cb85d7977b1e3 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2610,7 +2610,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
 	}
 
 	cifsFileInfo_put(cfile);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 int cifs_truncate_page(struct address_space *mapping, loff_t from)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index dd6a423dc6e11..a5cba71c30aed 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -297,7 +297,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
 				credits->value, new_val);
 
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	spin_lock(&server->req_lock);
@@ -1159,7 +1159,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 			/* Use a fudge factor of 256 bytes in case we collide
 			 * with a different set_EAs command.
 			 */
-			if(CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+			if (CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
 			   MAX_SMB2_CLOSE_RESPONSE_SIZE - 256 <
 			   used_len + ea_name_len + ea_value_len + 1) {
 				rc = -ENOSPC;
@@ -4716,7 +4716,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	if (shdr->Command != SMB2_READ) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (server->ops->is_session_expired &&
-- 
2.40.1

