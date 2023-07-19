Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2C758A00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGSASu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSASo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:18:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B9E134
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso42513537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689725922; x=1692317922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzZfmowfpaOAxfw4qEjYh3Dd4yzwOwjsuGJmX6Wkr1Y=;
        b=JlGx8OjDED/9mGbeDU0purblcp19YsAhhm1yfmMZ5AxoB5/YnBIVJ/U+xIe03wLKmZ
         KF045vV6VIxDYj67PwbuF6ceSylQbxVCDPbUn9W+wXvL/fdkQPPQNXt6qOzJd0aioqru
         LL55ddw9h6A+ybAxScavuNT3dw4seXKoJ4LOIjLjVxHs6TAw7NpQbdssGguG+n60DshU
         iUD522FEt7WLwEErStpyo+Dp1IgZFHnwau4a9j4FI7Wc/CzQ0HVo9GevlpRV6tFjPdxQ
         aT4XxWx40ZtmI31Koarzs2xCPGSXSj6nUoHSxwvI630sTTaZpZ5CJn3n+/PSAx0wXvxH
         7ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689725922; x=1692317922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzZfmowfpaOAxfw4qEjYh3Dd4yzwOwjsuGJmX6Wkr1Y=;
        b=cbSfsxps48XklisU9Xdg6eUO51pgApaLr5EGoND0WbgcB+qi/2zLEEoGVyGOhlBzJL
         oiv4NcTauw1dWlLDcuQe6NywqVBNFDVy/kxF8W01UacYHz98qXEzCVD0Oop5dXsx5p5a
         cRBp6e0je91SD7ysp0BoJSHsauRnBKAcCSJ1Do2uUJp2rrenZI4BA8t711ItB9xxmCp9
         Y5gTzDQMYSPZInTpWs2ZMMEa7p/uxztzT5fj8nPyicSccIC32k4IzKgKmi362Udq/Yvp
         tTRIlWXOxRN62dqGo/g25L0csgwZY+bkBQgldH+ciwPjuk+euIlqBYS3D0lq8GwVlUX+
         bTyg==
X-Gm-Message-State: ABy/qLbltfb6IDJQzblssnpwRU7biCG5CpZIDzMeggl9e0nXsz9fLDmI
        dN9lzyClPu15x5sHLPztU3hlKDv7scp2
X-Google-Smtp-Source: APBJJlGoqw5slG37ZamIc0FtM+3St0BI0iyNqMpsLcXhIrObXzSVzC4tb8ifO4A5x/NN2TV3wfKqESDC4+Gt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c587:348f:a079:d876])
 (user=irogers job=sendgmr) by 2002:a81:8d51:0:b0:579:fa4c:1f22 with SMTP id
 w17-20020a818d51000000b00579fa4c1f22mr191864ywj.6.1689725922615; Tue, 18 Jul
 2023 17:18:42 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:34 -0700
In-Reply-To: <20230719001836.198363-1-irogers@google.com>
Message-Id: <20230719001836.198363-2-irogers@google.com>
Mime-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/3] perf parse-events: Extra care around force grouped events
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf metric (topdown) events on Intel Icelake+ machines require a
group, however, they may be next to events that don't require a group.
Consider:
cycles,slots,topdown-fe-bound

The cycles event needn't be grouped but slots and topdown-fe-bound
need grouping. Prior to this change, as slots and topdown-fe-bound
need a group forcing and all events share the same PMU, slots and
topdown-fe-bound would be forced into a group with cycles. This is a
bug on two fronts, cycles wasn't supposed to be grouped and cycles
can't be a group leader with a perf metric event.

This change adds recognition that cycles isn't force grouped and so it
shouldn't be force grouped with slots and topdown-fe-bound.

Fixes: a90cc5a9eeab ("perf evsel: Don't let evsel__group_pmu_name() traverse unsorted group")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..f10760ac1781 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2141,7 +2141,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	int idx = 0, unsorted_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
-	bool idx_changed = false;
+	bool idx_changed = false, cur_leader_force_grouped = false;
 	int orig_num_leaders = 0, num_leaders = 0;
 	int ret;
 
@@ -2182,7 +2182,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		const struct evsel *pos_leader = evsel__leader(pos);
 		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
-		bool force_grouped = arch_evsel__must_be_in_group(pos);
+		bool pos_force_grouped = arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
 		if (pos->core.idx != idx)
@@ -2198,7 +2198,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 			cur_leader = pos;
 
 		cur_leader_pmu_name = cur_leader->group_pmu_name;
-		if ((cur_leaders_grp != pos->core.leader && !force_grouped) ||
+		if ((cur_leaders_grp != pos->core.leader &&
+		     (!pos_force_grouped || !cur_leader_force_grouped)) ||
 		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
 			/* Event is for a different group/PMU than last. */
 			cur_leader = pos;
@@ -2208,9 +2209,14 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 			 * group.
 			 */
 			cur_leaders_grp = pos->core.leader;
+			/*
+			 * Avoid forcing events into groups with events that
+			 * don't need to be in the group.
+			 */
+			cur_leader_force_grouped = pos_force_grouped;
 		}
 		pos_leader_pmu_name = pos_leader->group_pmu_name;
-		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_grouped) {
+		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || pos_force_grouped) {
 			/*
 			 * Event's PMU differs from its leader's. Groups can't
 			 * span PMUs, so update leader from the group/PMU
-- 
2.41.0.487.g6d72f3e995-goog

