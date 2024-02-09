Return-Path: <linux-kernel+bounces-59343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162B84F5A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BD31C221BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A152376F9;
	Fri,  9 Feb 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPNmz+cV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA961374F8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484098; cv=none; b=K826lT7injzBnU3opkif1UECPUAN2LYEllS7qD/d/mAOL8wHU8FeOKOEC3FTpJVwQ4cHRXQEOCGvuL2SUNZTCRNF/IOFeqM4GReZz+7+y/arStJZ0jBV0J0tr1Y0zdOoB9tFJNzSBjCpGkjdelaPSp5QnYbI3ifOVDaAeJGqL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484098; c=relaxed/simple;
	bh=mHSlaxGCUJKdSq3oGHFsskIaS1mOF+ZiEDyOYY36WmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QySY0bIo0/nsRnMQPT7a6J5b2PruAzGsp75hv9hY3Hg2fCwn+koDpctXqYBjwFMfFp7xrAs5nE0cb9t5SkvcgdS/miP3oO/7aty6Wncyi3KiiMwYoV7jmveWNhjEvM75YjQp5GlkEc3iMNyA++U3iOcDZjG5+ZrHVDKLiFh20TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPNmz+cV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707484095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETbj5B8vI9mqFeC8WBwO1d2T9IgzINe0mXcd/+60DO0=;
	b=cPNmz+cVNXbCN+J+sKjqhhmayyD2HIPrvdmHbDe4nWLmUJ2y1aJDS9uLNP6hY793ZQOvu7
	Av4z6dUTaE76GWc8ne4B5LJ9KeShjwLIbsbHH78l4xX9yxk5qA6UsETwjmX62QBiyWHaB6
	f8SuVNHGT02JqMhArFc3/vNRqg8Sag8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-WKn6s1c9Mxu6tyxh85JWuQ-1; Fri, 09 Feb 2024 08:08:10 -0500
X-MC-Unique: WKn6s1c9Mxu6tyxh85JWuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A223D83B7E6;
	Fri,  9 Feb 2024 13:08:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 025AC8BCC;
	Fri,  9 Feb 2024 13:08:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 14:06:53 +0100 (CET)
Date: Fri, 9 Feb 2024 14:06:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209130650.GA8048@redhat.com>
References: <20240209130620.GA8039@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209130620.GA8039@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
pid_type to group_send_sig_info(), despite its name it should work fine
even if type = PIDTYPE_PID.

Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
on PIDFD_THREAD.

While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c   |  2 --
 kernel/signal.c | 38 ++++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cd61ca87d0e6..47b565598063 100644
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
index a8199fda0d61..9578ce17d85d 100644
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
@@ -3872,14 +3879,10 @@ static struct pid *pidfd_to_pid(const struct file *file)
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
@@ -3890,6 +3893,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
+	bool thread;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags)
@@ -3910,6 +3914,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (!access_pidfd_pidns(pid))
 		goto err;
 
+	thread = f.file->f_flags & PIDFD_THREAD;
+
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);
 		if (unlikely(ret))
@@ -3925,12 +3931,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo, SI_USER);
+		prepare_kill_siginfo(sig, &kinfo,
+				     thread ? SI_TKILL : SI_USER);
 	}
 
-	/* TODO: respect PIDFD_THREAD */
-	ret = kill_pid_info(sig, &kinfo, pid);
-
+	ret = kill_pid_info_type(sig, &kinfo, pid,
+				 thread ? PIDTYPE_PID : PIDTYPE_TGID);
 err:
 	fdput(f);
 	return ret;
-- 
2.25.1.362.g51ebf55



