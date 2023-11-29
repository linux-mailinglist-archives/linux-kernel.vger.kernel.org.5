Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0937FCEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377000AbjK2GCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjK2GCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F2B1BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db40b699d0fso7331294276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237739; x=1701842539; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8ykSaAbLFyuzcPYepQRuQ5xp7FIWrmaxmvAYiTpoEM=;
        b=uspoxPX8E+ukWpbpDaIPltcSuLuYXkZjkyQAFnD+ZHlccd93ygNbhE26g8N6A4gGZz
         trPWszcg5+fakGMKJ+JFfhMMI4CN3LnxyRb/fYgJNWnTFEmTjgUcg0G+GprK510Yy3Xd
         08AhJLv98drog7NjeiFW1WzE4hZeOG8BW1Y5C8ski6VCPzKnnBdjclcklHDBFqMTh43s
         zsorQtJWI5V+yphwovihsaN6UUnQOypJmvwifGk7w90+kKsc7xaK8pDO8RDweob5FO3X
         jVH8kgHR8Zzeb0YWDJpcaVTopuDEraS6pKdliysP9MenV4fiimta7aabEoSVfldTzCcq
         Kneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237739; x=1701842539;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8ykSaAbLFyuzcPYepQRuQ5xp7FIWrmaxmvAYiTpoEM=;
        b=T81WYPEFULbUHep/3rj+Sg+GibFb8K/N7eIXTWy/HyeqDkJ9pbyFmZwpiK8Nm+mCww
         VbjrxtVanGJ38fsH0TT0q1fA64FX42JhrkYQ6Xgf1/CYKsMGgvknAEYyYA9XOAwBuHfR
         7P2dtqUaMuU0f9KndDoI3L0qHS+2p9ZS5wWjkOed08PlvzPJK0+vSmwWfKA1HVRenTDM
         5x+VmPtbg53dHV+Js5mzDbriRL18v48I95Xiy29U2PMtawMGChactBjHhUMbuiHWp1ab
         parV9abJlNJEp4y1tNMj5489cRIWJ5HEwrF4n1Wz2PyhhUnE5ZIX4JBD4ncT9hrgk+17
         GNWg==
X-Gm-Message-State: AOJu0Yx9uv6wHvaz0DVunYzQ0OpSXMP3cjRduDE97UEvNT8TlpVC6y7C
        fpnYDXXU25lhClDKQZJyEIx7WkfRMGCY
X-Google-Smtp-Source: AGHT+IGpkfJM/vGDzeJGawlB8gonUbNHatIumaAJ9ml4Cx9YmaCI6/1HJPOtb7yX5CQXz6dt/8yBM1CTLG9d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:ca50:0:b0:daf:5d6b:ef39 with SMTP id
 a77-20020a25ca50000000b00daf5d6bef39mr547103ybg.12.1701237739607; Tue, 28 Nov
 2023 22:02:19 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:01:59 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-3-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 02/14] libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename perf_cpu_map__default_new to perf_cpu_map__new_online_cpus to
better indicate what the implementation does. Read the online CPUs
from /sys/devices/system/cpu/online first before using sysconf as
sysconf can't accurately configure holes in the CPU map. If sysconf is
used, warn when the configured and online processors disagree.

When reading from a file, if the read doesn't yield a CPU map then
return an empty map rather than the default online. This avoids
recursion but also better yields being able to detect failures.

Add more comments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 59 +++++++++++++++++-----------
 tools/lib/perf/include/perf/cpumap.h | 15 ++++++-
 tools/lib/perf/libperf.map           |  2 +-
 tools/lib/perf/tests/test-cpumap.c   |  2 +-
 4 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 2bd6aba3d8c9..463ca8b37d45 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <limits.h>
+#include "internal.h"
 
 void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 {
@@ -66,15 +67,21 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
 	}
 }
 
