Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7857E7580
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbjKJACV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbjKJABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:41 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8D4C28;
        Thu,  9 Nov 2023 16:00:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-282e3beb418so1387360a91.0;
        Thu, 09 Nov 2023 16:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574453; x=1700179253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBPueJvgwiS4jbMZ32+YHhWj7LPDThqjPdS48KXuEko=;
        b=UrghWcXLKPW7mopPOEUgxZlMZI+CtiysiZ2TXGkze24aQ1nKGMiWARmzScNRMQZ7RJ
         Sfxep8kPlxQ+ADLhgODqbFXdW+eD8IFGxl3+3ND/vyzFxaB7N+vozb0tqhaYxW6bI+Zk
         Ht4zH2LMqRjD544qNt0tkrd7jY4IKhelhuzFMm8/O5kwGrgLObCCr9oAavNyTzrQCVlR
         5abiBjwtcyuNsQL5aLQjxgpVEeSz0Hj4ZvkRqqow5zMi3IfqqqziucEZF4VnySJ9Lqi4
         AOEQjS7dSnEJ1ListPKwYVQA5i7yrIuYkn2LJ9QbmJgyUTjD0j1rUEx5maK4qbnzXZfh
         VD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574453; x=1700179253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBPueJvgwiS4jbMZ32+YHhWj7LPDThqjPdS48KXuEko=;
        b=KimWzzlh58lduIiEtiAyXAp4Q8l8h8eWcmFKV0nbMUQ4d2OrEJt1B+zECSm4xM1trz
         2cQNMM0T9fQpdM+u1x9yeZuOZBRx75OPBxg6SpHKs2DvZuvtaN7+4LwSCl0y039rfDU3
         w6L2dlgY3WkoXVVLEAYQE6rwF7VmkJrthYf4wsgS9cwh5nL6/j28ozTy/vaETRCgXGtC
         /wI1BeE7P08mcvhVyTQfvfv1YzOYW/6HoMwbStlNIECYhGrR8AQe5jkZG0Xyf2fYZyME
         3c1sv3D9mSFwmtFkMC+RFxxRN0smsvk3oYdk6rWty/2whrEQJVpD9KyptiMVBCyM/uYS
         +Lnw==
X-Gm-Message-State: AOJu0Yy2NmZMFkhThDi9sZmhZP1ghqx4LC6SMNSq/32txqIihoyTuTaB
        9UAlDrVSZ7HPbSzeVHOEdgo=
X-Google-Smtp-Source: AGHT+IGXhnm2PrbjKXH9oJ3EqaCbBZdb/2qU0WaQVC9ZbmHqg1p2uSRGngvgatFefhxbYMDult/NBQ==
X-Received: by 2002:a17:90b:4c10:b0:280:c0:9d3f with SMTP id na16-20020a17090b4c1000b0028000c09d3fmr3411524pjb.34.1699574453531;
        Thu, 09 Nov 2023 16:00:53 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:52 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 25/52] perf annotate: Support event group display
