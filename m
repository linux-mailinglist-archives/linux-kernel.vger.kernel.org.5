Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBD7E4CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbjKGXXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjKGXXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:23:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520D7170A;
        Tue,  7 Nov 2023 15:23:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2332AC433C8;
        Tue,  7 Nov 2023 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399382;
        bh=VbLINJBBcOe3ggBEOLfEm+vNop3D93xrWfVtIKzVYpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ne3E0c3oRYnUGxIg/LgPoscCC45CA8mEs46fGKmEITDA6HPI8iws31AP/w63iFbVc
         fsipBwxRDl5g6AIspc7O50RxR62pGYzn/5/CME5p5IAfqB4l/N3qBct+PnHpSsUXBo
         AHfyM8j5Ul2EB0/4xq0ErJ8BUex3SCerAuUVRjFgv5IuYi9s/8vxN2MAOyGzwid1FR
         fn7WnjGEsDITyndHALAtb3T0BJ0JUbXRCh51HuH3J+j2YBOOu7myNG5hZ5zOkk2whg
         ZUjmn/sAGi7S5HH6wf1ANn7I8VyUyP8FLI/0SPbWcFwheNajDMANd5Vhnd5uIuSIAB
         ZrtmQDZlZOK+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 13/18] f2fs: fix error path of __f2fs_build_free_nids
Date:   Tue,  7 Nov 2023 18:22:07 -0500
Message-ID: <20231107232231.3775605-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

