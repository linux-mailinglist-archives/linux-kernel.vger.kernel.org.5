Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CC807DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443136AbjLGBXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443120AbjLGBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:22:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61319AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:46 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3eafe3d17so1066257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911924; x=1702516724; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DScuCVkugRW2aZffCKwUGb5lXhuYLK0ENueq8aB8pho=;
        b=sTzld2YsOSiWNZ9S9WJgCSucDXm4m8gQSaYpzfSgwgFeODK0U8tD2AlLIQxX+YBikC
         HxNsoW5p7Wfs4NHeXIakX2vR2EChEYpW7wd7fJfhyw16US3v8hD9A2udF7ht4wUVrmce
         88OfkgXcnw8LxjOoyPKNWnuQ2JJlZR5e7+M35sXQcehsZZSQ+DflxXwX3pWf+5UHZUsi
         VHsidbJd5aTu8naDMfl17r+/dVb6QET4O2aoVBQsEGDr+tY+1TLf+hBG0pCqUokDAL1i
         N4e8wVEQvkK1yEdUKkD/6N0yitVXCaUr45RWj9vbclPUj8ae/GNwH+tZa0+3kx8+aYaa
         PYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911924; x=1702516724;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DScuCVkugRW2aZffCKwUGb5lXhuYLK0ENueq8aB8pho=;
        b=cW2ZZvUyjUEzNSc1gTf4NpmgH1VDfGTxWvCYPdlrvVIfTsd7SJ1SQbFUd6lskAGfqX
         rdFAs1IOrelCd5UXvFRENCiY0nJyYMOkNNGJQY74BIFpiGHDKq3pQLg2rDmPQ/xlj5cz
         Vj2W05Idr9cR2vif57BD0zg7WPhJnhem0epFu3cxMW3e+JuypFNj4t8rzsLsQwkdRa5C
         aLfcyf8Wh4azMkmbDt6Op3e5ySXRCiNPKkvheu5T5KoJgUBeE1m9VfPAoWSkOtbKP41m
         HtavJ7jTq0e1XaOQlhIzLMN6o7g6VAxzqFsTyfd7/rSHUF4NKQizSK2KE8ALiG1+AiNk
         x7rA==
X-Gm-Message-State: AOJu0YzigEVL06cOqT4f0LhfX+rFgSOEUArfUgkcYak+L+3o1UPL5emX
        MetMtcxFSOVIRyGcj5hI59T8eCJnRAS8
X-Google-Smtp-Source: AGHT+IGe6WA06RQtC0reXcbrGlSjgvHxHswVD4lERrmwe9MsL2GuTqQBTSjt8Cio0tssXvP5fmmnYYOUFDoa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:6902:51:b0:da3:b467:af07 with SMTP id
 m17-20020a056902005100b00da3b467af07mr113227ybh.2.1701911924275; Wed, 06 Dec
 2023 17:18:44 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:07 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-34-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 33/47] perf threads: Move threads to its own files
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

Move threads out of machine and move thread_rb_node into the C
file. This hides the implementation of threads from the rest of the
code allowing for it to be refactored.

Locking discipline is tightened up in this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   8 +-
 tools/perf/util/machine.c             | 287 ++++----------------------
 tools/perf/util/machine.h             |  20 +-
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 244 ++++++++++++++++++++++
 tools/perf/util/threads.h             |  35 ++++
 8 files changed, 325 insertions(+), 278 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 132508ebe125..a10fafa88ad0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -71,6 +71,7 @@ perf-y += ordered-events.o
 perf-y += namespaces.o
 perf-y += comm.o
 perf-y += thread.o
+perf-y += threads.o
 perf-y += thread_map.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 31ff19afc20c..3992c8a9fd96 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -210,7 +210,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 		/* do not update idle comm which contains CPU number */
 		if (pid) {
-			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+			struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
 
 			if (t == NULL)
 				return name;
@@ -302,9 +302,9 @@ int lock_contention_read(struct lock_contention *con)
 		return -1;
 
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
-		struct thread *idle = __machine__findnew_thread(machine,
-								/*pid=*/0,
-								/*tid=*/0);
+		struct thread *idle = machine__findnew_thread(machine,
+							      /*pid=*/0,
+							      /*tid=*/0);
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e072b2115b64..e668a97255f8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -43,9 +43,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock);
-
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
 	return map__dso(machine->vmlinux_map);
