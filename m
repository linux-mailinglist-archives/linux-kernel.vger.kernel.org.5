Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7B7BE9E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378287AbjJISks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378311AbjJISkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:40:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F44E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:40:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23fed55d7so77429577b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876799; x=1697481599; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niI1DS8q+ZbexmAiDdLr0rnTr4377R73icOoozlTydQ=;
        b=rXsOoCOi9IoLNymI/T09YYIpQk2fwalh+/sjgLoOz68oak642mvan2IHzdQ4lFkG9C
         qTDkmTDdRFdiOi/tIuqRosf8PTUh4R/3RDUMvBsPVFwqKrcElx4eB4/KGcZ4ugGHhR4q
         6+UdrZ7knDyTRPrVQY5TysvxoGbDYKxYPyGtKLW7srpiDu8nTMdEH2p+ZHfgSkxck40k
         Q7QhWMoWIg1JlRT1FdvDOtxBJGgPOstnjpNtOD2cTbk8vRRZNFCw/x88Anev4FS7hmnI
         URIV8lpxbzse82ysu662VNHxzQnipW52Xfr2GyeANJmk93kdWXZjdBrMuq2jb91uxRjd
         g8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876799; x=1697481599;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niI1DS8q+ZbexmAiDdLr0rnTr4377R73icOoozlTydQ=;
        b=WS8EAWMctc51mKpgf35EOhFlSNo4hIKOlEf02bZGibUi//ak+BMnqOoav3t8Og3N5H
         4JGjMAwQDNDzdRTPyp9I6SyBwJDkE8FGvRwaeaOtWJDpmajh0p7QcUrkpOAKa7c+tdXR
         83xkZ8eFb9/YffyPglA45OGyts7tDx+AjGWgeudKGo9TTZx3f3c9F+klSPqx5ppZ0gwi
         2AJgV6XnSBBNAkpcb4F9ZLhVStkkAw1+xxEJyPhHjwXOHI+M0B9awrHgBi5vXfkwQhGK
         SS02XG34gSu5xQ0kJHgRalXEdG6GvHDo5UPQlGpGZFKhxvXC+jLNSVuREnqzd5SirD/N
         VCVw==
X-Gm-Message-State: AOJu0YxF2hauZn6trJQBv2ZWpK7d1zkS5oVyNFGkdTBCsOfOWDHJAk11
        74SSVM+U+wMkzHFImACgOclGFZRi+A6z
X-Google-Smtp-Source: AGHT+IHVauHFJJ6dURYCURIsUyMaH8uHK9E3Vkz92KCp4HMULUMevSk/Te5SUgiu4nvqqGfnHApJa8igvKfI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:bcd:0:b0:d7f:2cb6:7d8c with SMTP id
 196-20020a250bcd000000b00d7f2cb67d8cmr247211ybl.13.1696876799415; Mon, 09 Oct
 2023 11:39:59 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:15 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-15-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 13/18] perf lock: Fix a memory leak on an error path
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memory allocation fails then the strdup-ed string needs
freeing. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fa7419978353..a3ff2f4edbaa 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2478,6 +2478,7 @@ static int parse_call_stack(const struct option *opt __maybe_unused, const char
 		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
 		if (entry == NULL) {
 			pr_err("Memory allocation failure\n");
+			free(s);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog

