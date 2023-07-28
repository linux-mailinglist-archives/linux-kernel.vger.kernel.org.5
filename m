Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174A776762F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjG1TS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjG1TS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:18:27 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DC19A1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690571906; x=1722107906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZLN+K2/8C4v2pMy98JqZ3Uxtz8+XYzqGi/zD9UpPicc=;
  b=KU2Sfpznd246yNbQzJJD9z5fiAL2zuUHPwomhiYMfpDhAf0/wpzN5Ja1
   J+Ufz9NbCCEd0tceT/++/IyqX7hc3XRj9PNLHPR/hAz7uv0CA1sJlUXM3
   XoCiM3NhZoNO9F+dP5Ejbqh0DM7b+Q2ZN4iZm6GCAxYMPXxBtdPgiTFRY
   XKINjLw4k6SL6U7h67QJoU+slYRDOG2cUVLv/rBpR1WcvI0yJIMBfYgco
   kJ2RcjGinI3chAWP0NbUZYy8AKDEzIehO9olq5irkfvx5ryya20aVVLuH
   48T00Ca2QyG1AmGwU42uylt9aUDbK75fTKNs5oqOcCp/vjEb+sGo56RCL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="367551046"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367551046"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="730877383"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="730877383"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.27])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:18:10 -0700
Message-ID: <95590e6a-0747-a365-4de1-0ccd8fdfc257@intel.com>
Date:   Fri, 28 Jul 2023 22:18:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
Content-Language: en-US
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZMJ7d7BUeva82rMm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/23 17:13, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 25, 2023 at 02:51:58PM +0300, Adrian Hunter escreveu:
>> On 25/07/23 00:31, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Jul 24, 2023 at 02:16:05PM -0700, Ian Rogers escreveu:
>>>> On Mon, Jul 24, 2023 at 2:09 PM Arnaldo Carvalho de Melo
>>>> <acme@kernel.org> wrote:
>>>>>
>>>>> As thread__find_symbol_fb() will end up calling thread__find_map() and
>>>>> it in turn will call these on uninitialized memory:
>>>>>
>>>>>         maps__zput(al->maps);
>>>>>         map__zput(al->map);
>>>>>         thread__zput(al->thread);
>>>>
>>>> Normally there would be a addr_location__exit. It looks here like most
>>>> values are copied in al_to_d_al, which copies reference counted values
>>>> without doing appropriate gets. Perhaps add the gets in al_to_d_al and
>>>> add the exit to make it clear there can't be addr_location related
>>>> leaks here.
> 
> Or just make al_to_d_al use strdups for the strings it gets from
> reference counter structs.
> 
> That or make the caller of ->resolve_address() provide a initialized
> addr_location that it then exits.

OK, I will send a patch.

> 
> - Arnaldo
> 
>>> I'll do that as well and add the addr_location__exit() then send a V2.
>>
>> The data is not valid outside the context of ->filter_event() or
>> ->filter_event_early(), so the reference counts should not be changed.
>> That probably needs to be made clearer in the documentation.
> 
> 
>  
>>>
>>> - Arnaldo
>>>  
>>>> Thanks,
>>>> Ian
>>>>
>>>>> Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
>>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>>>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
>>>>> Cc: Ian Rogers <irogers@google.com>
>>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>>> Cc: Kajol Jain <kjain@linux.ibm.com>
>>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>> Link: https://lore.kernel.org/lkml/
>>>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>> ---
>>>>>  tools/perf/util/dlfilter.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
>>>>> index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
>>>>> --- a/tools/perf/util/dlfilter.c
>>>>> +++ b/tools/perf/util/dlfilter.c
>>>>> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
>>>>>         if (!thread)
>>>>>                 return -1;
>>>>>
>>>>> +       addr_location__init(&al);
>>>>>         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
>>>>>
>>>>>         al_to_d_al(&al, &d_al);
>>>>> --
>>>>> 2.37.1
>>>>>
>>>
>>
> 

