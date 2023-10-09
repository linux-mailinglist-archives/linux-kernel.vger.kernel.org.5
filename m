Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0897BE9D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbjJISj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378229AbjJISjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD7113
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a507eb61a6so73204577b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876782; x=1697481582; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=OFk3wZEKRbsVyMjM+9CyBIeNKC7CQOS4Q3CWIkEQeGHzOExrefIAwk74TnX0ULOJ7g
         gf2IuNSvlsl6dvg/i0SupHeYkkjvTdsN7bOvIrT3Z8mPfIqG5UwbhXnLDT9Qzb+ofA9o
         HyUTVuUVnDK32cxvmyg8rgr7yhi41QWGmryGHjD/04A3i5Ndq4WdtcKveOiTnf2Z/Ids
         fxdQrTkfCCthLonmrUPnKPeMCQ7gBZQeY8Orn3AIDZnPR/NZdyg+syaOlLsXOnLfPYyq
         8iz4w7NCFe1pxo4AUhRpECmwBxRKhlL6r7B7HFXOLzS0b+sH04tgW4CxBktzn0hfnTYM
         FyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876782; x=1697481582;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fapvG1sgoYBqHgoFOW9TcSIAiI5hx1hj0GAN7+v4jh4=;
        b=TfPAT+t2iRNfczKuKQoMhOK0cLp5W//Ls9dgrB/8jB2BNZ8xGaBnp0Yt+ZXf39qpkG
         tbAyH7O4dN95IbEraED25auW9yIFyyHwvea6UJy0rjnRdCrgJX81a/JDhiinF18Ll3a8
         qxYNYTtQAxWFU237kyo43+zWR3epv+9Z4NAZ+GTzsl0sIv0ShOlykq4X1omvXB6qRimV
         Qg2x3pZfv7x3kPaSzWuaeuhXJGVeMcaSnIenLSbS21QuIMxtOyN22d8GFfelaksh/d+A
         nD7iDfMqhox5OIJNwRzvSTc4zS7Lt98655eVN705szTVt9mrEy/26iNhuNOrePD45MIZ
         jgCg==
X-Gm-Message-State: AOJu0YxfvXR2YUemwTdX9tXSYEw6CiQK2ynVcGeFWD1SkGw2gOsKl1hs
        F3zmkwdofyxtkg7IsgwZEqEq6aDX+/PB
X-Google-Smtp-Source: AGHT+IFF5Ce3xTASsAOk8I7voMtqVFZ/Fie+83QxW2GS/qJ0vRq1xrYlGTONWtgU9T98ME4DI6ky2PLg0Jc+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bc03:0:b0:59b:c6bb:babb with SMTP id
 a3-20020a81bc03000000b0059bc6bbbabbmr297631ywi.6.1696876782479; Mon, 09 Oct
 2023 11:39:42 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:08 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-8-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 06/18] perf env: Remove unnecessary NULL tests
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-tidy was warning:
```
util/env.c:334:23: warning: Access to field 'nr_pmu_mappings' results in a dereference of a null pointer (loaded from variable 'env') [clang-analyzer-core.NullDereference]
        env->nr_pmu_mappings = pmu_num;
```

As functions are called potentially when !env was true. This condition
could never be true as it would produce a segv, so remove the
unnecessary NULL tests and silence clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index a164164001fb..44140b7f596a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -457,7 +457,7 @@ const char *perf_env__cpuid(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->cpuid) { /* Assume local operation */
+	if (!env->cpuid) { /* Assume local operation */
 		status = perf_env__read_cpuid(env);
 		if (status)
 			return NULL;
@@ -470,7 +470,7 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
+	if (!env->nr_pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return 0;
@@ -483,7 +483,7 @@ const char *perf_env__pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->pmu_mappings) { /* Assume local operation */
+	if (!env->pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return NULL;
-- 
2.42.0.609.gbb76f46606-goog

