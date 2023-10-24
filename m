Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81687D5E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbjJXWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbjJXWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:36:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66C269F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso94320637b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186316; x=1698791116; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pz/huDXZnCv4WpZbLBWJkVcH6X2J/pDveZLu7bi+8Bs=;
        b=nAo67VtDE5EUgapv9HttFk8STcAU8mRbYsPzyTT8kb+YiMRx7jsKNFXhZNWQ1EbNHK
         E16SzbzZz/VeVoQy/cSRwLqf1nA8b4TMPBg4e/ohD5hcvy/izFP73XKRtgj5Q4YAmT8l
         LnYT1r067RIB+JMkDwH6JATjxa4yrI2xg1rJPWZOrZ5vAuBeuQblykeNTSbnt5YtgZD1
         EdqBgTC+e9FxbXvZT949+ek7e6yru9XRhb76f85wqU1bd67bdZO4WiQQXHo/dW1eTayW
         svmDAs4nkreyKQLJm8h+GawxYhY3uVnCpE2j/UDZn0qNb0DvV8aUSjfpM0W3lVVWmrpR
         +MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186316; x=1698791116;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz/huDXZnCv4WpZbLBWJkVcH6X2J/pDveZLu7bi+8Bs=;
        b=F66B5kmBOAVmnxUZeC9L+tbA38aHTYnxv8GWVGoqAhaqGEJhUrKoU6zDL2s0JrG/ok
         nUbfjvtNYo/NwMw+ryI5iguQbnFl0yYUv4HVr7yOD24GCcObXfWFNEin1hP3mHu6SLFL
         QxK04oNKtQmBIfeZSa5AI9RNbm6DPS4jRmABTMfNG9MK4YXCscvU5iBy1UpDpkX3tZvA
         CDrDWCJF4qnk9SOJQxE/I/lt1aPzTCQI3oKa1lYNECXtaNGCww3u7KUpVZ7QZD5e+3e+
         qUVfRoKCMtjlYx5to4KnWjVJE3X1707yRp6o7imLyrWEmaJeduZ21VzpGY3lO31f7Eha
         nR/g==
X-Gm-Message-State: AOJu0YxWg34vmD27RneFKLxjYNjYHcBAXF3CKcCYl8mREa+2WKTUWoKD
        jctOXuXcuVqifvJS6+RuVapD2fkOA1wy
X-Google-Smtp-Source: AGHT+IEJO9Db9jZp8KRdInxtkeUGN9csPCjvZ+FopQ3hpaABnffpZp6XDj5SOyiZyycjoelvH9dxjuLiKZS5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a81:4e0e:0:b0:583:4f82:b9d9 with SMTP id
 c14-20020a814e0e000000b005834f82b9d9mr303273ywb.5.1698186316289; Tue, 24 Oct
 2023 15:25:16 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:31 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-29-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 28/50] perf maps: Add maps__for_each_map to call a function
 on each entry
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most current uses of maps don't take the rwsem introducing a risk that
the maps will change during iteration. Introduce maps__for_each_map
that iterates the entries under the read lock of the rwsem. This
replaces the maps__for_each_entry macro that is moved into
maps.c. maps__for_each_entry_safe will be replaced in a later change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/event.c         | 103 +++++++------
 tools/perf/builtin-report.c              |  54 ++++---
 tools/perf/tests/maps.c                  |  61 +++++---
 tools/perf/tests/vmlinux-kallsyms.c      | 181 ++++++++++++-----------
 tools/perf/util/machine.c                |  53 ++++---
 tools/perf/util/maps.c                   | 102 ++++++++-----
 tools/perf/util/maps.h                   |   6 +-
 tools/perf/util/probe-event.c            |  40 +++--
 tools/perf/util/symbol.c                 |  36 ++---
 tools/perf/util/synthetic-events.c       | 118 ++++++++-------
 tools/perf/util/thread.c                 |  35 +++--
 tools/perf/util/unwind-libunwind-local.c |  34 +++--
 tools/perf/util/vdso.c                   |  35 +++--
 13 files changed, 508 insertions(+), 350 deletions(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index 5741ffe47312..e65b7dbe27fb 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -14,66 +14,79 @@
 
 #if defined(__x86_64__)
 
-int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine)
+struct perf_event__synthesize_extra_kmaps_cb_args {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	union perf_event *event;
+};
+
+static int perf_event__synthesize_extra_kmaps_cb(struct map *map, void *data)
 {
-	int rc = 0;
-	struct map_rb_node *pos;
-	struct maps *kmaps = machine__kernel_maps(machine);
-	union perf_event *event = zalloc(sizeof(event->mmap) +
-					 machine->id_hdr_size);
+	struct perf_event__synthesize_extra_kmaps_cb_args *args = data;
+	union perf_event *event = args->event;
+	struct kmap *kmap;
+	size_t size;
 
-	if (!event) {
-		pr_debug("Not enough memory synthesizing mmap event "
-			 "for extra kernel maps\n");
-		return -1;
-	}
+	if (!__map__is_extra_kernel_map(map))
+		return 0;
 
-	maps__for_each_entry(kmaps, pos) {
-		struct kmap *kmap;
-		size_t size;
-		struct map *map = pos->map;
+	kmap = map__kmap(map);
 
-		if (!__map__is_extra_kernel_map(map))
-			continue;
+	size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
+		      PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
+		      args->machine->id_hdr_size;
 
-		kmap = map__kmap(map);
+	memset(event, 0, size);
 
-		size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
-		       PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
-		       machine->id_hdr_size;
+	event->mmap.header.type = PERF_RECORD_MMAP;
 
-		memset(event, 0, size);
+	/*
+	 * kernel uses 0 for user space maps, see kernel/perf_event.c
+	 * __perf_event_mmap
+	 */
+	if (machine__is_host(args->machine))
+		event->header.misc = PERF_RECORD_MISC_KERNEL;
+	else
+		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		event->mmap.header.type = PERF_RECORD_MMAP;
+	event->mmap.header.size = size;
 
-		/*
-		 * kernel uses 0 for user space maps, see kernel/perf_event.c
-		 * __perf_event_mmap
-		 */
-		if (machine__is_host(machine))
-			event->header.misc = PERF_RECORD_MISC_KERNEL;
-		else
-			event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+	event->mmap.start = map__start(map);
+	event->mmap.len   = map__size(map);
+	event->mmap.pgoff = map__pgoff(map);
+	event->mmap.pid   = args->machine->pid;
 
-		event->mmap.header.size = size;
+	strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
 
-		event->mmap.start = map__start(map);
-		event->mmap.len   = map__size(map);
-		event->mmap.pgoff = map__pgoff(map);
-		event->mmap.pid   = machine->pid;
+	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
+		return -1;
 
-		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
+	return 0;
+}
 
-		if (perf_tool__process_synth_event(tool, event, machine,
-						   process) != 0) {
-			rc = -1;
-			break;
-		}
+int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	int rc;
+	struct maps *kmaps = machine__kernel_maps(machine);
+	struct perf_event__synthesize_extra_kmaps_cb_args args = {
+		.tool = tool,
+		.process = process,
+		.machine = machine,
+		.event = zalloc(sizeof(args.event->mmap) + machine->id_hdr_size),
+	};
+
+	if (!args.event) {
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for extra kernel maps\n");
+		return -1;
 	}
 
-	free(event);
+	rc = maps__for_each_map(kmaps, perf_event__synthesize_extra_kmaps_cb, &args);
+
+	free(args.event);
 	return rc;
 }
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 749246817aed..d7f1f3c8cb7d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -844,27 +844,47 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 	return tasks_list(parent_task, machine);
 }
 
