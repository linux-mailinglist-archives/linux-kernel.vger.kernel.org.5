Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378017C9E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJPEmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJPEmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:42:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF2E3;
        Sun, 15 Oct 2023 21:42:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c8a1541232so35583735ad.0;
        Sun, 15 Oct 2023 21:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697431349; x=1698036149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bswXwNfImS+XtehLFp8Hks3Rdc2qkHkQlUwKqtmfp54=;
        b=Z3JsoCQzcnRY27jf1JfjejN7rvSr3AOGdGxzNb+bI7OICDq7Yf6lqFjBfSNs5tzvcM
         X2POp+eX7iZLeT0h8LbYBiJhbMIHHafzsK7YWLIVujdUhNxUl+A96opkLL3BUEmryVlG
         f/yfEEe2k6uH4/CjBAVSyGQJPK9wkZFTRy4Jm5dmN6oInAO2zTINuYfj5efhHShHyhXE
         093XBF7wd8l4zFCYLOki/CwNUFMCUdmaqKvLQcXsfzpNFSa4hGxYKYRX1LLomvW5SMuj
         gp9Eunw2WpPUmT78r5o/KEs8xvrleFx2aV826rABd+wZU0CqAJ+0ZNbuObXRUVtyWndP
         +Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697431349; x=1698036149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bswXwNfImS+XtehLFp8Hks3Rdc2qkHkQlUwKqtmfp54=;
        b=AywjQnot+flwiN5/QInqcNbNyeWMjxhf1384YQicHbMxmYEd1F7uBhBtUT5jASo+gh
         y0YNghGoOoC/hibkDx7LiBx8chTpoYGRqOGFNjQJI7TXymzgTSK7G0ptNOb8z/nwjG8h
         ExYVx7MM4V3/yL0gJpKu1p6wJQzYd4c2qAphT4pVjKg8OAgyJ6kYrzkCG3pT1WH+gA4P
         OUELrYsrA3vd05jHMvugrbMCByftoKnyEQ86iI7Omwa/yNaJcoAN0GJnPMrS3/IcVmhi
         ipOdhAsIOF4kH55TQh7B9Dm3Zdet+u2/vvrmo66f7PY4F+rsMTL+MUry/lKicxKwLjPD
         WopQ==
X-Gm-Message-State: AOJu0Yw7dqCYs6ZbHfY0SyHc1IbC2cQSjyHKPA+bTF1zrAh0Ojqalb6b
        7XzTKP3nyUEDUDJecHJnAj8=
X-Google-Smtp-Source: AGHT+IGLf8a+S2l5e9Rgfyjh9feJZQeUDt7aRbUUPCOjqEDu8uuVBuU94nRWdamGqjj8gCb+aX4stw==
X-Received: by 2002:a17:902:c212:b0:1c9:aac5:df0f with SMTP id 18-20020a170902c21200b001c9aac5df0fmr14986817pll.55.1697431348536;
        Sun, 15 Oct 2023 21:42:28 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:149a:25d:ca33:9105])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001c61afa7009sm7695816pla.114.2023.10.15.21.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 21:42:28 -0700 (PDT)
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
Subject: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Date:   Sun, 15 Oct 2023 21:42:25 -0700
Message-ID: <20231016044225.1125674-1-namhyung@kernel.org>
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
 tools/perf/Documentation/perf-bench.txt |  19 ++++
 tools/perf/bench/sched-pipe.c           | 118 +++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 3 deletions(-)

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
index a960e7a93aec..88d20a34adb2 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -10,7 +10,9 @@
  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
 #include <subcmd/parse-options.h>
+#include <api/fs/fs.h>
 #include "bench.h"
+#include "util/cgroup.h"
 
 #include <unistd.h>
 #include <stdio.h>
@@ -19,6 +21,7 @@
 #include <sys/wait.h>
 #include <string.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <assert.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -31,6 +34,7 @@ struct thread_data {
 	int			nr;
 	int			pipe_read;
 	int			pipe_write;
+	bool			cgroup_failed;
 	pthread_t		pthread;
 };
 
@@ -40,9 +44,55 @@ static	int			loops = LOOPS_DEFAULT;
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
 
@@ -51,12 +101,71 @@ static const char * const bench_sched_pipe_usage[] = {
 	NULL
 };
 
+static int enter_cgroup(struct cgroup *cgrp)
+{
+	char buf[32];
+	int fd, len, ret;
+	pid_t pid;
+
+	if (cgrp == NULL)
+		return 0;
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
+		char mnt[PATH_MAX];
+
+		printf("Failed to open cgroup file in %s\n", cgrp->name);
+
+		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
+			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
+			       mnt, cgrp->name);
+		return -1;
+	}
+
+	ret = write(fd, buf, len);
+	close(fd);
+
+	if (ret != len) {
+		printf("Cannot enter to cgroup: %s\n", cgrp->name);
+		return -1;
+	}
+	return 0;
+}
+
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
 	int m = 0, i;
 	int ret;
 
+	if (td->nr)
+		ret = enter_cgroup(cgrp_send);
+	else
+		ret = enter_cgroup(cgrp_recv);
+
+	if (ret < 0) {
+		td->cgroup_failed = true;
+		return NULL;
+	}
+	td->cgroup_failed = false;
+
 	for (i = 0; i < loops; i++) {
 		if (!td->nr) {
 			ret = read(td->pipe_read, &m, sizeof(int));
@@ -112,9 +221,7 @@ int bench_sched_pipe(int argc, const char **argv)
 		}
 	}
 
-
 	if (threaded) {
-
 		for (t = 0; t < nr_threads; t++) {
 			td = threads + t;
 
@@ -128,7 +235,6 @@ int bench_sched_pipe(int argc, const char **argv)
 			ret = pthread_join(td->pthread, NULL);
 			BUG_ON(ret);
 		}
-
 	} else {
 		pid = fork();
 		assert(pid >= 0);
@@ -147,6 +253,12 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	cgroup__put(cgrp_send);
+	cgroup__put(cgrp_recv);
+
+	if (threads[0].cgroup_failed || threads[1].cgroup_failed)
+		return 0;
+
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		printf("# Executed %d pipe operations between two %s\n\n",
-- 
2.42.0.655.g421f12c284-goog

