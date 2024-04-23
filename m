Return-Path: <linux-kernel+bounces-154496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BA8ADCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6471F214BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A47208D7;
	Tue, 23 Apr 2024 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJp8gqMe"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146331CF92
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846385; cv=none; b=L7muJynY5YX6bZJ1flJL2fOPC/4vp7opVqBwVUWlprfJUiHor8UKoP1d17ioxTuy2NCroEeHWyDgmbQFBOsKwNCyS37dImkLAr6amx9TAvIjTmSqLy7pVcpOHLkz3tPglzdz1lLgPpASEy956SuHOuJkpr8UPwfpCZuxtkPjQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846385; c=relaxed/simple;
	bh=C/lc+AGf/Tq5IYjiIijITz1XV9PrHM6TD0L9DK0tCu0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JhRnDCed9r3LyBADddkXeC47wjtEyIY5MiyRyGMr1S1kB53cdHJQKDpY5W1Ic/Il/wdeCTsl6DIORSZ7nroZY7krSo8QVWPva9fcSg9YXf5GBhuic6TB4nfoG1e91v3iQZerP1Om0vXA06QQ3LHq0NeK7ChNL8XBAyXLgfblKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJp8gqMe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de465caa098so8931629276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846382; x=1714451182; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf9DU2dnw7wispX/TBVDNkoG04QwKWtFDLd1toiCdnE=;
        b=qJp8gqMe3RsRKxJ0iS3tZYwq4lch9Q368dLnXOkuqxWuu2hrDvvblJ1sTTcn3R/TjG
         MRyYTe7R/frPz1dHe8fpH5OMYLl3ircHhBwyPPjb++0Smno3YRaR805Q5vcAGdag8tN+
         0GrQkbbW+bv0Vh1XtT2n+61RqwMMbNyTyFkXUYblimoreKg9rL1IoB3uOQGU0wGJIbJ8
         RUo8oUS+h7pCpPI+29awoGKqN10NaSKz1Wfgzf91SnfQ4uAF6jwUNnQF8tW7x3EazPBI
         1pZs01Jtfo+efuqSHmogYcFNTFH6pF/tEiHEpCdYmtAyLj9iuPaclqKPgUUP+6kYLGLt
         lpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846382; x=1714451182;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf9DU2dnw7wispX/TBVDNkoG04QwKWtFDLd1toiCdnE=;
        b=Zru70LCohJAYI0f/DrG6Lf9Ek8JyUpM6DbJ07ET3DiKiWLaIJJ7mWFlL/nntiUOZqM
         3nU3CFmfoUTK6aAt7DY5SwjeekfgiHcQBj7SPlCCuR+/bZ4192wEG6W8C58LBD3HMBYx
         HEkfdYJVZGezXW72k1x9JKaRc1CG+bRvdhbKre00WrfAs1Puwl0Car9DmUm6C1sPHpk5
         DVpFPflSd0iqCd7uNhJkLhs0FuzgfN2loOkPYzKM1VlKkXwjk68JmDSMlOTQOxY+ejbX
         1G12tQMrB9WEPbxdQkrLuh+5u8gNhiMEDInMhxvAduf0gH4QHaU+1R7ry780ECrByENw
         cRFg==
X-Forwarded-Encrypted: i=1; AJvYcCVEjrleDuX2PprMTJTh/joyZmQ8aH4z83ZrQeX6daPsZCeSv+l20EVZXFDKAqeeieZitd9NYE/TId4A2NmEXyduRoPOLz0TGZDxMcTp
X-Gm-Message-State: AOJu0YxG31DdUs/4hN213iym0A3iW5CiUnUxqTXx2vdR9hRgeZzsiq2M
	Sl8vBBeCrZgJTacThlJdOd6CCxXYg7qSUPdeq77ao/Zho0yzb7i6KThkLSzwSiOD4Z31SWkyLhB
	wIBsJfw==
X-Google-Smtp-Source: AGHT+IFpZBBenLl8CuXMTRon+NipwRvKVm6t9uJVipKavl7gMSaP6TAS4cv5iL09olazYmMUaOe5cUl0zyga
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a25:d884:0:b0:dda:d7cf:5c2c with SMTP id
 p126-20020a25d884000000b00ddad7cf5c2cmr929744ybg.13.1713846382002; Mon, 22
 Apr 2024 21:26:22 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:55 -0700
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>
Message-Id: <20240423042601.2009469-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423042601.2009469-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 1/7] perf dsos: Switch backing storage to array from rbtree/list
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DSOs were held on a list for fast iteration and in an rbtree for fast
finds. Switch to using a lazily sorted array where iteration is just
iterating through the array and binary searches are the same
complexity as searching the rbtree. The find may need to sort the
array first which does increase the complexity, but add operations
have lower complexity and overall the complexity should remain about
the same.

