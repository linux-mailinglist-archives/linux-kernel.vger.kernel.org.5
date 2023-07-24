Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6F760050
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGXUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:13:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FB10E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:13:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d114bc2057fso1635460276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229581; x=1690834381;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEagIzbSR+iB7PSrtUC5DfVnlIQ8QvGcLEq0hl6k6cA=;
        b=j2eqq8QJfxe5onO/aGVvaZmBZjt/wIF7SaMZOFFFIBmta/BHNLFdiK8Q22j/eX09oZ
         w0dHp+SS4oB8TAwI9U1Thqt3j09spPnfcwI5kYPTP6gIVsRyjJHjWvvzSLslo5YYpeoN
         c2hboVA2Xj41u9rSGKt+XtGy2WWpRd+D5CYDFN6InkvFRRqrqencUeV1GqGIh6jl61n7
         b0eNVnasnKfepEZSJY8N3RZ1gOgZfudCajlb88Bm5NjCpYtXm+lCAc1tmM9BAwtyUUlH
         y67MvoHn0sz9nUTZCUbw2FJ2VKENjbcoNmOlh8rmbn5beNZ12CP1T7kwYUaSKiKFCwFp
         ShAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229581; x=1690834381;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEagIzbSR+iB7PSrtUC5DfVnlIQ8QvGcLEq0hl6k6cA=;
        b=HwKSGnwxVBNQ4SWDopFwnMgF9faXJTYElh1Pd5t0IG+U1ataHWizd2dTsRECARVjnR
         1GkPbUvoSbk8wtjpVtLhVzKU8hFbEe4mISTeFDjBTg1axKatpzh6DAiSnnFGMkCrweSa
         pAaF7JPNj3kNl+Mum1NyVMtW04IUkkZS+Ufx/2PDmum89kPoosHUgeG2z5cqAMEeD/7L
         Y5gfi+pu9fDbS4RTndzLqywwGBYbICh7tUHlUDGrMGEfIb3ZoU8/fx+elku5+45Y1NGb
         XlUVo9dzqYis0/D8emv8tb7p/+58P5u0wdAvsqKxSuWlUQ6GylfGtw7X9Wb8UmkAszUo
         zBWA==
X-Gm-Message-State: ABy/qLYKcQJvOCGZV51Lz78nyQ0EtMGizJCWpvvnQ/bCsn7xZOIGjV3T
        J2Y+DOGFn+iIWC/adV6Fr1XSuzWKM9Af
X-Google-Smtp-Source: APBJJlGTgMXHdweJXUUP8uwI0itLY4YWQi+grIGikzrinhegW1hUjINBGxYjKS5buICDoHMRDOoVHCAWEx5B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a25:d156:0:b0:d0e:e780:81b3 with SMTP id
 i83-20020a25d156000000b00d0ee78081b3mr21789ybg.2.1690229580852; Mon, 24 Jul
 2023 13:13:00 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:12:46 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-4-irogers@google.com>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/4] perf test: Avoid weak symbol for arch_tests
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     maskray@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC LTO will complain that the array length varies for the arch_tests
weak symbol. Use extern/static and architecture determining #if to
workaround this problem.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1f6557ce3b0a..5291fb5f54d7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -33,9 +33,18 @@
 static bool dont_fork;
 const char *dso_to_test;
 
-struct test_suite *__weak arch_tests[] = {
+/*
+ * List of architecture specific tests. Not a weak symbol as the array length is
+ * dependent on the initialization, as such GCC with LTO complains of
+ * conflicting definitions with a weak symbol.
+ */
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
+extern struct test_suite *arch_tests[];
+#else
+static struct test_suite *arch_tests[] = {
 	NULL,
 };
+#endif
 
 static struct test_suite *generic_tests[] = {
 	&suite__vmlinux_matches_kallsyms,
-- 
2.41.0.487.g6d72f3e995-goog

