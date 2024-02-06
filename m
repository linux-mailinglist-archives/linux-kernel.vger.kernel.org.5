Return-Path: <linux-kernel+bounces-55117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2884B7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8BB254A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008B132C2F;
	Tue,  6 Feb 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrgkvPOK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6A1E863;
	Tue,  6 Feb 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229934; cv=none; b=b9A+2PhXVSUSRNKD3NF3PtwxUbvjNpF6OLfxplRDhBiAt+BE6Rj7rNN4MLMZiAQjGeEspFT+HFerSUwKN2hrVpfytMUma6hIvIIW8z1BFVOhyvstheGutEUi/s0VZyuHlQUHbCRWafCwexDesIXj8SeBO6UzFoxnauFW19VYhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229934; c=relaxed/simple;
	bh=DLi2cOTGGXpfM3d/08BWeixnAJkYrReaaZAoFL/71Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9kbZ9gT/NQqQKV308TsLk3VxvdB7xkSsxYKjucv7gmD6+zAnBXkd4My3YHePM4gHeangsG4dja2A0ogR1t4f5nM5sbRrZPtzlrXRJOzuOc7A1lrinXR4sjTAraJS1wr3QzKQ3hd1ooRqppkCJ447c/6gX8eK/i6e41aZY4zluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrgkvPOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1A5C43394;
	Tue,  6 Feb 2024 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229933;
	bh=DLi2cOTGGXpfM3d/08BWeixnAJkYrReaaZAoFL/71Uo=;
	h=From:To:Cc:Subject:Date:From;
	b=OrgkvPOKWzqWCtl7Wj71boguffvHhphHxRM7PSBmpA84vqRe6DdR8f5wd7/Xt6J9e
	 LoETTbu0bGm24MZU1dq701pTTSaGks54u6sJoUTRsoS2PONW8OstGNYnulkjQpbGov
	 Hl4ojrb/+rO9Jh/2isJ+fyeRlo4mrRGkvL6X54HA13B9AoC4wXTO39/qm3A8uR5vo2
	 L0qO6v9RZZEDdblrjak8mI1EYlYTOwa9rN5GqFJ6vwyyuiVIWwtqdwYTXGFFCotiaQ
	 eCXQJyCrBnO4b8oRM1ZVMd8l4q1J3l6t5cVwOn8hSSpTMDtlOTvlIXIABvkweZapjQ
	 EvIxFhg2bG/dw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/rtla: Add -U/--user-load option to timerlat
Date: Tue,  6 Feb 2024 15:32:06 +0100
Message-ID: <36e6bcf18fe15c7601048fd4c65aeb193c502cc8.1707229706.git.bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timerlat tracer provides an interface for any application to wait
for the timerlat's periodic wakeup. Currently, rtla timerlat uses it
to dispatch its user-space workload (-u option).

But as the tracer interface is generic, rtla timerlat can also be used
to monitor any workload that uses it. For example, a user might
place their own workload to wait on the tracer interface, and
monitor the results with rtla timerlat.

Add the -U option to rtla timerlat top and hist. With this option, rtla
timerlat will not dispatch its workload but only setting up the
system, waiting for a user to dispatch its workload.

The sample code in this patch is an example of python application
that loops in the timerlat tracer fd.

To use it, dispatch:

 # rtla timerlat -U

In a terminal, then run the python program on another terminal,
specifying the CPU to run it. For example, setting on CPU 1:

 #./timerlat_load.py 1

Then rtla timerlat will start printing the statistics of the
/timerlat_load.py app.

An interesting point is that the "Ret user Timer Latency" value
is the overall response time of the load. The sample load does
a memory copy to exemplify that.

The stop tracing options on rtla timerlat works in this setup
as well, including auto analysis.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_timerlat_options.rst    |  6 ++
 tools/tracing/rtla/sample/timerlat_load.py    | 74 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_hist.c        | 16 ++--
 tools/tracing/rtla/src/timerlat_top.c         | 14 +++-
 4 files changed, 101 insertions(+), 9 deletions(-)
 create mode 100644 tools/tracing/rtla/sample/timerlat_load.py

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 88506b397c2d..d3255ed70195 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -33,3 +33,9 @@
         to wait on the timerlat_fd. Once the workload is awakes, it goes to sleep again
         adding so the measurement for the kernel-to-user and user-to-kernel to the tracer
         output.
