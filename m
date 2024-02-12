Return-Path: <linux-kernel+bounces-61712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848F8515AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FA0B28ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9627E3F9FC;
	Mon, 12 Feb 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae76YWd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9383F9EB;
	Mon, 12 Feb 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745061; cv=none; b=eaTWdhGILqyhW3Pbezz3jNxXqf/E0M8A5wj21ohP17GIxGv747FO1moeIEO3odUDi8kNZ51rdrYn2UoU/O6CBAc+aYWIbIETZg8z8Fza2r10qjsRHfdgonVpgYUL6EJYDGKkz+u7DpR8RaKLUYCXS+9M0mC7NB+EzrlU1DobtqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745061; c=relaxed/simple;
	bh=4sTEmsotNj78doyDXGe8tqFXHWZp5ctoZf7N+E1kfMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbB7o1RgASX9oixIJd2Vmdrh+2prSRSmq3FWFWahw/yOQpCU7ltdB84ELeISdH1P+AG+gKbBhWGibgZk9t4ROb8O0EMHYp9RxFZaxoKpgvVfuvyrdugmmug0dSItVzAwkp3O2VoO0xj6v93oNrTWN8HmcSeJGXifeHQAz2PXgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae76YWd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B3BC433C7;
	Mon, 12 Feb 2024 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707745061;
	bh=4sTEmsotNj78doyDXGe8tqFXHWZp5ctoZf7N+E1kfMs=;
	h=From:To:Cc:Subject:Date:From;
	b=Ae76YWd8PNxkfVxoREUzIvQNkQFE76DqtACVwSJowkFakOquzSQl/H5RBhuVbPfMH
	 XEfd1fBmLz4rN38pkU2dXf+pzuwemp3j+6rNILnIuCOcXFIQXmbVMI/98y0O0ppMnH
	 JLZwVBFDGjT9I93EQusvymoNErSboTgwtI/99aEPpiB6cQrLQBTRePqWbIeddqy0E2
	 QOl9G8bCnVKwOh1UU2InxtVNJkVT4LF7BCJd3J2+tAEh4JABa7l1kzcw6E59hNand3
	 SNklVBIJ1ZjlMbvO61Cb7kWI1JIkKvdAatHxIf389hk6iighwfoRZlX3M8SQYMnKiD
	 /BNJt4GwQA1eQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	limingming3 <limingming890315@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] tracing/tools: Fixes for 6.8-rc4
Date: Mon, 12 Feb 2024 14:37:28 +0100
Message-ID: <20240212133730.25714-1-bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

Tracing tooling updates for 6.8-rc4

RTLA:
        - rtla tools are exiting with a positive value  when usage()
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


Please pull the latest trace-tools-fixes-v6.8-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
trace-tools-fixes-v6.8-rc4

Tag SHA1: 63f0522db203c7d138595e760b9a237bc02990fa
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

