Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D57617A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGYLwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjGYLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:52:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F310EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690285928; x=1721821928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fd/RDz89cgDhh0kuNdhH2IWsW1WRaHvoArD8ju6Ge28=;
  b=fbVFzRs4VXkMnS4d6aA+faeIsdgZRBflas6O5bG/GO3SNcLEB9acJ/rG
   TaBLR1H9NDcn08lQPXFxjWwjWSWK8CXhIcXoTWFBAH5Zl0yBa4nQjPkls
   SiRhGHb0na+ZjNjEO1oxfS7lw7jazwk1Tx3m5Z7zC90OKIEKAnRhda59F
   5PUJ0byBxmN8j4hAfKgs/KLMbG4dbjqczWuwrBynMQ5sES5zB/iw8Hrdl
   UedOPuRmxbe/sq40XXMpkxiRhoXOIuuTWUaKsNIqp776NHgp03cR4KcNU
   7CtMFaqxlAABm16wyOgqzIXm7jAxwKvo4sybhPdpWjOtE8++t1nW/eolw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357700524"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="357700524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 04:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729323683"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="729323683"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.150])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 04:52:02 -0700
Message-ID: <d81c192a-49e1-b02a-b6e7-6c44927f041d@intel.com>
Date:   Tue, 25 Jul 2023 14:51:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZL7ocEWxjRtWR80T@kernel.org>
 <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
 <ZL7tv45K3zKqkHhZ@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZL7tv45K3zKqkHhZ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/23 00:31, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 24, 2023 at 02:16:05PM -0700, Ian Rogers escreveu:
>> On Mon, Jul 24, 2023 at 2:09 PM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> As thread__find_symbol_fb() will end up calling thread__find_map() and
>>> it in turn will call these on uninitialized memory:
>>>
>>>         maps__zput(al->maps);
>>>         map__zput(al->map);
>>>         thread__zput(al->thread);
>>
>> Normally there would be a addr_location__exit. It looks here like most
>> values are copied in al_to_d_al, which copies reference counted values
>> without doing appropriate gets. Perhaps add the gets in al_to_d_al and
>> add the exit to make it clear there can't be addr_location related
>> leaks here.
> 
> I'll do that as well and add the addr_location__exit() then send a V2.

The data is not valid outside the context of ->filter_event() or
->filter_event_early(), so the reference counts should not be changed.
That probably needs to be made clearer in the documentation.

> 
> - Arnaldo
>  
>> Thanks,
>> Ian
>>
>>> Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Kajol Jain <kjain@linux.ibm.com>
>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Link: https://lore.kernel.org/lkml/
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> ---
>>>  tools/perf/util/dlfilter.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
>>> index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
>>> --- a/tools/perf/util/dlfilter.c
>>> +++ b/tools/perf/util/dlfilter.c
>>> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
>>>         if (!thread)
>>>                 return -1;
>>>
>>> +       addr_location__init(&al);
>>>         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
>>>
>>>         al_to_d_al(&al, &d_al);
>>> --
>>> 2.37.1
>>>
> 

