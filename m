Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DD80147A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379591AbjLAUax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379547AbjLAUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:30:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEAD10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:30:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBE7C433CB;
        Fri,  1 Dec 2023 20:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701462657;
        bh=QVbACnLUnYQMYgOMYoEehYGakqfQw3HgLVP3m0AP9nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f70uuGixlDaJcgsf2n6YchS57/ri8BALDiEeWnOumwvDZDqwy67PHfV8h9LsE8s3N
         /VGa3UkO5I1x9vdByVOcmKTE75IcwsAx/Od2IhZe/kEunB0yu2/Vwd7bTz7mdYl0nT
         QJ1GvffFGrB0Sz1CoqFoSSeYjRmzYDgxQpKBG9/AxedGGYO8/VSBDuVLh+PFma13tV
         p5Zl+97ISlp1A5ISIy+amkTI89UhCQA6lvAN4YfImzZo1oVdIaK8/RpFP2IBzYCViH
         Ripio0j/StTd1uSV91lBO/4ICDL1cVVpvOs/n0DWngSw2fuiJX+tH3ltB3hL463Hwj
         Kfj+P5ng5F9SQ==
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
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH 1/2] perf env: Introduce perf_env__arch_strerrno()
Date:   Fri,  1 Dec 2023 17:30:45 -0300
Message-ID: <20231201203046.486596-2-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201203046.486596-1-acme@kernel.org>
References: <20231201203046.486596-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That will cache the arch specific function translating error numbers to
strings.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++----
 tools/perf/util/env.c      | 7 +++++++
 tools/perf/util/env.h      | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e541d0e2777ab935..109b8e64fe69ae32 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2470,9 +2470,8 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 static const char *errno_to_name(struct evsel *evsel, int err)
 {
 	struct perf_env *env = evsel__env(evsel);
-	const char *arch_name = perf_env__arch(env);
 
-	return arch_syscalls__strerrno(arch_name, err);
+	return perf_env__arch_strerrno(env, err);
 }
 
 static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
@@ -4264,12 +4263,11 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 			printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
 
 			if (trace->errno_summary && stats->nr_failures) {
-				const char *arch_name = perf_env__arch(trace->host->env);
 				int e;
 
 				for (e = 0; e < stats->max_errno; ++e) {
 					if (stats->errnos[e] != 0)
-						fprintf(fp, "\t\t\t\t%s: %d\n", arch_syscalls__strerrno(arch_name, e + 1), stats->errnos[e]);
+						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
 				}
 			}
 		}
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cbc18b22ace5231e..fdd62ea00173ccf5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include "pmus.h"
 #include "strbuf.h"
+#include "trace/beauty/beauty.h"
 
 struct perf_env perf_env;
 
@@ -453,6 +454,12 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
+const char *perf_env__arch_strerrno(struct perf_env *env, int err)
+{
+	const char *arch_name = perf_env__arch(env);
+	return arch_syscalls__strerrno(arch_name, err);
+}
+
 const char *perf_env__cpuid(struct perf_env *env)
 {
 	int status;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 94596ff124d54188..79f371879f45bafc 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -164,6 +164,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
+const char *perf_env__arch_strerrno(struct perf_env *env, int err);
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
-- 
2.41.0

