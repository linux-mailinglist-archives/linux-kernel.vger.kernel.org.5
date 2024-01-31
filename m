Return-Path: <linux-kernel+bounces-46495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACA844094
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A352B2F633
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648E7BB10;
	Wed, 31 Jan 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJpJWTJd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4F7BAE8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707647; cv=none; b=j6JV6RAPWDGWmJ2KdIGqDTVvGIMY3Rp4+2uuSUqUiBPvwhT8k97f2AZU5fQ435cCo+IO7+TmFXiqZstcbjkj8XjSpdF47Pb3W1IHsMM26s4N3PyOvv0s7YX1AwdNk0rHnkq5WzjGyho5dUipXzuITJVotvSFc6XPfuAkm+Ip8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707647; c=relaxed/simple;
	bh=AQKcgMW4D1LnI2u89cV4/2OD7A7nQ6DYmOTjd6O/3Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DE6pZ9qu+6JIKrcrj8krNb4Ld6Oi+/FpE6tZ3uwNbLSO8pqUgarMx1L0+xjbQ8Tm0qcgTJ2ZG4qKCRvC3CWSdTe38RPgL5moXxCTNsFrgT1NUwhqMQF9kYmNomOb0/7/vvD2Do88zlGEUae+PaGQL37tZM1UXSsIEUefYPQSbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJpJWTJd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706707644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXSRGEmdOSgjUDywudR4t/mFeWWDDqj4L9Qs0yTV+/E=;
	b=FJpJWTJdK3HUMeNAUV5YCD7yYeOwJ9/46Ov6FqHi8BMMx/xqv5wb5525hD/NlNPog+VgEO
	9HCudR7XijoncM1DqaYiVpMjF8EAwI8BiIQCX1WnquehIqxWmVQ0QHwnu82sEsPFIIBrSr
	cQNp1f8Bbvtm0oHDzgxg7JE+P+9t1n0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-X8yrXUP5P3KLX3InNtU7pg-1; Wed, 31 Jan 2024 08:27:19 -0500
X-MC-Unique: X8yrXUP5P3KLX3InNtU7pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D58FB86D4D5;
	Wed, 31 Jan 2024 13:27:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id 98E3D1121312;
	Wed, 31 Jan 2024 13:27:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 14:26:04 +0100 (CET)
Date: Wed, 31 Jan 2024 14:26:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131132602.GA23641@redhat.com>
References: <20240131132541.GA23632@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131132541.GA23632@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

With this flag:

	- pidfd_open() doesn't require that the target task must be
	  a thread-group leader

	- pidfd_poll() succeeds when the task exits and becomes a
	  zombie (iow, passes exit_notify()), even if it is a leader
	  and thread-group is not empty.

	  This means that the behaviour of pidfd_poll(PIDFD_THREAD,
	  pid-of-group-leader) is not well defined if it races with
	  exec() from its sub-thread; pidfd_poll() can succeed or not
	  depending on whether pidfd_task_exited() is called before
	  or after exchange_tids().

	  Perhaps we can improve this behaviour later, pidfd_poll()
	  can probably take sig->group_exec_task into account. But
	  this doesn't really differ from the case when the leader
	  exits before other threads (so pidfd_poll() succeeds) and
	  then another thread execs and pidfd_poll() will block again.

thread_group_exited() is no longer used, perhaps it can die.

Co-developed-by: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c                  |  6 +++++-
 include/linux/pid.h        |  3 ++-
 include/uapi/linux/pidfd.h |  3 ++-
 kernel/exit.c              |  7 +++++++
 kernel/fork.c              | 38 +++++++++++++++++++++++++++++++-------
 kernel/pid.c               | 14 +++-----------
 kernel/signal.c            |  6 ++++--
 7 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 73e4045df271..0fd7e668c477 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1143,7 +1143,11 @@ static int de_thread(struct task_struct *tsk)
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
 		leader->exit_state = EXIT_DEAD;
-
+		/*
+		 * leader and tsk exhanged their pids, the old pid dies,
+		 * wake up the PIDFD_THREAD waiters.
+		 */
+		do_notify_pidfd(leader);
 		/*
 		 * We are going to release_task()->ptrace_unlink() silently,
 		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
diff --git a/include/linux/pid.h b/include/linux/pid.h
index e6a041cb8bac..8124d57752b9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -70,10 +70,11 @@ extern const struct file_operations pidfd_fops;
 
 struct file;
 
-extern struct pid *pidfd_pid(const struct file *file);
+struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
+void do_notify_pidfd(struct task_struct *task);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 5406fbc13074..2e6461459877 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -7,6 +7,7 @@
 #include <linux/fcntl.h>
 
 /* Flags for pidfd_open().  */
