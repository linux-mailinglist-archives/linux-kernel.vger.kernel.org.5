Return-Path: <linux-kernel+bounces-113925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B48D888EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A61C2A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D921EEEE3;
	Sun, 24 Mar 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqsNvCjW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C371EE6AD;
	Sun, 24 Mar 2024 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321017; cv=none; b=jNRW7JlTseLWy/Tf8Vcu+2xvSLTuZCbXeMRt6QquDZ2IT+i0UHeyxFC9HnYVXeloQcX/80xfdTAXdgaXmAxzwKv1Ha2ELadP86dnya7+41Z17PFyf7r3c1ZWnpcrZrkd+yfZQmsfIrXPo3gDJOpvrOVAXx26jETG1F8XbwgGEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321017; c=relaxed/simple;
	bh=VMTd483AtVhJY1yg3JO6CqehvFQ36/l32rlPNuPTpN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suThxcvW54cvCvrnhfSZie+ryuVscINvzIbQHzue9u8yhfyVV6Ge9lFifjnlOcixhKFmIk/PHTEkIf2S1gcr3HFsM3Gptl0Hyk9WKzRryhZOequ3ZhNrKU3lR7/FjaNGTPwQgxhsu7p3Jac1WuwgmPpm2VYO9wovr5E8RxGjYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqsNvCjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D83BC433B1;
	Sun, 24 Mar 2024 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321016;
	bh=VMTd483AtVhJY1yg3JO6CqehvFQ36/l32rlPNuPTpN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqsNvCjWtOeyn6Xa9Tq4pCwJA+I8FAVG0hHEljjWPF2+OAegLvK7ekBgYB/5XdqAu
	 qxPlI302C/qshJGXMa+Ab2vo1X7yjaEx10QW8Ne7Vl5VlFUOW6B2d3vFuWHcY8XMxD
	 M68AwDy9WxF/g9c5SdLRBrNKWYLBorBCk0bNp6lIUFzkQOpfkQzQLp/p4V+MR6D1HB
	 2dZtgDMH6gdwMrK/xEquMncKnZxNpBPtoVcKjMlfr1wI9aHj69vIHqVtQg0qZdAWkj
	 8kGy41+uZMLwSx3LULX5xq7iQSkw9UXUS502enfN+azunysTpE6PecQZ7L/4yjtWDu
	 KfQfMmwRSaJBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 579/713] f2fs: fix to avoid potential panic during recovery
Date: Sun, 24 Mar 2024 18:45:05 -0400
Message-ID: <20240324224720.1345309-580-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 21ec68234826b1b54ab980a8df6e33c74cfbee58 ]

During recovery, if FAULT_BLOCK is on, it is possible that
f2fs_reserve_new_block() will return -ENOSPC during recovery,
then it may trigger panic.

Also, if fault injection rate is 1 and only FAULT_BLOCK fault
type is on, it may encounter deadloop in loop of block reservation.

Let's change as below to fix these issues:
- remove bug_on() to avoid panic.
- limit the loop count of block reservation to avoid potential
deadloop.

Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve_new_block()")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h     |  5 +++++
 fs/f2fs/recovery.c | 33 ++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3bd67d4fcb1d4..007f39ff99b20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -75,6 +75,11 @@ struct f2fs_fault_info {
 
 extern const char *f2fs_fault_name[FAULT_MAX];
 #define IS_FAULT_SET(fi, type) ((fi)->inject_type & BIT(type))
+
+/* maximum retry count for injected failure */
+#define DEFAULT_FAILURE_RETRY_COUNT		8
+#else
+#define DEFAULT_FAILURE_RETRY_COUNT		1
 #endif
 
 /*
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d0f24ccbd1ac6..aad1d1a9b3d64 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -611,6 +611,19 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+static int f2fs_reserve_new_block_retry(struct dnode_of_data *dn)
+{
+	int i, err = 0;
+
+	for (i = DEFAULT_FAILURE_RETRY_COUNT; i > 0; i--) {
+		err = f2fs_reserve_new_block(dn);
+		if (!err)
+			break;
+	}
+
+	return err;
+}
+
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 					struct page *page)
 {
@@ -712,14 +725,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			do {
-				err = f2fs_reserve_new_block(&dn);
-				if (err == -ENOSPC) {
-					f2fs_bug_on(sbi, 1);
-					break;
-				}
-			} while (err &&
-				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+
+			err = f2fs_reserve_new_block_retry(&dn);
 			if (err)
 				goto err;
 			continue;
@@ -727,16 +734,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 		/* dest is valid block, try to recover from src to dest */
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
-
 			if (src == NULL_ADDR) {
-				do {
-					err = f2fs_reserve_new_block(&dn);
-					if (err == -ENOSPC) {
-						f2fs_bug_on(sbi, 1);
-						break;
-					}
-				} while (err &&
-					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+				err = f2fs_reserve_new_block_retry(&dn);
 				if (err)
 					goto err;
 			}
-- 
2.43.0


