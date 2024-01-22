Return-Path: <linux-kernel+bounces-33501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1D836A66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD11C23C66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2513B7BE;
	Mon, 22 Jan 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La00eq5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2D13B7AF;
	Mon, 22 Jan 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936541; cv=none; b=oRF6ObFKm+ebBaZu38R6TVp6DVaWkbHg8i+zQW0pzGX3xWaIJznTQYczeoCnxZysopKYoY3OEe9J+oYWK3xAZ9F+dv2n3as6rdQb65GKGBt+ifSmMIqrvpkUIMtNg7wsR50ykylJlFsFfNydob2dSpDQudKwPCB/8pTSX3rxtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936541; c=relaxed/simple;
	bh=jjJkIUKUyYnSCAg2CihNAepIP4V3HGMLbqd+zqHbcZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf/Ynt2+8QasiMuxL24lYx9eD43uqmIqOGqstlxnGcRQJp7ITW9Bez0PK5l2LT90OT1D4NNHisfcwJImx9lJrib/9ZCfQAA7zOZtlANJk4G1oi7zHl07sRvqxWJw8EU7YHaXV8GamZ5NHHB7j6pH9iUosY0OMoeYYRBjsgO1Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La00eq5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57ADC43394;
	Mon, 22 Jan 2024 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936541;
	bh=jjJkIUKUyYnSCAg2CihNAepIP4V3HGMLbqd+zqHbcZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=La00eq5xlmFXXItZX2M21BOtDQuXelJmVa0G3Tne0RtBzNThFiuTAuBIeWYoKdclE
	 4a4HFSBH8yxhAUZoLLKPGldzWdVb5gYwHgYHhvtUvs4pgD0I/pbP2zX3sUbIgNULK7
	 D+FQqKT2tSsJvQvPrxnH9/r/S/xhN2vokreAIsNTBBQZyaFApgxCbOEwks3ITqMtOy
	 x+sDQjiXGt274L/JtLnlJmnTtu8+FSD3v5i6nPNHbmIkU3a2wuYrRuktHr6UfGX86/
	 5JDkfmZ1HoHgv+jmpO/5MfJdij+YRsb9HzIYinJQD+lXEufHdXzSaNV5yk3/lCjIiU
	 iCZmUaq1k96CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Sasha Levin <sashal@kernel.org>,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 08/28] f2fs: fix write pointers on zoned device after roll forward
Date: Mon, 22 Jan 2024 10:14:34 -0500
Message-ID: <20240122151521.996443-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
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
index 2700e0fdd3e0..cd56af93df42 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -855,6 +855,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0