Date:   Thu,  9 Nov 2023 15:59:44 -0800
Message-ID: <20231110000012.3538610-26-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When events are grouped together, it'd be natural to show them at once
like in other mode.  Handle group leaders with members to collect the
number of samples together and display like below:

  $ perf annotate --data-type --group
  ...
  Annotate type: 'struct page' in vmlinux (1 samples):
   event[0] = cpu/mem-loads,ldlat=30/P
   event[1] = cpu/mem-stores/P
   event[2] = dummy:u
  ============================================================================
                            samples     offset       size  field
            1          0          0          0         64  struct page     {
            0          0          0          0          8      long unsigned int  flags;
            0          0          0          8         40      union       {
            0          0          0          8         40          struct          {
            0          0          0          8         16              union       {
            0          0          0          8         16                  struct list_head       lru {
            0          0          0          8          8                      struct list_head*  next;
            0          0          0         16          8                      struct list_head*  prev;
                                                                           };
            0          0          0          8         16                  struct          {
            0          0          0          8          8                      void*      __filler;
            0          0          0         16          4                      unsigned int       mlock_count;
                                                                           };
            0          0          0          8         16                  struct list_head       buddy_list {
            0          0          0          8          8                      struct list_head*  next;
            0          0          0         16          8                      struct list_head*  prev;
                                                                           };

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 89 ++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2290ce3bdc2e..7e4ef93b19a0 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -330,19 +330,64 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 	return symbol__tty_annotate2(&he->ms, evsel, &ann->opts);
 }
 
+static void print_annotated_data_header(struct hist_entry *he, struct evsel *evsel)
+{
+	struct map *map = he->ms.map;
+	int nr_members = 1;
+	int nr_samples = he->stat.nr_events;
+
+	if (evsel__is_group_event(evsel)) {
+		struct hist_entry *pair;
+
+		list_for_each_entry(pair, &he->pairs.head, pairs.node)
+			nr_samples += pair->stat.nr_events;
+	}
+
+	printf("Annotate type: '%s' in %s (%d samples):\n",
+	       he->mem_type->self.type_name, map->dso->name, nr_samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+		int i = 0;
+
+		for_each_group_evsel(pos, evsel)
+			printf(" event[%d] = %s\n", i++, pos->name);
+
+		nr_members = evsel->core.nr_members;
+	}
+
+	printf("============================================================================\n");
+	printf("%*s %10s %10s  %s\n", 11 * nr_members, "samples", "offset", "size", "field");
+}
+
 static void print_annotated_data_type(struct annotated_data_type *mem_type,
 				      struct annotated_member *member,
 				      struct evsel *evsel, int indent)
 {
 	struct annotated_member *child;
 	struct type_hist *h = mem_type->histograms[evsel->core.idx];
-	int i, samples = 0;
+	int i, nr_events = 1, samples = 0;
 
 	for (i = 0; i < member->size; i++)
 		samples += h->addr[member->offset + i].nr_samples;
+	printf(" %10d", samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+
+		for_each_group_member(pos, evsel) {
+			h = mem_type->histograms[pos->core.idx];
+
+			samples = 0;
+			for (i = 0; i < member->size; i++)
+				samples += h->addr[member->offset + i].nr_samples;
+			printf(" %10d", samples);
+		}
+		nr_events = evsel->core.nr_members;
+	}
 
-	printf(" %10d %10d %10d  %*s%s\t%s",
-	       samples, member->offset, member->size, indent, "", member->type_name,
+	printf(" %10d %10d  %*s%s\t%s",
+	       member->offset, member->size, indent, "", member->type_name,
 	       member->var_name ?: "");
 
 	if (!list_empty(&member->children))
@@ -352,7 +397,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 		print_annotated_data_type(mem_type, child, evsel, indent + 4);
 
 	if (!list_empty(&member->children))
-		printf("%*s}", 35 + indent, "");
+		printf("%*s}", 11 * nr_events + 24 + indent, "");
 	printf(";\n");
 }
 
@@ -396,8 +441,6 @@ static void hists__find_annotations(struct hists *hists,
 		}
 
 		if (ann->data_type) {
-			struct map *map = he->ms.map;
-
 			/* skip unknown type */
 			if (he->mem_type->histograms == NULL)
 				goto find_next;
@@ -419,11 +462,7 @@ static void hists__find_annotations(struct hists *hists,
 					goto find_next;
 			}
 
-			printf("Annotate type: '%s' in %s (%d samples):\n",
-				he->mem_type->self.type_name, map->dso->name, he->stat.nr_events);
-			printf("============================================================================\n");
-			printf(" %10s %10s %10s  %s\n", "samples", "offset", "size", "field");
-
+			print_annotated_data_header(he, evsel);
 			print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
 			printf("\n");
 			goto find_next;
@@ -527,8 +566,20 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			evsel__reset_sample_bit(pos, CALLCHAIN);
 			evsel__output_resort(pos, NULL);
 
-			if (symbol_conf.event_group && !evsel__is_group_leader(pos))
+			/*
+			 * An event group needs to display other events too.
+			 * Let's delay printing until other events are processed.
+			 */
+			if (symbol_conf.event_group) {
+				if (!evsel__is_group_leader(pos)) {
+					struct hists *leader_hists;
+
+					leader_hists = evsel__hists(evsel__leader(pos));
+					hists__match(leader_hists, hists);
+					hists__link(leader_hists, hists);
+				}
 				continue;
+			}
 
 			hists__find_annotations(hists, pos, ann);
 		}
@@ -539,6 +590,20 @@ static int __cmd_annotate(struct perf_annotate *ann)
 		goto out;
 	}
 
+	/* Display group events together */
+	evlist__for_each_entry(session->evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+		u32 nr_samples = hists->stats.nr_samples;
+
+		if (nr_samples == 0)
+			continue;
+
+		if (!symbol_conf.event_group || !evsel__is_group_leader(pos))
+			continue;
+
+		hists__find_annotations(hists, pos, ann);
+	}
+
 	if (use_browser == 2) {
 		void (*show_annotations)(void);
 
-- 
2.42.0.869.gea05f2083d-goog

