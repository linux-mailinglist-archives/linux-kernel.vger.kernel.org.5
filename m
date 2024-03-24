Return-Path: <linux-kernel+bounces-114639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA9888B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B28F1F27CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2B2A8758;
	Sun, 24 Mar 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGJbCzTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6C14E2F0;
	Sun, 24 Mar 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322296; cv=none; b=Qkl5J9i7MgQKxMvG99Yh91OFiRj4nUuvDHiYMh6EurKel3YWnf5OWSw0aKQiiH2faA+HLQHPZgH9Y3bhLpIWgS7n69lnbZNtDQX8WeXAuM13kLwc1H4cw4CQmjRQX+jZaV6Wbgc7UTmdXE5157FSb17nEYeMvANx/+inoqKbJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322296; c=relaxed/simple;
	bh=ngSfJ+aeTDJ4Ne1E/Vg0LioQ/JQJ6bf4Pus/aQBD2c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw4bFtox2WTTyCZMBGbK8V3H0YJUicb3vbNtLxi8FpykvaVwLMGacs7naF1BVPdeeMuZbSHpcZCijGUyFbmK5sHPLaHzjwbdaBoFiwYclXtSDhnXg9UeGZQML+YcNLcchiEqBuZDkc6AsqXFLFnL+KFEaFnWAmgaPs66jVvLifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGJbCzTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638F9C433C7;
	Sun, 24 Mar 2024 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322295;
	bh=ngSfJ+aeTDJ4Ne1E/Vg0LioQ/JQJ6bf4Pus/aQBD2c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGJbCzTcqcKvNe+5p7Thno9e9tvPzBa5g4qxAPshNjTJbNtlSB8IZAPavrXNvHIhp
	 IRkvGnNB28TtSnRSPAaNaxhXxx2KmadFlRYFT28DkDR0GR2qF4KNCdS/1N4GJoBb11
	 S2Devox4r/w8fO/0l0v4tuXDjwfmwslMqGO7DCPMdCICB+EbYDK+IGmdLobnUtdgVB
	 mrWmZuYHMUy0pktp54cAur59D2jmaWrUR1zLkREgHZ0BH6yqgXQ7s9VKalHB5oGO+C
	 a7NNuqBylgzX0rJQJ6gOZig4lY/aQz0qN2BV0gsifC+qH/KHbNS1VHddLrCX02I9k+
	 oFVl1vO4HKhaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 378/451] f2fs: convert to use sbi directly
Date: Sun, 24 Mar 2024 19:10:54 -0400
Message-ID: <20240324231207.1351418-379-sashal@kernel.org>
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

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit c3355ea9d82fe6b1a4226c9a7d311f9c5715b456 ]

F2FS_I_SB(inode) is redundant.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: b7d797d241c1 ("f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be4cab941d299..c787a3f408ab3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3462,7 +3462,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	int ret;
 	int writecount;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
 	if (!f2fs_compressed_file(inode))
@@ -3475,7 +3475,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
@@ -3644,7 +3644,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	unsigned int reserved_blocks = 0;
 	int ret;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
 	if (!f2fs_compressed_file(inode))
@@ -3660,7 +3660,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
@@ -4070,7 +4070,7 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
@@ -4142,7 +4142,7 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
-- 
2.43.0


