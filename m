Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974937BAF35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjJEXLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjJEXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C3185
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8040b2ffso22549897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547344; x=1697152144; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVKoLuc5a7LEHlQh90vyaH3VbvcXZG1OCxjaJSmoY8k=;
        b=uZVuZXdwF+UaQzN+j5ci/zOPDWqvXBGviotmMlC1ioE/3wiNDwWySHYd75Gm8qezlH
         0uQX1dMtw1/zgS3ZA3Y73XsCeReO6sN8AWcnZXRh+scinxEslZZydX/du0KVM/evNW4O
         5pNMkqYqfEGXrRaV2A0W6Zp+V8dKCPcF2hn6ZkSRC9k7tkgTu5YlHwb1e1N6GuzqH75f
         GP6nx3NHo7LwHIK49uZd1YGkFk9W7CYnD3IXwj2n3mJBZLriaMbnUjtd90i/ClVZtljJ
         +/OXre5yLaaBZAts79ki+gWCPQVWR33Dzvzm5yqmZZOK6/taF7TA34YLkqJEsAP0IgMj
         88DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547344; x=1697152144;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVKoLuc5a7LEHlQh90vyaH3VbvcXZG1OCxjaJSmoY8k=;
        b=khFTgjcQ/jeGIYqKJwqw/9foJpNEJgXZ2FDYPdtyvWR2kli/eFrzIiIfOpx+OAWG3Y
         NvB05OBzSPI3Kg55cmCFQ5nL0NHr1KNJ/cRUiATzARBEVp8Tuj8N3l0SideyYwx3fgSL
         pYURLUqyOrUoQiB85ETJi7LLfi4drIWZtnfm3nSlk+JorGGxl3p0SDUwyUy3/WCRLMEz
         pXA2hBjm6BGC8RN9PgDEO6Csv1mCYl9L4PcjapO/RCi01iCn6jBEb733ZXW+BzFhY28m
         SwZNuzG9YXQTxsuyvYXvy3vau8JmPI6AXprrFC18fHB/djkA1+CtnKV+gqPfByQH45p3
         Kj8A==
X-Gm-Message-State: AOJu0YwBGbOl+/Pz78+ZOrytfdNLUQsGVS9zGShmvchSV+4FiQZO0eVE
        jQ58Hd5k/DNZj8FQleVryXkOnl/rzU5I
X-Google-Smtp-Source: AGHT+IHo6U+kJASF6nCohpjFiAn0CLPcx5Qb6otqZC+Kpf+MOzGXa7HHf6AdITUGY7vbn2be8G5F1c0EEIDU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:d4d1:0:b0:d81:7d48:a459 with SMTP id
 m200-20020a25d4d1000000b00d817d48a459mr114013ybf.8.1696547344121; Thu, 05 Oct
 2023 16:09:04 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:36 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-4-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a -checks argument to allow the checks passed to the clang-tool to
be set on the command line.

Add a pass through -header-filter option.

Don't run analysis on non-C or CPP files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 scripts/clang-tools/run-clang-tools.py | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 3266708a8658..f31ffd09e1ea 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -33,6 +33,11 @@ def parse_arguments():
     path_help = "Path to the compilation database to parse"
     parser.add_argument("path", type=str, help=path_help)
 
+    checks_help = "Checks to pass to the analysis"
+    parser.add_argument("-checks", type=str, default=None, help=checks_help)
+    header_filter_help = "Pass the -header-filter value to the tool"
+    parser.add_argument("-header-filter", type=str, default=None, help=header_filter_help)
+
     return parser.parse_args()
 
 
@@ -45,14 +50,27 @@ def init(l, a):
 
 def run_analysis(entry):
     # Disable all checks, then re-enable the ones we want
-    checks = []
-    checks.append("-checks=-*")
-    if args.type == "clang-tidy":
-        checks.append("linuxkernel-*")
+    global args
+    checks = None
+    if args.checks:
+        checks = args.checks.split(',')
     else:
-        checks.append("clang-analyzer-*")
-        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
-    p = subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks), entry["file"]],
+        checks = ["-*"]
+        if args.type == "clang-tidy":
+            checks.append("linuxkernel-*")
+        else:
+            checks.append("clang-analyzer-*")
+            checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
+    file = entry["file"]
+    if not file.endswith(".c") and not file.endswith(".cpp"):
+        with lock:
+            print(f"Skipping non-C file: '{file}'", file=sys.stderr)
+        return
+    pargs = ["clang-tidy", "-p", args.path, "-checks=" + ",".join(checks)]
+    if args.header_filter:
+        pargs.append("-header-filter=" + args.header_filter)
+    pargs.append(file)
+    p = subprocess.run(pargs,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        cwd=entry["directory"])
-- 
2.42.0.609.gbb76f46606-goog

