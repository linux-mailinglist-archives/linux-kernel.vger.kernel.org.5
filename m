Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C330788AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbjHYOIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbjHYOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC282689;
        Fri, 25 Aug 2023 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692972408; x=1724508408;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pWTAAgLlRZncja+IDv+iUtfr3L7H3/K6szkOOG/SR94=;
  b=JU1uj7oO9xJ0C7svrfBe76YS3IEONIS3KoBmaewbjsK3WLvWo7/ifWxh
   EIf099GLjYPXsmK/QWN734IBL7BJeCyjbaoDt8awytgWRWtuaQhuq1rtR
   arWRlYMkBm6BwPiHZjx7ww++zdrfqRB9XXg5X1S+D1iR0QQDeemamQwkt
   0d4kZ9d8iFK25SQqceWt+djgb4G4omCK2qCDi0Bs1evud2q6xiQFzGby2
   m/WFLLNjwYhWw0ZVTmXgAghMsMdsIZr71UofHPZnsfJVo17RzOr1DBnRF
   wQgIp3BQyw8JTA56ULGoXq+f+pAAL4gxzb6xcn9b7l1Q1uM1cfXmWXZDd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355048105"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="355048105"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 07:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772482279"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="772482279"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 07:05:49 -0700
Received: from [10.209.146.71] (kliang2-mobl1.ccr.corp.intel.com [10.209.146.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 03D5D580C56;
        Fri, 25 Aug 2023 07:05:47 -0700 (PDT)
Message-ID: <166e2aad-5e17-3ffa-b140-05f174583ab2@linux.intel.com>
Date:   Fri, 25 Aug 2023 10:05:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 0/2] perf list: Remove duplicate PMUs
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
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825135237.921058-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230825135237.921058-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-25 9:52 a.m., Ian Rogers wrote:
> When there are multiple PMUs, differing by ordered suffixes, by
> default only display one. This avoids repeated listing of events, in
> particular when there are 10s of uncore PMUs. If "-v" is passed to
> "perf list" then still list all PMUs.
> 
> Listing fewer PMU/event combinations helps speed the all PMU event
> tests.
> 
> Before:
> ```
> $ perf list
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ```
> 
> After:
> ```
> $ perf list
> ...
>   uncore_imc_free_running/data_read/                 [Kernel PMU event]
>   uncore_imc_free_running/data_total/                [Kernel PMU event]
>   uncore_imc_free_running/data_write/                [Kernel PMU event]
> ...
> $ perf list -v
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ...
> ```
> 
> The PMUs are sorted by name then suffix as a part of this change.
> 
> v5: Improved the 2nd patch's commit message and removed an unused
>     variable as suggested by Kan Liang <kan.liang@linux.intel.com>.
> v4: Rebase on top of lazy PMU changes. Ignore numeric ordering due to
>     gaps, suggested by Kan Liang <kan.liang@linux.intel.com>. Fold
>     patches 2 & 3 as suggested by John Garry <john.g.garry@oracle.com>
>     (done by accident as part of rebasing).
> v3: Add detail to patch 1 sorting commit message about the suffix and
>     why sorting is necessary.
> v2: List all PMUs when "-v" is passed as suggested by John Garry
>     <john.g.garry@oracle.com>.
> 
> Ian Rogers (2):
>   perf pmus: Sort pmus by name then suffix
>   perf pmus: Skip duplicate PMUs and don't print list suffix by default


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
>  tools/perf/builtin-list.c         |  8 +++
>  tools/perf/util/pmu.c             | 17 ++++--
>  tools/perf/util/pmu.h             |  3 +-
>  tools/perf/util/pmus.c            | 99 ++++++++++++++++++++++++++++++-
>  tools/perf/util/pmus.h            |  2 +
>  tools/perf/util/print-events.h    |  1 +
>  tools/perf/util/s390-sample-raw.c |  3 +-
>  7 files changed, 123 insertions(+), 10 deletions(-)
> 
