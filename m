Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D5787DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbjHYCks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbjHYCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA31AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5925f39aa5cso12516187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931227; x=1693536027;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9y0R0T/KYoRSkCgPsetHA/E7ag4fZJml6jv6nZDJg9Q=;
        b=lgMPZ9u2Li+a94DkzByZ+jgOm9cM0gX+J1LFEJnVHnhMY8aW+ZctJVGNUG54bt1wrO
         LvHQf308xkPh+3/sj9S0wUsaFrisxoUbNwCKcmEC4hD1pY1NV0+L0GmfzZxZAjkijRY9
         MAgkqwS7Ds3rfex5SPDQShFaTqHiMrngfMoU+Z3ZM9+VTlmnWKVXQ44+NzSwrgDwChNs
         zLz3hiZ280SVTpqXyMA2qrEQ3xOtA+eS6YvbXOjE7WqNe/op3qVmxwWbZ74VRJ054Nzn
         Y8TY1O4rEqdUN6vjqPFYC/bnAIcGYF2T8bR9kGMrZl92slRrctI3dMiCVoHzuSfMz4OZ
         BK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931227; x=1693536027;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9y0R0T/KYoRSkCgPsetHA/E7ag4fZJml6jv6nZDJg9Q=;
        b=aIsf+mzIQn4JdvHKRMfemptiW4yqFX9Wj4sOQL9Mjlz5+BR0432ojHt1kPYrnkY0ER
         BMdkDJmmFZC4APFDQEUJaK4tw1DFEnqqLFFh9iEHwK4+DWz3/SKtV6iAFBcTs+TVNsis
         ZbCEbrMUb7RpG5OH9SP18S2BtT+Og3v6m1/OEM4EDNLmraZ1xlq8v9YghV7RKYH5tk6A
         jZMBr9TaDCeOaya1uib+65cQ6emC6mM1W3ZaTpe2fWDgENApJvHEFp2c6mv9iHaingJu
         1+mP54J8e8z1MXj/V9oH3mofMHfTrB9s9t92HiDxS/5L26JiV+YdeJXhU7ymeb4cU45h
         Y0gg==
X-Gm-Message-State: AOJu0YwPMGXbmPOoUcfh30+5w42UzaVqtIpYqaAIq6g6hhmx0GFTaYqN
        fCBmYA1i6vCpVz302Xp9K00rDa+0Amr6
X-Google-Smtp-Source: AGHT+IEB53pqv6HCic/xx2KLuoXmwH5iUnq0oTL0ZppgE2SwkTZgpvnxmDyHuX/w5KJ70BlN5o0QKPx9YKY0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2fc2:b0:589:a533:405b with SMTP
 id ex2-20020a05690c2fc200b00589a533405bmr379315ywb.3.1692931227754; Thu, 24
 Aug 2023 19:40:27 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:56 -0700
Message-Id: <20230825024002.801955-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 0/6] Fix missing caps, fix unnecessary casting/checking
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
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

Wei Li <liwei391@huawei.com> reported an issue where writing PMU caps
for ARM was broken. Patch 1 addresses this issue.

Patch 2 removes unnecessary checks on a PMU's name by ensuring the
fake PMU has a name. Types are updated to have a const as a
consequence and a cleanup of the use of types is done for struct pmu's
variable name. This was motivated by the discussion:
https://lore.kernel.org/lkml/20230818171952.3719251-1-irogers@google.com/

Patches 3-5 repeat the const cleanup on struct pmu's name with the
variables id and config in struct pmu and struct parse_events_term
respectively. This is done for consistency with patch 2.

Patch 6 tidies casts around libslang and removes workarounds for
libslang support needed for a libslang older than 15 years - let's say
nobody cares about a libslang that is this old.

Ian Rogers (6):
  perf header: Fix missing PMU caps
  perf pmu: Remove logic for PMU name being NULL
  perf parse-events: Make term's config const
  perf pmu: Make id const and add missing free
  perf build-id: Simplify build_id_cache__cachedir
  perf tui slang: Tidy casts

 tools/perf/arch/arm64/util/mem-events.c   |  2 +-
 tools/perf/arch/powerpc/util/mem-events.c |  6 ++--
 tools/perf/arch/x86/util/mem-events.c     |  8 ++---
 tools/perf/arch/x86/util/pmu.c            | 10 +++---
 tools/perf/builtin-list.c                 |  2 +-
 tools/perf/tests/pmu-events.c             | 20 ++++++------
 tools/perf/tests/pmu.c                    | 18 +++++------
 tools/perf/ui/Build                       |  2 --
 tools/perf/ui/browser.c                   |  6 ++--
 tools/perf/ui/browsers/Build              |  5 ---
 tools/perf/ui/libslang.h                  | 20 +++---------
 tools/perf/ui/tui/helpline.c              |  2 +-
 tools/perf/ui/tui/setup.c                 |  2 +-
 tools/perf/ui/tui/util.c                  | 12 +++----
 tools/perf/util/build-id.c                |  6 ++--
 tools/perf/util/env.c                     |  8 ++---
 tools/perf/util/header.c                  | 39 ++++++++++-------------
 tools/perf/util/mem-events.c              | 16 +++++-----
 tools/perf/util/mem-events.h              |  2 +-
 tools/perf/util/parse-events.c            | 17 ++++------
 tools/perf/util/parse-events.h            |  6 ++--
 tools/perf/util/parse-events.y            |  2 +-
 tools/perf/util/pmu.c                     | 19 ++++++-----
 tools/perf/util/pmu.h                     | 10 +++---
 24 files changed, 105 insertions(+), 135 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