The set name operations on the dso just records that the array is no
longer sorted, avoiding complexity in rebalancing the rbtree. Tighter
locking discipline is enforced to avoid the array being resorted while
long and short names or ids are changed.

The array is smaller in size, replacing 6 pointers with 2, and so even
with extra allocated space in the array, the array may be 50%
unoccupied, the memory saving should be at least 2x.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  |  67 +++++++++------
 tools/perf/util/dso.h  |  10 +--
 tools/perf/util/dsos.c | 188 ++++++++++++++++++++++++++---------------
 tools/perf/util/dsos.h |  21 +++--
 4 files changed, 177 insertions(+), 109 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ad562743d769..3caca60a6ce3 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1241,35 +1241,35 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 	return dso;
 }
 
-static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_id *id, bool name_allocated)
+static void dso__set_long_name_id(struct dso *dso, const char *name, bool name_allocated)
 {
-	struct rb_root *root = dso->root;
+	struct dsos *dsos = dso->dsos;
 
 	if (name == NULL)
 		return;
 
-	if (dso->long_name_allocated)
-		free((char *)dso->long_name);
-
-	if (root) {
-		rb_erase(&dso->rb_node, root);
+	if (dsos) {
 		/*
-		 * __dsos__findnew_link_by_longname_id() isn't guaranteed to
-		 * add it back, so a clean removal is required here.
+		 * Need to avoid re-sorting the dsos breaking by non-atomically
+		 * renaming the dso.
 		 */
-		RB_CLEAR_NODE(&dso->rb_node);
-		dso->root = NULL;
+		down_write(&dsos->lock);
 	}
 
+	if (dso->long_name_allocated)
+		free((char *)dso->long_name);
+
 	dso->long_name		 = name;
 	dso->long_name_len	 = strlen(name);
 	dso->long_name_allocated = name_allocated;
 
-	if (root)
-		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
+	if (dsos) {
+		dsos->sorted = false;
+		up_write(&dsos->lock);
+	}
 }
 
-static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
+static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
 	if (a->maj > b->maj) return -1;
 	if (a->maj < b->maj) return 1;
@@ -1297,7 +1297,7 @@ static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	return 0;
 }
 
-bool dso_id__empty(struct dso_id *id)
+bool dso_id__empty(const struct dso_id *id)
 {
 	if (!id)
 		return true;
@@ -1305,15 +1305,22 @@ bool dso_id__empty(struct dso_id *id)
 	return !id->maj && !id->min && !id->ino && !id->ino_generation;
 }
 
-void dso__inject_id(struct dso *dso, struct dso_id *id)
+void __dso__inject_id(struct dso *dso, struct dso_id *id)
 {
+	struct dsos *dsos = dso->dsos;
+
+	/* dsos write lock held by caller. */
+
 	dso->id.maj = id->maj;
 	dso->id.min = id->min;
 	dso->id.ino = id->ino;
 	dso->id.ino_generation = id->ino_generation;
+
+	if (dsos)
+		dsos->sorted = false;
 }
 
-int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
 	/*
 	 * The second is always dso->id, so zeroes if not set, assume passing
@@ -1332,20 +1339,34 @@ int dso__cmp_id(struct dso *a, struct dso *b)
 
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
-	dso__set_long_name_id(dso, name, NULL, name_allocated);
+	dso__set_long_name_id(dso, name, name_allocated);
 }
 
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 {
+	struct dsos *dsos = dso->dsos;
+
 	if (name == NULL)
 		return;
 
+	if (dsos) {
+		/*
+		 * Need to avoid re-sorting the dsos breaking by non-atomically
+		 * renaming the dso.
+		 */
+		down_write(&dsos->lock);
+	}
 	if (dso->short_name_allocated)
 		free((char *)dso->short_name);
 
 	dso->short_name		  = name;
 	dso->short_name_len	  = strlen(name);
 	dso->short_name_allocated = name_allocated;
+
+	if (dsos) {
+		dsos->sorted = false;
+		up_write(&dsos->lock);
+	}
 }
 
 int dso__name_len(const struct dso *dso)