-static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+struct maps__fprintf_task_args {
+	int indent;
+	FILE *fp;
+	size_t printed;
+};
+
+static int maps__fprintf_task_cb(struct map *map, void *data)
 {
-	size_t printed = 0;
-	struct map_rb_node *rb_node;
+	struct maps__fprintf_task_args *args = data;
+	const struct dso *dso = map__dso(map);
+	u32 prot = map__prot(map);
+	int ret;
 
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-		const struct dso *dso = map__dso(map);
-		u32 prot = map__prot(map);
+	ret = fprintf(args->fp,
+		"%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
+		args->indent, "", map__start(map), map__end(map),
+		prot & PROT_READ ? 'r' : '-',
+		prot & PROT_WRITE ? 'w' : '-',
+		prot & PROT_EXEC ? 'x' : '-',
+		map__flags(map) ? 's' : 'p',
+		map__pgoff(map),
+		dso->id.ino, dso->name);
 
-		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
-				   indent, "", map__start(map), map__end(map),
-				   prot & PROT_READ ? 'r' : '-',
-				   prot & PROT_WRITE ? 'w' : '-',
-				   prot & PROT_EXEC ? 'x' : '-',
-				   map__flags(map) ? 's' : 'p',
-				   map__pgoff(map),
-				   dso->id.ino, dso->name);
-	}
+	if (ret < 0)
+		return ret;
+
+	args->printed += ret;
+	return 0;
+}
+
+static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+{
+	struct maps__fprintf_task_args args = {
+		.indent = indent,
+		.fp = fp,
+		.printed = 0,
+	};
+
+	maps__for_each_map(maps, maps__fprintf_task_cb, &args);
 
-	return printed;
+	return args.printed;
 }
 
 static void task__print_level(struct task *task, FILE *fp, int level)
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 5bb1123a91a7..bb3fbfe5a73e 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -14,44 +14,59 @@ struct map_def {
 	u64 end;
 };
 
