Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9A766477
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjG1Gtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjG1Gtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:49:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752403A8F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583b256faf5so29870027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526984; x=1691131784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C14Lkth5YhYGrilJLa3as9gLOwkujqv4yqaGCfXT1cI=;
        b=pTjgM814griVQd95nxRaERmRO4ta0it5y0NikLDzqte4Dxn2OcWCpUMVSOvdBGreHj
         PZJRS4r4rVxhf29d7VG6q96fZkFs1VfPbiGyiQrPDC6Q9vUxd2rIephumHnoDhePDv2s
         dZbeVLCAvL5Q+Mv4ZDP+F2ec55M3eGwo3vCBg8m30lXOcsi/8UbFGTLKyJw4IeRjmbFD
         kTV85zxQ5M5/yBE4/QrnJEK2Mn1TnBXO1PxDUJWAlKuX+PuB0RRx31rFWa82I+LvrfuM
         iww3QIxpJUoNGzIl7w8eydhXRjvGgmD818Sy6noQENKa3nyDJQixl0m0FI6X5wuwbhVr
         Gg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526984; x=1691131784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C14Lkth5YhYGrilJLa3as9gLOwkujqv4yqaGCfXT1cI=;
        b=TyC5zy1JSQ9M7fZR5xy4aBT1Y4I21cUKAImIA5hAvOu2WTZ6yu3xY5xC3RavYrGJjl
         GKsL4w1BaXgetIKtwzmHnv4xFNx+BSdvbn3aVwycKINSSN11mx7OlNZAxhGzDGPUSLou
         W0JuU0RgqXzsJwFyZIntaFAcklp1QSqGihdmHX2rZO1+Xv+nvun+06+xg5+NaGvj5Ezy
         Ti5eZWSSX+l/te3v/90zqPXmRPrVe4Mhox05QCLwOO6S/aH7+JEfytSwSxdKLGxdx5wE
         CvEZhKss0Xb5g7kfydYtMqolNLmGK5PB5m4jRQuSEC4elBJL7gpAm4ijwLX6PB714RRr
         xjig==
X-Gm-Message-State: ABy/qLauvGUbPlWyO+HLvYFTG6A2KbalJc85T5qlIFjvhVpmd+e+3Kzb
        h4DqI3kxFeAuRmFEJ5epIXLvdexvCgg7
X-Google-Smtp-Source: APBJJlHY5OrUkocwZKG462E8XmaFPEseNqQWvhpbV4IL+1aqabtUQ0n/nVuKjAoPgqFX/ErHS1qmqEk8D1gC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a81:c509:0:b0:583:9d8d:fb0d with SMTP id
 k9-20020a81c509000000b005839d8dfb0dmr10517ywi.0.1690526984540; Thu, 27 Jul
 2023 23:49:44 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:12 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-2-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 1/6] perf bpf-loader: Remove unneeded diagnostic pragma
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
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

Added during the progress to libbpf 1.0 the deprecated functions are
no longer used and so the pragma can be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 44cde27d6389..8f4c76f2265a 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -32,9 +32,6 @@
 
 #include <internal/xyarray.h>
 
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
 			      const char *fmt, va_list args)
 {
-- 
2.41.0.487.g6d72f3e995-goog

