Return-Path: <linux-kernel+bounces-33333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C667C836889
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605DCB2B9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212D6166F;
	Mon, 22 Jan 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXbwIliP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D4482C8;
	Mon, 22 Jan 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935908; cv=none; b=Fbx05r5qB22/f56+hBURhDG/j8bZBpoPmTUPjAMi0X3dN0UNMVDskQ+6JfCa5H0dli6XlZ5Li2m7lN1grLRKXZi01/pxLeTlPLSu0G2hH017pFxZ+j5R4eh4LRQ3stViWUJQSYNywuluxrld1efGr8BD33PwQdgt+nvNmgvrFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935908; c=relaxed/simple;
	bh=78geT9fVOQTEOWX4gyPh1xA3/6G3VJHkoN6RKZ9rGu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYDWOcCzL7aVOZqdeaGK4mYuonQ0fH3LOdO0HzVQv442n7JedfLmg+Y+QnOtVdBQNoM8KiNGbTQPo0NKSWjl/Djp9zCwftTt08RbiaWZsQ0cymCVc9hNDScMH/gHqQD6A8FZ3BGoXmnUvPYBnln4MciKoKZpsTNt5Kh/wc+GIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXbwIliP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5B4C43390;
	Mon, 22 Jan 2024 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935907;
	bh=78geT9fVOQTEOWX4gyPh1xA3/6G3VJHkoN6RKZ9rGu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXbwIliPqn/P2ZpWtB+N7gFXpP7miUZH9xSrxg3YB5vtG/GNJ4z7QY/R3rb5mFVli
	 7+l9LT6KksGIAxqNRNUjF0kyGRch4VikRpz0Vqg1iTaVfVNzojrq86g+qlLbEmjWJv
	 sFPSuzGDNUqc8GjHTXriUrU8EMyQwB3jMseQy3R4CNOAUpZNm73DSCbjTrOy6cGxAA
	 DBp/5kMl9/hj9YOZjjgH1KMz33IfCJVBjLOdjktXw45DOKEYUg6hfunMfKLIZHHEbx
	 H+G77qsnXnre/nYjw0aHIB/fRirSi1k0visbWmheN/4tiEGunyeN+tfiOxRHCmwVi9
	 LscWGxVokJIQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Sasha Levin <sashal@kernel.org>,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 13/73] f2fs: fix write pointers on zoned device after roll forward
Date: Mon, 22 Jan 2024 10:01:27 -0500
Message-ID: <20240122150432.992458-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 9dad4d964291295ef48243d4e03972b85138bc9f ]

1. do roll forward recovery
2. update current segments pointers
3. fix the entire zones' write pointers
4. do checkpoint

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f0de36ef73c2..c8ba9f1551b6 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -917,6 +917,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0


