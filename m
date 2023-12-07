Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF06807DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443170AbjLGBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443057AbjLGBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:21:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B21BE7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db54a19c7d6so503579276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911884; x=1702516684; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BM+/6c/Tr/mAdGEEBA/HXGZRIn+6+7yv2y1Rhu0O2o=;
        b=NxSdT39faglTLaxlk9edbhFB/RBMdP3+tNG493GpancH3w8PBph/ssCk1S5VGyw6ZI
         Mr9Z7NyYc1vUtgTN9Rvw+LO13RxUvmWcga13AmlXKDXmsAhCmXqB0c2zDut5pvjY/6j1
         W1xJ7gqHsgtlDFpeo19CJP/nZfj11G7H3d8oE47fROuKIXyslFXmlbb/j/LXzTDY6yZ+
         aIZfh6COzuog18uO6+u49+7B6K4PYUtqcEAzhCRPP7ym3tjS3KVmuHs/+QtkNfTx9PL8
         llueD5Xac1+CORj8YIO2JrtX2ssFblcSySS18nLPtBSyYRF3EpOjORwaXSQa1W9oJTNZ
         JGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911884; x=1702516684;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BM+/6c/Tr/mAdGEEBA/HXGZRIn+6+7yv2y1Rhu0O2o=;
        b=Vb7fNIs3PWcZ2GYXnahRMSwO2SEG3Pz7Ox5hcgfuL6Hnb4RXtHmUI6jtmo8dVddh/Z
         pKl/2CnKMd1o7/2E9VPEth3Cjv8pvDgjq9QKJOhTll+u8ugfepTjIMk5dH1Vs91YZpXr
         kOlKnzvY/Rxn0GjfZ/5qrgS4Fjd4SLwwP+1Td3Jg4Q9QCcu2UlB8wmjGx00tsga9w/+R
         ccbvZTUtMB6DQiYd6NQ8qSF4dLK6GBnfzavygIPd07eMArtFpARV3KPhbXyv/eebsl1R
         +dfDvn2Iri+J+Y/YH2gY6c/j2RHIshyNHlWyijRXzVT33WBSJ951CNdbPVJcON6XOv4c
         eMug==
X-Gm-Message-State: AOJu0YwWGvpM7c80wpw8vp5plTHjLM6ROG/9y5QXlVf3dQHcj6tBlSSe
        6wqAqE8RJ5ul5Je9+wYCRFoXeOTQWRPS
X-Google-Smtp-Source: AGHT+IHuGOinVo8yGRnJo+pdShHMcAZ3lIS76n/OsEzGgjuALvSJoFK5cIamFV++qi4EcWYQydm0lqCsA7Yx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:d003:0:b0:db5:41e9:aa1c with SMTP id
 h3-20020a25d003000000b00db541e9aa1cmr21259ybg.11.1701911884195; Wed, 06 Dec
 2023 17:18:04 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:50 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-17-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 16/47] perf maps: Refactor maps__fixup_overlappings
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

Rename to maps__fixup_overlap_and_insert as the given mapping is
always inserted. Factor out first_ending_after as a utility
function. Minor variable name changes. Switch to using debug_file()
rather than passing a debug FILE*.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 57 ++++++++++++++++++++++++----------------
 tools/perf/util/maps.h   |  2 +-
 tools/perf/util/thread.c |  3 +--
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f13fd3a9686b..94a97923527d 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 	return args.printed;
 }
 
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+/*
+ * Find first map where end > map->start.
+ * Same as find_vma() in kernel.
+ */
+static struct rb_node *first_ending_after(struct maps *maps, const struct map *map)
 {
 	struct rb_root *root;
 	struct rb_node *next, *first;
-	int err = 0;
-
-	down_write(maps__lock(maps));
 
 	root = maps__entries(maps);
-
-	/*
-	 * Find first map where end > map->start.
-	 * Same as find_vma() in kernel.
-	 */
 	next = root->rb_node;
 	first = NULL;
 	while (next) {
@@ -361,8 +357,23 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		} else
 			next = next->rb_right;
 	}
+	return first;
+}
+
+/*
+ * Adds new to maps, if new overlaps existing entries then the existing maps are
+ * adjusted or removed so that new fits without overlapping any entries.
+ */
+int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
+{
+
+	struct rb_node *next;
+	int err = 0;
+	FILE *fp = debug_file();
+
+	down_write(maps__lock(maps));
 
-	next = first;
+	next = first_ending_after(maps, new);
 	while (next && !err) {
 		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
@@ -371,27 +382,27 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (map__start(pos->map) >= map__end(map))
+		if (map__start(pos->map) >= map__end(new))
 			break;
 
 		if (verbose >= 2) {
 
 			if (use_browser) {
 				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					 map__dso(map)->name);
+					 map__dso(new)->name);
 			} else {
-				fputs("overlapping maps:\n", fp);
-				map__fprintf(map, fp);
+				pr_debug("overlapping maps:\n");
+				map__fprintf(new, fp);
 				map__fprintf(pos->map, fp);
 			}
 		}
 
-		rb_erase_init(&pos->rb_node, root);
+		rb_erase_init(&pos->rb_node, maps__entries(maps));
 		/*
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map__start(map) > map__start(pos->map)) {
+		if (map__start(new) > map__start(pos->map)) {
 			struct map *before = map__clone(pos->map);
 
 			if (before == NULL) {
@@ -399,7 +410,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			map__set_end(before, map__start(map));
+			map__set_end(before, map__start(new));
 			err = __maps__insert(maps, before);
 			if (err) {
 				map__put(before);
@@ -411,7 +422,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			map__put(before);
 		}
 
-		if (map__end(map) < map__end(pos->map)) {
+		if (map__end(new) < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
@@ -419,10 +430,10 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			map__set_start(after, map__end(map));
-			map__add_pgoff(after, map__end(map) - map__start(pos->map));
-			assert(map__map_ip(pos->map, map__end(map)) ==
-				map__map_ip(after, map__end(map)));
+			map__set_start(after, map__end(new));
+			map__add_pgoff(after, map__end(new) - map__start(pos->map));
+			assert(map__map_ip(pos->map, map__end(new)) ==
+				map__map_ip(after, map__end(new)));
 			err = __maps__insert(maps, after);
 			if (err) {
 				map__put(after);
@@ -436,6 +447,8 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 		map__put(pos->map);
 		free(pos);
 	}
+	/* Add the map. */
+	err = __maps__insert(maps, new);
 	up_write(maps__lock(maps));
 	return err;
 }
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index b94ad5c8fea7..62e94d443c02 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -133,7 +133,7 @@ struct addr_map_symbol;
 
 int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
+int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b6986a81aa6d..3d47b5c5528b 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -345,8 +345,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
 	if (ret)
 		return ret;
 
-	maps__fixup_overlappings(thread__maps(thread), map, stderr);
-	return maps__insert(thread__maps(thread), map);
+	return maps__fixup_overlap_and_insert(thread__maps(thread), map);
 }
 
 struct thread__prepare_access_maps_cb_args {
-- 
2.43.0.rc2.451.g8631bc7472-goog

