Return-Path: <linux-kernel+bounces-159876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCE8B355B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574371C21367
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D0548FD;
	Fri, 26 Apr 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On42Bq5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1A1E522
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127739; cv=none; b=P3HURYA+D3qoS57o1KU54izG2RvtzEQVcySOq3JGfuJjw1TWu8tbV6FtbK2EQ35MWz6Eq8kkVXhbShdO1owmyVdC2YtLbMoGmR7zIYYb1IwZQB98+Kuc4gTebWaAQbyA00AJfQhoTxuXfAFwKsDeiBxEcu2ps66qakhiPjTD69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127739; c=relaxed/simple;
	bh=1M11MRI5r8LFTEUJBIZWj9DEeQPtq9UkmPXJoyrFJjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPZVrnH9IFPqt1UqEU3j8zs5lIQR1PReL9FxI4ylUuLo/5pjSRhF2ziRun7SkzEs1dtiLrn6sryrfrS8qVD/0fFzT3XC77SPlBRP80LVPjcL4d+LW6b5q3pTw51F32XZZQd2TwbzyrLk6P0bE1DOeIIKOjbHv+MTqW4ettu4GQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On42Bq5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13252C113CD;
	Fri, 26 Apr 2024 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714127738;
	bh=1M11MRI5r8LFTEUJBIZWj9DEeQPtq9UkmPXJoyrFJjU=;
	h=From:To:Cc:Subject:Date:From;
	b=On42Bq5KFzRD58lKilMe0u76cR7Lb3kLZv3yFI8/dRcW/gGFClfpRsUzevcZVZNBZ
	 zsbWa07OXKjttI4WUKybjCosSxNTxiz81HjVwR5jL22uF466Itlldl9ZoFA5rPvhFw
	 s535rAYULOBpDgV9LKQDSi9V0vIdHvGGcRPqWx76luyPwOOSRcg7dyQDcq6Bm1/J6Z
	 Xfq/0oPeWrixhzoWhwxR+xG+kYa3+IQODhMni99yh8KlFsdS3L1NHC0oPMjFwCX6eK
	 5gVO4BLYPFFONM0jLI2pq90md2EXzC2lHOQAI0IgxWEQN0rK1R+MXMPtfzqQSr57Rm
	 Hvi7an9EHuBXA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daeho43@gmail.com>
Subject: [PATCH] f2fs: zone: fix to don't trigger OPU on pinfile for direct IO
Date: Fri, 26 Apr 2024 18:35:28 +0800
Message-Id: <20240426103528.406063-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise, it breaks pinfile's sematics.

Cc: Daeho Jeong <daeho43@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bee1e45f76b8..e29000d83d52 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1596,7 +1596,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
+	    (is_hole || (flag == F2FS_GET_BLOCK_DIO && (f2fs_lfs_mode(sbi) &&
+	    (!f2fs_sb_has_blkzoned(sbi) || !f2fs_is_pinned_file(inode)))))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
-- 
2.40.1