@@ -1381,7 +1402,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		strcpy(dso->name, name);
 		if (id)
 			dso->id = *id;
-		dso__set_long_name_id(dso, dso->name, id, false);
+		dso__set_long_name_id(dso, dso->name, false);
 		dso__set_short_name(dso, dso->name, false);
 		dso->symbols = RB_ROOT_CACHED;
 		dso->symbol_names = NULL;
@@ -1406,9 +1427,6 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->is_kmod = 0;
 		dso->needs_swap = DSO_SWAP__UNSET;
 		dso->comp = COMP_ID__NONE;
-		RB_CLEAR_NODE(&dso->rb_node);
-		dso->root = NULL;
-		INIT_LIST_HEAD(&dso->node);
 		INIT_LIST_HEAD(&dso->data.open_entry);
 		mutex_init(&dso->lock);
 		refcount_set(&dso->refcnt, 1);
@@ -1424,9 +1442,8 @@ struct dso *dso__new(const char *name)
 
 void dso__delete(struct dso *dso)
 {
-	if (!RB_EMPTY_NODE(&dso->rb_node))
-		pr_err("DSO %s is still in rbtree when being deleted!\n",
-		       dso->long_name);
+	if (dso->dsos)
+		pr_err("DSO %s is still in rbtree when being deleted!\n", dso->long_name);
 
 	/* free inlines first, as they reference symbols */
 	inlines__tree_delete(&dso->inlined_nodes);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2c295438226d..b22dec8b3f3a 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -146,9 +146,7 @@ struct auxtrace_cache;
 
 struct dso {
 	struct mutex	 lock;
-	struct list_head node;
-	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
-	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
+	struct dsos	 *dsos;
 	struct rb_root_cached symbols;
 	struct symbol	 **symbol_names;
 	size_t		 symbol_names_len;
@@ -238,8 +236,8 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
-int dso_id__cmp(struct dso_id *a, struct dso_id *b);
-bool dso_id__empty(struct dso_id *id);
+int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
+bool dso_id__empty(const struct dso_id *id);
 
 struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
@@ -248,7 +246,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
-void dso__inject_id(struct dso *dso, struct dso_id *id);
+void __dso__inject_id(struct dso *dso, struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index b7fbfb877ae3..cfc10e1a6802 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -14,24 +14,30 @@
 
 void dsos__init(struct dsos *dsos)
 {
-	INIT_LIST_HEAD(&dsos->head);
-	dsos->root = RB_ROOT;
 	init_rwsem(&dsos->lock);
+
+	dsos->cnt = 0;
+	dsos->allocated = 0;
+	dsos->dsos = NULL;
+	dsos->sorted = true;
 }
 
 static void dsos__purge(struct dsos *dsos)
 {
-	struct dso *pos, *n;
-
 	down_write(&dsos->lock);
 
-	list_for_each_entry_safe(pos, n, &dsos->head, node) {
-		RB_CLEAR_NODE(&pos->rb_node);
-		pos->root = NULL;
-		list_del_init(&pos->node);
-		dso__put(pos);
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
+
+		dso__put(dso);
+		dso->dsos = NULL;
 	}
 
+	zfree(&dsos->dsos);
+	dsos->cnt = 0;
+	dsos->allocated = 0;
+	dsos->sorted = true;
+
 	up_write(&dsos->lock);
 }
 
@@ -46,9 +52,8 @@ static int __dsos__for_each_dso(struct dsos *dsos,
 				int (*cb)(struct dso *dso, void *data),
 				void *data)
 {
-	struct dso *dso;
-
-	list_for_each_entry(dso, &dsos->head, node) {
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
 		int err;
 
 		err = cb(dso, data);
@@ -119,16 +124,47 @@ static int dso__cmp_short_name(struct dso *a, struct dso *b)
 	return __dso__cmp_short_name(a->short_name, &a->id, b);
 }
 
+static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
+{
+	const struct dso *a = *((const struct dso **)va);
+	const struct dso *b = *((const struct dso **)vb);
+	int rc = strcmp(a->long_name, b->long_name);
+
+	if (!rc) {
+		rc = dso_id__cmp(&a->id, &b->id);
+		if (!rc)
+			rc = strcmp(a->short_name, b->short_name);
+	}
+	return rc;
+}
+
 /*
  * Find a matching entry and/or link current entry to RB tree.
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
-						const char *name, struct dso_id *id)
+struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
+						struct dso *dso,
+						const char *name,
+						struct dso_id *id,
+						bool write_locked)
 {
-	struct rb_node **p = &root->rb_node;
-	struct rb_node  *parent = NULL;
+	int low = 0, high = dsos->cnt - 1;
+
+	if (!dsos->sorted) {
+		if (!write_locked) {
+			up_read(&dsos->lock);
+			down_write(&dsos->lock);
+			dso = __dsos__findnew_link_by_longname_id(dsos, dso, name, id,
+								  /*write_locked=*/true);
+			up_write(&dsos->lock);
+			down_read(&dsos->lock);
+			return dso;
+		}
+		qsort(dsos->dsos, dsos->cnt, sizeof(struct dso *),
+		      dsos__cmp_long_name_id_short_name);
+		dsos->sorted = true;
+	}
 
 	if (!name)
 		name = dso->long_name;
@@ -136,11 +172,11 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 	/*
 	 * Find node with the matching name
 	 */
-	while (*p) {
-		struct dso *this = rb_entry(*p, struct dso, rb_node);
+	while (low <= high) {
+		int mid = (low + high) / 2;
+		struct dso *this = dsos->dsos[mid];
 		int rc = __dso__cmp_long_name(name, id, this);
 
-		parent = *p;
 		if (rc == 0) {
 			/*
 			 * In case the new DSO is a duplicate of an existing
@@ -161,56 +197,53 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 			}
 		}
 		if (rc < 0)
-			p = &parent->rb_left;
+			high = mid - 1;
 		else
-			p = &parent->rb_right;
-	}
-	if (dso) {
-		/* Add new node and rebalance tree */
-		rb_link_node(&dso->rb_node, parent, p);
-		rb_insert_color(&dso->rb_node, root);
-		dso->root = root;
+			low = mid + 1;
 	}
+	if (dso)
+		__dsos__add(dsos, dso);
 	return NULL;
 }
 
-void __dsos__add(struct dsos *dsos, struct dso *dso)
+int __dsos__add(struct dsos *dsos, struct dso *dso)
 {
-	list_add_tail(&dso->node, &dsos->head);
-	__dsos__findnew_link_by_longname_id(&dsos->root, dso, NULL, &dso->id);
-	/*
-	 * It is now in the linked list, grab a reference, then garbage collect
-	 * this when needing memory, by looking at LRU dso instances in the
-	 * list with atomic_read(&dso->refcnt) == 1, i.e. no references
-	 * anywhere besides the one for the list, do, under a lock for the
-	 * list: remove it from the list, then a dso__put(), that probably will
-	 * be the last and will then call dso__delete(), end of life.
-	 *
-	 * That, or at the end of the 'struct machine' lifetime, when all
-	 * 'struct dso' instances will be removed from the list, in
-	 * dsos__exit(), if they have no other reference from some other data
-	 * structure.
-	 *
-	 * E.g.: after processing a 'perf.data' file and storing references
-	 * to objects instantiated while processing events, we will have
-	 * references to the 'thread', 'map', 'dso' structs all from 'struct
-	 * hist_entry' instances, but we may not need anything not referenced,
-	 * so we might as well call machines__exit()/machines__delete() and
-	 * garbage collect it.
-	 */
-	dso__get(dso);
+	if (dsos->cnt == dsos->allocated) {
+		unsigned int to_allocate = 2;
+		struct dso **temp;
+
+		if (dsos->allocated > 0)
+			to_allocate = dsos->allocated * 2;
+		temp = realloc(dsos->dsos, sizeof(struct dso *) * to_allocate);
+		if (!temp)
+			return -ENOMEM;
+		dsos->dsos = temp;
+		dsos->allocated = to_allocate;
+	}
+	dsos->dsos[dsos->cnt++] = dso__get(dso);
+	if (dsos->cnt >= 2 && dsos->sorted) {
+		dsos->sorted = dsos__cmp_long_name_id_short_name(&dsos->dsos[dsos->cnt - 2],
+								 &dsos->dsos[dsos->cnt - 1])
+			<= 0;
+	}
+	dso->dsos = dsos;
+	return 0;
 }
 
-void dsos__add(struct dsos *dsos, struct dso *dso)
+int dsos__add(struct dsos *dsos, struct dso *dso)
 {
+	int ret;
+
 	down_write(&dsos->lock);
-	__dsos__add(dsos, dso);
+	ret = __dsos__add(dsos, dso);
 	up_write(&dsos->lock);
+	return ret;
 }
 
-static struct dso *__dsos__findnew_by_longname_id(struct rb_root *root, const char *name, struct dso_id *id)
+static struct dso *__dsos__findnew_by_longname_id(struct dsos *dsos, const char *name,
+						struct dso_id *id, bool write_locked)
 {
-	return __dsos__findnew_link_by_longname_id(root, NULL, name, id);
+	return __dsos__findnew_link_by_longname_id(dsos, NULL, name, id, write_locked);
 }
 
 struct dsos__find_id_cb_args {
@@ -231,7 +264,8 @@ static int dsos__find_id_cb(struct dso *dso, void *data)
 
 }
 
-static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id, bool cmp_short)
+static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id,
+				   bool cmp_short, bool write_locked)
 {
 	struct dso *res;
 
@@ -245,7 +279,7 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
 		return args.res;
 	}
