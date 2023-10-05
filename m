Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E427BAF31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjJEXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJEXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271DD67
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4f2b6de8so23690777b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547368; x=1697152168; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3q7J1zaKrxcJsN5cKPHsdKPNVlGGTILkxMs0fP/b8pI=;
        b=th/zkdUVIH9RNTZAxrSbaoNWz9FU7rplWE/5lMyqV9j6eK94Xs8BYTH0egZpLx5m/0
         Uv/SHZJTdT5NFRxBcipJKQaM6joZ0nancKx2wFtQomGJ9cDUbgP7TrqSqNM2+VHTue7F
         SPHtbuJPSedwcCcVlm2xqRHu65Zv86ZYPnN7Tbl/c5sWgS6xUEbrmfmA3f19P9eXKFex
         5RQYTfc5PvE18ZMNNhYzfGqJuL6FAoJ+vyagfyk9nfpJBdz0s24E3yf2hZjgHTmA+513
         49Lhsg40XkF1tdZhmhIpQwae9c/7sEMuKpqTqHhPQftTeuSJMVWJeo14InAbLRRdFT33
         UZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547368; x=1697152168;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q7J1zaKrxcJsN5cKPHsdKPNVlGGTILkxMs0fP/b8pI=;
        b=Ad4omQVV+31v4e53lEiQ1xUtHScCRVoF2q/D8EOiheuhzUOYimf+PeitfZAt2W1CbB
         dm72ZwkmMNOr2xjtviNUugQfeeY+V3Dad2EhMaPOBiGhdB/8h/SUGZmF2/ae5EXacfJh
         QIQOGfJ0+mH4HnipVVWBCLbMWHSBwFjh7bx9hv7p7XpNOIX8cEI2blSmGl/GRMrJiDIu
         8sV6Ny3RvpN76M4nq75MbQPyL9bucoqBuF0nc+CuAhaJLRZtPQb9Gp2WDfAl9cVddB5N
         3+COZBrEVJ7gK5UKfwCPCZt2onsXHjxh5BMQeTsmYg7SOUPvEa/0x/ftako/SjLJpmMr
         kQiA==
X-Gm-Message-State: AOJu0YzI9ayaSVpfx5K/a8jPpSKmQnx8HA3HYVLv2MqcpvWZkA3kGpKv
        6OkaXbWsQ7kyFl4rVl4poGSgB/q6/gcy
X-Google-Smtp-Source: AGHT+IEV9eKUl8jHouya/2mrGEIvTy7eAbccM7CjR+efeiDf6wWkcXilTE2icrLHqdeRcbaf181kT4qfwnl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:a8c8:0:b0:592:7bc7:b304 with SMTP id
 f191-20020a81a8c8000000b005927bc7b304mr115386ywh.8.1696547368133; Thu, 05 Oct
 2023 16:09:28 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:46 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-14-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 13/18] perf svghelper: Avoid memory leak
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On success path the sib_core and sib_thr values weren't being
freed. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c   | 1 +
 tools/perf/util/svghelper.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d4b22313e5fc..1b40b00c9563 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *opt __maybe_unused, const char
 		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
 		if (entry == NULL) {
 			pr_err("Memory allocation failure\n");
+			free(s);
 			return -1;
 		}
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 0e4dc31c6c9c..1892e9b6aa7f 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
 	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
+	int ret = -1;
 
 	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
 
@@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
 
 	scan_core_topology(topology_map, &t, nr_cpus);
 
-	return 0;
+	ret = 0;
 
 exit:
 	zfree(&t.sib_core);
 	zfree(&t.sib_thr);
 
-	return -1;
+	return ret;
 }
-- 
2.42.0.609.gbb76f46606-goog

