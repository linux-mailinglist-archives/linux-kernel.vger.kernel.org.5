Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E97FAD24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjK0WN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjK0WNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:13:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC91FD0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cfd2325a06so25319297b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123046; x=1701727846; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaMvGQIwm952jjWrCT4ml8Z5CScyNCbVZIlwZUsveHY=;
        b=ywACG4KMs88cV+79pEgY2uXws6Euw7Nivo1JVrOcvGlIKuI7FxhGkjWHa4qWY5jyL6
         Dz/9S3/DzsRpb/uBVVBC4VIprncInyvdgZ9SwI9cZGx3C9qojpwe1JmbqhIWuxM0z4pf
         hRDyCJ5b1qcsV+I800vcHp2Qj9L138inb3OJJsCjwsLvp4BgUAk2y6HWCAcJQLF+CTc+
         y4Rq1WWbAzAwhFHb0tt6q7OBJh7Dx4Wx1A58NMn7z9jSr5sf6hCzU0LDVija7igzjwSb
         NbpNNtLtbKhbQ8v/cUnSqGfbQUbGezECm+9OHiiR5cNpd47OGsMk4yHc9ZX+m+wtHvH6
         pzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123046; x=1701727846;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaMvGQIwm952jjWrCT4ml8Z5CScyNCbVZIlwZUsveHY=;
        b=Uq1XV0UTaR6x5BqnGeAK6CcfniJvdZFELvgSWUpzXnN+785tQA2Y34BaWVZvxXDBnZ
         rdEhaLSL6EY4UyPkvOQ+AtcgrpvVrhWrwDrHDCh4Ykt2kcchTXhLIRrgZmOihX86noxN
         1TBow03ZJTtSVaBrmAV4VKTqUxluuJIPuP6qNZ1A9QE8vX43Mo4EjxQFQEe6bRUY2YbF
         OkhDQE8eqTIWX0KxDWULHPDQuLqdlP3Jht7DrSKo3v2qLdYQwUWcH1X/y8ZnisWRYO18
         IH9san6kBfmqqaPF/uyyvnH5zofxziksH/odMHJjLacfMhJm5I55oRSWDyMmoGbRRgFJ
         R8gw==
X-Gm-Message-State: AOJu0YyGJXgwYFLNPhmvXBv1ZFeNkn9JWplaH8BgQOABqw+nM1f93APQ
        13R2CK1h+RuiGFstSsPmnpxSCUyWZucl
X-Google-Smtp-Source: AGHT+IFAm1HXp+h/967s2xgHudQu1AnZOIoJDXbUhGY2ujJKKHQkk0EH9mNMrPYCM0Fvp72b885dHCsCa6Jp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:3301:b0:5c9:6d54:de9e with SMTP
 id fj1-20020a05690c330100b005c96d54de9emr400964ywb.10.1701123046429; Mon, 27
 Nov 2023 14:10:46 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:48 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-37-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 36/50] perf threads: Switch from rbtree to hashmap
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

The rbtree provides a sorting on entries but this is unused. Switch to
using hashmap for O(1) rather than O(log n) find/insert/remove
complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 146 ++++++++++++--------------------------
 tools/perf/util/threads.h |   6 +-
 2 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index d984ec939c7b..55923be53180 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -3,25 +3,30 @@
 #include "machine.h"
 #include "thread.h"
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
 {
 	/* Cast it to handle tid == -1 */
 	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
 }
 
+static size_t key_hash(long key, void *ctx __maybe_unused)
+{
+	/* The table lookup removes low bit entropy, but this is just ignored here. */
+	return key;
+}
+
+static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 void threads__init(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		table->entries = RB_ROOT_CACHED;
+		hashmap__init(&table->shard, key_hash, key_equal, NULL);
 		init_rwsem(&table->lock);
-		table->nr = 0;
 		table->last_match = NULL;
 	}
 }
@@ -32,6 +37,7 @@ void threads__exit(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
+		hashmap__clear(&table->shard);
 		exit_rwsem(&table->lock);
 	}
 }
@@ -44,7 +50,7 @@ size_t threads__nr(struct threads *threads)
 		struct threads_table_entry *table = &threads->table[i];
 
 		down_read(&table->lock);
-		nr += table->nr;
+		nr += hashmap__size(&table->shard);
 		up_read(&table->lock);
 	}
 	return nr;
@@ -86,28 +92,13 @@ static void threads_table_entry__set_last_match(struct threads_table_entry *tabl
 struct thread *threads__find(struct threads *threads, pid_t tid)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct thread *res = NULL;
+	struct thread *res;
 
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
-	if (res)
-		return res;
-
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			res = thread__get(th);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	if (!res) {
+		if (hashmap__find(&table->shard, tid, &res))
+			res = thread__get(res);
 	}
 	up_read(&table->lock);
 	if (res)
@@ -118,49 +109,25 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
 	struct thread *res = NULL;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
 
 	*created = false;
 	down_write(&table->lock);
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct thread *th;
-
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			__threads_table_entry__set_last_match(table, th);
-			res = thread__get(th);
-			goto out_unlock;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			leftmost = false;
-			p = &(*p)->rb_right;
-		}
-	}
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL)
-		goto out_unlock;
 	res = thread__new(pid, tid);
-	if (!res)
-		free(nd);
-	else {
-		*created = true;
-		nd->thread = thread__get(res);
-		rb_link_node(&nd->rb_node, parent, p);
-		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
-		++table->nr;
-		__threads_table_entry__set_last_match(table, res);
+	if (res) {
+		if (hashmap__add(&table->shard, tid, res)) {
+			/* Add failed. Assume a race so find other entry. */
+			thread__put(res);
+			res = NULL;
+			if (hashmap__find(&table->shard, tid, &res))
+				res = thread__get(res);
+		} else {
+			res = thread__get(res);
+			*created = true;
+		}
+		if (res)
+			__threads_table_entry__set_last_match(table, res);
 	}
-out_unlock:
 	up_write(&table->lock);
 	return res;
 }
@@ -169,57 +136,32 @@ void threads__remove_all_threads(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur, *tmp;
+		size_t bkt;
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		nd = rb_first_cached(&table->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			thread__put(trb->thread);
-			rb_erase_cached(&trb->rb_node, &table->entries);
-			RB_CLEAR_NODE(&trb->rb_node);
-			--table->nr;
+		hashmap__for_each_entry_safe((&table->shard), cur, tmp, bkt) {
+			struct thread *old_value;
 
-			free(trb);
+			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
+			thread__put(old_value);
 		}
-		assert(table->nr == 0);
 		up_write(&table->lock);
 	}
 }
 
 void threads__remove(struct threads *threads, struct thread *thread)
 {
-	struct rb_node **p;
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	pid_t tid = thread__tid(thread);
+	struct thread *old_value;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
-		struct thread *th = nd->thread;
-
-		if (RC_CHK_EQUAL(th, thread)) {
-			thread__put(nd->thread);
-			rb_erase_cached(&nd->rb_node, &table->entries);
-			RB_CLEAR_NODE(&nd->rb_node);
-			--table->nr;
-			free(nd);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
+	thread__put(old_value);
 	up_write(&table->lock);
 }
 
@@ -229,11 +171,11 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur;
+		size_t bkt;
 
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
+		hashmap__for_each_entry((&table->shard), cur, bkt) {
+			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0)
 				return rc;
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index ed67de627578..d03bd91a7769 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_THREADS_H
 #define __PERF_THREADS_H
 
-#include <linux/rbtree.h>
+#include "hashmap.h"
 #include "rwsem.h"
 
 struct thread;
@@ -11,9 +11,9 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	struct rb_root_cached  entries;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	unsigned int	       nr;
 	struct thread	       *last_match;
 };
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

