Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A947BE9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378191AbjJISja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378156AbjJISj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA3B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ac9c1522so7543597b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876766; x=1697481566; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BpyZW6SIyDMddq/KpJ5/Dy63Sl93+U/oxSoQXfrAQ3A=;
        b=y1baXPaW4ackkfC5Ocaos5AsCGcbojhoUujqkbBVvlh7CKfLny2xAHK+jviqyTvOE6
         2FXlyAWm+JezeyFyZsrHAbbDiHxZftwUkVU8yDiwLQ3gt4YlbSYXatma/ggXQERSmjVk
         7oRxE8stHnCVmMMDwS0Vaj8IT/9a4DsUGNQzfvtpoPgW/UGTZMDNxbx3VklyHE+5kfMU
         p21JwWty6nqMm3pp15bL6B67dggp8g1hSkyKKmfOIMJDaxCJ1kvarXb75wM1vw1T/IH/
         WI6UKDAEq8EJ3pDfItbNcwMkUR8bv4NJWbfmsW3PMe99ZFPSpW3VXMkLRwD0G47jDkjT
         jqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876766; x=1697481566;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpyZW6SIyDMddq/KpJ5/Dy63Sl93+U/oxSoQXfrAQ3A=;
        b=QtwdrdrZkkXW/hYRcpe/wlbf63SBoZq9nFiPTKWxoIFu4TJzEe7L5GSpmHkiYrnMkt
         dScxLdL4cVfzMLoPi317a0/noLbhdK8xh8BDgVKVXHkaQ/zg2ZRpIYKg3p9Hm7uOgoou
         ORtumDW+AEUKEo6rReJWwHZza60Bwdv0HzaGYhsS6rYNHtQvN4L3F1srm204VROSMTgH
         eJRrY2ViZbF2CHxjKrwZ3QfF2747EmHC6QScF4+KuqRBO2BlqJGKHd0/th9ALPj8fqvD
         jqEbCRaB0gl/WO+fCt7VvwP0OPADX+6ypna/L6kvDerg7nyv3OLGGhCPyu6cjEoKgZia
         wP5Q==
X-Gm-Message-State: AOJu0Yy0tlxam+RwfNUB9iUHrHDKxS7+5YEN4DucnLN8xnR5Pu/voS+/
        S2Ax9mrxLgt4Iv/bovUby8hVOHx83o0C
X-Google-Smtp-Source: AGHT+IE5eoNJprN8tdSYHf6jE8fdT3BZ0VpowwVuHGUswqy5qF7XIcGdLKN5PekbQIWRZ7TgfCwwYCkWsS2V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP id
 b8-20020a81bd08000000b0059bc811a702mr300054ywi.6.1696876766254; Mon, 09 Oct
 2023 11:39:26 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:01 -0700
Message-Id: <20231009183920.200859-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 00/18] clang-tools support in tools
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the clang-tools scripts to work with builds in tools such as
tools/perf and tools/lib/perf. An example use looks like:

```
$ cd tools/perf
$ make CC=clang CXX=clang++
$ ../../scripts/clang-tools/gen_compile_commands.py
$ ../../scripts/clang-tools/run-clang-tools.py clang-tidy compile_commands.json -checks=-*,readability-named-parameter
Skipping non-C file: 'tools/perf/bench/mem-memcpy-x86-64-asm.S'
Skipping non-C file: 'tools/perf/bench/mem-memset-x86-64-asm.S'
Skipping non-C file: 'tools/perf/arch/x86/tests/regs_load.S'
8 warnings generated.
Suppressed 8 warnings (8 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
2 warnings generated.
4 warnings generated.
Suppressed 4 warnings (4 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
2 warnings generated.
4 warnings generated.
Suppressed 4 warnings (4 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
3 warnings generated.
tools/perf/util/parse-events-flex.c:546:27: warning: all parameters should be named in a function [readability-named-parameter]
void *yyalloc ( yy_size_t , yyscan_t yyscanner );
                          ^
                           /*size*/
...
```

Fix a number of the more serious low-hanging issues in perf found by
clang-tidy.

This support isn't complete, in particular it doesn't support output
directories properly and so fails for tools/lib/bpf, tools/bpf/bpftool
and if an output directory is used.

v3. Add Nick Desaulniers reviewed-by to patch 3. For Namhyung, drop
    "perf hisi-ptt: Fix potential memory leak", split lock change out
    of "perf svghelper: Avoid memory leak" and address comments in
    "perf header: Fix various error path memory leaks".
v2: Address comments by Nick Desaulniers in patch 3, and add their
    Reviewed-by to patches 1 and 2.

Ian Rogers (18):
  gen_compile_commands: Allow the line prefix to still be cmd_
  gen_compile_commands: Sort output compile commands by file name
  run-clang-tools: Add pass through checks and header-filter arguments
  perf bench uprobe: Fix potential use of memory after free
  perf buildid-cache: Fix use of uninitialized value
  perf env: Remove unnecessary NULL tests
  perf jitdump: Avoid memory leak
  perf mem-events: Avoid uninitialized read
  perf dlfilter: Be defensive against potential NULL dereference
  perf hists browser: Reorder variables to reduce padding
  perf hists browser: Avoid potential NULL dereference
  perf svghelper: Avoid memory leak
  perf lock: Fix a memory leak on an error path
  perf parse-events: Fix unlikely memory leak when cloning terms
  tools api: Avoid potential double free
  perf trace-event-info: Avoid passing NULL value to closedir
  perf header: Fix various error path memory leaks
  perf bpf_counter: Fix a few memory leaks

 scripts/clang-tools/gen_compile_commands.py |  8 +--
 scripts/clang-tools/run-clang-tools.py      | 32 ++++++++---
 tools/lib/api/io.h                          |  1 +
 tools/perf/bench/uprobe.c                   |  1 +
 tools/perf/builtin-buildid-cache.c          |  6 ++-
 tools/perf/builtin-lock.c                   |  1 +
 tools/perf/ui/browsers/hists.c              |  6 +--
 tools/perf/util/bpf_counter.c               |  5 +-
 tools/perf/util/dlfilter.c                  |  4 +-
 tools/perf/util/env.c                       |  6 +--
 tools/perf/util/header.c                    | 60 ++++++++++++---------
 tools/perf/util/jitdump.c                   |  1 +
 tools/perf/util/mem-events.c                |  3 +-
 tools/perf/util/parse-events.c              |  4 +-
 tools/perf/util/svghelper.c                 |  5 +-
 tools/perf/util/trace-event-info.c          |  3 +-
 16 files changed, 94 insertions(+), 52 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog

