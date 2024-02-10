Return-Path: <linux-kernel+bounces-60360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D9B8503E2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872031C21914
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD13364C5;
	Sat, 10 Feb 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAVZeQQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED03611E;
	Sat, 10 Feb 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707560597; cv=none; b=rfmlGfP7mv5eysK3yvYIXpMfCc7+H9aSQMZFCDhHjN/QK9vcTteQIEe58/UVXIEXk4eMR+sw3MRMTJmIbwT11j1cIi9Ay3NR4KhFPdHHC9+wPjIeXTeweIdTzPIoS1jWFPTaYYJVHIxTFS95lDLJilL+S9mqWshVDc9d2m74AOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707560597; c=relaxed/simple;
	bh=2NohwMntg56S0VFXTKPyYwyqPYjBkrLyO8gcG29B3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEoGw268O7YI9PiS3D1KksrMfqFYjkqV8tqtcD/05Y89VV2ZbOKI7PLgvlVcS86gqFODDXLro/l/DTSgTafsCWZ8Qhk7Rw7PPeiFHpqDwGRATlc6wHyWRhXKtGVVV9Y0FvZAi3MgTZGjyKh2JsdLCht5KzWbxez/dIn8xwEa07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAVZeQQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F9CC433F1;
	Sat, 10 Feb 2024 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707560596;
	bh=2NohwMntg56S0VFXTKPyYwyqPYjBkrLyO8gcG29B3Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAVZeQQH9UC1scU5hGFRc4k61xLYvTY2ARezjvcemJ6ZzbJmGtMcr6vgUGkVrTJxi
	 iDf2FCglJ5/zZR67xDI4FArAJ40ISIVoeARw1vFWTLymmavKmpmxNQWyijhChhMO2S
	 +ljePcFN6cyPiQVTpURFw0z4WSXvPpToAqoW3tovzWxY+QFzi2sOjK/jDDnVXogfk7
	 G2LUErlmP3K7EQ79fgCfc9Le4BpFw7Wxhz5u1iA9DBYwaVWNrla8y8aFSpKtNqMy4J
	 wOj7UBviwIvtJuHdfD9ftZcC8VjTEmug7ogVV5lOc35w65kMn8OnwlX2iOFbZWtNUd
	 bJPbkYc1xhEUg==
Date: Sat, 10 Feb 2024 11:23:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209155644.GD3282@redhat.com>

> and I forgot to mention, if you want to add PIDFD_SIGNAL_PRGP you can
> look at __kill_pgrp_info().

Yeah, I did that and there's a semantical twist in the old kill(2)
system call that made me think:

(1) kill(-1234) => kill process group with id 1234
(2) kill(0)     => kill process group of @current

which implementation wise is indicated by

__kill_pgrp_info(..., pid ? find_vpid(-pid) ? task_pgrp(current))

We're obviously not going to implement (2) as that doesn't really make a
sense for pidfd_send_signal().

But (1) is also wrong for pidfd_send_signal(). If we'd ever implement
(1) it should be via pidfd_open(1234, PIDFD_PROCESS_GROUP).

So if PIDFD_PROCESS_GROUP is set then we want to send a signal to the
process group that @pidfd is in. Unless there's reasons we can't do
this. I tried to draft this and what I have is a totally uncompiled
draft.

I was unsure how best to cleanly express how to take the process group
from the struct pid of that @pidfd. So I modeled it after how we do it
for PIDTYPE_TGID.

From 8d886b07cc1b17cc6dd3a9ebf19c51212282b6f5 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Feb 2024 15:49:45 +0100
Subject: [PATCH] [RFC] pidfd: allow to override signal scope in
 pidfd_send_signal()

Right now we determine the scope of the signal based on the type of
pidfd. There are use-cases where it's useful to override the scope of
the signal. For example in [1]. Add flags to determine the scope of the
signal:

(1) PIDFD_SIGNAL_THREAD: send signal to specific thread reference by @pidfd
(2) PIDFD_SIGNAL_THREAD_GROUP: send signal to thread-group of @pidfd
(2) PIDFD_SIGNAL_PROCESS_GROUP: send signal to process-group of @pidfd

There's a semantical quirk in the old kill(2) system call that made me think:

(1) kill(-1234) => kill process group with id 1234
(2) kill(0)     => kill process group of @current

as indicated by

__kill_pgrp_info(..., pid ? find_vpid(-pid) ? task_pgrp(current))

We're obviously not going to implement (2) as that doesn't really make a
lot of sense for pidfd_send_signal().

But (1) is also wrong for pidfd_send_signal(). If we'd ever implement
(1) it should be via pidfd_open(..., PIDFD_PROCESS_GROUP).

Link: https://github.com/systemd/systemd/issues/31093 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/pidfd.h |  5 +++++
 kernel/signal.c            | 46 ++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

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
index 8b8169623850..f0f9a5a822b4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3873,6 +3873,23 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
+static int kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+{
+	struct task_struct *p;
+	int ret = -ESRCH;
+
+	read_lock(&tasklist_lock);
+	p = pid_task(pid, PIDTYPE_PID);
+	if (p)
+		ret = __kill_pgrp_info(sig, info, task_pgrp(p));
+	read_unlock(&tasklist_lock);
+	return ret;
+}
+
+#define PIDFD_SEND_SIGNAL_FLAGS                            \
+	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
+	 PIDFD_SIGNAL_PROCESS_GROUP)
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -3897,7 +3914,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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
@@ -3915,10 +3936,24 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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
@@ -3938,7 +3973,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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




