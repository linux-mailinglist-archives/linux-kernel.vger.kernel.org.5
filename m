Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E67BC41C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjJGCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:13:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D75BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:13:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d816fa2404aso3729725276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644825; x=1697249625; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JEVjZ6N3og+gW+xMTkpMzQJ6pQd4TOr0IjDXaW6Z93M=;
        b=Sh7Z5eAOKDlJFvMF4do3ce2itXjTZsOeGNFBKEnY0eQPyChXiauARjZ6JFGYkgNthA
         wVYwiNHVh/rievmGACu4lHjj4o9+b0/N5a97/pT5lFGJFmzA5v7Rj2wuKOFcal2BI9qI
         ZmFq3Nzxltnhm58fNGdiMzMdgl0JHt3/M/7vt4vEDxMin9/qNPAmIZWzC7TutGFaRIk1
         tX8MHvMgdhTUFzJlnt0YOetRiVO1yUOkkeN1NAWJCxTSM5iq6yWKotEP8biwyaOwy38X
         lsSRhto77rhVOIF1F3DwX/Ds+UYYkr1BANyxj7fu0KgCbt2eTlRYaJgldPHcTCT5VSRf
         fEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644825; x=1697249625;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEVjZ6N3og+gW+xMTkpMzQJ6pQd4TOr0IjDXaW6Z93M=;
        b=baOQ8Pn7+Yc0ngWdZwDVoo7UYd4DvsFIERZOgvdk+aAZKHAN0SmDmHYvcrZeFNLAJ7
         0bevVzkrGMvizciycFD02gFhn5SX/Ne7WOOm9suFYdRwAZ5Mi+CoQkyRmjFHcS9kaqT6
         XPf74R7A+l78cMnBEMDDPCN25ZP03UyzUwLBT9oeGQw8W8rXnbCIvr6GtF2Q6ZFQLfIC
         BJyE2319dN4oQL0pdsI4b6hXI2doQC49PHltkwooVcg9npQcoJlIoaWYmwKon61ZEpmv
         vAQ75gUEVHfyNKEtccfbNwE0mSEOYw81SG0LXqQhDzIpLZ/L6jkrIQwfkYV11bH2Kknl
         oTnA==
X-Gm-Message-State: AOJu0Yzl+yReVT4mnP3Jrq5nl0CqD8h+UdK0a2mghnqSvobQcQ27iiZq
        xDKUcbgaQE6HgNdVi8jBGjj3pM5biVM6
X-Google-Smtp-Source: AGHT+IF2EWY4ixpkApTIlh/URgj2hH2/ff+8VAS2lTt0A8xa82u8MZbVhfUp9TQhyImXiXti7n+Pv8SxiS2H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:2513:0:b0:d0f:a0a6:8e87 with SMTP id
 l19-20020a252513000000b00d0fa0a68e87mr142757ybl.2.1696644825394; Fri, 06 Oct
 2023 19:13:45 -0700 (PDT)
Date:   Fri,  6 Oct 2023 19:13:19 -0700
Message-Id: <20231007021326.4156714-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 0/7] PMU performance improvements
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Ian Rogers (7):
  perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
  perf intel-pt: Move PMU initialization from default config code
  perf arm-spe: Move PMU initialization from default config code
  perf pmu: Const-ify file APIs
  perf pmu: Const-ify perf_pmu__config_terms
  perf pmu-events: Remember the events and metrics table
  perf pmu: Lazily compute default config

 tools/perf/arch/arm/util/cs-etm.c    | 13 ++------
 tools/perf/arch/arm/util/pmu.c       | 10 +++---
 tools/perf/arch/arm64/util/arm-spe.c | 48 +++++++++++++---------------
 tools/perf/arch/s390/util/pmu.c      |  3 +-
 tools/perf/arch/x86/util/intel-pt.c  | 27 +++++++---------
 tools/perf/arch/x86/util/pmu.c       |  6 ++--
 tools/perf/pmu-events/jevents.py     | 48 ++++++++++++++++------------
 tools/perf/util/arm-spe.h            |  4 ++-
 tools/perf/util/cs-etm.h             |  2 +-
 tools/perf/util/intel-pt.h           |  3 +-
 tools/perf/util/parse-events.c       | 12 +++----
 tools/perf/util/pmu.c                | 39 +++++++++++-----------
 tools/perf/util/pmu.h                | 18 ++++++-----
 tools/perf/util/python.c             |  2 +-
 14 files changed, 117 insertions(+), 118 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog

