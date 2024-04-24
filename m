Return-Path: <linux-kernel+bounces-157093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E08B0CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295C31C21D19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63921160883;
	Wed, 24 Apr 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPduaNxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DD15ECCE;
	Wed, 24 Apr 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969439; cv=none; b=eKHunq+aVfMyS3AaBCinUg0+e5sS5abS6bZN7FmTFsCcBbZ64h88ob7Vjp8yn1UNxt81dXhhCG2dv6PpsPp9RZq60s5BqkCBNOBPKLMG9aS0ohwxMJsfx6ap0Ze7BkAqPOUc6R0iC4CF7FizWFZHEt/uTx6O+UvVzie1fuc3BKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969439; c=relaxed/simple;
	bh=Ir4Y2qQm8lE4tORnhv0WH6e3Vusi/T6CAiMS9Ua2YVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODYaBMcit/GQ2TorTEuA+qh85OBkZiTtBr5SUTlWAfr6HL9GoiteXv++aRbqdd1wV6bvlit84dx6MSxDaAiWD4c81SigdwDxeDzSqozxNYOYXfnzjEG/XJkXusJNQewqzfjh3I/Gj2F2gcnWFIHIeStlGTqt/YjuFfSQ5I5WMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPduaNxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD887C32783;
	Wed, 24 Apr 2024 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969439;
	bh=Ir4Y2qQm8lE4tORnhv0WH6e3Vusi/T6CAiMS9Ua2YVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPduaNxlsWw+gbO4TCsmKAxskVQ5NtL5UV2hKOCknxa9/eR+avEhyx6msHxQBB6Hp
	 RI7CEVH44EEmXa0waar4emVcTve+sGfCJoSzZhSPYJ1gHz8ika9WpbYG+7IQbxiUdS
	 nFs8drsK/rhkZ0G1yH9gq/1IX3EnTwKHJMrzAC9vFIAuDWq3yPpIOKGRrKQh0374lt
	 CjuOfPUonAVEvnDCRjWO7Kt/uJKkjlY3DykwjVBeWidGHjY86mhEp8PTO8hFpJKq6N
	 Dv+ICtJHOfJQ38+sBiKYaZ+KqLNwbo/vvQPEcSCVO6R/N00uuP4mQjc0BrSaQGJE8x
	 rPTbr1zxl6jlA==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] rtla: Add the --warm-up option
Date: Wed, 24 Apr 2024 16:36:55 +0200
Message-ID: <e682d5ce5af90f123bd13220f63d5c3d118a92be.1713968967.git.bristot@kernel.org>
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

On many cases, the results right after the startup are different
from the rest of the execution, biasing the results. For example,
on osnoise, the scheduler might take some time to adapt to the new
busy-loop workload.

Add the --warm-up <seconds> option, adding a warm-up phase (in
seconds) where the workload is set, but the results are discarded.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |  4 ++
 tools/tracing/rtla/src/osnoise_hist.c       | 30 +++++++++++--
 tools/tracing/rtla/src/osnoise_top.c        | 29 +++++++++++-
 tools/tracing/rtla/src/timerlat_hist.c      | 49 ++++++++++++++-------
 tools/tracing/rtla/src/timerlat_top.c       | 47 ++++++++++++--------
 5 files changed, 119 insertions(+), 40 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index aeb91ff3bd68..a96ea0ed662e 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -50,6 +50,10 @@
 
         Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
 
+**--warm-up** *s*
+
+        After starting the workload, let it run for *s* seconds before starting collecting the data, allowing the system to warm-up. Statistical data generated during warm-up is discarded.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 01870d50942a..c6100ff46a7f 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -36,13 +36,13 @@ struct osnoise_hist_params {
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
-
 	char			no_header;
 	char			no_summary;
 	char			no_index;
 	char			with_zeros;
 	int			bucket_size;
 	int			entries;
+	int			warmup;
 };
 
 struct osnoise_hist_cpu {
@@ -438,7 +438,7 @@ static void osnoise_hist_usage(char *usage)
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]]",
+		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]] [--warm-up]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -468,6 +468,7 @@ static void osnoise_hist_usage(char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
+		"	     --warm-up: let the workload run for s seconds before collecting data",
 		NULL,
 	};
 
@@ -531,13 +532,14 @@ static struct osnoise_hist_params
 			{"with-zeros",		no_argument,		0, '3'},
 			{"trigger",		required_argument,	0, '4'},
 			{"filter",		required_argument,	0, '5'},
+			{"warm-up",		required_argument,	0, '6'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -680,6 +682,9 @@ static struct osnoise_hist_params
 				osnoise_hist_usage("--filter requires a previous -e\n");
 			}
 			break;
+		case '6':
+			params->warmup = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
@@ -899,6 +904,25 @@ int osnoise_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
+	if (params->warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->warmup);
+		sleep(params->warmup);
+		if (stop_tracing)
+			goto out_hist;
+
+		/*
+		 * Clean up the buffer. The osnoise workload do not run
+		 * with tracing off to avoid creating a performance penalty
+		 * when not needed.
+		 */
+		retval = tracefs_instance_file_write(trace->inst, "trace", "");
+		if (retval < 0) {
+			debug_msg("Error cleaning up the buffer");
+			goto out_hist;
+		}
+
+	}
+
 	tool->start_time = time(NULL);
 	osnoise_hist_set_signals(params);
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 457360db0767..53a074c1222e 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -40,6 +40,7 @@ struct osnoise_top_params {
 	int			set_sched;
 	int			cgroup;
 	int			hk_cpus;
+	int			warmup;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -282,7 +283,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 	static const char * const msg[] = {
 		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C[=cgroup_name]]",
+		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C[=cgroup_name]] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -307,6 +308,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 		"		f:prio - use SCHED_FIFO with prio",
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
+		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		NULL,
 	};
 
