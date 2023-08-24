Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BE9787B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbjHXW1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbjHXW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:27:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06F1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d9e327d3aso4484407b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916039; x=1693520839;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxbbdEcf8OWbRWmq4wU3iFPZpMe4/3EUR64PUokKaeQ=;
        b=K5K3vWoQU44G5bC69Sm9jvmBWdgzCRotqzYQrfHbdkFvxhkE5wNz+aMTCE19y8jxQ+
         5pUi4Jup1DuJr91sBlcVDkLE0UXfxuK8/u1eeupHi9u91mLEUSUK2RrppRZTOQ84yMdc
         AftR5gLU/Hs18plXw6k1A+//bdMc39xt6z3PcqzmFMcJY4q0u5eZ4LJyxkb/s/5TUlF7
         bNxQlLhyzJBpFhYXYkROROGPAUxLLzamk1lIo5C+A65rkn5ocGCvXXmkvgyXJ8gUggE3
         /h/vTZabWfkZ/d0rhU+6Auq7TP7SypzClKxzqUSJgF/ba4sptwxoRchgWVa4yJ5qiFOV
         q52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916039; x=1693520839;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxbbdEcf8OWbRWmq4wU3iFPZpMe4/3EUR64PUokKaeQ=;
        b=OdiQNTLu3z5bnFgOfCpDjHukYjqnelZT3CoNZklhgsZ407HTQ8sAFrrM6IkN3Q/v/E
         BELS+sUyd/oiBcwy8unIxYvlaamCj9Z9pdA70eEfugrqGosJiCLeaWrj1QHwwV/bIJGd
         a4WrvDN2qWPtLT7rzwCL1sY2pw8ucr3PNSBnGIFSMknghqw1n+sMK58TwC13rHFyoda/
         88tLmo1QrsudTnqCCeD7hZ5WbsWMZOcsrwa1IpSmiWbDpewc7ef7snfcGfgi0qjf9/dQ
         J9mUbCsVWifuxTtyfOQu7ebkDTNgaH2Nq7UAcjlmJykgDU97uhdDDTEBqIrvW36MCJaj
         sqAg==
X-Gm-Message-State: AOJu0YyXQq4r1jsC1IZW5brIUOhORQ29zF3MYkmcjfRH3nle4X7kGWDM
        TuZ3OhtbpiT4e8gQ256vc+v+BA40Jz0U
X-Google-Smtp-Source: AGHT+IHe7Ds6ZF7L4QrZRwMtXnxYwvFQA2MHBAnwCxktSH7oYgWN0lOhnsmmRWQIyQ0JlBwTkBIsVIiBoBcF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a25:ac82:0:b0:d77:e43d:6e80 with SMTP id
 x2-20020a25ac82000000b00d77e43d6e80mr128415ybi.6.1692916039527; Thu, 24 Aug
 2023 15:27:19 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:27:14 -0700
Message-Id: <20230824222716.553982-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v4 0/2] perf list: Remove duplicate PMUs
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

v4: Rebase on top of lazy PMU changes. Ignore numeric ordering due to
    gaps, suggested by Kan Liang <kan.liang@linux.intel.com>. Fold
    patches 2 & 3 as suggested by John Garry <john.g.garry@oracle.com>
    (done by accident as part of rebasing).
v3: Add detail to patch 1 sorting commit message about the suffix and
    why sorting is necessary.
v2: List all PMUs when "-v" is passed as suggested by John Garry
    <john.g.garry@oracle.com>.

Ian Rogers (2):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Skip duplicate PMUs and don't print list suffix by default

 tools/perf/builtin-list.c         |   8 +++
 tools/perf/util/pmu.c             |  17 +++--
 tools/perf/util/pmu.h             |   3 +-
 tools/perf/util/pmus.c            | 102 +++++++++++++++++++++++++++++-
 tools/perf/util/pmus.h            |   2 +
 tools/perf/util/print-events.h    |   1 +
 tools/perf/util/s390-sample-raw.c |   3 +-
 7 files changed, 126 insertions(+), 10 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

