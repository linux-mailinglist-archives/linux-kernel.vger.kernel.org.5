Return-Path: <linux-kernel+bounces-46578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B184418C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2F01F22333
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DED82887;
	Wed, 31 Jan 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmakQWFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FB80C1D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710357; cv=none; b=XHMjgjoS5YsN8z7cw69cIojDr4FQUIBDTvK6G7bbCbJsn8neX8gv1i5qHfZPOwrrueriDoOuwtop0CQYTQfw9dr97bveL/+UqyCPhCxPqZER2ui8cVdYKv2mbvPo7w0KjJPgCYBGXlBsp0SzatyK+a6NzJPEcafMGRhapaU9jaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710357; c=relaxed/simple;
	bh=3uMW2MxPokLkcdyNH64mmfPGoGIADWc/tJ8ybNPXsuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5WA2ugXjOxy+Txe5gg+98qbi4l5D1RZOz8EaN2obI/aiq2ktE1uxzu2tWvDRS9Za9SbxB3Ixo4air3rZeRcJgy2u2qBSRiLFmXlakWxtTV9u94ItSynBEGGolPE4o+TRbWjwKQqAv9MTSt2fGp6TxDbtUAzu7+pZBVchnbcOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmakQWFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6446C43399;
	Wed, 31 Jan 2024 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706710356;
	bh=3uMW2MxPokLkcdyNH64mmfPGoGIADWc/tJ8ybNPXsuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmakQWFJj762moEGZ7NdSd9+jOmiQngvUSiVGkdNdwbsF6MeUrVver20RsXtKju5D
	 0BtxT9wZ/dvuWAFzClHC1euFm/DvVraBsu0CiX3chtUKZHDawHYRg5cWioPkNgG6IF
	 WTUU5UBns4XyR7A3mHeQk7DMWa4Jrdpttq0iscYv0uRW5GvTkGkAHe1xfyJr+wCgNS
	 XOPC9+fkwUaaD1Bhwb8FAKSYqdekvzhGrvTFLyVouIy4ggdKJxbFYRGkWM0XL+E0qw
	 Z1O+DhK7dCdqnlDVfQfQxubz1EJKb2weLTAcyUAz0olYe7vQPFv5nw/aCbNNy63NG/
	 SLeAYcMRDpExg==
Date: Wed, 31 Jan 2024 15:12:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131-raubbau-rentier-7ca9be9bc7c9@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131132602.GA23641@redhat.com>

On Wed, Jan 31, 2024 at 02:26:02PM +0100, Oleg Nesterov wrote:
> With this flag:
> 
> 	- pidfd_open() doesn't require that the target task must be
> 	  a thread-group leader
> 
> 	- pidfd_poll() succeeds when the task exits and becomes a
> 	  zombie (iow, passes exit_notify()), even if it is a leader
> 	  and thread-group is not empty.
> 
> 	  This means that the behaviour of pidfd_poll(PIDFD_THREAD,
> 	  pid-of-group-leader) is not well defined if it races with
> 	  exec() from its sub-thread; pidfd_poll() can succeed or not
> 	  depending on whether pidfd_task_exited() is called before
> 	  or after exchange_tids().

I think that we can live with that for now. If it doesn't hinder Tycho's
use-case it's fine.

> 
> 	  Perhaps we can improve this behaviour later, pidfd_poll()
> 	  can probably take sig->group_exec_task into account. But
> 	  this doesn't really differ from the case when the leader
> 	  exits before other threads (so pidfd_poll() succeeds) and
> 	  then another thread execs and pidfd_poll() will block again.

.. because it assumes the old thread-group leader's struct pid, right.
One would hope that implementations don't poll on the same fd again
after they saw an exit event.

(I often wish that we could report custom data from poll similar to
kqueue on bsd then we could attach file specific information to the
notification. That would enable userspace to handle this the way they
want.)

> 
> thread_group_exited() is no longer used, perhaps it can die.

Feel free to add a patch for that on top of it.

