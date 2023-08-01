Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE176A862
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHAFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHAFgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:36:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45E199E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c83284edf0eso5797491276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868206; x=1691473006;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cP8wdd+KwpsAv2ShtYOYpBxbm0STXFlV3eoDNJ7OHtg=;
        b=mL9zuBLW/gfQT7MkFoHJ+Ct280XnyulVgddTXFXR9aFEfVDgnlG62wUTw3ESbdIiyl
         53dwyeKWXPWJ73II12Xv2UkRxm8bFwaoIldw0C+qBeYD1XErQISsE/Ovs1qA+Op7sEI0
         z8m+YnqQF7BgvnDQn1sQ0TCvhQybwd48KVaVQ8UvpPkU94zTxJkSor+/hqJaGqOEOJrT
         WPCHBhrH9tA6+IV9a7T41Z3FyEUdrB39axZlWUOWB9d258SwAg18KQW6oV0DXDIdOlo2
         77ule0hjeicz6K5g/s4go6sYONwttRDhVM5GuP/M8z3b4bZ7kS36z4ehNEdbTDLwFqp+
         jSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868206; x=1691473006;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cP8wdd+KwpsAv2ShtYOYpBxbm0STXFlV3eoDNJ7OHtg=;
        b=jZjWTSbHyrujwzB8ROGNklnytta4Wwe08jSLwOJ6buXi0d4K4emXknFYL8HKCXtJiO
         ilI3uER7TDrU4oOiU9/JgkvfrwHlY7GBnAQDubLzeBrcbtTTboEn83vaT7jaAKyzDFP2
         PZQzBhUaTiEe5ehgFamJhFzWLoVnND9E8jgTXdaKBFhQHCln0nMZ4RVKMdf/hhjZqPHF
         aogVv58DNKSDJ+A1EBu4ZdFC1CH9MWPzYAPe6HQwGNt+VOJg6D2+44Onar8cymPA56CU
         2x++yLmVLhAyRODXLMgQv55PaDr/d16Tc8dZKyUyyZBoSKYng0T/rucmMITcTA+++0Vq
         yRdw==
X-Gm-Message-State: ABy/qLakPrxJtf4XYFrqfGN+rglm6ribQIzey2PnyTsnbPzWVFqLKNlX
        2EXY/A61ZC3baStqqqh3X2u1WtYEMFQC
X-Google-Smtp-Source: APBJJlHcD9Xco+3AePtBpEqjlsHJvHtlAXrE2v5r8KY+izHX0/bSjyG5kXlb056okjUC93Go4zLdNcKnNPuM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a25:ab86:0:b0:bc0:bfa7:7647 with SMTP id
 v6-20020a25ab86000000b00bc0bfa77647mr75590ybi.0.1690868206436; Mon, 31 Jul
 2023 22:36:46 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:30 -0700
Message-Id: <20230801053634.1142634-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 0/4] Intel metric fixes and event updates
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metric tma_info_pipeline_retire contains uops_retired.slots with
perf metric events. Patch 1 fixes this event sorting so that
uops_retired.slots isn't made a group leader as that needs to be
topdown.slots.

Patch 2 and 3 update the meteorlake and sapphirerapids events.

Patch 4 addresses an issue with event grouping discussed in:
https://lore.kernel.org/lkml/20230719001836.198363-3-irogers@google.com/
by adding and altering metric constraints. The constraints avoid
groups for metrics where the kernel PMU fails to not open the group
(the trigger for the weak group being removed).

Ian Rogers (4):
  perf parse-events x86: Avoid sorting uops_retired.slots
  perf vendor events intel: Update meteorlake to 1.04
  perf vendor events intel: Update sapphirerapids to 1.15
  perf vendor events intel: Update Icelake+ metric constraints

 tools/perf/arch/x86/util/evlist.c             |   7 +-
 tools/perf/arch/x86/util/evsel.c              |   7 +-
 .../arch/x86/alderlake/adl-metrics.json       |  11 +-
 .../arch/x86/alderlaken/adln-metrics.json     |   2 +
 .../arch/x86/icelake/icl-metrics.json         |  10 +-
 .../arch/x86/icelakex/icx-metrics.json        |  10 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 165 ++++++++++++++++++
 .../arch/x86/meteorlake/floating-point.json   |   8 +
 .../arch/x86/meteorlake/frontend.json         |  56 ++++++
 .../arch/x86/meteorlake/memory.json           |  80 +++++++++
 .../pmu-events/arch/x86/meteorlake/other.json |  16 ++
 .../arch/x86/meteorlake/pipeline.json         | 159 +++++++++++++++++
 .../arch/x86/rocketlake/rkl-metrics.json      |  10 +-
 .../arch/x86/sapphirerapids/other.json        |  18 ++
 .../arch/x86/sapphirerapids/spr-metrics.json  |   9 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  10 +-
 17 files changed, 549 insertions(+), 33 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog

