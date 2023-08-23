Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05378526C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjHWIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjHWIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB409E61
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-592210fe8easo33162157b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778112; x=1693382912;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2JVycqj7NyzXptj4+H0IvIRwFTBhGtFQhZxDM1SxBA=;
        b=hPFzweU/vPs5vXDl3IvqbHUSZT/woIU8PZMfdhekcWrr/26OCLjJfo/qBcq4q7ZMsv
         QU73QX8wiv4A3GBJDkOiaTCJaJhs8K/LfdwQc8EV9ltbJadYp3y2hp9EnpjddCCuugJV
         qOlxdV/9DByiwFjXWtRHrlS/jXuO0Aj9Dp336hYc0l07yV0c8C1ERKWWfvQblOfOZ9IA
         qVJFQSaQMQLx61sUwGaKivfCT+jhJIwbTCWVv9PdGB/SsX3J/xfM8lLuIYIvvasL+rGU
         pe3HnwCWHYAq2t8eLzlV8WIv+5KmABrBjM29CsqAh0XMjZSZnj6c0Lgp4CgIucF8UdA7
         rZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778112; x=1693382912;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2JVycqj7NyzXptj4+H0IvIRwFTBhGtFQhZxDM1SxBA=;
        b=NLAtray1FHEWmcQN3IgFV8CiMfzY9X6t+ELa7HQEGO+ScX56DWZNoMriDkJXEwn/W/
         PPBqvbbU5XaCmzof3ukY5MqcE+MD8NSEeMo3xVe6VO4YLTBCDCLh0eu5FFpnRid5fyL5
         w310CmJTQBcTf8hDM8Bf3sgY4qO50pkzPlQY1ICL56qyD9iN3vxC0isl6ouB13h3mY4j
         gzBDpVt/DGltKgsek1gerp9QlYDMWmXeJKnKi4Ci0LGDx6SnGEZJbzBDXmyBAqE0+aKE
         EvapDIYyxGLogJjyGO1GkIFmmriNu1o69s39FkWvqATwOFW7fs20tWGPGN2ow582MGwD
         hmUA==
X-Gm-Message-State: AOJu0YyI5X3YbTsJjqWIjubKCITUPxHT35dmtMbJec9BOrubQXRE+Yhc
        QtnGxClHtn+jgT8f4p9hyRnJ/+FS0y1r
X-Google-Smtp-Source: AGHT+IFDpiyvw2quRyqNwtWZepy68qkaJhARjQRj4Xbv5XR4q+3rBCbNgfUiVt+dUc4SB+NEmDDXm4qGO4Ka
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:2c7:0:b0:cb1:918b:d19b with SMTP id
 190-20020a2502c7000000b00cb1918bd19bmr145769ybc.0.1692778112102; Wed, 23 Aug
 2023 01:08:32 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:03 -0700
Message-Id: <20230823080828.1460376-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 00/25] Lazily load PMU data
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Binary size reduction of 1.4% or 143,264 bytes because the PMU
name no longer appears in the string.

stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open calls reduced
from 171 to 94.

stat default minor faults reduced from 1085 to 1727, open calls reduced
from 654 to 343.

Average PMU scanning reduced from 4720.641usec to 2927.293usec.
Average core PMU scanning reduced from 1004.658usec to 232.668usec
(4.3x faster).

Ian Rogers (25):
  perf script ibs: Remove unused include
  perf pmu: Avoid a path name copy
  perf pmu: Move perf_pmu__set_format to pmu.y
  perf pmu: Reduce scope of perf_pmu_error
  perf pmu: Avoid passing format list to perf_pmu__config_terms
  perf pmu: Avoid passing format list to perf_pmu__format_type
  perf pmu: Avoid passing format list to perf_pmu__format_bits
  perf pmu: Pass PMU rather than aliases and format
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

 tools/perf/arch/x86/util/intel-pt.c      |  39 +-
 tools/perf/bench/pmu-scan.c              |   8 +-
 tools/perf/pmu-events/empty-pmu-events.c |  49 +-
 tools/perf/pmu-events/jevents.py         | 319 +++++++--
 tools/perf/pmu-events/pmu-events.h       |  15 +-
 tools/perf/tests/parse-events.c          |   2 +-
 tools/perf/tests/pmu-events.c            | 183 ++---
 tools/perf/tests/pmu.c                   |  76 +-
 tools/perf/util/amd-sample-raw.c         |   1 -
 tools/perf/util/metricgroup.c            |  10 +-
 tools/perf/util/parse-events.c           |  91 ++-
 tools/perf/util/parse-events.h           |   3 +-
 tools/perf/util/pmu.c                    | 872 +++++++++++++++--------
 tools/perf/util/pmu.h                    | 110 ++-
 tools/perf/util/pmu.y                    |  32 +-
 tools/perf/util/pmus.c                   | 230 ++----
 tools/perf/util/s390-sample-raw.c        |  50 +-
 17 files changed, 1251 insertions(+), 839 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