-static struct perf_cpu_map *cpu_map__default_new(void)
+static struct perf_cpu_map *cpu_map__new_sysconf(void)
 {
 	struct perf_cpu_map *cpus;
-	int nr_cpus;
+	int nr_cpus, nr_cpus_conf;
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	if (nr_cpus < 0)
 		return NULL;
 
+	nr_cpus_conf = sysconf(_SC_NPROCESSORS_CONF);
+	if (nr_cpus != nr_cpus_conf) {
+		pr_warning("Number of online CPUs (%d) differs from the number configured (%d) the CPU map will only cover the first %d CPUs.",
+			nr_cpus, nr_cpus_conf, nr_cpus);
+	}
+
 	cpus = perf_cpu_map__alloc(nr_cpus);
 	if (cpus != NULL) {
 		int i;
@@ -86,9 +93,27 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
-struct perf_cpu_map *perf_cpu_map__default_new(void)
+static struct perf_cpu_map *cpu_map__new_syfs_online(void)
 {
-	return cpu_map__default_new();
+	struct perf_cpu_map *cpus = NULL;
+	FILE *onlnf;
+
+	onlnf = fopen("/sys/devices/system/cpu/online", "r");
+	if (onlnf) {
+		cpus = perf_cpu_map__read(onlnf);
+		fclose(onlnf);
+	}
+	return cpus;
+}
+
+struct perf_cpu_map *perf_cpu_map__new_online_cpus(void)
+{
+	struct perf_cpu_map *cpus = cpu_map__new_syfs_online();
+
+	if (cpus)
+		return cpus;
+
+	return cpu_map__new_sysconf();
 }
 
 
@@ -180,27 +205,11 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
-		cpus = cpu_map__default_new();
 out_free_tmp:
 	free(tmp_cpus);
 	return cpus;
 }
 
-static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
-{
-	struct perf_cpu_map *cpus = NULL;
-	FILE *onlnf;
-
-	onlnf = fopen("/sys/devices/system/cpu/online", "r");
-	if (!onlnf)
-		return cpu_map__default_new();
-
-	cpus = perf_cpu_map__read(onlnf);
-	fclose(onlnf);
-	return cpus;
-}
-
 struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 {
 	struct perf_cpu_map *cpus = NULL;
@@ -211,7 +220,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	int max_entries = 0;
 
 	if (!cpu_list)
-		return cpu_map__read_all_cpu_map();
+		return perf_cpu_map__new_online_cpus();
 
 	/*
 	 * must handle the case of empty cpumap to cover
@@ -268,9 +277,11 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else if (*cpu_list != '\0')
-		cpus = cpu_map__default_new();
-	else
+	else if (*cpu_list != '\0') {
+		pr_warning("Unexpected characters at end of cpu list ('%s'), using online CPUs.",
+			   cpu_list);
+		cpus = perf_cpu_map__new_online_cpus();
+	} else
 		cpus = perf_cpu_map__new_any_cpu();
 invalid:
 	free(tmp_cpus);
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index d0bf218ada11..b24bd8b8f34e 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -22,7 +22,20 @@ struct perf_cpu_map;
  * perf_cpu_map__new_any_cpu - a map with a singular "any CPU"/dummy -1 value.
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
-LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
+/**
+ * perf_cpu_map__new_online_cpus - a map read from
+ *                                 /sys/devices/system/cpu/online if
+ *                                 available. If reading wasn't possible a map
+ *                                 is created using the online processors
+ *                                 assuming the first 'n' processors are all
+ *                                 online.
+ */
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
+/**
+ * perf_cpu_map__new - create a map from the given cpu_list such as "0-7". If no
+ *                     cpu_list argument is provided then
+ *                     perf_cpu_map__new_online_cpus is returned.
+ */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index a8ff64baea3e..8a71f841498e 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -2,7 +2,7 @@ LIBPERF_0.0.1 {
 	global:
 		libperf_init;
 		perf_cpu_map__new_any_cpu;
-		perf_cpu_map__default_new;
+		perf_cpu_map__new_online_cpus;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
 		perf_cpu_map__new;
diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
index 2c359bdb951e..c998b1dae863 100644
--- a/tools/lib/perf/tests/test-cpumap.c
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -29,7 +29,7 @@ int test_cpumap(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 	perf_cpu_map__put(cpus);
 
-	cpus = perf_cpu_map__default_new();
+	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
 		return -1;
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

