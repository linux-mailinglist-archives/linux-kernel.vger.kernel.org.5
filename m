Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33B7E4D22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbjKGXZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjKGXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:25:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363881FE5;
        Tue,  7 Nov 2023 15:24:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122CAC433C7;
        Tue,  7 Nov 2023 23:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399440;
        bh=VbLINJBBcOe3ggBEOLfEm+vNop3D93xrWfVtIKzVYpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lhp3MS8jivY+T3Ny2chkTlalY/ttzmGf85L/j1JMikaMQEj2rx8gM/a6tpK80NS+B
         wAP+9kFTfNqblHwrW/PFb5Cn+J7CtUst+bYvFbRSzclD8AO0S4KkuiPtBHXmtE5NM3
         Q1MwJnHk7zw85h0RFg8HYzX7XXARdO5XEx6UaV5we+S+t+/WiqzzlgZi74ZlRaZT02
         elSzlc7tQRk3OmLNQx+6gf0h1i2nFnT9TzJffHXfQt3v+se5MqaV6MUvVkv5RYLwr0
         x9q6fU+eUNM1CPhLIrEFg++KkwW7I8DYtKbDi7oSRLZdI77V8avHWViwmvlL0B+4J/
         6fQvE4uccIYtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.5 13/18] f2fs: fix error path of __f2fs_build_free_nids
Date:   Tue,  7 Nov 2023 18:23:08 -0500
Message-ID: <20231107232330.3776001-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232330.3776001-1-sashal@kernel.org>
References: <20231107232330.3776001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit a5e80e18f268ea7c7a36bc4159de0deb3b5a2171 ]

If NAT is corrupted, let scan_nat_page() return EFSCORRUPTED, so that,
caller can set SBI_NEED_FSCK flag into checkpoint for later repair by
fsck.

Also, this patch introduces a new fscorrupted error flag, and in above
scenario, it will persist the error flag into superblock synchronously
to avoid it has no luck to trigger a checkpoint to record SBI_NEED_FSCK

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c          | 11 +++++++++--
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ee2e1dd64f256..248764badcde8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2389,7 +2389,7 @@ static int scan_nat_page(struct f2fs_sb_info *sbi,
 		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
 
 		if (blk_addr == NEW_ADDR)
-			return -EINVAL;
+			return -EFSCORRUPTED;
 
 		if (blk_addr == NULL_ADDR) {
 			add_free_nid(sbi, start_nid, true, true);
@@ -2504,7 +2504,14 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 
 			if (ret) {
 				f2fs_up_read(&nm_i->nat_tree_lock);
-				f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
+
+				if (ret == -EFSCORRUPTED) {
+					f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
+					set_sbi_flag(sbi, SBI_NEED_FSCK);
+					f2fs_handle_error(sbi,
+						ERROR_INCONSISTENT_NAT);
+				}
+
 				return ret;
 			}
 		}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a82a4bb6ce68b..cf1adceb02697 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -104,6 +104,7 @@ enum f2fs_error {
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
 	ERROR_INVALID_NODE_REFERENCE,
+	ERROR_INCONSISTENT_NAT,
 	ERROR_MAX,
 };
 
-- 
2.42.0

