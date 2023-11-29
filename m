Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5B7FD062
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjK2IK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2IK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:10:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5F10F0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:10:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd1172b815so5415367b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701245432; x=1701850232; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfx1JC4eBOGrcYnY6xicCWpxUTppoeccvNEbp92VzIk=;
        b=c1+LsFpWXVZa9f0P5WSJVas0Ky1Ns9z08OWReCQPUx8UbCCItqqEjvqKl9VaEWy/T8
         +KVwuU6p8GeqL84vzu9l2ePUgs154JheZQq+kFRA6eb0XGF5SQqR0fKtljCEUlxCO4mn
         D4n8LB1H18QLEMUBV05lbnVllpkBtSl++Ankn+zpMLqLcPQw8UfhBeVdNAwdhXCe45ex
         bEN5J6Fx4j9jRZ+mKczV96Bz0+gYWgXpqBsQAdNXYxkeg+mJLCuCUnULQ0Y28bc4K4rF
         dJ4RyLAfPIzZ79PeyQ1kmBlcAId4DIzHFFuVS2qe4AzRYdC1nBJDRbe2b4byUD/na57w
         HnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245432; x=1701850232;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfx1JC4eBOGrcYnY6xicCWpxUTppoeccvNEbp92VzIk=;
        b=hemnjsavLDh1k1cGvt7WF4Qo9y2Afvaubd8AZhQxelFQFnBgHpU+KL5HmsxwsC/3mz
         ghqCHhLFOc7ahYCQZtKt35mJ/S/rM79Nqzxp/JlHFeqNypqZSYBVNSuvF3lsF0FQC7FN
         CeApoZKOpyLCSWECnaSZJqLGvE2ugEo+sAg0+YJp/kcIE9fWnrXWGUL3HNhOUw65ehPj
         xZ8Y0uDcgTpZp0dlkjcQIEjAgLMkA6yZ4w+2z+tDupe/2J0G2hklYh07QsZFx/aVqrfU
         UshjcdFqW3o59UWZOGB/nCh9/L5kRqzgGRBj583x6YLbHb2wMAEw/j5knnHBBml0eXdi
         5wSw==
X-Gm-Message-State: AOJu0Yyo5WIXu7wvCgKQfLgEa2MJESetnkdtXZvysBbUyrmnbY+LrZRZ
        +67g9S7caoLQ42JCoTDocPMBahnRbdBe
X-Google-Smtp-Source: AGHT+IE5b9oYoQQYInppAwId01GLHLrLVHBthTMBolUCilxrEIoPz5tuG8kxIflGG6rgmhKBscV72D45W3Am
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b0a:b0:5d0:8fb3:559c with SMTP
 id em10-20020a05690c2b0a00b005d08fb3559cmr253486ywb.0.1701245431941; Wed, 29
 Nov 2023 00:10:31 -0800 (PST)
Date:   Wed, 29 Nov 2023 00:10:04 -0800
In-Reply-To: <20231129081004.1918096-1-irogers@google.com>
Message-Id: <20231129081004.1918096-2-irogers@google.com>
Mime-Version: 1.0
References: <20231129081004.1918096-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 2/2] perf test: Add basic list test
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Test that json output produces valid json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 tools/perf/tests/shell/list.sh

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
new file mode 100755
index 000000000000..286879a9837a
--- /dev/null
+++ b/tools/perf/tests/shell/list.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# perf list tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+err=0
+
+if [ "x$PYTHON" == "x" ]
+then
+	if which python3 > /dev/null
+	then
+		PYTHON=python3
+	elif which python > /dev/null
+	then
+		PYTHON=python
+	else
+		echo Skipping test, python not detected please set environment variable PYTHON.
+		exit 2
+	fi
+fi
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

