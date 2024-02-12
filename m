Return-Path: <linux-kernel+bounces-62448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C198520D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F25B2396B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD304D12D;
	Mon, 12 Feb 2024 22:00:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDE4CDE5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775225; cv=none; b=aurLkW56GZ7Zw+vyPgpCrhwrhhigamJwXC/16uiHSk5GBDsDS6T9+EFL4PVLWMn2bp4ntrdISNFHdh7IwvaIN2+MvxLGLdjU43lRFlBoER8Gygf3bqImIa3ghmzkLMHx2X8o4M85xy7SBQMNIx0kinLdJvrt+qXgC5FtP9eX7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775225; c=relaxed/simple;
	bh=ooTB2I6b7Z7IEefQMC00P9YKHefeksN14fi7O6leJDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iWr2PDtDycUVydC8X0p5E0d/Bu8HA9YRdO7VtwhdgB8NjPDNgnurTdFUYTI6viqqAgwHSVuXtKsDwKPid4EtpQmBQBxUmnAZMHY+ItaJ815oJ7yqBlR59A/kjHzTx7YsQAIoTazwvkgLsa1qkMJNpekhvYVQlH8yt0HcXhubDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33731C433F1;
	Mon, 12 Feb 2024 22:00:24 +0000 (UTC)
Date: Mon, 12 Feb 2024 17:01:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, John Kacur
 <jkacur@redhat.com>, limingming3 <limingming890315@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] tracing/tooling: Fixes for v6.8-rc4
Message-ID: <20240212170107.60da326a@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Tracing tooling updates for 6.8-rc4:

RTLA:
        - rtla tools are exiting with a positive value when usage()
          is called. Make them return 0 if the usage was called via
          -h/--help.

        - the -P priority sets the sched priority for rtla workload.
          When the SCHED_OTHER scheduler is selected, it sets
          the rt_priority instead of the nice parameter. Setting
          the nice value is the correct thing, so fix it.

        - rtla is failing to compile with clang due to unsupported
          options from gcc. Adjusting the compiler/linker options
          makes clang work properly.

        - Remove the sched_getattr() unused function on utils.c.

        - Fixes on variable initialization and size, reported by
          clang.

Verification:
        - rv is failing to compile with clang due to unsupported
          options from gcc. Adjusting the compiler/linker options
          makes clang work properly.

        - Fix an uninitialized variable on in_kernel.c reported by
          clang.


Please pull the latest trace-tools-v6.8-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.8-rc4

Tag SHA1: 43f245e8613c3a071441ab907842c1b9b7812ee1
Head SHA1: b5f319360371087d52070d8f3fc7789e80ce69a6


Daniel Bristot de Oliveira (6):
      tools/rtla: Fix Makefile compiler options for clang
      tools/rtla: Fix uninitialized bucket/data->bucket_size warning
      tools/rtla: Fix clang warning about mount_point var size
      tools/rtla: Remove unused sched_getattr() function
      tools/rv: Fix Makefile compiler options for clang
      tools/rv: Fix curr_reactor uninitialized variable

John Kacur (1):
      tools/rtla: Exit with EXIT_SUCCESS when help is invoked

limingming3 (1):
      tools/rtla: Replace setting prio with nice for SCHED_OTHER

----
 tools/tracing/rtla/Makefile            |  7 ++++++-
 tools/tracing/rtla/src/osnoise_hist.c  |  9 ++++++---
 tools/tracing/rtla/src/osnoise_top.c   |  6 +++++-
 tools/tracing/rtla/src/timerlat_hist.c |  9 ++++++---
 tools/tracing/rtla/src/timerlat_top.c  |  6 +++++-
 tools/tracing/rtla/src/utils.c         | 14 ++++----------
 tools/tracing/rtla/src/utils.h         |  2 ++
 tools/verification/rv/Makefile         |  7 ++++++-
 tools/verification/rv/src/in_kernel.c  |  2 +-
 9 files changed, 41 insertions(+), 21 deletions(-)
---------------------------
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2456a399eb9a..afd18c678ff5 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -28,10 +28,15 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
 
+ifeq ($(CC),clang)
+  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
+  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
 CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
-LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8f81fa007364..01870d50942a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -135,8 +135,7 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 	if (params->output_divisor)
 		duration = duration / params->output_divisor;
 
-	if (data->bucket_size)
-		bucket = duration / data->bucket_size;
+	bucket = duration / data->bucket_size;
 
 	total_duration = duration * count;
 
@@ -480,7 +479,11 @@ static void osnoise_hist_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f7c959be8677..457360db0767 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -331,7 +331,11 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 47d3d8b53cb2..dbf154082f95 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -178,8 +178,7 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 	if (params->output_divisor)
 		latency = latency / params->output_divisor;
 
-	if (data->bucket_size)
-		bucket = latency / data->bucket_size;
+	bucket = latency / data->bucket_size;
 
 	if (!context) {
 		hist = data->hist[cpu].irq;
@@ -546,7 +545,11 @@ static void timerlat_hist_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1640f121baca..3e9af2c38688 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -375,7 +375,11 @@ static void timerlat_top_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index c769d7b3842c..9ac71a66840c 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -238,12 +238,6 @@ static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
 
-static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
-				unsigned int size, unsigned int flags)
-{
-	return syscall(__NR_sched_getattr, pid, attr, size, flags);
-}
-
 int __set_sched_attr(int pid, struct sched_attr *attr)
 {
 	int flags = 0;
@@ -479,13 +473,13 @@ int parse_prio(char *arg, struct sched_attr *sched_param)
 		if (prio == INVALID_VAL)
 			return -1;
 
-		if (prio < sched_get_priority_min(SCHED_OTHER))
+		if (prio < MIN_NICE)
 			return -1;
-		if (prio > sched_get_priority_max(SCHED_OTHER))
+		if (prio > MAX_NICE)
 			return -1;
 
 		sched_param->sched_policy   = SCHED_OTHER;
-		sched_param->sched_priority = prio;
+		sched_param->sched_nice = prio;
 		break;
 	default:
 		return -1;
@@ -536,7 +530,7 @@ int set_cpu_dma_latency(int32_t latency)
  */
 static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
-	char mount_point[MAX_PATH];
+	char mount_point[MAX_PATH+1];
 	char type[100];
 	int found = 0;
 	FILE *fp;
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 04ed1e650495..d44513e6c66a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -9,6 +9,8 @@
  */
 #define BUFF_U64_STR_SIZE	24
 #define MAX_PATH		1024
+#define MAX_NICE		20
+#define MIN_NICE		-19
 
 #define container_of(ptr, type, member)({			\
 	const typeof(((type *)0)->member) *__mptr = (ptr);	\
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 3d0f3888a58c..485f8aeddbe0 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -28,10 +28,15 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
 
+ifeq ($(CC),clang)
+  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
+  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
 CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS) -I include
-LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index ad28582bcf2b..f04479ecc96c 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -210,9 +210,9 @@ static char *ikm_read_reactor(char *monitor_name)
 static char *ikm_get_current_reactor(char *monitor_name)
 {
 	char *reactors = ikm_read_reactor(monitor_name);
+	char *curr_reactor = NULL;
 	char *start;
 	char *end;
-	char *curr_reactor;
 
 	if (!reactors)
 		return NULL;

