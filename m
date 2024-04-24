Return-Path: <linux-kernel+bounces-157095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E048B0CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64D4B27E90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E415ECE0;
	Wed, 24 Apr 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPUDLJT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D8160885;
	Wed, 24 Apr 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969443; cv=none; b=CLWVj/A5RLL0VwZAV/95wfhOcgJgFb202YjkIDDM0TlvMmPdwJN0BjUGUaN2Qtgz9yOsq4paIBHzITq6HwvvL/pynXg0r0i6cuhfxMQa8j1Z1TWJKOUrpuYM3vAka58g9NS+9RNfkbHec+uUzKnRYbCLtCG3xxBjTDHI/CnMSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969443; c=relaxed/simple;
	bh=PW/mKN9SsKQYfJubvo/JIUYxbAIyYneBGNWi3qCcTow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwDGnFp0+MzuTB5jdvqPJkW5BHi8LjcxGIBTapNWhfJH8HVP/0gDmCM4T0SC8pNGI4zfxFMcK0wEOj5z4VAFnbOOJYhuzI/B6gb3mvSJphNDgZ8TuqXFbgJSXP8smQmV2CYjEXJXzn998wLGrsEZRD6apkLuUgHJS2D37aD8TyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPUDLJT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBF6C2BBFC;
	Wed, 24 Apr 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969443;
	bh=PW/mKN9SsKQYfJubvo/JIUYxbAIyYneBGNWi3qCcTow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPUDLJT38CANyl6uS+s1jGahVWM31z9fmKVu4lCJCA+sF8M1qXGO9ur8w+zLEaIAa
	 i4yIULeptP3FJfyp73jx7z9ysSWOSLdETgP90wMLtdZodb0jrcWwxFgH34qKu1hpy9
	 idvKtJ9XUFM7CR1qaaukFi/U/P+23VsrrZqk2dWw+sKZxXnzLrXCqdJ2C5Sb14B/Fu
	 ZUCA0ND/2hPdTkKb64ZzRBhnwrIeX2Bf0fkp0c8yw3ucvMd0YWm8Zw8NL+EMLRXqbk
	 hlcfJOWgUmjQOoRwDmW9PVe2fqxAY8yhB9GD5GxHuw9dDfPs0S2a+zk8DbkAOTJ/FP
	 R2sZda5Kiwv5w==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] rtla: Add --trace-buffer-size option
Date: Wed, 24 Apr 2024 16:36:57 +0200
Message-ID: <0281bfbd3b3fed11a0150a8645a1f9941a423c7a.1713968967.git.bristot@kernel.org>
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

Add the option allow the users to set a different buffer size for the
trace. For example, in large systems, the user might be interested on
reducing the trace buffer to avoid large tracing files.

The buffer size is specified in kB, and it is only affecting
the tracing instance.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |  3 +++
 tools/tracing/rtla/src/osnoise_hist.c       | 13 ++++++++++++-
 tools/tracing/rtla/src/osnoise_top.c        | 14 +++++++++++++-
 tools/tracing/rtla/src/timerlat_hist.c      | 14 +++++++++++++-
 tools/tracing/rtla/src/timerlat_top.c       | 14 +++++++++++++-
 tools/tracing/rtla/src/trace.c              | 15 +++++++++++++++
 tools/tracing/rtla/src/trace.h              |  1 +
 7 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index a96ea0ed662e..7ac7b7581466 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -54,6 +54,9 @@
 
         After starting the workload, let it run for *s* seconds before starting collecting the data, allowing the system to warm-up. Statistical data generated during warm-up is discarded.
 
