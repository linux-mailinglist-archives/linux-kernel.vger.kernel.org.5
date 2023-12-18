Return-Path: <linux-kernel+bounces-3674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F3816F66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1405287E05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605D1297E5;
	Mon, 18 Dec 2023 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGgrunfm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C441297CA;
	Mon, 18 Dec 2023 12:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D53C433C9;
	Mon, 18 Dec 2023 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903654;
	bh=IabCCm4KKZwo8d/aJFphk+xg2Z10Z8zjdAJ3kO6qi1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGgrunfm8JziqldMwrf7ECuo/T6H9Myz3jzUuVH+ZmOn0YuXaX5KNvjfny0J1t1zc
	 TpRT/2x8k6KZpOrCNkI3UHhS/bhLsDMgn8D2SuWPH0PwggvShoFVA8Hb5zk6teuQ5W
	 YwPmT8Rc3/28fwu7aiOOKNVnaVO+UnvgMgsJGw/CNindGvqIIgYOdSsKP4ubeoIrBy
	 IsaC5K+wsdfgYh+67RiC6nWS/xP6Yart34zrqJ/jUZMX+ugQtz425l0Lg4PzmkdzoW
	 YnSDQy0Jkk6mdI2+rbXY4DflKQT6cAqk4NbkJZM9d7PElF7ki8dGcLNljc4MMoqoPS
	 1hwWQgbuDsyMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/6] tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
Date: Mon, 18 Dec 2023 07:47:21 -0500
Message-ID: <20231218124725.1382738-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124725.1382738-1-sashal@kernel.org>
References: <20231218124725.1382738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.333
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
index c5fe020336bea..755d6146c738c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3826,7 +3826,11 @@ static int s_show(struct seq_file *m, void *v)
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


