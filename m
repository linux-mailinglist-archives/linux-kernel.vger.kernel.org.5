Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4477BE31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjHNQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjHNQiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542FE0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:38:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d65201b777dso7816509276.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031082; x=1692635882;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFQ8vC5XQzgbvA+JsLCqADpM15IC2vMeMSJvkR1GdkU=;
        b=bLOdGV5zU5g2foKHhovwgNU8bbs6HNM9yzvZqm2zF2ZeIzc0ylmy7dhFi1X777X7kV
         Cg8bqf7tLDslXr1MWVYqDsJplRRbnXg1F6MLtu2PTPPdnQYFdRJwdXo0LMCmC0zU9Lsb
         E+0mm5dS8xHK5Zfzdl9zBFgO9TmivGhb+NaXjnrn0/hwgRZkfSQg9ViW6gPGEIWjumHT
         qD+ZINuoDLt1sCWCHVQ2D6RCLepOUc11T7/JPGhckrwBFfkXL4SFYqvM9/HvgndqN4vt
         HA5ADHSxUBroAkrsSobeU9I2+XYnYQWA8n7qWndqeQeTYy6hrnFkA6VxoGN03W6uSwDe
         80Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031082; x=1692635882;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFQ8vC5XQzgbvA+JsLCqADpM15IC2vMeMSJvkR1GdkU=;
        b=VQ4M38+cNJlapv/+2d7s3694Scizi5VRG+gxN8twE72zt5LHabChYWEggDJ4OBL/Uo
         dq6eXycRmWnrpjYGXHspJlsBi2sOvlLm2u7mJFZ08Svactiyx+BhgTYgQchDg4PkcFJA
         Xl5IEDFY5Mng4EifCxWGrAsIJakk0onqO3zN+x+CAkvb0s+R5hk50V3iRoOiM6pqg8pc
         vXLpYPBIsluRJHAao9XXwAN0r+aI5iu7PWYQee3bjtwId4h6B1T+dOzO5Cj4OgBOCuK9
         pviBeKFvAk4vGEn1ev7oc7JBjwqNhvptsHDj3k+eBPzmNoShAgyPOwZHAZ5m/dfoX74K
         XC8g==
X-Gm-Message-State: AOJu0YwF1j5fblhMLXbhtdYKmdt7ahLzrRjs6yKwhrbpTAVQudxweVx6
        NCiJr1+DC9S33K/MMBMO3ok9l3Ng+JGK
X-Google-Smtp-Source: AGHT+IGvxWe5XAH8eHCUck5OYb1/bre01R7f62ujA3WsqNi5U1902cjcsrT+MMekH4kJ+OvWVK4nJEhqw+OR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a919:6125:510f:f0ef])
 (user=irogers job=sendgmr) by 2002:a25:23c9:0:b0:d47:3d35:1604 with SMTP id
 j192-20020a2523c9000000b00d473d351604mr179595ybj.2.1692031082702; Mon, 14 Aug
 2023 09:38:02 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:54 -0700
Message-Id: <20230814163757.3077138-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v3 0/3] perf list: Remove duplicate PMUs
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple PMUs, differing by ordered suffixes, by
default only display one. This avoids repeated listing of events, in
particular when there are 10s of uncore PMUs. If "-v" is passed to
"perf list" then still list all PMUs.

Listing fewer PMU/event combinations helps speed the all PMU event
tests.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
...
$ perf list -v
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
...
```

The PMUs are sorted by name then suffix as a part of this change.

v3: Add detail to patch 1 sorting commit message about the suffix and
    why sorting is necessary.
v2: List all PMUs when "-v" is passed as suggested by John Garry
    <john.g.garry@oracle.com>.

Ian Rogers (3):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Add scan that ignores duplicates, use for perf list
  perf pmus: Don't print duplicate PMU suffix in list by default

 tools/perf/builtin-list.c      |   8 +++
 tools/perf/util/pmus.c         | 120 +++++++++++++++++++++++++++++++--
 tools/perf/util/print-events.h |   1 +
 3 files changed, 122 insertions(+), 7 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog

