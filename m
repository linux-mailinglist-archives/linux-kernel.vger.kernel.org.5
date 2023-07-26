Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F67637B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjGZNhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGZNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:36:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668E1734;
        Wed, 26 Jul 2023 06:36:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb7b8390e8so22745035ad.2;
        Wed, 26 Jul 2023 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690378612; x=1690983412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qde5oqHOAvsDSREhKG9It0ouCEwVKT5mPlK+bDyfn8=;
        b=rneJtUcl30vC39kDvh6x+a76gLDmYJAkBzKP7aG3pFg1C3ryu8gJfBnKVm70cc3+LQ
         uBirqVzGIsqygHIuus6YjLwNCf8VYDUOorB/g0f1dg2gHb+IXNYlgvOibtpmUGAOvSpz
         +a3AVG1chnPpM/dm1/0uzr4gfPxFSoIwQuPH7t0NWyv8IOTlazh9dVQohPwaHh9vHF1S
         ieF2yle5Lymz3dF5RDIlqoZztGg78FyY1ifDXn1Ly7/tymZ9tFhu9BKgTLN8+dko+iYp
         4GRCMGREZe6uPhRLHX9l/dluODpWd8qM1STadRcugZN9TojqXqA83DdZGcWxtnDAu5G3
         ercQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378612; x=1690983412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qde5oqHOAvsDSREhKG9It0ouCEwVKT5mPlK+bDyfn8=;
        b=KIbCxMzNXwoj9/MUu7cHaWZc1GWMHULQtHXhOosaM8ihHtG+QaQXM818QheI7VCMK4
         UcFbQPJdNB//za7UsUWUdAWLcEIn7LGVZWfRZ0sv4LAHXl3c6AtoT4pzpTM+lMJ8dyCu
         phVl3Sx6GPDmofEi8+45yG/j+P47bY7QOPmDh0oAQyi6yA7vIeJmNHPYNpjBV8PkWjEr
         rTP/ZTV0DQFkBL2lSLTj3hkwck9d8ruakFNCimnGO6do0NuoH8S6kOb+Gix7SX26DfhY
         lb0HZNTxX1KGBIGO2ngbgFP3M85CvvxO/Z7+req188M6jevnCMwMCkdTNf/Du62RIvyO
         QA6g==
X-Gm-Message-State: ABy/qLah+KzNKpNjRsD/dVVsyVzGJVbM7fHw05Un07UPWvFB6GV8qPO2
        FbMyVNCoQTu5SoiAg7rF4WA=
X-Google-Smtp-Source: APBJJlHG2scKX86QkShM+T+SiQW+luLXUkOMNb1/y4zZzKHvkDQFINn7xy0QEl2wpBRdLQKvelvW8g==
X-Received: by 2002:a17:902:d487:b0:1bb:c5b5:8353 with SMTP id c7-20020a170902d48700b001bbc5b58353mr2195782plg.4.1690378612102;
        Wed, 26 Jul 2023 06:36:52 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([114.129.115.132])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001b8baa83639sm13206369plr.200.2023.07.26.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:36:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] perf build: Include generated header files properly
Date:   Wed, 26 Jul 2023 06:36:42 -0700
Message-ID: <20230726133642.750342-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726133642.750342-1-namhyung@kernel.org>
References: <20230726133642.750342-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flex and bison generate header files from the source.  When user
specified a build directory with O= option, it'd generate files under
the directory.  The build command has -I option to specify the header
include directory.

But the -I option only affects the files included like <...>.  Let's
change the flex and bison headers to use it instead of "...".

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 tools/perf/util/bpf-filter.c     | 4 ++--
 tools/perf/util/expr.c           | 4 ++--
 tools/perf/util/parse-events.c   | 4 ++--
 tools/perf/util/pmu.c            | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12e80bb7939b..82c42c46d886 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -999,7 +999,7 @@ such as "arm/cortex-a34".''',
   _args = ap.parse_args()
 
   _args.output_file.write("""
-#include "pmu-events/pmu-events.h"
+#include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
 #include <string.h>
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0b30688d78a7..47f01df658d9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -9,8 +9,8 @@
 #include "util/evsel.h"
 
 #include "util/bpf-filter.h"
-#include "util/bpf-filter-flex.h"
-#include "util/bpf-filter-bison.h"
+#include <util/bpf-filter-flex.h>
+#include <util/bpf-filter-bison.h>
 
 #include "bpf_skel/sample-filter.h"
 #include "bpf_skel/sample_filter.skel.h"
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4814262e3805..7410a165f68b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -10,8 +10,8 @@
 #include "debug.h"
 #include "evlist.h"
 #include "expr.h"
-#include "expr-bison.h"
-#include "expr-flex.h"
+#include <util/expr-bison.h>
+#include <util/expr-flex.h>
 #include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index acde097e327c..f3773467c103 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -18,8 +18,8 @@
 #include "debug.h"
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
-#include "parse-events-bison.h"
-#include "parse-events-flex.h"
+#include <util/parse-events-bison.h>
+#include <util/parse-events-flex.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7f984a7f16ca..b6654b9f55d2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -19,8 +19,8 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
-#include "pmu-bison.h"
-#include "pmu-flex.h"
+#include <util/pmu-bison.h>
+#include <util/pmu-flex.h>
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"
-- 
2.41.0.487.g6d72f3e995-goog

