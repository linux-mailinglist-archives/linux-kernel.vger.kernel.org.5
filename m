Return-Path: <linux-kernel+bounces-33400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C978E83693E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8129C1F23C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7A4C3B3;
	Mon, 22 Jan 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BudYVM5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EF4C3AD;
	Mon, 22 Jan 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936193; cv=none; b=N+QcEIngly8eLC8Zmo7xyuzNOBjancFUQzwv4mrXVC2U+mrXqE2+RMTWAblcCevxM2pVuJFTx40Z7E6aOe0C7WvUr2WbCith9KM/+pvSdabRLkXlzMQf3noLPKQc8PqqsP2VuUR5DRw6xca8PyLFx1RchC9gwMkHX1Wdqny2DBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936193; c=relaxed/simple;
	bh=gVYl3puETxMBF8kQKDFOuGLxTaMGQg6pVudIGcoKl2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVFab2wGtCHGDJ5q6lx+4ccPHnwMVNWLloF0F53bHLGbvZDkmoBf7bP6b2gP9pNs3Vaw1gYRR5/hv0kXexbvlLdiVoXRY/DkrgqJkyhTMd4IYvON6c1m8ZrgIS6GimYDWXfh3VEN21Dm+9FvvoPC8pAtCtQ5CcfVEEAtx89MXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BudYVM5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D92C433C7;
	Mon, 22 Jan 2024 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936192;
	bh=gVYl3puETxMBF8kQKDFOuGLxTaMGQg6pVudIGcoKl2g=;
	h=From:To:Cc:Subject:Date:From;
	b=BudYVM5MDW8nK3m4VP96h42pdjiCNYFA3/4RiIn0Ex+N9X9/gfzcmY8fqCZ+Wj2jg
	 ecD8qCWI6NVQvrSOSQSsFvenWTgQ6MTFstJjZaV7RR3s9B2ny8QDczMqu7WYuXRNQD
	 clXmZSq497bUzb/slziDnkzKsZKZ+n7O1UvRxe51u+Z+uT1peKVspH8rV7/81nTK+4
	 hZrBz4n9S1w/YfO8ECbajyK+GfdkA1J/EvwcNhSF2/p/6262D4a6kv7SFbmDH77imU
	 1PeMeqNEQ6jizmOPQAYFAA8QVURxdXGuRrKvv1IVcpvpY5B96yMczCZlU2AM+kikSw
	 r0kgxkcEqtsEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 01/53] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:08:02 -0500
Message-ID: <20240122150949.994249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 956fa1ddc132e028f3b7d4cf17e6bfc8cb36c7fd ]

Let's check return value of f2fs_reserve_new_block() in do_recover_data()
rather than letting it fails silently.

Also refactoring check condition on return value of f2fs_reserve_new_block()
as below:
- trigger f2fs_bug_on() only for ENOSPC case;
- use do-while statement to avoid redundant codes;

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index dea95b48b647..4f4db465220f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -683,7 +683,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -691,12 +700,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
-- 
2.43.0


