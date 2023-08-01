Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3266A76BED8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjHAUzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHAUy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:54:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A541BFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:54:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so6109734276.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923298; x=1691528098;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=01D3Mc0WQ1sIli+WCBM4zperRKd1MnhhHpfIVHiLwx8=;
        b=1jJu6159CsEIRLvgUdpUI1Kmk2CD/pULRu35xBZarz3VKKiaxvzywe8XhiyRymuz9+
         VGXNWUH2W7pvQXfMIFXjZmhpOu6k5N8HysyDDxF6SRGYVwcdOjXbrjMZSdm3nL489cDc
         zNM16qvLpgziUskQ7RgtgbUDHKiLINF17HGx7edKruttIUkYvdFWrvMBgblyiXcIKy2K
         jA062pKnujX4Aq2su7H2c7Z7HerlA36c3xy6KMqDzQfKJv5GX4lc6ucFYCKTyZD3eDPo
         0JLAGEHy8Q9zCvLhjp+I25CNKfCJwrDZpC1A6PWm42ykYKs4hAwSlWvUEgc6mbjYXdhO
         aFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923298; x=1691528098;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01D3Mc0WQ1sIli+WCBM4zperRKd1MnhhHpfIVHiLwx8=;
        b=fr0Wey8a2SvA1zjGP36A9o2UDyAvzGBfZ0h3sG9hjLYCJSI0NAv7ALwS+hzFTgX3FX
         k+hhrcbs4W78fa8KGQmRnRArKj1B5OiRjqZJRItBIVWQaquDT5Ik3Yh29EV+1zfk23w8
         mccoxcUC8IOLWWADCMt6I+xJU3NfT8JPg0DalX/ODz85VFQR7n20ZPhWCLX5bTp+QAkq
         0Qx6xHyQy5/yPXYNVlHT0MNYvgScSU/bKvPWo4VJL6ePRM8fsuRb1GT6gaay2v/GO4dr
         aryxZb2eZTvvjUhPT7GcptHRAMzN5IiLIgzYeS8djeu9cUp0+1KwW1ubBBkTEwCg3Vma
         bVrg==
X-Gm-Message-State: ABy/qLbXao4B+fPbyjTRxq0Vb2nZ9rqPgJT5aZYFgXknwwzXYuu/ujST
        pMn6d6yXYcKDEEP/URSxc+R0E2pBszBv
X-Google-Smtp-Source: APBJJlEq9l+NEtUD1U41TgFedR95hPQqXDoEZJG5YtLGgKxbgLgZUUEM7/8Esq5rFZhfDdXxNAOrT/Xz2wJm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bea9:545d:a179:25e7])
 (user=irogers job=sendgmr) by 2002:a25:d613:0:b0:d12:d6e4:a08d with SMTP id
 n19-20020a25d613000000b00d12d6e4a08dmr85369ybg.7.1690923298054; Tue, 01 Aug
 2023 13:54:58 -0700 (PDT)
Date:   Tue,  1 Aug 2023 13:54:52 -0700
Message-Id: <20230801205452.3380578-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1] perf stat: Don't display zero tool counts
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip zero counts for tool events.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7329b3340f88..d45d5dcb0e2b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -931,6 +931,11 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	 */
 	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
 		return true;
+
+	/* Tool events have the software PMU but are only gathered on 1. */
+	if (evsel__is_tool(counter))
+		return true;
+
 	/*
 	 * Skip value 0 when it's an uncore event and the given aggr id
 	 * does not belong to the PMU cpumask.
-- 
2.41.0.585.gd2178a4bd4-goog

