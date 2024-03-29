Return-Path: <linux-kernel+bounces-124819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE7891CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD70C1F25F30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6E1A38CD;
	Fri, 29 Mar 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1iYFZoa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E761A0B13;
	Fri, 29 Mar 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716229; cv=none; b=B24qRW9JdOPaCnRPayXzFpWQL9BDuXAgdqepLTFiY0wbeMreaCweOawa1+acWvPmpUL8fVMu7aozzHmJiAIb5tf8d9LWVJfvqaIZ3gc0ZMfdDQBAVeeLM5tq+UXXpaRbCUsr29cslJLhC3Kg4GTYVvLj8PTmdmZ+/bRjP23Jqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716229; c=relaxed/simple;
	bh=vY2dHuMi+WBs3WDDgt1k83JDIfXf2frpp4A0vqx+Qsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVCDvxXBX6cL2DROno/Yt05UDgK2ADbcIUx4f7Bd9WNharQpsYochokwBtTtOmkmsBZHXW922DVkw6jGWSeGEeKAnLQhhUG8mpqIIq95olDVIHngPsDzPQouLb1lNuxTD3tFiF/2cgZeElETlta783CYxmO8NxucV4huJ+VcvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1iYFZoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64587C43390;
	Fri, 29 Mar 2024 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716229;
	bh=vY2dHuMi+WBs3WDDgt1k83JDIfXf2frpp4A0vqx+Qsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1iYFZoamENQdsEHgnPHzquJ3JPiNLLZtthxvdzwulG+KTrRzcd10kbJuw/Fhk6Yf
	 TLw3DJTujiASLoleV0NASPpLvvhDVm931TGeirhk2CmWj0SVQXlCC7kiWFG5NITAI6
	 A7PUBKc9GCowYjhU+N5X5S4DmVLeN6cwFcIFOt97pUGDwTZRwzCSF+BT9G/6pCrs5J
	 +vh/1IuM8x2k1rEjyBRqZzVbsnnRz3pmHmInZF/7eXb8h09IPIGwtT20A8X2ynDsHV
	 chJqJdka4BIILLH+NZbHdpiDmF1qjbiCP7o/4ou07GzhEsqDMTcHc2X5GRvYcosGto
	 qQK5uUgLw7a0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jlayton@kernel.org,
	jack@suse.cz,
	pc@manguebit.com,
	axboe@kernel.dk,
	princekumarmaurya06@gmail.com,
	willy@infradead.org
Subject: [PATCH AUTOSEL 6.6 10/75] sysv: don't call sb_bread() with pointers_lock held
Date: Fri, 29 Mar 2024 08:41:51 -0400
Message-ID: <20240329124330.3089520-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit f123dc86388cb669c3d6322702dc441abc35c31e ]

syzbot is reporting sleep in atomic context in SysV filesystem [1], for
sb_bread() is called with rw_spinlock held.

A "write_lock(&pointers_lock) => read_lock(&pointers_lock) deadlock" bug
and a "sb_bread() with write_lock(&pointers_lock)" bug were introduced by
"Replace BKL for chain locking with sysvfs-private rwlock" in Linux 2.5.12.

Then, "[PATCH] err1-40: sysvfs locking fix" in Linux 2.6.8 fixed the
former bug by moving pointers_lock lock to the callers, but instead
introduced a "sb_bread() with read_lock(&pointers_lock)" bug (which made
this problem easier to hit).

Al Viro suggested that why not to do like get_branch()/get_block()/
find_shared() in Minix filesystem does. And doing like that is almost a
revert of "[PATCH] err1-40: sysvfs locking fix" except that get_branch()
 from with find_shared() is called without write_lock(&pointers_lock).

Reported-by: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://lore.kernel.org/r/0d195f93-a22a-49a2-0020-103534d6f7f6@I-love.SAKURA.ne.jp
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/sysv/itree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index edb94e55de8e5..7b2a07a31e463 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -82,9 +82,6 @@ static inline sysv_zone_t *block_end(struct buffer_head *bh)
 	return (sysv_zone_t*)((char*)bh->b_data + bh->b_size);
 }
 
-/*
- * Requires read_lock(&pointers_lock) or write_lock(&pointers_lock)
- */
 static Indirect *get_branch(struct inode *inode,
 			    int depth,
 			    int offsets[],
@@ -104,15 +101,18 @@ static Indirect *get_branch(struct inode *inode,
 		bh = sb_bread(sb, block);
 		if (!bh)
 			goto failure;
+		read_lock(&pointers_lock);
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (sysv_zone_t*)bh->b_data + *++offsets);
+		read_unlock(&pointers_lock);
 		if (!p->key)
 			goto no_block;
 	}
 	return NULL;
 
 changed:
+	read_unlock(&pointers_lock);
 	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
@@ -218,9 +218,7 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 		goto out;
 
 reread:
-	read_lock(&pointers_lock);
 	partial = get_branch(inode, depth, offsets, chain, &err);
-	read_unlock(&pointers_lock);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -290,9 +288,9 @@ static Indirect *find_shared(struct inode *inode,
 	*top = 0;
 	for (k = depth; k > 1 && !offsets[k-1]; k--)
 		;
+	partial = get_branch(inode, k, offsets, chain, &err);
 
 	write_lock(&pointers_lock);
-	partial = get_branch(inode, k, offsets, chain, &err);
 	if (!partial)
 		partial = chain + k-1;
 	/*
-- 
2.43.0


