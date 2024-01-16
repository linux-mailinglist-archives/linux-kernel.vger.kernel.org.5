Return-Path: <linux-kernel+bounces-26769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1923F82E602
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A502843E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFB20330;
	Tue, 16 Jan 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJzIKKez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59A4F1F5;
	Tue, 16 Jan 2024 00:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853A2C433C7;
	Tue, 16 Jan 2024 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364813;
	bh=SoixcK9V/FIxkFV7jO31TVWonuK2Ri5TI6NpucPPDEY=;
	h=From:To:Cc:Subject:Date:From;
	b=FJzIKKezdJ84tG4LC9uXI0oUpOPiVKnKCagSL4iGbOUWp5ZQsALxCkNbM5bx1jLPp
	 GiP+onyQSv13O7f08QsbwIEVb330EU3mlWFx7GeQy9n4RKJ1Ljx7WtoAaS9Vr3dbPE
	 pAAwKT9Q58oMPkMWxgk1vf5UyjTGBxqJDJ6YiI599p2bsHZlqhLWCp04MxVx7vjYUV
	 zXIcwkxNhJuUF57mLYgpdRqo/GgyJPyx5Pv357aEuAJdYdE0jq5XVBiNUE5ORzAm6V
	 bLaE23xQO5S+dFX6ObS2gJKLFz90jYbP/cK55oWXbiDFb6VQY0GKG5g5PGg1f82uAp
	 sVgoL2Y6siLUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Osama Muhammad <osmtendev@gmail.com>,
	syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	andrew.kanner@gmail.com,
	wonguk.lee1023@gmail.com,
	code@siddh.me,
	yogi.kernel@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 01/12] FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
Date: Mon, 15 Jan 2024 19:26:26 -0500
Message-ID: <20240116002649.216260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 9862ec7ac1cbc6eb5ee4a045b5d5b8edbb2f7e68 ]

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2867:6
index 196694 is out of range for type 's8[1365]' (aka 'signed char[1365]')
CPU: 1 PID: 109 Comm: jfsCommit Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 dbAdjTree+0x474/0x4f0 fs/jfs/jfs_dmap.c:2867
 dbJoin+0x210/0x2d0 fs/jfs/jfs_dmap.c:2834
 dbFreeBits+0x4eb/0xda0 fs/jfs/jfs_dmap.c:2331
 dbFreeDmap fs/jfs/jfs_dmap.c:2080 [inline]
 dbFree+0x343/0x650 fs/jfs/jfs_dmap.c:402
 txFreeMap+0x798/0xd50 fs/jfs/jfs_txnmgr.c:2534
 txUpdateMap+0x342/0x9e0
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2732
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 109 Comm: jfsCommit Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 panic+0x30f/0x770 kernel/panic.c:340
 check_panic_on_warn+0x82/0xa0 kernel/panic.c:236
 ubsan_epilogue lib/ubsan.c:223 [inline]
 __ubsan_handle_out_of_bounds+0x13c/0x150 lib/ubsan.c:348
 dbAdjTree+0x474/0x4f0 fs/jfs/jfs_dmap.c:2867
 dbJoin+0x210/0x2d0 fs/jfs/jfs_dmap.c:2834
 dbFreeBits+0x4eb/0xda0 fs/jfs/jfs_dmap.c:2331
 dbFreeDmap fs/jfs/jfs_dmap.c:2080 [inline]
 dbFree+0x343/0x650 fs/jfs/jfs_dmap.c:402
 txFreeMap+0x798/0xd50 fs/jfs/jfs_txnmgr.c:2534
 txUpdateMap+0x342/0x9e0
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2732
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

The issue is caused when the value of lp becomes greater than
CTLTREESIZE which is the max size of stree. Adding a simple check
solves this issue.

Dave:
As the function returns a void, good error handling
would require a more intrusive code reorganization, so I modified
Osama's patch at use WARN_ON_ONCE for lack of a cleaner option.

The patch is tested via syzbot.

Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 72eb5ed54c2a..985beb1c654d 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2935,6 +2935,9 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
+	if (WARN_ON_ONCE(lp >= CTLTREESIZE))
+		return;
+
 	if (tp->dmt_stree[lp] == newval)
 		return;
 
-- 
2.43.0


