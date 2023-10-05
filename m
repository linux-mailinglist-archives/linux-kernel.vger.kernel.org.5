Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5C7BAF33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjJEXMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjJEXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE0137
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so1903632276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547370; x=1697152170; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=qjtCvls5v8mag+wFClqLuBaKLzk6ijHeHJt4XcHzOxbnR1rQR1spiwejCbu0YVBuI/
         cluu6B6kbyRaJ1sb5HPqGcTgislwsIrmQWi158NgzXwvwL7G13hlOacWou+SijnRv0Lo
         Mw8ClDoyvOpV0QXDm7rs1UPsVGFLhLeuc3XkQv+MctNpbw8bmo8B+dsSdPqVLo6sKQb3
         gIbydW4Zzvx9cGBKz9yPKhnhXDRW1YOvrOvPJzkQd3ctbyWpOWoDfLx4UoF4RvTkgU0y
         9O4Gn02xioFzNdYrO0/maAxkgco11ttZ63P+F9/y/OpL6PXFG6fPbXb4iH9+7TQidOgx
         AWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547370; x=1697152170;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=Hvpzsns7n4q1psc9lNcIGwAiJifhNKmyornCrK63sjZ+P2JLp24yH8JrCxWT+vkqMX
         G1A1dBV25wFCbGSCLtsSssgZ5YvMJgu+ulR8p7m2gAE7kcfP418TfNuo5QNLMy1Eba57
         LYOn5/ChbOwe3DMXbd92UhhKHMcm9qJ2ehderLPaN19p5ei1RuqI9nsr6SfpKNIzQBxu
         yKYA3qFRZf72pUzOOvqp5wXxkAxVc6lk/HsnpnNGDTOOWz9ADzBuwMRY4eNaH0NWgg0n
         wCyP/uGfRdddEAsIU8HLIExzybjebwlTtMlJs5bN3cj5xWJ6UMbZZrkhfgGDSm8V3GkN
         2Y/g==
X-Gm-Message-State: AOJu0YwfoqkttFhFGGmmv5wTzSpMJ9GVZDjwQKV/eomL3BvAqHAspdfN
        2rR41D9uPBpMgHCFWjndlZuTFh7Lcaw7
X-Google-Smtp-Source: AGHT+IEgTi3PLG+3o2WWDEFrIlbIkR+q1EaEaSDVhwE+qexUhANhreJWyGErr61dmZWaJXVBJMGi41ML+jYa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:74c2:0:b0:d7b:9902:fb3d with SMTP id
 p185-20020a2574c2000000b00d7b9902fb3dmr105008ybc.0.1696547370559; Thu, 05 Oct
 2023 16:09:30 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:47 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-15-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 14/18] perf parse-events: Fix unlikely memory leak when
 cloning terms
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing free on an error path as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..23c027cf20ae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2549,8 +2549,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, /*num=*/0);
 }
 
-- 
2.42.0.609.gbb76f46606-goog

