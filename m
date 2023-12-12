Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BC80E4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjLLHF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjLLHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:05:47 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ADAD0;
        Mon, 11 Dec 2023 23:05:54 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-590b3337d2bso2037220eaf.2;
        Mon, 11 Dec 2023 23:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364753; x=1702969553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7MmpZWXIj03M3uDOilYQIEOcQY8xZL0V5IuLXoT63s=;
        b=eCK+ZX0PffaP0WcIiHc9Jm86gljP3ACMk8PVUnJTt7QLmLm1iZvRF64/QQwZrhVJcP
         nKe8+Vwuf813a/zN8l5PyFaA7N0UUiQjJn7QMQMZlEcg3pEmyphLT257V6SGUUNxQQ/k
         mbN09+shBo2YpUH8LdIFJa3NyBzEAgXtQbEi5b7Ix76x7dHCEXG8A/3qPPeY/iZ1+BQH
         hfoz9hxKhgBS6bu2Vzet3mt+ZH6Xx13wSGty8ZpuZaiMRhVN3vUgEAiD3N47zNfmrBxv
         YN8lY61SkrYRWN92zNiJRrumEiPxqsYeB4PdxsKXiM/a4IwaSFrqtGuJ0fomZRy00hHR
         W20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364753; x=1702969553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7MmpZWXIj03M3uDOilYQIEOcQY8xZL0V5IuLXoT63s=;
        b=W3HwC3nrbUO+FQbsY9jJa1Q8R4LQIxnv5PuCuUWc8IAYraLJGDMhER4Yw1U2kcCigy
         IpSJY2BK/+uzve+wD++yfxul86S/uVsYToOVXDz/s5h0LkofSKNW9nXWJgV6Gk2ruHUs
         tDgxPE+CglonJn26K1uih9hSNV6QpYv71H/SCYU6BWbURBZuGgyY9js9yL0SYw3VdTjK
         TbPFGCOxY9hGti5vVra609Ue+1oBOwsimRMVmPg+4dLBqovpnhAgX8ofgnK8qSI6WOXz
         9o36BdZ4TFeAFe2/1jmIfke0pQI38LtdOmvjIJWm0k9XlWM+KY21schujeGjKlpBEYY1
         9NTg==
X-Gm-Message-State: AOJu0YzGgHjtgde3pM3ymt/W1UnMOb54TvTjF2CvaQHj25q+FyefthsZ
        r1e2o0FCd4JebmH0tVzO33w=
X-Google-Smtp-Source: AGHT+IEKK1PG3Igx/3v5NKBHwbQVvC92wq1g1r492iiziO6sUZtoxHvt/SdfwNUyWjAgDxKZUvhquw==
X-Received: by 2002:a05:6358:6f93:b0:170:f1ab:9612 with SMTP id s19-20020a0563586f9300b00170f1ab9612mr7264rwn.65.1702364753280;
        Mon, 11 Dec 2023 23:05:53 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7da0:5ec4:de63:3cf4])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm7397491pfc.192.2023.12.11.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:05:53 -0800 (PST)
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
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH 3/3] perf unwind-libunwind: Fix base address for .eh_frame
Date:   Mon, 11 Dec 2023 23:05:46 -0800
Message-ID: <20231212070547.612536-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
References: <20231212070547.612536-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base address of a DSO mapping should start at the start of the file.
Usually DSOs are mapped from the pgoff 0 so it doesn't matter when it
uses the start of the map address.  But generated DSOs for JIT codes
doesn't start from the 0 so it should subtract the offset to calculate
the .eh_frame table offsets correctly.

Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index c0641882fd2f..5e5c3395a499 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -327,7 +327,7 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 
 	maps__for_each_entry(thread__maps(ui->thread), map_node) {
 		struct map *map = map_node->map;
-		u64 start = map__start(map);
+		u64 start = map__start(map) - map__pgoff(map);
 
 		if (map__dso(map) == dso && start < base_addr)
 			base_addr = start;
-- 
2.43.0.472.g3155946c3a-goog

