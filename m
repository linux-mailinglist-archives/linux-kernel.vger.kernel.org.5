Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7875791F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGRKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:17:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1D4116;
        Tue, 18 Jul 2023 03:17:22 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4vxc0crWzrRn6;
        Tue, 18 Jul 2023 18:16:36 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 18:17:18 +0800
Subject: Re: [PATCH v2 5/7] perf evlist: Skip dummy event sample_type check
 for evlist_config
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-6-yangjihong1@huawei.com>
 <5797e5a7-a85f-4f7c-1649-88f8f9ff7a6b@intel.com>
 <44645529-0ee6-fe69-bc03-fefbc6f73d4d@huawei.com>
 <c4b7fb70-7b2e-74e9-576f-33b29e8801cd@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <77ea9309-da6f-f7b9-a822-b371e0f832d3@huawei.com>
Date:   Tue, 18 Jul 2023 18:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c4b7fb70-7b2e-74e9-576f-33b29e8801cd@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/18 17:56, Adrian Hunter wrote:
> On 18/07/23 12:30, Yang Jihong wrote:
>> Hello,
>>
>> On 2023/7/17 22:41, Adrian Hunter wrote:
>>> On 15/07/23 06:29, Yang Jihong wrote:
>>>> The dummp event does not contain sampls data. Therefore, sample_type does
>>>> not need to be checked.
>>>>
>>>> Currently, the sample id format of the actual sampling event may be changed
>>>> after the dummy event is added.
>>>>
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>    tools/perf/util/record.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
>>>> index 9eb5c6a08999..0240be3b340f 100644
>>>> --- a/tools/perf/util/record.c
>>>> +++ b/tools/perf/util/record.c
>>>> @@ -128,6 +128,13 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>>>>            evlist__for_each_entry(evlist, evsel) {
>>>>                if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>>>>                    continue;
>>>> +
>>>> +            /*
>>>> +             * Skip the sample_type check for the dummy event
>>>> +             * because it does not have any samples anyway.
>>>> +             */
>>>> +            if (evsel__is_dummy_event(evsel))
>>>> +                continue;
>>>
>>> Sideband event records have "ID samples" so the sample type still matters.
>>>
>> Okay, will remove this patch in next version.
>>
>> Can I ask a little more about this?
>>
>> Use PERF_SAMPLE_IDENTIFICATION instead of PERF_SAMPLE_ID because for samples of type PERF_RECORD_SAMPLE, there may be different record formats due to different *sample_type* settings, so the fixed SAMPLE_ID  location mode PERF_SAMPLE_NAME is required here.
>>
>> However, for the sideband event, the samples of the PERF_RECORD_SAMPLE type is not recorded (only PERF_RECORD_MMAP, PERF_RECORD_COMM, and so on). Therefore, the "use sample identifier "check can be skipped here.
>>
>> That's my understanding of PERF_SAMPLE_IDENTIFICATION . If there is any error, please help to correct it.
>>
>> *Sideband event records have "ID samples" so the sample type still matters.*
>>
>> Does this mean that sideband will also record samples of type PERF_RECORD_SAMPLE? What exactly is the sampling data?
> 
> No.  There are additional members as defined by struct sample_id for PERF_RECORD_MMAP:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/perf_event.h?h=v6.4#n872
> 
I'm sorry, maybe my comments didn't make it clear.
I mean, can we skip the "use_sample_identifier" check here?

That is, set sample_type to *XXX|PERF_SAMPLE_ID* instead of 
*XXX|PERF_SAMPLE_IDENTIFICATION*

Thanks,
Yang
