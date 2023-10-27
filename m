Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E27D8D36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbjJ0Cnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Cnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:43:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5CC4;
        Thu, 26 Oct 2023 19:43:37 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SGn2v387cz1L9K2;
        Fri, 27 Oct 2023 10:40:39 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 10:43:33 +0800
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to
 rlimit__increase_nofile
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
 <ZTrCS5Z3PZAmfPdV@kernel.org>
 <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <3458c302-8c43-51e5-f45b-c18657fa7015@huawei.com>
Date:   Fri, 27 Oct 2023 10:43:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/10/27 6:08, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Thu, Oct 26, 2023 at 12:47 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Mon, Oct 23, 2023 at 03:31:44AM +0000, Yang Jihong escreveu:
>>> evsel__increase_rlimit() helper does nothing with evsel, and description
>>> of the functionality is inaccurate, rename it and move to util/rlimit.c.
>>
>>> By the way, fix a checkppatch warning about misplaced license tag:
>>
>>>    WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>    #160: FILE: tools/perf/util/rlimit.h:3:
>>>    /* SPDX-License-Identifier: LGPL-2.1 */
>>
>>> No functional change.
>>
>> Please run 'perf test' before sending patches upstream, I'm checking if
>> what is in perf-tools-next/perf-tools-next is building and I noticed
>> this:
>>
>> ⬢[acme@toolbox perf-tools-next]$ perf test -v python
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>>   14: 'import perf' in python                                         :
>> --- start ---
>> test child forked, pid 2912462
>> python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
>> Traceback (most recent call last):
>>    File "<stdin>", line 1, in <module>
>> ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
>> test child finished with -1
>> ---- end ----
>> 'import perf' in python: FAILED!
>> ⬢[acme@toolbox perf-tools-next]$
>>
>> The following patch cures it, Namhyung, can you please fold it and force
>> push perf-tools-next/perf-tools-next or let me know if you prefer that I
>> submit a patch fixing this separately.
> 
> Thanks for fixing this.  I prefer having a separate fix.
> Please send it as a formal patch.
> 

Sorry, only rename helper and no function change.
I didn't consider the scenario that might affect test python.

I've submitted a fix that can be used if needed:

https://lore.kernel.org/lkml/20231027023028.1106441-1-yangjihong1@huawei.com/

Also, can we consider identifying this problem at the stage of compiling 
the perf tool?


Thanks,
Yang
