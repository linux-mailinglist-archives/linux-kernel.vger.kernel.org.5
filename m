Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FF7CCDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjJQUXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:23:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136B92;
        Tue, 17 Oct 2023 13:23:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4262509b3a.0;
        Tue, 17 Oct 2023 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697574224; x=1698179024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KAqPA/YFMqh2bR5uVEmxZn2oXu3HsR87lhWgVKndKxg=;
        b=CO+SUSniCMbajadJOpYcdUcwb9D20X3hrXoKISjQSNO76HiCHiQRR9PD3suOPkF/IP
         cPlmnLARpCNl0fo8i+AUpsF5OlZ2deFjGp2bsa3mQuedIvlHcrBukr+ZxKq8EcilHpTj
         DMUI5juNgMVTIAXskzEfGoJS8DBm7uoH2rWmSo3EHbZJdbjfcKn8UMCrXHv/FwqVNsEk
         7V7O1i00/Qz7jLGLByQ9VgdVytrAVs/l229ZX3ZOi3MLJaDgHIH7OvYHvpbJK0454qie
         qDqt3eeYn6p7ZL8peXyaQCc0ODFpGPxxu5i7IcRY4rc+tBGoJxXytGf1E3Xkh6qaM0LU
         Eiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574224; x=1698179024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAqPA/YFMqh2bR5uVEmxZn2oXu3HsR87lhWgVKndKxg=;
        b=CP6J90SxyOxXBaWfFOaz0TFOe/xPE9KO6Un9Ra6bKi/pp69kzk8SdvVXAX20FaG5h8
         +SqxHXuov6oLITDswP121esiSPQJWgFWqypuvRfG/f5qHJiR3hiC3XvPzTqqibBztDCU
         4U4mw0iFOTzCLG+p3fCP1TV+gyeJNyGWwa0iSsNmZuSMKcDU1m8D8Ny3nOEaFUh/h7Bc
         svPD6/31yYhTtROSTVP1L9xoz8fNXfWqnky7+TvBNmilmEfcruMMqkswqCqqGfgeYPqV
         NqQzA72u7cyYdAD/64SsZNDgmDK00xUyzi/HzPGcnA0WGiJzA54F0MlKa7sKlQsq69xH
         wTnw==
X-Gm-Message-State: AOJu0YxdJm7+JZ7l9eFj8YDnT43+/znw58US9wwf74DZTN3rwPXQTppL
        Zx2C7GYO0HG/Zv3wrv63E/ZAFJz9S3A=
X-Google-Smtp-Source: AGHT+IE9O35DarWhXvaCC35KxMiYKUmkA2WF0gK3+CGUB2FLZqFVx632uDNERI70NpAojxReYcFV7A==
X-Received: by 2002:a05:6a00:13a3:b0:6be:25c5:4f74 with SMTP id t35-20020a056a0013a300b006be25c54f74mr3848666pfg.13.1697574224437;
        Tue, 17 Oct 2023 13:23:44 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:566a:72e8:b1ae:fbcd])
        by smtp.gmail.com with ESMTPSA id h1-20020a625301000000b006be484e5b9asm1924773pfb.188.2023.10.17.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:23:44 -0700 (PDT)
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
Subject: [PATCH v4] perf bench sched pipe: Add -G/--cgroups option
Date:   Tue, 17 Oct 2023 13:23:42 -0700
Message-ID: <20231017202342.1353124-1-namhyung@kernel.org>
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

Users need to make sure the cgroups exist and accessible.  The following
example should the effect of this change.  Please don't forget taskset
before the perf bench to measure cgroup switches properly.  Otherwise
each task would run on a different CPU and generate cgroup switches
regardless of this change.

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
* update hint for non-root usage
* initialize cgroup_failed properly
* describe taskset usage in the commit log

 tools/perf/Documentation/perf-bench.txt |  19 ++++
 tools/perf/bench/sched-pipe.c           | 132 +++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 4 deletions(-)

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
index a960e7a93aec..3af6d3c55aba 100644
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
 
@@ -40,9 +44,48 @@ static	int			loops = LOOPS_DEFAULT;
 /* Use processes by default: */
 static bool			threaded;
 
