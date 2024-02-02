Return-Path: <linux-kernel+bounces-50229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7352847610
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3141CB2BF26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8014AD24;
	Fri,  2 Feb 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHfavaIw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919314A4E6;
	Fri,  2 Feb 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894670; cv=none; b=EG84427Abg0NadoXRqYu76pY+DPdKKbPZ/pX83T3Tp1YGMbUPP9zRoYPD88ALuoWaxojCGkDb49uakuE0hQTIP1CK3VjFpYtjcFCokFfBDeoiuQts+X9OtqnKvGcYc0KFnmTHWbcGtDrzz76hEgCRlleE905GKNpZUbdPtpMx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894670; c=relaxed/simple;
	bh=gH6u2dryMc1Vv4IaCuQUmgGMrxBT1ABnbHkcvmr2Kls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjJ+hpiMvNGlAAfx6qDMEpMTbETozxANpp4BQN7/U/gtc4Y+BbHDGyXB9KnsKzwP6N0+1kgYdPigRv3vEaK6yMbfg8ciLlywt3MMiIky5D8Opw72JPdknZ9OqQUaK3qVHz7KTDyq55u7yJtmKHU3IwxwqF3QqzMhMi32bLCrvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHfavaIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A142CC433C7;
	Fri,  2 Feb 2024 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706894670;
	bh=gH6u2dryMc1Vv4IaCuQUmgGMrxBT1ABnbHkcvmr2Kls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHfavaIwJcuEltLM4CaMAZdOSujQf9s99qiO7U6saUKHfRM3/+cElbcdOtbm4IlR4
	 k/6pSEKxTgrdvRaKWRICEznqNVUolonXxp5A87S4QelpX5745P9/tiA6ZMwECiWsYE
	 iBic5sCq7POf14YeXxjOjXTdwNRhl+6jyjZfwpC7ZDmIOoTFo9lOBjN2dI3tHV88uI
	 n6UhUQkkFy2ThD+bAnVNOqv5maAd/9vQN51fWu61AoMrHdK4v4ojcrM8b/wxJkeb+X
	 qnOxWolijJAqUz1hcorJpBwk4+0txH/idGc2WMbIelegU9MiH3ALy4cspOD0ycrHSV
	 KimIJ/XmpEoCw==
Date: Fri, 2 Feb 2024 18:24:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jrozykordr44ab6z"
Content-Disposition: inline
In-Reply-To: <20240202160704.GA5850@redhat.com>


--jrozykordr44ab6z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> I think we need a simpler patch. I was going to send it as 4/4, but I'd
> like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
> and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or

Right, I didn't go that far.

> at least provided more info.
> 
> 3 notes for now:
> 
> 	1. we can't use wake_up_poll(), it passes nr_exclusive => 1

Bah. So we need the same stuff we did for io_uring and use
__wake_up() directly. Or we add wake_up_all_poll() and convert the other
three callsites:

// uncompiled, untested

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..210ee0d69b6f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -234,6 +234,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)                                                     \
        __wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+#define wake_up_all_poll(x, m)                                                 \
+       __wake_up(x, TASK_NORMAL, 0, poll_to_key(m))
 #define wake_up_poll_on_current_cpu(x, m)                                      \
        __wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)                                              \
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 04e33f25919c..65dcd5dc9645 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -228,8 +228,7 @@ static inline void io_commit_cqring(struct io_ring_ctx *ctx)
 static inline void io_poll_wq_wake(struct io_ring_ctx *ctx)
 {
        if (wq_has_sleeper(&ctx->poll_wq))
-               __wake_up(&ctx->poll_wq, TASK_NORMAL, 0,
-                               poll_to_key(EPOLL_URING_WAKE | EPOLLIN));
+               wake_up_all_poll(&ctx->poll_wq, EPOLL_URING_WAKE | EPOLLIN);
 }

 static inline void io_cqring_wake(struct io_ring_ctx *ctx)
@@ -245,8 +244,7 @@ static inline void io_cqring_wake(struct io_ring_ctx *ctx)
         * epoll and should terminate multishot poll at that point.
         */
        if (wq_has_sleeper(&ctx->cq_wait))
-               __wake_up(&ctx->cq_wait, TASK_NORMAL, 0,
-                               poll_to_key(EPOLL_URING_WAKE | EPOLLIN));
+               wake_up_all_poll(&ctx->cq_wait, EPOLL_URING_WAKE | EPOLLIN);
 }

 static inline bool io_sqring_full(struct io_ring_ctx *ctx)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..ee849fb35603 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -208,7 +208,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync);  /* For internal
use only */

 void __wake_up_pollfree(struct wait_queue_head *wq_head)
  {
  -       __wake_up(wq_head, TASK_NORMAL, 0, poll_to_key(EPOLLHUP |
  POLLFREE));
  +       wake_up_all_poll(wq_head, EPOLLHUP | POLLFREE);
          /* POLLFREE must have cleared the queue. */
	          WARN_ON_ONCE(waitqueue_active(wq_head));
		   }

> 
> 	2. exit_notify() should not pass EPOLLHUP to wake_up, we do
> 	   not want to wake up the { .events = POLLHUP } waiters.

Indeed.

