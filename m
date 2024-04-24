Return-Path: <linux-kernel+bounces-157092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448748B0CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADED71F21969
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EB15FCF9;
	Wed, 24 Apr 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo6rMHu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665215FA81;
	Wed, 24 Apr 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969436; cv=none; b=mAJU2AioVyNT+UmuHzcj3+IbxpU/Gn7ByG5UJ6zc3Uo5Fg9kTqOBS7b7CdnWoIkR2B+7WI757QYv7JtoSNiDbObNP23jZrdkCrRNe2LF4mOz1O0UeHwLEHLoGtc7LmCbs1l3bJfw4uBXpTvXtD21B77PNVq82PmiRByM94gXxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969436; c=relaxed/simple;
	bh=390Eo1RZGQlHBzU/2csneSc6ReZsjy7ZuswNR9do5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXONJ8NpuUgSo82npGhJ2fF8GBYzPmjPrbXV8Fs+khtrKHUJTbGLpyZlDYRyplyWD+GCAati6A8WTeaIcUw0S2KOJDpVZJk0A7O1yk/lnCNLeP0wl++JAgKFb+FRECzQt1B7kGzcohHTwwE/EyjeQsUHQ6Uh/2JHZbkxfQkTJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo6rMHu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A37C113CD;
	Wed, 24 Apr 2024 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969436;
	bh=390Eo1RZGQlHBzU/2csneSc6ReZsjy7ZuswNR9do5E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bo6rMHu0ia3/o/kv8iDRWKIQM+VLXkshYEeUa232RmMw0oPix9CQc6li9wAgRlZfG
	 JrOp5yipinSiZBBzm2iOO4O+MXt7ZVFejjcSIkKdgj/DidJ9XdXh8Y1lIraZlS/Tzt
	 4ad2nUQ6H6mPvKFvkcj/ToZseRPtaI9MdpTyGELqmxZyc7qGicsY7QuvKeuQYDfvr6
	 vqDkuwU02WTmI1XnRQKHbOoNKirgY5SkthDfASx/5YKTKiXV5MSeMC/FPtQ7VZvAqN
	 6idelyviDOD8HiP9tBF9j3dZXnYP88pN0HZuNByxw/i0eBWd+dcSwXYiMkvJ4geiP0
	 rvcG9lvG2JGIA==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] rtla/timerlat: Add a summary for hist mode
Date: Wed, 24 Apr 2024 16:36:54 +0200
Message-ID: <a6bc06c798f72127edc57d1f99da8d57e1187cee.1713968967.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713968967.git.bristot@kernel.org>
References: <cover.1713968967.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like on rtla timerlat top, add an overall summary at the bottom
of timerlat hist. For instance:

  # timerlat hist -c 0-1 -d 10s -E 20
  # RTLA timerlat histogram
  # Time unit is microseconds (us)
  # Duration:   0 00:00:10
  Index   IRQ-000   Thr-000   IRQ-001   Thr-001
  6             1         0         0         0
  7             1         0         0         0
  8             1         0         1         0
  9             7         0         0         0
  10           16         0         0         0
  11            1         0         3         0
  15            0         0         3         0
  16            0         0        12         0
  17            0         0        28         0
  18            0         2        26         0
  19            1         1        80         1
  over:      9973      9998      9848     10000
  count:    10001     10001     10001     10001
  min:          6        18         8        19
  avg:        185       204        95       113
  max:        428       450       341       371
  ALL:        IRQ       Thr
  count:    20002     20002
  min:          6        18
  avg:        140       159
  max:        428       450

Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 130 ++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 8bd51aab6513..b12c6b571dd4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -401,8 +401,135 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 	trace_seq_reset(trace->seq);
 }
 
+static void
+timerlat_print_stats_all(struct timerlat_hist_params *params,
+			 struct trace_instance *trace,
+			 struct timerlat_hist_data *data)
+{
+	struct timerlat_hist_cpu *cpu_data;
+	struct timerlat_hist_cpu sum;
+	int cpu;
+
+	if (params->no_summary)
+		return;
+
+	memset(&sum, 0, sizeof(sum));
+	sum.min_irq = ~0;
+	sum.min_thread = ~0;
+	sum.min_user = ~0;
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		cpu_data = &data->hist[cpu];
+
+		sum.irq_count += cpu_data->irq_count;
+		update_min(&sum.min_irq, &cpu_data->min_irq);
+		update_sum(&sum.sum_irq, &cpu_data->sum_irq);
+		update_max(&sum.max_irq, &cpu_data->max_irq);
+
+		sum.thread_count += cpu_data->thread_count;
+		update_min(&sum.min_thread, &cpu_data->min_thread);
+		update_sum(&sum.sum_thread, &cpu_data->sum_thread);
+		update_max(&sum.max_thread, &cpu_data->max_thread);
+
+		sum.user_count += cpu_data->user_count;
+		update_min(&sum.min_user, &cpu_data->min_user);
+		update_sum(&sum.sum_user, &cpu_data->sum_user);
+		update_max(&sum.max_user, &cpu_data->max_user);
+	}
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "ALL:  ");
+
+	if (!params->no_irq)
+		trace_seq_printf(trace->seq, "      IRQ");
+
+	if (!params->no_thread)
+		trace_seq_printf(trace->seq, "       Thr");
+
+	if (params->user_hist)
+		trace_seq_printf(trace->seq, "       Usr");
+
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "count:");
+
+	if (!params->no_irq)
+		trace_seq_printf(trace->seq, "%9d ",
+				 sum.irq_count);
+
+	if (!params->no_thread)
+		trace_seq_printf(trace->seq, "%9d ",
+				 sum.thread_count);
+
+	if (params->user_hist)
+		trace_seq_printf(trace->seq, "%9d ",
+				 sum.user_count);
+
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "min:  ");
+
+	if (!params->no_irq)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.min_irq);
+
+	if (!params->no_thread)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.min_thread);
+
+	if (params->user_hist)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.min_user);
+
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "avg:  ");
+
+	if (!params->no_irq)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.sum_irq / sum.irq_count);
+
+	if (!params->no_thread)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.sum_thread / sum.thread_count);
+
+	if (params->user_hist)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.sum_user / sum.user_count);
+
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "max:  ");
+
+	if (!params->no_irq)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.max_irq);
+
+	if (!params->no_thread)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.max_thread);
+
+	if (params->user_hist)
+		trace_seq_printf(trace->seq, "%9llu ",
+				 sum.max_user);
+
+	trace_seq_printf(trace->seq, "\n");
+	trace_seq_do_printf(trace->seq);
+	trace_seq_reset(trace->seq);
+}
+
 /*
- * timerlat_print_stats - print data for all CPUs
+ * timerlat_print_stats - print data for each CPUs
  */
 static void
 timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *tool)
@@ -485,6 +612,7 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 	trace_seq_reset(trace->seq);
 
 	timerlat_print_summary(params, trace, data);
+	timerlat_print_stats_all(params, trace, data);
 }
 
 /*
-- 
2.44.0


