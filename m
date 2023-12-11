Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2A80D509
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbjLKSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbjLKSM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:12:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1AA95
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:13:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf61210e3so53678957b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702318382; x=1702923182; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3zU0Mza8xelLsIrsnPiZI1psCs6jGW5zuolURJTG2A=;
        b=qkYC/+W6fAj6/EytOdsO61Mf2TH19e+VrAuC1bTyYHA4e49Fnea4tI5JkTEXVAfZqu
         A3IU0TFs6TCcChAoHnI1lTf12zG2mM+/R264rSykA2Wg1qTJos8gk6C3xd8RjuqBl496
         GruzQ8ScYweLw0sDzKoAKsaSlQRrLjXoWlHrAbiAs4nHXH0/ifZYkQFiVHSjJdr6hbFr
         HBflecuFmovXV7Q7txoVIHTJ7nH5Lg9JOJBGRK+7P8fJ/dyZT9uUKynLdJzlQmaiS2XC
         gtfxjNJstDSeXEwAG9bImWO88uwSMAojul7q+tnr9EPej3h5X4N0PsYFKY+ZvXgB8Jy0
         O6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318382; x=1702923182;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3zU0Mza8xelLsIrsnPiZI1psCs6jGW5zuolURJTG2A=;
        b=QYopHh6bymxK8WZzj4xILF638npC6Kal3LcYM0yVSUQdvv1RE8RF2d4KDLHkUUaWaN
         dCqmlZeGHMkoE2YPLjxogwGI5H8bNTsFPgvuOwizVYR4Zj91pS+v+f+ZxePUGREvjfDZ
         PErfuLyZwBvQrMkAlBzrpl2hQTPH+4dqgz50mEzVY4mkG7eyyC25bJdjqADNR2tv2vcJ
         gYT0p2ArGXaKsT5eKBEfUxJ4DNJdAGAXOwgYY9dlJqAJLbfjniyvxImjZoqiGbXSVGrz
         yG2nIXwDDRVitCp7Xo10eyQkiIoJd6EoGxrSCNPSWHlmAb8NOWexi9O9SjykvyVON0w7
         J7Dg==
X-Gm-Message-State: AOJu0YzubaOxYu68P04gqVVTu+rRc2y/33Pj0tVBrNXLd7ntBUWjss5m
        rsGfusvVgtfzbTwU4ZfF6CFKWW0RjgoN
X-Google-Smtp-Source: AGHT+IGVlhrck8yldxsx8dzUPl5v/hDJwqs4ANNzPwmrRmXJdkTzkOSefZMYaoKPX7fG+zB0OzOPNJxTw47L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7997:94ef:ba9a:d2b6])
 (user=irogers job=sendgmr) by 2002:a81:fe04:0:b0:5d2:735c:b9f4 with SMTP id
 j4-20020a81fe04000000b005d2735cb9f4mr40965ywn.1.1702318382095; Mon, 11 Dec
 2023 10:13:02 -0800 (PST)
Date:   Mon, 11 Dec 2023 10:12:41 -0800
Message-Id: <20231211181242.1721059-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1] perf stat: Fix hard coded ll miss units
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
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Endignoux <guillaumee@google.com>
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

Copy-paste error where LL cache misses are reported as l1i.

Suggested-by: Guillaume Endignoux <guillaumee@google.com>
Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 1c5c3eeba4cf..e31426167852 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -264,7 +264,7 @@ static void print_ll_miss(struct perf_stat_config *config,
 	static const double color_ratios[3] = {20.0, 10.0, 5.0};
 
 	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, color_ratios,
-		    "of all L1-icache accesses");
+		    "of all LL-cache accesses");
 }
 
 static void print_dtlb_miss(struct perf_stat_config *config,
-- 
2.43.0.472.g3155946c3a-goog