+struct check_maps_cb_args {
+	struct map_def *merged;
+	unsigned int i;
+};
+
+static int check_maps_cb(struct map *map, void *data)
+{
+	struct check_maps_cb_args *args = data;
+	struct map_def *merged = &args->merged[args->i];
+
+	if (map__start(map) != merged->start ||
+	    map__end(map) != merged->end ||
+	    strcmp(map__dso(map)->name, merged->name) ||
+	    refcount_read(map__refcnt(map)) != 1) {
+		return 1;
+	}
+	args->i++;
+	return 0;
+}
+
+static int failed_cb(struct map *map, void *data __maybe_unused)
+{
+	pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
+		map__start(map),
+		map__end(map),
+		map__dso(map)->name,
+		refcount_read(map__refcnt(map)));
+
+	return 0;
+}
+
 static int check_maps(struct map_def *merged, unsigned int size, struct maps *maps)
 {
-	struct map_rb_node *rb_node;
-	unsigned int i = 0;
 	bool failed = false;
 
 	if (maps__nr_maps(maps) != size) {
 		pr_debug("Expected %d maps, got %d", size, maps__nr_maps(maps));
 		failed = true;
 	} else {
-		maps__for_each_entry(maps, rb_node) {
-			struct map *map = rb_node->map;
-
-			if (map__start(map) != merged[i].start ||
-			    map__end(map) != merged[i].end ||
-			    strcmp(map__dso(map)->name, merged[i].name) ||
-			    refcount_read(map__refcnt(map)) != 1) {
-				failed = true;
-			}
-			i++;
-		}
+		struct check_maps_cb_args args = {
+			.merged = merged,
+			.i = 0,
+		};
+		failed = maps__for_each_map(maps, check_maps_cb, &args);
 	}
 	if (failed) {
 		pr_debug("Expected:\n");
-		for (i = 0; i < size; i++) {
+		for (unsigned int i = 0; i < size; i++) {
 			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: 1\n",
 				merged[i].start, merged[i].end, merged[i].name);
 		}
 		pr_debug("Got:\n");
-		maps__for_each_entry(maps, rb_node) {
-			struct map *map = rb_node->map;
-
-			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
-				map__start(map),
-				map__end(map),
-				map__dso(map)->name,
-				refcount_read(map__refcnt(map)));
-		}
+		maps__for_each_map(maps, failed_cb, NULL);
 	}
 	return failed ? TEST_FAIL : TEST_OK;
 }
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 1078a93b01aa..822f893e67d5 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -112,18 +112,92 @@ static bool is_ignored_symbol(const char *name, char type)
 	return false;
 }
 
+struct test__vmlinux_matches_kallsyms_cb_args {
+	struct machine kallsyms;
+	struct map *vmlinux_map;
+	bool header_printed;
+};
+
+static int test__vmlinux_matches_kallsyms_cb1(struct map *map, void *data)
+{
+	struct test__vmlinux_matches_kallsyms_cb_args *args = data;
+	struct dso *dso = map__dso(map);
+	/*
+	 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
+	 * the kernel will have the path for the vmlinux file being used, so use
+	 * the short name, less descriptive but the same ("[kernel]" in both
+	 * cases.
+	 */
+	struct map *pair = maps__find_by_name(args->kallsyms.kmaps,
+					(dso->kernel ? dso->short_name : dso->name));
+
+	if (pair)
+		map__set_priv(pair, 1);
+	else {
+		if (!args->header_printed) {
+			pr_info("WARN: Maps only in vmlinux:\n");
+			args->header_printed = true;
+		}
+		map__fprintf(map, stderr);
+	}
+	return 0;
+}
+
+static int test__vmlinux_matches_kallsyms_cb2(struct map *map, void *data)
+{
+	struct test__vmlinux_matches_kallsyms_cb_args *args = data;
+	struct map *pair;
+	u64 mem_start = map__unmap_ip(args->vmlinux_map, map__start(map));
+	u64 mem_end = map__unmap_ip(args->vmlinux_map, map__end(map));
+
+	pair = maps__find(args->kallsyms.kmaps, mem_start);
+	if (pair == NULL || map__priv(pair))
+		return 0;
+
+	if (map__start(pair) == mem_start) {
+		struct dso *dso = map__dso(map);
+
+		if (!args->header_printed) {
+			pr_info("WARN: Maps in vmlinux with a different name in kallsyms:\n");
+			args->header_printed = true;
+		}
+
+		pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
+			map__start(map), map__end(map), map__pgoff(map), dso->name);
+		if (mem_end != map__end(pair))
+			pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
+				map__start(pair), map__end(pair), map__pgoff(pair));
+		pr_info(" %s\n", dso->name);
+		map__set_priv(pair, 1);
+	}
+	return 0;
+}
+
+static int test__vmlinux_matches_kallsyms_cb3(struct map *map, void *data)
+{
+	struct test__vmlinux_matches_kallsyms_cb_args *args = data;
+
+	if (!map__priv(map)) {
+		if (!args->header_printed) {
+			pr_info("WARN: Maps only in kallsyms:\n");
+			args->header_printed = true;
+		}
+		map__fprintf(map, stderr);
+	}
+	return 0;
+}
+
 static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
 	int err = TEST_FAIL;
 	struct rb_node *nd;
 	struct symbol *sym;
-	struct map *kallsyms_map, *vmlinux_map;
-	struct map_rb_node *rb_node;
-	struct machine kallsyms, vmlinux;
+	struct map *kallsyms_map;
+	struct machine vmlinux;
 	struct maps *maps;
 	u64 mem_start, mem_end;
-	bool header_printed;
+	struct test__vmlinux_matches_kallsyms_cb_args args;
 
 	/*
 	 * Step 1:
@@ -131,7 +205,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * Init the machines that will hold kernel, modules obtained from
 	 * both vmlinux + .ko files and from /proc/kallsyms split by modules.
 	 */