@@ -381,13 +383,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"trace",		optional_argument,	0, 't'},
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
+			{"warm-up",		required_argument,	0, '2'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -511,6 +514,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "--filter requires a previous -e\n");
 			}
 			break;
+		case '2':
+			params->warmup = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
 		}
@@ -732,6 +738,25 @@ int osnoise_top_main(int argc, char **argv)
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
+	if (params->warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->warmup);
+		sleep(params->warmup);
+		if (stop_tracing)
+			goto out_top;
+
+		/*
+		 * Clean up the buffer. The osnoise workload do not run
+		 * with tracing off to avoid creating a performance penalty
+		 * when not needed.
+		 */
+		retval = tracefs_instance_file_write(trace->inst, "trace", "");
+		if (retval < 0) {
+			debug_msg("Error cleaning up the buffer");
+			goto out_top;
+		}
+
+	}
+
 	tool->start_time = time(NULL);
 	osnoise_top_set_signals(params);
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index b12c6b571dd4..da1c353bdac9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -52,6 +52,7 @@ struct timerlat_hist_params {
 	char			with_zeros;
 	int			bucket_size;
 	int			entries;
+	int			warmup;
 };
 
 struct timerlat_hist_cpu {
@@ -628,6 +629,7 @@ static void timerlat_hist_usage(char *usage)
 		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u]",
+		"	  [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -664,6 +666,7 @@ static void timerlat_hist_usage(char *usage)
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
+		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		NULL,
 	};
 
@@ -738,13 +741,14 @@ static struct timerlat_hist_params
 			{"dma-latency",		required_argument,	0, '8'},
 			{"no-aa",		no_argument,		0, '9'},
 			{"dump-task",		no_argument,		0, '\1'},
+			{"warm-up",		required_argument,	0, '\2'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:uU0123456:7:8:9\1",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:uU0123456:7:8:9\1\2:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -913,6 +917,9 @@ static struct timerlat_hist_params
 		case '\1':
 			params->dump_tasks = 1;
 			break;
+		case '\2':
+			params->warmup = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -1167,22 +1174,6 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	/*
-	 * Start the tracers here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (params->trace_output)
-		trace_instance_start(&record->trace);
-	if (!params->no_aa)
-		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
-
-	tool->start_time = time(NULL);
-	timerlat_hist_set_signals(params);
-
 	if (params->user_workload) {
 		/* rtla asked to stop */
 		params_u.should_run = 1;
@@ -1202,6 +1193,29 @@ int timerlat_hist_main(int argc, char *argv[])
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
+	if (params->warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->warmup);
+		sleep(params->warmup);
+		if (stop_tracing)
+			goto out_hist;
+	}
+
+	/*
+	 * Start the tracers here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
+		trace_instance_start(&record->trace);
+	if (!params->no_aa)
+		trace_instance_start(&aa->trace);
+	trace_instance_start(trace);
+
+	tool->start_time = time(NULL);
+	timerlat_hist_set_signals(params);
+
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
@@ -1227,6 +1241,7 @@ int timerlat_hist_main(int argc, char *argv[])
 			}
 		}
 	}
+
 	if (params->user_workload && !params_u.stopped_running) {
 		params_u.should_run = 0;
 		sleep(1);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index bdcf8ef8f815..410eb5174913 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -45,6 +45,7 @@ struct timerlat_top_params {
 	int			user_top;
 	int			user_workload;
 	int			pretty_output;
+	int			warmup;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -444,7 +445,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u]",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -475,6 +476,7 @@ static void timerlat_top_usage(char *usage)
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
+		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		NULL,
 	};
 
@@ -541,13 +543,14 @@ static struct timerlat_top_params
 			{"no-aa",		no_argument,		0, '3'},
 			{"dump-tasks",		no_argument,		0, '4'},
 			{"aa-only",		required_argument,	0, '5'},
+			{"warm-up",		required_argument,	0, '6'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:uU0:1:2:345:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:uU0:1:2:345:6:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -704,6 +707,9 @@ static struct timerlat_top_params
 		case '4':
 			params->dump_tasks = 1;
 			break;
+		case '6':
+			params->warmup = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -971,22 +977,6 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	/*
-	 * Start the tracers here, after having set all instances.
-	 *
-	 * Let the trace instance start first for the case of hitting a stop
-	 * tracing while enabling other instances. The trace instance is the
-	 * one with most valuable information.
-	 */
-	if (params->trace_output)
-		trace_instance_start(&record->trace);
-	if (!params->no_aa && aa != top)
-		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
-
-	top->start_time = time(NULL);
-	timerlat_top_set_signals(params);
-
 	if (params->user_workload) {
 		/* rtla asked to stop */
 		params_u.should_run = 1;
@@ -1006,6 +996,27 @@ int timerlat_top_main(int argc, char *argv[])
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
+	if (params->warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->warmup);
+		sleep(params->warmup);
+	}
+
+	/*
+	 * Start the tracers here, after having set all instances.
+	 *
+	 * Let the trace instance start first for the case of hitting a stop
+	 * tracing while enabling other instances. The trace instance is the
+	 * one with most valuable information.
+	 */
+	if (params->trace_output)
+		trace_instance_start(&record->trace);
+	if (!params->no_aa && aa != top)
+		trace_instance_start(&aa->trace);
+	trace_instance_start(trace);
+
+	top->start_time = time(NULL);
+	timerlat_top_set_signals(params);
+
 	while (!stop_tracing) {
 		sleep(params->sleep_time);
 
-- 
2.44.0


