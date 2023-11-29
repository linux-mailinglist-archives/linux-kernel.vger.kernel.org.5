Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB447FCEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376994AbjK2GCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjK2GCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CD19AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db3fc4a1254so7689609276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237735; x=1701842535; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0G+iPFdqPEFrwKvYIt+aM1SI2CrgzPYcwp9sXOSF54=;
        b=F43Cdyei04AdOpfSQd3OpAJLSm9xhRahe1O9QqkF0mPs+iLhQVMaGKePv7pinYZ8Tt
         0wvo1siGlfX7V9OTI2E1LDcrKbupla3Oq1lkJ9v3JRvjB/+Z5gDI6OAfI7dgs+FN5cE6
         Hjx4ZL1f7OMt0sQXCWHzs+0jBc4NqNejl8NeWqOYRUlrJOu71IZ0zvvaojVqYF96RQUV
         fBz+l7xylyjOOwEaNhN8igDLxh1OHIortZ8drWSn4OsasC7ouRfbL1ihY0d2nc0kbL9J
         7Qb42/47N4NEToqDAXQRLXwX/AT3ivOJJ6+RvfdawBEMIyP2+qMNC69Fw5BO9I5kQPL9
         yahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237735; x=1701842535;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0G+iPFdqPEFrwKvYIt+aM1SI2CrgzPYcwp9sXOSF54=;
        b=s+pnFyxd6HHRE4dloOeixSf8XI1G4wHHnx16cjTjNJlGON4K4h0N5WECtITZTMeMcu
         gTycbKvaKO3+XvT4rUS5d73qZd5wZjJ8DyEZ2frUaoyJiuL4/zRWedkD+sBwLtIpPgkp
         7pH8jmW7j7mMoJa6y+tk7ftCif/i2v/X2zAV9Dr7VkfDCfvBLvztLtc409RCy8w2XmNV
         2YqJ+oyVuZd3htZqR9TRmU01wRuK0WgG0GRIs8BuX08FQHtJ20SeItrnV8wKzwVosSDA
         fM7S9ncDeH/vMYhWxmWGLl6nAt+KZi9l/f16P5TU/s1pcUFaIuuutb4mA/OetWHRr5cj
         Z0Yg==
X-Gm-Message-State: AOJu0Yw9X6alczuQ36SIbGwsMhA92JYRGP0fKcYxCFn/0bUB7adJ19Yf
        BPlvdWbV6jv+IJoCUS3BmLjl3ak6JIx/
X-Google-Smtp-Source: AGHT+IF0ACoSYZCtsTHrbz5F11NIz13TQ5Pg2yk0VsMy0quHAj1RB3jL2FGMYTv/jpjjrYqF7QXw8dBKFGOB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:d114:0:b0:da3:ab41:304a with SMTP id
 i20-20020a25d114000000b00da3ab41304amr505879ybg.4.1701237734702; Tue, 28 Nov
 2023 22:02:14 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:01:57 -0800
Message-Id: <20231129060211.1890454-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 00/14] Clean up libperf cpumap's empty function
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
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

Rename and clean up the use of libperf CPU map functions particularly
focussing on perf_cpu_map__empty that may return true for maps
containing CPUs but also with an "any CPU"/dummy value.

perf_cpu_map__nr is also troubling in that iterating an empty CPU map
will yield the "any CPU"/dummy value. Reduce the appearance of some
calls to this by using the perf_cpu_map__for_each_cpu macro.

Ian Rogers (14):
  libperf cpumap: Rename perf_cpu_map__dummy_new
  libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
  libperf cpumap: Rename perf_cpu_map__empty
  libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
  libperf cpumap: Add for_each_cpu that skips the "any CPU" case
  libperf cpumap: Add any, empty and min helpers
  perf arm-spe/cs-etm: Directly iterate CPU maps
  perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
    use
  perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
  perf top: Avoid repeated function calls
  perf arm64 header: Remove unnecessary CPU map get and put
  perf stat: Remove duplicate cpus_map_matched function
  perf cpumap: Use perf_cpu_map__for_each_cpu when possible
  libperf cpumap: Document perf_cpu_map__nr's behavior

 .../perf/Documentation/examples/sampling.c    |  2 +-
 .../perf/Documentation/libperf-sampling.txt   |  2 +-
 tools/lib/perf/Documentation/libperf.txt      |  4 +-
 tools/lib/perf/cpumap.c                       | 92 +++++++++++++------
 tools/lib/perf/evlist.c                       |  6 +-
 tools/lib/perf/evsel.c                        |  2 +-
 tools/lib/perf/include/perf/cpumap.h          | 56 ++++++++++-
 tools/lib/perf/libperf.map                    | 10 +-
 tools/lib/perf/tests/test-cpumap.c            |  4 +-
 tools/lib/perf/tests/test-evlist.c            |  6 +-
 tools/lib/perf/tests/test-evsel.c             |  2 +-
 tools/perf/arch/arm/util/cs-etm.c             | 83 +++++++----------
 tools/perf/arch/arm64/util/arm-spe.c          |  4 +-
 tools/perf/arch/arm64/util/header.c           | 15 +--
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           | 10 +-
 tools/perf/bench/epoll-ctl.c                  |  2 +-
 tools/perf/bench/epoll-wait.c                 |  2 +-
 tools/perf/bench/futex-hash.c                 |  2 +-
 tools/perf/bench/futex-lock-pi.c              |  2 +-
 tools/perf/bench/futex-requeue.c              |  2 +-
 tools/perf/bench/futex-wake-parallel.c        |  2 +-
 tools/perf/bench/futex-wake.c                 |  2 +-
 tools/perf/builtin-c2c.c                      |  6 +-
 tools/perf/builtin-ftrace.c                   |  2 +-
 tools/perf/builtin-record.c                   |  4 +-
 tools/perf/builtin-stat.c                     | 31 +------
 tools/perf/tests/bitmap.c                     | 13 +--
 tools/perf/tests/code-reading.c               |  2 +-
 tools/perf/tests/cpumap.c                     |  2 +-
 tools/perf/tests/keep-tracking.c              |  2 +-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  2 +-
 tools/perf/tests/perf-time-to-tsc.c           |  2 +-
 tools/perf/tests/sw-clock.c                   |  2 +-
 tools/perf/tests/switch-tracking.c            |  2 +-
 tools/perf/tests/task-exit.c                  |  2 +-
 tools/perf/tests/topology.c                   | 48 +++++-----
 tools/perf/util/auxtrace.c                    |  4 +-
 tools/perf/util/bpf_counter.c                 |  2 +-
 tools/perf/util/bpf_kwork.c                   | 16 ++--
 tools/perf/util/bpf_kwork_top.c               | 12 +--
 tools/perf/util/cpumap.c                      | 14 ++-
 tools/perf/util/cputopo.c                     |  2 +-
 tools/perf/util/evlist.c                      |  4 +-
 tools/perf/util/evsel.c                       |  2 +-
 tools/perf/util/perf_api_probe.c              |  4 +-
 tools/perf/util/record.c                      |  4 +-
 .../scripting-engines/trace-event-python.c    | 12 ++-
 tools/perf/util/session.c                     |  5 +-
 tools/perf/util/stat.c                        |  2 +-
 tools/perf/util/svghelper.c                   | 20 ++--
 tools/perf/util/top.c                         |  9 +-
 53 files changed, 296 insertions(+), 254 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog

