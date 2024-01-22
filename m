Return-Path: <linux-kernel+bounces-33318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7083687C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E7BB295BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2347F7B;
	Mon, 22 Jan 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM5kM0s4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AD47764;
	Mon, 22 Jan 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935875; cv=none; b=O3emkjJgJqCJn5aquGqLn+34OEmHx0lbe74cITCKYXAd0zoohdN3Gekj3cMrRElrZBNMTSNQl5M2Yw43Uezf4TQnOxR7KxOqekCqC8Xh6Rsko08gjjI9r8UKg4F/tdCKKXY2s1yx81ztgTC3/aY4QvGQlJs9WHMOlX2+AsGfNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935875; c=relaxed/simple;
	bh=TUoRPDeyxb9QXB0MVg5ZmATCPGDnkl1LaY1FN21NJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMQgAfzeVC3VP0f19FMA/Qm5P5WzHoU/acbO/xkBEJP1NPrJNJs+EZO2I7VfkZamGBFxU5whx9IOPRchi9PbllISSXfRt06XML5zNdV2eJMCSyPYzsw5v4BEr3LHEuxslqNUSn5wYA+wPsrFNoaSe3VSIwHJi++bdgWVFokdBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM5kM0s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9ECC43394;
	Mon, 22 Jan 2024 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935874;
	bh=TUoRPDeyxb9QXB0MVg5ZmATCPGDnkl1LaY1FN21NJ6M=;
	h=From:To:Cc:Subject:Date:From;
	b=ZM5kM0s4MlHA/7v3cXSYTodLfgy0F7kaBf0cXP1jkKZxBmv1ueKLP3+/LuozAnStg
	 aibLVy5UnvA74Q6EtlW/s6eNLckgL66KszNopBVOCTecvzjoxHHrxwmbjaTD87Tdg+
	 jVRp1rkrK+0rM5ibhzI2k8Tw+nOwVwc4NU6vpRDIyI3/S7YAlb9FCNrIiHPEnBJPOD
	 Baz4+bYlFQEtqACgihGUFfJfeaei2Qe+BseGNfaOu0JdD1C4uNrtw5UhtiBGvcnT5n
	 3c6uUkoZ98bDaoK5b9KIEU4tUFP9HkzgBB0p3OOERUu2gkRrk+6WuOJc1OLS7WPOa1
	 HXzg9JMY88wWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 01/73] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:01:15 -0500
Message-ID: <20240122150432.992458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 7be60df277a5..f0de36ef73c2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -712,7 +712,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -720,12 +729,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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