-	res = __dsos__findnew_by_longname_id(&dsos->root, name, id);
+	res = __dsos__findnew_by_longname_id(dsos, name, id, write_locked);
 	return res;
 }
 
@@ -254,7 +288,7 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	struct dso *res;
 
 	down_read(&dsos->lock);
-	res = __dsos__find_id(dsos, name, NULL, cmp_short);
+	res = __dsos__find_id(dsos, name, NULL, cmp_short, /*write_locked=*/false);
 	up_read(&dsos->lock);
 	return res;
 }
@@ -296,8 +330,13 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	struct dso *dso = dso__new_id(name, id);
 
 	if (dso != NULL) {
-		__dsos__add(dsos, dso);
+		/*
+		 * The dsos lock is held on entry, so rename the dso before
+		 * adding it to avoid needing to take the dsos lock again to say
+		 * the array isn't sorted.
+		 */
 		dso__set_basename(dso);
+		__dsos__add(dsos, dso);
 	}
 	return dso;
 }
@@ -309,10 +348,10 @@ struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
-	struct dso *dso = __dsos__find_id(dsos, name, id, false);
+	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
 	if (dso && dso_id__empty(&dso->id) && !dso_id__empty(id))
-		dso__inject_id(dso, id);
+		__dso__inject_id(dso, id);
 
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
@@ -403,18 +442,27 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos,
 
 	down_write(&dsos->lock);
 
