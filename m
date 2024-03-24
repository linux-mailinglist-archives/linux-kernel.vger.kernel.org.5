Return-Path: <linux-kernel+bounces-113921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4838888761
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F27F28623E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11821410E;
	Sun, 24 Mar 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM7+OqiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E31EE688;
	Sun, 24 Mar 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321013; cv=none; b=pRPoIIwiZzmoiEA1mMzURPw1bIVKw8CK5arnsmqb+jPxbL1M8Qh69P6/h2qrPcqOk3Mdszbi9BfaJlYcdLOzC/ykqis1nJD7tbasjwGUO2IXh57ZLvOg0cWjZ9iCfpxyHHIe7idhhnyFbdogeQUTevY+eeTxetS5GQBCngIalJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321013; c=relaxed/simple;
	bh=gWrnndJgT90FBfCRyWDVypTXyKWyM0DYGP+MkSD85nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kklm4gunwGXXBVCyfN5qlPIDaVwTjrzOauZxW+R2QwvV4R6tBsE0wtt2o5JouhnLC1qnO6E3YqWqTgejdveI677Tv9hwJ+ccsHBt9pV/4mF/0BqCm610pXLFJjZQVdfMQ5JY5VqGtzSmIvxFWn3EHaZyvAN3yb5qzO3sanrWcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM7+OqiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2AAC433A6;
	Sun, 24 Mar 2024 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321012;
	bh=gWrnndJgT90FBfCRyWDVypTXyKWyM0DYGP+MkSD85nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uM7+OqiHhwqtICvFahgReGEHhN9nVKxJVfh/O0Y2Kc8z2IOCKYAM/r72QTwhCsuo5
	 /du2VMARldH7oZfmENzgIVe0aGBgoAKsvD1GsIT09r28sU9B/bP1gRTADEv/3gHfkq
	 qmZxLG50mWV33NJr3HbsBbcsM7V0MVJZdEn9oYoWkYOYJXpBt2F6NqVHr5JgntvXb+
	 LPXRsdv9dAwsRUSfRoh3tfurM6XH1OXkdBUf/pSZy+wA0xrvlQFkQW0PR6PG5Li91E
	 rvGJE/v43T8qoPDHeb0mOue7irWcIE2nxb17DR+OTosw1YObTX0iOdALxR3ZT6zgGk
	 udbXzJYeYEjQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 575/713] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Sun, 24 Mar 2024 18:45:01 -0400
Message-ID: <20240324224720.1345309-576-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index fb355b9e2e3ca..2401d91ebc25a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3463,11 +3463,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
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


