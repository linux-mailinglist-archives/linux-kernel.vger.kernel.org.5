Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A775A02C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGSUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGSUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DB2108;
        Wed, 19 Jul 2023 13:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F8861843;
        Wed, 19 Jul 2023 20:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270F6C433CA;
        Wed, 19 Jul 2023 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799782;
        bh=OazpdNCdjjMaiaC/TvQE6CjFJ6T/f9NfLfUAUPgtiPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZE2Q9/7xBBEfujluvrRVJM0CsJUEth7+NFDpXRW5r0p8RCdU6V9heUR8LvzekahbM
         Gi1zcfLtLIvYlgFQJ8Q0izhZFhi66yVvwalcduhqWfvPkJ9eeUuOvv1nE7HMnp7P+U
         JXdXINJa1jB2U6hZpr9x9WO4UGmmXrdm5O1FQ8VXFo5n6Ns9QM39ilzD/E7gGSG0/6
         nYCXx6JgTGd8QDjsGKZP7KPHZRT+zsxTOBmzae/TGvAmnIxY6dRCanBMxxLynax5Jg
         8hf+OzfUyMQQpx/ZBTQFKFnUc83PuINmQdDOAdvBdb76itOuJM45eHsZfyBuOiGvxJ
         MWtzgYK6o/r6g==
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
Subject: [PATCH 5/5] perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk
Date:   Wed, 19 Jul 2023 17:49:10 -0300
Message-ID: <20230719204910.539044-6-acme@kernel.org>
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

  [root@five ~]# perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,053,963 usecs

   1,053.963 usecs/op

  # Running uprobe/empty benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,056,293 usecs +2,330 to baseline

   1,056.293 usecs/op 2.330 usecs/op to baseline

  # Running uprobe/trace_printk benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,056,977 usecs +3,014 to baseline +684 to previous

   1,056.977 usecs/op 3.014 usecs/op to baseline 0.684 usecs/op to previous

  [root@five ~]#

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
 tools/perf/bench/bench.h                    |  1 +
 tools/perf/bench/uprobe.c                   | 39 +++++++++++++++------
 tools/perf/builtin-bench.c                  |  1 +
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c | 11 ++++++
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index daf4850b441cf91c..50de4773651f9914 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -44,6 +44,7 @@ int bench_breakpoint_thread(int argc, const char **argv);
 int bench_breakpoint_enable(int argc, const char **argv);
 int bench_uprobe_baseline(int argc, const char **argv);
 int bench_uprobe_empty(int argc, const char **argv);
+int bench_uprobe_trace_printk(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index dfb90038a4f7a06a..914c0817fe8ad31b 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -11,6 +11,7 @@
 #include <subcmd/parse-options.h>
 #include "../builtin.h"
 #include "bench.h"
+#include <linux/compiler.h>
 #include <linux/time64.h>
 
 #include <inttypes.h>
@@ -27,6 +28,7 @@ static int loops = LOOPS_DEFAULT;
 enum bench_uprobe {
         BENCH_UPROBE__BASELINE,
         BENCH_UPROBE__EMPTY,
+        BENCH_UPROBE__TRACE_PRINTK,
 };
 
 static const struct option options[] = {
@@ -42,9 +44,21 @@ static const char * const bench_uprobe_usage[] = {
 #ifdef HAVE_BPF_SKEL
 #include "bpf_skel/bench_uprobe.skel.h"
 
+#define bench_uprobe__attach_uprobe(prog) \
+	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
+							   /*pid=*/-1, \
+							   /*binary_path=*/"/lib64/libc.so.6", \
+							   /*func_offset=*/0, \
+							   /*opts=*/&uprobe_opts); \
+	if (!skel->links.prog) { \
+		err = -errno; \
+		fprintf(stderr, "Failed to attach bench uprobe \"%s\": %s\n", #prog, strerror(errno)); \
+		goto cleanup; \
+	}
+
 struct bench_uprobe_bpf *skel;
 
-static int bench_uprobe__setup_bpf_skel(void)
+static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	int err;
@@ -63,14 +77,12 @@ static int bench_uprobe__setup_bpf_skel(void)
 	}
 
 	uprobe_opts.func_name = "usleep";
-	skel->links.empty = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.empty,
-							    /*pid=*/-1,
-							    /*binary_path=*/"/lib64/libc.so.6",
-							    /*func_offset=*/0,
-							    /*opts=*/&uprobe_opts);
-	if (!skel->links.empty) {
-		err = -errno;
-		fprintf(stderr, "Failed to attach bench uprobe: %s\n", strerror(errno));
+	switch (bench) {
+	case BENCH_UPROBE__BASELINE:							break;
+	case BENCH_UPROBE__EMPTY:	 bench_uprobe__attach_uprobe(empty);		break;
+	case BENCH_UPROBE__TRACE_PRINTK: bench_uprobe__attach_uprobe(trace_printk);	break;
+	default:
+		fprintf(stderr, "Invalid bench: %d\n", bench);
 		goto cleanup;
 	}
 
@@ -88,7 +100,7 @@ static void bench_uprobe__teardown_bpf_skel(void)
 	}
 }
 #else
-static int bench_uprobe__setup_bpf_skel(void) { return 0; }
+static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench __maybe_unused) { return 0; }
 static void bench_uprobe__teardown_bpf_skel(void) {};
 #endif
 
@@ -135,7 +147,7 @@ static int bench_uprobe(int argc, const char **argv, enum bench_uprobe bench)
 
 	argc = parse_options(argc, argv, options, bench_uprobe_usage, 0);
 
-	if (bench != BENCH_UPROBE__BASELINE && bench_uprobe__setup_bpf_skel() < 0)
+	if (bench != BENCH_UPROBE__BASELINE && bench_uprobe__setup_bpf_skel(bench) < 0)
 		return 0;
 
         clock_gettime(CLOCK_REALTIME, &start);
@@ -179,3 +191,8 @@ int bench_uprobe_empty(int argc, const char **argv)
 {
 	return bench_uprobe(argc, argv, BENCH_UPROBE__EMPTY);
 }
+
+int bench_uprobe_trace_printk(int argc, const char **argv)
+{
+	return bench_uprobe(argc, argv, BENCH_UPROBE__TRACE_PRINTK);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 1021680bbc6d4298..f60ccafccac25602 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -107,6 +107,7 @@ static struct bench breakpoint_benchmarks[] = {
 static struct bench uprobe_benchmarks[] = {
 	{ "baseline",	"Baseline libc usleep(1000) call",				bench_uprobe_baseline,	},
 	{ "empty",	"Attach empty BPF prog to uprobe on usleep, system wide",	bench_uprobe_empty,	},
+	{ "trace_printk", "Attach trace_printk BPF prog to uprobe on usleep syswide",	bench_uprobe_trace_printk,	},
 	{ NULL,	NULL, NULL },
 };
 
diff --git a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
index 1365dcc5dddff546..7046bea5da871627 100644
--- a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
+++ b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
@@ -3,10 +3,21 @@
 #include "vmlinux.h"
 #include <bpf/bpf_tracing.h>
 
+unsigned int nr_uprobes;
+
 SEC("uprobe")
 int BPF_UPROBE(empty)
 {
        return 0;
 }
 
+SEC("uprobe")
+int BPF_UPROBE(trace_printk)
+{
+	char fmt[] = "perf bench uprobe %u";
+
+        bpf_trace_printk(fmt, sizeof(fmt), ++nr_uprobes);
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.41.0

