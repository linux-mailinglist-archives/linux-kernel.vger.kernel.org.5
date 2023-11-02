Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4E7DF97B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjKBSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjKBSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:04:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523B10C8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0631f977bso1489180276.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947979; x=1699552779; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYLNUTtd8dvo+GCdvXg7ejQy1XDzoD4f5hK9J1ErhWM=;
        b=ezqVLUYyKkbiqbl//et0/p3Ic9v3EYtgpjvs8YFUAgW7HD+3wYddoHFOdJ9NYVPWmH
         g6y5cC+FVsCRBtqFqC+Lem0m8wa5IjPCMCjTvXHnD7NpL2nmznwvLyGAwxC+RhM//jQq
         forNZv6XRcmgdl3SrdHnp3WsZbh6sWGapAAjK7TD07isAeES74komhfVp7KfAXiROybK
         q3u+sLgQ3v1DdxGs+tRIGtQH+Npf4P+lUkYqg+I9heJs+bvPeHDTJOcZAVEDTKms2YLZ
         IluVoMxkW7TBH0gXKMnB0TmLcb684RjXOTDarQIO6bV+4j3AtZV4yPnkdYnm4VkPdSlj
         GOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947979; x=1699552779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYLNUTtd8dvo+GCdvXg7ejQy1XDzoD4f5hK9J1ErhWM=;
        b=kLunZAlpcBIONNWMMhHczBtxH7s4GUWBWKbSxBpIZEru7cCeyulgs5I+5YNyiV9dAM
         RNWbx7rjfzeXEnE1gilFVhtYspQA9gVvyA5YTuUSoS8DhT7Z9dKKvIKF/Ezzr+YRJ1Ob
         gyp0wKWYBg6czIi8mu2DgORovOwY6x/rzEvcHt+wzne/BmqN50lQQdoyHjJNxL/VIaNF
         tz1RFL3ePvIeL0nqhlEIU47sAmZdfoACTxHArdoFLdzVKKmgJSCjbt7QiojRcZ4EcRYP
         JsNy4vGlpIfd8w29HaJeWJNvi+roiOLi3TmAwOtJKufxWsvUi/LAopTSmr0SDkh9FQho
         dvYQ==
X-Gm-Message-State: AOJu0Yxcn6j9STqP9TXDy++YeV7buCaxBvYrPCc+ID1Zpm8NBKtPPd5H
        TRI89hvnM2t9Jye9RMqEPV6OMJBXXKTm
X-Google-Smtp-Source: AGHT+IHoALrsESqPlPrvJrEknZj/yIyHVUo48Ay3jJUtHNcmdvSaxFpVJEbQEWTSEW7hfr2bRm0e0L8YRJ8R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:d449:0:b0:da0:cea9:2b3d with SMTP id
 m70-20020a25d449000000b00da0cea92b3dmr409653ybf.8.1698947979568; Thu, 02 Nov
 2023 10:59:39 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:27 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-46-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 45/53] perf dsos: Switch more loops to dsos__for_each_dso
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
        linux-perf-users@vger.kernel.org
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

