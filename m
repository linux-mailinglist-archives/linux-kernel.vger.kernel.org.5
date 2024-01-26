Return-Path: <linux-kernel+bounces-39954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223183D7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047E7295BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C141C7E;
	Fri, 26 Jan 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrbK+erJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE707134A0;
	Fri, 26 Jan 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262483; cv=none; b=ZStfn0SEwb5UNfX9jXjbYQz1e4J8RS5FFFuad7JY/aou1pZZzAbkTSLGvx0opqRM9jp6cX8kx40w5zW9wIJ2BVXzuAN/8AH0ca5o9xx46phkT4I7QmG9kgVcwaRdGoKUWW+naplfBdng7g4YQsK0K55tQygpQ9iSsyTsAW397a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262483; c=relaxed/simple;
	bh=J5VjNbl4WGKu+nXMw2DuCoJGRTOyS8wy3t1S37JzKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIvDRiAKh7qsH7IlP9LtBzoqUsMjU2ktbAFGoiTBI+0qQ9nL18yT9l0F9V5rwdFzhiyn0e4AEXH1O63kdsUoRE8yehu4tM7hmdJqjC1brZKkGiauryQiVHaJ3ZojCCoh/laIKXsdT3eDMBhs2A/vpjrJ+8huuooZF4UKrA/ICcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrbK+erJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDBFC43390;
	Fri, 26 Jan 2024 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706262483;
	bh=J5VjNbl4WGKu+nXMw2DuCoJGRTOyS8wy3t1S37JzKPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrbK+erJc04AO71cW5oUSCZebgIfnYFgQScOLYpT0J90fAUYTt62Sw0/dEfp61Yy3
	 3jI+pKX4aOpgDPTiyt+DA8PsWDSNcgD+BUt5IxnlpJEzriIgKFHICGZShc+05S2SvI
	 JJbgvxgYk7CPiWQIV7unHyJlV1AvaofyJRsxcop7muAqyonbzLVYmzzAGnP3FegFEc
	 2utXM24leDOuShjwMS15f1JvSkZAjvwyCSHySrGjI54ZAPnUXQU7oQ6BLBRhqGMZEs
	 bI31B7GJexWeNJddPSWhyBbv22N2Qg3v0tM8W0iFWs8/BUapaqSAzoQWX14OVo+zT0
	 C0UrVDn4uOHIw==
Date: Fri, 26 Jan 2024 10:47:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240126-kulinarisch-ausziehen-d2af51882d2f@brauner>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125140830.GA5513@redhat.com>

> Please the the incomplete/untested patch below.
> 
> 	- The change in exit_notify() is sub-optimal, we can do better
> 	  to avoid 2 do_notify_pidfd() calls from exit_notify(). But
> 	  so far this is only for discussion, lets keep it simple.
> 
> 	- __pidfd_prepare() needs some minor cleanups regardless of
> 	  this change, I'll send the patch...
> 
> What do you think?
> 
> And why is thread_group_exited() exported?
> 
> Oleg.
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
> +#define PIDFD_THREAD	O_EXCL	// or anything else not used by anon_inode's

I like it!

The only request I would have is to not alias O_EXCL and PIDFD_THREAD.
Because it doesn't map as clearly as NONBLOCK did.

>  
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index dfb963d2f862..9f8526b7d717 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -752,6 +752,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		autoreap = true;
>  	}
>  
> +	/* unnecessary if do_notify_parent() was already called,
> +	   we can do better */
> +	do_notify_pidfd(tsk);
> +
>  	if (autoreap) {
>  		tsk->exit_state = EXIT_DEAD;
>  		list_add(&tsk->ptrace_entry, &dead);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c981fa6171c1..38f2c7423fb4 100644
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
> @@ -2068,12 +2069,27 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  }
>  #endif
>  
> +static bool xxx_exited(struct pid *pid, int excl)
> +{
> +	struct task_struct *task;
> +	bool exited;
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	exited = !task ||
> +		(READ_ONCE(task->exit_state) && (excl || thread_group_empty(task)));
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
> +	int excl = file->f_flags & PIDFD_THREAD;
>  	__poll_t poll_flags = 0;
>  
>  	poll_wait(file, &pid->wait_pidfd, pts);
> @@ -2083,7 +2099,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	 * If the thread group leader exits before all other threads in the
>  	 * group, then poll(2) should block, similar to the wait(2) family.
>  	 */
> -	if (thread_group_exited(pid))
> +	if (xxx_exited(pid, excl))
>  		poll_flags = EPOLLIN | EPOLLRDNORM;
>  
>  	return poll_flags;
> @@ -2129,7 +2145,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>  {
>  	int pidfd;
>  	struct file *pidfd_file;
> +	unsigned excl = flags & PIDFD_THREAD;
>  
> +	flags &= ~PIDFD_THREAD;
>  	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
>  		return -EINVAL;
>  
> @@ -2144,6 +2162,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>  		return PTR_ERR(pidfd_file);
>  	}
>  	get_pid(pid); /* held by pidfd_file now */
> +	pidfd_file->f_flags |= excl;
>  	*ret = pidfd_file;
>  	return pidfd;
>  }
> @@ -2176,7 +2195,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>   */
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>  {
> -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +	unsigned excl = flags & PIDFD_THREAD;
> +
> +	if (!pid || !pid_has_task(pid, excl ? PIDTYPE_PID : PIDTYPE_TGID))
>  		return -EINVAL;
>  
>  	return __pidfd_prepare(pid, flags, ret);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index b52b10865454..5257197f9493 100644
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
> 