-	machine__init(&kallsyms, "", HOST_KERNEL_ID);
+	machine__init(&args.kallsyms, "", HOST_KERNEL_ID);
 	machine__init(&vmlinux, "", HOST_KERNEL_ID);
 
 	maps = machine__kernel_maps(&vmlinux);
@@ -143,7 +217,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * load /proc/kallsyms. Also create the modules maps from /proc/modules
 	 * and find the .ko files that match them in /lib/modules/`uname -r`/.
 	 */
-	if (machine__create_kernel_maps(&kallsyms) < 0) {
+	if (machine__create_kernel_maps(&args.kallsyms) < 0) {
 		pr_debug("machine__create_kernel_maps failed");
 		err = TEST_SKIP;
 		goto out;
@@ -160,7 +234,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * be compacted against the list of modules found in the "vmlinux"
 	 * code and with the one got from /proc/modules from the "kallsyms" code.
 	 */
-	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
+	if (machine__load_kallsyms(&args.kallsyms, "/proc/kallsyms") <= 0) {
 		pr_debug("machine__load_kallsyms failed");
 		err = TEST_SKIP;
 		goto out;
@@ -174,7 +248,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * to see if the running kernel was relocated by checking if it has the
 	 * same value in the vmlinux file we load.
 	 */
-	kallsyms_map = machine__kernel_map(&kallsyms);
+	kallsyms_map = machine__kernel_map(&args.kallsyms);
 
 	/*
 	 * Step 5:
@@ -186,7 +260,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		goto out;
 	}
 
-	vmlinux_map = machine__kernel_map(&vmlinux);
+	args.vmlinux_map = machine__kernel_map(&vmlinux);
 
 	/*
 	 * Step 6:
@@ -213,7 +287,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * in the kallsyms dso. For the ones that are in both, check its names and
 	 * end addresses too.
 	 */
-	map__for_each_symbol(vmlinux_map, sym, nd) {
+	map__for_each_symbol(args.vmlinux_map, sym, nd) {
 		struct symbol *pair, *first_pair;
 
 		sym  = rb_entry(nd, struct symbol, rb_node);
@@ -221,10 +295,10 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 		if (sym->start == sym->end)
 			continue;
 
-		mem_start = map__unmap_ip(vmlinux_map, sym->start);
-		mem_end = map__unmap_ip(vmlinux_map, sym->end);
+		mem_start = map__unmap_ip(args.vmlinux_map, sym->start);
+		mem_end = map__unmap_ip(args.vmlinux_map, sym->end);
 
-		first_pair = machine__find_kernel_symbol(&kallsyms, mem_start, NULL);
+		first_pair = machine__find_kernel_symbol(&args.kallsyms, mem_start, NULL);
 		pair = first_pair;
 
 		if (pair && UM(pair->start) == mem_start) {
@@ -253,7 +327,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 				 */
 				continue;
 			} else {
-				pair = machine__find_kernel_symbol_by_name(&kallsyms, sym->name, NULL);
+				pair = machine__find_kernel_symbol_by_name(&args.kallsyms,
+									   sym->name, NULL);
 				if (pair) {
 					if (UM(pair->start) == mem_start)
 						goto next_pair;
@@ -267,7 +342,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 
 				continue;
 			}
-		} else if (mem_start == map__end(kallsyms.vmlinux_map)) {
+		} else if (mem_start == map__end(args.kallsyms.vmlinux_map)) {
 			/*
 			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
 			 * such as __indirect_thunk_end.
@@ -289,78 +364,18 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	if (verbose <= 0)
 		goto out;
 
-	header_printed = false;
-
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-		struct dso *dso = map__dso(map);
-		/*
-		 * If it is the kernel, kallsyms is always "[kernel.kallsyms]", while
-		 * the kernel will have the path for the vmlinux file being used,
-		 * so use the short name, less descriptive but the same ("[kernel]" in
-		 * both cases.
-		 */
-		struct map *pair = maps__find_by_name(kallsyms.kmaps, (dso->kernel ?
-								dso->short_name :
-								dso->name));
-		if (pair) {
-			map__set_priv(pair, 1);
-		} else {
-			if (!header_printed) {
-				pr_info("WARN: Maps only in vmlinux:\n");
-				header_printed = true;
-			}
-			map__fprintf(map, stderr);
-		}
-	}
-
-	header_printed = false;
-
-	maps__for_each_entry(maps, rb_node) {
-		struct map *pair, *map = rb_node->map;
-
-		mem_start = map__unmap_ip(vmlinux_map, map__start(map));
-		mem_end = map__unmap_ip(vmlinux_map, map__end(map));
+	args.header_printed = false;
+	maps__for_each_map(maps, test__vmlinux_matches_kallsyms_cb1, &args);
 
-		pair = maps__find(kallsyms.kmaps, mem_start);
-		if (pair == NULL || map__priv(pair))
-			continue;
-
-		if (map__start(pair) == mem_start) {
-			struct dso *dso = map__dso(map);
-
-			if (!header_printed) {
-				pr_info("WARN: Maps in vmlinux with a different name in kallsyms:\n");
-				header_printed = true;
-			}
-
-			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
-				map__start(map), map__end(map), map__pgoff(map), dso->name);
-			if (mem_end != map__end(pair))
-				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
-					map__start(pair), map__end(pair), map__pgoff(pair));
-			pr_info(" %s\n", dso->name);
-			map__set_priv(pair, 1);
-		}
-	}
-
-	header_printed = false;
-
-	maps = machine__kernel_maps(&kallsyms);
+	args.header_printed = false;
+	maps__for_each_map(maps, test__vmlinux_matches_kallsyms_cb2, &args);
 
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
+	args.header_printed = false;
+	maps = machine__kernel_maps(&args.kallsyms);
+	maps__for_each_map(maps, test__vmlinux_matches_kallsyms_cb3, &args);
 
-		if (!map__priv(map)) {
-			if (!header_printed) {
-				pr_info("WARN: Maps only in kallsyms:\n");
-				header_printed = true;
-			}
-			map__fprintf(map, stderr);
-		}
-	}
 out:
-	machine__exit(&kallsyms);
+	machine__exit(&args.kallsyms);
 	machine__exit(&vmlinux);
 	return err;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b6831a1f909d..3c967295c9a3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1286,33 +1286,46 @@ static u64 find_entry_trampoline(struct dso *dso)
 #define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
 #define X86_64_ENTRY_TRAMPOLINE		0x6000
 
+struct machine__map_x86_64_entry_trampolines_args {
+	struct maps *kmaps;
+	bool found;
+};
+
+static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
+{
+	struct machine__map_x86_64_entry_trampolines_args *args = data;
+	struct map *dest_map;
+	struct kmap *kmap = __map__kmap(map);
+
+	if (!kmap || !is_entry_trampoline(kmap->name))
+		return 0;
+
+	dest_map = maps__find(args->kmaps, map__pgoff(map));
+	if (dest_map != map)
+		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
+
+	args->found = true;
+	return 0;
+}
+
 /* Map x86_64 PTI entry trampolines */
 int machine__map_x86_64_entry_trampolines(struct machine *machine,
 					  struct dso *kernel)
 {
-	struct maps *kmaps = machine__kernel_maps(machine);
+	struct machine__map_x86_64_entry_trampolines_args args = {
+		.kmaps = machine__kernel_maps(machine),
+		.found = false,
+	};
 	int nr_cpus_avail, cpu;
-	bool found = false;
-	struct map_rb_node *rb_node;
 	u64 pgoff;
 
 	/*
 	 * In the vmlinux case, pgoff is a virtual address which must now be
 	 * mapped to a vmlinux offset.
 	 */
-	maps__for_each_entry(kmaps, rb_node) {
-		struct map *dest_map, *map = rb_node->map;
-		struct kmap *kmap = __map__kmap(map);
-
-		if (!kmap || !is_entry_trampoline(kmap->name))
-			continue;
+	maps__for_each_map(args.kmaps, machine__map_x86_64_entry_trampolines_cb, &args);
 
-		dest_map = maps__find(kmaps, map__pgoff(map));
-		if (dest_map != map)
-			map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
-		found = true;
-	}
-	if (found || machine->trampolines_mapped)
+	if (args.found || machine->trampolines_mapped)
 		return 0;
 
 	pgoff = find_entry_trampoline(kernel);
@@ -3395,16 +3408,8 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
 {
 	struct maps *maps = machine__kernel_maps(machine);
-	struct map_rb_node *pos;
-	int err = 0;
 
-	maps__for_each_entry(maps, pos) {
-		err = fn(pos->map, priv);
-		if (err != 0) {
-			break;
-		}
-	}
-	return err;
+	return maps__for_each_map(maps, fn, priv);
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 9a011aed4b75..00e6589bba10 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,6 +10,9 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
+#define maps__for_each_entry(maps, map) \
+	for (map = maps__first(maps); map; map = map_rb_node__next(map))
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -196,6 +199,21 @@ void maps__put(struct maps *maps)
 		RC_CHK_PUT(maps);
 }
 
+int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data)
+{
+	struct map_rb_node *pos;
+	int ret = 0;
+
+	down_read(maps__lock(maps));
+	maps__for_each_entry(maps, pos)	{
+		ret = cb(pos->map, data);
+		if (ret)
+			break;
+	}
+	up_read(maps__lock(maps));
+	return ret;
+}
+
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
@@ -210,31 +228,40 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	return NULL;
 }
 
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
-{
+struct maps__find_symbol_by_name_args {
+	struct map **mapp;
+	const char *name;
 	struct symbol *sym;
-	struct map_rb_node *pos;
+};
 
-	down_read(maps__lock(maps));
+static int maps__find_symbol_by_name_cb(struct map *map, void *data)
+{
+	struct maps__find_symbol_by_name_args *args = data;
 
-	maps__for_each_entry(maps, pos) {
-		sym = map__find_symbol_by_name(pos->map, name);
+	args->sym = map__find_symbol_by_name(map, args->name);
+	if (!args->sym)
+		return 0;
 
-		if (sym == NULL)
-			continue;
-		if (!map__contains_symbol(pos->map, sym)) {
-			sym = NULL;
-			continue;
-		}
-		if (mapp != NULL)
-			*mapp = pos->map;
-		goto out;
+	if (!map__contains_symbol(map, args->sym)) {
+		args->sym = NULL;
+		return 0;
 	}
 
-	sym = NULL;
-out:
-	up_read(maps__lock(maps));
-	return sym;
+	if (args->mapp != NULL)
+		*args->mapp = map__get(map);
+	return 1;
+}
+
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp)
+{
+	struct maps__find_symbol_by_name_args args = {
+		.mapp = mapp,
+		.name = name,
+		.sym = NULL,
+	};
+
+	maps__for_each_map(maps, maps__find_symbol_by_name_cb, &args);
+	return args.sym;
 }
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
@@ -253,25 +280,34 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	return ams->ms.sym ? 0 : -1;
 }
 
-size_t maps__fprintf(struct maps *maps, FILE *fp)
-{
-	size_t printed = 0;
-	struct map_rb_node *pos;
+struct maps__fprintf_args {
+	FILE *fp;
+	size_t printed;
+};
 
-	down_read(maps__lock(maps));
+static int maps__fprintf_cb(struct map *map, void *data)
+{
+	struct maps__fprintf_args *args = data;
 
-	maps__for_each_entry(maps, pos) {
-		printed += fprintf(fp, "Map:");
-		printed += map__fprintf(pos->map, fp);
-		if (verbose > 2) {
-			printed += dso__fprintf(map__dso(pos->map), fp);
-			printed += fprintf(fp, "--\n");
-		}
+	args->printed += fprintf(args->fp, "Map:");
+	args->printed += map__fprintf(map, args->fp);
+	if (verbose > 2) {
+		args->printed += dso__fprintf(map__dso(map), args->fp);
+		args->printed += fprintf(args->fp, "--\n");
 	}
+	return 0;
+}
 
-	up_read(maps__lock(maps));
+size_t maps__fprintf(struct maps *maps, FILE *fp)
+{
+	struct maps__fprintf_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+
+	maps__for_each_map(maps, maps__fprintf_cb, &args);
 
-	return printed;
+	return args.printed;
 }
 
 int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index a689149be8c4..8ac30cdaf5bd 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -36,9 +36,6 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
-#define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map_rb_node__next(map))
-
 #define maps__for_each_entry_safe(maps, map, next) \
 	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
 	     map = next, next = map_rb_node__next(map))
@@ -81,6 +78,9 @@ static inline void __maps__zput(struct maps **map)
 
 #define maps__zput(map) __maps__zput(&map)
 
+/* Iterate over map calling cb for each entry. */
+int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
+
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
 	return &RC_CHK_ACCESS(maps)->entries;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 1a5b7fa459b2..a1a796043691 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -149,10 +149,32 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 	return 0;
 }
 
+struct kernel_get_module_map_cb_args {
+	const char *module;
+	struct map *result;
+};
+
+static int kernel_get_module_map_cb(struct map *map, void *data)
+{
+	struct kernel_get_module_map_cb_args *args = data;
+	struct dso *dso = map__dso(map);
+	const char *short_name = dso->short_name; /* short_name is "[module]" */
+	u16 short_name_len =  dso->short_name_len;
+
+	if (strncmp(short_name + 1, args->module, short_name_len - 2) == 0 &&
+	    args->module[short_name_len - 2] == '\0') {
+		args->result = map__get(map);
+		return 1;
+	}
+	return 0;
+}
+
 static struct map *kernel_get_module_map(const char *module)
 {
-	struct maps *maps = machine__kernel_maps(host_machine);
-	struct map_rb_node *pos;
+	struct kernel_get_module_map_cb_args args = {
+		.module = module,
+		.result = NULL,
+	};
 
 	/* A file path -- this is an offline module */
 	if (module && strchr(module, '/'))
@@ -164,19 +186,9 @@ static struct map *kernel_get_module_map(const char *module)
 		return map__get(map);
 	}
 
-	maps__for_each_entry(maps, pos) {
-		/* short_name is "[module]" */
-		struct dso *dso = map__dso(pos->map);
-		const char *short_name = dso->short_name;
-		u16 short_name_len =  dso->short_name_len;
+	maps__for_each_map(machine__kernel_maps(host_machine), kernel_get_module_map_cb, &args);
 
-		if (strncmp(short_name + 1, module,
-			    short_name_len - 2) == 0 &&
-		    module[short_name_len - 2] == '\0') {
-			return map__get(pos->map);
-		}
-	}
-	return NULL;
+	return args.result;
 }
 
 struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1cc42b8d8afb..72f03b875478 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1114,33 +1114,35 @@ int compare_proc_modules(const char *from, const char *to)
 	return ret;
 }
 
