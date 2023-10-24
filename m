Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040E57D5E28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbjJXW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbjJXW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:27:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163510F4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ee6a1801so63570507b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186345; x=1698791145; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/kNgXH1Uh+lkDKn4udeU01EF+mxZdpavmj5nGxyL2A=;
        b=XvJXOZLyXI3pgqCPjcPyjhB/+6CS50YS/z6g04SRTQdp3wZ+Ct5TwGaohC3c+kvMFW
         VxPrRlzdeSmaqV44r0kHCXNm5yBNk3UfUCVXUMmtcJwc650v8sdh1I0WVDFB/OwZ3x2o
         3KbU1FRFVi+WAxU9u3xo4sTczU97ySsf7Y544dtcz/lbS6TLSCRoYhnlpBwHOeeZH5Cy
         sSOdnBbDOrhzdbRlwSBujoXqW/mk8bw7/x3yElFW+MPDWEHiAtvtx3Zis5Hih/3T1Z1L
         jTPQTU0iBufLjZTqaBXalfjhpwfGuG8Bi+Pl+jeCDD7kk19uxzHogOYK8hlwrgZL6BLU
         wvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186345; x=1698791145;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/kNgXH1Uh+lkDKn4udeU01EF+mxZdpavmj5nGxyL2A=;
        b=cH+RXUP7ixVClAqPRGmJvwT+sxHy31FFqPBOZRjJMPIEEs0BUwkcbDn5xz6vYxYt1G
         w6VFUsb/I74kia+TPArsQ3ZEM7M+5c16FPZm5c/QNNnlm8BlgNg7LusIhwfzqXA8lqH5
         ma2VLOGOC0srJO4iWG7c8wgJCFF5jfZ0CJAM5SE9zC7gdLAH8zqjjMGa879gg96+7uLS
         ciPtCgZICvD9cTxrOSZzxQlYJQELQGYkrAJzPSm3tr34R0/Gsvdr1T/7KPXw8z1aEI/W
         gZzm1eZjw+Z+TtDijsQBByGUDBzgCNXoInYI3yGee6SmXwclk6aLz/VOrAUIaKZqQU9H
         9b/A==
X-Gm-Message-State: AOJu0YwtuKPwK+L0N7JN0XmCoBuuFO7TS26s7Pxn3b9LLO7Zm0ww5lio
        Yg+VpqIc9npp/rUSOzc84YROZGvmGvVW
X-Google-Smtp-Source: AGHT+IEZn/79C0WxXeapm9MG7+V0rd8DVy1PiiAJtvyIYSGp0278m4lV2yy0OiU0jNwiItS3x7WOE65BqKFM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:aa45:0:b0:da0:3e46:8ba5 with SMTP id
 s63-20020a25aa45000000b00da03e468ba5mr57420ybi.8.1698186345124; Tue, 24 Oct
 2023 15:25:45 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:44 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-42-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 41/50] perf maps: Get map before returning in maps__find_next_entry
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d6b3f84cb935..42d73f00f9c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1758,8 +1758,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 8a8c1f216b86..b3937e734cbf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -942,7 +942,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.42.0.758.gaed0368e0e-goog

