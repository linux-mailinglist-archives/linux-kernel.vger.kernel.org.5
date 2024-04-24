Return-Path: <linux-kernel+bounces-157091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5C8B0CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A671F21A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E315FA7D;
	Wed, 24 Apr 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLl61lUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE515F40B;
	Wed, 24 Apr 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969434; cv=none; b=nnWb265tr+nVN1H7n9JKrXgJXwu3a+N2zI7rWTonn7J9YtfZnSK5AFSy75qif29rFAkJjLdp01q5j/6qotHVwGq8gPI3uMofvCD8MAgnBcTAPCBVFzMnbm4Sq7zt6DMBJdKNuC6YdwnC2fFbDKTqcOa1wNH5+IkjT9gDn4e4Q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969434; c=relaxed/simple;
	bh=FeU1sJCZO1dwqnocdJMj/19AzVWP8TaVqxh+hJvWmD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF8cDndhoF2cw546LcnqIXkay20SAz68+EhUVCzUX5sg+n4EACICsUPwkgUsmKlPZJbMJncRGNxsemm3wyR+yO40zZX6vccXRdFqWKkGaIbH6+d0K7R2myK0ifHgOl4E4ZLyJs/5PfYVwUxj0ffJfIaRVY6iyn0z5HvTWt1JlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLl61lUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F1C2BBFC;
	Wed, 24 Apr 2024 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969434;
	bh=FeU1sJCZO1dwqnocdJMj/19AzVWP8TaVqxh+hJvWmD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLl61lUGilcDIJD5fbAQdUjX/n3ICrHAXqsw8YwYLiiyJQgf23JdKA038F7Hm6/8f
	 hzQdr/aM9TYTfiX48zG5XorVt3XPvCA5sKRgLO4dC5ddadqi2C1e+0QnkLqUDDa0PD
	 ccIXc2MgOLHEkUuWAJXqKHyKsHLrwNXJyppjKJqSPGz0nv6yYlw55+Khk/7jhi1RDW
	 D0SR9sghO+wtbsfftyiW8a/NzcGAGCLMs1MiNKFQ9zUjqRZIemAXWUHt+eCOe1MYdn
	 NXDE0agvyt9Q30e0ZCzFR+XHeL3Oh0ScazUT1aq/Rin7bDtQtCHUjXrl1DE4DlQRjT
	 +im/XuqJwQpyQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] rtla/timerlat: Add a summary for top mode
Date: Wed, 24 Apr 2024 16:36:53 +0200
Message-ID: <5eb510d6faeb4ce745e09395196752df75a2dd1a.1713968967.git.bristot@kernel.org>
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

While the per-cpu values are the results to take into consideration, the
overall system values are also useful.

Add a summary at the bottom of rtla timerlat top showing the overall
results. For instance:

                                       Timer Latency
    0 00:00:10   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
  CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
    0 #10003     |      113        19       150       441 |      134        35       170       459
    1 #10003     |       63         8        99       462 |       84        15       119       481
    2 #10003     |        3         2        89       396 |       21         8       108       414
    3 #10002     |      206        11       210       394 |      223        21       228       415
  ---------------|----------------------------------------|---------------------------------------
  ALL #40011  e0 |                  2       137       462 |                  8       156       481

Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 108 ++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index c9cf90ed4e6d..bdcf8ef8f815 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -119,6 +119,37 @@ static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
 	return NULL;
 }
 
+static void
+timerlat_top_reset_sum(struct timerlat_top_cpu *summary)
+{
+	memset(summary, 0, sizeof(*summary));
+	summary->min_irq = ~0;
+	summary->min_thread = ~0;
+	summary->min_user = ~0;
+}
+
+static void
+timerlat_top_update_sum(struct osnoise_tool *tool, int cpu, struct timerlat_top_cpu *sum)
+{
+	struct timerlat_top_data *data = tool->data;
+	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
+
+	sum->irq_count += cpu_data->irq_count;
+	update_min(&sum->min_irq, &cpu_data->min_irq);
+	update_sum(&sum->sum_irq, &cpu_data->sum_irq);
+	update_max(&sum->max_irq, &cpu_data->max_irq);
+
+	sum->thread_count += cpu_data->thread_count;
+	update_min(&sum->min_thread, &cpu_data->min_thread);
+	update_sum(&sum->sum_thread, &cpu_data->sum_thread);
+	update_max(&sum->max_thread, &cpu_data->max_thread);
+
+	sum->user_count += cpu_data->user_count;
+	update_min(&sum->min_user, &cpu_data->min_user);
+	update_sum(&sum->sum_user, &cpu_data->sum_user);
+	update_max(&sum->max_user, &cpu_data->max_user);
+}
+
 /*
  * timerlat_hist_update - record a new timerlat occurent on cpu, updating data
  */
