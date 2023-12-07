Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381D807DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442960AbjLGBRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441989AbjLGBRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D167D71
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d988d69812so2000767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911859; x=1702516659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWbEUwb58UlcO44iquha9B3wIFU7ouiZNorH1Tw4idg=;
        b=An8hs7vM3xA34BLCGuIlyrdEwTaIlDJW3CT5PnzLofotq+4NL59J/BPExMYeHiZmpe
         n877WshRHMN9EQCAl0zRrgkrt7UVE5XWJSHrJtCR8wR/0ZtsAIJUn5R42uIULOm+s67t
         Z1WAgAnDghoBHq2+tYRd2ytkwotcm/iOEJb7dzKm5kp0q+EkMjD7JDGXrtkJBzf7rsuN
         Odaft3XOP5d+HCF2vuNfhzCwhbjRSvHEpGSGAkrbFMsHFpvMU7tTf45c9JtiFtoUL6Ok
         AzAYgvbaoMMaW5x+PqruSWdjuzVGLqgmTM9ODq+uEW3cyWWJpN5K+YTvd4D42Tm8WIJz
         xJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911859; x=1702516659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWbEUwb58UlcO44iquha9B3wIFU7ouiZNorH1Tw4idg=;
        b=qMXrYmkyU0S7l2K8+LrJgEbqnnO0u6HeaTPxvivKYcYIXVKdq8/cpdI48pETHAmZz/
         1nsyYY/8yarIIDV5k0nO3tT2bJbI5u4NGTYgz+xUQ7n8afi9iXs3U48ay5HnQ8WtmcX6
         wuSST+OrlA579uBuX/zSR+eaI+e8FBk49TSFmkp2dAHhTbmjLwoUSE0l2IvGtWIdPvng
         MMB0mfUyBc7BvOElxbZQesFyuZg+uBbcAsIkiyHMiKPGo2ePDw6tAPJ0VC+4b9sfg3jv
         BrXBBCr12cMxJXVwH28JuviynHgNRBkPV325awlB9W6TOL/XEyuPlvZo6XpqUlimJykm
         Mlhg==
X-Gm-Message-State: AOJu0Yyo2Y+i8Ba1mRZb3jUS+ulh0gHiNKvHFabZUigNNgPKdWi8+fP1
        MLYWzCvI/1WLsPLwRI9jpMnkNgEZEm8I
X-Google-Smtp-Source: AGHT+IGira8VNhWf1V5T6H2CZc74U8dx1xOUTg42LprohRK4QMCSI9v1zSDOVleO7URKLP27qDp3FCuKB32Q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:408b:b0:5d3:d6c3:dc6 with SMTP id
 gb11-20020a05690c408b00b005d3d6c30dc6mr27281ywb.7.1701911859217; Wed, 06 Dec
 2023 17:17:39 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:39 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-6-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 05/47] perf tests: Use function to add missing maps lock
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

Switch loop macro maps__for_each_entry to maps__for_each_map function
that takes a callback. The function holds the maps lock, which should
be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c             |  61 ++++++----
 tools/perf/tests/vmlinux-kallsyms.c | 181 +++++++++++++++-------------
 2 files changed, 136 insertions(+), 106 deletions(-)

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
-- 
2.43.0.rc2.451.g8631bc7472-goog

