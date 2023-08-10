Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E97780AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjHJStF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjHJStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:49:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417C2706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:49:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5868992ddd4so16442387b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693342; x=1692298142;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2WWD5RZ7txT2y+bELeSkVRhqrv7guu+AZxZ+/B7ig64=;
        b=o6wAtGQZ+EMExEpuZahj/6wsFfkHVecrBuxbrUbdt4kWtVVWlsOch4CjsXbTwhXhxH
         zxl0RCAPlpLOCS/l8jd8aiJFY1P8RgMKDRhXUzHclXHUuM+GygFj1DEKAOeIRB29b1kv
         oSeQOZkYAoO6O808GInBOzO56yOKAMbzQf+rjffwfV5gfWwSX32XkyriMgY3psluxqNV
         X9novVdNaiywNUONa6PhYsD787KsL9D2WtcSr+O3ajPI/SXxFqoYCiE8Zd5o782PqCaL
         ALWFZ6CXNi2XIkKbUQHNSTnO6EGNfwEFqaEi04rZCxhtRHiWuOOQOkp/5m+co1mjQcXY
         ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693342; x=1692298142;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WWD5RZ7txT2y+bELeSkVRhqrv7guu+AZxZ+/B7ig64=;
        b=HMeBd++UtsBAY9fIB/HNq2DYZ8gwh8Fr6uznb2kkWiG9+gV6VazVBGSYxTpqn/IYC1
         HBzvDhCK+iypMeYfIEjaMiXuBpA2RSYRhH3KtsCjQQp/J40Ck/cLo8c+iIMbO+h2MUyB
         2gtTQH6IgkU5l8sgo55Zz43axKV1x2fa/06B4Gf4NVbK/3OVlChvdvA839oPVegih+P4
         nTz1ufbgQGzXnxVhq/CjHL09qNr0Yl5ZvgxXjpxYlvb7X1NWp5bV217oFqZ+lId0yeV+
         q0j9jq3K9NGb419KKYRnxjjypt3lCjPYVRsoFjnCYGhPExQul4UC8uoyLxSf5w+iLFVd
         cyaw==
X-Gm-Message-State: AOJu0Yxr4vX76c3GeFOhVodIGsXbB/V+WlY5xSiwmRp5Aq1gaRXJ61gz
        qVMzxaVVDdxGDMxwHlmVd14EkHv4AQXd
X-Google-Smtp-Source: AGHT+IFE9EYsPE6iA3GxYy5BS/jQkuwPyiISjc4pFGXsdQlHdsFatosLNj3Mf8IlBuDHO64S2yFQbFam0TmK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a81:af06:0:b0:581:7b58:5e70 with SMTP id
 n6-20020a81af06000000b005817b585e70mr68906ywh.5.1691693342432; Thu, 10 Aug
 2023 11:49:02 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:48:49 -0700
Message-Id: <20230810184853.2860737-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1 0/4] Remove BPF event support
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        He Kuang <hekuang@huawei.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series removes BPF event support as past commits have shown
the support has bit rotten:
https://lore.kernel.org/lkml/20230728001212.457900-1-irogers@google.com/

Similar functionality is now available via the --filter option, that
uses a BPF skeleton, and is therefore more compact and simpler to
use. The simplicity coming from not having to build BPF object files.

A different use case for the events was for syscall augmentation in
perf trace. So that this isn't broken, and to make its use
significantly simpler, the support is migrated to use a BPF
skeleton. This means perf trace is much more likely to augment
syscalls for users.

Removal of BPF events was raised on LKML two weeks ago with the
original authors cc-ed:
https://lore.kernel.org/lkml/CAP-5=fXxGimJRXKf7bcaPqfjxxGcn1k3CspY_iSjQnpAKs3uFQ@mail.gmail.com/

BPF events are described publicly in very few places but one is:
https://www.brendangregg.com/perf.html#eBPF
"eBPF is currently a little restricted and difficult to use from
perf. It's getting better all the time. A different and currently
easier way to access eBPF is via the bcc Python interface, which is
described on my eBPF Tools page. On this page, I'll discuss perf."

I don't think the "getting better all the time" is any longer true as
BPF features are being added to perf primarily by using BPF
skeletons. The given example is a filter and would be better supported
via "perf record --filter".

