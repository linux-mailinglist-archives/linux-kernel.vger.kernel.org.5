Return-Path: <linux-kernel+bounces-49965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3390847224
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E5286144
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FA137C41;
	Fri,  2 Feb 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9zBbYfc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E718036;
	Fri,  2 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885090; cv=none; b=Thvr9AUVk2apHcpujnEuDiIPlddaZckD3+DyLZCfdG7yz0Opd/KgmliJyHCFYvtXT5J0ioHoy3RBnli+aoiXBSyNXOzv5jh6+FuF6cX5FvQd22RtmKHceO8venwdAb9mO/axMecarYAk3V1PtbDlXBCcWPnaUpA0z8KrwbQ8LtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885090; c=relaxed/simple;
	bh=+ymyXuB8pyInpfneV0fMDu69g0i2TTU3GG5qclVvWnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHorWRs69VvJyxbR1H3hSNtPxeQCL7eABVr6Mhge0OPsesjc33bFJt8VzkRmCPGiM1QQzZYCsWG4xTFrfQM+XLCQCYMW44rzWbpVMqVaMuKlKP04ickryD6rF9Aq5kFYm6Ee3hRRZY6jKM5zeyxL9+8I8W8tjKDAAySiu8oKvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9zBbYfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1AAC433C7;
	Fri,  2 Feb 2024 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706885089;
	bh=+ymyXuB8pyInpfneV0fMDu69g0i2TTU3GG5qclVvWnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9zBbYfcat+/5u+2ddP092SQgRPWJnVrd+xC0h4p5B1wSDbwJOO+XYYD2D0pWd7Hp
	 /9X1BibnKlIN4eS//ULFMCI3Jo9TuWqMDThU3LiGJnTyOYL+N2kpQ2UCJIyKAWyl/6
	 xK/6uuXjLamXCJimLl09lyF1hiAVsHg9mFaCTgmYahzqMhZf6jj2rQZyiKmxwTz3Nd
	 QfdywYAbBxQ1Nw1AazVi7wWAJt0oJ08eWqSBpr6DoYMcliC8enFarFUTfEw6qMsbtw
	 A6GnfW0AxzQhPCE5SKR7k9Cnjqlmr6Cs7bPcSFDtOb2Ej0/FzTkaIdwX70y7GAffWa
	 MXfvEddue9OKA==
Date: Fri, 2 Feb 2024 15:44:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202-arbeit-fruchtig-26880564a21a@brauner>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qtcprolcuit77q76"
Content-Disposition: inline
In-Reply-To: <20240202131226.GA26018@redhat.com>


--qtcprolcuit77q76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> TODO: change do_notify_pidfd() to use the keyed wakeups.

How does the following appended patch look?

--qtcprolcuit77q76
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-pidfd-convert-to-wake_up_poll.patch"

From d8ef35f3f151a758cb2503a51dfaf7263480cfbd Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Feb 2024 15:18:16 +0100
Subject: [PATCH] pidfd: convert to wake_up_poll()

* Rename do_notify_pidfd() pidfd_wake_up_poll()
* Pass in a poll mask to enable epoll to avoid spurious wakeups
* Use poll_table typedef
* Warn if caller doesn't pass in appropriate poll mask

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h |  2 +-
 kernel/exit.c       |  2 +-
 kernel/fork.c       |  4 ++--
 kernel/signal.c     | 10 ++++------
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 8124d57752b9..a3666b2ae877 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -74,7 +74,7 @@ struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
-void do_notify_pidfd(struct task_struct *task);
+void pidfd_wake_up_poll(struct task_struct *task, __poll_t mask);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index c038d10dfb38..b4b39709b046 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,7 +744,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	 * PIDFD_THREAD waiters.
 	 */
 	if (!thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		pidfd_wake_up_poll(tsk, EPOLLIN | EPOLLRDNORM | EPOLLHUP);
 
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
diff --git a/kernel/fork.c b/kernel/fork.c
index aa08193d124f..7b882e66448b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2074,14 +2074,14 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 /*
  * Poll support for process exit notification.
  */
-static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
+static __poll_t pidfd_poll(struct file *file, poll_table *wait)
 {
 	struct pid *pid = file->private_data;
 	bool thread = file->f_flags & PIDFD_THREAD;
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
-	poll_wait(file, &pid->wait_pidfd, pts);
+	poll_wait(file, &pid->wait_pidfd, wait);
 	/*
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
 	 * or the whole thread-group exits.
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b40109f0c56..ef330a7f1b51 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,13 +2019,11 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-void do_notify_pidfd(struct task_struct *task)
+void pidfd_wake_up_poll(struct task_struct *task, __poll_t mask)
 {
-	struct pid *pid;
-
 	WARN_ON(task->exit_state == 0);
-	pid = task_pid(task);
-	wake_up_all(&pid->wait_pidfd);
+	WARN_ON(mask == 0);
+	wake_up_poll(&task_pid(task)->wait_pidfd, mask);
 }
 
 /*
@@ -2055,7 +2053,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * non-PIDFD_THREAD waiters.
 	 */
 	if (thread_group_empty(tsk))
-		do_notify_pidfd(tsk);
+		pidfd_wake_up_poll(tsk, EPOLLIN | EPOLLRDNORM);
 
 	if (sig != SIGCHLD) {
 		/*
-- 
2.43.0


--qtcprolcuit77q76--

