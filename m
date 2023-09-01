Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2979040D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351217AbjIAXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351214AbjIAXkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:40:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63F10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:40:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77bd411d7eso2267020276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693611606; x=1694216406; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eB4oWP+sj4jJGctwa58rr/GuM0cqux23570Qb65gZuU=;
        b=FeW10ZcH4DN6CoRPBuYmFjjm+OuUr3YC3Invb5XODmjo8yhSxkeRimMDu0g1yA9kSO
         LrKLf2A1ogjNA6j2DLDEc95xbFQigUMUUwWFHYBnF0jMe44vTW1Vrm2s4g6Gelgy1MoJ
         hoqAsvf7YqZcKpEcASUcYNbvGAnD+n6+75Xbb0jApvD+sxpAmtroWr6JNo0l6CuNH12J
         8c/g36NV+rTmmf3h9mhOzU+l4JX/iqe6gnyMHZAlVT/PdyhcaCwqfo09u5gKuwgsCC36
         qOwi7GEu/oTnv4n+9PPYO2tOHB9zA4xnSh+PStLDqU0LeyQoQLp3AZ6+PeD6q7lqHH3I
         nfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611606; x=1694216406;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB4oWP+sj4jJGctwa58rr/GuM0cqux23570Qb65gZuU=;
        b=Cl9PM4oEofzhjg6pl4TcHg59k/A1wkPL5cmaEAqrqsrg3TffUJ6HGCR4dE/vk4yi2J
         +GkLVnLeMJFX2FsENuNWirfCyTJAYD9knrfxq0Ka2VQ85GNVKtrpiVZOmcPIsqt0J0Y4
         WrtmkL/le5ms03a4jz+nLMv2bimB6UHEre5cNN4c5aAoD3HPhCZtehGUxAlv+FHJMLO/
         IzUgFbP86BvMoGJXrq9B2Rvuh1OgLFzFH6RMSvG1YhPPjejZyafYGo7pfPKqbANZnxjw
         dYg+JA99WCGpHf0n26V839DksJqC7vIYkgLT9RlEkA2pMq+ZKyIqjtgI8Z0AlYCxx/tN
         sV1g==
X-Gm-Message-State: AOJu0Yyxn7dikA1Vholz4B1MrqkBOsVzJWLD1lYvhgaM/EOZeMKB9VGJ
        Xvu+v8ikzHkeI8902uUmLk1HVQqBrPZB
X-Google-Smtp-Source: AGHT+IGcA6HbVMw9mggsHlnhKggKaSDYZBBXN5eJy9H8899D7UhSAZz44q7Ol39uD9OQ5EZD5+4NzmhHxOhM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51bc:d985:dbbd:10b])
 (user=irogers job=sendgmr) by 2002:a25:bb12:0:b0:d7a:6a4c:b657 with SMTP id
 z18-20020a25bb12000000b00d7a6a4cb657mr123912ybg.0.1693611606737; Fri, 01 Sep
 2023 16:40:06 -0700 (PDT)
Date:   Fri,  1 Sep 2023 16:39:48 -0700
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
Message-Id: <20230901233949.2930562-5-irogers@google.com>
Mime-Version: 1.0
References: <20230901233949.2930562-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 5/6] perf parse-events: Copy fewer term lists
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to add events to multiple PMUs the term list is copied
first as adding the event will rewrite the event's name term into the
sysfs and/or json encoding terms (see perf_pmu__check_alias). Change
the parse events add API so the passed in term list is const, then
copy the list when modification is necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 108 ++++++++++++++++++---------------
 tools/perf/util/parse-events.h |   7 +--
 tools/perf/util/parse-events.y |  17 +-----
 3 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 283c559a35b4..06a844bcce4a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,6 +35,7 @@
 extern int parse_events_debug;
 #endif
 static int get_config_terms(struct list_head *head_config, struct list_head *head_terms);
