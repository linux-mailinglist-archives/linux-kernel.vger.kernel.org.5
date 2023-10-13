Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92447C9153
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJMXYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMXYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:24:39 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3FBB7;
        Fri, 13 Oct 2023 16:24:38 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b6c7d0cabso1512654eaf.1;
        Fri, 13 Oct 2023 16:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697239477; x=1697844277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hlPy5ggPstA5Vf2bJ1akF8shrqCTEJcK3rV/vSFC+uY=;
        b=gqMiRrO18E5+Ss6jNtm6vo81haH/wnKIrvxtDPXhRGSSXa+56IJO5l3Z1rHvxKbhij
         xyqDKceC1zYHIQmQb5ATRZdDZgQ8TWDLyzN75w5ZDzDE3602ac/HCSnepn8pPump3hAl
         krotG62SleDdPVHrmySwdnTlDKJ9EX7fzPPrdhazwS617QwPoELhNMLIZvLh+DhfUCG8
         GqB57+IZ7D9DsDXe9mVQNbDXU1wO6wZwv8xvC2AJ0zL4a+YHyyUmT1BveHv3YRnzOt6R
         Q2k/vFMTpc5jefBsGZmphIZKkshRX8ToE79QmtmxoZxZRlxjUxEAsJwsBHWFcrT1JkO3
         w+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239477; x=1697844277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlPy5ggPstA5Vf2bJ1akF8shrqCTEJcK3rV/vSFC+uY=;
        b=UmygjJkK7UibDnHirK4wirUAJexj2cugq7JniKS/fLojN38AycQRqmnve23yWg0svf
         F7CpQGtPv8VCK3Ap5l2DsoxQaIDo88A6q4XwRyniv8QahvvnVPy1dt5v8NGVnwFJ8CVr
         579iCmD/VWhY3sRg1X/xo4FkbH46xQb9spFMiOGwq5ia06G51/AuxsLAP11nzYhEsrmv
         n5jy8/7xMBqr5Ji4QtLlec+tog/5xw//ohCormeMMAGfmAS7OLf4YCwpnW7H9tdWhAFl
         KS8Td2oKQ+l1WxzaSbikR5sMQOmgfAGhjSLNHBajzeb6KrUGu07Ablwetyj8IZ9NDxsq
         8ORA==
X-Gm-Message-State: AOJu0YzFkHSxbrM8Y1NyRyTFyXclgVc8fFzHZLyhWw/Eh7S1WLnL/Y7d
        j1dDy5QyTA5Z9DaUZToNcig=
X-Google-Smtp-Source: AGHT+IGPUDD4kGWOdbhotNpYkmiBsU6AprFMl0FN9460vpyKgU4kGDY4zU25JDLOhFwgxDQ7lsf8qg==
X-Received: by 2002:a05:6358:72a:b0:139:bbae:1f3 with SMTP id e42-20020a056358072a00b00139bbae01f3mr29316223rwj.3.1697239477136;
        Fri, 13 Oct 2023 16:24:37 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:cd97:8dac:f4aa:e506])
        by smtp.gmail.com with ESMTPSA id b8-20020a637148000000b00589b7a9ef01sm3938930pgn.36.2023.10.13.16.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:24:36 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2] perf bench sched pipe: Add -G/--cgroups option
Date:   Fri, 13 Oct 2023 16:24:35 -0700
Message-ID: <20231013232435.1012585-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -G/--cgroups option is to put sender and receiver in different
cgroups in order to measure cgroup context switch overheads.

Users need to make sure the cgroups exist and accessible.

  # perf stat -e context-switches,cgroup-switches \
  > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null

   Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':

              20,001      context-switches
                   2      cgroup-switches

         0.053449651 seconds time elapsed

         0.011286000 seconds user
         0.041869000 seconds sys

  # perf stat -e context-switches,cgroup-switches \
  > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null

   Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

              20,001      context-switches
              20,001      cgroup-switches

         0.052768627 seconds time elapsed

         0.006284000 seconds user
         0.046266000 seconds sys

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-bench.txt | 19 +++++
 tools/perf/bench/sched-pipe.c           | 93 +++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index ca5789625cd2..8331bd28b10e 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -124,6 +124,14 @@ Options of *pipe*
 --loop=::
 Specify number of loops.
 
+-G::
+--cgroups=::
+Names of cgroups for sender and receiver, separated by a comma.
+This is useful to check cgroup context switching overhead.
+Note that perf doesn't create nor delete the cgroups, so users should
+make sure that the cgroups exist and are accessible before use.
+
+
 Example of *pipe*
 ^^^^^^^^^^^^^^^^^
 
@@ -141,6 +149,17 @@ Example of *pipe*
         Total time:0.016 sec
                 16.948000 usecs/op
                 59004 ops/sec
+
+% perf bench sched pipe -G AAA,BBB
+(executing 1000000 pipe operations between cgroups)
+# Running 'sched/pipe' benchmark:
+# Executed 1000000 pipe operations between two processes
+
+     Total time: 6.886 [sec]
+
+       6.886208 usecs/op
+         145217 ops/sec
+
 ---------------------
 
 SUITES FOR 'syscall'
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index a960e7a93aec..a98c2e239908 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -11,6 +11,7 @@
  */
 #include <subcmd/parse-options.h>
 #include "bench.h"
+#include "util/cgroup.h"
 
 #include <unistd.h>
 #include <stdio.h>
@@ -19,6 +20,7 @@
 #include <sys/wait.h>
 #include <string.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <assert.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -40,9 +42,55 @@ static	int			loops = LOOPS_DEFAULT;
 /* Use processes by default: */
 static bool			threaded;
 
+static struct cgroup *cgrp_send = NULL;
+static struct cgroup *cgrp_recv = NULL;
+
+static int parse_two_cgroups(const struct option *opt __maybe_unused,
+			     const char *str, int unset __maybe_unused)
+{
+	char *p = strdup(str);
+	char *q;
+	int ret = -1;
+
+	if (p == NULL) {
+		fprintf(stderr, "memory allocation failure");
+		return -1;
+	}
+
+	q = strchr(p, ',');
+	if (q == NULL) {
+		fprintf(stderr, "it should have two cgroup names: %s", p);
+		goto out;
+	}
+	*q = '\0';
+
+	cgrp_send = cgroup__new(p, /*do_open=*/true);
+	if (cgrp_send == NULL) {
+		fprintf(stderr, "cannot open sender cgroup: %s", p);
+		goto out;
+	}
+
+	/* skip ',' */
+	q++;
+
+	cgrp_recv = cgroup__new(q, /*do_open=*/true);
+	if (cgrp_recv == NULL) {
+		fprintf(stderr, "cannot open receiver cgroup: %s", q);
+		goto out;
+	}
+	ret = 0;
+
+out:
+	free(p);
+	return ret;
+}
+
 static const struct option options[] = {
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
+	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
+		     "Put sender and receivers in given cgroups",
+		     parse_two_cgroups),
 	OPT_END()
 };
 
@@ -51,12 +99,54 @@ static const char * const bench_sched_pipe_usage[] = {
 	NULL
 };
 
+static void enter_cgroup(struct cgroup *cgrp)
+{
+	char buf[32];
+	int fd, len;
+	pid_t pid;
+
+	if (cgrp == NULL)
+		return;
+
+	if (threaded)
+		pid = syscall(__NR_gettid);
+	else
+		pid = getpid();
+
+	snprintf(buf, sizeof(buf), "%d\n", pid);
+	len = strlen(buf);
+
+	/* try cgroup v2 interface first */
+	if (threaded)
+		fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
+	else
+		fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
+
+	/* try cgroup v1 if failed */
+	if (fd < 0)
+		fd = openat(cgrp->fd, "tasks", O_WRONLY);
+
+	if (fd < 0) {
+		printf("failed to open cgroup file in %s\n", cgrp->name);
+		return;
+	}
+
+	if (write(fd, buf, len) != len)
+		printf("cannot enter to cgroup: %s\n", cgrp->name);
+	close(fd);
+}
+
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
 	int m = 0, i;
 	int ret;
 
+	if (td->nr)
+		enter_cgroup(cgrp_send);
+	else
+		enter_cgroup(cgrp_recv);
+
 	for (i = 0; i < loops; i++) {
 		if (!td->nr) {
 			ret = read(td->pipe_read, &m, sizeof(int));
@@ -147,6 +237,9 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	cgroup__put(cgrp_send);
+	cgroup__put(cgrp_recv);
+
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		printf("# Executed %d pipe operations between two %s\n\n",
-- 
2.42.0.655.g421f12c284-goog

