Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5727E7F1D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjKTTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:04:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101429C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:04:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c934524a61so32428517b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700507053; x=1701111853; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NwegP4grp+NKVnXxnLCbPPhC1AoQpO7Vl3AwS2tf1V0=;
        b=TywSXqEvMpo5ZbZuXWqr18X4YXCVS6DIXbLqZQq38nST77LY4YihWyoVsW4V9hLNEN
         IU0m2q02LZeVounQQk5uMDWd+ky1U+qJAIAwI90ovxUpbxzLk2pkLyU9RRCuhp622qKA
         OKD+FU/kbYrL79cXE7g29//7sGIZb2bW0U6TStW2S0IKUiSGMYSjpWYrSyX3soKVTXcM
         D8kIbOwYzzPRBtaYxWW9XaAVmKevuE0rVKkpErAuVfWmapXB5Hl4chT4fHCTFcIlyheH
         /nNdmiKg7QnPpSomfOqfIcihXwxcTKmeZZvi0uxZW3we596GY3ps6SZt3W623SOciLxn
         AKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507053; x=1701111853;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwegP4grp+NKVnXxnLCbPPhC1AoQpO7Vl3AwS2tf1V0=;
        b=E8Bvx2CUT/wZEHLtr8+lf1eldadwnHSeQr+wIKRSOrXNVCZpIiB32CY/tTWW6l4FJO
         UMWhaBH/h+SUvfLM/IcIbi7Ge2wbglJNZAbayecQwvkzeoil5OA6PxrxrqZC3enx8FkK
         So0mKozpFDQkFDeOlj0k/ZmojfELHC+f+WcLQgFnIlnWz3ux6UfIuxZRKWtFsKIFZLm/
         0zZj9humG9ccQQFErKNbudoUA1DljIkjtUf5AEQzF3uQPGW2G6awJsvdZvKPYxnbssTc
         /6euZg6UqQKN867PeEqq3O1wKlaG3lTTBCpNRiBmhT4ZbpcC0cPNkFv5vmzkL+oFHrMJ
         HyvQ==
X-Gm-Message-State: AOJu0YwsFAhLfjtFZCXxzv6AeAK9fqmJOQ9WPjGHYxhHBRZ0u2pIBrg0
        PQYc+H8e26Co6YRAHiTX6Kf0+gVqvNN2
X-Google-Smtp-Source: AGHT+IGW9SCeYhNevQuiBWINPc7ABYMlEDWVxjfLt0OfeZ0gvhANIZO2KmcWZfOBL//9RfVl2axpoFhRQ4f3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:274d:270:40a9:df3f])
 (user=irogers job=sendgmr) by 2002:a81:6dc9:0:b0:59b:c6bb:bab9 with SMTP id
 i192-20020a816dc9000000b0059bc6bbbab9mr227590ywc.3.1700507053127; Mon, 20 Nov
 2023 11:04:13 -0800 (PST)
Date:   Mon, 20 Nov 2023 11:04:08 -0800
Message-Id: <20231120190408.281826-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf test: Add basic perf diff test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some old bug reports on perf diff crashing:
https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html

Happening across them I was prompted to add two very basic tests that
will give some perf diff coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/diff.sh | 101 +++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 tools/perf/tests/shell/diff.sh

diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
new file mode 100755
index 000000000000..213185763688
--- /dev/null
+++ b/tools/perf/tests/shell/diff.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+# perf diff tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata1=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfdata2=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+testprog="perf test -w thloop"
+testsym="test_loop"
+
+cleanup() {
+  rm -rf "${perfdata1}"
+  rm -rf "${perfdata1}".old
+  rm -rf "${perfdata2}"
+  rm -rf "${perfdata2}".old
+  rm -rf "${perfdata3}"
+  rm -rf "${perfdata3}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+make_data() {
+  file="$1"
+  if ! perf record -o "${file}" ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed record]"
+    echo 1
+    return
+  fi
+  if ! perf report -i "${file}" -q | grep -q "${testsym}"
+  then
+    echo "Workload record [Failed missing output]"
+    echo 1
+    return
+  fi
+  echo 0
+}
+
+test_two_files() {
+  echo "Basic two file diff test"
+  err=$(make_data "${perfdata1}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata2}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+
+  if ! perf diff "${perfdata1}" "${perfdata2}" | grep -q "${testsym}"
+  then
+    echo "Basic two file diff test [Failed diff]"
+    err=1
+    return
+  fi
+  echo "Basic two file diff test [Success]"
+}
+
+test_three_files() {
+  echo "Basic three file diff test"
+  err=$(make_data "${perfdata1}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata2}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+  err=$(make_data "${perfdata3}")
+  if [ $err != 0 ]
+  then
+    return
+  fi
+
+  if ! perf diff "${perfdata1}" "${perfdata2}" "${perfdata3}" | grep -q "${testsym}"
+  then
+    echo "Basic three file diff test [Failed diff]"
+    err=1
+    return
+  fi
+  echo "Basic three file diff test [Success]"
+}
+
+test_two_files
+test_three_files
+
+cleanup
+exit $err
-- 
2.43.0.rc1.413.gea7ed67945-goog

