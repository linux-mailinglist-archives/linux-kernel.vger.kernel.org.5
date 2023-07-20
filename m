Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0D675A7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGTHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGTHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:25:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3D2115;
        Thu, 20 Jul 2023 00:25:37 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R63zl3wxxztQy7;
        Thu, 20 Jul 2023 15:22:27 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 15:25:34 +0800
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
 <77ea9309-da6f-f7b9-a822-b371e0f832d3@huawei.com>
 <ab152551-5e65-c43d-2046-a096a28db913@intel.com>
 <ca64f76f-ccf4-3779-4090-6028b7ee7bef@huawei.com>
 <e1e94935-31b3-a567-44f7-739330548e7d@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <b350ee27-6b39-8371-06bf-3499271b520e@huawei.com>
Date:   Thu, 20 Jul 2023 15:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e1e94935-31b3-a567-44f7-739330548e7d@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2023/7/20 13:41, Adrian Hunter wrote:
> On 18/07/23 14:32, Yang Jihong wrote:
>> Hello,
>>
>> On 2023/7/18 18:29, Adrian Hunter wrote:
>>> On 18/07/23 13:17, Yang Jihong wrote:
>>>> Hello,
>>>>
>>>> On 2023/7/18 17:56, Adrian Hunter wrote:
>>>>> On 18/07/23 12:30, Yang Jihong wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 2023/7/17 22:41, Adrian Hunter wrote:
>>>>>>> On 15/07/23 06:29, Yang Jihong wrote:
>>>>>>>> The dummp event does not contain sampls data. Therefore, sample_type does
>>>>>>>> not need to be checked.
>>>>>>>>
>>>>>>>> Currently, the sample id format of the actual sampling event may be changed
>>>>>>>> after the dummy event is added.
>>>>>>>>
>>>>>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>>>>>> ---
>>>>>>>>      tools/perf/util/record.c | 7 +++++++
>>>>>>>>      1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
>>>>>>>> index 9eb5c6a08999..0240be3b340f 100644
>>>>>>>> --- a/tools/perf/util/record.c
>>>>>>>> +++ b/tools/perf/util/record.c
>>>>>>>> @@ -128,6 +128,13 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>>>>>>>>              evlist__for_each_entry(evlist, evsel) {
>>>>>>>>                  if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>>>>>>>>                      continue;
>>>>>>>> +
>>>>>>>> +            /*
>>>>>>>> +             * Skip the sample_type check for the dummy event
>>>>>>>> +             * because it does not have any samples anyway.
>>>>>>>> +             */
>>>>>>>> +            if (evsel__is_dummy_event(evsel))
>>>>>>>> +                continue;
>>>>>>>
>>>>>>> Sideband event records have "ID samples" so the sample type still matters.
>>>>>>>
>>>>>> Okay, will remove this patch in next version.
>>>>>>
>>>>>> Can I ask a little more about this?
>>>>>>
>>>>>> Use PERF_SAMPLE_IDENTIFICATION instead of PERF_SAMPLE_ID because for samples of type PERF_RECORD_SAMPLE, there may be different record formats due to different *sample_type* settings, so the fixed SAMPLE_ID  location mode PERF_SAMPLE_NAME is required here.
>>>>>>
>>>>>> However, for the sideband event, the samples of the PERF_RECORD_SAMPLE type is not recorded (only PERF_RECORD_MMAP, PERF_RECORD_COMM, and so on). Therefore, the "use sample identifier "check can be skipped here.
>>>>>>
>>>>>> That's my understanding of PERF_SAMPLE_IDENTIFICATION . If there is any error, please help to correct it.
>>>>>>
>>>>>> *Sideband event records have "ID samples" so the sample type still matters.*
>>>>>>
>>>>>> Does this mean that sideband will also record samples of type PERF_RECORD_SAMPLE? What exactly is the sampling data?
>>>>>
>>>>> No.  There are additional members as defined by struct sample_id for PERF_RECORD_MMAP:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/perf_event.h?h=v6.4#n872
>>>>>
>>>> I'm sorry, maybe my comments didn't make it clear.
>>>> I mean, can we skip the "use_sample_identifier" check here?
>>>>
>>>> That is, set sample_type to *XXX|PERF_SAMPLE_ID* instead of *XXX|PERF_SAMPLE_IDENTIFICATION*
>>>
>>> In general, when there are different values of sample_type, the PERF_SAMPLE_ID is needed to determine which is which.
>>> But PERF_SAMPLE_ID is not at a fixed position, so the sample_type is needed to find it.  That is why PERF_SAMPLE_IDENTIFIER is better.
>>>
>>> Why do want to change it?
>>
>> Without this patch, we now add a system_wide tracking event and modify the sample_type of the  actual sample event.
>>
>> For example, when we run:
>>    # perf record -e cycles -C 0
>>
>> 1. The default sample_type of the "cycles" is IP|TID|TIME|CPU|PERIOD.
>> 2. Then add a system_wide sideband event whose sample_type is IP|TID|TIME|CPU.
>> 3. The two sample_types are different.
>> 4. Therefore, the evlist__config adds a PERF_SAMPLE_IDENTIFICATION to both sample_types instead of PERF_SAMPLE_ID.
>>
>> evlist__config {
>>          ...
>>           } else if (evlist->core.nr_entries > 1) {
>>           // One is cycles and the other is sideband .
>>                   struct evsel *first = evlist__first(evlist);
>>
>>
>>                   evlist__for_each_entry(evlist, evsel) {
>>                           if (evsel->core.attr.sample_type == first->core.attr.sample_type)
>>                                   continue;
>>                           use_sample_identifier = perf_can_sample_identifier();
>>                           // the sample_type of cycles is different from that of sideband.
>>                           // Therefore, use_sample_identifier is set to true.
>>                           break;
>>                   }
>>                   sample_id = true;
>>           }
>>
>>
>>           if (sample_id) {
>>                   evlist__for_each_entry(evlist, evsel)
>>                           evsel__set_sample_id(evsel, use_sample_identifier);
>>                           // both cycles and sideband set PERF_SAMPLE_IDENTIFICATION
>>           }
>>          ...
>> }
>>
>> The comparison of the sideband event sample_type is skipped so that the sample_type of the original cycles is not changed.
>>
>> It does not seem necessary to compare the sample_type of sidebband event. It is not an actual sample event, so I'd like to confirm that.
> 
> It is necessary.  The sample type is used to parse ID samples
> that are part of e.g. MMAP events - refer perf_evsel__parse_id_sample()
> 
> We could teach perf to handle dummy events differently because they
> do not use all the sample_type bits (only the ones in perf_evsel__parse_id_sample())
> but that is probably not backward compatible.
> 
> The only value in that would be to make it work without
> PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER because that would
> save 8-bytes per event record.
> 
> Otherwise there is no benefit to prefer PERF_SAMPLE_ID over
> PERF_SAMPLE_IDENTIFIER except backward compatibility with
> some other tool that doesn't know about PERF_SAMPLE_IDENTIFIER.
> 
Thanks for detailed instructions, I understand, OK, will remove this 
patch in the next version.

Thanks,
Yang