+static int do_validate_kcore_modules_cb(struct map *old_map, void *data)
+{
+	struct rb_root *modules = data;
+	struct module_info *mi;
+	struct dso *dso;
+
+	if (!__map__is_kmodule(old_map))
+		return 0;
+
+	dso = map__dso(old_map);
+	/* Module must be in memory at the same address */
+	mi = find_module(dso->short_name, modules);
+	if (!mi || mi->start != map__start(old_map))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
-	struct map_rb_node *old_node;
 	int err;
 
 	err = read_proc_modules(filename, &modules);
 	if (err)
 		return err;
 
-	maps__for_each_entry(kmaps, old_node) {
-		struct map *old_map = old_node->map;
-		struct module_info *mi;
-		struct dso *dso;
+	err = maps__for_each_map(kmaps, do_validate_kcore_modules_cb, &modules);
 
-		if (!__map__is_kmodule(old_map)) {
-			continue;
-		}
-		dso = map__dso(old_map);
-		/* Module must be in memory at the same address */
-		mi = find_module(dso->short_name, &modules);
-		if (!mi || mi->start != map__start(old_map)) {
-			err = -EINVAL;
-			goto out;
-		}
-	}
-out:
 	delete_modules(&modules);
 	return err;
 }
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 7cc38f2a0e9e..cdab6aa04917 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -666,18 +666,74 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
+struct perf_event__synthesize_modules_maps_cb_args {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	union perf_event *event;
+};
+
+static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
+{
+	struct perf_event__synthesize_modules_maps_cb_args *args = data;
+	union perf_event *event = args->event;
+	struct dso *dso;
+	size_t size;
+
+	if (!__map__is_kmodule(map))
+		return 0;
+
+	dso = map__dso(map);
+	if (symbol_conf.buildid_mmap2) {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap2.header.type = PERF_RECORD_MMAP2;
+		event->mmap2.header.size = (sizeof(event->mmap2) -
+					(sizeof(event->mmap2.filename) - size));
+		memset(event->mmap2.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap2.header.size += args->machine->id_hdr_size;
+		event->mmap2.start = map__start(map);
+		event->mmap2.len   = map__size(map);
+		event->mmap2.pid   = args->machine->pid;
+
+		memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
+
+		perf_record_mmap2__read_build_id(&event->mmap2, args->machine, false);
+	} else {
+		size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
+		event->mmap.header.type = PERF_RECORD_MMAP;
+		event->mmap.header.size = (sizeof(event->mmap) -
+					(sizeof(event->mmap.filename) - size));
+		memset(event->mmap.filename + size, 0, args->machine->id_hdr_size);
+		event->mmap.header.size += args->machine->id_hdr_size;
+		event->mmap.start = map__start(map);
+		event->mmap.len   = map__size(map);
+		event->mmap.pid   = args->machine->pid;
+
+		memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
+	}
+
+	if (perf_tool__process_synth_event(args->tool, event, args->machine, args->process) != 0)
+		return -1;
+
+	return 0;
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
-	int rc = 0;
-	struct map_rb_node *pos;
+	int rc;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event;
-	size_t size = symbol_conf.buildid_mmap2 ?
-			sizeof(event->mmap2) : sizeof(event->mmap);
+	struct perf_event__synthesize_modules_maps_cb_args args = {
+		.tool = tool,
+		.process = process,
+		.machine = machine,
+	};
+	size_t size = symbol_conf.buildid_mmap2
+		? sizeof(args.event->mmap2)
+		: sizeof(args.event->mmap);
 
-	event = zalloc(size + machine->id_hdr_size);
-	if (event == NULL) {
+	args.event = zalloc(size + machine->id_hdr_size);
+	if (args.event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
 		return -1;
@@ -688,53 +744,13 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	 * __perf_event_mmap
 	 */
 	if (machine__is_host(machine))
-		event->header.misc = PERF_RECORD_MISC_KERNEL;
+		args.event->header.misc = PERF_RECORD_MISC_KERNEL;
 	else
-		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
-
-	maps__for_each_entry(maps, pos) {
-		struct map *map = pos->map;
-		struct dso *dso;
+		args.event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!__map__is_kmodule(map))
-			continue;
+	rc = maps__for_each_map(maps, perf_event__synthesize_modules_maps_cb, &args);
 
-		dso = map__dso(map);
-		if (symbol_conf.buildid_mmap2) {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap2.header.type = PERF_RECORD_MMAP2;
-			event->mmap2.header.size = (sizeof(event->mmap2) -
-						(sizeof(event->mmap2.filename) - size));
-			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-			event->mmap2.header.size += machine->id_hdr_size;
-			event->mmap2.start = map__start(map);
-			event->mmap2.len   = map__size(map);
-			event->mmap2.pid   = machine->pid;
-
-			memcpy(event->mmap2.filename, dso->long_name, dso->long_name_len + 1);
-
-			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
-		} else {
-			size = PERF_ALIGN(dso->long_name_len + 1, sizeof(u64));
-			event->mmap.header.type = PERF_RECORD_MMAP;
-			event->mmap.header.size = (sizeof(event->mmap) -
-						(sizeof(event->mmap.filename) - size));
-			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-			event->mmap.header.size += machine->id_hdr_size;
-			event->mmap.start = map__start(map);
-			event->mmap.len   = map__size(map);
-			event->mmap.pid   = machine->pid;
-
-			memcpy(event->mmap.filename, dso->long_name, dso->long_name_len + 1);
-		}
-
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
-			rc = -1;
-			break;
-		}
-	}
-
-	free(event);
+	free(args.event);
 	return rc;
 }
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index eae3041408a7..2b938ccbfe3e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -349,34 +349,33 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	return maps__insert(thread__maps(thread), map);
 }
 
-static int __thread__prepare_access(struct thread *thread)
+struct thread__prepare_access_maps_cb_args {
+	int err;
+	struct maps *maps;
+};
+
+static int thread__prepare_access_maps_cb(struct map *map, void *data)
 {
 	bool initialized = false;
-	int err = 0;
-	struct maps *maps = thread__maps(thread);
-	struct map_rb_node *rb_node;
-
-	down_read(maps__lock(maps));
-
-	maps__for_each_entry(maps, rb_node) {
-		err = unwind__prepare_access(thread__maps(thread), rb_node->map, &initialized);
-		if (err || initialized)
-			break;
-	}
+	struct thread__prepare_access_maps_cb_args *args = data;
 
-	up_read(maps__lock(maps));
+	args->err = unwind__prepare_access(args->maps, map, &initialized);
 
-	return err;
+	return (args->err || initialized) ? 1 : 0;
 }
 
 static int thread__prepare_access(struct thread *thread)
 {
-	int err = 0;
+	struct thread__prepare_access_maps_cb_args args = {
+		.err = 0,
+	};
 
-	if (dwarf_callchain_users)
-		err = __thread__prepare_access(thread);
+	if (dwarf_callchain_users) {
+		args.maps = thread__maps(thread);
+		maps__for_each_map(thread__maps(thread), thread__prepare_access_maps_cb, &args);
+	}
 
-	return err;
+	return args.err;
 }
 
 static int thread__clone_maps(struct thread *thread, struct thread *parent, bool do_maps_clone)
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index c0641882fd2f..228f1565bd0b 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -302,12 +302,31 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
 	return 0;
 }
 
