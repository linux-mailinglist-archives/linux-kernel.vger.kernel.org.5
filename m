Return-Path: <linux-kernel+bounces-157090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870C8B0CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E7628AF32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14015F3F2;
	Wed, 24 Apr 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb/Nprvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B815F314;
	Wed, 24 Apr 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969432; cv=none; b=ukeZU7YCOKdgHwHMGZyX6pTDoLYFRWCaZmsYos6OlL147/RWEMc/TwZoKox0GE4qhUBySgvzHva4j5Ld6miMeEj8WbxA7KH5xFF+roldpg/RsAcdehgd8afoxsxZ4T6+bMmmeuUJX4y3Veqan+QvXhj7qc8Kq4b1vLoyVI9Y3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969432; c=relaxed/simple;
	bh=j0YRjq89mh1z9ilQ9W1YlxmSrjLRKNllnP5X8Z2EVek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6WqfMsH2P25xxc/lKKx78c59SiGvF4ULPH1UgYpNciNbybs1dfzLVrYem1Etx64V3+Wk1Z8d9FXFfqPuPLozrYQA0bJLlpMzWA2YA7H25GTtjoh00q3MYTeEg4/f4576ejcemMFWDs5s6qo2l+Xz5puBk0IiwgvXx/xZPqW7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb/Nprvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26894C113CD;
	Wed, 24 Apr 2024 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969431;
	bh=j0YRjq89mh1z9ilQ9W1YlxmSrjLRKNllnP5X8Z2EVek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cb/NprvbwxGw0UkgQem5u9klDFeieqidScTiMeDYEyTMHs4YiHTfTAUPRaQaszgvx
	 s/NQWo7A5bsWjTEr4qYdilBDBEZuL4yCG0qVqW/cjnY+wH9AR/dSpVwJp5Cl3j26rk
	 kdvP3phGObMsa4uOTf7b0axS+zYzzEjxoMJDHocgcVOW/+6UWhj1E8A93D/wVm1nnS
	 Ft4DGcepyio90rmM+PjC9WwOiM/om2FFDZwy+WwN1kLwUTbEvjxWpdmCEejnSo9uLL
	 P65qWYFctca3Dc8s1DckNs1+OkyAEanZfDq2h8gNd5mGqRBfIQIKuEZnszXCdQYQ7Y
	 6S5QwvSlYWUQQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] rtla/timerlat: Use pretty formatting only on interactive tty
Date: Wed, 24 Apr 2024 16:36:52 +0200
Message-ID: <8288e1544ceab21557d5dda93a0f00339497c649.1713968967.git.bristot@kernel.org>
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

timerlat top does some background/font color formatting. While useful
on terminal, it breaks the output on other formats. For example, when
piping the output for pastebin tools, the format strings are printed
as characters. For instance:

  [2;37;40m                                     Timer Latency                                              [0;0;0m
    0 00:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
  [2;30;47mCPU COUNT      |      cur       min       avg       max |      cur       min       avg       max[0;0;0m
    0 #1013      |        1         0         1        54 |        5         2         4        57
    1 #1013      |        3         0         1        10 |        6         2         4        15

To avoid this problem, do the formatting only if running on a tty,
and in !quiet mode.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 2665e0bb5f1e..c9cf90ed4e6d 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -44,6 +44,7 @@ struct timerlat_top_params {
 	int			hk_cpus;
 	int			user_top;
 	int			user_workload;
+	int			pretty_output;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -179,19 +180,22 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 /*
  * timerlat_top_header - print the header of the tool output
  */
-static void timerlat_top_header(struct osnoise_tool *top)
+static void timerlat_top_header(struct timerlat_top_params *params, struct osnoise_tool *top)
 {
-	struct timerlat_top_params *params = top->params;
 	struct trace_seq *s = top->trace.seq;
 	char duration[26];
 
 	get_duration(top->start_time, duration, sizeof(duration));
 
-	trace_seq_printf(s, "\033[2;37;40m");
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[2;37;40m");
+
 	trace_seq_printf(s, "                                     Timer Latency                                              ");
 	if (params->user_top)
 		trace_seq_printf(s, "                                         ");
-	trace_seq_printf(s, "\033[0;0;0m");
+
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
 	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)", duration,
@@ -204,11 +208,15 @@ static void timerlat_top_header(struct osnoise_tool *top)
 	}
 
 	trace_seq_printf(s, "\n");
-	trace_seq_printf(s, "\033[2;30;47m");
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[2;30;47m");
+
 	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
 	if (params->user_top)
 		trace_seq_printf(s, " |      cur       min       avg       max");
-	trace_seq_printf(s, "\033[0;0;0m");
+
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
 
@@ -305,7 +313,7 @@ timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *to
 	if (!params->quiet)
 		clear_terminal(trace->seq);
 
-	timerlat_top_header(top);
+	timerlat_top_header(params, top);
 
 	for (i = 0; i < nr_cpus; i++) {
 		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
@@ -693,6 +701,9 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
+	if (isatty(1) && !params->quiet)
+		params->pretty_output = 1;
+
 	return 0;
 
 out_err:
-- 
2.44.0


