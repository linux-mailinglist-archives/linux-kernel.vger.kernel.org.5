Return-Path: <linux-kernel+bounces-102004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF187AD81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE461283047
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29A14BF5F;
	Wed, 13 Mar 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxBlwI3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6914BF4B;
	Wed, 13 Mar 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348217; cv=none; b=C2XQKC8wsEy5MXVGP1lDxoKA/JzI1HwRZEqGuuIo6YPkvMGFJuO59U+VHHNsBHlHk+kUDR/harG/E83LFy3cSy4oDjdSpOuuKjZfF0BlgsFio3RxuykbecLdmmL5kwD8yUz4/0wyzHJODLhiNmD7XtsKY8P4Gey30LBQaawNKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348217; c=relaxed/simple;
	bh=qhKKir9adXpVC5ZKe/JXK2kRFSMDfnJPV9kOB+uQ8ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXpOJjMisPZNRJp5eGCGklHOJ3+OyfEofHZibn8QolyeBWjruP8cyDKM582PpixOkdoJhmw9M49wc69wBWDokZQYFHXKS2p4TOpexbMqu+Kry6pKT3g/53ANxoF9UCplrYHXSvmJm/5iY4pixKilWixK8/l5ZHYZTB1eAqxseQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxBlwI3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA7C433C7;
	Wed, 13 Mar 2024 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348216;
	bh=qhKKir9adXpVC5ZKe/JXK2kRFSMDfnJPV9kOB+uQ8ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxBlwI3/nkayaPKS9q/ciYO8osQh0le6LPUyUizkWnm67atsPSkkSxFZ4qzGaiZ5u
	 9vJ0PtdAT5yjBv88S5yJkzSMGfJQ75gqjtixro9i7U4oriMPCUMXZaJK9qu8uzBWT6
	 XAZmXpWdC3DMiUekswZ0TOq9V3Q8Ee9I7YddK7OVGVDEEPOfDruvivIjhFyXuRC5EV
	 gezNK/ceLiq680pIHguIVHY376C7572YED0VnhvN+hmPkKI7aO2oii456TS2Hb1QKM
	 uqxZDnWDriviX2yKshWZosA/TQsG9H4WytT/G3oNr4HezHMgZeQBRBAC5weDkgXvst
	 DlkSsj2PFZUwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 63/76] getrusage: use sig->stats_lock rather than lock_task_sighand()
Date: Wed, 13 Mar 2024 12:42:10 -0400
Message-ID: <20240313164223.615640-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 85f358a5d5eb5..2cfb829864c63 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1766,7 +1766,9 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long maxrss;
 	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
+retry:
 	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
 	maxrss = 0;
@@ -1778,8 +1780,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
@@ -1807,14 +1808,23 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


