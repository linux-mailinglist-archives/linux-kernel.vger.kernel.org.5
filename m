Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5D7FAD27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjK0WOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjK0WNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:13:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8731FEE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03390793fso5286723276.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123051; x=1701727851; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZ+J0FhVymjq7UIXBxYu7T5YYWLZjb28QjsTWHaCUzM=;
        b=yupamZkvENCGnBYeTspRpey3vv4M1/rC/1iuKWiRcvybOmstjBEUbHju59oYj1ul8v
         WZ/GayagbKw7GA3SNMvmJB1fHKwXvhfOdsVD65UIp/M6Qu+WgBBc3XqIA0bb1gwuuaeM
         MOfhHma98VkB4kfyqNrrSFlCjmCAbMS/TiK5VbmJLIjR/X0cO1iwcIZd/J8eZZ8mmXCM
         XTl8tm55vsSGs5u8ruxQUxEO3ShJ3QpHd7elW6Hnntlm6VBIyUnOGZvtqAqBtldyqTId
         TorYqw9tnngRCxpMqlgDLiwc8zEZvDSGakDaueSeOXtJgtc+0sdewYZaMK0i9HgF4Ix1
         s55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123051; x=1701727851;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ+J0FhVymjq7UIXBxYu7T5YYWLZjb28QjsTWHaCUzM=;
        b=menWtf3GwEvwy3BdEG/vOIpnybGWT2qXORZ4swbINL9zkocNtRQ+K57TzG2ZUE2WjW
         cVsWCBDbf92g0Ig18rdfF+vYyEWSqShH4/u28jF7t3deT1Br9rSbCaxKC8K0QYNVHXOn
         hKc47FGxzYdTUqUsLCLkvqPMqpAgYUyu48Tygo82lC6FhUYPXDM0hNCJs1e6hwc/sAin
         I3UZWaFAReikYFeSzDjX2zNpZBf1wqeKxouNdhZSYoAnohdSupN3CI8TJwNE2oiFDbmg
         7YFntkm8eyAGJqG7nud/4caIQXtQ41EDq71y1wd5/GVGNfjUS7bBs/zzDLKElRA/YWYx
         cf8A==
X-Gm-Message-State: AOJu0Yx9WlBIfVKMLsqnLIfNawBAbo4LgGionyfxiEHDcWEulpl7XTns
        bXpfZ7LYNzb00W/rbyXrvIKcb1lZtBQ4
X-Google-Smtp-Source: AGHT+IEDuj2ifwWD3RUBOczIgLtLpkU2FwjAtujeHGTKHVS3xJwXtsTYzXW7mth96snrR1TWExgPC9LBEk3O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:3045:0:b0:dae:49a3:ae23 with SMTP id
 w66-20020a253045000000b00dae49a3ae23mr382280ybw.7.1701123051035; Mon, 27 Nov
 2023 14:10:51 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:50 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-39-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 38/50] perf dsos: Attempt to better abstract dsos internals
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

Move functions from machine and build-id to dsos. Pass dsos struct
rather than internal state. Rename some functions to better represent
which data structure they operate on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/build-id.c  | 38 +---------------------------
 tools/perf/util/build-id.h  |  2 --
 tools/perf/util/dso.h       |  6 -----
 tools/perf/util/dsos.c      | 49 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/dsos.h      | 19 +++++++++++---
 tools/perf/util/machine.c   | 40 ++++++------------------------
 tools/perf/util/machine.h   |  2 ++
 tools/perf/util/session.c   | 21 ++++++++++++++++
 tools/perf/util/session.h   |  2 ++
 11 files changed, 97 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index eb3ef5c24b66..ef73317e6ae7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2122,7 +2122,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		 */
 		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
 		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
-			dsos__hit_all(session);
+			perf_session__dsos_hit_all(session);
 		/*
 		 * The AUX areas have been removed and replaced with
 		 * synthesized hardware events, so clear the feature flag.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b6c8c1371b39..53653f21b52c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1787,7 +1787,7 @@ record__finish_output(struct record *rec)
 		process_buildids(rec);
 
 		if (rec->buildid_all)
-			dsos__hit_all(rec->session);
+			perf_session__dsos_hit_all(rec->session);
 	}
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 03c64b85383b..a617b1917e6b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -390,42 +390,6 @@ int perf_session__write_buildid_table(struct perf_session *session,
 	return err;
 }
 
-static int __dsos__hit_all(struct list_head *head)
-{
-	struct dso *pos;
-
-	list_for_each_entry(pos, head, node)
-		pos->hit = true;
-
-	return 0;
-}
-
-static int machine__hit_all_dsos(struct machine *machine)
-{
-	return __dsos__hit_all(&machine->dsos.head);
-}
-
-int dsos__hit_all(struct perf_session *session)
-{
-	struct rb_node *nd;
-	int err;
-
-	err = machine__hit_all_dsos(&session->machines.host);
-	if (err)
-		return err;
-
-	for (nd = rb_first_cached(&session->machines.guests); nd;
-	     nd = rb_next(nd)) {
-		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-
-		err = machine__hit_all_dsos(pos);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 void disable_buildid_cache(void)
 {
 	no_buildid_cache = true;
@@ -992,7 +956,7 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
 {
-	return __dsos__read_build_ids(&machine->dsos.head, with_hits);
+	return __dsos__read_build_ids(&machine->dsos, with_hits);
 }
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 4e3a1169379b..3fa8bffb07ca 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -39,8 +39,6 @@ int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct evsel *evsel,
 			   struct machine *machine);
 
-int dsos__hit_all(struct perf_session *session);
-
 int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 			       struct perf_sample *sample, struct evsel *evsel,
 			       struct machine *machine);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 8bdc17d78b02..8b45dbdae776 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -230,12 +230,6 @@ struct dso {
 #define dso__for_each_symbol(dso, pos, n)	\
 	symbols__for_each_entry(&(dso)->symbols, pos, n)
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 static inline void dso__set_loaded(struct dso *dso)
 {
 	dso->loaded = true;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cf80aa42dd07..e65ef6762bed 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,35 @@
 #include <symbol.h> // filename__read_build_id
 #include <unistd.h>
 
+void dsos__init(struct dsos *dsos)
+{
+	INIT_LIST_HEAD(&dsos->head);
+	dsos->root = RB_ROOT;
+	init_rwsem(&dsos->lock);
+}
+
+static void dsos__purge(struct dsos *dsos)
+{
+	struct dso *pos, *n;
+
+	down_write(&dsos->lock);
+
+	list_for_each_entry_safe(pos, n, &dsos->head, node) {
+		RB_CLEAR_NODE(&pos->rb_node);
+		pos->root = NULL;
+		list_del_init(&pos->node);
+		dso__put(pos);
+	}
+
+	up_write(&dsos->lock);
+}
+
+void dsos__exit(struct dsos *dsos)
+{
+	dsos__purge(dsos);
+	exit_rwsem(&dsos->lock);
+}
+
 static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
 	if (a->maj > b->maj) return -1;
@@ -73,8 +102,9 @@ int dso__cmp_id(struct dso *a, struct dso *b)
 	return __dso_id__cmp(&a->id, &b->id);
 }
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
+	struct list_head *head = &dsos->head;
 	bool have_build_id = false;
 	struct dso *pos;
 	struct nscookie nsc;
@@ -303,9 +333,10 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 	return dso;
 }
 
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -320,8 +351,9 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
 	return ret;
 }
 
-size_t __dsos__fprintf(struct list_head *head, FILE *fp)
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -331,3 +363,14 @@ size_t __dsos__fprintf(struct list_head *head, FILE *fp)
 
 	return ret;
 }
+
+int __dsos__hit_all(struct dsos *dsos)
+{
+	struct list_head *head = &dsos->head;
+	struct dso *pos;
+
+	list_for_each_entry(pos, head, node)
+		pos->hit = true;
+
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 5dbec2bc6966..1c81ddf07f8f 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -21,6 +21,15 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
+#define dsos__for_each_with_build_id(pos, head)	\
+	list_for_each_entry(pos, head, node)	\
+		if (!pos->has_build_id)		\
+			continue;		\
+		else
+
+void dsos__init(struct dsos *dsos);
+void dsos__exit(struct dsos *dsos);
+
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
@@ -28,13 +37,15 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits);
+
 struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
 						const char *name, struct dso_id *id);
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
-
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct list_head *head, FILE *fp);
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
+
+int __dsos__hit_all(struct dsos *dsos);
 
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 36231b5a86aa..a0abfba90962 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -49,13 +49,6 @@ static struct dso *machine__kernel_dso(struct machine *machine)
 	return map__dso(machine->vmlinux_map);
 }
 
-static void dsos__init(struct dsos *dsos)
-{
-	INIT_LIST_HEAD(&dsos->head);
-	dsos->root = RB_ROOT;
-	init_rwsem(&dsos->lock);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -166,28 +159,6 @@ struct machine *machine__new_kallsyms(void)
 	return machine;
 }
 
-static void dsos__purge(struct dsos *dsos)
-{
-	struct dso *pos, *n;
-
-	down_write(&dsos->lock);
-
-	list_for_each_entry_safe(pos, n, &dsos->head, node) {
-		RB_CLEAR_NODE(&pos->rb_node);
-		pos->root = NULL;
-		list_del_init(&pos->node);
-		dso__put(pos);
-	}
-
-	up_write(&dsos->lock);
-}
-
-static void dsos__exit(struct dsos *dsos)
-{
-	dsos__purge(dsos);
-	exit_rwsem(&dsos->lock);
-}
-
 void machine__delete_threads(struct machine *machine)
 {
 	threads__remove_all_threads(&machine->threads);
@@ -907,11 +878,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = __dsos__fprintf(&machines->host.dsos.head, fp);
+	size_t ret = __dsos__fprintf(&machines->host.dsos, fp);
 
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret += __dsos__fprintf(&pos->dsos.head, fp);
+		ret += __dsos__fprintf(&pos->dsos, fp);
 	}
 
 	return ret;
@@ -920,7 +891,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 size_t machine__fprintf_dsos_buildid(struct machine *m, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm)
 {
-	return __dsos__fprintf_buildid(&m->dsos.head, fp, skip, parm);
+	return __dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
 }
 
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
@@ -3278,3 +3249,8 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 	return false;
 }
+
+int machine__hit_all_dsos(struct machine *machine)
+{
+	return __dsos__hit_all(&machine->dsos);
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index e28c787616fe..05927aa3e813 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -306,4 +306,6 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 int machine__resolve(struct machine *machine, struct addr_location *al,
 		     struct perf_sample *sample);
 
+int machine__hit_all_dsos(struct machine *machine);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 199d3e8df315..e7b5d360a212 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2906,3 +2906,24 @@ int perf_event__process_id_index(struct perf_session *session,
 	}
 	return 0;
 }
+
+int perf_session__dsos_hit_all(struct perf_session *session)
+{
+	struct rb_node *nd;
+	int err;
+
+	err = machine__hit_all_dsos(&session->machines.host);
+	if (err)
+		return err;
+
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		err = machine__hit_all_dsos(pos);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ee3715e8563b..25c0d6c9cac9 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -154,6 +154,8 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
 
+int perf_session__dsos_hit_all(struct perf_session *session);
+
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event);
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