+static char			*cgrp_names[2];
+static struct cgroup		*cgrps[2];
+
+static int parse_two_cgroups(const struct option *opt __maybe_unused,
+			     const char *str, int unset __maybe_unused)
+{
+	char *p = strdup(str);
+	char *q;
+	int ret = -1;
+
+	if (p == NULL) {
+		fprintf(stderr, "memory allocation failure\n");
+		return -1;
+	}
+
+	q = strchr(p, ',');
+	if (q == NULL) {
+		fprintf(stderr, "it should have two cgroup names: %s\n", p);
+		goto out;
+	}
+	*q = '\0';
+
+	cgrp_names[0] = strdup(p);
+	cgrp_names[1] = strdup(q + 1);
+
+	if (cgrp_names[0] == NULL || cgrp_names[1] == NULL) {
+		fprintf(stderr, "memory allocation failure\n");
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
 
@@ -51,12 +94,89 @@ static const char * const bench_sched_pipe_usage[] = {
 	NULL
 };
 
+static int enter_cgroup(int nr)
+{
+	char buf[32];
+	int fd, len, ret;
+	int saved_errno;
+	struct cgroup *cgrp;
+	pid_t pid;
+
+	if (cgrp_names[nr] == NULL)
+		return 0;
+
+	if (cgrps[nr] == NULL) {
+		cgrps[nr] = cgroup__new(cgrp_names[nr], /*do_open=*/true);
+		if (cgrps[nr] == NULL)
+			goto err;
+	}
+	cgrp = cgrps[nr];
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
+	if (fd < 0 && errno == ENOENT)
+		fd = openat(cgrp->fd, "tasks", O_WRONLY);
+
+	if (fd < 0)
+		goto err;
+
+	ret = write(fd, buf, len);
+	close(fd);
+
+	if (ret != len) {
+		printf("Cannot enter to cgroup: %s\n", cgrp->name);
+		return -1;
+	}
+	return 0;
+
+err:
+	saved_errno = errno;
+	printf("Failed to open cgroup file in %s\n", cgrp_names[nr]);
+
+	if (saved_errno == ENOENT) {
+		char mnt[PATH_MAX];
+
+		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
+			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
+			       mnt, cgrp_names[nr]);
+	} else if (saved_errno == EACCES && geteuid() > 0) {
+		printf(" Hint: try to run as root\n");
+	}
+
+	return -1;
+}
+
+static void exit_cgroup(int nr)
+{
+	cgroup__put(cgrps[nr]);
+	free(cgrp_names[nr]);
+}
+
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
 	int m = 0, i;
 	int ret;
 
+	ret = enter_cgroup(td->nr);
+	if (ret < 0) {
+		td->cgroup_failed = true;
+		return NULL;
+	}
+
 	for (i = 0; i < loops; i++) {
 		if (!td->nr) {
 			ret = read(td->pipe_read, &m, sizeof(int));
@@ -76,7 +196,8 @@ static void *worker_thread(void *__tdata)
 
 int bench_sched_pipe(int argc, const char **argv)
 {
-	struct thread_data threads[2], *td;
+	struct thread_data threads[2] = {};
+	struct thread_data *td;
 	int pipe_1[2], pipe_2[2];
 	struct timeval start, stop, diff;
 	unsigned long long result_usec = 0;
@@ -112,9 +233,7 @@ int bench_sched_pipe(int argc, const char **argv)
 		}
 	}
 
-
 	if (threaded) {
-
 		for (t = 0; t < nr_threads; t++) {
 			td = threads + t;
 
@@ -128,7 +247,6 @@ int bench_sched_pipe(int argc, const char **argv)
 			ret = pthread_join(td->pthread, NULL);
 			BUG_ON(ret);
 		}
-
 	} else {
 		pid = fork();
 		assert(pid >= 0);
@@ -147,6 +265,12 @@ int bench_sched_pipe(int argc, const char **argv)
 	gettimeofday(&stop, NULL);
 	timersub(&stop, &start, &diff);
 
+	exit_cgroup(0);
+	exit_cgroup(1);
+
+	if (threads[0].cgroup_failed || threads[1].cgroup_failed)
+		return 0;
+
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		printf("# Executed %d pipe operations between two %s\n\n",
-- 
2.42.0.655.g421f12c284-goog

