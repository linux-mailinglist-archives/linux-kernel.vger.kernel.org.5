Return-Path: <linux-kernel+bounces-157094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9238B0CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA428B32B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D515ECDB;
	Wed, 24 Apr 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7EI9iqT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E015ECD7;
	Wed, 24 Apr 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969441; cv=none; b=QwCTQyY2S+zr+UqOwWwr3JC9nU9nTFuvqWjW90ohVEPT3ArmilWFw8kfdIn6wjyqsJMIYOiHK1uD7vmA+LaSy02lh9fhKBMpeTDnGQczWRSXO4H0dzfUJEM9m2+NNjBeZk6KkW47WaEvCwFF4f7ep4qzgxV8OJUV2vMKF859PrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969441; c=relaxed/simple;
	bh=1t/w49AxJlRcOalla//YJH6wuX5qWxc2smFyxx/3lVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBeWGzG4MmI9eZ3zi+JdNAamQx1Vz+FRemmwTVhyo2GPnHLxhppts1nnWr6FMtxqZxWRFxWg//BHn3PeRG21cPCGaRJNRX5nTqvk3hj0QVBpzN4/zm8+tHNgJSN+FOKPW3b12g++mOEY92gVIOySwvY39aMeJ8iGrxSOgUZwQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7EI9iqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74214C113CD;
	Wed, 24 Apr 2024 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969441;
	bh=1t/w49AxJlRcOalla//YJH6wuX5qWxc2smFyxx/3lVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7EI9iqTc43RSyJ1rDeBTGMjDqA38ALBoRIwlqUUz5Kkxuv5jwGTq012rLEwLKsEU
	 bhLr9n3VhJArc6x+bRFL4IL9w8GLXiijVc3L7cfR2F+xIMKESFSQ+1Ju3uDAvmAJNR
	 KI32xYZ+ctiTYyVx//ZD5zSU5BYmoFTcWG2hGx3g7vlEg+iWoD+FcuAGX99gtP+UI2
	 NtswUmH6vNu7xvqbjWtVfIDdkyfG7Fq9Fqlzzq6v9T/z8bP9lGbIokgh5DGXeAjS3k
	 LusioDgDUE4ihm9bBquT8ozDAGbU/4ORDpHMCuF+T7RAvE+cogIUNLLLl39/2K8r+K
	 1ZOhNgJojQ/JA==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] rtla/timerlat: Make user-space threads the default
Date: Wed, 24 Apr 2024 16:36:56 +0200
Message-ID: <9241d3089de4091b124f780ed832a0e6646cadaa.1713968967.git.bristot@kernel.org>
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

After ther -u addition, most of the known users are setting it. And
it makes sense, as it adds more information, and inherits the default
setup for the threads - e.g., cgroups configs.

Thus, if the user-space interface is available, enable -u. Otherwise,
use the in-kernel thread.

Add the -k option to allow the user to request kernel-threads.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_timerlat_options.rst    |  6 +++-
 tools/tracing/rtla/src/timerlat_hist.c        | 31 +++++++++++++++++--
 tools/tracing/rtla/src/timerlat_top.c         | 31 +++++++++++++++++--
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index d3255ed70195..090700a6ae9f 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -27,12 +27,16 @@
         *cyclictest* sets this value to *0* by default, use **--dma-latency** *0* to have
         similar results.
 
+**-k**, **--kernel-threads**
+
+        Use timerlat kernel-space threads, in contrast of **-u**.
+
 **-u**, **--user-threads**
 
         Set timerlat to run without a workload, and then dispatches user-space workloads
         to wait on the timerlat_fd. Once the workload is awakes, it goes to sleep again
         adding so the measurement for the kernel-to-user and user-to-kernel to the tracer
