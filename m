Return-Path: <linux-kernel+bounces-33524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5B836ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7C4281C65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729556759;
	Mon, 22 Jan 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxgWuOCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCD55C0A;
	Mon, 22 Jan 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936622; cv=none; b=i1bZSSq9Aqmcs8PMlZ98Yp1cWfV93dciWzJbtjOMUuTKiBnlcaSYYrAp6jAAuAWigyECRpt3SMSlJOirsxYK8Ma2jaDYfbfbo3Z2hqr4BNKVScyIP3ZeQ8KDX2XQQWe5GYe7D4ECqNv/3aDtEO5Gl2/ta/ZAr9i8ST6DhRtXhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936622; c=relaxed/simple;
	bh=PHlstZOn4P8fYiw3yCJ5n92bZwgwDCDEX6GCLi15oTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXSiN5n8yroFnI5NqMhiYUQyyK2XGF1MqkRwh9FWfJsNPZYo4RDBjmos4MLwAG3yukp55AUDoKCWKUIjs2yYPge80r01EILOyZdL9Qe3gDNSkCNh8CqG2wezN77n532R8z0ZHWbOnQOXoGAdHgt+R2f6Ek7Qq/OoZLL+xTA+rLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxgWuOCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E8C433C7;
	Mon, 22 Jan 2024 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936622;
	bh=PHlstZOn4P8fYiw3yCJ5n92bZwgwDCDEX6GCLi15oTY=;
	h=From:To:Cc:Subject:Date:From;
	b=HxgWuOCuZy8iHc4ax3wwEp6au9fDDN93g+tkSMEQ/hvLrtEDziJLyzKTmqk5NhHzc
	 PFDlgPALSVtgLbsIJUchV5aNvia9Hc1I0RFFbIfBTVdgwoIJndAFaGf6941qD8mf2p
	 /jdA32X1OYqTwt7E3Ae/cmDPBxeLU/9+lV+P5Y/q8rTKFZ0VJr979M/mGTP/i0H2ik
	 g6v9DDhKPFi74lAaJzK3NpLsHYGvfB/KDg8BAhje4y3cGFcJmtv2fI/NHnOlRgJO3Q
	 8NW6D1UIdB0YnYCiUz6qJ3wxZfKM2u9PPk7HZok6VjTwM4avbsRDv1Qud08aSl0XOB
	 i37RLpXhcceUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 01/24] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:16:15 -0500
Message-ID: <20240122151659.997085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index da123c6d3ce0..7e30326b296c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -611,7 +611,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -619,12 +628,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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