+**--trace-buffer-size** *kB*
+        Set the per-cpu trace buffer size in kB for the tracing output.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index c6100ff46a7f..198a17a3ea2e 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -43,6 +43,7 @@ struct osnoise_hist_params {
 	int			bucket_size;
 	int			entries;
 	int			warmup;
+	int			buffer_size;
 };
 
 struct osnoise_hist_cpu {
@@ -469,6 +470,7 @@ static void osnoise_hist_usage(char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	     --warm-up: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -533,13 +535,14 @@ static struct osnoise_hist_params
 			{"trigger",		required_argument,	0, '4'},
 			{"filter",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
+			{"trace-buffer-size",	required_argument,	0, '7'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -685,6 +688,9 @@ static struct osnoise_hist_params
 		case '6':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '7':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
@@ -891,6 +897,11 @@ int osnoise_hist_main(int argc, char *argv[])
 				goto out_hist;
 		}
 
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_hist;
+		}
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 53a074c1222e..7e5aab22727d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -41,6 +41,7 @@ struct osnoise_top_params {
 	int			cgroup;
 	int			hk_cpus;
 	int			warmup;
+	int			buffer_size;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -309,6 +310,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -384,13 +386,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
 			{"warm-up",		required_argument,	0, '2'},
+			{"trace-buffer-size",	required_argument,	0, '3'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -517,6 +520,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case '2':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '3':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
 		}
@@ -725,6 +731,12 @@ int osnoise_top_main(int argc, char **argv)
 			if (retval)
 				goto out_top;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_top;
+		}
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6eb6e38d4a05..d4bab86ca1b9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -54,6 +54,7 @@ struct timerlat_hist_params {
 	int			bucket_size;
 	int			entries;
 	int			warmup;
+	int			buffer_size;
 };
 
 struct timerlat_hist_cpu {
@@ -669,6 +670,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -745,13 +747,14 @@ static struct timerlat_hist_params
 			{"no-aa",		no_argument,		0, '9'},
 			{"dump-task",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
+			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -926,6 +929,9 @@ static struct timerlat_hist_params
 		case '\2':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '\3':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -1179,6 +1185,12 @@ int timerlat_hist_main(int argc, char *argv[])
 			if (retval)
 				goto out_hist;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_hist;
+		}
 	}
 
 	if (!params->no_aa) {
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 0acfefe151f7..3a23e8d481c6 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -47,6 +47,7 @@ struct timerlat_top_params {
 	int			kernel_workload;
 	int			pretty_output;
 	int			warmup;
+	int			buffer_size;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -479,6 +480,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -547,13 +549,14 @@ static struct timerlat_top_params
 			{"dump-tasks",		no_argument,		0, '4'},
 			{"aa-only",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
+			{"trace-buffer-size",	required_argument,	0, '7'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -716,6 +719,9 @@ static struct timerlat_top_params
 		case '6':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '7':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -973,6 +979,12 @@ int timerlat_top_main(int argc, char *argv[])
 			if (retval)
 				goto out_top;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_top;
+		}
 	}
 
 	if (!params->no_aa) {
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e1ba6d9f4265..170a706248ab 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -540,3 +540,18 @@ int trace_is_off(struct trace_instance *tool, struct trace_instance *trace)
 
 	return 0;
 }
+
+/*
+ * trace_set_buffer_size - set the per-cpu tracing buffer size.
+ */
+int trace_set_buffer_size(struct trace_instance *trace, int size)
+{
+	int retval;
+
+	debug_msg("Setting trace buffer size to %d Kb\n", size);
+	retval = tracefs_instance_set_buffer_size(trace->inst, size, -1);
+	if (retval)
+		err_msg("Error setting trace buffer size\n");
+
+	return retval;
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 2e9a89a25615..c7c92dc9a18a 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -48,3 +48,4 @@ int trace_events_enable(struct trace_instance *instance,
 int trace_event_add_filter(struct trace_events *event, char *filter);
 int trace_event_add_trigger(struct trace_events *event, char *trigger);
 int trace_is_off(struct trace_instance *tool, struct trace_instance *trace);
+int trace_set_buffer_size(struct trace_instance *trace, int size);
-- 
2.44.0


