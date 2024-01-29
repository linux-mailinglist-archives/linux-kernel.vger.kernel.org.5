Return-Path: <linux-kernel+bounces-42818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B309B840740
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68535289259
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97F64CFC;
	Mon, 29 Jan 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7SrMWov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8AE651AF;
	Mon, 29 Jan 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535676; cv=none; b=Zaf5qHyv/DTlGQSDQBR1JtmwjPHuoe8Q4bD6hlth5oT9id+kfeRKF3lM28cWHCBLjO8K3TYckALvd+OcJVqcncFL+A2f0P7PbKHZiRmMo4qlf+vHwPTqyMpi69tikWu76QHV2FE5R/FgEgOXLQnPL57t0XeDAMxn04pRV7qAghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535676; c=relaxed/simple;
	bh=TVCeACnJlgCOKF5yq3bMw9iisuRk62WRaQn66az30zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoHvIwCFkM9+iKz1GVT3nu1qT0+TS2zrQCvk078ntAR3XES8ZTZm5hd2ZEO6p30LC1qQkpe7NIXaE7Nne85TSNHmzn1C1J37htnvdy+j2LOnm2VOXLEGXGXTPHdHskeAZjPrrIRteNT9IfBWWtnxX7rmP2p3hMB6nX6gO4p3lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7SrMWov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19923C433C7;
	Mon, 29 Jan 2024 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706535675;
	bh=TVCeACnJlgCOKF5yq3bMw9iisuRk62WRaQn66az30zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7SrMWovr/HooMopeQOWcq5QFLiHYVdmon/wO+NfJnEwj0AH2FpnluqmQtF/CeZqD
	 vpt8eEfeUXlmsxDBugLcKrKLEZBnp6Cl6TZdBciX6I3qjXdIarN4AbpKzRyG3I3qlN
	 Pz9YC4yArnnSuEeuj0/sFE3cFYBU0iITFIiwBcCj4MbY5A55glaJCJ0iuoLPkRRdqZ
	 moLiv7UX0MAw9N9wRbcbrviq8ujsNqpDrEJ+ioKDpiuIDp3HdKmKWxsswTaNknWl+S
	 ljP6wsq5MehzK4VQQkTaZOJ1VOYu+EUn6YenKVZwSpAA+2W0Ui5dJ8tNR6aRvUG9+F
	 9k5KKoY5WDDlg==
Date: Mon, 29 Jan 2024 14:41:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240129-plakat-einlud-4903633a5410@brauner>
References: <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129112313.GA11635@redhat.com>

On Mon, Jan 29, 2024 at 12:23:15PM +0100, Oleg Nesterov wrote:
> On 01/27, Oleg Nesterov wrote:
> >
> > I'll (hopefully) send v2 on top of
> >
> > 	pidfd: cleanup the usage of __pidfd_prepare's flags
> > 	pidfd: don't do_notify_pidfd() if !thread_group_empty()
> >
> > on Monday
> 
> Sorry, I don't have time to finish v2 today, I need to update the comments
> and write the changelog.
> 
> But the patch itself is ready, I am sending it for review.
> 
> Tycho, Christian, any comments?
> 
> Oleg.
> 
> 
> From c31780f6c1136a72048d24701ac6d8401fc1afda Mon Sep 17 00:00:00 2001
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Sat, 27 Jan 2024 16:59:18 +0100
> Subject: [PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
> 
> ---
>  include/uapi/linux/pidfd.h |  3 ++-
>  kernel/exit.c              |  7 +++++++
>  kernel/fork.c              | 29 +++++++++++++++++++++++++++--
>  kernel/pid.c               |  2 +-
>  kernel/signal.c            |  4 +++-
>  5 files changed, 40 insertions(+), 5 deletions(-)
> 
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
> index dfb963d2f862..74fe6bfb9577 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -739,6 +739,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
>  	tsk->exit_state = EXIT_ZOMBIE;
> +	/*
> +	 * sub-thread or delay_group_leader(), wake up the PIDFD_THREAD
> +	 * waiters.
> +	 */
> +	if (!thread_group_empty(tsk))
> +		do_notify_pidfd(tsk);
> +
>  	if (unlikely(tsk->ptrace)) {
>  		int sig = thread_group_leader(tsk) &&
>  				thread_group_empty(tsk) &&
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 347641398f9d..977b58c0eac6 100644
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

Ah yes, very good point. We should give userspace an indicator whether
something is thread pidfd or not.

> +
>  #ifdef CONFIG_PID_NS
>  	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
>  	if (nr > 0) {
> @@ -2068,12 +2071,27 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
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
> @@ -2083,7 +2101,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	 * If the thread group leader exits before all other threads in the
>  	 * group, then poll(2) should block, similar to the wait(2) family.
>  	 */
> -	if (thread_group_exited(pid))
> +	if (pidfd_task_exited(pid, thread))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;
>  
>  	return poll_flags;
> @@ -2141,6 +2159,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
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
> @@ -2173,7 +2196,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
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
> index c7a3e359f8f5..04bdd5ecf183 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -629,7 +629,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  	int fd;
>  	struct pid *p;
>  
> -	if (flags & ~PIDFD_NONBLOCK)
> +	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
>  		return -EINVAL;
>  
>  	if (pid <= 0)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9561a3962ca6..919cd33a0405 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	WARN_ON_ONCE(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  	/*
> -	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
> +	 * tsk is a group leader and has no threads, wake up the !PIDFD_THREAD
> +	 * waiters.
>  	 */
>  	if (thread_group_empty(tsk))
>  		do_notify_pidfd(tsk);
> @@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		prepare_kill_siginfo(sig, &kinfo);
>  	}
>  
> +	/* TODO: respect PIDFD_THREAD */

So I've been thinking about this at the end of last week. Do we need to
give userspace a way to send a thread-group wide signal even when a
PIDFD_THREAD pidfd is passed? Or should we just not worry about this
right now and wait until someone needs this?

>  	ret = kill_pid_info(sig, &kinfo, pid);

Otherwise this looks good to me!

