Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC4807DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441980AbjLGBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLGBRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:22 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A3D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso1943667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911847; x=1702516647; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rho6A4K2pyLdXHAMEZCam07lp+rs55oaZJC5aHTkgLM=;
        b=wwFL3TABgZy8RfMkJuAMHXEItXtf5LPPFodTX1w5TT1jBdlb3ycvNw8M+4ZavGzGhh
         zDS334EQoyubupL4YMum0U8W/fknJa928CRXWAH73fGNSRDvDtPiHFo3mnFvvb00S+B6
         +K/TlX9jlB146f0hmtxO7lrRqXyr0JoUEDxL38S+UHyZiYo/NVzK6luSQot6A2DF/4C9
         H5wjiisOU3mAkHJ3bCposZBn4vDA/5eYpq3jDOGh6I8HBV9s2BPZDgg48LqzA3NDEBAh
         091sRLMC6gOHXpYxmbtRHNVhN717gil+9e/QfA7zw0z/crFxIoJmr3HlaqYcYJ6tHYig
         JOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911847; x=1702516647;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rho6A4K2pyLdXHAMEZCam07lp+rs55oaZJC5aHTkgLM=;
        b=Bs8D6LIK1gzuCl5llo1rcFCZ25Sdjuv1o4QeH7c+PeNAFOLbooSiaxmqlTBUokqXex
         d0aYdlV+HWSdxLBWZyVVomHBR9/f9AMcrkQJUTL4fgsszALuVThYzRfnw61lIedzCwbk
         ZqAW1K2Mw4QFk9+5sCHmR8pcq1Ki4j8YQVbAO8bj2dyeufo4957c+ris9BUQqeRVGXPY
         gr8bOhHmVqF5v7QUrJkVeRx518BACaJHrNPjh8nS3e2eMTXBEgHUaZD66xm0J7cvctA/
         MAPZuHvEAoga0et3LlDPGUIOvB+PQYR8qC17KQIzz10Bn5GJlpP48KznMiOUUfyGb2dW
         Jp0g==
X-Gm-Message-State: AOJu0Yzx1dsIPlXuotGh6nnRJBofatCmsaC26IkQYBuHrLpxzeMLiw5h
        AXnC5eIWlFbjFRuLep5xIz/q5g4WrEv8
X-Google-Smtp-Source: AGHT+IE9ptO7yfyuuXpEHzpl5xABXicnoVsRc1ruVk5cVrWZLqT6sSjYZTkAh7KqMbdYErWJIAv4hRh7eh+v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:b70b:0:b0:5d3:bf64:5e20 with SMTP id
 v11-20020a81b70b000000b005d3bf645e20mr25057ywh.9.1701911847572; Wed, 06 Dec
 2023 17:17:27 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:34 -0800
Message-Id: <20231207011722.1220634-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 00/47] maps/threads/dsos memory improvements and fixes
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

Modify the implementation of maps to not use an rbtree as the
container for maps, instead use a sorted array. Improve locking and
reference counting issues.

Similar to maps separate out and reimplement threads to use a hashmap
for lower memory consumption and faster look up. The fixes a
regression in memory usage where reference count checking switched to
using non-invasive tree nodes.  Reduce its default size by 32 times
and improve locking discipline. Also, fix regressions where tids had
become unordered to make `perf report --tasks` and
`perf trace --summary` output easier to read.

Better encapsulate the dsos abstraction. Remove the linked list and
rbtree used for faster iteration and log(n) lookup to a sorted array
for similar performance but half the memory usage per dso. Improve
reference counting and locking discipline, adding reference count
checking to dso.

v6:
 - Patch 1 is a parameter name fix requested by Namhyung.
 - Patches 2 to 13 split apart a macro to function callback refactor
   requested by Arnaldo.
 - Add fixes and acked-by to later patches from Namhyung.

v5 series is here:
https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.com/

Ian Rogers (47):
  perf map: Improve map/unmap parameter names
  perf maps: Add maps__for_each_map to iterate maps holding the lock
  perf events x86: Use function to add missing lock
  perf report: Use function to add missing maps lock
  perf tests: Use function to add missing maps lock
  perf machine: Use function to add missing maps lock
  perf probe-event: Use function to add missing maps lock
  perf symbol: Use function to add missing maps lock
  perf synthetic-events: Use function to add missing maps lock
  perf thread: Use function to add missing maps lock
  perf unwind: Use function to add missing maps lock
  perf vdso: Use function to add missing maps lock
  perf maps: Reduce scope of maps__for_each_entry
  perf maps: Add remove maps function to remove a map based on callback
  perf debug: Expose debug file
  perf maps: Refactor maps__fixup_overlappings
  perf maps: Do simple merge if given map doesn't overlap
  perf maps: Rename clone to copy from
  perf maps: Add maps__load_first
  perf maps: Add find next entry to give entry after the given map
  perf maps: Reduce scope of map_rb_node and maps internals
  perf maps: Fix up overlaps during fixup_end
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps
  perf dso: Reorder variables to save space in struct dso
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8
  perf dsos: Attempt to better abstract dsos internals
  perf dsos: Tidy reference counting and locking
  perf dsos: Add dsos__for_each_dso
  perf dso: Move dso functions out of dsos
  perf dsos: Switch more loops to dsos__for_each_dso
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
 tools/perf/arch/x86/util/event.c              |  103 +-
 tools/perf/builtin-annotate.c                 |    6 +-
 tools/perf/builtin-buildid-cache.c            |    2 +-
 tools/perf/builtin-buildid-list.c             |   18 +-
 tools/perf/builtin-inject.c                   |   96 +-
 tools/perf/builtin-kallsyms.c                 |    2 +-
 tools/perf/builtin-mem.c                      |    4 +-
 tools/perf/builtin-record.c                   |    2 +-
 tools/perf/builtin-report.c                   |  243 +--
 tools/perf/builtin-script.c                   |    8 +-
 tools/perf/builtin-top.c                      |    4 +-
 tools/perf/builtin-trace.c                    |   41 +-
 tools/perf/tests/code-reading.c               |    8 +-
 tools/perf/tests/dso-data.c                   |   67 +-
 tools/perf/tests/hists_common.c               |    6 +-
 tools/perf/tests/hists_cumulate.c             |    4 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/maps.c                       |   64 +-
 tools/perf/tests/symbols.c                    |    2 +-
 tools/perf/tests/thread-maps-share.c          |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  181 ++-
 tools/perf/ui/browsers/annotate.c             |    6 +-
 tools/perf/ui/browsers/hists.c                |    8 +-
 tools/perf/ui/browsers/map.c                  |    4 +-
 tools/perf/util/Build                         |    1 +
 tools/perf/util/annotate.c                    |   44 +-
 tools/perf/util/auxtrace.c                    |    2 +-
 tools/perf/util/block-info.c                  |    2 +-
 tools/perf/util/bpf-event.c                   |    9 +-
 tools/perf/util/bpf_lock_contention.c         |   10 +-
 tools/perf/util/build-id.c                    |  136 +-
 tools/perf/util/build-id.h                    |    2 -
 tools/perf/util/callchain.c                   |    4 +-
 tools/perf/util/data-convert-json.c           |    2 +-
 tools/perf/util/db-export.c                   |    6 +-
 tools/perf/util/debug.c                       |   22 +-
 tools/perf/util/debug.h                       |    1 +
 tools/perf/util/dlfilter.c                    |   12 +-
 tools/perf/util/dso.c                         |  468 +++---
 tools/perf/util/dso.h                         |  544 ++++++-
 tools/perf/util/dsos.c                        |  529 ++++---
 tools/perf/util/dsos.h                        |   40 +-
 tools/perf/util/event.c                       |   12 +-
 tools/perf/util/header.c                      |    8 +-
 tools/perf/util/hist.c                        |    4 +-
 tools/perf/util/intel-pt.c                    |   22 +-
 tools/perf/util/machine.c                     |  630 +++-----
 tools/perf/util/machine.h                     |   32 +-
 tools/perf/util/map.c                         |   73 +-
 tools/perf/util/map.h                         |   16 +-
 tools/perf/util/maps.c                        | 1398 +++++++++++------
 tools/perf/util/maps.h                        |  105 +-
 tools/perf/util/probe-event.c                 |   62 +-
 tools/perf/util/rb_resort.h                   |    5 -
 .../scripting-engines/trace-event-python.c    |   21 +-
 tools/perf/util/session.c                     |   21 +
 tools/perf/util/session.h                     |    2 +
 tools/perf/util/sort.c                        |   19 +-
 tools/perf/util/srcline.c                     |   65 +-
 tools/perf/util/symbol-elf.c                  |  132 +-
 tools/perf/util/symbol.c                      |  275 ++--
 tools/perf/util/symbol_fprintf.c              |    4 +-
 tools/perf/util/synthetic-events.c            |  134 +-
 tools/perf/util/thread.c                      |   48 +-
 tools/perf/util/thread.h                      |    6 -
 tools/perf/util/threads.c                     |  186 +++
 tools/perf/util/threads.h                     |   35 +
 tools/perf/util/unwind-libunwind-local.c      |   50 +-
 tools/perf/util/unwind-libunwind.c            |    9 +-
 tools/perf/util/vdso.c                        |   89 +-
 71 files changed, 3691 insertions(+), 2496 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

