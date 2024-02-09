Return-Path: <linux-kernel+bounces-59889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F0284FCF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AF81F239D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30B84A47;
	Fri,  9 Feb 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0HPwZAT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459584A2E;
	Fri,  9 Feb 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507389; cv=none; b=jCxQQwAbsCxRk0b5GLSFgnYCpwE6/9WCEPpcGykS3dk7UuutTJA6VGocg8XrbolcbjR+SHZJu5RajQ/j4Nc6dSAnfJAKPRGc6Qj1hsmkXNESVZ42T12oZgudoR7NyAYatACz40obvctR5W1VKzcWNO3Aj7ARnQ5IsPHvaCKtx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507389; c=relaxed/simple;
	bh=1t2jsDcc6BAyqWzck/uook5ni4hSyJpMHc+6o+p6lsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AumGdlikrlmtsttcfH1qHjwjnr77DCY3Mywdm0eTtK4Ssbvim1eY9F/IxNUP2INOAiWSVcs+yjgydN9zmx17ugsFAeaNpaV7/U8MwArZQX3/8QVjacE4VmlRaLjofX5ladwdixf4C0doAvMEFxXI90n7gP+3nIQn5lxaPXzpTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0HPwZAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7EAC433C7;
	Fri,  9 Feb 2024 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507388;
	bh=1t2jsDcc6BAyqWzck/uook5ni4hSyJpMHc+6o+p6lsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0HPwZATbrtinGh3yrfFB4Is7bFKLvoP4aHA8oaZNymdvkAPCgXfP4bneZgR9zDR8
	 xloncJ48J/8hf+6JQkg5FXSqRAnz9rMDjC7LYHHTcArMc2Ns9XORbp9z2NUfhN4R5S
	 zeuKm+h0UUoN5kED2YdlwclwJNkLLs5JYDzVWT/HAIuPWudhsxi5qX9V0kxlWGjBjD
	 pC/g9ffHdjEIX1GIne8xoUSdH9tuYVsK90FmuJ7P9heLCZdVu5bybAedhyvAuUTCk4
	 DOBbmhThoFM6I9eaTqif4o1f1yoFFTOwlR/dKT/8+5KNENA+nhORP5ri0hjT1QU+Ct
	 HRl6kS+xol0yQ==
Date: Fri, 9 Feb 2024 20:36:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Andy Lutomirski <luto@amacapital.net>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <20240209-traben-geothermie-8c6aa7e1984f@brauner>
References: <20240209130620.GA8039@redhat.com>
 <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
 <20240209163914.GE3282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209163914.GE3282@redhat.com>

On Fri, Feb 09, 2024 at 05:39:14PM +0100, Oleg Nesterov wrote:
> On 02/09, Eric W. Biederman wrote:
> >
> > Could you can pass in the destination type instead of the si_code?
> > Something like I have shown below?
> 
> ...
> 
> > 	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;
> 
> Yes, I considered this option too.
> 
> OK, will send V3 tomorrow.

Hm, I don't think that's necessary if you're happy to have me just fix
that up in tree. Here's the two patches updated. It was straightforward
but I have a baby on my lap so double check, please:

From 05ffda39f6f5c887cae319274366cbf856c88fe5 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 9 Feb 2024 14:06:20 +0100
Subject: [PATCH 1/2] signal: fill in si_code in prepare_kill_siginfo()

So that do_tkill() can use this helper too. This also simplifies
the next patch.

TODO: perhaps we can kill prepare_kill_siginfo() and change the
callers to use SEND_SIG_NOINFO,  but this needs some changes in
__send_signal_locked() and TP_STORE_SIGINFO().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240209130620.GA8039@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/signal.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c3fac06937e2..1450689302d9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3793,12 +3793,13 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
 #endif
 #endif
 
-static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
+static void prepare_kill_siginfo(int sig, struct kernel_siginfo *info,
+				 enum pid_type type)
 {
 	clear_siginfo(info);
 	info->si_signo = sig;
 	info->si_errno = 0;
-	info->si_code = SI_USER;
+	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;
 	info->si_pid = task_tgid_vnr(current);
 	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
 }
@@ -3812,7 +3813,7 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
 	struct kernel_siginfo info;
 
-	prepare_kill_siginfo(sig, &info);
+	prepare_kill_siginfo(sig, &info, PIDTYPE_TGID);
 
 	return kill_something_info(sig, &info, pid);
 }
@@ -3925,7 +3926,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo);
+		prepare_kill_siginfo(sig, &kinfo, PIDTYPE_TGID);
 	}
 
 	/* TODO: respect PIDFD_THREAD */
@@ -3970,12 +3971,7 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
 {
 	struct kernel_siginfo info;
 
-	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_TKILL;
-	info.si_pid = task_tgid_vnr(current);
-	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
+	prepare_kill_siginfo(sig, &info, PIDTYPE_PID);
 
 	return do_send_specific(tgid, pid, sig, &info);
 }
-- 
2.43.0

From 7726d44467d6d14cfb888ae1a7e48512ac23fedc Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 9 Feb 2024 14:06:50 +0100
Subject: [PATCH 2/2] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD

Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
pid_type to group_send_sig_info(), despite its name it should work fine
even if type = PIDTYPE_PID.

Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
on PIDFD_THREAD.

While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240209130650.GA8048@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c   |  2 --
 kernel/signal.c | 39 +++++++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4b6d994505ca..3f22ec90c5c6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2051,8 +2051,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 
 	seq_put_decimal_ll(m, "Pid:\t", nr);
 
-	/* TODO: report PIDFD_THREAD */
-
 #ifdef CONFIG_PID_NS
 	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
 	if (nr > 0) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 1450689302d9..8b8169623850 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <linux/cgroup.h>
 #include <linux/audit.h>
 #include <linux/sysctl.h>
+#include <uapi/linux/pidfd.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1436,7 +1437,8 @@ void lockdep_assert_task_sighand_held(struct task_struct *task)
 #endif
 
 /*
- * send signal info to all the members of a group
+ * send signal info to all the members of a thread group or to the
+ * individual thread if type == PIDTYPE_PID.
  */
 int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			struct task_struct *p, enum pid_type type)
@@ -1478,7 +1480,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 	return ret;
 }
 
-int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
+				struct pid *pid, enum pid_type type)
 {
 	int error = -ESRCH;
 	struct task_struct *p;
@@ -1487,11 +1490,10 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
 		if (p)
-			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
+			error = group_send_sig_info(sig, info, p, type);
 		rcu_read_unlock();
 		if (likely(!p || error != -ESRCH))
 			return error;
-
 		/*
 		 * The task was unhashed in between, try again.  If it
 		 * is dead, pid_task() will return NULL, if we race with
@@ -1500,6 +1502,11 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 	}
 }
 
+int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+{
+	return kill_pid_info_type(sig, info, pid, PIDTYPE_TGID);
+}
+
 static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
 	int error;
@@ -3873,14 +3880,10 @@ static struct pid *pidfd_to_pid(const struct file *file)
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
+ * Send the signal to the thread group or to the individual thread depending
+ * on PIDFD_THREAD.
+ * In the future extension to @flags may be used to override the default scope
+ * of @pidfd.
  *
  * Return: 0 on success, negative errno on failure
  */
@@ -3891,6 +3894,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
+	enum pid_type type;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags)
@@ -3911,6 +3915,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (!access_pidfd_pidns(pid))
 		goto err;
 
+	if (f.file->f_flags & PIDFD_THREAD)
+		type = PIDTYPE_PID;
+	else
+		type = PIDTYPE_TGID;
+
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
 		if (unlikely(ret))
@@ -3926,12 +3935,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo, PIDTYPE_TGID);
+		prepare_kill_siginfo(sig, &kinfo, type);
 	}
 
-	/* TODO: respect PIDFD_THREAD */
-	ret = kill_pid_info(sig, &kinfo, pid);
-
+	ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
 	fdput(f);
 	return ret;
-- 
2.43.0


