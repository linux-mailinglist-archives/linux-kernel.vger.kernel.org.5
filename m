Return-Path: <linux-kernel+bounces-49883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259918470E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF9A1F2A718
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C7210FE;
	Fri,  2 Feb 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX1NJ3mP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F022772A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879649; cv=none; b=P2h2dCcHNbnlH7q+pdjZX3I6ypO5OIgq8T3GzhT68lPq1CMM6RjKaRqQsevcCLm3k7mnJ+PRZJD976UvRRtXAJkarIitK/GfK4cTmalDzNFrXXA1z88yrF3T02VkTViyv00V0sb0m1neBNYt2HwlnExVz519ZeS3+1a69zqm6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879649; c=relaxed/simple;
	bh=Ll/s1Mpq1wn0WVe7lBWJ6vbuD1ND6xPjIS/Y+odacrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P4mz6sCsu7yyYPy/13DcIdYO22B8CAlwrLZU8XEOT0rc4ttclCOh5swlsQXIyZ1q4omP6ceyZOstD8uecDJX4SpQdrnaQ9QtERfFlN4V+hLVQzevnISxHtHxPDKxG1JKyVUR6fpH1ESKrqhlmGrNGXBF451rTsLM7aQfswDQhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX1NJ3mP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=hcrUB/TxGDQzkVWVzEEPdidIHt7V/i+DGLB/TQZqAG4=;
	b=KX1NJ3mPuL8X4OjuyxctE5FOG+qiczWYN/Vo1H5g6BTzhB7FrzzRCMWeewOrNYmj/vV/E7
	Ia5MOBDu5418XVNnOSvF5Tw0KeHLp6XHu/wKxwx06Ujc99cZs7Tx/3OQ/u+PxO3TGSRgJh
	6X1BY0MSQDbCtdTVWstnxt2c1hVfhuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-UFkX2USqOH-HlUQt27oB7w-1; Fri,
 02 Feb 2024 08:14:03 -0500
X-MC-Unique: UFkX2USqOH-HlUQt27oB7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 614F529AC00E;
	Fri,  2 Feb 2024 13:14:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0F4B4400D783;
	Fri,  2 Feb 2024 13:14:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 14:12:48 +0100 (CET)
Date: Fri, 2 Feb 2024 14:12:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240202131226.GA26018@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131147.GA25988@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add another wake_up_all(wait_pidfd) into __change_pid() and change
pidfd_poll() to include EPOLLHUP if task == NULL.

This allows to wait until the target process/thread is reaped.

TODO: change do_notify_pidfd() to use the keyed wakeups.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 22 +++++++---------------
 kernel/pid.c  |  5 +++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index b8c6ec9a08dd..8d08a2d1b095 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2071,20 +2071,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-static bool pidfd_task_exited(struct pid *pid, bool thread)
-{
-	struct task_struct *task;
-	bool exited;
-
-	rcu_read_lock();
-	task = pid_task(pid, PIDTYPE_PID);
-	exited = !task ||
-		(READ_ONCE(task->exit_state) && (thread || thread_group_empty(task)));
-	rcu_read_unlock();
-
-	return exited;
-}
-
 /*
  * Poll support for process exit notification.
  */
@@ -2092,6 +2078,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct pid *pid = file->private_data;
 	bool thread = file->f_flags & PIDFD_THREAD;
+	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
@@ -2099,8 +2086,13 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	 * Depending on PIDFD_THREAD, inform pollers when the thread
 	 * or the whole thread-group exits.
 	 */
-	if (pidfd_task_exited(pid, thread))
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
+	else if (task->exit_state && (thread || thread_group_empty(task)))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
+	rcu_read_unlock();
 
 	return poll_flags;
 }
diff --git a/kernel/pid.c b/kernel/pid.c
index e11144466828..62461c7c82b8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -349,6 +349,11 @@ static void __change_pid(struct task_struct *task, enum pid_type type,
 	hlist_del_rcu(&task->pid_links[type]);
 	*pid_ptr = new;
 
+	if (type == PIDTYPE_PID) {
+		WARN_ON_ONCE(pid_has_task(pid, PIDTYPE_PID));
+		wake_up_all(&pid->wait_pidfd);
+	}
+
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
 		if (pid_has_task(pid, tmp))
 			return;
-- 
2.25.1.362.g51ebf55