> 
> 	3. we do not need to change __change_pid().
> 
> 	   Well, _perhaps_ it can/should use __wake_up_pollfree(), but
> 	   I need to check if fs/select.c use "autoremove" or not.
> 
> 
> > -static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > +static __poll_t pidfd_poll(struct file *file, poll_table *wait)
> >  {
> >  	struct pid *pid = file->private_data;
> >  	bool thread = file->f_flags & PIDFD_THREAD;
> >  	struct task_struct *task;
> >  	__poll_t poll_flags = 0;
> >  
> > -	poll_wait(file, &pid->wait_pidfd, pts);
> > +	poll_wait(file, &pid->wait_pidfd, wait);
> 
> This is correct but only cosemtic and has nothing to do with what
> we discuss?

No, I just folded all of the changes because it was just a draft. See
the updated draft I appended.

--jrozykordr44ab6z
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-UNTESTED-UNCOMPILED.patch"

From 1a026da491f1262dc525933c73b90b6297abf5da Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Feb 2024 18:21:19 +0100
Subject: [PATCH] [UNTESTED][UNCOMPILED]

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h  |  2 +-
 include/linux/wait.h |  2 ++
 io_uring/io_uring.h  |  6 ++----
 kernel/exit.c        |  2 +-
 kernel/fork.c        |  4 ++--
 kernel/sched/wait.c  |  2 +-
 kernel/signal.c      | 11 +++++------
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 8124d57752b9..b261cd53517d 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -74,7 +74,7 @@ struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
-void do_notify_pidfd(struct task_struct *task);
+void pidfd_wake_up_poll(struct task_struct *task, bool dead);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..210ee0d69b6f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -234,6 +234,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)							\
 	__wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+#define wake_up_all_poll(x, m)							\
+	__wake_up(x, TASK_NORMAL, 0, poll_to_key(m))
 #define wake_up_poll_on_current_cpu(x, m)					\
 	__wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)						\
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 04e33f25919c..65dcd5dc9645 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -228,8 +228,7 @@ static inline void io_commit_cqring(struct io_ring_ctx *ctx)
 static inline void io_poll_wq_wake(struct io_ring_ctx *ctx)
 {
 	if (wq_has_sleeper(&ctx->poll_wq))
-		__wake_up(&ctx->poll_wq, TASK_NORMAL, 0,
-				poll_to_key(EPOLL_URING_WAKE | EPOLLIN));
+		wake_up_all_poll(&ctx->poll_wq, EPOLL_URING_WAKE | EPOLLIN);
 }
 
 static inline void io_cqring_wake(struct io_ring_ctx *ctx)
@@ -245,8 +244,7 @@ static inline void io_cqring_wake(struct io_ring_ctx *ctx)
 	 * epoll and should terminate multishot poll at that point.
 	 */
 	if (wq_has_sleeper(&ctx->cq_wait))
-		__wake_up(&ctx->cq_wait, TASK_NORMAL, 0,
-				poll_to_key(EPOLL_URING_WAKE | EPOLLIN));
+		wake_up_all_poll(&ctx->cq_wait, EPOLL_URING_WAKE | EPOLLIN);
 }
 
 static inline bool io_sqring_full(struct io_ring_ctx *ctx)
diff --git a/kernel/exit.c b/kernel/exit.c
index c038d10dfb38..70c967e08efa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,7 +744,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	 * PIDFD_THREAD waiters.
 	 */
 	if (!thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		pidfd_wake_up_poll(tsk, false);
 
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
diff --git a/kernel/fork.c b/kernel/fork.c
index aa08193d124f..7b882e66448b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2074,14 +2074,14 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 /*
  * Poll support for process exit notification.
  */
-static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
+static __poll_t pidfd_poll(struct file *file, poll_table *wait)
 {
 	struct pid *pid = file->private_data;
 	bool thread = file->f_flags & PIDFD_THREAD;
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
-	poll_wait(file, &pid->wait_pidfd, pts);
+	poll_wait(file, &pid->wait_pidfd, wait);
 	/*
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
 	 * or the whole thread-group exits.
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..ee849fb35603 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -208,7 +208,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
 void __wake_up_pollfree(struct wait_queue_head *wq_head)
 {
-	__wake_up(wq_head, TASK_NORMAL, 0, poll_to_key(EPOLLHUP | POLLFREE));
+	wake_up_all_poll(wq_head, EPOLLHUP | POLLFREE);
 	/* POLLFREE must have cleared the queue. */
 	WARN_ON_ONCE(waitqueue_active(wq_head));
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b40109f0c56..86b3721ea08f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,13 +2019,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-void do_notify_pidfd(struct task_struct *task)
+void pidfd_wake_up_poll(struct task_struct *task, bool dead)
 {
-	struct pid *pid;
-
 	WARN_ON(task->exit_state == 0);
-	pid = task_pid(task);
-	wake_up_all(&pid->wait_pidfd);
+	WARN_ON(mask == 0);
+	wake_up_all_poll(&task_pid(task)->wait_pidfd,
+			 EPOLLIN | EPOLLRDNORM | dead ? EPOLLHUP : 0);
 }
 
 /*
@@ -2055,7 +2054,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * non-PIDFD_THREAD waiters.
 	 */
 	if (thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		pidfd_wake_up_poll(tsk, false);
 
 	if (sig != SIGCHLD) {
 		/*
-- 
2.43.0


--jrozykordr44ab6z--