@@ -285,6 +316,77 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	}
 }
 
+/*
+ * timerlat_top_print_sum - prints the summary output
+ */
+static void
+timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summary)
+{
+	const char *split = "----------------------------------------";
+	struct timerlat_top_params *params = top->params;
+	unsigned long long count = summary->irq_count;
+	int divisor = params->output_divisor;
+	struct trace_seq *s = top->trace.seq;
+	int e = 0;
+
+	if (divisor == 0)
+		return;
+
+	/*
+	 * Skip if no data is available: is this cpu offline?
+	 */
+	if (!summary->irq_count && !summary->thread_count)
+		return;
+
+	while (count > 999999) {
+		e++;
+		count /= 10;
+	}
+
+	trace_seq_printf(s, "%.*s|%.*s|%.*s", 15, split, 40, split, 39, split);
+	if (params->user_top)
+		trace_seq_printf(s, "-|%.*s", 39, split);
+	trace_seq_printf(s, "\n");
+
+	trace_seq_printf(s, "ALL #%-6llu e%d |", count, e);
+
+	if (!summary->irq_count) {
+		trace_seq_printf(s, "          %s %s %s |", no_value, no_value, no_value);
+	} else {
+		trace_seq_printf(s, "          ");
+		trace_seq_printf(s, "%9llu ", summary->min_irq / params->output_divisor);
+		trace_seq_printf(s, "%9llu ", (summary->sum_irq / summary->irq_count) / divisor);
+		trace_seq_printf(s, "%9llu |", summary->max_irq / divisor);
+	}
+
+	if (!summary->thread_count) {
+		trace_seq_printf(s, "%s %s %s %s", no_value, no_value, no_value, no_value);
+	} else {
+		trace_seq_printf(s, "          ");
+		trace_seq_printf(s, "%9llu ", summary->min_thread / divisor);
+		trace_seq_printf(s, "%9llu ",
+				(summary->sum_thread / summary->thread_count) / divisor);
+		trace_seq_printf(s, "%9llu", summary->max_thread / divisor);
+	}
+
+	if (!params->user_top) {
+		trace_seq_printf(s, "\n");
+		return;
+	}
+
+	trace_seq_printf(s, " |");
+
+	if (!summary->user_count) {
+		trace_seq_printf(s, "          %s %s %s |", no_value, no_value, no_value);
+	} else {
+		trace_seq_printf(s, "          ");
+		trace_seq_printf(s, "%9llu ", summary->min_user / divisor);
+		trace_seq_printf(s, "%9llu ",
+				(summary->sum_user / summary->user_count) / divisor);
+		trace_seq_printf(s, "%9llu\n", summary->max_user / divisor);
+	}
+}
+
 /*
  * clear_terminal - clears the output terminal
  */
@@ -301,6 +403,7 @@ static void
 timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *top)
 {
 	struct trace_instance *trace = &top->trace;
+	struct timerlat_top_cpu summary;
 	static int nr_cpus = -1;
 	int i;
 
@@ -313,14 +416,19 @@ timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *to
 	if (!params->quiet)
 		clear_terminal(trace->seq);
 
+	timerlat_top_reset_sum(&summary);
+
 	timerlat_top_header(params, top);
 
 	for (i = 0; i < nr_cpus; i++) {
 		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
 			continue;
 		timerlat_top_print(top, i);
+		timerlat_top_update_sum(top, i, &summary);
 	}
 
+	timerlat_top_print_sum(top, &summary);
+
 	trace_seq_do_printf(trace->seq);
 	trace_seq_reset(trace->seq);
 }
-- 
2.44.0


