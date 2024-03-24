Return-Path: <linux-kernel+bounces-113458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91B88847E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080641F22104
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F51B0DDA;
	Sun, 24 Mar 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXhGa1dM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71571AFCF2;
	Sun, 24 Mar 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320259; cv=none; b=uE1IpeukR+SztX3gF0kBG/bP7nfCGBYCvIH949iLAx9yz2/ybnh/qLX0pYA4nIC6mmA5vq1QRv9G6rI5NcFRZz0qAetC9jPPCrnYO76DwMZEdtaxsa8T57z3tqRAZT52MEfIgbvUQErBirY9jWIL57L4pTLF86huPeXpjHgmLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320259; c=relaxed/simple;
	bh=5mbBYy7BQfk06vd+d7l3K4BuyHJFXccBuEJ2YZuCX2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh72LuRe8UFVtfUOfhWBdewnzes4u1Pu24hDXp8uxA23w7QGIdals0h8D9zC3vJQNwvTXzs9+r6alceK3SHic6iFqMRzqbYtRFFHeqj6p4TeTGD2ay4tw59KeBdrzvrJ0Nt3HNnvM/V9HkzdKyjn5O/Vs4x+hUypY1lyNaU68jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXhGa1dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A9C43390;
	Sun, 24 Mar 2024 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320259;
	bh=5mbBYy7BQfk06vd+d7l3K4BuyHJFXccBuEJ2YZuCX2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXhGa1dMBlXnOm6OG/vkiI5ORdklrxJkDzuFcpJnAAff6v7wDFriWamdc2mUyI0yY
	 9m0VPkUanAtTmV14jnS/y+1LUmUiI95OQQZ3thhL0fPVqxSk0dEXM+10qsSwvo8PCB
	 HKZ4UsW1r/AdDbLUadUlsZrKgm1PRvZK1TckGe752b8H/jths4BxpbbznB9iX7HKh2
	 i7wmmzeN/zQChRS77pcr0/huO3esYTnun71ZbtTQbLxoOzL8PbfDR5Jyoma71a1QEz
	 HSyCD9zG3YJ14AVDhdmISEl7p7EeHguPURNtBzno9t17/crZfcVc6fQaxAVhZ1KgcI
	 5IGHmoQMhYxDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 567/715] f2fs: fix to avoid potential panic during recovery
Date: Sun, 24 Mar 2024 18:32:26 -0400
Message-ID: <20240324223455.1342824-568-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 03c0d2e996fff..cadda74e06f61 100644
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


