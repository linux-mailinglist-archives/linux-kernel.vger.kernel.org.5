Return-Path: <linux-kernel+bounces-91110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB808709B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A6C1F216F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A88578B74;
	Mon,  4 Mar 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFvzHeXF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6479DD7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577356; cv=none; b=Q973FoFBtFJpn/93bg49hcTLTPbOnMq73+1SirM4X/0NoMb8IGzBdQxqt2KPCFxXPbqpOKMw5nRN4h4xTMbgktkpPctnuhOcMiBcMeFCiG3VK9PnZ//i3mK71QgKvgYutz8LciBn+Lb+0e4Iyqrax0gxTQFAj2UesG2zfuLuxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577356; c=relaxed/simple;
	bh=2GC+phSCVk6QC6Px3kBN8KHS0yInSA9bmF9fQs0KK60=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dFX1n/qLNclVOoZl8TaoyNPEYMPCQcjjMpfTC679q1jjAxpAmNYUH6qbjxxvAVrg/JNurPH5K8lI5yBXPo7eHrGyp5ln02tR3URVIDy7nJ6ms8WFL22V+s0LM0WrRxr72ew1CWU24bluzCb4VKrkwxmnvcN3kqvLwWFhvurJyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFvzHeXF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so74141247b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577354; x=1710182154; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQc/q5LErajBbQ74RTVNjqCPSv94nWCY/JjeQWSRZJM=;
        b=YFvzHeXFcV55AMkBfGB6R3B7MfXZ70NY2wRcUuTQD/nHlgCE0dbmQ9Cz70jD4zRHJl
         fUal8R+1c6IxWNqlzr9hgDa/CzMgt6J33FhbKrqZoxz3hf0JYM+YK1RvC7rDUPWGbeTA
         hCLgE/RUflukqnSoh0Pe2Pi54obKmhd7iyQo0L0z1zVI0u3Jpub3wh3ni57Aux3LsdP7
         HRHtn4lNummtCiYqoA83se0D4BNRA7NoM/FeW6IUPje2uWOu9fkRvTlmNPGc2q6KABMo
         KEG3/IA22Zpm+6s6lB811fQlPCOGW58dB3DeZC+5zZaviydpoZj+FL8ZyFQjROTyLcvq
         8/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577354; x=1710182154;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQc/q5LErajBbQ74RTVNjqCPSv94nWCY/JjeQWSRZJM=;
        b=N9KNA6vFcRfYJlhX8QuKjHJDSqNvVRjAEQ4OYUO0FK30DtNY3f0Lfp7KUZzuo/2Lv8
         eMEnjc8lQidNFexATc1g0Hdd+bTrI6hMsc4u2t3EIrS1gfFe7Y+yeA6Ry2cc5fcWZCbj
         VdS9LLaR5gTwSlYkfneeHWSks3vOnJWUid7QX2m99Y0JkzC1caPnp7iUNVdXuk9OEUJa
         fvCkbRlIER5MnF5Jd16x49VM2TYNp0kY0ppu3yD9qSG/M/IcS7qNI/W8kRH/5E33KzTs
         otDU3RmY7AkrBv8d+lidXzVfxx7mzSBrvDNJae4rq38SX5aea9hM5vxePw42o0CToboL
         Obrw==
X-Forwarded-Encrypted: i=1; AJvYcCXVfq/4RBYP36K9qrAXlvgCyY3Drb6aHSm7ycioHAk3bVmiyDDVIj96FDBsaw3wEXEEq+ordUzhDq7UMiSc7fBVUKbuUFeHQT2H8Fw0
X-Gm-Message-State: AOJu0YzMNd5LcvHeXi/1L0oTsW+0P4IeZX6h+5e6vc/WzGj2ypEBu2ox
	bH/IH2kx2d3XfeGhNbNkyKIyRuByEt5xJF5h0m2mKRhy1vO2rSYnlynxl1efiO1Zrxnlb1GFQ9l
	Zg3Qq0Q==
X-Google-Smtp-Source: AGHT+IGn7q3f4n2qFDHP3nNLIpYQeGAahw0onQ/F7Hn3ah1H14tIrD45iMMQJ+4y8pETRlLjUSY6HMaEkZs1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:690c:4445:b0:609:3c46:1889 with SMTP
 id gq5-20020a05690c444500b006093c461889mr2800238ywb.7.1709577354024; Mon, 04
 Mar 2024 10:35:54 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:17 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/13] perf dsos: Switch more loops to dsos__for_each_dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.44.0.278.ge034bb2e1d-goog


