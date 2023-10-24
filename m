Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2C7D5E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbjJXW0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbjJXWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BF19BA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so63563787b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186323; x=1698791123; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rha7reTjPPM+nzq3LN9RJmw1LRSN6MIopdCvqO71wM=;
        b=Ost0D5OmJOXGh20juf/FD6edHdPvqW/aaozKCA/p7a9Xmt2BL/grhJR1BT1OlnmYkR
         O1WK7OAbpP165tAHj8f120CT5kA/i8q+nEZRWKoFCc04uD4HghMXSAlPjaQ0OGTPTGYQ
         oCpIbKcHxFMgp/7H4V/igcOpjmZRz+cQym5q2czRrAHJ/cKAe3ieEmILlVVnKuYVb5um
         Wq3w1dZ56F5U4hjKxlPqNG7zbr6NV3lWFZJ9dIJMteDATZCd8shzvxMIGBc7jZdWL5Xe
         Z56LLihOfT4C//k3ursYKY7vVXWApYSBDaeEnq1HEo14yGiHZiq0es1bH52DJizT70Tj
         Y5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186323; x=1698791123;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rha7reTjPPM+nzq3LN9RJmw1LRSN6MIopdCvqO71wM=;
        b=C/618W/tOuDnhw0oYTT7ELlu++gHuRn7WfaqMQqLgzhwiBvIjWZzmuk+wAI0FyGc7U
         YsY/ImBfjSOLU/XDloL4hhKu6c2/BRbTOpRdXXjRr0silAAAls7yV+aYjMn9Z/tWMUf8
         EtBLDsE3mu7Liu3jBD99xD3DiF2AHgTHMqwnbR5RFy0kn51szfQIPkEbUjObbgd8k2Br
         7uFIdBrRg4UabsFb/DTH5gJ7ylEkl6NzO20ssf72oCQ0f9PeQz8G6MjlrT3S5qjlZwY3
         epPHpKXgWM99pT9GGltHFUNvp86J3hdO5pmGFEKlNdTiXEtVarq7Yk0BcQSFUe7jzrJO
         f4/w==
X-Gm-Message-State: AOJu0YyjP/ZVmkoSH0qwp5MecYE0dn5vp76sDnTj/YsGHIeKfuIVjUHs
        9ZeIX+UvXiz73oeOciLpMuXKJaHa/Oo3
X-Google-Smtp-Source: AGHT+IEuzboFi7UOqNWMU63JIXbWil3EAbmEgQQAQaaqXHU3yBam5F3N1ob6b62CzeCzwT3Hk2QV4PYjgyma
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:d05:0:b0:d9a:5b63:a682 with SMTP id
 5-20020a250d05000000b00d9a5b63a682mr239523ybn.13.1698186322987; Tue, 24 Oct
 2023 15:25:22 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:34 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-32-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 31/50] perf maps: Refactor maps__fixup_overlappings
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2b938ccbfe3e..cab818af6787 100644
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
2.42.0.758.gaed0368e0e-goog