+struct read_unwind_spec_eh_frame_maps_cb_args {
+	struct dso *dso;
+	u64 base_addr;
+};
+
+static int read_unwind_spec_eh_frame_maps_cb(struct map *map, void *data)
+{
+
+	struct read_unwind_spec_eh_frame_maps_cb_args *args = data;
+
+	if (map__dso(map) == args->dso && map__start(map) < args->base_addr)
+		args->base_addr = map__start(map);
+
+	return 0;
+}
+
+
 static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 				     u64 *table_data, u64 *segbase,
 				     u64 *fde_count)
 {
-	struct map_rb_node *map_node;
-	u64 base_addr = UINT64_MAX;
+	struct read_unwind_spec_eh_frame_maps_cb_args args = {
+		.dso = dso,
+		.base_addr = UINT64_MAX,
+	};
 	int ret, fd;
 
 	if (dso->data.eh_frame_hdr_offset == 0) {
@@ -325,16 +344,11 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 			return -EINVAL;
 	}
 
-	maps__for_each_entry(thread__maps(ui->thread), map_node) {
-		struct map *map = map_node->map;
-		u64 start = map__start(map);
+	maps__for_each_map(thread__maps(ui->thread), read_unwind_spec_eh_frame_maps_cb, &args);
 
-		if (map__dso(map) == dso && start < base_addr)
-			base_addr = start;
-	}
-	base_addr -= dso->data.elf_base_addr;
+	args.base_addr -= dso->data.elf_base_addr;
 	/* Address of .eh_frame_hdr */
-	*segbase = base_addr + dso->data.eh_frame_hdr_addr;
+	*segbase = args.base_addr + dso->data.eh_frame_hdr_addr;
 	ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
 				   table_data, fde_count);
 	if (ret)
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index ae3eee69b659..df8963796187 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -140,23 +140,34 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	return dso;
 }
 
