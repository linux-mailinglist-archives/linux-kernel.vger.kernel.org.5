Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9179EDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjIMPv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjIMPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72C0BE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694620267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=YOIimXAa4BnacYFigSUrd1F+Xa9jb+T8PxsuF24Vw+o=;
        b=ResrXRHn3CQwn21zxVIuGsFVVqdV7H0dO9JvxAHswicaq2NyzB2cf5pNeoykcozvevbuVK
        rhc9qgqb5BVn0PSXGVrz40JXrWp4O21b/yLy9imCSTFYHHU0sj0/jASuKuVbyR+R1u+jKQ
        auFYY9liN/BgEXncTFylp3x8XspEl2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518--MmqiAbIOYmQToADvHS67Q-1; Wed, 13 Sep 2023 11:51:05 -0400
X-MC-Unique: -MmqiAbIOYmQToADvHS67Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5976F801779;
        Wed, 13 Sep 2023 15:51:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id D291D10085AA;
        Wed, 13 Sep 2023 15:51:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 17:50:13 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:50:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] time,signal: turn signal_struct.stats_lock into
 seqcount_rwlock_t
Message-ID: <20230913155009.GA26255@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154907.GA26210@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way thread_group_cputime() doesn't exclude other readers on the
2nd pass.

thread_group_cputime() still needs to disable irqs because stats_lock
nests inside siglock. But once we change the getrusage()-like users to
rely on stats_lock we can remove this dependency, and after that there
will be no need for _irqsave.

And IIUC, this is the bugfix for CONFIG_PREEMPT_RT? Before this patch
read_seqbegin_or_lock() can spin in __read_seqcount_begin() while the
write_seqlock(stats_lock) section was preempted.

While at it, change the main loop to use __for_each_thread(sig, t).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h |  4 +++-
 kernel/exit.c                | 12 ++++++++----
 kernel/fork.c                |  3 ++-
 kernel/sched/cputime.c       | 10 ++++++----
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d7fa3ca2fa53..c7c0928b877d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -182,7 +182,9 @@ struct signal_struct {
 	 * Live threads maintain their own counters and add to these
 	 * in __exit_signal, except for the group leader.
 	 */
-	seqlock_t stats_lock;
+	rwlock_t stats_lock;
+	seqcount_rwlock_t stats_seqc;
+
 	u64 utime, stime, cutime, cstime;
 	u64 gtime;
 	u64 cgtime;
diff --git a/kernel/exit.c b/kernel/exit.c
index f3ba4b97a7d9..8dedb7138f9c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -182,7 +182,8 @@ static void __exit_signal(struct task_struct *tsk)
 	 * see the empty ->thread_head list.
 	 */
 	task_cputime(tsk, &utime, &stime);
-	write_seqlock(&sig->stats_lock);
+	write_lock(&sig->stats_lock);
+	write_seqcount_begin(&sig->stats_seqc);
 	sig->utime += utime;
 	sig->stime += stime;
 	sig->gtime += task_gtime(tsk);
@@ -196,7 +197,8 @@ static void __exit_signal(struct task_struct *tsk)
 	sig->sum_sched_runtime += tsk->se.sum_exec_runtime;
 	sig->nr_threads--;
 	__unhash_process(tsk, group_dead);
-	write_sequnlock(&sig->stats_lock);
+	write_seqcount_end(&sig->stats_seqc);
+	write_unlock(&sig->stats_lock);
 
 	/*
 	 * Do this under ->siglock, we can race with another thread
@@ -1160,7 +1162,8 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		 */
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
 		spin_lock_irq(&current->sighand->siglock);
-		write_seqlock(&psig->stats_lock);
+		write_lock(&psig->stats_lock);
+		write_seqcount_begin(&psig->stats_seqc);
 		psig->cutime += tgutime + sig->cutime;
 		psig->cstime += tgstime + sig->cstime;
 		psig->cgtime += task_gtime(p) + sig->gtime + sig->cgtime;
@@ -1183,7 +1186,8 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 			psig->cmaxrss = maxrss;
 		task_io_accounting_add(&psig->ioac, &p->ioac);
 		task_io_accounting_add(&psig->ioac, &sig->ioac);
-		write_sequnlock(&psig->stats_lock);
+		write_seqcount_end(&psig->stats_seqc);
+		write_unlock(&psig->stats_lock);
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b9d3aa493bbd..bbd5604053f8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1870,7 +1870,8 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	sig->curr_target = tsk;
 	init_sigpending(&sig->shared_pending);
 	INIT_HLIST_HEAD(&sig->multiprocess);
-	seqlock_init(&sig->stats_lock);
+	rwlock_init(&sig->stats_lock);
+	seqcount_rwlock_init(&sig->stats_seqc, &sig->stats_lock);
 	prev_cputime_init(&sig->prev_cputime);
 
 #ifdef CONFIG_POSIX_TIMERS
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..bd6a85bd2a49 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -333,12 +333,13 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	nextseq = 0;
 	do {
 		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+		flags = read_seqcount_begin_or_lock_irqsave(&sig->stats_seqc,
+						     &sig->stats_lock, &seq);
 		times->utime = sig->utime;
 		times->stime = sig->stime;
 		times->sum_exec_runtime = sig->sum_sched_runtime;
 
-		for_each_thread(tsk, t) {
+		__for_each_thread(sig, t) {
 			task_cputime(t, &utime, &stime);
 			times->utime += utime;
 			times->stime += stime;
@@ -346,8 +347,9 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 		}
 		/* If lockless access failed, take the lock. */
 		nextseq = 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	} while (need_seqcount_retry(&sig->stats_seqc, seq));
+	done_seqcount_retry_irqrestore(&sig->stats_seqc, &sig->stats_lock,
+					seq, flags);
 	rcu_read_unlock();
 }
 
-- 
2.25.1.362.g51ebf55

