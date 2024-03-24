Return-Path: <linux-kernel+bounces-113454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8ED888477
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3721C23D66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B01AFCE7;
	Sun, 24 Mar 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7D56RiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0691AFCC8;
	Sun, 24 Mar 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320256; cv=none; b=GgxzEGiAF/oqXOz5hJ0Vgg92rvyVthxTwxWBAwo3aQXFXf/3uD1ImfjaEry7rsuIiVt19vTjiR1gdwmZKex/G5P7MIjGY4OrxMWOMbnsGtJ00gHGI0SSN4utRnyQlHJtjod5wRissFJQj835aAOoD7q4IQ0QagJHofrSAQsiy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320256; c=relaxed/simple;
	bh=rUtiUbwYRLHWShPE8poEYtCKwElA8naS8Pl1LW03mZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5+53CQEA3ONa9WfAYjacVhqfXULogHfzybQKD7CfJKcxrTeZBn4gcnlnLbct04IHfR/Pna8Ggh2UL/PHdEOsOsqQzADNlGRy+yr+5BB9JT9456Y8HU83k5pR2IgnIJGj6/NSO7zqZkZRIj5O/lWaJFJl2E9b4l+ccGLH4PTizQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7D56RiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166F6C43390;
	Sun, 24 Mar 2024 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320255;
	bh=rUtiUbwYRLHWShPE8poEYtCKwElA8naS8Pl1LW03mZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7D56RiPXc75DP6LsMQuAdXKK07tv7ssjFPfpc5DcbUl8zjlgkzXF+kFTnO2HnqwS
	 Y+oF9HuOTDu/NO4SCCDVkvFtYxaEhW2IkjXrcwgUoFFJ3OZBBJKZNPiF48Uhm4V8sk
	 gTOQd4o6ey1zQnELJ7XEDFH5W8AphLVqLnaX0SvMMdrwrdWvgdwxJllA9nIofeOQR+
	 +KRj6e1uCxfddDWYt72jVmbmtgzmBz/xaRDf6xT0iESQu/t+SCAS6BoF4pysVmdskb
	 3y37dDN0n9/Sf8LK0XNy0/HTUogVW5rYT4FyTsjTIbf8vJCgeRlWrAAN74Kx2O8KVP
	 wemkdK/ityDsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 563/715] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Sun, 24 Mar 2024 18:32:22 -0400
Message-ID: <20240324223455.1342824-564-sashal@kernel.org>
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

[ Upstream commit b896e302f79678451a94769ddd9e52e954c64fbb ]

verify_blkaddr() will trigger panic once we inject fault into
f2fs_is_valid_blkaddr(), fix to remove this unnecessary f2fs_bug_on().

Fixes: 18792e64c86d ("f2fs: support fault injection for f2fs_is_valid_blkaddr()")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9fd2143378952..e4e249dd4c712 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3470,11 +3470,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type))
 		f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to fix.",
 			 blkaddr, type);
-		f2fs_bug_on(sbi, 1);
-	}
 }
 
 static inline bool __is_valid_data_blkaddr(block_t blkaddr)
-- 
2.43.0


