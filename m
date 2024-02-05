Return-Path: <linux-kernel+bounces-52787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1186849CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366531F25B21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DD249F7;
	Mon,  5 Feb 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyGcyUUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FA24219
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142215; cv=none; b=mV1GjeIZYNnpVKnkOWTb2RQ0z+T2rGYMVGjjPz2icLHicqwE6YfkbN4naffx5ZMYbxwYTm8IFuX52192B2bEG0knH7Q9LB7S0eQoiCsuU/ZCBxDs8ITjEClxfi/0ikaIKOtQCKPNlog8YkiOU71DwesLwtlKDbaiFAr9zlePKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142215; c=relaxed/simple;
	bh=VlPtY6olNrjVao89eI0OmwV4oZkcWMIdDl7/nQOTaHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH9yxGLVJvcR7pE/Xv9i5NKpaeu0fV+5cn8Tl9ZRZlBeqLFX5cym5yo1Q8kl+25tMFj+g2kIqfJk9ThvVSgxJyoJW7sN98ILtUXLiTSMHbQ4Mbd0XSTmJytyCGYB6LSDrJtYwi3LF/lvNkVSBqR0D+ygN/3lNH29utzqe5Ik4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyGcyUUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707142213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klU6EPOskgTXRS466DyWudV8fKqQ0vbbL3vzBLrKzXo=;
	b=IyGcyUUkWp8Wsgd00zo2+hAcjSHfCPYZ4sgNzx7M1k51e0+yD7kW/mdDCGogEoe07RwjG+
	1pNLpScelk0WfZtmXKk9H7FX9ukudEOWyMfYS8E6aBw5O7BY1/sR3bZJizhkiLYFi+wJaT
	UeGJjOdLnKICnQqaBnwiPMEyJbIjzqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-rOw9yvsHMbiS6h4KY0Sz_g-1; Mon,
 05 Feb 2024 09:10:07 -0500
X-MC-Unique: rOw9yvsHMbiS6h4KY0Sz_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF4EC1C09820;
	Mon,  5 Feb 2024 14:10:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id 408372166B31;
	Mon,  5 Feb 2024 14:10:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 15:08:51 +0100 (CET)
Date: Mon, 5 Feb 2024 15:08:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240205140848.GA15853@redhat.com>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
 <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
 <20240202190529.GA28818@redhat.com>
 <20240203120425.GA30029@redhat.com>
 <20240203-freuden-frucht-b598f8cca27d@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-freuden-frucht-b598f8cca27d@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/03, Christian Brauner wrote:
>
> On Sat, Feb 03, 2024 at 01:04:26PM +0100, Oleg Nesterov wrote:
> >
> > -	wake_up_all(&pid->wait_pidfd);
> > +	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
> > +		  poll_to_key(EPOLLIN | EPOLLRDNORM));
>
>
> Ok, care to just send me a full patch for this?

Will do in a minute,



> Second, I agree that this looks ugly. ;/

Agreed ;)

> So here's a very likely a stupid idea. To make that clean we essentially
> need kernel private information that can't be set in userspace (Btw,
> look at EPOLL_URING_WAKE which is similar in that it cannot be set from
> userspace. It's not the same thing ofc but it is a private bit.). Which
> is the gist of your proposal in a way.
>
> So we would have to grab a new private bit in the epoll flag space.

Agreed, but just in case:

	- EPOLLMSG (ab)used by this patch can't "leak" to userspace even
	  if it was (erroneously) set in pollfd.events

	- If EPOLLMSG was set by userspace nothing bad can happen, just
	  poll(non-PIDFD_THREAD-pidfd) will get the spurious wakeups.

So. I am attaching the patch for the record, in case we return to this
later.

It seems to work fine, but when I look into fs/eventpoll.c I suspect
it is not epoll friendly. I _think_ that the neccessary fix is trivial,
ep_item_poll() should just copy pt->_key to epi->event.events after
vfs_poll(), but I am not sure. So lets forget it for now.

Oleg.
---

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 8124d57752b9..7467cdb9735b 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -74,7 +74,7 @@ struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
-void do_notify_pidfd(struct task_struct *task);
+void do_notify_pidfd(struct task_struct *task, bool thread);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..c31f36d3a1ed 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,7 +744,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	 * PIDFD_THREAD waiters.
 	 */
 	if (!thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		do_notify_pidfd(tsk, true);
 
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
diff --git a/kernel/fork.c b/kernel/fork.c
index 8d08a2d1b095..3b4474ff6f4a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2081,6 +2081,15 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
+	if (pts && pts->_qproc) {
+		/*
+		 * We are not registered yet. Update pts->_key to mark us as
+		 * a non POLLHUP-only PIDFD_THREAD waiter for do_notify_pidfd,
+		 * _pollwait() will copy this _key to poll_table_entry->key.
+		 */
+		if (thread && (pts->_key & (EPOLLIN | EPOLLRDNORM)))
+			pts->_key |= EPOLLMSG;
+	}
 	poll_wait(file, &pid->wait_pidfd, pts);
 	/*
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
diff --git a/kernel/signal.c b/kernel/signal.c
index c3fac06937e2..f51070dec132 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,14 +2019,15 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task, bool thread)
 {
+	/* see the usage of EPOLLMSG in pidfd_poll() */
+	__poll_t m = thread ? EPOLLMSG : EPOLLIN | EPOLLRDNORM;
 	struct pid *pid = task_pid(task);
 
 	WARN_ON(task->exit_state == 0);
 
-	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
-			poll_to_key(EPOLLIN | EPOLLRDNORM));
+	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0, poll_to_key(m));
 }
 
 /*
@@ -2056,7 +2057,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * non-PIDFD_THREAD waiters.
 	 */
 	if (thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		do_notify_pidfd(tsk, false);
 
 	if (sig != SIGCHLD) {
 		/*


