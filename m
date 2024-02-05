Return-Path: <linux-kernel+bounces-53141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5684A131
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823EEB20B32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06C47F59;
	Mon,  5 Feb 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EddhWbiX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0447F5B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155110; cv=none; b=EDJ9nFqlyPCgboFcjRGokfPpQWjrkSiVgduahWeOmiTJ1TG8j/bJdZnC80/MP9AN2bwCNcFvqEgLJVFZlUFSKoLECI2e+O3NQFThGGNI9NMIERONlaxUkKlhoQB6ux3D0ezmttJ41Dt4V+ZXZTa0eN8sbwZxat+QnNDtnLQTHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155110; c=relaxed/simple;
	bh=WRPxwYmspKNKyfLLir/GX8MR7k+AFM05a8Ogn1J176k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iV5At1bODZ7skXMAIMRMBI07KSe0O/r/AG10nwgGmjbIwxYqNnkczxTd7kB0WHlak+nETh5DgQPVHyj2YIp5oOXsXDTQuLBVDZ/w4zjban/k4IAQ+D1tfxgf91MOZMrkCJpCVe4g19+KZ1iOoANtbjp4L4e8XpZluci4kRd2eKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EddhWbiX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707155108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lQvFAhGMFn+pd39FfBTWUiYQUgdCwLWcjWFOoTOc6PA=;
	b=EddhWbiXk/f40UE9bi8R9yGy/QqOF2BxaXFVU6nJlYgJN6OU6bo9OC/VVKeISm3Xk4fJaj
	C/FMoN+tj9wxO2O5kUd2URxqShJ/LBhFWBKMcL2IMD0yCrUoumf+X5y0vzmFeaoDGGGnoL
	X7q1B+VtjEQKAT9j6Bgvo4XlnVAjW70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-RV1cYdI6PhmAFzjnH-0N_Q-1; Mon,
 05 Feb 2024 12:45:04 -0500
X-MC-Unique: RV1cYdI6PhmAFzjnH-0N_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FB3338143A3;
	Mon,  5 Feb 2024 17:45:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id 085932026F95;
	Mon,  5 Feb 2024 17:45:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 18:43:48 +0100 (CET)
Date: Mon, 5 Feb 2024 18:43:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: exit: kill the no longer used thread_group_exited()
Message-ID: <20240205174347.GA31461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

It was used by pidfd_poll() but now it has no callers.

If it finally finds a modular user we can revert this change, but note
that the comment above this helper and the changelog in 38fd525a4c61
("exit: Factor thread_group_exited out of pidfd_poll") are not accurate,
thread_group_exited() won't return true if all other threads have passed
exit_notify() and are zombies, it returns true only when all other threads
are completely gone. Not to mention that it can only work if the task
identified by @pid is a thread-group leader.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h |  2 --
 kernel/exit.c                | 24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 4b7664c56208..0a0e23c45406 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -735,8 +735,6 @@ static inline int thread_group_empty(struct task_struct *p)
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
-extern bool thread_group_exited(struct pid *pid);
-
 extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
 							unsigned long *flags);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..41a12630cbbc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1896,30 +1896,6 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 }
 #endif
 
-/**
- * thread_group_exited - check that a thread group has exited
- * @pid: tgid of thread group to be checked.
- *
- * Test if the thread group represented by tgid has exited (all
- * threads are zombies, dead or completely gone).
- *
- * Return: true if the thread group has exited. false otherwise.
- */
-bool thread_group_exited(struct pid *pid)
-{
-	struct task_struct *task;
-	bool exited;
-
-	rcu_read_lock();
-	task = pid_task(pid, PIDTYPE_PID);
-	exited = !task ||
-		(READ_ONCE(task->exit_state) && thread_group_empty(task));
-	rcu_read_unlock();
-
-	return exited;
-}
-EXPORT_SYMBOL(thread_group_exited);
-
 /*
  * This needs to be __function_aligned as GCC implicitly makes any
  * implementation of abort() cold and drops alignment specified by
-- 
2.25.1.362.g51ebf55



