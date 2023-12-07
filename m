Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EC807DC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443067AbjLGBUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443052AbjLGBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:20:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909501724
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d33b70fce8so2038257b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911910; x=1702516710; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kz2oL9dDwNcBq6v0QnywleLTyISwSzEpRE/HF57DiU=;
        b=MX0w+v6lRRowcuisVEbg8t5tZ9CB9vFlluiBFkr8KeexxRn4MqQfStQT/ZM4PCVKPC
         P5Jzkc2FmTxA2v0toTwnw2ZhLzUe7stiCRp2DeHx19nIIuf5xfHTejh3x8fBJqvWkirT
         wBiG6ebBCcSsS5H/F0kG37Od9fcfdroy+XJGxftW7xOLO7GWhowcN5HlcUx+a6MjapLH
         dTftrquQLCMc81vMkCfnjU9waMcaeujMIzs30bL60GOfX8xg6tuQihka6I0osYmTXHaZ
         Yg+12I/Y+km1lbVGFwSR/XR83ZTrRODqex5i5WYqsiB8pxz5QnNOVI+CAeNYBs3R2E5Q
         zLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911910; x=1702516710;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kz2oL9dDwNcBq6v0QnywleLTyISwSzEpRE/HF57DiU=;
        b=Hnd2LLcFpL5q2xkYSDflqzmJoQFzSQ4GrKX8JrKRin7j7I/kH52vdERKRx5mzuYsse
         2dLAgscazdDrxNlGhwN579BV5e3CcSOm1Y7gAy9iH5k7pcilmkjdNCp/RvlKss2dyx7m
         /uL1wkr4d5mmMlLD+bIpOz5iUcoZg6q+CWNBfMtHIUnFgpcLpLG4JaCHZwa9IxUvwcei
         TSE8CVwPSEiLlyCNNf818Ifjd0RE/54HeYWiCkJMdx6g7GSMyJx+BOok07QZlLyc04fP
         O5eww1TToTLZCswvUHEuLp0cOVnkVs1UosOqfGX97+NdlUuBz9mPQb6Jk+uDxtxBLgua
         vJhQ==
X-Gm-Message-State: AOJu0YyABNyYXNMG0XQb/g618WQszUli8Z+fPyddqNphsj5wKL94X3fW
        N8grsOc3Zru3xDMEmhqIV8LHX25n8ugg
X-Google-Smtp-Source: AGHT+IF9sFhKVp/pUh3Bfw1uRAglh295FMqZmp3OubGiaoImXt/kaAQjK4rlo13V72G3wsKpcOAKhV67iMpW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:d304:0:b0:5d3:472b:3427 with SMTP id
 y4-20020a81d304000000b005d3472b3427mr34217ywi.6.1701911910246; Wed, 06 Dec
 2023 17:18:30 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:01 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-28-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 27/47] perf maps: Hide maps internals
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the struct into the C file. Add maps__equal to work around
exposing the struct for reference count checking. Add accessors for
the unwind_libunwind_ops. Move maps_list_node to its only use in
symbol.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/thread-maps-share.c     |  8 +-
 tools/perf/util/callchain.c              |  2 +-
 tools/perf/util/maps.c                   | 96 +++++++++++++++++++++++
 tools/perf/util/maps.h                   | 97 +++---------------------
 tools/perf/util/symbol.c                 | 10 +++
 tools/perf/util/thread.c                 |  2 +-
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 tools/perf/util/unwind-libunwind.c       |  7 +-
 8 files changed, 123 insertions(+), 101 deletions(-)

diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 7fa6f7c568e2..e9ecd30a5c05 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -46,9 +46,9 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 4);
 
 	/* test the maps pointer is shared */
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t1)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t2)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t3)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t1)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t2)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t3)));
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -73,7 +73,7 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	other_maps = thread__maps(other);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(other_maps)), 2);
 
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(other_maps, thread__maps(other_leader)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(other_maps, thread__maps(other_leader)));
 
 	/* release thread group */
 	thread__put(t3);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8262f69118db..7517d16c02ec 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1157,7 +1157,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (RC_CHK_EQUAL(al->maps, machine__kernel_maps(machine))) {
+	if (maps__equal(al->maps, machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 0438c417ee44..c08e412a4313 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -6,9 +6,63 @@
 #include "dso.h"
 #include "map.h"
 #include "maps.h"
+#include "rwsem.h"
 #include "thread.h"
 #include "ui/ui.h"
 #include "unwind.h"
+#include <internal/rc_check.h>
+
+/*
+ * Locking/sorting note:
+ *
+ * Sorting is done with the write lock, iteration and binary searching happens
+ * under the read lock requiring being sorted. There is a race between sorting
+ * releasing the write lock and acquiring the read lock for iteration/searching
+ * where another thread could insert and break the sorting of the maps. In
+ * practice inserting maps should be rare meaning that the race shouldn't lead
+ * to live lock. Removal of maps doesn't break being sorted.
+ */
+
+DECLARE_RC_STRUCT(maps) {
+	struct rw_semaphore lock;
+	/**
+	 * @maps_by_address: array of maps sorted by their starting address if
+	 * maps_by_address_sorted is true.
+	 */
+	struct map	 **maps_by_address;
+	/**
+	 * @maps_by_name: optional array of maps sorted by their dso name if
+	 * maps_by_name_sorted is true.
+	 */
+	struct map	 **maps_by_name;
+	struct machine	 *machine;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	void		*addr_space;
+	const struct unwind_libunwind_ops *unwind_libunwind_ops;
+#endif
+	refcount_t	 refcnt;
+	/**
+	 * @nr_maps: number of maps_by_address, and possibly maps_by_name,
+	 * entries that contain maps.
+	 */
+	unsigned int	 nr_maps;
+	/**
+	 * @nr_maps_allocated: number of entries in maps_by_address and possibly
+	 * maps_by_name.
+	 */
+	unsigned int	 nr_maps_allocated;
+	/**
+	 * @last_search_by_name_idx: cache of last found by name entry's index
+	 * as frequent searches for the same dso name are common.
+	 */
+	unsigned int	 last_search_by_name_idx;
+	/** @maps_by_address_sorted: is maps_by_address sorted. */
+	bool		 maps_by_address_sorted;
+	/** @maps_by_name_sorted: is maps_by_name sorted. */
+	bool		 maps_by_name_sorted;
+	/** @ends_broken: does the map contain a map where end values are unset/unsorted? */
+	bool		 ends_broken;
+};
 
 static void check_invariants(const struct maps *maps __maybe_unused)
 {
@@ -103,6 +157,43 @@ static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
 }
 
+struct machine *maps__machine(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->machine;
+}
+
+unsigned int maps__nr_maps(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->nr_maps;
+}
+
+refcount_t *maps__refcnt(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->refcnt;
+}
+
+#ifdef HAVE_LIBUNWIND_SUPPORT
+void *maps__addr_space(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->addr_space;
+}
+
+void maps__set_addr_space(struct maps *maps, void *addr_space)
+{
+	RC_CHK_ACCESS(maps)->addr_space = addr_space;
+}
+
+const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
+}
+
+void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops)
+{
+	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
+}
+#endif
+
 static struct rw_semaphore *maps__lock(struct maps *maps)
 {
 	/*
@@ -440,6 +531,11 @@ bool maps__empty(struct maps *maps)
 	return maps__nr_maps(maps) == 0;
 }
 
+bool maps__equal(struct maps *a, struct maps *b)
+{
+	return RC_CHK_EQUAL(a, b);
+}
+
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data)
 {
 	bool done = false;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index df9dd5a0e3c0..4bcba136ffe5 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -3,80 +3,15 @@
 #define __PERF_MAPS_H
 
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/types.h>
-#include "rwsem.h"
-#include <internal/rc_check.h>
 
 struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
 
-struct map_list_node {
-	struct list_head node;
-	struct map *map;
-};
-
-static inline struct map_list_node *map_list_node__new(void)
-{
-	return malloc(sizeof(struct map_list_node));
-}
-
-/*
- * Locking/sorting note:
- *
- * Sorting is done with the write lock, iteration and binary searching happens
- * under the read lock requiring being sorted. There is a race between sorting
- * releasing the write lock and acquiring the read lock for iteration/searching
- * where another thread could insert and break the sorting of the maps. In
- * practice inserting maps should be rare meaning that the race shouldn't lead
- * to live lock. Removal of maps doesn't break being sorted.
- */
-
-DECLARE_RC_STRUCT(maps) {
-	struct rw_semaphore lock;
-	/**
-	 * @maps_by_address: array of maps sorted by their starting address if
-	 * maps_by_address_sorted is true.
-	 */
-	struct map	 **maps_by_address;
-	/**
-	 * @maps_by_name: optional array of maps sorted by their dso name if
-	 * maps_by_name_sorted is true.
-	 */
-	struct map	 **maps_by_name;
-	struct machine	 *machine;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	void		*addr_space;
-	const struct unwind_libunwind_ops *unwind_libunwind_ops;
-#endif
-	refcount_t	 refcnt;
-	/**
-	 * @nr_maps: number of maps_by_address, and possibly maps_by_name,
-	 * entries that contain maps.
-	 */
-	unsigned int	 nr_maps;
-	/**
-	 * @nr_maps_allocated: number of entries in maps_by_address and possibly
-	 * maps_by_name.
-	 */
-	unsigned int	 nr_maps_allocated;
-	/**
-	 * @last_search_by_name_idx: cache of last found by name entry's index
-	 * as frequent searches for the same dso name are common.
-	 */
-	unsigned int	 last_search_by_name_idx;
-	/** @maps_by_address_sorted: is maps_by_address sorted. */
-	bool		 maps_by_address_sorted;
-	/** @maps_by_name_sorted: is maps_by_name sorted. */
-	bool		 maps_by_name_sorted;
-	/** @ends_broken: does the map contain a map where end values are unset/unsorted? */
-	bool		 ends_broken;
-};
-
 #define KMAP_NAME_LEN 256
 
 struct kmap {
@@ -100,36 +35,22 @@ static inline void __maps__zput(struct maps **map)
 
 #define maps__zput(map) __maps__zput(&map)
 
+bool maps__equal(struct maps *a, struct maps *b);
+
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
 /* Iterate over map removing an entry if cb returns true. */
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
-static inline struct machine *maps__machine(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->machine;
-}
-
-static inline unsigned int maps__nr_maps(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->nr_maps;
-}
-
-static inline refcount_t *maps__refcnt(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->refcnt;
-}
+struct machine *maps__machine(const struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps);
+refcount_t *maps__refcnt(struct maps *maps);
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
-static inline void *maps__addr_space(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->addr_space;
-}
-
-static inline const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
-}
+void *maps__addr_space(const struct maps *maps);
+void maps__set_addr_space(struct maps *maps, void *addr_space);
+const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps);
+void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops);
 #endif
 
 size_t maps__fprintf(struct maps *maps, FILE *fp);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0785a54e832e..35975189999b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -63,6 +63,16 @@ struct symbol_conf symbol_conf = {
 	.res_sample		= 0,
 };
 
