Return-Path: <linux-kernel+bounces-124725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B4891BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFBD1C26C97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90668146D4C;
	Fri, 29 Mar 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukg1yKLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311A177A9A;
	Fri, 29 Mar 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716017; cv=none; b=NpLmuz2R5Qxf1Co6SosAvipcZNhNG8JBMGiRt21nX6IYiZS3TYXaAtcxUNTe4MyWOjC9rXgnbZFOR3M3klL5qrBiDYjwCnX05yIa+PMIoImy19PZLzMZfTGQWrosIRp12yNoYfA2li9wtG81JQ97jNc3NEX4Row7JxRuJY8oiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716017; c=relaxed/simple;
	bh=unewMvCYxmOenMyhEJ0M480mxzurkE5usvV/94GPtlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqSybOTo92shaasjRxmhD+ZlzcTOWLqnAWGnFvC+167pnIRVbhQ3M/F1r3YFE74rvcOWrMKSElf2srqCdwb3Ycudj3+ZKljmY5p39pwAOxCBQniYr/MbmI38yAb4w2HG6pdpg0humgml6pjZd6YmZH6Ns7gq9tkDaRuk0SNc0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukg1yKLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA3CC433F1;
	Fri, 29 Mar 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716017;
	bh=unewMvCYxmOenMyhEJ0M480mxzurkE5usvV/94GPtlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ukg1yKLE1radBPclUPtBczeHuikqrAc7BlcvTj/Ttde6lrgrZDRcQsg65p8HseBFu
	 IyC1xM1TWgSWAwfJ5ITgacLqjXeHzuGic0STOeJAhM3w+mmHYlOgGeWDiBaTsBdVP+
	 mQnNWCIkAITs6Ll3ANx9QwZ14utOSAFPmFC0gn869P/M9Y28ZxjvrnW/eR1fL+iWXm
	 XQMBbEZ8jueTw/Wj11RGPIijilTEmOiHjjpqwJ/l+LKPVv5Sggmf9vOnpLE35i21eU
	 uBM++YXCt8gr/F2R8FWKeTIe9D3Legb001mfxY5E5vnhOsmIqVt/60Qt8u+Ex6Fgc0
	 bEQJ1G+4BJOSA==
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
	willy@infradead.org,
	princekumarmaurya06@gmail.com
Subject: [PATCH AUTOSEL 6.8 16/98] sysv: don't call sb_bread() with pointers_lock held
Date: Fri, 29 Mar 2024 08:36:47 -0400
Message-ID: <20240329123919.3087149-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


