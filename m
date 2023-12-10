Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF580BA5F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjLJLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjLJLgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:36:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156F11F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:36:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C726C433CB;
        Sun, 10 Dec 2023 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702208168;
        bh=17M2pG5LF+yTUT42vRyb2J9RQolF4UPApTsylmOgOqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhKpZ6bMkrzIwnh96I+1vV0Y2OCIZV/ymzd7baK1mrWUah3lbAoHJjqI7MB/s3SRm
         Vl4hGgaRM7HzUXf8iw7IiZQTR7CQzPHnmb0NF2RrsVZY68DRUwdGsaX3fwKzgXd2zJ
         JKdR5UcjWAcNU3PFutjamQmTrdJ6ubvaKMJdHjtaw927MIKe9aFFER8GfR5+fqAqdJ
         s7YwuahFs/xFV/RUX/bvsLCDeKpZ+TG9cuTsIiDfGsdYKC8ihmdV605qwAcFRtmUXk
         FyPeza8fPKgHSCoeyAaBiwEjhicRI1nEZKg88Q61Hs5j/YhVbRf2K4ZkP0h16h6wGZ
         5KsDwZJHvABfQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 5/6] f2fs: fix to restrict condition of compress inode conversion
Date:   Sun, 10 Dec 2023 19:35:46 +0800
Message-Id: <20231210113547.3412782-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
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

This patch adds i_size check during compress inode conversion in order
to avoid .page_mkwrite races w/ conversion.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 8 +++++++-
 fs/f2fs/file.c | 5 ++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..c9b8a1953913 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4397,13 +4397,19 @@ static inline int set_compress_context(struct inode *inode)
 #endif
 }
 
+static inline bool inode_has_data(struct inode *inode)
+{
+	return (S_ISREG(inode->i_mode) &&
+		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
+}
+
 static inline bool f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	if (!f2fs_compressed_file(inode))
 		return true;
-	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+	if (inode_has_data(inode))
 		return false;
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1a3c29a9a6a0..8af4b29c3e1a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1922,8 +1922,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 			f2fs_down_write(&F2FS_I(inode)->i_sem);
 			if (!f2fs_may_compress(inode) ||
-					(S_ISREG(inode->i_mode) &&
-					F2FS_HAS_BLOCKS(inode))) {
+					inode_has_data(inode)) {
 				f2fs_up_write(&F2FS_I(inode)->i_sem);
 				return -EINVAL;
 			}
@@ -3996,7 +3995,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (F2FS_HAS_BLOCKS(inode)) {
+	if (inode_has_data(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
-- 
2.40.1