+struct map_list_node {
+	struct list_head node;
+	struct map *map;
+};
+
+static struct map_list_node *map_list_node__new(void)
+{
+	return malloc(sizeof(struct map_list_node));
+}
+
 static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__KALLSYMS,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89c47a5098e2..c59ab4d79163 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -383,7 +383,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread__pid(thread) == thread__pid(parent))
 		return thread__prepare_access(thread);
 
-	if (RC_CHK_EQUAL(thread__maps(thread), thread__maps(parent))) {
+	if (maps__equal(thread__maps(thread), thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread__pid(thread), thread__tid(thread),
 			 thread__pid(parent), thread__tid(parent));
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 228f1565bd0b..b69dc3a447db 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -706,7 +706,7 @@ static int _unwind__prepare_access(struct maps *maps)
 {
 	void *addr_space = unw_create_addr_space(&accessors, 0);
 
-	RC_CHK_ACCESS(maps)->addr_space = addr_space;
+	maps__set_addr_space(maps, addr_space);
 	if (!addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 76cd63de80a8..2728eb4f13ea 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -12,11 +12,6 @@ struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
-static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
-{
-	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
-}
-
 int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized)
 {
 	const char *arch;
@@ -60,7 +55,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		return 0;
 	}
 out_register:
-	unwind__register_ops(maps, ops);
+	maps__set_unwind_libunwind_ops(maps, ops);
 
 	err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
 	if (initialized)
-- 
2.43.0.rc2.451.g8631bc7472-goog

