Return-Path: <linux-kernel+bounces-42610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562918403C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD69B22F01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8D5C8E4;
	Mon, 29 Jan 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTbSexiS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AB5C5E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527481; cv=none; b=cygUu92FXOQgtyvRG9yOEnBX/SgyLqW7uSleblzMmxwPwMN5fRDHe9sO/dEXNG4mc47gfi9S90IEGVd/peMG8KE3+rDW4jTnxqvgiESyrtXNGERxDrfamDWcB6tFFIiSNPM5kKLNgw2btUYgNXbAYgkEoLuordNyZytlkn0O8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527481; c=relaxed/simple;
	bh=M1eZFkZenuGschG9LJXhONAKU2yn51nzZ4is/X0qaLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wslvh4UuvzLB5ohlSsn7Xx+Ds8Lj8b26C8k7jB74SixicJ7SfMnGPfx8TMyDQquPyNzr69Nox6/OlSPhC809X+pgs9Qn4+afWsq0BGVXnMJzNW27OXGtMyuJKITzGpyBujKHNJNJZYEHpp9rCul7kKGRaCJoGFmKV3fXjqQliJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTbSexiS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706527478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNer/v8iFw3iF09xSTRkhGhoZsEuyh12Q2EV6DHDyCc=;
	b=eTbSexiSrAvOctlVTVm5cb9NEvWJ0N8+TxKa568yj3jhWDwwk75xcA6RfoOZRdsUcsviUc
	roim5TJZFPLVb9f09YaO0HnqPt9FLtrMmChx+oQfKCrgHPHHOPHS7+h/VbUMIoAcq3ROnN
	5QzDWNtFvLgU8ody9ueCnRuMgQPrGEU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Phvqwf0aNS-LDx8ZAaLthQ-1; Mon,
 29 Jan 2024 06:24:32 -0500
X-MC-Unique: Phvqwf0aNS-LDx8ZAaLthQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CB933806635;
	Mon, 29 Jan 2024 11:24:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.247])
	by smtp.corp.redhat.com (Postfix) with SMTP id A7502152E;
	Mon, 29 Jan 2024 11:24:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jan 2024 12:23:17 +0100 (CET)
Date: Mon, 29 Jan 2024 12:23:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240129112313.GA11635@redhat.com>
References: <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127210634.GE13787@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/27, Oleg Nesterov wrote:
>
> I'll (hopefully) send v2 on top of
>
> 	pidfd: cleanup the usage of __pidfd_prepare's flags
> 	pidfd: don't do_notify_pidfd() if !thread_group_empty()
>
> on Monday

Sorry, I don't have time to finish v2 today, I need to update the comments
and write the changelog.

But the patch itself is ready, I am sending it for review.

Tycho, Christian, any comments?

Oleg.


From c31780f6c1136a72048d24701ac6d8401fc1afda Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Sat, 27 Jan 2024 16:59:18 +0100
Subject: [PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()

---
 include/uapi/linux/pidfd.h |  3 ++-
 kernel/exit.c              |  7 +++++++
 kernel/fork.c              | 29 +++++++++++++++++++++++++++--
 kernel/pid.c               |  2 +-
 kernel/signal.c            |  4 +++-
 5 files changed, 40 insertions(+), 5 deletions(-)

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
index dfb963d2f862..74fe6bfb9577 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -739,6 +739,13 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
 	tsk->exit_state = EXIT_ZOMBIE;
+	/*
+	 * sub-thread or delay_group_leader(), wake up the PIDFD_THREAD
+	 * waiters.
+	 */
+	if (!thread_group_empty(tsk))
+		do_notify_pidfd(tsk);
+
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
 				thread_group_empty(tsk) &&
diff --git a/kernel/fork.c b/kernel/fork.c
index 347641398f9d..977b58c0eac6 100644
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
@@ -2068,12 +2071,27 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
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
@@ -2083,7 +2101,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	 * If the thread group leader exits before all other threads in the
 	 * group, then poll(2) should block, similar to the wait(2) family.
 	 */
-	if (thread_group_exited(pid))
+	if (pidfd_task_exited(pid, thread))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
 
 	return poll_flags;
@@ -2141,6 +2159,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
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
@@ -2173,7 +2196,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
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
index c7a3e359f8f5..04bdd5ecf183 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -629,7 +629,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	int fd;
 	struct pid *p;
 
-	if (flags & ~PIDFD_NONBLOCK)
+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
 		return -EINVAL;
 
 	if (pid <= 0)
diff --git a/kernel/signal.c b/kernel/signal.c
index 9561a3962ca6..919cd33a0405 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 	/*
-	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
+	 * tsk is a group leader and has no threads, wake up the !PIDFD_THREAD
+	 * waiters.
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



