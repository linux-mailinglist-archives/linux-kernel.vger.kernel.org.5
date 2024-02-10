Return-Path: <linux-kernel+bounces-60426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A078504B7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF51C20DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64E54FB8;
	Sat, 10 Feb 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="copeqtab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D154FA0;
	Sat, 10 Feb 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575190; cv=none; b=cYgMFj5BHlBOQlB+G4QU8KgXA4xaAhjGAtHmdWbf0SW2veIvfXLqo9euEcW9mz3TuPEQva6CKInYxW7zit5J/8YswigDUCGKREp7nejjkYQIwP3jKcYyKloEWMR/i/9UoKjh3u8iRS6PQuUhnLnimw35sK+/1GFIM5myDZ44td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575190; c=relaxed/simple;
	bh=cP5ZBDbj+tnDHJgNTktqU9+0bOVZQvOUyWuiD/ujJow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fikEzlfPdAWQ9Xl86eBlq780xDTAsUoMdeVpG+GVvBBat94aSaNvkWWDfGJkXvZZSCB3XaYqLEseswG3ZcWpJ8eJypza8yx4n4/Cz07xJJ37ivK1zuhLME7InIgNmORKP3TN4/oHfntBcAemp7+ZhJfo4Mj/DFexi84emob0+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=copeqtab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79777C433F1;
	Sat, 10 Feb 2024 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707575190;
	bh=cP5ZBDbj+tnDHJgNTktqU9+0bOVZQvOUyWuiD/ujJow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=copeqtabPKufaQq32IOnxy2SuNPLWmTrzF0p63TwmQs2rLvflra98/R/258+E0xcb
	 OFprgShZlvxPby1Cg4jl8NWP0uO7KX5U7m54LIxScejg6QjIuNPsGpPkgVJdYaZ7zA
	 9RmiSztnqMSWdvdREUbtRGhT3XkuE9aMzlf90lm8JVGjX4fnIf1Hx5Gs3tO+kIaQi3
	 Gvp8ulOtmVRDLxMFV4FoZ7FtwfW8eQmyN6tnrQb5iNoi8in6YNdFw/TzRoviCOq2Iy
	 /hN0HhFY5CHiNCl/zkZGXwZ5FuvrOHeD42GZ4arNO8n8vvShcTAi1oPNJ3k9Xz0lUV
	 HjuL6407j+l5w==
Date: Sat, 10 Feb 2024 15:26:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240210131518.GC27557@redhat.com>

On Sat, Feb 10, 2024 at 02:15:18PM +0100, Oleg Nesterov wrote:
> On 02/10, Christian Brauner wrote:
> >
> > The question is what is more useful for userspace when they do:
> > pidfd_send_signal(1234, PIDFD_SEND_PROCESS_GROUP)?
> >
> > (1) They either mean to signal a process group that is headed by 1234.
> 
> Yes, this is what I had in mind, see also another email from me.
> Simple, clear, and matches kill(-1234).

I went for a walk and kept thinking about this and I agree with you.
It will require that 1234 will be a process group leader but I think
that this is ok to require that. The implementation becomes a lot
simpler of course.

From 6a9d6a6bd8b77cba210b9c28f0e6e047c7956e9f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Feb 2024 15:49:45 +0100
Subject: [PATCH v2] [RFC] pidfd: allow to override signal scope in
 pidfd_send_signal()

Right now we determine the scope of the signal based on the type of
pidfd. There are use-cases where it's useful to override the scope of
the signal. For example in [1]. Add flags to determine the scope of the
signal:

(1) PIDFD_SIGNAL_THREAD: send signal to specific thread referenced by @pidfd
(2) PIDFD_SIGNAL_THREAD_GROUP: send signal to thread-group headed by @pidfd
(2) PIDFD_SIGNAL_PROCESS_GROUP: send signal to process-group headed by @pidfd

Link: https://github.com/systemd/systemd/issues/31093 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/pidfd.h |  5 +++++
 kernel/signal.c            | 44 +++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 2e6461459877..72ec000a97cd 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -10,4 +10,9 @@
 #define PIDFD_NONBLOCK	O_NONBLOCK
 #define PIDFD_THREAD	O_EXCL
 
+/* Flags for pidfd_send_signal(). */
+#define PIDFD_SIGNAL_THREAD		(1UL << 0)
+#define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
+#define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 8b8169623850..cee7cd27ec88 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1905,16 +1905,19 @@ int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
 	return send_sig_info(info.si_signo, &info, t);
 }
 
-int kill_pgrp(struct pid *pid, int sig, int priv)
+static int kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 {
 	int ret;
-
 	read_lock(&tasklist_lock);
-	ret = __kill_pgrp_info(sig, __si_special(priv), pid);
+	ret = __kill_pgrp_info(sig, info, pgrp);
 	read_unlock(&tasklist_lock);
-
 	return ret;
 }
+
+int kill_pgrp(struct pid *pid, int sig, int priv)
+{
+	return kill_pgrp_info(sig, __si_special(priv), pid);
+}
 EXPORT_SYMBOL(kill_pgrp);
 
 int kill_pid(struct pid *pid, int sig, int priv)
@@ -3873,6 +3876,10 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
+#define PIDFD_SEND_SIGNAL_FLAGS                            \
+	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
+	 PIDFD_SIGNAL_PROCESS_GROUP)
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -3897,7 +3904,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	enum pid_type type;
 
 	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags)
+	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
+		return -EINVAL;
+
+	/* Ensure that only a single signal scope determining flag is set. */
+	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
 	f = fdget(pidfd);
@@ -3915,10 +3926,24 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (!access_pidfd_pidns(pid))
 		goto err;
 
-	if (f.file->f_flags & PIDFD_THREAD)
+	switch (flags) {
+	case 0:
+		/* Infer scope from the type of pidfd. */
+		if (f.file->f_flags & PIDFD_THREAD)
+			type = PIDTYPE_PID;
+		else
+			type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_THREAD:
 		type = PIDTYPE_PID;
-	else
+		break;
+	case PIDFD_SIGNAL_THREAD_GROUP:
 		type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_PROCESS_GROUP:
+		type = PIDTYPE_PGID;
+		break;
+	}
 
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
@@ -3938,7 +3963,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo, type);
 	}
 
-	ret = kill_pid_info_type(sig, &kinfo, pid, type);
+	if (type == PIDFD_SIGNAL_PROCESS_GROUP)
+		ret = kill_pgrp_info(sig, &kinfo, pid);
+	else
+		ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
 	fdput(f);
 	return ret;
-- 
2.43.0


