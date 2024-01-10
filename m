Return-Path: <linux-kernel+bounces-21561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A64829126
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899511C25199
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06B1109;
	Wed, 10 Jan 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqi4B/uk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7410A59;
	Wed, 10 Jan 2024 00:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FEAC433C7;
	Wed, 10 Jan 2024 00:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704845591;
	bh=Gv4c6KiHO29Wy6P60cNBnzMOUtlrYYrwMdYxxWKGGFY=;
	h=From:To:Cc:Subject:Date:From;
	b=Bqi4B/uk/VltCFfhEXjIjNk7QvDsCS+7JyqKYmONimHrhav1/UluI5Nj7jT6Lq2Mn
	 ZjeclY/aL5T1PCOQ9r97Zqh8QTFuRJzLX9GKFEKzgqXIrLh/G9Mn2IEhg9H82xM5BY
	 MtEIot4/yqrFGesVhf70KaGIjvY94GeRS9jpjAskeudO24Awc36Kei+WjyQouYjMow
	 oJ4Qw5RB8JL4BoE42UFOjtd4UeEp0vsowgqhRTyBbsjaXNjIp7fp5EqK3HMrG3lPYA
	 YR4xeaIyW1bIaiPwW6kEqAx3MudklNnZG5QxCo18Ub5g/GV7QN50w2p0+AjbNl8ZO2
	 77p9tjUs4nF3w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
Date: Wed, 10 Jan 2024 09:13:06 +0900
Message-Id: <170484558617.178953.1590516949390270842.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The commit 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS
and !WITH_REGS") changed DIRECT_CALLS to use SAVE_ARGS when there
are multiple ftrace_ops at the same function, but since the x86 only
support to jump to direct_call from ftrace_regs_caller, when we set
the function tracer on the same target function on x86, ftrace-direct
does not work as below (this actually works on arm64.)

At first, insmod ftrace-direct.ko to put a direct_call on
'wake_up_process()'.

 # insmod kernel/samples/ftrace/ftrace-direct.ko
 # less trace
..
          <idle>-0       [006] ..s1.   564.686958: my_direct_func: waking up rcu_preempt-17
          <idle>-0       [007] ..s1.   564.687836: my_direct_func: waking up kcompactd0-63
          <idle>-0       [006] ..s1.   564.690926: my_direct_func: waking up rcu_preempt-17
          <idle>-0       [006] ..s1.   564.696872: my_direct_func: waking up rcu_preempt-17
          <idle>-0       [007] ..s1.   565.191982: my_direct_func: waking up kcompactd0-63

Setup a function filter to the 'wake_up_process' too, and enable it.

 # cd /sys/kernel/tracing/
 # echo wake_up_process > set_ftrace_filter
 # echo function > current_tracer
 # less trace
..
          <idle>-0       [006] ..s3.   686.180972: wake_up_process <-call_timer_fn
          <idle>-0       [006] ..s3.   686.186919: wake_up_process <-call_timer_fn
          <idle>-0       [002] ..s3.   686.264049: wake_up_process <-call_timer_fn
          <idle>-0       [002] d.h6.   686.515216: wake_up_process <-kick_pool
          <idle>-0       [002] d.h6.   686.691386: wake_up_process <-kick_pool

Then, only function tracer is shown on x86.
But if you enable 'kprobe on ftrace' event (which uses SAVE_REGS flag)
on the same function, it is shown again.

 # echo 'p wake_up_process' >> dynamic_events
 # echo 1 > events/kprobes/p_wake_up_process_0/enable
 # echo > trace
 # less trace
..
          <idle>-0       [006] ..s2.  2710.345919: p_wake_up_process_0: (wake_up_process+0x4/0x20)
          <idle>-0       [006] ..s3.  2710.345923: wake_up_process <-call_timer_fn
          <idle>-0       [006] ..s1.  2710.345928: my_direct_func: waking up rcu_preempt-17
          <idle>-0       [006] ..s2.  2710.349931: p_wake_up_process_0: (wake_up_process+0x4/0x20)
          <idle>-0       [006] ..s3.  2710.349934: wake_up_process <-call_timer_fn
          <idle>-0       [006] ..s1.  2710.349937: my_direct_func: waking up rcu_preempt-17

To fix this issue, use SAVE_REGS flag for multiple ftrace_ops flag of
direct_call by default.

Fixes: 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b01ae7d36021..c060d5b47910 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5325,7 +5325,17 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
+/*
+ * If there are multiple ftrace_ops, use SAVE_REGS by default, so that direct
+ * call will be jumped from ftrace_regs_caller. Only if the architecture does
+ * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
+ * jumps from ftrace_caller for multiple ftrace_ops.
+ */
+#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
+#else
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#endif
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {


