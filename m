Return-Path: <linux-kernel+bounces-101933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A073487ACD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56354285088
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4B131E4E;
	Wed, 13 Mar 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1GhBVBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A7131733;
	Wed, 13 Mar 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348077; cv=none; b=ZXHGUQ7zoKNX8l++F+uFoP1iBs6n0L6pEGOIZq0FuE007hFgM6HPxgcp9Vl/QsQAlWaXU4XtkZAAr4AnEh56NwHd4DXB6m3j9m3Az9pWrPXS+mV9ZtQnlABAycESS1B/7j1N5IrFg/DTelnnUfuH+Z5l9YUfSrkIvaYifzMjW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348077; c=relaxed/simple;
	bh=kf81Nn6gwkP79bHbEOQ98d8m85pVfVlKTZaXwUCbYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMJTBDKfJffJ0H74lzV0OG+xgXoFX3pfe7adtSeCP0L2hYQmuimtjj3nrIJTCV6XPSnVwLHd8r2TKIppkcBOidSsXcR63Hn3Q6V+hlG9ZxbCVSwcVw9NxcNZejjNSvhzIAYphvhv78ruGJhuz6X4vOIILo3U4TJGCZqqF8CYQ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1GhBVBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DCFC43390;
	Wed, 13 Mar 2024 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348076;
	bh=kf81Nn6gwkP79bHbEOQ98d8m85pVfVlKTZaXwUCbYWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1GhBVBexCqi0BMBJ9NXalj04xwuDLE7h96nq+GaPFQT0Ub9pW0kqkcMO2Wli7C0k
	 S39K56xaw4IcolC0VzRMHJXwaJkDYg7638t+Effpw/9wCN9P2Hg/JLNCQxicSfr/SS
	 j67bBeqYEALNrMWjNZ34mo9MQ906ecQjpuI8GAVr+P/AFLN4T/nKm8iqrSrquENv7W
	 5MJbcBMgBof4VLrMHOnPLpbBDjYYZLr2U1xx81WyRRM8NDlozfEPOxCH6Y3XCDc5HI
	 9ZoPtkoWN/5PFQxfihEJqXP64+x++aNprMW+MizaQMXg3xDGRpg7a2Y9qxUbi+K81q
	 5jutT5VDiCr3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 65/71] getrusage: use sig->stats_lock rather than lock_task_sighand()
Date: Wed, 13 Mar 2024 12:39:51 -0400
Message-ID: <20240313163957.615276-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit f7ec1cd5cc7ef3ad964b677ba82b8b77f1c93009 ]

lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
getrusage() at the same time and the process has NR_THREADS, spin_lock_irq
will spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change getrusage() to use sig->stats_lock, it was specifically designed
for this type of use. This way it runs lockless in the likely case.

TODO:
	- Change do_task_stat() to use sig->stats_lock too, then we can
	  remove spin_lock_irq(siglock) in wait_task_zombie().

	- Turn sig->stats_lock into seqcount_rwlock_t, this way the
	  readers in the slow mode won't exclude each other. See
	  https://lore.kernel.org/all/20230913154907.GA26210@redhat.com/

	- stats_lock has to disable irqs because ->siglock can be taken
	  in irq context, it would be very nice to change __exit_signal()
	  to avoid the siglock->stats_lock dependency.

Link: https://lkml.kernel.org/r/20240122155053.GA26214@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Dylan Hatch <dylanbhatch@google.com>
Tested-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 04102538cf43f..d06eda1387b69 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1781,7 +1781,9 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long maxrss;
 	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
+retry:
 	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
 	maxrss = 0;
@@ -1793,8 +1795,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
@@ -1822,14 +1823,23 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
+
+		rcu_read_lock();
 		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
+		rcu_read_unlock();
+
 		break;
 
 	default:
 		BUG();
 	}
-	unlock_task_sighand(p, &flags);
+
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
 	if (who == RUSAGE_CHILDREN)
 		goto out_children;
-- 
2.43.0


