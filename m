Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAC7FAD0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjK0WLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjK0WKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:10:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6619AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d064f9e2a1so18010797b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123005; x=1701727805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kx7LDUS3rY7lBdLFklcEVdSsIMEbcaAgKdOgd/PIIs0=;
        b=iITNyCpb6bqpFVm0KKOdbt3O5WJ2wmRho7nr+iO8qkwzge4HoVjJNoFCT6XG/0+reN
         PblzarBbgt8eNdL5UFxn+NS7PX4jqQmwMQcdVRdSk+1a/VXIxndWciVS9cWeTgV6gSE7
         K1EooAsWV3qTLkwkt3jsED8GVyHRMxDBSPJc8eOWgj7/i/E3rc5PJe8ux5fkFfuZ4ozp
         zCt2h5NyeMe9WzBUzLLc74qywRub+YrjwE8hhsquXTOoUDOB2E96Q2uCLuwQZuXUnpBV
         PpObH8j+ijYa/qQk/n+MrXDb+yPXrjb6nWyJeVgyQIv2FyPFuTMC9PtTrI/30oCorg+C
         wakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123005; x=1701727805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kx7LDUS3rY7lBdLFklcEVdSsIMEbcaAgKdOgd/PIIs0=;
        b=HFEgDozG8S5RG6Zkk0cluIQdKKunJgiZBf4A+Q+onUDMAAFVtiwoA3rxWu4yBtLUJx
         Md6VLXjD8ny/w9URRANKd1w/WWdlLRZxpbEO/5rFnzMIo5bzQBof5jgrFPYxYtLc3mWt
         5BZMtsfvPTQC2txRujsS5yt+qCu2bxvY5v/3CVp3Xs++hHsQcuo6RKEIzB3Q99362cPy
         fjL86YaFmN+maLxtgRu8R5hDHfc48h1jB9mOYeBVOWvJ9fdNH/LaMr41yAHwqlYRqvOP
         3/SGq+MnZB2P9tpXI0ONDpssesmmMcGh6t1sH0+f2rehq3D6nPaKRckLHCD0zhJSHObJ
         uyvg==
X-Gm-Message-State: AOJu0YyLutJm39ZYjTbzyqsLDfTY79nQm+SF1CF2vcCHfItHIOvQFGTV
        GehcxbGCsObVqzSUt7caFkwGY9oJipPX
X-Google-Smtp-Source: AGHT+IHwTOPDxEhKc7nYUbfhqyZJy/IY4/U9t9445mIszH9ERuGI/i+lfl5FPYsTbTCbarA2wQnGLHAPUOym
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a81:ad23:0:b0:5be:a336:4a6 with SMTP id
 l35-20020a81ad23000000b005bea33604a6mr478251ywh.3.1701123005663; Mon, 27 Nov
 2023 14:10:05 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:30 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-19-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 18/50] perf maps: Refactor maps__fixup_overlappings
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

Rename to maps__fixup_overlap_and_insert as the given mapping is
always inserted. Factor out first_ending_after as a utility
function. Minor variable name changes. Switch to using debug_file()
rather than passing a debug FILE*.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 62 ++++++++++++++++++++++++----------------
 tools/perf/util/maps.h   |  2 +-
 tools/perf/util/thread.c |  3 +-
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f13fd3a9686b..40df08dd9bf3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
 	return args.printed;
 }
 
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
+/*
+ * Find first map where end > new->start.
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
@@ -361,8 +357,22 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
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
+
+	down_write(maps__lock(maps));
 
-	next = first;
+	next = first_ending_after(maps, new);
 	while (next && !err) {
 		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
@@ -371,27 +381,27 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
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
-				map__fprintf(pos->map, fp);
+				pr_debug("overlapping maps:\n");
+				map__fprintf(new, debug_file());
+				map__fprintf(pos->map, debug_file());
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
@@ -399,7 +409,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 				goto put_map;
 			}
 
-			map__set_end(before, map__start(map));
+			map__set_end(before, map__start(new));
 			err = __maps__insert(maps, before);
 			if (err) {
 				map__put(before);
@@ -407,11 +417,11 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			}
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(before, fp);
+				map__fprintf(before, debug_file());
 			map__put(before);
 		}
 
-		if (map__end(map) < map__end(pos->map)) {
+		if (map__end(new) < map__end(pos->map)) {
 			struct map *after = map__clone(pos->map);
 
 			if (after == NULL) {
@@ -419,23 +429,25 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
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
 				goto put_map;
 			}
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(after, fp);
+				map__fprintf(after, debug_file());
 			map__put(after);
 		}
 put_map:
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
2.43.0.rc1.413.gea7ed67945-goog

