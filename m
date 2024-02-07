Return-Path: <linux-kernel+bounces-56416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F292F84C9E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EC61F2506A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45791B7F7;
	Wed,  7 Feb 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1+SCfFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5741B7E3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306433; cv=none; b=r+MTosaeYHm0F70UVd47xesyB2jVShQWdv7TppCgJ3wFIcdk7H/lCMVE1IBdIqlRhnL8z38ew5SgY5nMfz1kQw7nVR6W8sAkb0s4DambvLvlQyJK8cIiPrqv/+CESgx3zz32drWjgcqrZDoxPgXYxB9JqgbqDLzHPEPHhIc8Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306433; c=relaxed/simple;
	bh=tjrQh1y4H5W6sx6xqeHy4JzMSxFgjnezbUH6ZJHM5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=klXR/+PvGbwRbxAEzs+yUlZBSsuUXNXG7Gh5DpdbZ/MKCH+rWwn2D3y7SxMYs4AEehhQ8gzazKYHosJWBX83D2BdLdBTJ0DD7Z4MESyJZ76SBcSHpGL7SP2GSCJ64pKIIQqwCWYIrnEgtwDfWSiFhCxblneOSezWQ/YJnn3umG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1+SCfFb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707306429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nvbuj/0u9tEQEJhqguXdXu/oFCwcAEaMYAW5rW/LIQU=;
	b=a1+SCfFbIJhGzlOD8valK23DgWu7JYk8fdd0alY8o8ZjLFJRGEHzMVaIaGuZ6gJ3sYIlDs
	Pmibue2fZwnnsaWp4IWpgp7jrSSHJ77fEpQG093r2/IZumN5sT7NHY00nqc6mGn1tHLEmj
	tVj0DwLRcpVA1cmZMqQ0myAwWfPZLvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-aNrfZZEpPIqEjvdaQ2srow-1; Wed, 07 Feb 2024 06:47:08 -0500
X-MC-Unique: aNrfZZEpPIqEjvdaQ2srow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F195185A588;
	Wed,  7 Feb 2024 11:47:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.212])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5171F1C02EB3;
	Wed,  7 Feb 2024 11:47:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Feb 2024 12:45:51 +0100 (CET)
Date: Wed, 7 Feb 2024 12:45:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240207114549.GA12697@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
 kernel/signal.c | 18 ++++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

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
index c3fac06937e2..e3edcd784e45 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <linux/cgroup.h>
 #include <linux/audit.h>
 #include <linux/sysctl.h>
+#include <uapi/linux/pidfd.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1478,7 +1479,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 	return ret;
 }
 
-int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+static int kill_pid_info_type(int sig, struct kernel_siginfo *info,
+				struct pid *pid, enum pid_type type)
 {
 	int error = -ESRCH;
 	struct task_struct *p;
@@ -1487,11 +1489,10 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
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
@@ -1500,6 +1501,11 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
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
@@ -3890,6 +3896,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
+	enum pid_type type;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags)
@@ -3928,9 +3935,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo);
 	}
 
-	/* TODO: respect PIDFD_THREAD */
-	ret = kill_pid_info(sig, &kinfo, pid);
-
+	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
+	ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
 	fdput(f);
 	return ret;
-- 
2.25.1.362.g51ebf55



