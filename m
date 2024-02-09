Return-Path: <linux-kernel+bounces-59523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8484F854
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD7E1C25040
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8676F525;
	Fri,  9 Feb 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1tyFmwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5946EB65;
	Fri,  9 Feb 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491724; cv=none; b=FqmqiwFRNN29rEq2Bampqlbovekp+aiZWuiAH165auv+aJ4UwIlT4DmdLAnkdsWpv3uq50sbY8wGJnr73sdAuY1Y/1ilde4yj0L+EpIgfj2hQ+AKoAGR3Utq48ziE++l7bYHone1x1wAKQKEPBCxoEFCo8tpM/8Im8R39XGqReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491724; c=relaxed/simple;
	bh=vhoLSSlL/5ddek+ZFOhIOvsQoTmINNqk4DydXbkdtGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aANSQgUeG9xQzCRAYkFtXegv2ESt3JeSvw2gcSu72OniYoLBVNY0ASU+b9rp7yr53NLkf+TlSO7AH3et+qvbMqJ+w9j8sy8KwT8F9r3QuV2Sc+uQj4Y/R33f9Rj8BJCzlN77Lr+MvYommIcacTDOfaJzFcz6ifceJitAO+BFZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1tyFmwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52316C433F1;
	Fri,  9 Feb 2024 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707491723;
	bh=vhoLSSlL/5ddek+ZFOhIOvsQoTmINNqk4DydXbkdtGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1tyFmwbVm6zKZ64DuT5j6bfXPbNK68FHowfNrIFTprDYA7b/2CUkMM5BJcQgv12E
	 /s0lEnSuQlBHkCaoQxCoGv9MAdujszFLhG8a8DQT+KlZ0fFvr5YPOyWQtazx/aul3H
	 VGo5T5dLkXXBiu8aPR8pZGbAV6cfbDdz8f2PplVXSX6yfTFu9yjZDdOYy5jGqL9TTO
	 4GD5npkOL3Upa98GAmQLj9LQlwexMtzi2MvxzEj04IR7hRB+G1CwDpxw8JZDxQVPYC
	 8PO130wg0RJf7r0b/fnUEdCXw/WTA7akiYT+VADlg86aNKNUmOWZV3gWiaPrKYU1TQ
	 ZqUxFoHs6AbHw==
Date: Fri, 9 Feb 2024 16:15:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209-stangen-feuerzeug-17c8662854c9@brauner>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209130650.GA8048@redhat.com>

On Fri, Feb 09, 2024 at 02:06:50PM +0100, Oleg Nesterov wrote:
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

How do you feel about the following (untested...) addition?
I've played with PIDFD_SIGNAL_PROCESS_GROUP as well but that code is
fairly new to me so I would need some more time.

From a473512ed8de2e864961f7009e2f20ce4e7a0778 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Feb 2024 15:49:45 +0100
Subject: [PATCH] [RFC] pidfd: allow to override signal scope in
 pidfd_send_signal()

Right now we determine the scope of the signal based on the type of
pidfd. There are use-cases where it's useful to override the scope of
the signal. For example in [1]. Add flags to determine the scope of the
signal:

(1) PIDFD_SIGNAL_THREAD: send signal to specific thread
(2) PIDFD_SIGNAL_THREAD_GROUP: send signal to thread-group

I've put off PIDFD_SIGNAL_PROCESS_GROUP for now since I need to stare at
the code a bit longer how this would work.

Link: https://github.com/systemd/systemd/issues/31093 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/pidfd.h |  4 ++++
 kernel/signal.c            | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 2e6461459877..757ed5a668c6 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -10,4 +10,8 @@
 #define PIDFD_NONBLOCK	O_NONBLOCK
 #define PIDFD_THREAD	O_EXCL
 
+/* Flags for pidfd_send_signal(). */
+#define PIDFD_SIGNAL_THREAD		(1UL << 0)
+#define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 9578ce17d85d..1d6586964099 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3872,6 +3872,9 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
+#define PIDFD_SEND_SIGNAL_FLAGS \
+	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP)
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -3889,14 +3892,19 @@ static struct pid *pidfd_to_pid(const struct file *file)
 SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
-	int ret;
+	int ret, si_code;
 	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	bool thread;
+	enum pid_type si_scope;
 
 	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags)
+	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
+		return -EINVAL;
+
+	/* Ensure that only a single signal scope determining flag is set. */
+	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
 	f = fdget(pidfd);
@@ -3914,7 +3922,22 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (!access_pidfd_pidns(pid))
 		goto err;
 
-	thread = f.file->f_flags & PIDFD_THREAD;
+	switch (flags) {
+	case 0:
+		/* Infer scope from the type of pidfd. */
+		thread = (f.file->f_flags & PIDFD_THREAD);
+		si_scope = thread ? PIDTYPE_PID : PIDTYPE_TGID;
+		si_code = thread ? SI_TKILL : SI_USER;
+		break;
+	case PIDFD_SIGNAL_THREAD:
+		si_scope = PIDTYPE_PID;
+		si_code = SI_TKILL;
+		break;
+	case PIDFD_SIGNAL_THREAD_GROUP:
+		si_scope = PIDTYPE_TGID;
+		si_code = SI_USER;
+		break;
+	}
 
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
@@ -3931,12 +3954,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo,
-				     thread ? SI_TKILL : SI_USER);
+		prepare_kill_siginfo(sig, &kinfo, si_code);
 	}
 
-	ret = kill_pid_info_type(sig, &kinfo, pid,
-				 thread ? PIDTYPE_PID : PIDTYPE_TGID);
+	ret = kill_pid_info_type(sig, &kinfo, pid, si_scope);
 err:
 	fdput(f);
 	return ret;
-- 
2.43.0


