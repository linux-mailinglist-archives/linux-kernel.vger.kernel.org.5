Return-Path: <linux-kernel+bounces-101935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E787ACD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653AB2850BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032C133414;
	Wed, 13 Mar 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaFnLllt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DA1332A0;
	Wed, 13 Mar 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348079; cv=none; b=IjR6ozXBCF6SJPWwt+ANfjt44P2BgtqMoRWUikd7kGbKep/bqeZevpnlW9oucjD4eqHblXUXriZBFc2XmZAHrw1+CfBU4Gq6g/4G9MAHLZiVg0YoDlNyjNHsMKX+hJ6p3y6np3dbtMhVEOS6JbvsGpuuVfaFAEgsLibUppAZ2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348079; c=relaxed/simple;
	bh=eUYG8139G4/LZ8iaS64gMe5gXAMsInameY6my9JHNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQRUJUIeP4EnRi/YXweeAU0KeK6kRpmp1N/PBrhPD9LTvbjwFdw+5+51UhLOTnSRGrNkpjX5yoYxpjUYpSjJJ2lZtqdW1EDHdZlrYxsO0sVHCzvd00ntTNh+Y5tgqgdlJhuR1zDlM4Rzg+M3dTS7qsjhzybl8oGbWmjbz5bdbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaFnLllt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60076C433C7;
	Wed, 13 Mar 2024 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348079;
	bh=eUYG8139G4/LZ8iaS64gMe5gXAMsInameY6my9JHNTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaFnLllt+sIK9tOMmjjG7Rp1zCMwz0SsQ1yg6sY9BjqM9UexkfPG7HydSppsh0HPn
	 xfITJ551pLZtLnvCWbvlX1hSujsE8KsuajsSVlI7uQjk90w3mDqyTGKrB9g9HB2mOY
	 j4KiO9qTgQJbusyhY/lE1XMflDuFEDDIue9rl+J+5gn8xGPqvncZa4vGLKIoOXmaUj
	 FPDHiVfZ8616ykfKVscISj2P6QvNBvXfIkOJDSmDxLV23t0UqpzzZy0k5Vuk8QwBay
	 9ilIKH90LOCRkX7cFcR1AFIKZTaqRjkODUaU/U/XZbSLhmWJydfW1mf5kwloqZppas
	 UysdeO3j7XOSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 67/71] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Wed, 13 Mar 2024 12:39:53 -0400
Message-ID: <20240313163957.615276-68-sashal@kernel.org>
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

[ Upstream commit 7601df8031fd67310af891897ef6cc0df4209305 ]

lock_task_sighand() can trigger a hard lockup.  If NR_CPUS threads call
do_task_stat() at the same time and the process has NR_THREADS, it will
spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change do_task_stat() to use sig->stats_lock to gather the statistics
outside of ->siglock protected section, in the likely case this code will
run lockless.

Link: https://lkml.kernel.org/r/20240123153357.GA21857@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c | 58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index bcb645627991e..d210b2f8b7ed5 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -467,13 +467,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	int permitted;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0;
-	u64 cutime, cstime, utime, stime;
-	u64 cgtime, gtime;
+	unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
+	u64 cutime, cstime, cgtime, utime, stime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
 	int exit_code = task->exit_code;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -501,12 +501,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = 0;
-	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -517,27 +513,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
-		cmin_flt = sig->cmin_flt;
-		cmaj_flt = sig->cmaj_flt;
-		cutime = sig->cutime;
-		cstime = sig->cstime;
-		cgtime = sig->cgtime;
 		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
-			struct task_struct *t;
-
-			__for_each_thread(sig, t) {
-				min_flt += t->min_flt;
-				maj_flt += t->maj_flt;
-				gtime += task_gtime(t);
-			}
-
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
-			gtime += sig->gtime;
-
 			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
 				exit_code = sig->group_exit_code;
 		}
@@ -552,6 +530,34 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
+		cmin_flt = sig->cmin_flt;
+		cmaj_flt = sig->cmaj_flt;
+		cutime = sig->cutime;
+		cstime = sig->cstime;
+		cgtime = sig->cgtime;
+
+		if (whole) {
+			struct task_struct *t;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
+			__for_each_thread(sig, t) {
+				min_flt += t->min_flt;
+				maj_flt += t->maj_flt;
+				gtime += task_gtime(t);
+			}
+			rcu_read_unlock();
+		}
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
 	} else {
-- 
2.43.0


