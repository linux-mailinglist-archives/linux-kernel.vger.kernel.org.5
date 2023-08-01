Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D276BB9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHARs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHARst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:48:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874581BF9;
        Tue,  1 Aug 2023 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690912128; x=1722448128;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eFiu+chGOa/DVboePjsv2TCyJ6fcGyeJGuMw5oR1IRI=;
  b=eliWFbbAv5uEYQiVFHuDoO7LTawurhMXpo5SD96liOhaQ/C9aSYQNJAQ
   sUjj1xYXlVbWyiVHT1LJHLenOSvG+yAk6gwrjJF93loActh5gUe7OK7zO
   LUAIzKKk0FfSM2H2G3ULQn5ywfpsnhNZAWItUIL4eOuzOx9BdFeghMYiC
   q41/cdbUEGMEktyahqpTPdVbVNxy5Gu42aPNiMNKZqaxaRKokXPoD8iIX
   R8CMzDpFSXJKKw7pTCewLRfA+Dt9KeTCeB4aM+AexEtqFYERMs057CW+g
   mgUwEpNfv2+3Ap1Rub2mC1tlIyxXYytrdmIZ/wd5Ep/5/R1C1CZE5LOYm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455744170"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455744170"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852570873"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="852570873"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 10:48:47 -0700
Received: from [10.213.165.139] (kliang2-mobl1.ccr.corp.intel.com [10.213.165.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E55A258068A;
        Tue,  1 Aug 2023 10:48:45 -0700 (PDT)
Message-ID: <a0d5ec0a-e5d9-5938-fa6b-1d60b2aac019@linux.intel.com>
Date:   Tue, 1 Aug 2023 13:48:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] Intel metric fixes and event updates
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
References: <20230801053634.1142634-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-01 1:36 a.m., Ian Rogers wrote:
> The metric tma_info_pipeline_retire contains uops_retired.slots with
> perf metric events. Patch 1 fixes this event sorting so that
> uops_retired.slots isn't made a group leader as that needs to be
> topdown.slots.
> 
> Patch 2 and 3 update the meteorlake and sapphirerapids events.
> 
> Patch 4 addresses an issue with event grouping discussed in:
> https://lore.kernel.org/lkml/20230719001836.198363-3-irogers@google.com/
> by adding and altering metric constraints. The constraints avoid
> groups for metrics where the kernel PMU fails to not open the group
> (the trigger for the weak group being removed).
> 
> Ian Rogers (4):
>   perf parse-events x86: Avoid sorting uops_retired.slots
>   perf vendor events intel: Update meteorlake to 1.04
>   perf vendor events intel: Update sapphirerapids to 1.15
>   perf vendor events intel: Update Icelake+ metric constraints
>

Thanks Ian.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  tools/perf/arch/x86/util/evlist.c             |   7 +-
>  tools/perf/arch/x86/util/evsel.c              |   7 +-
>  .../arch/x86/alderlake/adl-metrics.json       |  11 +-
>  .../arch/x86/alderlaken/adln-metrics.json     |   2 +
>  .../arch/x86/icelake/icl-metrics.json         |  10 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  10 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json | 165 ++++++++++++++++++
>  .../arch/x86/meteorlake/floating-point.json   |   8 +
>  .../arch/x86/meteorlake/frontend.json         |  56 ++++++
>  .../arch/x86/meteorlake/memory.json           |  80 +++++++++
>  .../pmu-events/arch/x86/meteorlake/other.json |  16 ++
>  .../arch/x86/meteorlake/pipeline.json         | 159 +++++++++++++++++
>  .../arch/x86/rocketlake/rkl-metrics.json      |  10 +-
>  .../arch/x86/sapphirerapids/other.json        |  18 ++
>  .../arch/x86/sapphirerapids/spr-metrics.json  |   9 +-
>  .../arch/x86/tigerlake/tgl-metrics.json       |  10 +-
>  17 files changed, 549 insertions(+), 33 deletions(-)
> 
