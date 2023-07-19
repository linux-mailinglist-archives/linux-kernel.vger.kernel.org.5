Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1A75A02B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGSUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjGSUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF14212B;
        Wed, 19 Jul 2023 13:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5E661834;
        Wed, 19 Jul 2023 20:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F80C433C9;
        Wed, 19 Jul 2023 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799778;
        bh=ElLJOq0QUPKDQnER3dHopH9uUZiA0v6ocxNfFBx/PLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5fcWtrleX1d5Jmq4RLRJ7Y7NtH8/8O1NK8B5WkiOuSOIRYa3Eb4RV9JJ/IEs9TQq
         myOY1kb6vtaKViRVfq5qdY0XYMikWGQIqYVlxo0NdTJutHs3cGuzqtjdK3bS20zfk9
         YfMaJcNDIasiCAUGMGWZ+JkF9znAMXI4Bcnl7qfF99URb6IB9x7+k/lVzwbWSdUxb0
         ubvf6Yjt5wkjC9jENIWczVdkZ04EKQ9dNkTc2vWHZtRFeMHnOm7pQQyR8hpRPVgj67
         UwqgPFRHoD0VTc4F6Qz5XKc9mjkMql4uy2ABApxvLfMHcB3/HqcsaNpI1I3bzD3/h/
         ah+k8Q6/LbVcA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andre Fredette <anfredet@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/5] perf bench uprobe empty: Add entry attaching an empty BPF program
Date:   Wed, 19 Jul 2023 17:49:09 -0300
Message-ID: <20230719204910.539044-5-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719204910.539044-1-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Using libbpf and a BPF skel:

  # perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,055,618 usecs

   1,055.618 usecs/op
  # Running uprobe/empty benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,057,146 usecs +1,528 to baseline

   1,057.146 usecs/op
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Fredette <anfredet@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                    |  1 +
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/uprobe.c                   | 75 ++++++++++++++++++++-
 tools/perf/builtin-bench.c                  |  3 +-
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c | 12 ++++
 5 files changed, 88 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/bench_uprobe.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 097316ef38e6a80f..a44d16ec11ee5490 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1057,6 +1057,7 @@ SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
+SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 201311f75c964df2..daf4850b441cf91c 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -43,6 +43,7 @@ int bench_evlist_open_close(int argc, const char **argv);
 int bench_breakpoint_thread(int argc, const char **argv);
 int bench_breakpoint_enable(int argc, const char **argv);
 int bench_uprobe_baseline(int argc, const char **argv);
+int bench_uprobe_empty(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index a90e09f791c540a9..dfb90038a4f7a06a 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -24,6 +24,11 @@
 #define LOOPS_DEFAULT 1000
 static int loops = LOOPS_DEFAULT;
 
+enum bench_uprobe {
+        BENCH_UPROBE__BASELINE,
+        BENCH_UPROBE__EMPTY,
+};
+
 static const struct option options[] = {
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_END()
@@ -34,6 +39,59 @@ static const char * const bench_uprobe_usage[] = {
 	NULL
 };
 
+#ifdef HAVE_BPF_SKEL
+#include "bpf_skel/bench_uprobe.skel.h"
+
+struct bench_uprobe_bpf *skel;
+
+static int bench_uprobe__setup_bpf_skel(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	int err;
+
+	/* Load and verify BPF application */
+	skel = bench_uprobe_bpf__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to open and load uprobes bench BPF skeleton\n");
+		return -1;
+	}
+
+	err = bench_uprobe_bpf__load(skel);
+	if (err) {
+		fprintf(stderr, "Failed to load and verify BPF skeleton\n");
+		goto cleanup;
+	}
+
+	uprobe_opts.func_name = "usleep";
+	skel->links.empty = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.empty,
+							    /*pid=*/-1,
+							    /*binary_path=*/"/lib64/libc.so.6",
+							    /*func_offset=*/0,
+							    /*opts=*/&uprobe_opts);
+	if (!skel->links.empty) {
+		err = -errno;
+		fprintf(stderr, "Failed to attach bench uprobe: %s\n", strerror(errno));
+		goto cleanup;
+	}
+
+	return err;
+cleanup:
+	bench_uprobe_bpf__destroy(skel);
+	return err;
+}
+
+static void bench_uprobe__teardown_bpf_skel(void)
+{
+	if (skel) {
+		bench_uprobe_bpf__destroy(skel);
+		skel = NULL;
+	}
+}
+#else
+static int bench_uprobe__setup_bpf_skel(void) { return 0; }
+static void bench_uprobe__teardown_bpf_skel(void) {};
+#endif
+
 static int bench_uprobe_format__default_fprintf(const char *name, const char *unit, u64 diff, FILE *fp)
 {
 	static u64 baseline, previous;
@@ -68,7 +126,7 @@ static int bench_uprobe_format__default_fprintf(const char *name, const char *un
 	return printed + 1;
 }
 
-static int bench_uprobe(int argc, const char **argv)
+static int bench_uprobe(int argc, const char **argv, enum bench_uprobe bench)
 {
 	const char *name = "usleep(1000)", *unit = "usec";
 	struct timespec start, end;
@@ -77,7 +135,10 @@ static int bench_uprobe(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, bench_uprobe_usage, 0);
 
-	clock_gettime(CLOCK_REALTIME, &start);
+	if (bench != BENCH_UPROBE__BASELINE && bench_uprobe__setup_bpf_skel() < 0)
+		return 0;
+
+        clock_gettime(CLOCK_REALTIME, &start);
 
 	for (i = 0; i < loops; i++) {
 		usleep(USEC_PER_MSEC);
@@ -103,10 +164,18 @@ static int bench_uprobe(int argc, const char **argv)
 		exit(1);
 	}
 
+	if (bench != BENCH_UPROBE__BASELINE)
+		bench_uprobe__teardown_bpf_skel();
+
 	return 0;
 }
 
 int bench_uprobe_baseline(int argc, const char **argv)
 {
-	return bench_uprobe(argc, argv);
+	return bench_uprobe(argc, argv, BENCH_UPROBE__BASELINE);
+}
+
+int bench_uprobe_empty(int argc, const char **argv)
+{
+	return bench_uprobe(argc, argv, BENCH_UPROBE__EMPTY);
 }
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 09637aee83413e63..1021680bbc6d4298 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -105,7 +105,8 @@ static struct bench breakpoint_benchmarks[] = {
 };
 
 static struct bench uprobe_benchmarks[] = {
-	{ "baseline",	"Baseline libc usleep(1000) call",	bench_uprobe_baseline,	},
+	{ "baseline",	"Baseline libc usleep(1000) call",				bench_uprobe_baseline,	},
+	{ "empty",	"Attach empty BPF prog to uprobe on usleep, system wide",	bench_uprobe_empty,	},
 	{ NULL,	NULL, NULL },
 };
 
diff --git a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
new file mode 100644
index 0000000000000000..1365dcc5dddff546
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2023 Red Hat
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+SEC("uprobe")
+int BPF_UPROBE(empty)
+{
+       return 0;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.41.0