> 
> Co-developed-by: Tycho Andersen <tycho@tycho.pizza>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/exec.c                  |  6 +++++-
>  include/linux/pid.h        |  3 ++-
>  include/uapi/linux/pidfd.h |  3 ++-
>  kernel/exit.c              |  7 +++++++
>  kernel/fork.c              | 38 +++++++++++++++++++++++++++++++-------
>  kernel/pid.c               | 14 +++-----------
>  kernel/signal.c            |  6 ++++--
>  7 files changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 73e4045df271..0fd7e668c477 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1143,7 +1143,11 @@ static int de_thread(struct task_struct *tsk)
>  
>  		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
>  		leader->exit_state = EXIT_DEAD;
> -
> +		/*
> +		 * leader and tsk exhanged their pids, the old pid dies,
> +		 * wake up the PIDFD_THREAD waiters.
> +		 */
> +		do_notify_pidfd(leader);
>  		/*
>  		 * We are going to release_task()->ptrace_unlink() silently,
>  		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index e6a041cb8bac..8124d57752b9 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -70,10 +70,11 @@ extern const struct file_operations pidfd_fops;
>  
>  struct file;
>  
> -extern struct pid *pidfd_pid(const struct file *file);
> +struct pid *pidfd_pid(const struct file *file);
>  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
>  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
> +void do_notify_pidfd(struct task_struct *task);
>  
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 5406fbc13074..2e6461459877 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -7,6 +7,7 @@
>  #include <linux/fcntl.h>
>  
>  /* Flags for pidfd_open().  */
> -#define PIDFD_NONBLOCK O_NONBLOCK
> +#define PIDFD_NONBLOCK	O_NONBLOCK
> +#define PIDFD_THREAD	O_EXCL
>  
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index dfb963d2f862..493647fd7c07 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -739,6 +739,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
>  	tsk->exit_state = EXIT_ZOMBIE;
> +	/*
> +	 * sub-thread or delay_group_leader(), wake up the
> +	 * PIDFD_THREAD waiters.
> +	 */
> +	if (!thread_group_empty(tsk))
> +		do_notify_pidfd(tsk);
> +
>  	if (unlikely(tsk->ptrace)) {
>  		int sig = thread_group_leader(tsk) &&
>  				thread_group_empty(tsk) &&
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 347641398f9d..bea32071fff2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -101,6 +101,7 @@
>  #include <linux/user_events.h>
>  #include <linux/iommu.h>
>  #include <linux/rseq.h>
> +#include <uapi/linux/pidfd.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	seq_put_decimal_ll(m, "Pid:\t", nr);
>  
> +	/* TODO: report PIDFD_THREAD */
> +
>  #ifdef CONFIG_PID_NS
>  	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
>  	if (nr > 0) {
> @@ -2068,22 +2071,35 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  }
>  #endif
>  
> +static bool pidfd_task_exited(struct pid *pid, bool thread)
> +{
> +	struct task_struct *task;
> +	bool exited;
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	exited = !task ||
> +		(READ_ONCE(task->exit_state) && (thread || thread_group_empty(task)));
> +	rcu_read_unlock();
> +
> +	return exited;
> +}
> +
>  /*
>   * Poll support for process exit notification.
>   */
>  static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  {
>  	struct pid *pid = file->private_data;
> +	bool thread = file->f_flags & PIDFD_THREAD;
>  	__poll_t poll_flags = 0;
>  
>  	poll_wait(file, &pid->wait_pidfd, pts);
> -
>  	/*
> -	 * Inform pollers only when the whole thread group exits.
> -	 * If the thread group leader exits before all other threads in the
> -	 * group, then poll(2) should block, similar to the wait(2) family.
> +	 * Depending on PIDFD_THREAD, inform pollers when the thread
> +	 * or the whole thread-group exits.
>  	 */
> -	if (thread_group_exited(pid))
> +	if (pidfd_task_exited(pid, thread))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;
>  
>  	return poll_flags;
> @@ -2141,6 +2157,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>  		return PTR_ERR(pidfd_file);
>  	}
>  	get_pid(pid); /* held by pidfd_file now */
> +	/*
> +	 * anon_inode_getfile() ignores everything outside of the
> +	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
> +	 */
> +	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
>  	*ret = pidfd_file;
>  	return pidfd;
>  }
> @@ -2154,7 +2175,8 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   * Allocate a new file that stashes @pid and reserve a new pidfd number in the
>   * caller's file descriptor table. The pidfd is reserved but not installed yet.
>   *
> - * The helper verifies that @pid is used as a thread group leader.
> + * The helper verifies that @pid is still in use, without PIDFD_THREAD the
> + * task identified by @pid must be a thread-group leader.
>   *
>   * If this function returns successfully the caller is responsible to either
>   * call fd_install() passing the returned pidfd and pidfd file as arguments in
> @@ -2173,7 +2195,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   */
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>  {
> -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +	bool thread = flags & PIDFD_THREAD;
> +
> +	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID));
>  		return -EINVAL;
>  
>  	return __pidfd_prepare(pid, flags, ret);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index c7a3e359f8f5..e11144466828 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -552,11 +552,6 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>   * Return the task associated with @pidfd. The function takes a reference on
>   * the returned task. The caller is responsible for releasing that reference.
>   *
> - * Currently, the process identified by @pidfd is always a thread-group leader.
> - * This restriction currently exists for all aspects of pidfds including pidfd
> - * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
> - * (only supports thread group leaders).
> - *
>   * Return: On success, the task_struct associated with the pidfd.
>   *	   On error, a negative errno number will be returned.
>   */
> @@ -615,11 +610,8 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
>   * @flags: flags to pass
>   *
>   * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> - * the process identified by @pid. Currently, the process identified by
> - * @pid must be a thread-group leader. This restriction currently exists
> - * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> - * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> - * leaders).
> + * the task identified by @pid. Without PIDFD_THREAD flag the target task
> + * must be a thread-group leader.
>   *
>   * Return: On success, a cloexec pidfd is returned.
>   *         On error, a negative errno number will be returned.
> @@ -629,7 +621,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  	int fd;
>  	struct pid *p;
>  
> -	if (flags & ~PIDFD_NONBLOCK)
> +	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>  		return -EINVAL;
>  
>  	if (pid <= 0)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9561a3962ca6..9b40109f0c56 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2019,7 +2019,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	return ret;
>  }
>  
> -static void do_notify_pidfd(struct task_struct *task)
> +void do_notify_pidfd(struct task_struct *task)
>  {
>  	struct pid *pid;
>  
> @@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	WARN_ON_ONCE(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  	/*
> -	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
> +	 * tsk is a group leader and has no threads, wake up the
> +	 * non-PIDFD_THREAD waiters.
>  	 */
>  	if (thread_group_empty(tsk))
>  		do_notify_pidfd(tsk);
> @@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		prepare_kill_siginfo(sig, &kinfo);
>  	}
>  
> +	/* TODO: respect PIDFD_THREAD */
>  	ret = kill_pid_info(sig, &kinfo, pid);
>  
>  err:
> -- 
> 2.25.1.362.g51ebf55
> 
> 

