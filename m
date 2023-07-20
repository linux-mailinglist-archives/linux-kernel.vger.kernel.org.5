Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482375AB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGTKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGTKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:01:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345C1FD;
        Thu, 20 Jul 2023 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689847266; x=1721383266;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6K2m70PwHB5P+4FJyncCXsXVleOk0EtZEdMx58MuRo8=;
  b=V2a3f2CiQc1tq2ZSemwkz9PfhVMaJTgfmZmnsgPKgT69Zp0HHD3yphNd
   PL0SICsXrREs77m8W6TpLfbfarKYlsFluK/l/dw87rALPNxtkAVTjgs/s
   G406rLRyIl/FWYAB5PA+fQkKM0ONRo3B6IdRcVa/3AyGdkmD0wTgNK7+b
   xxvIZ8qG9d+4Kwt1h2u5T8nOx60U68aJwkOxb3DKiQ+lakrL8LYtGXIGG
   GF0YTtEX+UEW0XeTE8n6QlgvaTdXLgyPy8saB84sUfBkF5qVY15TpD3fD
   2gNgSIJjtwy0s8ZVAXnsy1GFN2ZCXJ8oM7PU+APmZ9DSVS53phVWnFY6l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="351553640"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="351553640"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794402832"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="794402832"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:01:02 -0700
Message-ID: <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
Date:   Thu, 20 Jul 2023 13:00:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 0/3] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
To:     Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230718033355.2960912-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/23 06:33, Changbin Du wrote:
> This adds a new option '--workload-attr' to set the sched_policy/priority/mask
> of the workload to reduce system noise.
> 
> $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls

Not really sold on the need for this, but maybe it could be
simpler.
What about just adding a hook for a command (e.g. script) to
run before exec'ing the workload e.g.

--configure-workload=blah.sh

results in perf doing system("blah.sh 12345") where 12345
is the workload PID.

Then maybe you could do:

--configure-workload="taskset -p 0x3"


> 
> Please see patch 1/2 for more details.
> 
> v3:
>   - replace taskset with --workload-attr option in documents and tests.
> v2:
>   - Use cpu list spec instead of cpu mask number.
>   - Update documents.
> 
> Changbin Du (3):
>   perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
>   perf: add new option '--workload-attr' to set workload
>     sched_policy/priority/mask
>   perf: replace taskset with --workload-attr option
> 
>  tools/lib/perf/cpumap.c                       |  45 ++++++-
>  tools/lib/perf/include/perf/cpumap.h          |   4 +
>  tools/lib/perf/libperf.map                    |   2 +
>  tools/perf/Documentation/intel-hybrid.txt     |   2 +-
>  tools/perf/Documentation/perf-record.txt      |   7 ++
>  tools/perf/Documentation/perf-stat.txt        |   8 +-
>  tools/perf/builtin-record.c                   |  26 ++++
>  tools/perf/builtin-stat.c                     |  18 +++
>  tools/perf/tests/cpumap.c                     |  23 ++++
>  .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
>  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
>  tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
>  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
>  tools/perf/util/evlist.c                      | 117 ++++++++++++++++++
>  tools/perf/util/evlist.h                      |   3 +
>  tools/perf/util/target.h                      |   9 ++
>  16 files changed, 263 insertions(+), 9 deletions(-)
> 