+
+**-U**, **--user-load**
+
+        Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
+        task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
+        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
new file mode 100644
index 000000000000..8cc5eb2d2e69
--- /dev/null
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -0,0 +1,74 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2024 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# This is a sample code about how to use timerlat's timer by any workload
+# so rtla can measure and provide auto-analysis for the overall latency (IOW
+# the response time) for a task.
+#
+# Before running it, you need to dispatch timerlat with -U option in a terminal.
+# Then # run this script pinned to a CPU on another terminal. For example:
+#
+# timerlat_load.py 1 -p 95
+#
+# The "Timerlat IRQ" is the IRQ latency, The thread latency is the latency
+# for the python process to get the CPU. The Ret from user Timer Latency is
+# the overall latency. In other words, it is the response time for that
+# activation.
+#
+# This is just an example, the load is reading 20MB of data from /dev/full
+# It is in python because it is easy to read :-)
+
+import argparse
+import sys
+import os
+
+parser = argparse.ArgumentParser(description='user-space timerlat thread in Python')
+parser.add_argument("cpu", help='CPU to run timerlat thread')
+parser.add_argument("-p", "--prio", help='FIFO priority')
+
+args = parser.parse_args()
+
+try:
+    affinity_mask = { int(args.cpu) }
+except:
+    print("Invalid cpu: " + args.cpu)
+    exit(1)
+
+try:
+    os.sched_setaffinity(0, affinity_mask);
+except:
+    print("Error setting affinity")
+    exit(1)
+
+if (args.prio):
+    try:
+        param = os.sched_param(int(args.prio))
+        os.sched_setscheduler(0, os.SCHED_FIFO, param)
+    except:
+        print("Error setting priority")
+        exit(1)
+
+try:
+    timerlat_path = "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu + "/timerlat_fd"
+    timerlat_fd = open(timerlat_path, 'r')
+except:
+    print("Error opening timerlat fd, did you run timerlat -U?")
+    exit(1)
+
+try:
+    data_fd = open("/dev/full", 'r');
+except:
+    print("Error opening data fd")
+
+while True:
+    try:
+        timerlat_fd.read(1)
+        data_fd.read(20*1024*1024)
+    except:
+        print("Leaving")
+        break
+
+timerlat_fd.close()
+data_fd.close()
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 3a5b8c409e7d..a668bf52e78e 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -39,6 +39,7 @@ struct timerlat_hist_params {
 	int			hk_cpus;
 	int			no_aa;
 	int			dump_tasks;
+	int			user_workload;
 	int			user_hist;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
@@ -534,6 +535,7 @@ static void timerlat_hist_usage(char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
+		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		NULL,
 	};
 
@@ -591,6 +593,7 @@ static struct timerlat_hist_params
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"user-threads",	no_argument,		0, 'u'},
+			{"user-load",		no_argument,		0, 'U'},
 			{"event",		required_argument,	0, 'e'},
 			{"no-irq",		no_argument,		0, '0'},
 			{"no-thread",		no_argument,		0, '1'},
@@ -609,7 +612,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:u0123456:7:8:9\1",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:np:P:s:t::T:uU0123456:7:8:9\1",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -720,6 +723,9 @@ static struct timerlat_hist_params
 				params->trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
+			params->user_workload = 1;
+			/* fallback: -u implies in -U */
+		case 'U':
 			params->user_hist = 1;
 			break;
 		case '0': /* no irq */
@@ -981,7 +987,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->cgroup && !params->user_hist) {
+	if (params->cgroup && !params->user_workload) {
 		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
@@ -1045,7 +1051,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
 
-	if (params->user_hist) {
+	if (params->user_workload) {
 		/* rtla asked to stop */
 		params_u.should_run = 1;
 		/* all threads left */
@@ -1082,14 +1088,14 @@ int timerlat_hist_main(int argc, char *argv[])
 			break;
 
 		/* is there still any user-threads ? */
-		if (params->user_hist) {
+		if (params->user_workload) {
 			if (params_u.stopped_running) {
 				debug_msg("timerlat user-space threads stopped!\n");
 				break;
 			}
 		}
 	}
-	if (params->user_hist && !params_u.stopped_running) {
+	if (params->user_workload && !params_u.stopped_running) {
 		params_u.should_run = 0;
 		sleep(1);
 	}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1640f121baca..6af47f21a1a3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -43,6 +43,7 @@ struct timerlat_top_params {
 	int			cgroup;
 	int			hk_cpus;
 	int			user_top;
+	int			user_workload;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -364,6 +365,7 @@ static void timerlat_top_usage(char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	  -u/--user-threads: use rtla user-space threads instead of in-kernel timerlat threads",
+		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		NULL,
 	};
 
@@ -419,6 +421,7 @@ static struct timerlat_top_params
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"user-threads",	no_argument,		0, 'u'},
+			{"user-load",		no_argument,		0, 'U'},
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
 			{"dma-latency",		required_argument,	0, '2'},
@@ -431,7 +434,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:u0:1:2:345:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:np:P:qs:t::T:uU0:1:2:345:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -548,6 +551,9 @@ static struct timerlat_top_params
 
 			break;
 		case 'u':
+			params->user_workload = true;
+			/* fallback: -u implies -U */
+		case 'U':
 			params->user_top = true;
 			break;
 		case '0': /* trigger */
@@ -865,7 +871,7 @@ int timerlat_top_main(int argc, char *argv[])
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
-	if (params->user_top) {
+	if (params->user_workload) {
 		/* rtla asked to stop */
 		params_u.should_run = 1;
 		/* all threads left */
@@ -908,7 +914,7 @@ int timerlat_top_main(int argc, char *argv[])
 			break;
 
 		/* is there still any user-threads ? */
-		if (params->user_top) {
+		if (params->user_workload) {
 			if (params_u.stopped_running) {
 				debug_msg("timerlat user space threads stopped!\n");
 				break;
@@ -916,7 +922,7 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->user_top && !params_u.stopped_running) {
+	if (params->user_workload && !params_u.stopped_running) {
 		params_u.should_run = 0;
 		sleep(1);
 	}
-- 
2.43.0


