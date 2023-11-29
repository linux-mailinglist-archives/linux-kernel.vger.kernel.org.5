Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6077FE216
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjK2Vey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjK2Vev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:34:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849595
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b2153ba1so4572177b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293697; x=1701898497; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0vBYr5JM7GPlHuM+wfhHkEVfDthy0I/VW5myloZwv8=;
        b=kegeFLM6hm8HwUxPO/LU0x+VB0Cp2vfgNxzFroEx+HwG89uxGg88vtxvIDe3wUN1aT
         aXPwxc45UNO2o6zW9gCY7hnqkFUnReL62w839oNTy8IuBILVnFxVNOaEMs5zgQ4zB6xi
         vIdjIUkMoQwWJkcnEkGjCIdibgtB4qVKRsf9zrnmTNWF6/jvG02HfX7fxKP/FLYIwOhN
         V4VUFX8TR3Szft76yo7dl20kl2mx5ZpONrEYG+Dm0qI5g7TG4HgNnURYofwl79cBEqzg
         Auheu2y9H7wC8GKQjM7nYRN6H+NEhFK8VjNavZN2Kg5AqbzczHAcJmEMoOsp/Qs1qwI1
         Hfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293697; x=1701898497;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0vBYr5JM7GPlHuM+wfhHkEVfDthy0I/VW5myloZwv8=;
        b=HWIerJNvDEBjfy4+K6TH8eNteuJQ8frwc/Hmv22k4qVstUMG7EPDak6v7hhFmhzl/u
         Qhdm9jjJtYZq8+9zVUQg/cB5zfnwd0lc5ATEwYpBKS2KLLkw8LRKtvMkzJqasEpPDFEd
         b57zCrxg9X3ug3SQ4daGIS47Ie6ZDkd1CiftncK+dajnF7IUsFH5FaqtkqOiSi3FVeYp
         B3wn7XOFV6/vyosWfBUO8n5gRJJwSjjnQbaqs6MkrXAIrnhRzjiLHrMgvdbl2CZmhaiL
         QIQ0xrRx4FPvA0VyEN3lX7lstaTzQ9wOr72qxBx1NIfcGUWz4Vp2onmfyG2M06U4rlog
         2oaQ==
X-Gm-Message-State: AOJu0YwEr3TMDbrswMJ05Mz5WI+j+uIMVDYgQ1C9DVjMJQb7hHEztVlD
        QwWS5rp1Oj+LkcdrS8fp0/cysYwd37Sx
X-Google-Smtp-Source: AGHT+IFwVkcH7Zb7hs06bJ3a0wb4DBQ6crLz02hS8w2L/4ueyja0cSGDE086Z9HIoY0ycPGKG6M8/fjTMPNG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:842:b0:5cc:cd5e:8f0e with SMTP id
 bz2-20020a05690c084200b005cccd5e8f0emr583925ywb.0.1701293697326; Wed, 29 Nov
 2023 13:34:57 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:34:27 -0800
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Message-Id: <20231129213428.2227448-3-irogers@google.com>
Mime-Version: 1.0
References: <20231129213428.2227448-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 3/4] perf test: Use common python setup library
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
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
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

Avoid replicated logic by having a common library to set the PYTHON
environment variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/setup_python.sh       | 16 ++++++++++++++++
 tools/perf/tests/shell/stat+json_output.sh       | 16 +++-------------
 tools/perf/tests/shell/stat_metrics_values.sh    | 14 ++++----------
 .../tests/shell/test_perf_data_converter_json.sh | 13 +++----------
 4 files changed, 26 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/setup_python.sh

diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
new file mode 100644
index 000000000000..c2fce1793538
--- /dev/null
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+if [ "x$PYTHON" = "x" ]
+then
+  python3 --version >/dev/null 2>&1 && PYTHON=python3
+fi
+if [ "x$PYTHON" = "x" ]
+then
+  python --version >/dev/null 2>&1 && PYTHON=python
+fi
+if [ "x$PYTHON" = "x" ]
+then
+  echo Skipping test, python not detected please set environment variable PYTHON.
+  exit 2
+fi
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 196e22672c50..3bc900533a5d 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -8,20 +8,10 @@ set -e
 
 skip_test=0
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
 pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
-if [ "x$PYTHON" == "x" ]
-then
-	if which python3 > /dev/null
-	then
-		PYTHON=python3
-	elif which python > /dev/null
-	then
-		PYTHON=python
-	else
-		echo Skipping test, python not detected please set environment variable PYTHON.
-		exit 2
-	fi
-fi
 
 stat_output=$(mktemp /tmp/__perf_test.stat_output.json.XXXXX)
 
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index ad94c936de7e..7ca172599aa6 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -1,16 +1,10 @@
 #!/bin/bash
 # perf metrics value validation
 # SPDX-License-Identifier: GPL-2.0
-if [ "x$PYTHON" == "x" ]
-then
-	if which python3 > /dev/null
-	then
-		PYTHON=python3
-	else
-		echo Skipping test, python3 not detected please set environment variable PYTHON.
-		exit 2
-	fi
-fi
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
 
 grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 
diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
index 6ded58f98f55..c4f1b59d116f 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
@@ -6,16 +6,9 @@ set -e
 
 err=0
 
-if [ "$PYTHON" = "" ] ; then
-	if which python3 > /dev/null ; then
-		PYTHON=python3
-	elif which python > /dev/null ; then
-		PYTHON=python
-	else
-		echo Skipping test, python not detected please set environment variable PYTHON.
-		exit 2
-	fi
-fi
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
 
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.output.json.XXXXX)
-- 
2.43.0.rc1.413.gea7ed67945-goog

