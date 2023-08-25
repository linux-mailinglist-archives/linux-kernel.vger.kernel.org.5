Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D83787FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbjHYGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbjHYGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:13:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BB1FEC;
        Thu, 24 Aug 2023 23:12:58 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RX8g86vp7zJrr7;
        Fri, 25 Aug 2023 14:09:40 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 14:12:47 +0800
Subject: Re: [PATCH v6 6/7] perf test: Add test case for record sideband
 events
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-7-yangjihong1@huawei.com>
 <CAP-5=fW+ybe3GStU2ttUKH4BSwiyhS=zf6uHUORVEXhexFJxtQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <b2708b48-1922-73b5-ba9b-a4729105d3fa@huawei.com>
Date:   Fri, 25 Aug 2023 14:12:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW+ybe3GStU2ttUKH4BSwiyhS=zf6uHUORVEXhexFJxtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 13:28, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Add a new test case to record sideband events for all CPUs when tracing
>> selected CPUs
>>
>> Test result:
>>
>>    # ./perf test list 2>&1 | grep 'perf record sideband tests'
>>     95: perf record sideband tests
>>    # ./perf test 95
>>     95: perf record sideband tests                                      : Ok
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   tools/perf/tests/shell/record_sideband.sh | 44 +++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/record_sideband.sh
>>
>> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
>> new file mode 100755
>> index 000000000000..2ecf00011cb1
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/record_sideband.sh
>> @@ -0,0 +1,44 @@
>> +#!/bin/sh
>> +# perf record sideband tests
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +
>> +err=0
>> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> 
> Could you add some kind of cleanup on trap function like:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record.sh?h=perf-tools-next#n26
> It'd be okay to do this as a follow up patch.
> 
Okay, it'll be modified in the next version.

Thanks,
Yang
