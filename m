Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0117C656A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbjJLGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjJLGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B33BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bcbb95b2so9738737b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091843; x=1697696643; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QJQ7uhIxdVvam4EsyPr00sicdDNbMv8/7DafmssRJc=;
        b=q8asiOS7fGW7Q4TUpCn/E5BwcBKRPa2Z6TMoj3KMqcOKF6vFp8JaXNKJXZ/JMwomgd
         +mu+2/+7nSDTmnkrOKgb3TUCxPgaxxAovXwqcwrFBHzV3TVcsYWDcxvZfH/lAOlcFVxO
         GRTjE++HeKTs0GQ3xEbQVqClAxiOW4c2qdJPkvd8d35nkQB3iqomyDw2AukUR7H9VOvB
         su6QVB3cEkRaF4I/YPe3r68mjugQh08jtxH1BM7/o4dIC0uYIz5kzp8uJga3jafQzlBQ
         u16c+Ze2GhPMVIaqNW44W4/IjamLX/8ZfeeQgHiSorjWm4Qie7veIT8mr+Nf057wCtuM
         LoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091843; x=1697696643;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QJQ7uhIxdVvam4EsyPr00sicdDNbMv8/7DafmssRJc=;
        b=BYjKzUges0fFIQizVmSLzd+TpOexeozJ6+xTgicmIMxEro+ib7nIqxz/l4AUAjzmTw
         LmeRj6feexJdX+v+bI0A6wrsd1PtovkWAb5r1jFBhW1UPqOqIlmUyhSliUx2tY+7BQwW
         ZgQsT8VTo/zMp1g7rG2+XJHjb5d8991/WllO8qjtRWloC8OwvVKrFx/ZujqI3o1byABg
         Q4ipyG8xgkyXFrT7z71tcFuGOCP02vwJpgAr418FIVbBZ1V2qVkePwoqq29+lCA+U+Gh
         KRMkJhytDM4tEdamM3Ai5fVNp9beqb9AcIYnNAIVFxoGLeBA8yHYvhSAhLDFqQ2UQoU0
         rH4A==
X-Gm-Message-State: AOJu0YyE/DpwnnuRbWcZX1Jn7WrbNG9TAgWYBJLJLIA8v3fstVF9yfXi
        +uhnYFHAlGcwSd3Kovw8CEOZLIei1jPw
X-Google-Smtp-Source: AGHT+IE9+bGU2dJLV4W9drtMJyLl57j1AoK17XLAh2MK1ViWE0qAcDAFExgoSJrPBgJDJHq6P7kediUOKvSZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:a84a:0:b0:59b:e97e:f7df with SMTP id
 f71-20020a81a84a000000b0059be97ef7dfmr417701ywh.2.1697091843534; Wed, 11 Oct
 2023 23:24:03 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:46 -0700
Message-Id: <20231012062359.1616786-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 00/13] Improvements to memory use
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

Fix memory leaks detected by address/leak sanitizer affecting LBR
call-graphs, perf mem and BPF offcpu.

Make branch_type_stat in callchain_list optional as it is large and
not always necessary - in particular it isn't used by perf top.

Make the allocations of zstd streams, kernel symbols and event copies
lazier in order to save memory in cases like perf record.

Handle the thread exit event and have it remove the thread from the
threads set in machine. Don't do this for perf report as it causes a
regression for task lists, which assume threads are never removed from
the machine's set, and offcpu events, that may sythensize samples for
threads that have exited.

The overall effect is to reduce memory consumption significantly for
perf top - with call graphs enabled running longer before 1GB of
memory is consumed. For a perf record of 'true', the memory
consumption goes from 39912kb max resident to 20820kb max resident -
nearly halved.

v2: Add additional memory fixes on top of initial LBR and rc check
    fixes.

Ian Rogers (13):
  perf machine: Avoid out of bounds LBR memory read
  libperf rc_check: Make implicit enabling work for GCC
  perf hist: Add missing puts to hist__account_cycles
  perf threads: Remove unused dead thread list
  perf offcpu: Add missed btf_free
  perf callchain: Make display use of branch_type_stat const
  perf callchain: Make brtype_stat in callchain_list optional
  perf callchain: Minor layout changes to callchain_list
  perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
  perf record: Lazy load kernel symbols
  libperf: Lazily allocate mmap event copy
  perf mmap: Lazily initialize zstd streams
  perf machine thread: Remove exited threads by default

 tools/lib/perf/include/internal/mmap.h     |  2 +-
 tools/lib/perf/include/internal/rc_check.h |  6 ++-
 tools/lib/perf/mmap.c                      |  9 ++++
 tools/perf/builtin-inject.c                |  4 ++
 tools/perf/builtin-record.c                |  2 +
 tools/perf/builtin-report.c                |  7 +++
 tools/perf/util/Build                      |  1 +
 tools/perf/util/bpf_off_cpu.c              | 10 ++--
 tools/perf/util/branch.c                   |  4 +-
 tools/perf/util/branch.h                   |  4 +-
 tools/perf/util/callchain.c                | 62 ++++++++++++++--------
 tools/perf/util/callchain.h                | 18 +++----
 tools/perf/util/compress.h                 |  1 +
 tools/perf/util/event.c                    |  4 +-
 tools/perf/util/hist.c                     | 16 +++---
 tools/perf/util/machine.c                  | 39 +++++++-------
 tools/perf/util/machine.h                  |  1 -
 tools/perf/util/map_symbol.c               | 15 ++++++
 tools/perf/util/map_symbol.h               |  4 ++
 tools/perf/util/mmap.c                     |  5 +-
 tools/perf/util/mmap.h                     |  1 -
 tools/perf/util/symbol.c                   |  5 +-
 tools/perf/util/symbol_conf.h              |  4 +-
 tools/perf/util/thread.h                   | 14 +++++
 tools/perf/util/zstd.c                     | 61 +++++++++++----------
 25 files changed, 196 insertions(+), 103 deletions(-)
 create mode 100644 tools/perf/util/map_symbol.c

-- 
2.42.0.609.gbb76f46606-goog

