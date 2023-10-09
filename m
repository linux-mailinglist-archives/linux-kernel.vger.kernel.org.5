Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7A7BE9E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378290AbjJISkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378420AbjJISkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:40:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E56D4E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:40:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8188b718so77598497b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876801; x=1697481601; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=06hv2eld/xw44RWn1xr2U+JITsXhvfwVgHKkxYlHPQ2wasN7Ofou0pUc3CoXr40ImG
         qNR2LlZ8MvLg6cNPhr9P2c7dmwXgQmo9Nnfc1/DUy85azjOubC+p31Q14GZ0G9/Vtg+Z
         oPc8KxwtQcwOMXO6VFfVwWcDpeHCbd/2jOTjXg4xDBWzuMNHHXT4X09J9e3vpQlqh5MV
         gawWuoboJtTEerxO9qEZqgXvGwMXiZG6mxTFVkgdreC+sNzfqDhtevV1bD3L+k2gV1D7
         hyx4Ztm9+4LmZC7Ccs/auboXubItxm4aE+XkD0rkoHIcBeuLWs6ngFRxTVMMtRxuSmPh
         cQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876801; x=1697481601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=mIQeR7oxQ7DcshkmECyEOAc/WmMfiIkU3rYKSO6l1RqctdDHSCu15oeKgDWE2iYYng
         OjjddXHA2ns+XLFFU+XSo8bqr9XU1A2kNRgeohL8quY8TlyqRJC1ekqp/lMPESWfCJE7
         FVODv0aJUDfXwiDvmsEjGTl9KTCm+jfYmpWQjUQOgL3NuJmTiQDYP3br7JPWV0oaIcR8
         VHZuIgPJ48h5r1kNUGrA4ZVNCNUctRHJqt5L++FKrNu34kmAdQeIvyAZZGq+pAhAEBKW
         Dw5ddRlpKpXJMz3TA87Q+Ws1z3zpFgXfTBAKv5JrpTCzQGhKPJTmlkc0b///POuNhuni
         g0cA==
X-Gm-Message-State: AOJu0YztZ8iBr2cnzSVFSoJRz+7ydOgrEC/GSn+t0N3UDAecEZf3AUuv
        O46ZPHhzXv4drwtursQd49QZogzYredv
X-Google-Smtp-Source: AGHT+IHv/D+bxgRzhvH5SJtdaUWM0vtK5Kcw+aA2tiW8Y4QaDfmm5vLlI9ULokvCKbvDQyU/3LpdJsz6h2n6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:a849:0:b0:577:619e:d3c9 with SMTP id
 f70-20020a81a849000000b00577619ed3c9mr336831ywh.10.1696876801567; Mon, 09 Oct
 2023 11:40:01 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:16 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-16-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 14/18] perf parse-events: Fix unlikely memory leak when
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
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

