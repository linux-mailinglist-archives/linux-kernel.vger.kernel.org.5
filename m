Return-Path: <linux-kernel+bounces-33229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0C8366CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E092828AFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290464B5AD;
	Mon, 22 Jan 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca1/d30I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D83DB95;
	Mon, 22 Jan 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935410; cv=none; b=s4k37OMPDr0t7v8AftvKF5uARF80brEqI0Dip5D1UoVu87BWIwtmv+uWT1nhRQ4Qx+EVL4D8nnrxR4gL+OnUASLRmV2w5GD6jhkmFGYvzVoie2lMcQD0xjn64l5v4s6XVv12cZVoaxKHbyDYyWPz4cPnCdO1qtMUt35tJMUSGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935410; c=relaxed/simple;
	bh=y0weoZjaAER4fd5JnbyUGnSm+FqzRTJnMMaHVtDIdJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHknBD9QnHjfwdv3hia/rw/K5V0OBh3GOcEWXldhL/qFfBQO9QXjHyGHejKQrJv8LDD9ebCnSD03POQk7wbDjEhpAVUQOPUvqeU0UO/cOwI4P5drG4UE9PkCP1LwUDboM3lPqCsp8vv86UTsNHcjXyT8cvC3CthYD2p16Kxrn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca1/d30I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A20DC43394;
	Mon, 22 Jan 2024 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935410;
	bh=y0weoZjaAER4fd5JnbyUGnSm+FqzRTJnMMaHVtDIdJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ca1/d30IXwJm8hnvYz4SP9L6ZlokwJGouNJT0AdxfnI+ijapMOuef9bTRIprv101f
	 RUU15R0fsM8ZnAL4zWZmbrXbCp4nTrSiBCrYSoAutI7bbr7mtmmtIVzxTt5AMAUhxC
	 hhAHcX8acCMJUrF498LBGV7gYtMXWTFRhZeK3yWS91+ULVhPKiGOZq4uKVoMb+EndQ
	 BwNXRpU5+NClPasraCO8a0V258TbzyeuU/3UywguBSkovLGq7wA4P6qeTVw31MGlMF
	 N1+qOxOT1iv5lZayRI6WlT0Ft7LatGk65aDz9dIzxoUjYLhbVq9cRTcjewVCdpHWya
	 +HbIMOtZJ81dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Sasha Levin <sashal@kernel.org>,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.7 15/88] f2fs: fix write pointers on zoned device after roll forward
Date: Mon, 22 Jan 2024 09:50:48 -0500
Message-ID: <20240122145608.990137-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 16415c770b45..d0f24ccbd1ac 100644
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


