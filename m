Return-Path: <linux-kernel+bounces-33412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6883695F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E01C23BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65A4D131;
	Mon, 22 Jan 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrIClBIM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1384D128;
	Mon, 22 Jan 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936223; cv=none; b=CLU1eWI6yEtq47BjkVkrKHFavlnVUtdfGY+o+PJ1G5aEzG2Qn4EK+ki52mNVQfCqrKovaBzgWjyt2nFVikUC3QYBSZ3Axxu7jzNsobskAvdDnNNxk9lqMtcCPlVFLITbHcnm5dD6PZcHjtp2+keKkiduOozLQVxTgVfMd1xaUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936223; c=relaxed/simple;
	bh=+wKW6dOd2BKZIFOfovk64QUcGxJAwrPnaf1NJrqV4zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH5B9QaSusY1EG87I0NzWnWGEKLZvuPu6E546KOK2V5rAf9nVroBEuq9XVeG4/z4eTHw1buiiSVpMzEleAAxtwAZc7W6lJleUn9RraG9V4lLNlABtGSVeZcGreSVJPUvJIm7mpA97wx0IWAurrtqpY4AHn1wSrVK4tobqCx/ViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrIClBIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883CDC433A6;
	Mon, 22 Jan 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936222;
	bh=+wKW6dOd2BKZIFOfovk64QUcGxJAwrPnaf1NJrqV4zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrIClBIM2laoA9kpnX+tLt0M0ofKcvO/0etxaWJ6jIV/GE8n4L9LmiHQf6a/bDyky
	 bDNiZ4cBC/LFtzh+N8/4G7ZE0pJSfi3xx0XZ9XYZPw/MmQ9n5YtjFUQGZfNllhO/kY
	 F94id64ohN3axgXknWAqalWF4GajkhgRZn4QaPQky0OSFXWlK1qILtixR4fC4I+B1p
	 +Zl54LSq+oioioB3HHiZJgPsNDkp06f2r+arQolJI/ZlnAMP0nrdg72j1MzWrl6EGF
	 jOmAAll2Yee46C6oIQidsacwCeIlnBGeAPUX8NExP29wSA1Z+aSu5F6xnoC0vxZ40a
	 wVC90JKhNHfmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Sasha Levin <sashal@kernel.org>,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 12/53] f2fs: fix write pointers on zoned device after roll forward
Date: Mon, 22 Jan 2024 10:08:13 -0500
Message-ID: <20240122150949.994249-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 4f4db465220f..53a6487f91e4 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -898,6 +898,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0