@@ -58,35 +55,6 @@ static void dsos__init(struct dsos *dsos)
 	init_rwsem(&dsos->lock);
 }
 
-static void machine__threads_init(struct machine *machine)
-{
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		threads->entries = RB_ROOT_CACHED;
-		init_rwsem(&threads->lock);
-		threads->nr = 0;
-		threads->last_match = NULL;
-	}
-}
-
-static int thread_rb_node__cmp_tid(const void *key, const struct rb_node *nd)
-{
-	int to_find = (int) *((pid_t *)key);
-
-	return to_find - (int)thread__tid(rb_entry(nd, struct thread_rb_node, rb_node)->thread);
-}
-
-static struct thread_rb_node *thread_rb_node__find(const struct thread *th,
-						   struct rb_root *tree)
-{
-	pid_t to_find = thread__tid(th);
-	struct rb_node *nd = rb_find(&to_find, tree, thread_rb_node__cmp_tid);
-
-	return rb_entry(nd, struct thread_rb_node, rb_node);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -120,7 +88,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
 
-	machine__threads_init(machine);
+	threads__init(&machine->threads);
 
 	machine->vdso_info = NULL;
 	machine->env = NULL;
@@ -221,27 +189,11 @@ static void dsos__exit(struct dsos *dsos)
 
 void machine__delete_threads(struct machine *machine)
 {
-	struct rb_node *nd;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		down_write(&threads->lock);
-		nd = rb_first_cached(&threads->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			__machine__remove_thread(machine, trb, trb->thread, false);
-		}
-		up_write(&threads->lock);
-	}
+	threads__remove_all_threads(&machine->threads);
 }
 
 void machine__exit(struct machine *machine)
 {
-	int i;
-
 	if (machine == NULL)
 		return;
 
@@ -254,12 +206,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
 
-	machine__delete_threads(machine);
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-
-		exit_rwsem(&threads->lock);
-	}
+	threads__exit(&machine->threads);
 }
 
 void machine__delete(struct machine *machine)
