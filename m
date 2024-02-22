Return-Path: <linux-kernel+bounces-76860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8E985FDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE4F287E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A1151CF3;
	Thu, 22 Feb 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="owEkeYMT"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B57151CC5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618204; cv=none; b=UIzJtW1nKXHmUGBi18QxXP0DMAiBmQer2ziGTQGBOlQNMPUYL8UeULJZNuWyxhngTxY2e8QU+U+idQ5EElxC+TO4GYERAjjqAmt0F4c5ezSgWxG8j0UUesmYiP7FcvJAIgIV+j0zMwhLiTsPTdCfiUWFEx3f3uIz3rgAkTZviWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618204; c=relaxed/simple;
	bh=VAARJbyByjfYUowrYEBvOr5VJx+E5jEyLas79aJZyFg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=C17Q3nYcCW0mmmk78pFzC2IivKdkx3+psPGUX7UaSM4ssqj9Yohc6fJWmjtj1STyVfpfpGWSc7rYC9w9btWwydrXWbabvojjC9kE+H3yhuDx6OkPzSyaEC0QeABq3QR+ZHgfGXn4KYKj1YCaViO1jgaqsQzvRUNj1TWjrq4GmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=owEkeYMT; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708617892;
	bh=vjLg0TSWsTe0chZQ3fuBODGo/vzvbbkVGlo25W/YgL8=;
	h=From:To:Cc:Subject:Date;
	b=owEkeYMTlWA81AQ2Ov455FK/7iNjh3ILUq4B2dPH3HRoJf5LdJFLczkRRS9en/olx
	 V1l7rmOQSm6MKe0huQbmJFv8QQHSMcA8++jfp36OfWTsEqdQS+OXdtiLQe2/31pKhO
	 G+8RayQWbZZMYPPcvwptgNogfcWQKFmVbo2OLluM=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:7404:388f:486a:7747])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 131B565A; Fri, 23 Feb 2024 00:04:49 +0800
X-QQ-mid: xmsmtpt1708617889t56zrz7dp
Message-ID: <tencent_09CF49556CD442411A93D0E92ACC2B7E5D08@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqAyF+hdEE/ByG4KGYO1CseUekNA69wAbtfaBeXNyKtLVasEGJN0
	 qy5g6p+FH26qGZHzdo5XnP3/bUsbmc58txge5SphCJ26cjze7bnVUrByy4eJR5rgyzSzvik+cE0R
	 4UI/nRWfdm2BWRYnAXhsL2CCqinhEhb4xncEer2svyeORTGqGmA+D2166CPlOUXLzZJUmb0dV0dB
	 qgK+Wi0J96/O87KfTXWQbsD+3VhgM5op5IC0OhOQKqnxnRA365Get8+jhfAy3RwGHeqNy+AujpPd
	 UvlrOwMEI+4EZptVbMSGzYVId4eSbIeiKXs2RcIZ+aW/0/Ab6Yix26995i3vAupqWHK7/HuyRie+
	 Rk4FyU2tzulEGqvkirg1gg0q67zZNwfM9kjSv14aRjYwhpvYV9lDqlW60fd0MY6no6ycN7FDdXFw
	 iB5alA1vjHsyzi6LKg/dA6gntzudQor3HJIkJE7cc2Wz+Pch3E5QiOdy9fAL50/QGvfwG9noUno4
	 DuOcrEpOjLB+iO5VgztrLhHFz3cMwKVb0zpOqWBiPu7LpXbiLbAYvHUWz98mfwW2U9q13UF9vCHn
	 xZhPdILxKseZii8O/t4Q41giT/Do9ovZ5/Z5qUY7SKFh+irRKixdgFgRY/CbQrEVLOf6lYr2izBi
	 5V8wvDJne3tm1TCAkxuwAmMw3bYyLZCbHrHtp9ZV8q3LftPSS6xL90iB4qtOunfsN/XGdILhRE+J
	 cS1KZyFahPVYdlJuJ85EPHm1NQVoPFuINvvTgmW2g/s6zoOzBG4+UYWJOpE3/T1CgaLsMfJ8RWRJ
	 CRGWZeffGXY0mVJQrSvlhCInZzWTNZNCFh5tuIz6e25nUGaeLHkN7s2ynMK1B8q+VxRbZ/cOcnMR
	 +vsEAa2AO7mFsh3Z8OJFdk1hUTCc61U5kRptZQAEmPUNkVqRiI3GvmQ+0l0dZCM+G3/VVhTCZn5k
	 HOT2XyLd40dhOECKspO3Dj6vm0acJNMdOPsROolAQrrh/3HFwaDPFW9itmdjjPAAUzb2KE1qXAvH
	 GsRdQZLJu9LNn0pw1Obm1E9iC6V/uxH+1Frwj7yRMcuCjbTVYz
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exit: add a tracepoint for profiling a task that is starting to exit
Date: Fri, 23 Feb 2024 00:04:34 +0800
X-OQ-MSGID: <20240222160434.350595-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Currently coredump_task_exit() takes some time to wait for the generation
of the dump file. But if the user-space wants to receive a notification
as soon as possible it maybe inconvenient.

Commit 2d4bcf886e42 ("exit: Remove profile_task_exit & profile_munmap")
simplified the code, but also removed profile_task_exit(), which may
prevent third-party kernel modules from detecting process exits timely.

Add the new trace_sched_profile_task_exit() this way a user-space monitor
could detect the exits and potentially make some preparations in advance.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/sched.h | 28 ++++++++++++++++++++++++++++
 kernel/exit.c                |  1 +
 2 files changed, 29 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..750b2f0bdf69 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -341,6 +341,34 @@ DEFINE_EVENT(sched_process_template, sched_wait_task,
 	TP_PROTO(struct task_struct *p),
 	TP_ARGS(p));
 
+/*
+ * Tracepoint for profiling a task that is starting to exit:
+ */
+TRACE_EVENT(sched_profile_task_exit,
+
+	TP_PROTO(struct task_struct *task, long code),
+
+	TP_ARGS(task, code),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	prio			)
+		__field(	long,	code			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->pid		= task->pid;
+		__entry->prio		= task->prio;
+		__entry->code		= code;
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d exit_code=0x%lx",
+		  __entry->comm, __entry->pid, __entry->prio,
+		  __entry->code)
+);
+
 /*
  * Tracepoint for a waiting task:
  */
diff --git a/kernel/exit.c b/kernel/exit.c
index 493647fd7c07..f675f879a1b2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -826,6 +826,7 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(tsk->plug);
 
+	trace_sched_profile_task_exit(tsk, code);
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
-- 
2.25.1


