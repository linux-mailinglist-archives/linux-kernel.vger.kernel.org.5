Return-Path: <linux-kernel+bounces-3629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09679816EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28261F21EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA595D759;
	Mon, 18 Dec 2023 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN+2IGCE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38E5D73C;
	Mon, 18 Dec 2023 12:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36411C433C9;
	Mon, 18 Dec 2023 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903532;
	bh=uvqxq9ivRICZK7D93QOfg+Z9GhD5LpEsFUd7tOOgJhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JN+2IGCEMpcCg9B+gVq9YbgmW9+LOcuvYzGOlqhJXgPFBDXWY36J3MWt3Coq2gibB
	 qslou2GodNp/qeKtgxHgdxp3/ojTs0fiWtFF/bsHltx4gcYlQBcYBHWmdT/4XNT9jC
	 Y0sjOhT688t0mT3+5N5Jn8kZ6cujWDN7DxqTqbTXd29ZMRMJgg9Yh7OohJFKc+mnfW
	 ioo9zCiP95U4pNUzqoPPNLzuNzdZt21VhLdo4Yyg2fQYtWEF1TshphCO7Pj0ri2gs4
	 hayUNqOOnhShii30ewb4H/OhoLDW6UGhxCx9B9YSOVjMhvbi7FqfdQxHBu4WMvC4nO
	 knGkrG6/ACr8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/15] tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
Date: Mon, 18 Dec 2023 07:44:57 -0500
Message-ID: <20231218124513.1380056-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124513.1380056-1-sashal@kernel.org>
References: <20231218124513.1380056-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.68
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit b55b0a0d7c4aa2dac3579aa7e6802d1f57445096 ]

If a large event was added to the ring buffer that is larger than what the
trace_seq can handle, it just drops the output:

 ~# cat /sys/kernel/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-859     [001] .....   141.118951: tracing_mark_write           <...>-859     [001] .....   141.148201: tracing_mark_write: 78901234

Instead, catch this case and add some context:

 ~# cat /sys/kernel/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
            <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234

This now emulates the same output as trace_pipe.

Link: https://lore.kernel.org/linux-trace-kernel/20231209171058.78c1a026@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d2db4d6f0f2fd..cfab12e266d98 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4665,7 +4665,11 @@ static int s_show(struct seq_file *m, void *v)
 		iter->leftover = ret;
 
 	} else {
-		print_trace_line(iter);
+		ret = print_trace_line(iter);
+		if (ret == TRACE_TYPE_PARTIAL_LINE) {
+			iter->seq.full = 0;
+			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+		}
 		ret = trace_print_seq(m, &iter->seq);
 		/*
 		 * If we overflow the seq_file buffer, then it will
-- 
2.43.0


