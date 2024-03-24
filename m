Return-Path: <linux-kernel+bounces-112736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EA887DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59531C20A53
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BA19470;
	Sun, 24 Mar 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr06EP/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D3CA64;
	Sun, 24 Mar 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299955; cv=none; b=lsIPXVu8WYJgVAJyNYEbNvuQrwZZQE+lzy9n3DJEHhiidKbMsok1gOteuBbOC3sVeSOuR4J/4gdf8sBwzGR5k50PXWvGdrru4Ms6FrmAlTLCRSgC0X7CPDtWLdZgcrKE1G/AXgMfK3PMbxqAmtECteMkYsdPH/V6DV5DByLU5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299955; c=relaxed/simple;
	bh=unewMvCYxmOenMyhEJ0M480mxzurkE5usvV/94GPtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMMvd82pRUtx0RRsy2eah77CROyMgtMMoCXjFMLIr8DwS8+GzjD3tb88e1drHWe6ucKFoUTIE1A4CjC/6hek7wf6PKPyUR2ykqEHxLJ77RGaw+eA+Ew3674nBLV58Hv8tY03d8CSDUaVmDDEzm4mnZ7WRiPaOraLa3L3EVuRcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr06EP/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95794C433F1;
	Sun, 24 Mar 2024 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299955;
	bh=unewMvCYxmOenMyhEJ0M480mxzurkE5usvV/94GPtlY=;
	h=From:To:Cc:Subject:Date:From;
	b=Hr06EP/B+z0nCXY6hDQ2utZiJoaMqaVV8kigw1iM9kOewPnlDbspglA6mub/YAcMf
	 jDu5guh9tdhLZlIdw6N5dcRmzzCUGFpS6opWMVu7Hy4XyvHiazEb+Jf7gamVQKXOBc
	 7ws8DVRlgXYNqVRrmq3nvLxe7dXdMxYbHy35LJqEA1n1im9uYaUyDArSB60vHMt8uC
	 9BKRioU/CkpyiJLv15loguBbRAyGyQMfcnXIK2IDLykbQU3FiROYnebZncrDczLcyl
	 17Uuqcph/fSB0l5uDToRtqT50sr2r0RAiaCX0Wg78x5rj6YY3609rlGDfvFxGuN5Zi
	 H2d2Wrs3sh8Pw==
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
	xiubli@redhat.com,
	pc@manguebit.com,
	princekumarmaurya06@gmail.com,
	willy@infradead.org
Subject: [PATCH AUTOSEL 6.8 01/11] sysv: don't call sb_bread() with pointers_lock held
Date: Sun, 24 Mar 2024 13:05:36 -0400
Message-ID: <20240324170552.545730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.1
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
index 410ab2a44d2f6..19bcb51a22036 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -83,9 +83,6 @@ static inline sysv_zone_t *block_end(struct buffer_head *bh)
 	return (sysv_zone_t*)((char*)bh->b_data + bh->b_size);
 }
 
-/*
- * Requires read_lock(&pointers_lock) or write_lock(&pointers_lock)
- */
 static Indirect *get_branch(struct inode *inode,
 			    int depth,
 			    int offsets[],
@@ -105,15 +102,18 @@ static Indirect *get_branch(struct inode *inode,
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
@@ -219,9 +219,7 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 		goto out;
 
 reread:
-	read_lock(&pointers_lock);
 	partial = get_branch(inode, depth, offsets, chain, &err);
-	read_unlock(&pointers_lock);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -291,9 +289,9 @@ static Indirect *find_shared(struct inode *inode,
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


