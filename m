Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E73808F03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443497AbjLGRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjLGRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:40:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13687170C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:41:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db410931c23so1434799276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701970862; x=1702575662; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=niYg5A4Vl8wxZvl0dW0Aqla8QlNk079TUHdjvbyyS3A=;
        b=csTA5Sv80llF1L+RpndLQs6eQOSGNQQAPW/I60QLdwD7sxMVJ57OpaGkJkWUR6yroI
         2qRXjppG1hB/F54bppq/sZKLXEjpDPEjdmA00Ckl5S6dVjs8FOn6+Lb5OrS2SkkUruhE
         GbaXCeM5gyG/pwDWTw95hLKGx7ga5dJLApG/Vbpp3uFXmD7AlHY4aK0gdVxkbyeGuPAH
         /M0FJOHhzg8bK/dHVJgiw1l60I0snKbGAiDuWKBksoUwQugdoh7kJ9FAzRIbNzWCATAO
         JCszczlpqqq1dHOCir6p6t2xz/KQbi36ZgfkvgN5XeP5yshjJ1/UUiiXfu/0k3QcIpxH
         26tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970862; x=1702575662;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niYg5A4Vl8wxZvl0dW0Aqla8QlNk079TUHdjvbyyS3A=;
        b=RYeAnzqJOeCElzzYlBH4JiF077tRybcntE0+dvMieVDzgv0wBChy+wQbsSSoZENQyP
         5ba6r2qI7AdA2jJfVu/ZbJZspSR8PMw5+zaAJISiGiZtYHyeHIUmQylbn/ciu4kTnPlD
         RCLWB/C8/huD+Vbno+y/thVeoWaghdRmHvlNI+FeGu+V3wsH4y0QKsVuV/s9EWxakqJd
         9EbhKwZFHJq5kh52iI3mb8nMqdRw3sGi+o8HjNqBMX5BOzgtlw1jBoq5aPQRsRxgYmK/
         DVzuh4Qr39YeAHOTIZ1YcWMjtMB5L5AAbbix+GW2cmURjvzGiidc82312OJYaH9+DlzO
         AEnw==
X-Gm-Message-State: AOJu0YwobJrhCl46OayJFYnZMVhT8EC2jLvDfKWFfstzkEHRJEZbhslM
        jrkNY9iuiEE1PfILsaGvuKWgYLCHT1d3
X-Google-Smtp-Source: AGHT+IG1uUHscqr78fzFiaNu9Xova/+Jee3jNfzWA/gZC7ueT8il/DECGiuPKk9ckx8PFtV46AStdGhgQHLV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:df06:0:b0:d9a:520f:1988 with SMTP id
 w6-20020a25df06000000b00d9a520f1988mr35484ybg.4.1701970862296; Thu, 07 Dec
 2023 09:41:02 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:40:57 -0800
Message-Id: <20231207174057.1482161-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf tests: Add perf script test
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ben Gainey <ben.gainey@arm.com>
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

Start a new set of shell tests for testing perf script. The initial
contribution is checking that some perf db-export functionality works
as reported in this regression by Ben Gainey <ben.gainey@arm.com>:
https://lore.kernel.org/lkml/20231207140911.3240408-1-ben.gainey@arm.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 tools/perf/tests/shell/script.sh

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
new file mode 100755
index 000000000000..5ae7bd0031a8
--- /dev/null
+++ b/tools/perf/tests/shell/script.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+# perf script tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
+
+perfdatafile="${temp_dir}/perf.data"
+db_test="${temp_dir}/db_test.py"
+
+err=0
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	sane=$(echo "${temp_dir}" | cut -b 1-21)
+	if [ "${sane}" = "/tmp/perf-test-script" ] ; then
+		echo "--- Cleaning up ---"
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+
+test_db()
+{
+	echo "DB test"
+
+	# Check if python script is supported
+	libpython=$(perf version --build-options | grep python | grep -cv OFF)
+	if [ "${libpython}" != "1" ] ; then
+		echo "SKIP: python scripting is not supported"
+		err=2
+		return
+	fi
+
+	cat << "_end_of_file_" > "${db_test}"
+perf_db_export_mode = True
+perf_db_export_calls = False
+perf_db_export_callchains = True
+
+def sample_table(*args):
+    print(f'sample_table({args})')
+
+def call_path_table(*args):
+    print(f'call_path_table({args}')
+_end_of_file_
+	perf record -g -o "${perfdatafile}" true
+	perf script -i "${perfdatafile}" -s "${db_test}"
+	echo "DB test [Success]"
+}
+
+test_db
+
+cleanup
+
+exit $err
-- 
2.43.0.rc2.451.g8631bc7472-goog