@@ -526,7 +473,7 @@ static void machine__update_thread_pid(struct machine *machine,
 	if (thread__pid(th) == thread__tid(th))
 		return;
 
-	leader = __machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
+	leader = machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
 	if (!leader)
 		goto out_err;
 
@@ -560,160 +507,55 @@ static void machine__update_thread_pid(struct machine *machine,
 	goto out_put;
 }
 
-/*
- * Front-end cache - TID lookups come in blocks,
- * so most of the time we dont have to look up
- * the full rbtree:
- */
-static struct thread*
-__threads__get_last_match(struct threads *threads, struct machine *machine,
-			  int pid, int tid)
-{
-	struct thread *th;
-
-	th = threads->last_match;
-	if (th != NULL) {
-		if (thread__tid(th) == tid) {
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
-		}
-		thread__put(threads->last_match);
-		threads->last_match = NULL;
-	}
-
-	return NULL;
-}
-
-static struct thread*
-threads__get_last_match(struct threads *threads, struct machine *machine,
-			int pid, int tid)
-{
-	struct thread *th = NULL;
-
-	if (perf_singlethreaded)
-		th = __threads__get_last_match(threads, machine, pid, tid);
-
-	return th;
-}
-
-static void
-__threads__set_last_match(struct threads *threads, struct thread *th)
-{
-	thread__put(threads->last_match);
-	threads->last_match = thread__get(th);
-}
-
-static void
-threads__set_last_match(struct threads *threads, struct thread *th)
-{
-	if (perf_singlethreaded)
-		__threads__set_last_match(threads, th);
-}
-
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
  */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+static struct thread *__machine__findnew_thread(struct machine *machine,
+						pid_t pid,
+						pid_t tid,
+						bool create)
 {
-	struct rb_node **p = &threads->entries.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct thread *th;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
+	struct thread *th = threads__find(&machine->threads, tid);
+	bool created;
 
-	th = threads__get_last_match(threads, machine, pid, tid);
-	if (th)
+	if (th) {
+		machine__update_thread_pid(machine, th, pid);
 		return th;
-
-	while (*p != NULL) {
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			threads__set_last_match(threads, th);
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
 	}
-
 	if (!create)
 		return NULL;
 
-	th = thread__new(pid, tid);
-	if (th == NULL)
-		return NULL;
-
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL) {
-		thread__put(th);
-		return NULL;
-	}
-	nd->thread = th;
-
-	rb_link_node(&nd->rb_node, parent, p);
-	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
-	/*
-	 * We have to initialize maps separately after rb tree is updated.
-	 *
-	 * The reason is that we call machine__findnew_thread within
-	 * thread__init_maps to find the thread leader and that would screwed
-	 * the rb tree.
-	 */
-	if (thread__init_maps(th, machine)) {
-		pr_err("Thread init failed thread %d\n", pid);
-		rb_erase_cached(&nd->rb_node, &threads->entries);
-		RB_CLEAR_NODE(&nd->rb_node);
-		free(nd);
-		thread__put(th);
-		return NULL;
-	}
-	/*
-	 * It is now in the rbtree, get a ref
-	 */
-	threads__set_last_match(threads, th);
-	++threads->nr;
-
-	return thread__get(th);
-}
+	th = threads__findnew(&machine->threads, pid, tid, &created);
+	if (created) {
+		/*
+		 * We have to initialize maps separately after rb tree is
+		 * updated.
+		 *
+		 * The reason is that we call machine__findnew_thread within
+		 * thread__init_maps to find the thread leader and that would
+		 * screwed the rb tree.
+		 */
+		if (thread__init_maps(th, machine)) {
+			pr_err("Thread init failed thread %d\n", pid);
+			threads__remove(&machine->threads, th);
+			thread__put(th);
+			return NULL;
+		}
+	} else
+		machine__update_thread_pid(machine, th, pid);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
-{
-	return ____machine__findnew_thread(machine, machine__threads(machine, tid), pid, tid, true);
+	return th;
 }
 
-struct thread *machine__findnew_thread(struct machine *machine, pid_t pid,
-				       pid_t tid)
+struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_write(&threads->lock);
-	th = __machine__findnew_thread(machine, pid, tid);
-	up_write(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/true);
 }
 
-struct thread *machine__find_thread(struct machine *machine, pid_t pid,
-				    pid_t tid)
+struct thread *machine__find_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_read(&threads->lock);
-	th =  ____machine__findnew_thread(machine, threads, pid, tid, false);
-	up_read(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/false);
 }
 
 /*
@@ -1127,23 +969,13 @@ static int machine_fprintf_cb(struct thread *thread, void *data)
 	return 0;
 }
 
-static size_t machine__threads_nr(const struct machine *machine)
-{
-	size_t nr = 0;
-
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
-		nr += machine->threads[i].nr;
-
-	return nr;
-}
-
 size_t machine__fprintf(struct machine *machine, FILE *fp)
 {
 	struct machine_fprintf_cb_args args = {
 		.fp = fp,
 		.printed = 0,
 	};
-	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
+	size_t ret = fprintf(fp, "Threads: %zu\n", threads__nr(&machine->threads));
 
 	machine__for_each_thread(machine, machine_fprintf_cb, &args);
 	return ret + args.printed;
@@ -2069,36 +1901,9 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock)
-{
-	struct threads *threads = machine__threads(machine, thread__tid(th));
-
-	if (!nd)
-		nd = thread_rb_node__find(th, &threads->entries.rb_root);
-
-	if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th))
-		threads__set_last_match(threads, NULL);
-
-	if (lock)
-		down_write(&threads->lock);
-
-	BUG_ON(refcount_read(thread__refcnt(th)) == 0);
-
-	thread__put(nd->thread);
-	rb_erase_cached(&nd->rb_node, &threads->entries);
-	RB_CLEAR_NODE(&nd->rb_node);
-	--threads->nr;
-
-	free(nd);
-
-	if (lock)
-		up_write(&threads->lock);
-}
-
 void machine__remove_thread(struct machine *machine, struct thread *th)
 {
-	return __machine__remove_thread(machine, NULL, th, true);
+	return threads__remove(&machine->threads, th);
 }
 
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
@@ -3232,23 +3037,7 @@ int machine__for_each_thread(struct machine *machine,
 			     int (*fn)(struct thread *thread, void *p),
 			     void *priv)
 {
-	struct threads *threads;
-	struct rb_node *nd;
-	int rc = 0;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		threads = &machine->threads[i];
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			rc = fn(trb->thread, priv);
-			if (rc != 0)
-				return rc;
-		}
-	}
-	return rc;
+	return threads__for_each_thread(&machine->threads, fn, priv);
 }
 
 int machines__for_each_thread(struct machines *machines,
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b738ce84817b..e28c787616fe 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -7,6 +7,7 @@
 #include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
+#include "threads.h"
 
 struct addr_location;
 struct branch_stack;
@@ -28,16 +29,6 @@ extern const char *ref_reloc_sym_names[];
 
 struct vdso_info;
 
-#define THREADS__TABLE_BITS	8
-#define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
-
-struct threads {
-	struct rb_root_cached  entries;
-	struct rw_semaphore    lock;
-	unsigned int	       nr;
-	struct thread	       *last_match;
-};
-
 struct machine {
 	struct rb_node	  rb_node;
 	pid_t		  pid;
@@ -48,7 +39,7 @@ struct machine {
 	char		  *root_dir;
 	char		  *mmap_name;
 	char		  *kallsyms_filename;
-	struct threads    threads[THREADS__TABLE_SIZE];
+	struct threads    threads;
 	struct vdso_info  *vdso_info;
 	struct perf_env   *env;
 	struct dsos	  dsos;
@@ -69,12 +60,6 @@ struct machine {
 	bool		  trampolines_mapped;
 };
 
-static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
-{
-	/* Cast it to handle tid == -1 */
-	return &machine->threads[(unsigned int)tid % THREADS__TABLE_SIZE];
-}
-
 /*
  * The main kernel (vmlinux) map
  */
