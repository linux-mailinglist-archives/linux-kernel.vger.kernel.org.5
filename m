Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE17785AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHKC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHKC6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:58:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9CC10D;
        Thu, 10 Aug 2023 19:58:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-56546b45f30so1240684a12.3;
        Thu, 10 Aug 2023 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722709; x=1692327509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3HQQCbZUQgMGtswL7NtUKKa35Z1CAMIgNgpjGVzPks=;
        b=U7Xg0vUCJn2dGjJvtFxShAyxZLabTC6A855FIb4VVng+t+Y0CInQo0q4KFdA+tcl9O
         3qd3+KwDns4jY+p1cceG9q+ZYWt21k9p9AzKnss6WTlhmb93JZUqcOe44b2oPFyyDzaL
         DgPBNix/z1JACyrEjb/4mcadFAKq6xcgF+EMHuRz/eQlpAwXqw8Qc21O8bzgcAcOSpe8
         UlVCrcKyr6Bk0q/XPM0MSxote2JiaWfBAAmHkvKklxLVXuCRwVkFC6hiRYgj9mEIf0wf
         txgYQVY99OciCLunnSfKv1tJrGRl6p46pBTPDsgA6ew/ebLOblujAnGiLCSrbDh7fzjh
         pJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722709; x=1692327509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3HQQCbZUQgMGtswL7NtUKKa35Z1CAMIgNgpjGVzPks=;
        b=QMiUboyNqZ++1dqLZFZftl65KmMXJjGf/meNpW8hdL5Fc0Rt1Dib1XashoTa5VSlhT
         FmZC0p3gYhRHAOUyw7xMNIvUZFRjWf10H5Aidtl577DcdBc/c2h0KaMQFboOsT1qP42y
         Q2N9aIXBkExHcE1XA57FFT2kenz2Ug846jWwCSIP9DDY8dSmGCqtXYH3bU2g77BAQGG0
         7K0NB5zAhNch91yrVYxYEBHuUEkxQBKxE5kXz7dDLRaNTyBsvI2psM8Ert0v6lyiesDp
         50+2MxuVCIqUqGwo99MrBTUF3QXuYdm3lRIOVmCT6Ps54wQU/30vdY8vPjItCzsRecfB
         TzeA==
X-Gm-Message-State: AOJu0YwGA9XeivQC3Zrs2mteuQMUk205Oc90U1iAoolhpOAv1aAm+Zxu
        ko3ToHm9Rz/IVmvzKG3IP+o=
X-Google-Smtp-Source: AGHT+IGkhq4EEk97+eG9idjdjbCJGyNzpfRefSo/gUeuSxYRWCpeHRgoZlKGQW3MtXe1CcBkHtqHGg==
X-Received: by 2002:a17:903:11c9:b0:1bb:ce4a:5893 with SMTP id q9-20020a17090311c900b001bbce4a5893mr842388plh.30.1691722708974;
        Thu, 10 Aug 2023 19:58:28 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:2328:6915:cbeb:39d4])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b001b9be3b94d3sm2526592pls.140.2023.08.10.19.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:58:28 -0700 (PDT)
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf test: Add perf record sample filtering test
Date:   Thu, 10 Aug 2023 19:58:22 -0700
Message-ID: <20230811025822.3859771-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230811025822.3859771-1-namhyung@kernel.org>
References: <20230811025822.3859771-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  $ sudo ./perf test 'sample filter' -v
   94: perf record sample filtering (by BPF) tests                     :
  --- start ---
  test child forked, pid 3817527
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
  Group bpf-filter test [Success]
  test child finished with 0
  ---- end ----
  perf record sample filtering (by BPF) tests: Ok

Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 128 ++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_bpf_filter.sh

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
new file mode 100755
index 000000000000..e76ea861b92c
--- /dev/null
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+# perf record sample filtering (by BPF) tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_bpf_filter_priv() {
+  echo "Checking BPF-filter privilege"
+
+  if [ "$(id -u)" != 0 ]
+  then
+    echo "bpf-filter test [Skipped permission]"
+    err=2
+    return
+  fi
+  if ! perf record -e task-clock --filter 'period > 1' \
+	  -o /dev/null --quiet true 2>&1
+  then
+    echo "bpf-filter test [Skipped missing BPF support]"
+    err=2
+    return
+  fi
+}
+
+test_bpf_filter_basic() {
+  echo "Basic bpf-filter test"
+
+  if ! perf record -e task-clock -c 10000 --filter 'ip < 0xffffffff00000000' \
+	  -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Basic bpf-filter test [Failed record]"
+    err=1
+    return
+  fi
+  if perf script -i "${perfdata}" -F ip | grep 'ffffffff[0-9a-f]*'
+  then
+    echo "Basic bpf-filter test [Failed invalid output]"
+    err=1
+    return
+  fi
+  echo "Basic bpf-filter test [Success]"
+}
+
+test_bpf_filter_fail() {
+  echo "Failing bpf-filter test"
+
+  # 'cpu' requires PERF_SAMPLE_CPU flag
+  if ! perf record -e task-clock --filter 'cpu > 0' \
+	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
+  then
+    echo "Failing bpf-filter test [Failed forbidden CPU]"
+    err=1
+    return
+  fi
+
+  if ! perf record --sample-cpu -e task-clock --filter 'cpu > 0' \
+	  -o /dev/null true 2>/dev/null
+  then
+    echo "Failing bpf-filter test [Failed should succeed]"
+    err=1
+    return
+  fi
+
+  echo "Failing bpf-filter test [Success]"
+}
+
+test_bpf_filter_group() {
+  echo "Group bpf-filter test"
+
+  if ! perf record -e task-clock --filter 'period > 1000 || ip > 0' \
+	  -o /dev/null true 2>/dev/null
+  then
+    echo "Group bpf-filter test [Failed should succeed]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
+	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
+  then
+    echo "Group bpf-filter test [Failed forbidden CPU]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'period > 0 || code_pgsz > 4096' \
+	  -o /dev/null true 2>&1 | grep PERF_SAMPLE_CODE_PAGE_SIZE
+  then
+    echo "Group bpf-filter test [Failed forbidden CODE_PAGE_SIZE]"
+    err=1
+    return
+  fi
+
+  echo "Group bpf-filter test [Success]"
+}
+
+
+test_bpf_filter_priv
+
+if [ $err = 0 ]; then
+  test_bpf_filter_basic
+fi
+
+if [ $err = 0 ]; then
+  test_bpf_filter_fail
+fi
+
+if [ $err = 0 ]; then
+  test_bpf_filter_group
+fi
+
+cleanup
+exit $err
-- 
2.41.0.640.ga95def55d0-goog

