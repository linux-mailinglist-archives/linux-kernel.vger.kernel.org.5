Return-Path: <linux-kernel+bounces-114620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B088908C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD31C2C573
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D142A3597;
	Sun, 24 Mar 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbvZ+zpT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20B233CFE;
	Sun, 24 Mar 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322280; cv=none; b=gmLalwHqbNlwCNVzvYaOAvYQq4gz2Jz7qqPVcwL3jZy2mXWotpp9FGqDwFe01dzFXD1X8mHHIruJyV7iwKglHQoWjmHISckm6hggjrymfHuYog16Kjtxr99ApayOLrhExXYNzFMCtf8gK2V8njAgq0pJclrr8milOkvSniTDq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322280; c=relaxed/simple;
	bh=Wb0lZEF+fzsfKq5nbyUbEiq7f5MQZ2qsQZlboYEXHig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhYwd0mhgboplfiCfQRLkMUtW1SsFAtv3tyZckALVUqDJ+Ys5YtfapzSYELaVhqjP5cYhbu7DeXGNToVWgh6pWRx78oixBOCAtSz3sKRPg00v1AAxOP16fTjtVjzrFyyEoi+wzM8D7yBrRsFo2keI7QeTOh6sEBGbFXZPzUyp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbvZ+zpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38FFC43390;
	Sun, 24 Mar 2024 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322279;
	bh=Wb0lZEF+fzsfKq5nbyUbEiq7f5MQZ2qsQZlboYEXHig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbvZ+zpTgUsVH6YYCdBdY0eHo6wpSgENIYlweNfMhu0ct/nbCYcscNO9PPC8Zp/gr
	 SCEdXcA6PYM0k6tlgoM3ScdxWc6bkpvzXQQ427WaHvxjEW1FjdklAGKWsvmNJ8sjRs
	 XxuQBssL10oHVanB0AbYeMDNFuOtH/b80qaUeW7kIn3llRljad8xX7IQ4KuglBa3NZ
	 MCne6Wf2o/wfUgNGhThBzMaiiJRA/22hLAzKdgbBCbnG11GH1OkfPFZXJRwOgfi7TN
	 9/i+U83lWvBnA1E2pRdxNFIiPikB9nJ6m5+uCi9orOtdSI/PWXA1vhO8xxurGW++g8
	 nLHIxqWJf82VA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 362/451] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
Date: Sun, 24 Mar 2024 19:10:38 -0400
Message-ID: <20240324231207.1351418-363-sashal@kernel.org>
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

[ Upstream commit 2f9420d3a94aeebd92db88f00f4f2f1a3bd3f6cf ]

- f2fs_disable_compressed_file
  - check inode_has_data
					- f2fs_file_mmap
					- mkwrite
					 - f2fs_get_block_locked
					 : update metadata in compressed
					   inode's disk layout
  - fi->i_flags &= ~F2FS_COMPR_FL
  - clear_inode_flag(inode, FI_COMPRESSED_FILE);

we should use i_sem lock to prevent above race case.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2afb91471b535..a81091a5e282d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4367,15 +4367,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	if (!f2fs_compressed_file(inode))
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
+
+	if (!f2fs_compressed_file(inode)) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return true;
-	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+	}
+	if (f2fs_is_mmap_file(inode) ||
+		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return false;
+	}
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
+
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	return true;
 }
 
-- 
2.43.0


