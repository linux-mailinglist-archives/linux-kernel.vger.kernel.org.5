Return-Path: <linux-kernel+bounces-114622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48A888B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BDC1F2774A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BED2A4905;
	Sun, 24 Mar 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNTm2Y2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B682234500;
	Sun, 24 Mar 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322281; cv=none; b=jqozN2D2a0Ss1jy1EfsJAhes3YrIKMi32V7DdIp963bTtnRGog9dsVP8b3tqvcwNqLeOxIRHfK0lSB4fCOI5gjGO02WjF7yLKBEz5+zSvXGU1Z/SVMzRHqBAMtzvU1oBROYYD/rsuNLqa4RyB/d7Wfv3smlaRjzl7JJKrqo8vaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322281; c=relaxed/simple;
	bh=KF94tE9wc8iQd/yr9pjHcO4zDQAEnIv2U/NDSyNuoXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrZms/Ay+4ybUIaqghA4JPfuKnD286lYrgFfsuAUe1pQ3+M6SeLsdWBrzAfwVhjMxuogD7iZCfaUBRTaHi/tcYo1dr6CKrwSvzpYPXpruDf2Hs/7nJMOSWOt+lTUxWW8vHDi/Wg7avLIloMs9eiQjHdbB2mFEdOo3RdVimldPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNTm2Y2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEABC433F1;
	Sun, 24 Mar 2024 23:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322280;
	bh=KF94tE9wc8iQd/yr9pjHcO4zDQAEnIv2U/NDSyNuoXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNTm2Y2t567o92JGDqgjBuG0CIL2oGr10dSN8tZxr8gTCRdBraSxh576y+8wo62cD
	 q8WHsXxWsqdiCcTFr5GK6/wog8L8va5xgW/BMczejkC0PRniMT4s1K8RlW9xoT7wwJ
	 bUmwoujFtuUduv8rkFl2wGy0UllNvZfuWBzd78CohkpensrNmVEAkDpgvimMVLNt1D
	 64Y38aoSqUpOZU7nQnlQvvHIIZfcCDw7kBMGlJ/VSq8OdZkXdfYMNsUZSasqtRKW02
	 mUe7EtbhmSjQbx6N5cW91PvxF4yK0AhePZ+U02tFwg8wY7Vbuok2gJpGuOPm7+kyDH
	 dichUQ6e9jufA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 363/451] f2fs: fix to avoid potential panic during recovery
Date: Sun, 24 Mar 2024 19:10:39 -0400
Message-ID: <20240324231207.1351418-364-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index a81091a5e282d..f5d69893d2d92 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -74,6 +74,11 @@ struct f2fs_fault_info {
 
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
index 53a6487f91e44..f5efc37a2b513 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -582,6 +582,19 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
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
@@ -683,14 +696,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -698,16 +705,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
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


