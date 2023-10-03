Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5A7B62CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjJCHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:49:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A6A9;
        Tue,  3 Oct 2023 00:49:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406618d080eso6031655e9.2;
        Tue, 03 Oct 2023 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696319354; x=1696924154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4uGm4UsgcR7Wz0vCxNV3ZjfJf/Okbz0Af+MHqDGOL8=;
        b=IFiy0DvNGYoUPT0kPDi3wkqhtzdv2pzpiv+QRdtxfBYLzfTlsqzZVPQPgZ7KCl9f4k
         p2KfqyfTeeIUWI1CenznUqbS8c5uGFMw1fy3DYr48duH5+K6Z5CXds+2q81cGBoBngVy
         sQb25vUbmgoyBsjvbK0VYpKyogJjkPgEI3UpywXBC6JkjyjzaFVUdD5r/QAkuf8bCf+n
         mXzqtfhQlWMoY6DH8Phh8t0iOzLaQnMdNZoNlLgnN8b8no67gkrMe9GhqSEDOnfA60ad
         4pwxfBanC2q/BIepcyewElXWVKJxJyw0OaijWh8TTWq/oTy6Vqf6xoKT0XZFfc6czZhA
         S6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319354; x=1696924154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4uGm4UsgcR7Wz0vCxNV3ZjfJf/Okbz0Af+MHqDGOL8=;
        b=w0XDqdp7Ukidjl0uzDbEH/RsOHY3uWGgZFgnjo+TMFt88nLn+tUqtORXzYKQ75eTR3
         KpFDXqeuNgqOfOS7XGywEimq4T52Oc/kFxCLC3zuzFKBSIDyGFCfO+06ElwERojPLYV9
         a5uXGvYiq/pGSF9MT4ZsZij4h+SZ3YZbfskcz8enWu92XQB3B9e05hKE6BUpARQY1W6T
         xalavDjvipeDl1Qj6DsOJsNbscRnRgPgzaBhDDa6fNK2d/aUeqG420phe1cz0JCWWvwb
         hkPhsgvGhAGg8YALhpotAkWAxE5YdSeDWb7VpxWZydfkAIyuar/krMmjpQZmYdgEVC2w
         FxKQ==
X-Gm-Message-State: AOJu0Yyo7pekdLFZwSFZImbBj4EqJlQYN0zHLAUCsUAbierqVLg4hWpG
        CSOrbWuWyCOhzrxYRqGUJ7KqLmq7QZou0Q==
X-Google-Smtp-Source: AGHT+IGM0toQ5phS7q3cqK/tEymfpWpGNUL/kuRaKervb++r8PKGOM+/7BfeUmkMJOrBrfRpZkpSOw==
X-Received: by 2002:a7b:ce16:0:b0:405:3803:5588 with SMTP id m22-20020a7bce16000000b0040538035588mr11036440wmc.22.1696319353524;
        Tue, 03 Oct 2023 00:49:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b00401c595fcc7sm8766499wmd.11.2023.10.03.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:49:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf: fix spelling mistake "parametrized" -> "parameterized"
Date:   Tue,  3 Oct 2023 08:49:11 +0100
Message-Id: <20231003074911.220216-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spelling mistakes in comments and a pr_debug message. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/tests/parse-events.c        | 4 ++--
 tools/perf/tests/shell/stat_all_pmu.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index f78be21a5999..e52f45c7c3d1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2549,7 +2549,7 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			if (strchr(ent->d_name, '.'))
 				continue;
 
-			/* exclude parametrized ones (name contains '?') */
+			/* exclude parameterized ones (name contains '?') */
 			n = snprintf(pmu_event, sizeof(pmu_event), "%s%s", path, ent->d_name);
 			if (n >= PATH_MAX) {
 				pr_err("pmu event name crossed PATH_MAX(%d) size\n", PATH_MAX);
@@ -2578,7 +2578,7 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			fclose(file);
 
 			if (is_event_parameterized == 1) {
-				pr_debug("skipping parametrized PMU event: %s which contains ?\n", pmu_event);
+				pr_debug("skipping parameterized PMU event: %s which contains ?\n", pmu_event);
 				continue;
 			}
 
diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index c77955419173..d2a3506e0d19 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -4,7 +4,7 @@
 
 set -e
 
-# Test all PMU events; however exclude parametrized ones (name contains '?')
+# Test all PMU events; however exclude parameterized ones (name contains '?')
 for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
   echo "Testing $p"
   result=$(perf stat -e "$p" true 2>&1)
-- 
2.39.2

