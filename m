Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3327ABDF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIWFhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIWFg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432910E3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c2ca3bcf9so52539537b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447364; x=1696052164; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5vqIfXNWliDocU8tzStcp+r+OU5EjvAXvx9gVnGgcs=;
        b=GhGHPD2qvlwf6DPEFJ+9yvS+OHNHzTKjhuNdApz5z/GoqKX68u3AFI4wayELNU/30Y
         uqWwzPKCLls98voX1c3ZEoR0IIWdaw2l2YKBbZL5/bOb67lRDSQjuiuinpGDQJIzZ1Xe
         +zEwKIC34AdfWybCaqoHYKlTD/fTkn+g9M/dmHawF+giGaLFT+8zlSm6plTrql/TlRD9
         QcwWV4t4QCd+tQTvo4iH3BTJLd8lTcKOdP8liGHVFmVCQ1HqzArTeiRLonqw+oSZMy+K
         rvpNNmXWQSX1PB6aOznwwoP5ooJJ0m81SD4y2DYhB2cvAyDxfpkHTcdgzl6tRNNCubf/
         wK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447364; x=1696052164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5vqIfXNWliDocU8tzStcp+r+OU5EjvAXvx9gVnGgcs=;
        b=ZGviwdhIuONc6pmL6w3XTDZKdfUTMf/HS+//DlSRWYltw3M0ULloDB7ClE2fvvjsK1
         Aih2hLSdv5yzFK5NI9FSWViwx/xVO+oczY1z09YpHOdGk7BnwppgSv4eUvvNykoa4f53
         9fLcEuUpjn6g9ycfNoJVWxrPQQvlGjtm27B7nNLJVgii1RbTNtePBSdg2hZV2hYD0R7M
         vbAD1gxg24ijJ1VLLd9+QdA42NiPnlzDCSTTebmp6IWuBcLknFEvwB2w+xr72jsvmnjY
         lpTm/x4rgNhGQquNDcLRffABgcNUXo9bZR6K53m9iC1gUG3MaXSjcrlch8fcADCi0nMs
         kw3w==
X-Gm-Message-State: AOJu0YzEEd7wmaLjEdo8lOyLrnwqxdLlRPWILOM3zSWaVZIXz9wvJaVc
        F8oDndo8MDNfxPIokPLnmLWIekQq8v2H
X-Google-Smtp-Source: AGHT+IEsgOcl2A0UL8zGlp3FXRaWIZMQmNaQRl2Uoy/Z9jK5/KtmB2FVYeGP9zN3vSGo3xTtN8wODP+0jzxj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:264b:0:b0:d7f:8e0a:4b3f with SMTP id
 m72-20020a25264b000000b00d7f8e0a4b3fmr12822ybm.3.1695447363914; Fri, 22 Sep
 2023 22:36:03 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:09 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-13-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 12/18] perf hists browser: Avoid potential NULL dereference
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
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
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
2.42.0.515.g380fc7ccd1-goog

