Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54F78E708
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbjHaHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHaHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BEF1A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fbfcb8d90so8350347b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693466084; x=1694070884; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr41kDdDeJzQNFW3nz+BwVQXTEOQ7IBxm5AfGxJhvdk=;
        b=CDp1t5ekzB1vlkslgmD1Uk/jcoVrl3+7g5PSXl4YozmAl5uDxHIAY9MS+ISesQ3+hc
         iayCQHlsCEVNC4K5sV47w1YI5OBrwhzYmSdPp0QjdFOSonULeV0BNcZmVzX579f7y8sS
         BOYazvFmkN5p1HPfXTFUMUChn/wnAa4a2MYbq8E1HQdLmOSs0FU07nlne0o1Mlv6Wts3
         6+JeDOIjM9UhX6KK1T1GHFLhKQisvuFHD6rHohmuvzFscwP+TAAWXa1LwnTk0Miy+6gO
         gGl1R0kFtswnMEOiC+DMPsJykOOZOFOnc3j7vkxCnxGBPhW16R8o1nqs4Gx9IAr1FLSY
         YsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466084; x=1694070884;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr41kDdDeJzQNFW3nz+BwVQXTEOQ7IBxm5AfGxJhvdk=;
        b=g/i3xT5gNduI10Sx0xXhhEBFGAMZ5PQXATB+FlExMJgUg4p4In2SSNa9RzNAgFPl5k
         0NJWmc/P3pLUb6vvPoj19z3T0NXUaub1IywWv4OxTjKdSHvsYXOr76heDf+0dPYxBlcx
         o4fNzMpQrgfDqZ+S/FPDCEnsTLhPnrLVY6uG40QRcb9syC84AqWBHkrqH6Smcr0YatCd
         KduLQzpliWKB4Krubkbv/zlGyAXV3EWUyrKmzB2HEde78Ru/nLFY9Fa1iAmLG/c/oe+z
         AG0fZ8tvosTOKrmZy/1AT4xEeWxkuVRjz8Cxxx+is7Mfqjbi6+wefsfYOLkUQKUyaqaU
         QcIA==
X-Gm-Message-State: AOJu0Yw7KrqjBMxKyDy/1Ql1GCQm36Y7pnKLd40Qlplo7tz5ADudG/fI
        AgI7CjysxAxqaxNNlcY2Kwve+IiGJyIw
X-Google-Smtp-Source: AGHT+IF5RuXo9qTB0bgfsrdHCQZZY+zjteXaXkJaflVMOpRzb34MoLKDR2Dz6HXv+Z6xBHIZ0Y+uYEedugR0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:feef:cd5e:6353:57f0])
 (user=irogers job=sendgmr) by 2002:a81:af07:0:b0:56d:647:664b with SMTP id
 n7-20020a81af07000000b0056d0647664bmr125753ywh.5.1693466083950; Thu, 31 Aug
 2023 00:14:43 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:14:19 -0700
In-Reply-To: <20230831071421.2201358-1-irogers@google.com>
Message-Id: <20230831071421.2201358-2-irogers@google.com>
Mime-Version: 1.0
References: <20230831071421.2201358-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 1/3] perf list: Don't print Unit for default_core
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
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

default_core was added as a way to demark json events whose PMU should
be whatever the default core PMU is, previously this had been assumed
to be "cpu" but that fails on s390 and ARM. perf list displays the PMU
in the event description to save storing it in json, but was still
comparing against "cpu" and not "default_core", so update this.

Fixes: d2045f87154b ("perf jevents: Use "default_core" for events with no Unit")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 1ac47db4d66a..a343823c8ddf 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -148,7 +148,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
-		if (pmu_name && strcmp(pmu_name, "cpu")) {
+		if (pmu_name && strcmp(pmu_name, "default_core")) {
 			desc_len = strlen(desc);
 			desc_len = asprintf(&desc_with_unit,
 					    desc[desc_len - 1] != '.'
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

