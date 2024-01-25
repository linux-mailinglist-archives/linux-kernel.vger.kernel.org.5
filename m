Return-Path: <linux-kernel+bounces-38705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADE83C45A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E251F23617
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83E63126;
	Thu, 25 Jan 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kw6gGX0U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79857633E4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191795; cv=none; b=doBU7TxJuQR+ff5MoelxR4/8+fx4RtpUYnfiRLJwia3kwaym+rZtmMiwUfpdcqWZvaJWubQ4hT0uv2wreLQqd8SNkkaB/naDrY0emJmjJ1VCU/dIz0xlLAe3oj5wJxwaNjX0alnxiKsmkJo/dL/lK74LdYlucMAjlvuTiRO6zWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191795; c=relaxed/simple;
	bh=S+4hMy1M89A/ViQObRAG9pigwG+uvKA4pnLBzzqhjo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgIf1fGiZyk0+K9mAT/1DlzsIYC8plqDLhZUl8aBsL0JFbGjTusAOqoq3UZ0Ds7kyULeiU44wsTz1gCGPgX+5voMtXab0wKdfY7/uhhuyBVeNF4Wrc7VpJpKQ8NuwH2QNKqQ9MdvB7tW/iqoF/Skhmur+N0lwGaq5/Sh5q1npA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kw6gGX0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706191789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jV3kBqGQnSVi6PRDgMj7+x6sh3ddpdE2IkidGSTX9R0=;
	b=Kw6gGX0UgUu/0pJ1Hpc1JKmkZqSgfuUopI37avblEF0t2HHUKwzalkkMdaZRs+HFDT3Slh
	0OBDZE2Gdz8tCamXPL8WxoCGTXb2Lm2CeZ1jjmzn5po208lXJqcnSFhPH2Uo4/vbkCfErx
	0SUaJ2I10qL8rPKi96oT6mjivxVBC1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-L7VrF8nSOMiePghSFkTmPg-1; Thu, 25 Jan 2024 09:09:47 -0500
X-MC-Unique: L7VrF8nSOMiePghSFkTmPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05598881C82;
	Thu, 25 Jan 2024 14:09:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5FE632026F95;
	Thu, 25 Jan 2024 14:09:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jan 2024 15:08:33 +0100 (CET)
Date: Thu, 25 Jan 2024 15:08:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240125140830.GA5513@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbArN3EYRfhrNs3o@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add Eric.

On 01/23, Tycho Andersen wrote:
>
> On Tue, Jan 23, 2024 at 08:56:08PM +0100, Oleg Nesterov wrote:
>
> > So. When do we want to do do_notify_pidfd() ? Whe the task (leader or not)
> > becomes a zombie (passes exit_notify) or when it is reaped by release_task?
>
> It seems like we'd want it when exit_notify() is called in principle,
> since that's when the pid actually dies.

No the pid "dies" after this task is reaped, until then its nr is still
in use and pid_task(PIDTYPE_PID) returns the exiting/exited task.

> When it is reaped is "mostly unrelated".

Then why pidfd_poll() can't simply check !task || task->exit_state ?

Nevermind. So, currently pidfd_poll() succeeds when the leader can be
reaped, iow the whole thread group has exited. But even if you are the
parent, you can't expect that wait(WNOHANG) must succeed, the leader
can be traced. I guess it is too late to change this behaviour.

What if we add the new PIDFD_THREAD flag? With this flag

	- sys_pidfd_open() doesn't require the must be a group leader

	- pidfd_poll() succeeds when the task passes exit_notify() and
	  becomes a zombie, even if it is a leader and has other threads.


Please the the incomplete/untested patch below.

	- The change in exit_notify() is sub-optimal, we can do better
	  to avoid 2 do_notify_pidfd() calls from exit_notify(). But
	  so far this is only for discussion, lets keep it simple.

	- __pidfd_prepare() needs some minor cleanups regardless of
	  this change, I'll send the patch...

What do you think?

And why is thread_group_exited() exported?

Oleg.

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 5406fbc13074..2e6461459877 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -7,6 +7,7 @@
 #include <linux/fcntl.h>
 
 /* Flags for pidfd_open().  */
-#define PIDFD_NONBLOCK O_NONBLOCK
+#define PIDFD_NONBLOCK	O_NONBLOCK
+#define PIDFD_THREAD	O_EXCL	// or anything else not used by anon_inode's
 
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index dfb963d2f862..9f8526b7d717 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -752,6 +752,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		autoreap = true;
 	}
 
+	/* unnecessary if do_notify_parent() was already called,
+	   we can do better */
+	do_notify_pidfd(tsk);
+
 	if (autoreap) {
 		tsk->exit_state = EXIT_DEAD;
 		list_add(&tsk->ptrace_entry, &dead);
diff --git a/kernel/fork.c b/kernel/fork.c
index c981fa6171c1..38f2c7423fb4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -101,6 +101,7 @@
 #include <linux/user_events.h>
 #include <linux/iommu.h>
 #include <linux/rseq.h>
+#include <uapi/linux/pidfd.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2068,12 +2069,27 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static bool xxx_exited(struct pid *pid, int excl)
+{
+	struct task_struct *task;
+	bool exited;
+
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	exited = !task ||
+		(READ_ONCE(task->exit_state) && (excl || thread_group_empty(task)));
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
+	int excl = file->f_flags & PIDFD_THREAD;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
@@ -2083,7 +2099,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	 * If the thread group leader exits before all other threads in the
 	 * group, then poll(2) should block, similar to the wait(2) family.
 	 */
-	if (thread_group_exited(pid))
+	if (xxx_exited(pid, excl))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
 
 	return poll_flags;
@@ -2129,7 +2145,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 {
 	int pidfd;
 	struct file *pidfd_file;
+	unsigned excl = flags & PIDFD_THREAD;
 
+	flags &= ~PIDFD_THREAD;
 	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
 		return -EINVAL;
 
@@ -2144,6 +2162,7 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 		return PTR_ERR(pidfd_file);
 	}
 	get_pid(pid); /* held by pidfd_file now */
+	pidfd_file->f_flags |= excl;
 	*ret = pidfd_file;
 	return pidfd;
 }
@@ -2176,7 +2195,9 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+	unsigned excl = flags & PIDFD_THREAD;
+
+	if (!pid || !pid_has_task(pid, excl ? PIDTYPE_PID : PIDTYPE_TGID))
 		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
diff --git a/kernel/pid.c b/kernel/pid.c
index b52b10865454..5257197f9493 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -629,7 +629,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	int fd;
 	struct pid *p;
 
-	if (flags & ~PIDFD_NONBLOCK)
+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
 		return -EINVAL;
 
 	if (pid <= 0)


