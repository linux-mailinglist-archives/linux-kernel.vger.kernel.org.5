Return-Path: <linux-kernel+bounces-87934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D286DB31
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A775283776
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF25476B;
	Fri,  1 Mar 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roPXcHyq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C453807
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271426; cv=none; b=QZyDqIpac+cjjhlrvXGuYxeOKK9KutgU5Mz6kZI8lR8QLBsMNKcBKeSb0r4CTgp7Jg30OiK8QNdXIHBzvdD5nOZ/Exb/Mjzhk+EXgO40HeEHwtDGMrFEUgl9ajNqMu41MA8M0jlglF6CMPqzhw4Ds5YCoDvnhjQqUc/gBdajQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271426; c=relaxed/simple;
	bh=aOKvNCw0mP/aSzwrAr6tjIXHYZ6WOqSdyo+aZpChxCA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QMGyKrckwudfKh9C0coZYunaWAY1DKoO60Q/YMXFMUlw1chHZvwzE9j/2Bsh7NYYILt8yzoDgXm0zVI/wxlO15XPJ9xxWY/+yI+V5+FaPMO96U+f2dNzbwO0XfbsL7LnleOsUcMKBnS0y0gFeIVCF00yeG80TS2LuOfdDulF60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roPXcHyq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6093f75fc81so31046637b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271423; x=1709876223; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROSXDwUomvqQuML9PMkfq2AQvT85kKoIeIu9nBJaVks=;
        b=roPXcHyqgy8Gk6nnFgvnnRHDuYdbOT9ZL4WhuO3V+sUOYDZCBsVHyn0rE4XLrt30XH
         9gT3Dh2Ya8OP+jBsgjeVbDqinInIOXajpjMrDggRRue0mNvuU6m37V9afQwHemaRSPcP
         DU7YSE1NbXqA00uXJ2wMX6zSnatmseXQ/ym7KAfIosa4z0D5v4PUMT6UwcmQp1A0qRNZ
         RD7Q/XVrRnBuYE3BojWXQDZ3gKzv3e3tFz/JwmeiWNNo56c8E63jPlsXioU48j7rFGdk
         uF5yOR2bU/P5gwOkc2/e7wZ/Z5Fvj2IDj7YHrkWPLpnqfDn11+NIcNlVSLkbVLxRDNyU
         tpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271423; x=1709876223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROSXDwUomvqQuML9PMkfq2AQvT85kKoIeIu9nBJaVks=;
        b=m+gf5Xzvmisp9XINGfz3Zhdf1ay05UorYF6zXittuPx3UxIE3x+mjvAWn3N/XSsxOd
         0mTHMZGmYBd3q+u90dp6lLEHRU+aR6+2Q+yG/KUsYeNgTf8yW4GBsF4WkMxhRy9EFpw/
         iPJgsbPbeocVNLOIqEBxXlVNegHWCZp1nLHynetDCzZ1vksYdm3X+fBKRof8ZoIAbEOc
         yP1FcTrlToAw8Be509ZVNnHpKtLvouebwE5VphC1xIubLT2jWH+3BXMMNtfzxRKyjpkb
         38rY1QOLp7Ctiy3exFYBIyjQvME7V9mtL4/MfOTFPyhpXzP2ryCHt/b83fbwRdHJU1WM
         8cQw==
X-Forwarded-Encrypted: i=1; AJvYcCVOoWbDt1UxcZuXyiRL3DlQT9fOdEryuo4xoC3vMaktrjvfqkCTSANWjwA6h82syKKYRaxDhAub3Cay83fbDGpWV7xG22PYEVcg3tGO
X-Gm-Message-State: AOJu0YwFQtMkVkxKtMVVOEdmPDyFQen4EhShACExMBvpOzOglg0fGqpr
	GDPrjChglPbZ1YwmGbEVSsDxhp5DgTY6R2f2XhRIqlvlqQ+p5LVKGWWdCN1wmmWIsRiwc6OsSC1
	ONC2FIA==
X-Google-Smtp-Source: AGHT+IHzQdeM1X0crAbAfCGu8ncW89Nm1yPNhZsTC2Nfd9aa23Z5xJAhmN2erL3pTCl9ayhj96utvGNJOn0J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c86:b0:608:ce23:638c with SMTP id
 cm6-20020a05690c0c8600b00608ce23638cmr174942ywb.4.1709271423168; Thu, 29 Feb
 2024 21:37:03 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:43 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 5/7] perf threads: Move threads to its own files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move threads out of machine and into its own file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/machine.c | 248 --------------------------------------
 tools/perf/util/machine.h |  26 +---
 tools/perf/util/threads.c | 248 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/threads.h |  35 ++++++
 5 files changed, 285 insertions(+), 273 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2cbeeb79b6ef..e0a723e24503 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -72,6 +72,7 @@ perf-y += ordered-events.o
 perf-y += namespaces.o
 perf-y += comm.o
 perf-y += thread.o
+perf-y += threads.o
 perf-y += thread_map.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 224b53b4bfe2..527517db3182 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -43,17 +43,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
-static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
-{
-	/* Cast it to handle tid == -1 */
-	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
-}
-
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
 	return map__dso(machine->vmlinux_map);
@@ -66,18 +55,6 @@ static void dsos__init(struct dsos *dsos)
 	init_rwsem(&dsos->lock);
 }
 
-void threads__init(struct threads *threads)
-{
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads_table_entry *table = &threads->table[i];
-
-		table->entries = RB_ROOT_CACHED;
-		init_rwsem(&table->lock);
-		table->nr = 0;
-		table->last_match = NULL;
-	}
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -210,49 +187,11 @@ static void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
-						  struct thread *th);
-
-void threads__remove_all_threads(struct threads *threads)
-{
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
-
-		down_write(&table->lock);
-		__threads_table_entry__set_last_match(table, NULL);
-		nd = rb_first_cached(&table->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			thread__put(trb->thread);
-			rb_erase_cached(&trb->rb_node, &table->entries);
-			RB_CLEAR_NODE(&trb->rb_node);
-			--table->nr;
-
-			free(trb);
-		}
-		assert(table->nr == 0);
-		up_write(&table->lock);
-	}
-}
-
 void machine__delete_threads(struct machine *machine)
 {
 	threads__remove_all_threads(&machine->threads);
 }
 
-void threads__exit(struct threads *threads)
-{
-	threads__remove_all_threads(threads);
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads_table_entry *table = &threads->table[i];
-
-		exit_rwsem(&table->lock);
-	}
-}
-
 void machine__exit(struct machine *machine)
 {
 	if (machine == NULL)
@@ -568,121 +507,6 @@ static void machine__update_thread_pid(struct machine *machine,
 	goto out_put;
 }
 
-/*
- * Front-end cache - TID lookups come in blocks,
- * so most of the time we dont have to look up
- * the full rbtree:
- */
-static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
-							    pid_t tid)
-{
-	struct thread *th, *res = NULL;
-
-	th = table->last_match;
-	if (th != NULL) {
-		if (thread__tid(th) == tid)
-			res = thread__get(th);
-	}
-	return res;
-}
-
-static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
-						  struct thread *th)
-{
-	thread__put(table->last_match);
-	table->last_match = thread__get(th);
-}
-
-static void threads_table_entry__set_last_match(struct threads_table_entry *table,
-						struct thread *th)
-{
-	down_write(&table->lock);
-	__threads_table_entry__set_last_match(table, th);
-	up_write(&table->lock);
-}
-
-struct thread *threads__find(struct threads *threads, pid_t tid)
-{
-	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct thread *res = NULL;
-
-	down_read(&table->lock);
-	res = __threads_table_entry__get_last_match(table, tid);
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
-	}
-	up_read(&table->lock);
-	if (res)
-		threads_table_entry__set_last_match(table, res);
-	return res;
-}
-
-struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
-{
-	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct thread *res = NULL;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
-
-	*created = false;
-	down_write(&table->lock);
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
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL)
-		goto out_unlock;
-	res = thread__new(pid, tid);
-	if (!res)
-		free(nd);
-	else {
-		*created = true;
-		nd->thread = thread__get(res);
-		rb_link_node(&nd->rb_node, parent, p);
-		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
-		++table->nr;
-		__threads_table_entry__set_last_match(table, res);
-	}
-out_unlock:
-	up_write(&table->lock);
-	return res;
-}
-
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
@@ -699,7 +523,6 @@ static struct thread *__machine__findnew_thread(struct machine *machine,
 		machine__update_thread_pid(machine, th, pid);
 		return th;
 	}
-
 	if (!create)
 		return NULL;
 
@@ -1147,20 +970,6 @@ static int machine_fprintf_cb(struct thread *thread, void *data)
 	return 0;
 }
 
-size_t threads__nr(struct threads *threads)
-{
-	size_t nr = 0;
-
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads_table_entry *table = &threads->table[i];
-
-		down_read(&table->lock);
-		nr += table->nr;
-		up_read(&table->lock);
-	}
-	return nr;
-}
-
 size_t machine__fprintf(struct machine *machine, FILE *fp)
 {
 	struct machine_fprintf_cb_args args = {
@@ -2093,39 +1902,6 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
-void threads__remove(struct threads *threads, struct thread *thread)
-{
-	struct rb_node **p;
-	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	pid_t tid = thread__tid(thread);
-
-	down_write(&table->lock);
-	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
-		__threads_table_entry__set_last_match(table, NULL);
-
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
-	up_write(&table->lock);
-}
-
 void machine__remove_thread(struct machine *machine, struct thread *th)
 {
 	return threads__remove(&machine->threads, th);
@@ -3258,30 +3034,6 @@ int thread__resolve_callchain(struct thread *thread,
 	return ret;
 }
 
-int threads__for_each_thread(struct threads *threads,
-			     int (*fn)(struct thread *thread, void *data),
-			     void *data)
-{
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
-
-		down_read(&table->lock);
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
-
-			if (rc != 0) {
-				up_read(&table->lock);
-				return rc;
-			}
-		}
-		up_read(&table->lock);
-	}
-	return 0;
-
-}
-
 int machine__for_each_thread(struct machine *machine,
 			     int (*fn)(struct thread *thread, void *p),
 			     void *priv)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 5b425b70140e..e28c787616fe 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -7,6 +7,7 @@
 #include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
+#include "threads.h"
 
 struct addr_location;
 struct branch_stack;
@@ -28,31 +29,6 @@ extern const char *ref_reloc_sym_names[];
 
 struct vdso_info;
 
-#define THREADS__TABLE_BITS	8
-#define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
-
-struct threads_table_entry {
-	struct rb_root_cached  entries;
-	struct rw_semaphore    lock;
-	unsigned int	       nr;
-	struct thread	       *last_match;
-};
-
-struct threads {
-	struct threads_table_entry table[THREADS__TABLE_SIZE];
-};
-
-void threads__init(struct threads *threads);
-void threads__exit(struct threads *threads);
-size_t threads__nr(struct threads *threads);
-struct thread *threads__find(struct threads *threads, pid_t tid);
-struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created);
-void threads__remove_all_threads(struct threads *threads);
-void threads__remove(struct threads *threads, struct thread *thread);
-int threads__for_each_thread(struct threads *threads,
-			     int (*fn)(struct thread *thread, void *data),
-			     void *data);
-
 struct machine {
 	struct rb_node	  rb_node;
 	pid_t		  pid;
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
new file mode 100644
index 000000000000..db52d233c2de
--- /dev/null
+++ b/tools/perf/util/threads.c
@@ -0,0 +1,248 @@
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
+		down_read(&table->lock);
+		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+			int rc = fn(trb->thread, data);
+
+			if (rc != 0) {
+				up_read(&table->lock);
+				return rc;
+			}
+		}
+		up_read(&table->lock);
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
2.44.0.278.ge034bb2e1d-goog


