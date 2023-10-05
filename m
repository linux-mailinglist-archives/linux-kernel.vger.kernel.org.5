Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14D7BAF49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjJEXW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJEXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:20:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB0B19B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d4bbfc7so22026157b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547366; x=1697152166; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=AqNhgrFbRKtUQdWQjxRR5EHYfMMb4DG7jZ19gCcE2xsMbDVRxvMRvV3uQm8kEO0/n9
         cvwinzb6BPcWY6ewNPjPyu2Sb6s5j+LsUrcuuv2i6JgKzd7GU0bayM6KhdV5l3nmfFY2
         Ox9N1RhODCo7vjmHbsW1t+5XX3riysjwC55idTsfAdcp7A84jggSp/2VzdvdyLzUl4Lb
         VUr5WIjeyZt91oKbAshQ3V85qHwFNlW4CMj6FVa1lzlSoqtkr+w+m1bB45g7OrQjD9t7
         368B3Xurb29JH/Z/asL0n7/I6bwqChboHNOJB2wqUtt22LskCAnRDoJPVGiOLMGSsytI
         h94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547366; x=1697152166;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSqAvWdBbUtQxC7pnyJJtR4WVxr7hcg6OVnTaxh+F6M=;
        b=UKBQxC9F4V9OUk6IHfZBzOIxnOREXyvdS/DIknKieA3UC0u8B53THwowmlmsnHNpIv
         J0x4lyNIgjcbQs0Ti34JmLZ4r58Lyp9zQatkBUa9b0Tt+9AlhT6E7HbZ2vOk9+UwuGWH
         L2cx0infXhcvAlN1RNnLuEOmvOxfaIE8A7xuCJEYJ6/Zb06eJKGoUm0F/2zSVK/GO9Ha
         gAousE1sNsEZY2KR3VEpyBYzav5dfWK1IQD1gK1Q/DGPGQCkFFFcuKq79Pxg8eo1rxj0
         OcftzTQlQYCby+mSsmK4PVeaPp697RX1bltuAkpwTAaspZRzTNpv6QywMD3cgeqLEQxA
         YvXA==
X-Gm-Message-State: AOJu0YzfBN2NU2D06n3mmoSErceW0KXHmLq4t7NUBovNnhXmIGf5TCfe
        59cVHge46dCR6fyaP6oHiatK72u57Kf8
X-Google-Smtp-Source: AGHT+IEYRgFM2NV2BQHADakfTQjBrB/7bt9C3vOnga95X2gYJqpyJ21VOHkHsl8QQL8bn7YhF9HuuYUts//N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a05:6902:181a:b0:d89:3ed5:6042 with SMTP
 id cf26-20020a056902181a00b00d893ed56042mr106147ybb.11.1696547365955; Thu, 05
 Oct 2023 16:09:25 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:45 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-13-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 12/18] perf hists browser: Avoid potential NULL dereference
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

On other code paths browser->he_selection is NULL checked, add a
missing case reported by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f02ee605bbce..f4812b226818 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3302,7 +3302,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 							&options[nr_options],
 							&bi->to.ms,
 							bi->to.al_addr);
-		} else {
+		} else if (browser->he_selection) {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-- 
2.42.0.609.gbb76f46606-goog

