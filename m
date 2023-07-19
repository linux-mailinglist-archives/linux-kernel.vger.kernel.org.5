Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3076758A01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGSAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGSAS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:18:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B8196
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso5493806276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689725925; x=1692317925;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQhjJCwCizVjI6zsBo644k5ejMqtTn3YGv7O61mhVz0=;
        b=i0TbVRn1nj8cogXXq+MgECyaLUZs/5vqRr0koKL2JFSQx9nXyET7zyPSab/r+ayTcH
         wNl82VZToSCfotazOs3Mzo9A5Ems8dkVSKLbLJQ51US38cPe1P09b9kNGpEtHXMn+zRz
         4NGv8BaH0+eJ2C9S2y4NTlSE4cXzkuxnenePKBH7Ew+Ad6/b7u3r12p4/YfQ79eHzXWs
         NqVMDOSP6e+tAgiK9PO61GPXhMTH0golvvVXIA0QuVXwoO4zL6X3+K4mM1s7Gd/oawaV
         jmzAmLabPVNa7vRUrUvPstW3q4vkhdc342QOEpulBzzK9MWlI0ROrdph3Kdb/uWuzNTS
         cmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689725925; x=1692317925;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bQhjJCwCizVjI6zsBo644k5ejMqtTn3YGv7O61mhVz0=;
        b=fNM1Sm4Q+fxzGDO/lA6NnZkpiPvonqZfAk53O4YGY4lRY+itALJpTP54FQTJdYxCrO
         L3+cfuwKlQT8Pmn8AbMAmjM195E6CCmiVzTSiz7SoBejpkXdROEOJtjuKl4GhajQQbG5
         PPQIXsdjL5DSju+IlAaJy9na5RmF3aZ1Y5C5SkEogAVR5DWG9OhzMdmA4hBN9fj197gx
         wfb8WGbMJL7wcySIB+K7EphyBoaqw2xyza0vOsDJSrukDU3c3ogoHNhKnzv8a4L+VEJr
         f3pnoUB6wEByEVBD3qyWvsFb+KwSvLrtvpTwpdnIUDqZACTmD8FyyBt4cYcQMGDd1cNI
         lfGw==
X-Gm-Message-State: ABy/qLYe/NVi43+3kVfb3UXc/yTqsZjEE+56T6aniJIxdR8+O8dDRSzv
        aOT740Zcpk2gUFBYkC1U5KaVDNeTj4UO
X-Google-Smtp-Source: APBJJlEg+bVWv7rHg8zTymSrEwYQ1XWBqOZtko3019L1wwD8uUHvQFedbBKmp/mm+sJJ9ko5JNlSv0dOzV6T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c587:348f:a079:d876])
 (user=irogers job=sendgmr) by 2002:a5b:a12:0:b0:c72:2571:bd9a with SMTP id
 k18-20020a5b0a12000000b00c722571bd9amr11695ybq.6.1689725924923; Tue, 18 Jul
 2023 17:18:44 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:35 -0700
In-Reply-To: <20230719001836.198363-1-irogers@google.com>
Message-Id: <20230719001836.198363-3-irogers@google.com>
Mime-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 2/3] perf parse-events: When fixing group leaders always
 set the leader
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel grouping fix iterates over evsels tracking the leader group
and the current position's group, updating the current position's
leader if an evsel is being forced into a group or groups
changed. However, groups changing isn't a sufficient condition as
sorting may have reordered events and the leader may no longer come
first. For this reason update all leaders whenever they disagree.

This change breaks certain Icelake+ metrics due to bugs in the
kernel. For example, tma_l3_bound with threshold enabled tries to
program the events:

{topdown-retiring,slots,CYCLE_ACTIVITY.STALLS_L2_MISS,topdown-fe-bound,EXE_=
ACTIVITY.BOUND_ON_STORES,EXE_ACTIVITY.1_PORTS_UTIL,topdown-be-bound,cpu/INT=
_MISC.RECOVERY_CYCLES,cmask=3D1,edge/,CYCLE_ACTIVITY.STALLS_L3_MISS,CPU_CLK=
_UNHALTED.THREAD,CYCLE_ACTIVITY.STALLS_MEM_ANY,EXE_ACTIVITY.2_PORTS_UTIL,CY=
CLE_ACTIVITY.STALLS_TOTAL,topdown-bad-spec}:W

fixing the perf metric event order gives:

{slots,topdown-retiring,topdown-fe-bound,topdown-be-bound,topdown-bad-spec,=
CYCLE_ACTIVITY.STALLS_L2_MISS,EXE_ACTIVITY.BOUND_ON_STORES,EXE_ACTIVITY.1_P=
ORTS_UTIL,cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/,CYCLE_ACTIVITY.STALL=
S_L3_MISS,CPU_CLK_UNHALTED.THREAD,CYCLE_ACTIVITY.STALLS_MEM_ANY,EXE_ACTIVIT=
Y.2_PORTS_UTIL,CYCLE_ACTIVITY.STALLS_TOTAL}:W

Both of these return "<not counted>" for all events, whilst they work
with the group removed respecting that the perf metric events must
still be grouped. A vendor events update will need to add
METRIC_NO_GROUP to these metrics to workaround the kernel PMU driver
issue.

Fixes: a90cc5a9eeab ("perf evsel: Don't let evsel__group_pmu_name() travers=
e unsorted group")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index f10760ac1781..4a36ce60c7dd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2181,7 +2181,7 @@ static int parse_events__sort_events_and_fix_groups(s=
truct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader =3D evsel__leader(pos);
 		const char *pos_pmu_name =3D pos->group_pmu_name;
-		const char *cur_leader_pmu_name, *pos_leader_pmu_name;
+		const char *cur_leader_pmu_name;
 		bool pos_force_grouped =3D arch_evsel__must_be_in_group(pos);
=20
 		/* Reset index and nr_members. */
@@ -2215,13 +2215,8 @@ static int parse_events__sort_events_and_fix_groups(=
struct list_head *list)
 			 */
 			cur_leader_force_grouped =3D pos_force_grouped;
 		}
-		pos_leader_pmu_name =3D pos_leader->group_pmu_name;
-		if (strcmp(pos_leader_pmu_name, pos_pmu_name) || pos_force_grouped) {
-			/*
-			 * Event's PMU differs from its leader's. Groups can't
-			 * span PMUs, so update leader from the group/PMU
-			 * tracker.
-			 */
+		if (pos_leader !=3D cur_leader) {
+			/* The leader changed so update it. */
 			evsel__set_leader(pos, cur_leader);
 		}
 	}
--=20
2.41.0.487.g6d72f3e995-goog

