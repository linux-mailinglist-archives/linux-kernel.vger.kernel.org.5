Return-Path: <linux-kernel+bounces-33549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D184C836B28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7308F1F26090
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BFD3FB32;
	Mon, 22 Jan 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5hXEryf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC557303;
	Mon, 22 Jan 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936706; cv=none; b=Sqz0WpR9RaEEdfbyCptERzJphWEELC7hvvqtPJl/ZNFUNYfociHdD3mcjxr8yB1ybaV5wF6WlJsfaEZmMK0cj7VrC52e4ALvXZWCPBg6BvtgalPrH8fHgwmG3d/byqotddunOTWe+B13tEQPC70FN9zI3PeDejj1Xqz4LW1ljtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936706; c=relaxed/simple;
	bh=as4ZD96i3aN9NMBMedkYzd3p78ya5sCcySgUgKIfv/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M585KQu2NllepGW1AQOVn/XOvcQXynI9Moz72SaCX67ghntaKb4VUuj9WDmHW4qBGigwysaeKfhuxT/Z19rucrdF8DIoteykf9gzgcZbDbkli3OigSufJa/MTEHiss5zVt3z6DsdoiJARs1eA3QS0xR93suuDhJVKOt1nGWO04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5hXEryf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1EAC433F1;
	Mon, 22 Jan 2024 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936706;
	bh=as4ZD96i3aN9NMBMedkYzd3p78ya5sCcySgUgKIfv/M=;
	h=From:To:Cc:Subject:Date:From;
	b=g5hXEryflvrDZR3cjcBlPLKBemyak//2xLrAs2+FyA8SiwR7HUA2880QiZZWfqRsf
	 PmYyDzhyc4IsfHV4mQg4PfmWUikrBmbN50PVPRBHnZ04KkQS4RoMpPrNyqB4M5PNMG
	 FXGcQfGwzSI1KaDdHklU3ME/3oNmeFj1RY/T5SHtD8LZbcsOYpeLdsSINwL/XVQpd/
	 17KDe2rW+SkDNBXsZrnWLXV904/yuLfIrkO13Xk7k9Iltj2M0d7XP1O7HioxSHvXn6
	 xpAzrv17KLy6js8ou4l41b3BnhtLbRjwn8NsnpKauMbLuJxtkuOdmlt0Qu4X1lOGDa
	 PaVWh9YqraeUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 01/23] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:17:41 -0500
Message-ID: <20240122151823.997644-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index ad0486beee2c..fffc7a9de04b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -548,7 +548,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -556,12 +565,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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