-	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true);
+	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true, /*write_locked=*/true);
+	if (dso) {
+		up_write(&dsos->lock);
+		return dso;
+	}
+	/*
+	 * Failed to find the dso so create it. Change the name before adding it
+	 * to the array, to avoid unnecessary sorts and potential locking
+	 * issues.
+	 */
+	dso = dso__new_id(m->name, /*id=*/NULL);
 	if (!dso) {
-		dso = __dsos__addnew(dsos, m->name);
-		if (dso == NULL)
-			goto out_unlock;
-
-		dso__set_module_info(dso, m, machine);
-		dso__set_long_name(dso, strdup(filename), true);
-		dso->kernel = DSO_SPACE__KERNEL;
+		up_write(&dsos->lock);
+		return NULL;
 	}
+	dso__set_basename(dso);
+	dso__set_module_info(dso, m, machine);
+	dso__set_long_name(dso,	strdup(filename), true);
+	dso->kernel = DSO_SPACE__KERNEL;
+	__dsos__add(dsos, dso);
 
-out_unlock:
 	up_write(&dsos->lock);
 	return dso;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 50bd51523475..c1b3979ad4bd 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -14,20 +14,22 @@ struct kmod_path;
 struct machine;
 
 /*
- * DSOs are put into both a list for fast iteration and rbtree for fast
- * long name lookup.
+ * Collection of DSOs as an array for iteration speed, but sorted for O(n)
+ * lookup.
  */
 struct dsos {
-	struct list_head    head;
-	struct rb_root	    root;	/* rbtree root sorted by long name */
 	struct rw_semaphore lock;
+	struct dso **dsos;
+	unsigned int cnt;
+	unsigned int allocated;
+	bool sorted;
 };
 
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
-void __dsos__add(struct dsos *dsos, struct dso *dso);
-void dsos__add(struct dsos *dsos, struct dso *dso);
+int __dsos__add(struct dsos *dsos, struct dso *dso);
+int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
@@ -35,8 +37,11 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
-struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
-						const char *name, struct dso_id *id);
+struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
+						struct dso *dso,
+						const char *name,
+						struct dso_id *id,
+						bool write_locked);
 
 size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-- 
2.44.0.769.g3c40516874-goog