-#define PIDFD_NONBLOCK O_NONBLOCK
+#define PIDFD_NONBLOCK	O_NONBLOCK
+#define PIDFD_THREAD	O_EXCL
 
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index dfb963d2f862..493647fd7c07 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -739,6 +739,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
 	tsk->exit_state = EXIT_ZOMBIE;
+	/*
+	 * sub-thread or delay_group_leader(), wake up the
+	 * PIDFD_THREAD waiters.
+	 */
+	if (!thread_group_empty(tsk))
+		do_notify_pidfd(tsk);
+
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
 				thread_group_empty(tsk) &&
diff --git a/kernel/fork.c b/kernel/fork.c
index 347641398f9d..bea32071fff2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -101,6 +101,7 @@
 #include <linux/user_events.h>
 #include <linux/iommu.h>
 #include <linux/rseq.h>
+#include <uapi/linux/pidfd.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 
 	seq_put_decimal_ll(m, "Pid:\t", nr);
 
+	/* TODO: report PIDFD_THREAD */
+
 #ifdef CONFIG_PID_NS
 	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
 	if (nr > 0) {
@@ -2068,22 +2071,35 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static bool pidfd_task_exited(struct pid *pid, bool thread)
+{
+	struct task_struct *task;
+	bool exited;
+
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	exited = !task ||
+		(READ_ONCE(task->exit_state) && (thread || thread_group_empty(task)));
+	rcu_read_unlock();
+
+	return exited;
+}
+
 /*
  * Poll support for process exit notification.
  */
 static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct pid *pid = file->private_data;
+	bool thread = file->f_flags & PIDFD_THREAD;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
-
 	/*
-	 * Inform pollers only when the whole thread group exits.
-	 * If the thread group leader exits before all other threads in the
-	 * group, then poll(2) should block, similar to the wait(2) family.
+	 * Depending on PIDFD_THREAD, inform pollers when the thread
+	 * or the whole thread-group exits.
 	 */
-	if (thread_group_exited(pid))
+	if (pidfd_task_exited(pid, thread))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
 
 	return poll_flags;
@@ -2141,6 +2157,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 		return PTR_ERR(pidfd_file);
 	}
 	get_pid(pid); /* held by pidfd_file now */
+	/*
+	 * anon_inode_getfile() ignores everything outside of the
+	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
+	 */
+	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 	*ret = pidfd_file;
 	return pidfd;
 }
@@ -2154,7 +2175,8 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  * Allocate a new file that stashes @pid and reserve a new pidfd number in the
  * caller's file descriptor table. The pidfd is reserved but not installed yet.
  *
- * The helper verifies that @pid is used as a thread group leader.
+ * The helper verifies that @pid is still in use, without PIDFD_THREAD the
+ * task identified by @pid must be a thread-group leader.
  *
  * If this function returns successfully the caller is responsible to either
  * call fd_install() passing the returned pidfd and pidfd file as arguments in
@@ -2173,7 +2195,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+	bool thread = flags & PIDFD_THREAD;
+
+	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID));
 		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
diff --git a/kernel/pid.c b/kernel/pid.c
index c7a3e359f8f5..e11144466828 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -552,11 +552,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Return the task associated with @pidfd. The function takes a reference on
  * the returned task. The caller is responsible for releasing that reference.
  *
- * Currently, the process identified by @pidfd is always a thread-group leader.
- * This restriction currently exists for all aspects of pidfds including pidfd
- * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
- * (only supports thread group leaders).
- *
  * Return: On success, the task_struct associated with the pidfd.
  *	   On error, a negative errno number will be returned.
  */
@@ -615,11 +610,8 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
  * @flags: flags to pass
  *
  * This creates a new pid file descriptor with the O_CLOEXEC flag set for
- * the process identified by @pid. Currently, the process identified by
- * @pid must be a thread-group leader. This restriction currently exists
- * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
- * be used with CLONE_THREAD) and pidfd polling (only supports thread group
- * leaders).
+ * the task identified by @pid. Without PIDFD_THREAD flag the target task
+ * must be a thread-group leader.
  *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
@@ -629,7 +621,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	int fd;
 	struct pid *p;
 
-	if (flags & ~PIDFD_NONBLOCK)
+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
 		return -EINVAL;
 
 	if (pid <= 0)
diff --git a/kernel/signal.c b/kernel/signal.c
index 9561a3962ca6..9b40109f0c56 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,7 +2019,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 
@@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 	/*
-	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
+	 * tsk is a group leader and has no threads, wake up the
+	 * non-PIDFD_THREAD waiters.
 	 */
 	if (thread_group_empty(tsk))
 		do_notify_pidfd(tsk);
@@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo);
 	}
 
+	/* TODO: respect PIDFD_THREAD */
 	ret = kill_pid_info(sig, &kinfo, pid);
 
 err:
-- 
2.25.1.362.g51ebf55



