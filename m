Return-Path: <linux-kernel+bounces-58137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8C84E1CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1FA1F2528C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB917CF0E;
	Thu,  8 Feb 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivAHTSh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB57CF02;
	Thu,  8 Feb 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398108; cv=none; b=DKDd2XgV/AuNBqhkdoKmQe6CCnqdTyLT90hLwQ/HojdrwqeQzv/kk4IO8PqW9m4yUnbMe8sp3J6jKDARUuwporEhv/BcLORoe86BnXuzOeyqpZlhg2813q9ISwtDfZ20xeBD3RGdokZ+geD9AJmY+MeczjWfNzLvde87cFzG1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398108; c=relaxed/simple;
	bh=q6awbs+YreoMeUxonom32OUjfO17lLFk08XgUb9aaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVwVVZjGhEXqkdPMryzIumqy5VcbefcfeXQupOukpp1meec42jDkpl/w4qV3SLEeIn9/VqeuWX3OY2ny963hObn6VWwjXXRWZCGJd2cGCehpxJegIIEWMDRlT1JQOxu7cbOslIq2GQAVVB+KZSU6N6nt690GMexnncO+laWwuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivAHTSh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA8FC433C7;
	Thu,  8 Feb 2024 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707398107;
	bh=q6awbs+YreoMeUxonom32OUjfO17lLFk08XgUb9aaMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivAHTSh0vucBZ1Tq2ackjWXZuDD4/eQiiFSf9vMdbjln7iBq6kWbS3isQ4i1kP4B9
	 qbmvlpUg6Z/tNvTjf2kQO98CoNsXgfQX1+uloYlJfh2kM9bzgAWOQPk5cLBmGBRT4k
	 DXBHRqfyukUF2INxTvPGsT0jI2UxEmQYNCuJidNj/kzQlXRjU9d+G9v2ediNSyXz5W
	 2O5mXCvBVBYR+NV1WsTSkQGZmeSBQAAyX4pbwMxNmguGPrpqu/Ow1oHsqbM7ja/PHT
	 gUyJYm9YdqPpLbqA54DSksgfagzjkWXwWlYlOy/80X4vEYdNBxUHF0VeI0yVYWhdJR
	 b81a5Q20Edpxg==
Date: Thu, 8 Feb 2024 14:15:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208-fragt-prospekt-7866333b15f0@brauner>
References: <20240207114549.GA12697@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207114549.GA12697@redhat.com>

On Wed, Feb 07, 2024 at 12:45:49PM +0100, Oleg Nesterov wrote:
> Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> pid_type to group_send_sig_info(), despite its name it should work fine
> even if type = PIDTYPE_PID.
> 
> Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> on PIDFD_THREAD.
> 
> While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/fork.c   |  2 --
>  kernel/signal.c | 18 ++++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cd61ca87d0e6..47b565598063 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2051,8 +2051,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  
>  	seq_put_decimal_ll(m, "Pid:\t", nr);
>  
> -	/* TODO: report PIDFD_THREAD */
> -
>  #ifdef CONFIG_PID_NS
>  	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
>  	if (nr > 0) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c3fac06937e2..e3edcd784e45 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -47,6 +47,7 @@
>  #include <linux/cgroup.h>
>  #include <linux/audit.h>
>  #include <linux/sysctl.h>
> +#include <uapi/linux/pidfd.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/signal.h>
> @@ -1478,7 +1479,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
>  	return ret;
>  }
>  
> -int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> +static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
> +				struct pid *pid, enum pid_type type)
>  {
>  	int error = -ESRCH;
>  	struct task_struct *p;
> @@ -1487,11 +1489,10 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
>  		rcu_read_lock();
>  		p = pid_task(pid, PIDTYPE_PID);
>  		if (p)
> -			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
> +			error = group_send_sig_info(sig, info, p, type);
>  		rcu_read_unlock();
>  		if (likely(!p || error != -ESRCH))
>  			return error;
> -
>  		/*
>  		 * The task was unhashed in between, try again.  If it
>  		 * is dead, pid_task() will return NULL, if we race with
> @@ -1500,6 +1501,11 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
>  	}
>  }
>  
> +int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
> +{
> +	return kill_pid_info_type(sig, info, pid, PIDTYPE_TGID);
> +}
> +
>  static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  {
>  	int error;
> @@ -3890,6 +3896,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	struct fd f;
>  	struct pid *pid;
>  	kernel_siginfo_t kinfo;
> +	enum pid_type type;
>  
>  	/* Enforce flags be set to 0 until we add an extension. */
>  	if (flags)
> @@ -3928,9 +3935,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		prepare_kill_siginfo(sig, &kinfo);
>  	}
>  
> -	/* TODO: respect PIDFD_THREAD */
> -	ret = kill_pid_info(sig, &kinfo, pid);
> -
> +	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
> +	ret = kill_pid_info_type(sig, &kinfo, pid, type);

If the user doesn't provide siginfo then the kernel fills in the info in
prepare_kill_siginfo() a few lines above. That sets info->si_code to
SI_USER even for the PIDFD_THREAD case. Whenever the info is filled in
by the kernel it's not exactly userspace impersonating anything plus we
know that what we're sending to is a pidfd by the type of the pidfd. So
it feels like we should fill in SI_TKILL here as well?

I would also suggest we update the obsolete comment on top of
pidfd_send_signal() along the lines of:

diff --git a/kernel/signal.c b/kernel/signal.c
index e3edcd784e45..40df0c17abd7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3878,14 +3878,10 @@ static struct pid *pidfd_to_pid(const struct file *file)
  * @info:   signal info
  * @flags:  future flags
  *
- * The syscall currently only signals via PIDTYPE_PID which covers
- * kill(<positive-pid>, <signal>. It does not signal threads or process
- * groups.
- * In order to extend the syscall to threads and process groups the @flags
- * argument should be used. In essence, the @flags argument will determine
- * what is signaled and not the file descriptor itself. Put in other words,
- * grouping is a property of the flags argument not a property of the file
- * descriptor.
+ * If the @pidfd refers to a thread-group leader the signal is thread-group
+ * directed. If @pidfd referes to a thread then the signal is thread directed.
+ * In the future extension to @flags may be used to override the default scope
+ * of @pidfd.
  *
  * Return: 0 on success, negative errno on failure
  */

