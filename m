Return-Path: <linux-kernel+bounces-110301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E386885CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE131F21C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E112D1EC;
	Thu, 21 Mar 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHaa81mj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0612CDA9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037007; cv=none; b=Hq8uLJHmROJ2lWb23U97OepFtPosxjusiFtwqqXTYt7VIGANC6Bs8KNJJi4GZg+OYhR0yB5BGmD0+GVWKiUL/7POYJKp1SF9DWlnKULoiyCECMslCudqf+XFumwFqLQwNOhFup3k/1gSE3pG7Gae/IkFfaZeKxQYKT/f/T6FHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037007; c=relaxed/simple;
	bh=pcKEp/t7NibPWWwI0c25kFKRAInJPDRXwVb8ImvA4bw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qi3MK3FLsZ65t7lXd8D1Mws90Iz1Ynid5duSJo02iJGFisTzySmblNzdAyjOIz/+wzfa12OuZaDGz3P167zMQ0PhisRVRuymiDMw6jEQUDztJh/kHPeEhh3z5vJ42/K5Dy3usJsRVXu18nAw2OixdZJZ0Vf8D7OyRERZlzTxsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHaa81mj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ab69a9e6fso28372827b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711037003; x=1711641803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVLF+UKKSSneQDn6qHputn9QFsbRV8FfQmrWOHTFem8=;
        b=VHaa81mjeWm7jeTO9GoOfIlgMNGAgry38glFr7EJ9akANzSwdltxFHYb1ffgE8pY6E
         2nWkwG3eBOr5kbJNNgGapv77vh9QfSOt1SNAfmK62eVVWQUtPjUo5ELxt9DotrLL23av
         eS+p+tgSnVY3rwkEpiidk/uhp3klLrM437YO2n47KiCR1ex5oXCw48E7FbnQ+WBiBveK
         J11mNUA5Pv5M8YoeY6f1qlL4WOo+ZczANigBQgWwI2iadjnwVHbbN5hw9Qhhg2siH3vE
         ryyJS+6LIIaq466hXrGnXkClDcQ5ni+szwnRzymFvzwRj/39YnogbaIUK6ufGLYHoVm3
         hMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037003; x=1711641803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVLF+UKKSSneQDn6qHputn9QFsbRV8FfQmrWOHTFem8=;
        b=ia9MDP2JBlFU8d2zX9DWUvWpYeMKNKbEs//+NP0j3zp+bHT0cz/JFQvV3XcTerTXTE
         3p6PsPz+y7f4ucQrnEHEt6JwmtLf1bEiC3PVoC86vpUjfEmAO1VlWFnmjZDKRPtaR9uH
         IXJzjUrIZzkPq7icsX7fAFeam084oYBtJde37tpiOO5C9pJuGL5DymKEflRFmxcdlWOp
         FOxfchEwmI/+5d+FTC+BdVHSzxOJy/taRINWrnRFZ0fAJvqhwS64mzEGPp8f178VoH+p
         L9WJPppcHU/FDg6+fZAQlmxl7T/8V2kOLRPEv5UJrM/1JR7k4NHjH/3VFwGEzWgs9qh4
         99gg==
X-Forwarded-Encrypted: i=1; AJvYcCUph5Z7wiDYzMWogqK8WWTOX9oDt+mWjcwiuCLvDboZqkFqj2tuoSVkeRFNHXEbqcr9y6fRcgdGZdzTQJf55aCgKJ+o42Mu5sdA1HHC
X-Gm-Message-State: AOJu0Yw4ROIk2HYD63UDwGVlqyyueVxIvcv4jwWg3QXW2OsX7P4L9Krf
	gtsl+d8lfauOlF5aIKgkyf2K0/aM7J3Mh46a1mffhEc6NUJxAoNzYvAiZNFuxGOI0Qs9gVNG1Wk
	P+fCkSA==
X-Google-Smtp-Source: AGHT+IFXqgieHzdBR1PeQbVrNq2Ez/JXfq1sVXzLHKGI5bHOXdEHN+ok9zB6M8NysufvWDRFFOmYjUqbxTgv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a0d:cc41:0:b0:610:dc1b:8e57 with SMTP id
 o62-20020a0dcc41000000b00610dc1b8e57mr835290ywd.3.1711037003534; Thu, 21 Mar
 2024 09:03:23 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:53 -0700
In-Reply-To: <20240321160300.1635121-1-irogers@google.com>
Message-Id: <20240321160300.1635121-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321160300.1635121-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 06/13] perf dsos: Switch more loops to dsos__for_each_dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
index bd153bc2c8da..97a0c21ba2a5 100644
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
@@ -3208,5 +3208,5 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 int machine__hit_all_dsos(struct machine *machine)
 {
-	return __dsos__hit_all(&machine->dsos);
+	return dsos__hit_all(&machine->dsos);
 }
-- 
2.44.0.396.g6e790dbe36-goog