Ian Rogers (4):
  perf parse-events: Remove BPF event support
  perf trace: Migrate BPF augmentation to use a skeleton
  perf bpf examples: With no BPF events remove examples
  perf trace: Tidy comments

 tools/perf/Documentation/perf-config.txt      |   33 -
 tools/perf/Documentation/perf-record.txt      |   22 -
 tools/perf/Makefile.config                    |   43 -
 tools/perf/Makefile.perf                      |   19 +-
 tools/perf/builtin-record.c                   |   45 -
 tools/perf/builtin-trace.c                    |  310 +--
 tools/perf/examples/bpf/5sec.c                |   53 -
 tools/perf/examples/bpf/empty.c               |   12 -
 tools/perf/examples/bpf/hello.c               |   27 -
 tools/perf/examples/bpf/sys_enter_openat.c    |   33 -
 tools/perf/perf.c                             |    2 -
 tools/perf/tests/.gitignore                   |    5 -
 tools/perf/tests/Build                        |   31 -
 tools/perf/tests/bpf-script-example.c         |   60 -
 tools/perf/tests/bpf-script-test-kbuild.c     |   21 -
 tools/perf/tests/bpf-script-test-prologue.c   |   49 -
 tools/perf/tests/bpf-script-test-relocation.c |   51 -
 tools/perf/tests/bpf.c                        |  390 ----
 tools/perf/tests/builtin-test.c               |    3 -
 tools/perf/tests/clang.c                      |   32 -
 tools/perf/tests/llvm.c                       |  219 --
 tools/perf/tests/llvm.h                       |   31 -
 tools/perf/tests/make                         |    2 -
 tools/perf/tests/tests.h                      |    2 -
 tools/perf/trace/beauty/beauty.h              |   15 +-
 tools/perf/util/Build                         |    8 +-
 tools/perf/util/bpf-loader.c                  | 2006 -----------------
 tools/perf/util/bpf-loader.h                  |  216 --
 .../bpf_skel/augmented_raw_syscalls.bpf.c}    |   35 +-
 tools/perf/util/c++/Build                     |    5 -
 tools/perf/util/c++/clang-c.h                 |   43 -
 tools/perf/util/c++/clang-test.cpp            |   67 -
 tools/perf/util/c++/clang.cpp                 |  225 --
 tools/perf/util/c++/clang.h                   |   27 -
 tools/perf/util/config.c                      |    4 -
 tools/perf/util/llvm-utils.c                  |  612 -----
 tools/perf/util/llvm-utils.h                  |   69 -
 tools/perf/util/parse-events.c                |  268 ---
 tools/perf/util/parse-events.h                |   15 -
 tools/perf/util/parse-events.l                |   31 -
 tools/perf/util/parse-events.y                |   44 +-
 41 files changed, 133 insertions(+), 5052 deletions(-)
 delete mode 100644 tools/perf/examples/bpf/5sec.c
 delete mode 100644 tools/perf/examples/bpf/empty.c
 delete mode 100644 tools/perf/examples/bpf/hello.c
 delete mode 100644 tools/perf/examples/bpf/sys_enter_openat.c
 delete mode 100644 tools/perf/tests/.gitignore
 delete mode 100644 tools/perf/tests/bpf-script-example.c
 delete mode 100644 tools/perf/tests/bpf-script-test-kbuild.c
 delete mode 100644 tools/perf/tests/bpf-script-test-prologue.c
 delete mode 100644 tools/perf/tests/bpf-script-test-relocation.c
 delete mode 100644 tools/perf/tests/bpf.c
 delete mode 100644 tools/perf/tests/clang.c
 delete mode 100644 tools/perf/tests/llvm.c
 delete mode 100644 tools/perf/tests/llvm.h
 delete mode 100644 tools/perf/util/bpf-loader.c
 delete mode 100644 tools/perf/util/bpf-loader.h
 rename tools/perf/{examples/bpf/augmented_raw_syscalls.c => util/bpf_skel/augmented_raw_syscalls.bpf.c} (93%)
 delete mode 100644 tools/perf/util/c++/Build
 delete mode 100644 tools/perf/util/c++/clang-c.h
 delete mode 100644 tools/perf/util/c++/clang-test.cpp
 delete mode 100644 tools/perf/util/c++/clang.cpp
 delete mode 100644 tools/perf/util/c++/clang.h
 delete mode 100644 tools/perf/util/llvm-utils.c
 delete mode 100644 tools/perf/util/llvm-utils.h

-- 
2.41.0.640.ga95def55d0-goog

