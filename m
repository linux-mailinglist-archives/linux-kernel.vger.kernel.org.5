Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B237978F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjIGQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244356AbjIGQiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD182210C;
        Thu,  7 Sep 2023 09:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F0C43395;
        Thu,  7 Sep 2023 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694102791;
        bh=wTTVey9YZJtMRL2JwAl4Bl6GOm8D1pcSnWWALoFSdIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ly3WQ1iEc2TELoq4i1Tuj7guxul+pO6MqtfVJ2o+DC+ddi//R2z3/Qj+UfygKr1/b
         hN/xZyEhZvyZ8A8v7+fkILHcGAcQHz2ACAyX93Vew8vm0wXizP0Pu021F1V19+eipM
         Ah08TKcNIoBMLkTi5RGgLfODGHxxuI+egvLERORHZm/GwrCYpwJL6/WpGWDck1ptMt
         H8BOphEpWe8O7ax68EN1bn/9ApNiwMIrUuwOVIB3+e7vVtCGL9ACDgdeMAb519/oE5
         BxURPeoB3eRlC8xBqxJ2NzYFZJWPz5zGWjQfSJxdKwGRbqwuz5OJ4knfwGobNVP5h9
         dLyMIJZybOlEQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31F4A403F4; Thu,  7 Sep 2023 13:06:28 -0300 (-03)
Date:   Thu, 7 Sep 2023 13:06:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v8 0/8] Add metrics for Arm CMN
Message-ID: <ZPn1BEzAoQa/ogtL@kernel.org>
References: <1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 07, 2023 at 07:58:25PM +0800, Jing Zhang escreveu:
> Changes since v7:
> - Optimized pmu_uncore_identifier_match().
> - Added all missing "event=0" in JSON file.
> - Rebase this series onto the latest perf-tools-next.
> - Link: https://lore.kernel.org/all/1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com/

Can you please refresh on top of what is in the tmp.perf-tools-next
branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

patch 3/8 has some fuzz and b4 is not finding it in the mailing list,
probably the patch is too large? Do you have some git tree somewhere I
can use to pull from?

- Arnaldo
 
> Jing Zhang (8):
>   perf pmu: "Compat" supports matching multiple identifiers
>   perf metric: "Compat" supports matching multiple identifiers
>   perf vendor events: Supplement the omitted EventCode
>   perf jevents: Support more event fields
>   perf test: Make matching_pmu effective
>   perf test: Add pmu-event test for "Compat" and new event_field.
>   perf jevents: Add support for Arm CMN PMU aliasing
>   perf vendor events: Add JSON metrics for Arm CMN
> 
>  .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++++++++
>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |  74 ++++++
>  .../pmu-events/arch/test/test_soc/sys/uncore.json  |   8 +
>  .../pmu-events/arch/x86/alderlake/pipeline.json    |   9 +
>  .../pmu-events/arch/x86/alderlaken/pipeline.json   |   3 +
>  .../pmu-events/arch/x86/broadwell/pipeline.json    |   4 +
>  .../pmu-events/arch/x86/broadwellde/pipeline.json  |   4 +
>  .../arch/x86/broadwellde/uncore-cache.json         |   2 +
>  .../arch/x86/broadwellde/uncore-interconnect.json  |   1 +
>  .../arch/x86/broadwellde/uncore-memory.json        |   1 +
>  .../arch/x86/broadwellde/uncore-power.json         |   1 +
>  .../pmu-events/arch/x86/broadwellx/pipeline.json   |   4 +
>  .../arch/x86/broadwellx/uncore-cache.json          |   2 +
>  .../arch/x86/broadwellx/uncore-interconnect.json   |  13 +
>  .../arch/x86/broadwellx/uncore-memory.json         |   2 +
>  .../arch/x86/broadwellx/uncore-power.json          |   1 +
>  .../pmu-events/arch/x86/cascadelakex/pipeline.json |   4 +
>  .../arch/x86/cascadelakex/uncore-cache.json        |   2 +
>  .../arch/x86/cascadelakex/uncore-interconnect.json |   1 +
>  .../arch/x86/cascadelakex/uncore-io.json           |   1 +
>  .../arch/x86/cascadelakex/uncore-memory.json       |   1 +
>  .../arch/x86/cascadelakex/uncore-power.json        |   1 +
>  .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   2 +
>  .../pmu-events/arch/x86/goldmont/pipeline.json     |   3 +
>  .../pmu-events/arch/x86/goldmontplus/pipeline.json |   3 +
>  .../pmu-events/arch/x86/grandridge/pipeline.json   |   3 +
>  .../arch/x86/graniterapids/pipeline.json           |   4 +
>  .../perf/pmu-events/arch/x86/haswell/pipeline.json |   4 +
>  .../pmu-events/arch/x86/haswellx/pipeline.json     |   4 +
>  .../pmu-events/arch/x86/haswellx/uncore-cache.json |   2 +
>  .../arch/x86/haswellx/uncore-interconnect.json     |  14 ++
>  .../arch/x86/haswellx/uncore-memory.json           |   2 +
>  .../pmu-events/arch/x86/haswellx/uncore-power.json |   1 +
>  .../perf/pmu-events/arch/x86/icelake/pipeline.json |   5 +
>  .../pmu-events/arch/x86/icelakex/pipeline.json     |   5 +
>  .../pmu-events/arch/x86/icelakex/uncore-cache.json |   1 +
>  .../arch/x86/icelakex/uncore-interconnect.json     |   1 +
>  .../arch/x86/icelakex/uncore-memory.json           |   1 +
>  .../pmu-events/arch/x86/icelakex/uncore-power.json |   1 +
>  .../pmu-events/arch/x86/ivybridge/pipeline.json    |   3 +
>  .../perf/pmu-events/arch/x86/ivytown/pipeline.json |   4 +
>  .../pmu-events/arch/x86/ivytown/uncore-cache.json  |   2 +
>  .../arch/x86/ivytown/uncore-interconnect.json      |  11 +
>  .../pmu-events/arch/x86/ivytown/uncore-memory.json |   1 +
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  |   1 +
>  .../pmu-events/arch/x86/jaketown/pipeline.json     |   4 +
>  .../pmu-events/arch/x86/jaketown/uncore-cache.json |   2 +
>  .../arch/x86/jaketown/uncore-interconnect.json     |  12 +
>  .../arch/x86/jaketown/uncore-memory.json           |   1 +
>  .../pmu-events/arch/x86/jaketown/uncore-power.json |   2 +
>  .../arch/x86/knightslanding/pipeline.json          |   3 +
>  .../arch/x86/knightslanding/uncore-cache.json      |   1 +
>  .../arch/x86/knightslanding/uncore-memory.json     |   4 +
>  .../pmu-events/arch/x86/meteorlake/pipeline.json   |   9 +
>  .../pmu-events/arch/x86/rocketlake/pipeline.json   |   3 +
>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |   4 +
>  .../arch/x86/sapphirerapids/pipeline.json          |   5 +
>  .../pmu-events/arch/x86/sierraforest/pipeline.json |   4 +
>  .../pmu-events/arch/x86/silvermont/pipeline.json   |   3 +
>  .../perf/pmu-events/arch/x86/skylake/pipeline.json |   4 +
>  .../pmu-events/arch/x86/skylakex/pipeline.json     |   4 +
>  .../pmu-events/arch/x86/skylakex/uncore-cache.json |   2 +
>  .../arch/x86/skylakex/uncore-interconnect.json     |   1 +
>  .../pmu-events/arch/x86/skylakex/uncore-io.json    |   1 +
>  .../arch/x86/skylakex/uncore-memory.json           |   1 +
>  .../pmu-events/arch/x86/skylakex/uncore-power.json |   1 +
>  .../pmu-events/arch/x86/snowridgex/pipeline.json   |   2 +
>  .../arch/x86/snowridgex/uncore-cache.json          |   1 +
>  .../arch/x86/snowridgex/uncore-interconnect.json   |   1 +
>  .../arch/x86/snowridgex/uncore-memory.json         |   1 +
>  .../arch/x86/snowridgex/uncore-power.json          |   1 +
>  .../pmu-events/arch/x86/tigerlake/pipeline.json    |   5 +
>  tools/perf/pmu-events/empty-pmu-events.c           |   8 +
>  tools/perf/pmu-events/jevents.py                   |  21 +-
>  tools/perf/tests/pmu-events.c                      |  65 ++++-
>  tools/perf/util/metricgroup.c                      |   2 +-
>  tools/perf/util/pmu.c                              |  28 ++-
>  tools/perf/util/pmu.h                              |   1 +
>  78 files changed, 681 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> 
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
