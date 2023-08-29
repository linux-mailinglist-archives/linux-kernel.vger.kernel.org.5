Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AE78C196
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjH2JfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjH2JfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:35:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24B3A1;
        Tue, 29 Aug 2023 02:35:02 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZj0L3Vh3zrSPF;
        Tue, 29 Aug 2023 17:33:22 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 29 Aug 2023 17:34:59 +0800
Subject: Re: [PATCH v7 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Ravi Bangoria <ravi.bangoria@amd.com>, <acme@kernel.org>,
        <irogers@google.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230826032608.107261-1-yangjihong1@huawei.com>
 <bcfabb85-4dc1-e642-4a82-f3b8cc009b0b@amd.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <93abb0e0-1691-a887-f7b2-7591f83a8618@huawei.com>
Date:   Tue, 29 Aug 2023 17:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bcfabb85-4dc1-e642-4a82-f3b8cc009b0b@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/29 13:37, Ravi Bangoria wrote:
> On 26-Aug-23 8:56 AM, Yang Jihong wrote:
>> User space tasks can migrate between CPUs, track sideband events for all
>> CPUs.
> 
> I've tested this series with simple test program and it mostly works fine.
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
Thanks for the test.

> Since we are recording sideband data on all cpus, perf will endup recording
> lots of unnecessary data, esp. on large systems. E.g. on a 128 cpu system:
> 
> Without patch:
>    $ sudo ./perf record -C 10 -o perf.data.without -- sleep 10
>    $ du -d1 -ha ./perf.data.without
>    3.0M    ./perf.data.without
> 
>    $ sudo ./perf report --stats -i perf.data.without
>    Aggregated stats:
>               TOTAL events:      47011
>                MMAP events:         51  ( 0.1%)
>                COMM events:       1549  ( 3.3%)
>                EXIT events:        105  ( 0.2%)
>                FORK events:       1544  ( 3.3%)
>              SAMPLE events:      38226  (81.3%)
>               MMAP2 events:       5485  (11.7%)
>               ...
>    cycles:P stats:
>              SAMPLE events:      38226
> 
> With patch:
>    $ sudo ./perf record -C 10 -o perf.data.with -- sleep 10
>    $ du -d1 -ha ./perf.data.with
>    15M     ./perf.data.with
> 
>    $ sudo ./perf report --stats -i perf.data.with
>    Aggregated stats:
>               TOTAL events:     160164
>                MMAP events:         51  ( 0.0%)
>                COMM events:      12879  ( 8.0%)
>                EXIT events:      11192  ( 7.0%)
>                FORK events:      12669  ( 7.9%)
>              SAMPLE events:      38464  (24.0%)
>               MMAP2 events:      84844  (53.0%)
>               ...
>    cycles:P stats:
>              SAMPLE events:      38464
> 
> Number of actual samples are same ~38K. However, the perf.data file is 5x
> bigger because of additional sideband data.

Yes, if record system wide sideband data, the amount of sideband events 
will increase proportionally, which is expected.

> 
> I'm pretty sure we don't need most of those additional data. So, thinking
> loud, should we post-process perf.data file and filter out unnecessary data?
> 

I wonder if we can add a new function in perf inject.
By reading perf.data and comparing tid of SAMPLE events and sideband 
events, we can filter out the sideband data of unmatched tasks.

That's just my idea, or there's another better solution.

Thanks,
Yang
