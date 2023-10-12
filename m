Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF87C7543
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441952AbjJLR4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:56:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2425CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7e4745acdso19507997b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133409; x=1697738209; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WBYNCwMRWf2j/q/jHdVPvtgHF8EEuq5iigzIRPIKj74=;
        b=UA0+ynfW3kqF8FpfieUTk/yFBWoxAkzVA+DSBD//QT/H3HY8SsUWulcrR/bYvaJDxo
         LKCH/IkD/fevswyvkjFZ9Me3zSljXO9s9JG0DJQYoimj5keNf9N+7oVzEdJWCgbt8/E/
         UWWN/XcAhgwRwNz2Pv0tI74XiiYjTIW/8jAmTnBjsFpt5tTwI0/smjIJdtKIgsc22hUM
         wyEYwg1AquvVWoxb4a69yESAPlVzVvdLMQVCYPdr/nVhFpawpVIkTnAzVYT+DP4FO1yN
         zEILy4Vv+dCcQ4dTI0j1dxUTdSFodrPSKWv8gSiwYHZsHateGcyIOQGofWEIwe+GOESU
         HEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133409; x=1697738209;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBYNCwMRWf2j/q/jHdVPvtgHF8EEuq5iigzIRPIKj74=;
        b=Fpm8fuIuKNLwxAWza7pj6MxxtSIEJ2mKhYte46RAkB6zntMBxzVjSjmUDoxeFkL/kT
         5H2zQX+Q8n81C7hoKP9E52kCqZNbUF5zbqdrfkoh2hPk1safKV4eKHsyAv0gClT0UhI9
         ESFmRF3GSLHqtwsEUrlzunPKA0TSfScu9FNKjZ0ZbGSpfMBdsg4DbtxVmeanLa9UrEoS
         NkGp4pWQaCvCPKPxhgZdgzDPiayagGRX9woBtKdCtGlEXKNaPbWwgWvfRA614/ay1P7R
         nSXMDA39keKWuVP40+GEtZQWojnYnY3bcHgFvrSO9+8flWqbTqhOI3Mm9lffnLR9obVF
         tcvg==
X-Gm-Message-State: AOJu0YxIBYCYEOE9fmG8hjIip7Hd1qe2wv7jjTGDPXklOMlokuCplXtG
        8GkqC7xxrFBoEPwoWUbQplsHr1NAihyC
X-Google-Smtp-Source: AGHT+IHw+89XI9SqD0f3m9NX2o1w09tj2COvD8HCR0n2aQj6ML6m/aLtOYL6vAFj+X7KkMX5yLAMWHeWEz1n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a81:bc0d:0:b0:58c:b45f:3e94 with SMTP id
 a13-20020a81bc0d000000b0058cb45f3e94mr498616ywi.8.1697133409197; Thu, 12 Oct
 2023 10:56:49 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:38 -0700
Message-Id: <20231012175645.1849503-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 0/7] PMU performance improvements
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
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

Performance improvements to pmu scanning by holding onto the
event/metric tables for a cpuid (avoid regular expression comparisons)
and by lazily computing the default perf_event_attr for a PMU.

Before
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 251.990 usec (+- 4.009 usec)
  Average PMU scanning took: 3222.460 usec (+- 211.234 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 260.120 usec (+- 7.905 usec)
  Average PMU scanning took: 3228.995 usec (+- 211.196 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 252.310 usec (+- 3.980 usec)
  Average PMU scanning took: 3220.675 usec (+- 210.844 usec)

After:
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 28.530 usec (+- 0.602 usec)
  Average PMU scanning took: 275.725 usec (+- 18.253 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 28.720 usec (+- 0.446 usec)
  Average PMU scanning took: 271.015 usec (+- 18.762 usec)
% Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 31.040 usec (+- 0.612 usec)
  Average PMU scanning took: 267.340 usec (+- 17.209 usec)

Measuring the pmu-scan benchmark on a Tigerlake laptop: core PMU
scanning is reduced to 11.5% of the previous execution time, all PMU
scanning is reduced to 8.4% of the previous execution time. There is a
4.3% reduction in openat system calls.

v2. Address feedback from Adrian Hunter and Yang Jihong to allow the
    caching to address varying CPUIDs per PMU (currently an ARM64 only
    feature) and to cache when there is no table to return.

Ian Rogers (7):
  perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
  perf intel-pt: Move PMU initialization from default config code
  perf arm-spe: Move PMU initialization from default config code
  perf pmu: Const-ify file APIs
  perf pmu: Const-ify perf_pmu__config_terms
  perf pmu-events: Remember the perf_events_map for a PMU
  perf pmu: Lazily compute default config

 tools/perf/arch/arm/util/cs-etm.c    |  13 +---
 tools/perf/arch/arm/util/pmu.c       |  10 +--
 tools/perf/arch/arm64/util/arm-spe.c |  48 ++++++------
 tools/perf/arch/s390/util/pmu.c      |   3 +-
 tools/perf/arch/x86/util/intel-pt.c  |  27 +++----
 tools/perf/arch/x86/util/pmu.c       |   6 +-
 tools/perf/pmu-events/jevents.py     | 109 +++++++++++++++++----------
 tools/perf/util/arm-spe.h            |   4 +-
 tools/perf/util/cs-etm.h             |   2 +-
 tools/perf/util/intel-pt.h           |   3 +-
 tools/perf/util/parse-events.c       |  12 +--
 tools/perf/util/pmu.c                |  38 +++++-----
 tools/perf/util/pmu.h                |  22 +++---
 tools/perf/util/python.c             |   2 +-
 14 files changed, 160 insertions(+), 139 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

