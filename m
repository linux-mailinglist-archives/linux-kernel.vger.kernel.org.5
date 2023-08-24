Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE978668A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbjHXENw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjHXENk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:13:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5710C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56c379a8250so4138636a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850418; x=1693455218;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7glduzwKUFKREskodQo/TuRyVqjFFfS9emVgfJc94XQ=;
        b=yGRQaxGW6QljvzX5CGhY6AG9R01mvnnDTAvn+bjqEho4bkGL7YoD/D+PCyu1ndCE1l
         ivlA6K5AMsHiN2HX3XZfO8fJlMikh7lxbqLaaJnPwBCzUMkBhDYBaxXsADFvAhevGN8n
         9Gqf8Dsb6ZlZynw1gJGAkbxLKtuRejHK1JITXZKJtqJRe0YNX/6kL53TGe1lDkuoqVr7
         3xdhHh/M5rpLmdSUDdf9mp6+lLvNG8j7FaOIsx++GeHyCCI5lnRUQUQcoRNm5/j7an0X
         I5GcnEIqbczuhlmD1I9lTVx3SlOa3cmob6As7oJStNBCCCKiastVh2bNxRQOEtwEdOpj
         yyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850418; x=1693455218;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7glduzwKUFKREskodQo/TuRyVqjFFfS9emVgfJc94XQ=;
        b=bJIohuIAsPhVAShrKYdhOX2NQ4d0hlqSrdr4tM/XWIm8hA8PrSeZD+C+mnSUp0Xdo8
         /gyTCc2H4Hdv8UvUPRsWiJ4dxW5nzFB0xzEHZinPct4PzNUk1NXy/SYkIINiQi7c5cxJ
         8dq1Hvg+94besXu89TXxalEB4Pxy5YP4glj9INqp7P1fw3C0h7Xk9PbLQq21nJnC/FGQ
         WZC5vA7eP1fr+KCL5k9Re2bz/xqO5f6hRcWI9ClwIlmywK14KxQzdJjxVGld8D0Ns3LB
         dRjRnrBwG1vto4Qz7r9qxxnKoxLhKem98hBJRxkeaw3M2oDQfIZpA70LCLOABXWfRzgD
         Tl/Q==
X-Gm-Message-State: AOJu0YzbvNHNhPB9PplSpDHKfYXrRIGJU4ruNe0UzLsrRPP5HOXLWqmU
        RHNVqitTF5srMKgyVco3GYhL4N9fWCyy
X-Google-Smtp-Source: AGHT+IEkhxrkbFxU96OoYjfhWSHyI4SuXn7WF5bc74nkpjCPwqEpAKsXQzl15tTOIIkkrxlMnISi0OboYc1Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a63:754f:0:b0:565:eb51:3866 with SMTP id
 f15-20020a63754f000000b00565eb513866mr2600100pgn.11.1692850417799; Wed, 23
 Aug 2023 21:13:37 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:12 -0700
Message-Id: <20230824041330.266337-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 00/18] Lazily load PMU data
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
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

Lazily load PMU data both from sysfs and json files. Reorganize
json data to be more PMU oriented to facilitate this, for
example, json data is now sorted into arrays for their PMU.

In refactoring the code some changes were made to get rid of maximum
encoding sizes for events (256 bytes), with input files being directly
passed to the lex generated code. There is also a small event parse
error message improvement.

Some results from an Intel tigerlake laptop running Debian:

Binary size reduction of 5.3% or 552,864 bytes because the PMU
name no longer appears in the string or desc field.

stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls reduced
from 171 to 94.

stat default minor faults reduced from 1805 to 1717, open calls reduced
from 654 to 343.

Average PMU scanning reduced from 4720.641usec to 2927.293usec.
Average core PMU scanning reduced from 1004.658usec to 232.668usec
(4.3x faster).

v2: Add error path for failing strdup when allocating a format,
    suggested by Arnaldo. Rebased on top of tmp.perf-tools-next
    removing 8 patches. Added "perf jevents: Don't append Unit to
    desc" to save yet more encoding json event space.

Ian Rogers (18):
  perf pmu: Make the loading of formats lazy
  perf pmu: Abstract alias/event struct
  perf pmu-events: Add extra underscore to function names
  perf jevents: Group events by PMU
  perf parse-events: Improve error message for double setting
  perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
  perf pmu-events: Reduce processed events by passing PMU
  perf pmu-events: Add pmu_events_table__find_event
  perf pmu: Parse sysfs events directly from a file
  perf pmu: Prefer passing pmu to aliases list
  perf pmu: Merge json events with sysfs at load time
  perf pmu: Cache json events table
  perf pmu: Lazily add json events
  perf pmu: Scan type early to fail an invalid PMU quickly
  perf pmu: Be lazy about loading event info files from sysfs
  perf pmu: Lazily load sysfs aliases
  perf jevents: Sort strings in the big C string to reduce faults
  perf jevents: Don't append Unit to desc

 tools/perf/arch/x86/util/intel-pt.c      |   2 +-
 tools/perf/bench/pmu-scan.c              |   8 +-
 tools/perf/builtin-list.c                |  13 +-
 tools/perf/pmu-events/empty-pmu-events.c |  49 +-
 tools/perf/pmu-events/jevents.py         | 312 +++++++--
 tools/perf/pmu-events/pmu-events.h       |  15 +-
 tools/perf/tests/parse-events.c          |   2 +-
 tools/perf/tests/pmu-events.c            | 148 +++--
 tools/perf/tests/pmu.c                   |   2 +-
 tools/perf/util/metricgroup.c            |  10 +-
 tools/perf/util/parse-events.c           |  87 ++-
 tools/perf/util/parse-events.h           |   3 +-
 tools/perf/util/pmu.c                    | 806 +++++++++++++++--------
 tools/perf/util/pmu.h                    |  96 ++-
 tools/perf/util/pmu.y                    |  20 +-
 tools/perf/util/pmus.c                   | 230 +++----
 tools/perf/util/s390-sample-raw.c        |  50 +-
 17 files changed, 1141 insertions(+), 712 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

