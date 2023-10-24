Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD17D5E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjJXW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344644AbjJXW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:27:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517A1700
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb3a59a19so2859931276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186332; x=1698791132; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiRI18wPFPsoj3esFQh9IhgomcBelp5JaqZwyCYVfWY=;
        b=zSTUS5jdV7rKsOD7wncjVXcyqL1sOPHzXG2/a9kSRAwf3/XvbAHBV5zrQ8WsLWkVCk
         efbjbuAfjgH0FNr5pR251us6BjWcJHX8KZHGzNjnXM9N8F5NSklkreiQEKXnOUyNxP3x
         eq6QeDZ289YikNgPMqhf3xSLXd0fCmYu/+t9g8n1Zat1fJM0f52DAuEHuKdkgNTvtkSS
         n7kaGgZXC+gNxiwEcvEXbEs7GtKxegcL9JXCfVHjB2KInCWV3sqH+s+0qymhutcxAooN
         jVlDCUZXEcHqVf5uA817QVZWRlYKJPmgK1+MwEAUnj8P3EXu8KkLT/5C+lOqK37g/oEm
         6gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186332; x=1698791132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiRI18wPFPsoj3esFQh9IhgomcBelp5JaqZwyCYVfWY=;
        b=p6KQRxU9mgzaXnPvzvwXTuqRN1sZ1D55s6TIUUHuMMvov2jYvqiUQ7oYM3y3RkWlXy
         bTa0pQpds1up2Bm6o49vr3W8qEWglgnP73T26HVK33BI2USAp1nBvsAEBdFjkvWr9cWR
         X/MtAe4LJ0hdWZwZPhDyTjQUa0h42aDKAe6qF6GQyavnFpgLykC+tqhLD4AO2kE3Ha2Y
         t0IRxhgY0Xi0xkwB6+CntVZAiTFACNxla5B8BHdGsTjiRZTmsOpR5HXOLkXyHE/vPTrk
         NvrtcIz3dDCbrwFEofRKcVRG+MGaGTZxka5uSsBQ95YJWfRQcvmjrvdvRwW40I7BzcA3
         75aw==
X-Gm-Message-State: AOJu0YydrdDxFBz4/iOekgFfmkhKIOeVmAPXcgNzIPaEbyrgfg6NBqQs
        pHoI50P2eUOPu47Hvk9O1Hxx/477GyQw
X-Google-Smtp-Source: AGHT+IGXDkdr+GYf3+Uii128YBRB9U48VI5EbuLEHC0IkaHgNqKm9aqVymDt2TgW9D08iv713nCAp1+H/yHP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1743:b0:d9a:50d2:a8be with SMTP
 id bz3-20020a056902174300b00d9a50d2a8bemr262421ybb.1.1698186331901; Tue, 24
 Oct 2023 15:25:31 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:38 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-36-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 35/50] perf maps: Add find next entry to give entry after
 the given map
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use to remove map_rb_node use from machine.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  7 +++----
 tools/perf/util/maps.c    | 11 +++++++++++
 tools/perf/util/maps.h    |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 191e492539e5..ab345604f274 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1759,12 +1759,11 @@ int machine__create_kernel_maps(struct machine *machine)
 
 	if (end == ~0ULL) {
 		/* update end address of the kernel map using adjacent module address */
-		struct map_rb_node *rb_node = maps__find_node(machine__kernel_maps(machine),
-							machine__kernel_map(machine));
-		struct map_rb_node *next = map_rb_node__next(rb_node);
+		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
+							 machine__kernel_map(machine));
 
 		if (next)
-			machine__set_kernel_mmap(machine, start, map__start(next->map));
+			machine__set_kernel_mmap(machine, start, map__start(next));
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 9a84d26328a7..38d56709bd5e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -662,6 +662,17 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	return map;
 }
 
+struct map *maps__find_next_entry(struct maps *maps, struct map *map)
+{
+	struct map_rb_node *rb_node = maps__find_node(maps, map);
+	struct map_rb_node *next = map_rb_node__next(rb_node);
+
+	if (next)
+		return next->map;
+
+	return NULL;
+}
+
 void maps__fixup_end(struct maps *maps)
 {
 	struct map_rb_node *prev = NULL, *curr;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index b7ab3ec61b7c..84b42c8456e8 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -136,6 +136,8 @@ int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
 
+struct map *maps__find_next_entry(struct maps *maps, struct map *map);
+
 int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void __maps__sort_by_name(struct maps *maps);
-- 
2.42.0.758.gaed0368e0e-goog

