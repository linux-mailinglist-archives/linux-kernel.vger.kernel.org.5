Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC327FE217
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjK2Ve7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjK2Vex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:34:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389BD7D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:35:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d2f58660d4so3319987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293699; x=1701898499; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRVp3dZOza3BPJg1hP4prPeqJnELXQfl8OwEl5/3ecI=;
        b=E5kxKLHc2RkBpypwPjiAH9ejAMmO3mhTaadbxDv1Qe8CJK2fh2aizYvTBTdiBKa0qg
         cTac753lguvqEcWaT5ZpQGOvN1D5bdCpSKRMDm40+73POJOAStfONhJeWn6qDR1wtBtT
         HoPICAI2caJmoDOntjwkiH1uTYoB0jAd7nRvlcaaPKPRk6KIbyhCEmlHSOxFQPR5EK+e
         eNMERwoz3uHWQUU1SoAzHT/+0Peq0rN26eDvcxA9NF3EnDytK7NHSXNF3E4CdmbIR2+i
         ML6lLP9+9Mni0pceZ0SBP5ttuQ9iFj1NYUP55iO86JsnoQR9c8xAyz/XPSN7WSIk5R2k
         4UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293699; x=1701898499;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRVp3dZOza3BPJg1hP4prPeqJnELXQfl8OwEl5/3ecI=;
        b=AeJuF946Uzx5TNAlcQebf5mWYXR7YS28u4C6b9KKtAInujnxM0T9j3oYb4Zw/oRLr1
         pa6HtN6TsLaTuVFb0twLyU9FKr5ZupX3ZcqjtBuojfjjI3gl+W7okMfpvuTs9gubity2
         FnYmG/14gz9x86GmjEgaq+d0eudCZLaYHTKfpFI2yO4zkEufxW2j4IHnmIcP294LXzJb
         NTRODWtAsWXB+/ftuuSeCheueyQYaFxZHIhkf92PxjujCVcGLobnl7S/+f8qx3q99xnK
         Ji5x2cRXNnImkdh5y/Oo69Vujl2nabLapSojxl5cb2OW1wLLajPl9OfWzus478zyHDQh
         lmzA==
X-Gm-Message-State: AOJu0YwOwzK8Avz2vi2pLNWlpj3iURim/VwH406ByYA9V90WaiT5uMzr
        aCDiorUsURqiv0CQuE/l/AQzb7gkZ/QL
X-Google-Smtp-Source: AGHT+IEpGmq6z8SUXOSm9a+7bIuqfanFRJQ8FfDPo4Ti3gSXTSrQOwyTKUfJ4iwslN3aoy/Zf6MpNgzkPqLw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a81:ff05:0:b0:5cd:c47d:d89a with SMTP id
 k5-20020a81ff05000000b005cdc47dd89amr666680ywn.2.1701293699266; Wed, 29 Nov
 2023 13:34:59 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:34:28 -0800
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Message-Id: <20231129213428.2227448-4-irogers@google.com>
Mime-Version: 1.0
References: <20231129213428.2227448-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v2 4/4] perf test: Add basic list test
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

Test that json output produces valid json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tools/perf/tests/shell/list.sh

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
new file mode 100755
index 000000000000..22b004f2b23e
--- /dev/null
+++ b/tools/perf/tests/shell/list.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# perf list tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+err=0
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+test_list_json() {
+  echo "Json output test"
+  perf list -j | $PYTHON -m json.tool
+  echo "Json output test [Success]"
+}
+
+test_list_json
+exit $err
-- 
2.43.0.rc1.413.gea7ed67945-goog

