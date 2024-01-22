Return-Path: <linux-kernel+bounces-33457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4DF8369EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE27F1F2525D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979650273;
	Mon, 22 Jan 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4aM9zD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4783F8F7;
	Mon, 22 Jan 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936387; cv=none; b=ay5m5swwpVAipX7yLQ9a0AoKRk4XECStZIKB0fc5GxhLCT5pTBfDh66/LzrYQ+wUE+8/P4yuZwq46qoi/OrSAtsPI5+rCofmO3G0YGcP3Z7ByZg+NUhwIXhLRqYjZsmAaMJ9UhbsyFdVHYVLis7H8a5SW8QVYa9KbEMjGEFM+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936387; c=relaxed/simple;
	bh=Uye9Z16T4F7rnw5uWqM/ojOYrT953nGpjEqyI3AjPzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSICVB83+YFe8n1wr/7NILKaPEn+2SlHfc8mV2wA4kml5gyywESFSxl4Kvf74BGHm3cGikFEE3bicyYW2HLaN66QiNuFYwTHc1heGjOL0ttVC8XYxBvUGrnr1E5BHTux4t7BxQ/83DusJ1VPpwxenpJZIMZn1iZb/OfZMrFhGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4aM9zD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8422BC43394;
	Mon, 22 Jan 2024 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936387;
	bh=Uye9Z16T4F7rnw5uWqM/ojOYrT953nGpjEqyI3AjPzY=;
	h=From:To:Cc:Subject:Date:From;
	b=s4aM9zD01Gyb+L/C/wj4XPSBnd6FmXXpz2gBDVi+AX/XieEjKtk0AOKOkIB1Kb1k6
	 TQMC6A6xTk8JBA22WLtF+WyKt+ZPrUOUcgvCl5fr9YzJUv/q+x1xiAfnXdE6pXp6nb
	 XRp91kmA0KpbqV0k9Iz/jsXoK4d0SYy4EecBKSFQ0vVxNg7YUh3GnbJAgoLpQWzY0o
	 E3TBh+qFD4ucxVFgd8ebcFjOfGsNwSLpRYAG1v+l04BaMp+CM/JEpoaSI6kRLPJ5LT
	 9ErnsxiWpG8lg+auhlyoFCP7y5zG3P4V5KOXrBGXhTxl7Rf0deOcuG/qY+mhrz3vKp
	 JiLV6VVHeAktA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 01/35] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:11:58 -0500
Message-ID: <20240122151302.995456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ba7eeb3c2738..da0801aa4118 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -657,7 +657,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -665,12 +674,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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