-        output.
+        output. **--user-threads** will be used unless the user specify **-k**.
 
 **-U**, **--user-load**
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index da1c353bdac9..6eb6e38d4a05 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -40,6 +40,7 @@ struct timerlat_hist_params {
 	int			no_aa;
 	int			dump_tasks;
 	int			user_workload;
+	int			kernel_workload;
 	int			user_hist;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
@@ -628,7 +629,7 @@ static void timerlat_hist_usage(char *usage)
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
 		"	  [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
@@ -664,7 +665,8 @@ static void timerlat_hist_usage(char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
-		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
+		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
+		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		NULL,
@@ -728,6 +730,7 @@ static struct timerlat_hist_params
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"user-threads",	no_argument,		0, 'u'},
+			{"kernel-threads",	no_argument,		0, 'k'},
 			{"user-load",		no_argument,		0, 'U'},
 			{"event",		required_argument,	0, 'e'},
 			{"no-irq",		no_argument,		0, '0'},
@@ -748,7 +751,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:uU0123456:7:8:9\1\2:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -831,6 +834,9 @@ static struct timerlat_hist_params
 		case 'i':
 			params->stop_us = get_llong_from_str(optarg);
 			break;
+		case 'k':
+			params->kernel_workload = 1;
+			break;
 		case 'n':
 			params->output_divisor = 1;
 			break;
@@ -942,6 +948,9 @@ static struct timerlat_hist_params
 	if (!params->stop_us && !params->stop_total_us)
 		params->no_aa = 1;
 
+	if (params->kernel_workload && params->user_workload)
+		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
+
 	return params;
 }
 
@@ -1017,6 +1026,22 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	/*
+	 * If the user did not specify a type of thread, try user-threads first.
+	 * Fall back to kernel threads otherwise.
+	 */
+	if (!params->kernel_workload && !params->user_workload) {
+		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
+		if (retval) {
+			debug_msg("User-space interface detected, setting user-threads\n");
+			params->user_workload = 1;
+			params->user_hist = 1;
+		} else {
+			debug_msg("User-space interface not detected, setting kernel-threads\n");
+			params->kernel_workload = 1;
+		}
+	}
+
 	if (params->user_hist) {
 		retval = osnoise_set_workload(tool->context, 0);
 		if (retval) {
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 410eb5174913..0acfefe151f7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -44,6 +44,7 @@ struct timerlat_top_params {
 	int			hk_cpus;
 	int			user_top;
 	int			user_workload;
+	int			kernel_workload;
 	int			pretty_output;
 	int			warmup;
 	cpu_set_t		hk_cpu_set;
@@ -445,7 +446,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u] [--warm-up s]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -474,7 +475,8 @@ static void timerlat_top_usage(char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
-		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
+		"	  -u/--user-threads: use rtla user-space threads instead of kernel-space timerlat threads",
+		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		NULL,
@@ -536,6 +538,7 @@ static struct timerlat_top_params
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"user-threads",	no_argument,		0, 'u'},
+			{"kernel-threads",	no_argument,		0, 'k'},
 			{"user-load",		no_argument,		0, 'U'},
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
@@ -550,7 +553,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:uU0:1:2:345:6:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -635,6 +638,9 @@ static struct timerlat_top_params
 		case 'i':
 			params->stop_us = get_llong_from_str(optarg);
 			break;
+		case 'k':
+			params->kernel_workload = true;
+			break;
 		case 'n':
 			params->output_divisor = 1;
 			break;
@@ -729,6 +735,9 @@ static struct timerlat_top_params
 	if (params->no_aa && params->aa_only)
 		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
 
+	if (params->kernel_workload && params->user_workload)
+		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
+
 	return params;
 }
 
@@ -807,6 +816,22 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	/*
+	 * If the user did not specify a type of thread, try user-threads first.
+	 * Fall back to kernel threads otherwise.
+	 */
+	if (!params->kernel_workload && !params->user_workload) {
+		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
+		if (retval) {
+			debug_msg("User-space interface detected, setting user-threads\n");
+			params->user_workload = 1;
+			params->user_top = 1;
+		} else {
+			debug_msg("User-space interface not detected, setting kernel-threads\n");
+			params->kernel_workload = 1;
+		}
+	}
+
 	if (params->user_top) {
 		retval = osnoise_set_workload(top->context, 0);
 		if (retval) {
-- 
2.44.0


