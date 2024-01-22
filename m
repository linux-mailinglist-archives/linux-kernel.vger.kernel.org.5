Return-Path: <linux-kernel+bounces-33494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F454836A50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033072835E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9A3FB12;
	Mon, 22 Jan 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+HEGo5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D753FB0D;
	Mon, 22 Jan 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936526; cv=none; b=YfraU8cIMvbLwDmlMvOoQG7pubry6zguUVVfZQkNzqszSDWC8ebSZDVxFdjRl56cYAzJHMNwrsiOBfg3vo0xxI7yj7owSfWcJsv7ZK+/L3Zw0tmdh/m7lJqZoRul2G2U5AZYPJLQKxWVnLi2TkUPsSlJjPkUmxrQsDusOXlRcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936526; c=relaxed/simple;
	bh=z/q4voB+EPDamF3u0eqwmT9u48yKxLVPnuOYra/Tn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmuyrInb02QjsTyvT3Mj2yAINklAZwnQd0FcxIvJ28SnBL/L/mWtqHm7TXG6xseAzJX8y8TWnTeLwkg3XN7fDBNZEzIdULac6qMzXEz3KJJ0vYq6vhPyvm+ayZ5x4MVlljVWe5g8u1pxSmkMXlbgbbEMT0xizO8jNs2I51T5BdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+HEGo5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB0AC433C7;
	Mon, 22 Jan 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936524;
	bh=z/q4voB+EPDamF3u0eqwmT9u48yKxLVPnuOYra/Tn6c=;
	h=From:To:Cc:Subject:Date:From;
	b=B+HEGo5HkIk+FQS/1l2VcoUlMcdzwvCuWENhqcYVt5nTr0BzGycBBCWHZxrQ4LoNl
	 pCTG83j3ydR9lSQJnH7D+df2lKleegK4fRzIg10cNte5BK2WfnqrLnkyJBt/jjGS+C
	 mudfXslXm1C33FwwgnosQvjufbx2E4xcPHOtbwsk9LkKl7jPhas2AZn0oVwr0fyaae
	 qa9WrGjm/Ysbv+dCAgEwg9ihE9xQmwo8979YAItR3bCPvVRMgsGUQlepbUlwekC3tk
	 Fwh2n+vZS1kP7/YQok1qqcX8K9XrxFmQzGSRKxDqIlHJl/OTJb1Gli9cMjcpUiHt7c
	 SnYR7RFIJoO1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 01/28] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 10:14:27 -0500
Message-ID: <20240122151521.996443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index c3c527afdd07..2700e0fdd3e0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -641,7 +641,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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
 
@@ -649,12 +658,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
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