+static int parse_events_terms__copy(const struct list_head *src, struct list_head *dest);
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -1367,7 +1368,7 @@ static bool config_term_percore(struct list_head *config_terms)
 
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, const char *name,
-			 struct list_head *head_config,
+			 const struct list_head *const_head_terms,
 			 bool auto_merge_stats, void *loc_)
 {
 	struct perf_event_attr attr;
@@ -1377,6 +1378,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct parse_events_error *err = parse_state->error;
 	YYLTYPE *loc = loc_;
 	LIST_HEAD(config_terms);
+	LIST_HEAD(head_terms);
 
 	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
 
@@ -1390,32 +1392,37 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
+	if (const_head_terms) {
+		int ret = parse_events_terms__copy(const_head_terms, &head_terms);
+
+		if (ret)
+			return ret;
+	}
+
 	if (verbose > 1) {
 		struct strbuf sb;
 
 		strbuf_init(&sb, /*hint=*/ 0);
-		if (pmu->selectable && !head_config) {
+		if (pmu->selectable && list_empty(&head_terms)) {
 			strbuf_addf(&sb, "%s//", name);
 		} else {
 			strbuf_addf(&sb, "%s/", name);
-			parse_events_term__to_strbuf(head_config, &sb);
+			parse_events_term__to_strbuf(&head_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
 		fprintf(stderr, "Attempt to add: %s\n", sb.buf);
 		strbuf_release(&sb);
 	}
-	if (head_config)
-		fix_raw(head_config, pmu);
+	fix_raw(&head_terms, pmu);
 
 	if (pmu->default_config) {
-		memcpy(&attr, pmu->default_config,
-		       sizeof(struct perf_event_attr));
+		memcpy(&attr, pmu->default_config, sizeof(struct perf_event_attr));
 	} else {
 		memset(&attr, 0, sizeof(attr));
 	}
 	attr.type = pmu->type;
 
-	if (!head_config) {
+	if (list_empty(&head_terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
@@ -1424,14 +1431,16 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
-	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info, err))
+	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &head_terms, &info, err)) {
+		parse_events_terms__purge(&head_terms);
 		return -EINVAL;
+	}
 
 	if (verbose > 1) {
 		struct strbuf sb;
 
 		strbuf_init(&sb, /*hint=*/ 0);
-		parse_events_term__to_strbuf(head_config, &sb);
+		parse_events_term__to_strbuf(&head_terms, &sb);
 		fprintf(stderr, "..after resolving event: %s/%s/\n", name, sb.buf);
 		strbuf_release(&sb);
 	}
@@ -1440,39 +1449,52 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	 * Configure hardcoded terms first, no need to check
 	 * return value when called with fail == 0 ;)
 	 */
-	if (config_attr(&attr, head_config, parse_state->error, config_term_pmu))
+	if (config_attr(&attr, &head_terms, parse_state->error, config_term_pmu)) {
+		parse_events_terms__purge(&head_terms);
 		return -EINVAL;
+	}
 
-	if (get_config_terms(head_config, &config_terms))
+	if (get_config_terms(&head_terms, &config_terms)) {
+		parse_events_terms__purge(&head_terms);
 		return -ENOMEM;
+	}
 
 	/*
 	 * When using default config, record which bits of attr->config were
 	 * changed by the user.
 	 */
-	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
+	if (pmu->default_config && get_config_chgs(pmu, &head_terms, &config_terms)) {
+		parse_events_terms__purge(&head_terms);
 		return -ENOMEM;
+	}
 
-	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+	if (!parse_state->fake_pmu &&
+	    perf_pmu__config(pmu, &attr, &head_terms, parse_state->error)) {
 		free_config_terms(&config_terms);
+		parse_events_terms__purge(&head_terms);
 		return -EINVAL;
 	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
-			    get_config_name(head_config),
-			    get_config_metric_id(head_config), pmu,
+			    get_config_name(&head_terms),
+			    get_config_metric_id(&head_terms), pmu,
 			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
-	if (!evsel)
+	if (!evsel) {
+		parse_events_terms__purge(&head_terms);
 		return -ENOMEM;
+	}
 
 	if (evsel->name)
 		evsel->use_config_name = true;
 
 	evsel->percore = config_term_percore(&evsel->config_terms);
 
-	if (parse_state->fake_pmu)
+	if (parse_state->fake_pmu) {
+		parse_events_terms__purge(&head_terms);
 		return 0;
+	}
 
+	parse_events_terms__purge(&head_terms);
 	free((char *)evsel->unit);
 	evsel->unit = strdup(info.unit);
 	evsel->scale = info.scale;
@@ -1482,25 +1504,25 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name, struct list_head *head,
+			       const char *event_name,
+			       const struct list_head *const_head_terms,
 			       struct list_head **listp, void *loc_)
 {
 	struct parse_events_term *term;
 	struct list_head *list = NULL;
-	struct list_head *orig_head = NULL;
 	struct perf_pmu *pmu = NULL;
 	YYLTYPE *loc = loc_;
 	int ok = 0;
 	const char *config;
+	LIST_HEAD(head_terms);
 
 	*listp = NULL;
 
-	if (!head) {
-		head = malloc(sizeof(struct list_head));
-		if (!head)
-			goto out_err;
+	if (const_head_terms) {
+		int ret = parse_events_terms__copy(const_head_terms, &head_terms);
 
-		INIT_LIST_HEAD(head);
+		if (ret)
+			return ret;
 	}
 
 	config = strdup(event_name);
@@ -1514,7 +1536,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 		zfree(&config);
 		goto out_err;
 	}
-	list_add_tail(&term->list, head);
+	list_add_tail(&term->list, &head_terms);
 
 	/* Add it for all PMUs that support the alias */
 	list = malloc(sizeof(struct list_head));
@@ -1533,27 +1555,25 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			continue;
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-		parse_events_copy_term_list(head, &orig_head);
 		if (!parse_events_add_pmu(parse_state, list, pmu->name,
-					  orig_head, auto_merge_stats, loc)) {
+					  &head_terms, auto_merge_stats, loc)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
-			parse_events_term__to_strbuf(orig_head, &sb);
+			parse_events_term__to_strbuf(&head_terms, &sb);
 			pr_debug("%s -> %s/%s/\n", event_name, pmu->name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
 		}
-		parse_events_terms__delete(orig_head);
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, event_name, head,
+		if (!parse_events_add_pmu(parse_state, list, event_name, &head_terms,
 					  /*auto_merge_stats=*/true, loc)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
-			parse_events_term__to_strbuf(head, &sb);
+			parse_events_term__to_strbuf(&head_terms, &sb);
 			pr_debug("%s -> %s/%s/\n", event_name, "fake_pmu", sb.buf);
 			strbuf_release(&sb);
 			ok++;
@@ -1561,12 +1581,12 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 out_err:
+	parse_events_terms__purge(&head_terms);
 	if (ok)
 		*listp = list;
 	else
 		free(list);
 
-	parse_events_terms__delete(head);
 	return ok ? 0 : -1;
 }
 
@@ -2543,27 +2563,19 @@ void parse_events_term__delete(struct parse_events_term *term)
 	free(term);
 }
 
-int parse_events_copy_term_list(struct list_head *old,
-				 struct list_head **new)
+static int parse_events_terms__copy(const struct list_head *src, struct list_head *dest)
 {
-	struct parse_events_term *term, *n;
-	int ret;
-
-	if (!old) {
-		*new = NULL;
-		return 0;
-	}
+	struct parse_events_term *term;
 
-	*new = malloc(sizeof(struct list_head));
-	if (!*new)
-		return -ENOMEM;
-	INIT_LIST_HEAD(*new);
+	list_for_each_entry (term, src, list) {
+		struct parse_events_term *n;
+		int ret;
 
-	list_for_each_entry (term, old, list) {
 		ret = parse_events_term__clone(&n, term);
 		if (ret)
 			return ret;
-		list_add_tail(&n->list, *new);
+
+		list_add_tail(&n->list, dest);
 	}
 	return 0;
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 36a67ef7b35a..e6612856e881 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -209,7 +209,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *head_config);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, const char *name,
-			 struct list_head *head_config,
+			 const struct list_head *const_head_terms,
 			bool auto_merge_stats, void *loc);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
@@ -218,12 +218,9 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       const char *event_name,
-			       struct list_head *head_config,
+			       const struct list_head *head_terms,
 			       struct list_head **listp, void *loc);
 
-int parse_events_copy_term_list(struct list_head *old,
-				 struct list_head **new);
-
 void parse_events__set_leader(char *name, struct list_head *list);
 void parse_events_update_lists(struct list_head *list_event,
 			       struct list_head *list_all);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4fae7847d13b..1ee65f36762c 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -274,23 +274,18 @@ event_pmu:
 PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	/* List of created evsels. */
+	struct list_head *list = NULL;
 	char *pattern = NULL;
 
 #define CLEANUP						\
 	do {						\
 		parse_events_terms__delete($2);		\
-		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
 		free(pattern);				\
 	} while(0)
 
-	if (parse_events_copy_term_list($2, &orig_terms)) {
-		CLEANUP;
-		YYNOMEM;
-	}
-
 	list = alloc_list();
 	if (!list) {
 		CLEANUP;
@@ -320,16 +315,11 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-				if (parse_events_copy_term_list(orig_terms, &terms)) {
-					CLEANUP;
-					YYNOMEM;
-				}
-				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
+				if (!parse_events_add_pmu(parse_state, list, pmu->name, $2,
 							  auto_merge_stats, &@1)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
 				}
-				parse_events_terms__delete(terms);
 			}
 		}
 
@@ -337,7 +327,6 @@ PE_NAME opt_pmu_config
 			/* Failure to add, assume $1 is an event name. */
 			zfree(&list);
 			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list, &@1);
-			$2 = NULL;
 		}
 		if (!ok) {
 			struct parse_events_error *error = parse_state->error;
-- 
2.42.0.283.g2d96d420d3-goog

