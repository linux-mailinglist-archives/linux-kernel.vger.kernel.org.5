Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D37785AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHKC6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKC63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:58:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EFDEA;
        Thu, 10 Aug 2023 19:58:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc83a96067so11763815ad.0;
        Thu, 10 Aug 2023 19:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722707; x=1692327507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpn1N1ZB0KetpAmPQkAbgnFDVJSzxAlzA4W3TfJjTiA=;
        b=Cx4FUrEk1nD38+jb31BkywBQvWaqk4i2dYX9OOyMbyfUsUv8KA+cNNGvfQiR73t6AM
         uUKiwV+bSXkg7ffmX87KSJsd5+PHcdPMMi11mkby4fHjBr3B3KN2gR1xwwoXi4Dc44HW
         ag7CUWMiTgD9Tt6rLOFcNVF7oQrS7/gXhCGFA1IrLl8+AipoLRWbJj53eDL+u9yy/78E
         ywo8ehQHIu2i5dDfUNZ2kFTHHWepHREz6SvA5H1fgOJlFCF774nxXdD7Sb7hKtg3MzaP
         RbmzrVPoq1blGdJi6bj6gQebheVCEz1gADPRLgrmBAgX76TD8yXGuTJe3cFt6teSCANq
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722707; x=1692327507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpn1N1ZB0KetpAmPQkAbgnFDVJSzxAlzA4W3TfJjTiA=;
        b=UE6eHmUz4hwblKTVrK7xJ9D54bRvVnhBgROzjr2g6UVXKrdtkN2OejkYd9vV37mn34
         lMEMuzCBVUWKV9fpvh8gIddJt1OhYYGtBkam6qwmU0UczBXYazkjbXBbl4t+ueiptbQa
         06IFLsFrz1CAm+mVCG69FodkXkHiC5N5Om4s0mrTADm8RGVvqqUSmN3Py+aB3pJ+7tNI
         gLIn1LAruWx5ITHiaIyzunXpMvVMR//0Ttw1WRlcrzuqAcvvVS5NY4AZsaV083zqZ8nJ
         cKUQQMmWDLZtX41dTmWdQMS+1+iAKMlVRWBRJXnHbHmXZ2BzIEjOLm+K9GJ99QLg1CQO
         4aBg==
X-Gm-Message-State: AOJu0YwaplAHSwQpS3crTkkaBMNzYAwGUBZWkDbJdvQDUVc3UzbjQYkO
        1RvSrkaUBb12sVS7tfe9zuTO4tv04/Y=
X-Google-Smtp-Source: AGHT+IHg9TNQhcaP/GLS+YnbHFbq4WGUxaIpMTz2AzciDZzB/N+5ETuL0lZw5WLXuYlijQlzN6uldg==
X-Received: by 2002:a17:902:dacc:b0:1b9:cc6b:408c with SMTP id q12-20020a170902dacc00b001b9cc6b408cmr579146plx.38.1691722707364;
        Thu, 10 Aug 2023 19:58:27 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:2328:6915:cbeb:39d4])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b001b9be3b94d3sm2526592pls.140.2023.08.10.19.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:58:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf bpf-filter: Fix sample flag check with ||
Date:   Thu, 10 Aug 2023 19:58:21 -0700
Message-ID: <20230811025822.3859771-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
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

For logical OR operator, the actual sample_flags are in the 'groups'
list so it needs to check entries in the list instead.  Otherwise it
would show the following error message.

  $ sudo perf record -a -e cycles:p --filter 'period > 100 || weight > 0' sleep 1
  Error: cycles:p event does not have sample flags 0
  failed to set filter "BPF" on event cycles:p with 2 (No such file or directory)

Actually it should warn on 'weight' is used without WEIGHT flag.

  Error: cycles:p event does not have PERF_SAMPLE_WEIGHT
   Hint: please add -W option to perf record
  failed to set filter "BPF" on event cycles:p with 2 (No such file or directory)

Fixes: 4310551b76e0 ("perf bpf filter: Show warning for missing sample flags")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 47f01df658d9..b51544996046 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -62,6 +62,16 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	if (evsel->core.attr.sample_type & expr->sample_flags)
 		return 0;
 
+	if (expr->op == PBF_OP_GROUP_BEGIN) {
+		struct perf_bpf_filter_expr *group;
+
+		list_for_each_entry(group, &expr->groups, list) {
+			if (check_sample_flags(evsel, group) < 0)
+				return -1;
+		}
+		return 0;
+	}
+
 	info = get_sample_info(expr->sample_flags);
 	if (info == NULL) {
 		pr_err("Error: %s event does not have sample flags %lx\n",
-- 
2.41.0.640.ga95def55d0-goog