+struct machine__thread_dso_type_maps_cb_args {
+	struct machine *machine;
+	enum dso_type dso_type;
+};
+
+static int machine__thread_dso_type_maps_cb(struct map *map, void *data)
+{
+	struct machine__thread_dso_type_maps_cb_args *args = data;
+	struct dso *dso = map__dso(map);
+
+	if (!dso || dso->long_name[0] != '/')
+		return 0;
+
+	args->dso_type = dso__type(dso, args->machine);
+	return (args->dso_type != DSO__TYPE_UNKNOWN) ? 1 : 0;
+}
+
 static enum dso_type machine__thread_dso_type(struct machine *machine,
 					      struct thread *thread)
 {
-	enum dso_type dso_type = DSO__TYPE_UNKNOWN;
-	struct map_rb_node *rb_node;
-
-	maps__for_each_entry(thread__maps(thread), rb_node) {
-		struct dso *dso = map__dso(rb_node->map);
+	struct machine__thread_dso_type_maps_cb_args args = {
+		.machine = machine,
+		.dso_type = DSO__TYPE_UNKNOWN,
+	};
 
-		if (!dso || dso->long_name[0] != '/')
-			continue;
-		dso_type = dso__type(dso, machine);
-		if (dso_type != DSO__TYPE_UNKNOWN)
-			break;
-	}
+	maps__for_each_map(thread__maps(thread), machine__thread_dso_type_maps_cb, &args);
 
-	return dso_type;
+	return args.dso_type;
 }
 
 #if BITS_PER_LONG == 64
-- 
2.42.0.758.gaed0368e0e-goog

