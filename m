Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5407B8E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbjJDUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:47:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCF9B;
        Wed,  4 Oct 2023 13:47:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692d2e8c003so1096891b3a.1;
        Wed, 04 Oct 2023 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696452463; x=1697057263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe7AYgbbCr6h7nPpRbjMws5d7g3FTU6k23yCXjc41mQ=;
        b=je6Ilf2KnFZ4xyDmYyBYESmE7B/dLksrNTD6hTA408+Qbx611zJeWSvL4/AkG3u6PS
         4l4x8eyF6AnPAIZ9xXdbo7Yvtb24n98y4ysE6KtV1dNuHZ6KRqFe9yVIcGFtB/OoVKO0
         Tz4+nvH7FDOvLI8LoqCcMQu/IOxifxZ+OD4MqeuTBzKlsq49ZpqO3Xe2slPTSPXvJBXT
         RIsvG2NsU1aLZHkQ3xD/eKYG+ACPoLTjHFLq+1OsDauWf54Blg5hxXDPTKOxdZAOmtKC
         NModpyyIRCLt80iQ9vZS0NRsDybQICM60BpqCiSQMMXdSHDOcioSZfnumKo1El5htjr/
         Mxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452463; x=1697057263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe7AYgbbCr6h7nPpRbjMws5d7g3FTU6k23yCXjc41mQ=;
        b=wnp3KFFCdPOBzlNVI+WxCBdcsMEFqfuhxFXJlXfLS3z7uZSk4ZoiIgjk3ST0xbMWe0
         x1VkSoeYgGZROC8I4Ki9w44PhvbGBBAKqLrn7iX0/jqtwvH75/2zvE37tSnPeOjWKqIi
         U/rs2Ro0TxB9eCud/SL9HU9jCqDXuhyosPFS/ImwF5Iu7cz/IbAzCDI6f8KCUKE5tTq8
         /KS9sfS/du38lYThzjPq5veLVTpkn8f5V8Tgufj5hnz2/NI0zBo2BTDTNB/YADrzCcbC
         Ek4k8c+7cFI1zYjSBlHU5xXpt6ka6uM8yLgHbzDK0YAfaEsIOA8sisOEbdUfdhOC4sL3
         Veow==
X-Gm-Message-State: AOJu0YwaWr2PCo9uwMWi+WM5vxd3zzaxkLTxRXu8D2ruN1VJYoUxGw19
        /Z1GBqZvmbI2m6jeEx6KfRw=
X-Google-Smtp-Source: AGHT+IE+Sh4y+Vgw4K099B0kmwjW51RSzabx95V9+meTncqsjlspCxUjB13TaVl5Vk7q5jfQpYSZaA==
X-Received: by 2002:a05:6a20:1456:b0:134:73f6:5832 with SMTP id a22-20020a056a20145600b0013473f65832mr1044930pzi.16.1696452463269;
        Wed, 04 Oct 2023 13:47:43 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:2489:7e4:8212:9753])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b00694f14a7851sm3622061pfo.43.2023.10.04.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 13:47:42 -0700 (PDT)
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
Subject: [PATCH] perf bench sched pipe: Add -G/--cgroups option
Date:   Wed,  4 Oct 2023 13:47:41 -0700
Message-ID: <20231004204741.985422-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
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
index a960e7a93aec..1103fd658d5d 100644
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
+		fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
+	else
+		fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
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
2.42.0.609.gbb76f46606-goog

