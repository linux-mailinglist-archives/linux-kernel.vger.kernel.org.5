Return-Path: <linux-kernel+bounces-59214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A147C84F34D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A5C1F2219B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7869DF4;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9369D3C;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474140; cv=none; b=anvjGL+qW7YNgJkXFIchYY5cDIyCMxUejtRqiGgAu5UbIZP3Pn3b6LqT9S7Rb08Lk7YoEZp07Etke8andrpNhaTQe7VFwjjvMEuN44WFZgtFmGokFcAWg2TGpCS5qVntTq1gz5fVRphVW2J+Bo4PgD4oUOzOnKiAk28L+0s4zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474140; c=relaxed/simple;
	bh=gcrpK3JCHbvy8Q1untTYfCckW8ZGxPgkiJAX+Ww1Dl4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oGtE8IT3Xe+eI3SGiicL7N+vMD/myAvOgNGz8w2D8yyR4DYZjGY1eWxbripRV/swrZ0EDdvvfvvxO+XE/7UtmYJqDQBgTnw/caV1YSezxzp2MasXFrUDZC1Rh5ONWPFTgxAzimF2YADZA6xvkm37RA5PkS32GUazy+WYtJ16W8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CB0C433A6;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rYO23-00000006pwX-1qXh;
	Fri, 09 Feb 2024 05:22:55 -0500
Message-ID: <20240209102255.301135077@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 09 Feb 2024 05:22:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Florent Revest <revest@chromium.org>,
 Jiri Olsa <jolsa@kernel.org>
Subject: [for-linus][PATCH 1/2] ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
References: <20240209102220.255052617@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

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

Link: https://lore.kernel.org/linux-trace-kernel/170484558617.178953.1590516949390270842.stgit@devnote2

Fixes: 60c8971899f3 ("ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS")
Cc: stable@vger.kernel.org
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 ++++++++++
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
-- 
2.43.0