Switch loops within dsos.c, add a version that isn't locked. Switch
some unlocked loops to hold the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c |   2 +-
 tools/perf/util/dsos.c     | 258 ++++++++++++++++++++++++-------------
 tools/perf/util/dsos.h     |   8 +-
 tools/perf/util/machine.c  |   8 +-
 4 files changed, 174 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a6d3c253f19f..864bc26b6b46 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -964,7 +964,7 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
 {
-	return __dsos__read_build_ids(&machine->dsos, with_hits);
+	return dsos__read_build_ids(&machine->dsos, with_hits);
 }
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index f816927a21ff..b7fbfb877ae3 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,38 +41,65 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
+
+static int __dsos__for_each_dso(struct dsos *dsos,
+				int (*cb)(struct dso *dso, void *data),
+				void *data)
+{
+	struct dso *dso;
+
+	list_for_each_entry(dso, &dsos->head, node) {
+		int err;
+
+		err = cb(dso, data);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+struct dsos__read_build_ids_cb_args {
+	bool with_hits;
+	bool have_build_id;
+};
+
+static int dsos__read_build_ids_cb(struct dso *dso, void *data)
 {
-	struct list_head *head = &dsos->head;
-	bool have_build_id = false;
-	struct dso *pos;
+	struct dsos__read_build_ids_cb_args *args = data;
 	struct nscookie nsc;
 
-	list_for_each_entry(pos, head, node) {
-		if (with_hits && !pos->hit && !dso__is_vdso(pos))
-			continue;
-		if (pos->has_build_id) {
-			have_build_id = true;
-			continue;
-		}
-		nsinfo__mountns_enter(pos->nsinfo, &nsc);
-		if (filename__read_build_id(pos->long_name, &pos->bid) > 0) {
-			have_build_id	  = true;
-			pos->has_build_id = true;
-		} else if (errno == ENOENT && pos->nsinfo) {
-			char *new_name = dso__filename_with_chroot(pos, pos->long_name);
-
-			if (new_name && filename__read_build_id(new_name,
-								&pos->bid) > 0) {
-				have_build_id = true;
-				pos->has_build_id = true;
-			}
-			free(new_name);
+	if (args->with_hits && !dso->hit && !dso__is_vdso(dso))
+		return 0;
+	if (dso->has_build_id) {
+		args->have_build_id = true;
+		return 0;
+	}
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	if (filename__read_build_id(dso->long_name, &dso->bid) > 0) {
+		args->have_build_id = true;
+		dso->has_build_id = true;
+	} else if (errno == ENOENT && dso->nsinfo) {
+		char *new_name = dso__filename_with_chroot(dso, dso->long_name);
+
+		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0) {
+			args->have_build_id = true;
+			dso->has_build_id = true;
 		}
-		nsinfo__mountns_exit(&nsc);
+		free(new_name);
 	}
+	nsinfo__mountns_exit(&nsc);
+	return 0;
+}
 
-	return have_build_id;
+bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
+{
+	struct dsos__read_build_ids_cb_args args = {
+		.with_hits = with_hits,
+		.have_build_id = false,
+	};
+
+	dsos__for_each_dso(dsos, dsos__read_build_ids_cb, &args);
+	return args.have_build_id;
 }
 
 static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
@@ -105,6 +132,7 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 
 	if (!name)
 		name = dso->long_name;
+
 	/*
 	 * Find node with the matching name
 	 */
@@ -185,17 +213,40 @@ static struct dso *__dsos__findnew_by_longname_id(struct rb_root *root, const ch
 	return __dsos__findnew_link_by_longname_id(root, NULL, name, id);
 }
 
+struct dsos__find_id_cb_args {
+	const char *name;
+	struct dso_id *id;
+	struct dso *res;
+};
+
+static int dsos__find_id_cb(struct dso *dso, void *data)
+{
+	struct dsos__find_id_cb_args *args = data;
+
+	if (__dso__cmp_short_name(args->name, args->id, dso) == 0) {
+		args->res = dso__get(dso);
+		return 1;
+	}
+	return 0;
+
+}
+
 static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id, bool cmp_short)
 {
-	struct dso *pos;
+	struct dso *res;
 
 	if (cmp_short) {
-		list_for_each_entry(pos, &dsos->head, node)
-			if (__dso__cmp_short_name(name, id, pos) == 0)
-				return dso__get(pos);
-		return NULL;
+		struct dsos__find_id_cb_args args = {
+			.name = name,
+			.id = id,
+			.res = NULL,
+		};
+
+		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
+		return args.res;
 	}
-	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
+	res = __dsos__findnew_by_longname_id(&dsos->root, name, id);
+	return res;
 }
 
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
@@ -275,48 +326,74 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 	return dso;
 }
 
-size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
-			       bool (skip)(struct dso *dso, int parm), int parm)
-{
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
-	size_t ret = 0;
+struct dsos__fprintf_buildid_cb_args {
+	FILE *fp;
+	bool (*skip)(struct dso *dso, int parm);
+	int parm;
+	size_t ret;
+};
 
-	list_for_each_entry(pos, head, node) {
-		char sbuild_id[SBUILD_ID_SIZE];
+static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
+{
+	struct dsos__fprintf_buildid_cb_args *args = data;
+	char sbuild_id[SBUILD_ID_SIZE];
 
-		if (skip && skip(pos, parm))
-			continue;
-		build_id__sprintf(&pos->bid, sbuild_id);
-		ret += fprintf(fp, "%-40s %s\n", sbuild_id, pos->long_name);
-	}
-	return ret;
+	if (args->skip && args->skip(dso, args->parm))
+		return 0;
+	build_id__sprintf(&dso->bid, sbuild_id);
+	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso->long_name);
+	return 0;
 }
 
-size_t __dsos__fprintf(struct dsos *dsos, FILE *fp)
+size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
+			       bool (*skip)(struct dso *dso, int parm), int parm)
 {
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
-	size_t ret = 0;
+	struct dsos__fprintf_buildid_cb_args args = {
+		.fp = fp,
+		.skip = skip,
+		.parm = parm,
+		.ret = 0,
+	};
+
+	dsos__for_each_dso(dsos, dsos__fprintf_buildid_cb, &args);
+	return args.ret;
+}
 
-	list_for_each_entry(pos, head, node) {
-		ret += dso__fprintf(pos, fp);
-	}
+struct dsos__fprintf_cb_args {
+	FILE *fp;
+	size_t ret;
+};
 
-	return ret;
+static int dsos__fprintf_cb(struct dso *dso, void *data)
+{
+	struct dsos__fprintf_cb_args *args = data;
+
+	args->ret += dso__fprintf(dso, args->fp);
+	return 0;
 }
 
-int __dsos__hit_all(struct dsos *dsos)
+size_t dsos__fprintf(struct dsos *dsos, FILE *fp)
 {
-	struct list_head *head = &dsos->head;
-	struct dso *pos;
+	struct dsos__fprintf_cb_args args = {
+		.fp = fp,
+		.ret = 0,
+	};
 
-	list_for_each_entry(pos, head, node)
-		pos->hit = true;
+	dsos__for_each_dso(dsos, dsos__fprintf_cb, &args);
+	return args.ret;
+}
 
+static int dsos__hit_all_cb(struct dso *dso, void *data __maybe_unused)
+{
+	dso->hit = true;
 	return 0;
 }
 
+int dsos__hit_all(struct dsos *dsos)
+{
+	return dsos__for_each_dso(dsos, dsos__hit_all_cb, NULL);
+}
+
 struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 				     struct machine *machine,
 				     struct kmod_path *m,
@@ -342,49 +419,44 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 	return dso;
 }
 
-struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 {
-	struct dso *dso, *res = NULL;
+	struct dso **res = data;
+	/*
+	 * The cpumode passed to is_kernel_module is not the cpumode of *this*
+	 * event. If we insist on passing correct cpumode to is_kernel_module,
+	 * we should record the cpumode when we adding this dso to the linked
+	 * list.
+	 *
+	 * However we don't really need passing correct cpumode.  We know the
+	 * correct cpumode must be kernel mode (if not, we should not link it
+	 * onto kernel_dsos list).
+	 *
+	 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
+	 * is_kernel_module() treats it as a kernel cpumode.
+	 */
+	if (!dso->kernel ||
+	    is_kernel_module(dso->long_name, PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+		return 0;
 
-	down_read(&dsos->lock);
-	list_for_each_entry(dso, &dsos->head, node) {
-		/*
-		 * The cpumode passed to is_kernel_module is not the cpumode of
-		 * *this* event. If we insist on passing correct cpumode to
-		 * is_kernel_module, we should record the cpumode when we adding
-		 * this dso to the linked list.
-		 *
-		 * However we don't really need passing correct cpumode.  We
-		 * know the correct cpumode must be kernel mode (if not, we
-		 * should not link it onto kernel_dsos list).
-		 *
-		 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
-		 * is_kernel_module() treats it as a kernel cpumode.
-		 */
-		if (!dso->kernel ||
-		    is_kernel_module(dso->long_name,
-				     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
-			continue;
+	*res = dso__get(dso);
+	return 1;
+}
 
-		res = dso__get(dso);
-		break;
-	}
-	up_read(&dsos->lock);
+struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+{
+	struct dso *res = NULL;
+
+	dsos__for_each_dso(dsos, dsos__find_kernel_dso_cb, &res);
 	return res;
 }
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data)
 {
-	struct dso *dso;
+	int err;
 
 	down_read(&dsos->lock);
-	list_for_each_entry(dso, &dsos->head, node) {
-		int err;
-
-		err = cb(dso, data);
-		if (err)
-			return err;
-	}
+	err = __dsos__for_each_dso(dsos, cb, data);
 	up_read(&dsos->lock);
-	return 0;
+	return err;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 317a263f0e37..50bd51523475 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -33,16 +33,16 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
-bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits);
+bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
 struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
 						const char *name, struct dso_id *id);
 
-size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
+size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
+size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
 
-int __dsos__hit_all(struct dsos *dsos);
+int dsos__hit_all(struct dsos *dsos);
 
 struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 				     struct kmod_path *m, const char *filename);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6505f8c2cecc..3646d4593502 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -853,11 +853,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = __dsos__fprintf(&machines->host.dsos, fp);
+	size_t ret = dsos__fprintf(&machines->host.dsos, fp);
 
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret += __dsos__fprintf(&pos->dsos, fp);
+		ret += dsos__fprintf(&pos->dsos, fp);
 	}
 
 	return ret;
@@ -866,7 +866,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 size_t machine__fprintf_dsos_buildid(struct machine *m, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm)
 {
-	return __dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
+	return dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
 }
 
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
@@ -3204,5 +3204,5 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 int machine__hit_all_dsos(struct machine *machine)
 {
-	return __dsos__hit_all(&machine->dsos);
+	return dsos__hit_all(&machine->dsos);
 }
-- 
2.42.0.869.gea05f2083d-goog

