Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD07691AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjGaJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGaJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:26:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49340E7A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690795570; x=1722331570;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5DroKSxtJt7ROa5ru6XtTRU2BpA/NiTBkY1GaPFsUQI=;
  b=V3w7BvsWb6ULAIPLc4IumkP+1s9IPHFmmAwV6XI4r+nHLmP+Fn9sMXUr
   4kk6neE3Nss+dz7QCdT4+65D5ktYr9hY9WfZs4uXuiEYH8oI5FG7tUau9
   euUKDl1Y0/XDp38ApuSTUqUtTeyOU95Dhtd/KiaC1e0NKOCfO8gaGRiAn
   ODo5GAz6WrG/cx4yBLh8gpQEX3BVSMfIWXZPyDM4F7wDHqpYawIxDpwRq
   z7/kYHrKC/r5NXRQB+RkStiLHjmX4HETlX2s3qDYMqMC9Er6qZbzCKLS9
   n+bAekdeOVWRzo/v5WNN4JA267WbGz6xmfDAxzpySh8njA+gcikT+CWK7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="372600334"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="372600334"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="731535642"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="731535642"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.223])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:26:04 -0700
Message-ID: <1d10fab5-d375-79b8-122d-f3cb66f2d94a@intel.com>
Date:   Mon, 31 Jul 2023 12:26:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZL7ocEWxjRtWR80T@kernel.org>
 <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
 <ZL7tv45K3zKqkHhZ@kernel.org>
 <d81c192a-49e1-b02a-b6e7-6c44927f041d@intel.com>
 <ZMJ7d7BUeva82rMm@kernel.org>
 <95590e6a-0747-a365-4de1-0ccd8fdfc257@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <95590e6a-0747-a365-4de1-0ccd8fdfc257@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/23 22:18, Adrian Hunter wrote:
> On 27/07/23 17:13, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jul 25, 2023 at 02:51:58PM +0300, Adrian Hunter escreveu:
>>> On 25/07/23 00:31, Arnaldo Carvalho de Melo wrote:
>>>> Em Mon, Jul 24, 2023 at 02:16:05PM -0700, Ian Rogers escreveu:
>>>>> On Mon, Jul 24, 2023 at 2:09 PM Arnaldo Carvalho de Melo
>>>>> <acme@kernel.org> wrote:
>>>>>>
>>>>>> As thread__find_symbol_fb() will end up calling thread__find_map() and
>>>>>> it in turn will call these on uninitialized memory:
>>>>>>
>>>>>>         maps__zput(al->maps);
>>>>>>         map__zput(al->map);
>>>>>>         thread__zput(al->thread);
>>>>>
>>>>> Normally there would be a addr_location__exit. It looks here like most
>>>>> values are copied in al_to_d_al, which copies reference counted values
>>>>> without doing appropriate gets. Perhaps add the gets in al_to_d_al and
>>>>> add the exit to make it clear there can't be addr_location related
>>>>> leaks here.
>>
>> Or just make al_to_d_al use strdups for the strings it gets from
>> reference counter structs.
>>
>> That or make the caller of ->resolve_address() provide a initialized
>> addr_location that it then exits.
> 
> OK, I will send a patch.

2 patches plus yours:

https://lore.kernel.org/linux-perf-users/20230731091857.10681-1-adrian.hunter@intel.com/T/#t

> 
>>
>> - Arnaldo
>>
>>>> I'll do that as well and add the addr_location__exit() then send a V2.
>>>
>>> The data is not valid outside the context of ->filter_event() or
>>> ->filter_event_early(), so the reference counts should not be changed.
>>> That probably needs to be made clearer in the documentation.
>>
>>
>>  
>>>>
>>>> - Arnaldo
>>>>  
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
>>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>>>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
>>>>>> Cc: Ian Rogers <irogers@google.com>
>>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>>> Cc: Kajol Jain <kjain@linux.ibm.com>
>>>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>>> Link: https://lore.kernel.org/lkml/
>>>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>>> ---
>>>>>>  tools/perf/util/dlfilter.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
>>>>>> index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
>>>>>> --- a/tools/perf/util/dlfilter.c
>>>>>> +++ b/tools/perf/util/dlfilter.c
>>>>>> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
>>>>>>         if (!thread)
>>>>>>                 return -1;
>>>>>>
>>>>>> +       addr_location__init(&al);
>>>>>>         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
>>>>>>
>>>>>>         al_to_d_al(&al, &d_al);
>>>>>> --
>>>>>> 2.37.1
>>>>>>
>>>>
>>>
>>
> 

