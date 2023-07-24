Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F475EAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGXFoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGXFoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:44:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44892A6;
        Sun, 23 Jul 2023 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690177460; x=1721713460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pQN45hlanwXU5g7m+FxtKVhlB8R9k4XvqrTxCF+ZvC4=;
  b=m1ljLLmxL9oSvcNrzVhJATY3iW49/NjrgN9k1NHJagq/WQij8/UFxBIO
   +r3iKigSTaBvAx35Alz9EfLu1YCZhsdWVCxmIjaGyFNuv1+98NmKhLIpX
   RUs0tpV6u2bbXU2xNqxe7yoQmpXzFsvz1ewfPqGZ+0NL/kOYOp5ogMIXS
   cfOrUxyZNdCVLnVEQEQitzX2R9RJApLSkz3jlWsqa/N1riLcGR8co4M6X
   C1utNsBLjNtdNmFJa+3A1WgpsOZ/iJ8OhCLGmsSC60YarcGZaer/2yeCu
   Lb9WeNgr1RbFK0IAwDfLtHqgbhm0XKUyo35HHFAW2Ekfjn6q5pxN3kI2L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="453728246"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453728246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 22:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815693602"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815693602"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.18])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 22:44:16 -0700
Message-ID: <05b67e8c-6ba0-5774-93fd-d390ac4e3b19@intel.com>
Date:   Mon, 24 Jul 2023 08:44:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
 <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
 <20230724040229.eipq7i43v4xcrq3p@M910t>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230724040229.eipq7i43v4xcrq3p@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/23 07:02, Changbin Du wrote:
> On Thu, Jul 20, 2023 at 01:00:58PM +0300, Adrian Hunter wrote:
>> On 18/07/23 06:33, Changbin Du wrote:
>>> This adds a new option '--workload-attr' to set the sched_policy/priority/mask
>>> of the workload to reduce system noise.
>>>
>>> $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls
>>
>> Not really sold on the need for this, but maybe it could be
>> simpler.
>> What about just adding a hook for a command (e.g. script) to
>> run before exec'ing the workload e.g.
>>
>> --configure-workload=blah.sh
>>
>> results in perf doing system("blah.sh 12345") where 12345
>> is the workload PID.
>>
>> Then maybe you could do:
>>
>> --configure-workload="taskset -p 0x3"
>>
> Acctually, we already have such option for perf-stat.
> 
> 	--post <command>  command to run after to the measured command
>         --pre <command>   command to run prior to the measured command
> 
> By involving a shell script we can do more complex setup. But sometimes I just
> need to set sched attributes. For example, to investigate the impact of
> various compiler optimizations. In this case, I don't want a script. This is the
> original purpose I try to add this new option.

There is also command schedtool, but what exactly is the problem
with a script?

> 
>>
>>>
>>> Please see patch 1/2 for more details.
>>>
>>> v3:
>>>   - replace taskset with --workload-attr option in documents and tests.
>>> v2:
>>>   - Use cpu list spec instead of cpu mask number.
>>>   - Update documents.
>>>
>>> Changbin Du (3):
>>>   perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
>>>   perf: add new option '--workload-attr' to set workload
>>>     sched_policy/priority/mask
>>>   perf: replace taskset with --workload-attr option
>>>
>>>  tools/lib/perf/cpumap.c                       |  45 ++++++-
>>>  tools/lib/perf/include/perf/cpumap.h          |   4 +
>>>  tools/lib/perf/libperf.map                    |   2 +
>>>  tools/perf/Documentation/intel-hybrid.txt     |   2 +-
>>>  tools/perf/Documentation/perf-record.txt      |   7 ++
>>>  tools/perf/Documentation/perf-stat.txt        |   8 +-
>>>  tools/perf/builtin-record.c                   |  26 ++++
>>>  tools/perf/builtin-stat.c                     |  18 +++
>>>  tools/perf/tests/cpumap.c                     |  23 ++++
>>>  .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
>>>  tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
>>>  tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
>>>  tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
>>>  tools/perf/util/evlist.c                      | 117 ++++++++++++++++++
>>>  tools/perf/util/evlist.h                      |   3 +
>>>  tools/perf/util/target.h                      |   9 ++
>>>  16 files changed, 263 insertions(+), 9 deletions(-)
>>>
>>
> 

