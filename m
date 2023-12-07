Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F11807DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443032AbjLGBSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442154AbjLGBS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:18:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5271BCA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d8d3271ff5so1701457b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911880; x=1702516680; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozafK+YxnV8oHaLDKY1idAuezimM/K5JtLiBl1FMWy4=;
        b=MyCF4wh1Q3febjw4LwmXl9bao3ZdbKX8Rzsvgng5/kl+IvjKT3ddVR8g4vC7nBGIdq
         95Ire528ngTWyB0iz3iWLtYo0TY/2HdD0bmNh7vo94TJ6EKC5SJwzXCFMBj2tuF2bPaG
         ypVBi7qC+uwiieUkidJ6UZAm8gVB0P2wiFF3XkMj4lIguVHcE2SKJebJWPb1zByDrETT
         pBakj177G+jSGcWuPrJLjyS2BiUShxDshzuJGYrDtOlXJqwlDxPO3HuQam0zQ+C0X4jO
         DcePsqT4LUR+ZtuZcyfx1gNR8VNXZz7G2PtWNUSm+vbpDjpubYkiDVY8OJDSfmUpGX6T
         TqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911880; x=1702516680;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozafK+YxnV8oHaLDKY1idAuezimM/K5JtLiBl1FMWy4=;
        b=ZV/ckCotYbd1cRM8myqODlwlkJ4PPW6nXmY9YekSbUZ5PsStGJh9fy1yOfnSL9q+f0
         Wnr20Y6AMCo+otMaoJU+LXjXG+OrEUwqEl3KZmRCmu91s9H3PX80/fni/sR5s1WiroZh
         cZ+tcj79WACSjB35Eme+jlOz11GPPAQOropzIf8aHAhwOPpFwcIokGtlXNcFy105EyUx
         +7PuTcewlEubwhki6s8OULCDYFwPvFuEoBIBfmRluNgTAqTPijOUGqcIf3AXzPU30Ho8
         7P4RUY2Q21XV39p2zO/R/fm54jMjepT4x3D9yqC4XXigBX2e9qO11OQclrITDLNoXCQa
         S9jw==
X-Gm-Message-State: AOJu0YxpTQ18Km1wNZKDP/CjrpeyysPTm0EjPBnX8kf4uuaYfw26S+AZ
        BaYFPcDO1oGLoA9syKTruBz/Vzal5C3I
X-Google-Smtp-Source: AGHT+IHYqtg3wYZ6Cj08Ag7z/4V1Ij15UrdLWEAPGm8HG4oMYnwYyjGXa+uN2xWtnqN6l8o3Gje33p48Xtgx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:98b:b0:5d4:2ff3:d280 with SMTP id
 ce11-20020a05690c098b00b005d42ff3d280mr27363ywb.7.1701911879847; Wed, 06 Dec
 2023 17:17:59 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:48 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-15-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 14/47] perf maps: Add remove maps function to remove a map
 based on callback
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

Removing maps wasn't being done under the write lock. Similar to
maps__for_each_map, iterate the entries but in this case remove the
entry based on the result of the callback. If an entry was removed
then maps_by_name also needs updating, so add missed flush.

In dso__load_kcore, the test of map to save would always be false with
REFCNT_CHECKING because of a missing RC_CHK_ACCESS/RC_CHK_EQUAL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 24 ++++++++++++++++++++++++
 tools/perf/util/maps.h   |  6 ++----
 tools/perf/util/symbol.c | 24 ++++++++++++------------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 00e6589bba10..f13fd3a9686b 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -13,6 +13,10 @@
 #define maps__for_each_entry(maps, map) \
 	for (map = maps__first(maps); map; map = map_rb_node__next(map))
 
+#define maps__for_each_entry_safe(maps, map, next) \
+	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
+	     map = next, next = map_rb_node__next(map))
+
 static void maps__init(struct maps *maps, struct machine *machine)
 {
 	refcount_set(maps__refcnt(maps), 1);
@@ -214,6 +218,26 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 	return ret;
 }
 
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
+{
+	struct map_rb_node *pos, *next;
+	unsigned int start_nr_maps;
+
+	down_write(maps__lock(maps));
+
+	start_nr_maps = maps__nr_maps(maps);
+	maps__for_each_entry_safe(maps, pos, next)	{
+		if (cb(pos->map, data)) {
+			__maps__remove(maps, pos);
+			--RC_CHK_ACCESS(maps)->nr_maps;
+		}
+	}
+	if (maps__maps_by_name(maps) && start_nr_maps != maps__nr_maps(maps))
+		__maps__free_maps_by_name(maps);
+
+	up_write(maps__lock(maps));
+}
+
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 {
 	struct map *map = maps__find(maps, addr);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 8ac30cdaf5bd..b94ad5c8fea7 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -36,10 +36,6 @@ struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
 struct map_rb_node *maps__find_node(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
 
-#define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
-	     map = next, next = map_rb_node__next(map))
-
 DECLARE_RC_STRUCT(maps) {
 	struct rb_root      entries;
 	struct rw_semaphore lock;
@@ -80,6 +76,8 @@ static inline void __maps__zput(struct maps **map)
 
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
+/* Iterate over map removing an entry if cb returns true. */
+void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 72f03b875478..be212ba157dc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1239,13 +1239,23 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+static bool remove_old_maps(struct map *map, void *data)
+{
+	const struct map *map_to_save = data;
+
+	/*
+	 * We need to preserve eBPF maps even if they are covered by kcore,
+	 * because we need to access eBPF dso for source data.
+	 */
+	return !RC_CHK_EQUAL(map, map_to_save) && !__map__is_bpf_prog(map);
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
 	struct map *replacement_map = NULL;
-	struct map_rb_node *old_node, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1292,17 +1302,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	maps__for_each_entry_safe(kmaps, old_node, next) {
-		struct map *old_map = old_node->map;
-
-		/*
-		 * We need to preserve eBPF maps even if they are
-		 * covered by kcore, because we need to access
-		 * eBPF dso for source data.
-		 */
-		if (old_map != map && !__map__is_bpf_prog(old_map))
-			maps__remove(kmaps, old_map);
-	}
+	maps__remove_maps(kmaps, remove_old_maps, map);
 	machine->trampolines_mapped = false;
 
 	/* Find the kernel map using the '_stext' symbol */
-- 
2.43.0.rc2.451.g8631bc7472-goog

