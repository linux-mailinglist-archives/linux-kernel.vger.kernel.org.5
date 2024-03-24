Return-Path: <linux-kernel+bounces-114393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6C888A36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEDB28AC81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B502745D1;
	Sun, 24 Mar 2024 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrwHkFqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176513EFE9;
	Sun, 24 Mar 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321794; cv=none; b=Y5RfUoT4ycYCzEHgu/bdoB7R/E/eXbYl5kkcR3GnkX+HcOrVH0IToRPGQKFpYBOL61H8ya6O6tJxDaGAvNPPiNpNvgCm1gOJio6AnoH7CjSnzYNm0Z+EEv50sRsObOZ9qE7eDOhcuunHnkKVOjEogPdMzfuUCi4iKjcsoomehlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321794; c=relaxed/simple;
	bh=wmrlvE/L6C5hK39oJ2Jr9GXuLZqVCB/arPW5jiT+93k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q//Xn2IE/s39F3jTHkN+dx7Coe53xATI2hokgkVGF+ZMG6ulhU7LND6Z6SF2nbUXfjpKx8KWwSguc1RcUkFppUazRgyqgjLZzcZ8a3Of3dhTlUtSmrL7Qec82tTO2nVWYLu5kRb7dCtpduVGFGewtElgG2b6F6yov4QsdW+1SQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrwHkFqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0206BC433C7;
	Sun, 24 Mar 2024 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321793;
	bh=wmrlvE/L6C5hK39oJ2Jr9GXuLZqVCB/arPW5jiT+93k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrwHkFqbfoPNqxhFGYMxSYKzom1MfJs/5Qg95CXkr3TyPSnLJoMW30SPA9sHzx86T
	 n3TDr7NQa/d/E8YmMmlMpixqyj41O9g4VCL1LwjvrcWy473ic824EOTT30fblfZvKC
	 CpSvhXdxVw6OnP2l2Yl6T2YVVPfGH0IffJs87jS2qFOE7erg079y2HRQ9b1kO0RjF2
	 R5r0y7ZFPVelwgYk3duCD/JqGFbtlHsMqJk1DcGDmJtxKkbRpgG5k7K/fQKDdBc1NH
	 FSloOwFYbFWG1DJzuBFXNf1RpMqGVA2dvP+5OIwT8g6RYBHmMUkvIkQf6KiAPRP7Gc
	 EFqcDCgUvh7dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 521/638] f2fs: fix to avoid potential panic during recovery
Date: Sun, 24 Mar 2024 18:59:18 -0400
Message-ID: <20240324230116.1348576-522-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 95fa1f7a89707..a518fe31ec9e1 100644
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
index c8ba9f1551b62..23077cdfde367 100644
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