@@ -220,7 +205,6 @@ bool machine__is(struct machine *machine, const char *arch);
 bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
 struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c59ab4d79163..1aa8962dcf52 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -26,7 +26,7 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 	if (pid == thread__tid(thread) || pid == -1) {
 		thread__set_maps(thread, maps__new(machine));
 	} else {
-		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
+		struct thread *leader = machine__findnew_thread(machine, pid, pid);
 
 		if (leader) {
 			thread__set_maps(thread, maps__get(thread__maps(leader)));
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 0df775b5c110..4b8f3e9e513b 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -3,7 +3,6 @@
 #define __PERF_THREAD_H
 
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <linux/list.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -30,11 +29,6 @@ struct lbr_stitch {
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 DECLARE_RC_STRUCT(thread) {
 	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
new file mode 100644
index 000000000000..d984ec939c7b
--- /dev/null
+++ b/tools/perf/util/threads.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "threads.h"
+#include "machine.h"
+#include "thread.h"
+
+struct thread_rb_node {
+	struct rb_node rb_node;
+	struct thread *thread;
+};
+
+static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
+{
+	/* Cast it to handle tid == -1 */
+	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
+}
+
+void threads__init(struct threads *threads)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		table->entries = RB_ROOT_CACHED;
+		init_rwsem(&table->lock);
+		table->nr = 0;
+		table->last_match = NULL;
+	}
+}
+
+void threads__exit(struct threads *threads)
+{
+	threads__remove_all_threads(threads);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		exit_rwsem(&table->lock);
+	}
+}
+
+size_t threads__nr(struct threads *threads)
+{
+	size_t nr = 0;
+
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		down_read(&table->lock);
+		nr += table->nr;
+		up_read(&table->lock);
+	}
+	return nr;
+}
+
+/*
+ * Front-end cache - TID lookups come in blocks,
+ * so most of the time we dont have to look up
+ * the full rbtree:
+ */
+static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
+							    pid_t tid)
+{
+	struct thread *th, *res = NULL;
+
+	th = table->last_match;
+	if (th != NULL) {
+		if (thread__tid(th) == tid)
+			res = thread__get(th);
+	}
+	return res;
+}
+
+static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
+						  struct thread *th)
+{
+	thread__put(table->last_match);
+	table->last_match = thread__get(th);
+}
+
+static void threads_table_entry__set_last_match(struct threads_table_entry *table,
+						struct thread *th)
+{
+	down_write(&table->lock);
+	__threads_table_entry__set_last_match(table, th);
+	up_write(&table->lock);
+}
+
+struct thread *threads__find(struct threads *threads, pid_t tid)
+{
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
+	struct thread *res = NULL;
+
+	down_read(&table->lock);
+	res = __threads_table_entry__get_last_match(table, tid);
+	if (res)
+		return res;
+
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
+
+		if (thread__tid(th) == tid) {
+			res = thread__get(th);
+			break;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_read(&table->lock);
+	if (res)
+		threads_table_entry__set_last_match(table, res);
+	return res;
+}
+
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
+{
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct thread *res = NULL;
+	struct thread_rb_node *nd;
+	bool leftmost = true;
+
+	*created = false;
+	down_write(&table->lock);
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct thread *th;
+
+		parent = *p;
+		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
+
+		if (thread__tid(th) == tid) {
+			__threads_table_entry__set_last_match(table, th);
+			res = thread__get(th);
+			goto out_unlock;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else {
+			leftmost = false;
+			p = &(*p)->rb_right;
+		}
+	}
+	nd = malloc(sizeof(*nd));
+	if (nd == NULL)
+		goto out_unlock;
+	res = thread__new(pid, tid);
+	if (!res)
+		free(nd);
+	else {
+		*created = true;
+		nd->thread = thread__get(res);
+		rb_link_node(&nd->rb_node, parent, p);
+		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
+		++table->nr;
+		__threads_table_entry__set_last_match(table, res);
+	}
+out_unlock:
+	up_write(&table->lock);
+	return res;
+}
+
+void threads__remove_all_threads(struct threads *threads)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
+
+		down_write(&table->lock);
+		__threads_table_entry__set_last_match(table, NULL);
+		nd = rb_first_cached(&table->entries);
+		while (nd) {
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+
+			nd = rb_next(nd);
+			thread__put(trb->thread);
+			rb_erase_cached(&trb->rb_node, &table->entries);
+			RB_CLEAR_NODE(&trb->rb_node);
+			--table->nr;
+
+			free(trb);
+		}
+		assert(table->nr == 0);
+		up_write(&table->lock);
+	}
+}
+
+void threads__remove(struct threads *threads, struct thread *thread)
+{
+	struct rb_node **p;
+	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
+	pid_t tid = thread__tid(thread);
+
+	down_write(&table->lock);
+	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
+		__threads_table_entry__set_last_match(table, NULL);
+
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
+		struct thread *th = nd->thread;
+
+		if (RC_CHK_EQUAL(th, thread)) {
+			thread__put(nd->thread);
+			rb_erase_cached(&nd->rb_node, &table->entries);
+			RB_CLEAR_NODE(&nd->rb_node);
+			--table->nr;
+			free(nd);
+			break;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_write(&table->lock);
+}
+
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
+
+		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+			int rc = fn(trb->thread, data);
+
+			if (rc != 0)
+				return rc;
+		}
+	}
+	return 0;
+
+}
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
new file mode 100644
index 000000000000..ed67de627578
--- /dev/null
+++ b/tools/perf/util/threads.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_THREADS_H
+#define __PERF_THREADS_H
+
+#include <linux/rbtree.h>
+#include "rwsem.h"
+
+struct thread;
+
+#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
+
+struct threads_table_entry {
+	struct rb_root_cached  entries;
+	struct rw_semaphore    lock;
+	unsigned int	       nr;
+	struct thread	       *last_match;
+};
+
+struct threads {
+	struct threads_table_entry table[THREADS__TABLE_SIZE];
+};
+
+void threads__init(struct threads *threads);
+void threads__exit(struct threads *threads);
+size_t threads__nr(struct threads *threads);
+struct thread *threads__find(struct threads *threads, pid_t tid);
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created);
+void threads__remove_all_threads(struct threads *threads);
+void threads__remove(struct threads *threads, struct thread *thread);
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data);
+
+#endif	/* __PERF_THREADS_H */
-- 
2.43.0.rc2.451.g8631bc7472-goog

