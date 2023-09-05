Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D5792994
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349732AbjIEQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354663AbjIENWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:22:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9019B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693920168; x=1725456168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hkJRK04JX1DUOtu+OnP0WBjpHDZLTz6wdJrsqh8md7A=;
  b=OhLaLg6RLEliGnxIiJ0o7/8T1BO0W0YhO3+Q1eWgbZZCXWQEUv1Kh0JE
   IVeH1e4GnxorQFQlup5y0sr7V6S6L8gA7OuWxwAI6mJ57JJG4AWk3dn1o
   3sid9uFeC5m/baCbD5OcpJmi39VLsR5RS4oNR2qYalYw4faDYhatCG4VG
   zKZnMxvBhP3HuEG/qiaDnmWyVYiIaO+JQEKTzB7pfTJdvfdvw/5lrk0+5
   xCXbqaq/gAdzJJtvHIQKCPEe7Jov0kXT9OCTTkbzvyf1I3T2BzbfDrrfC
   TGPwwTfwDiXNLluMBd/n6cRiN/bgmiATvnlxRVD6GW2iGgZPw56rNMeMr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="440765639"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="440765639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776199477"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="776199477"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:22:47 -0700
Received: from [10.209.168.123] (hhong-mobl.amr.corp.intel.com [10.209.168.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 062BF580DA0;
        Tue,  5 Sep 2023 06:22:46 -0700 (PDT)
Message-ID: <b706693a-b259-0c70-4ee3-0f63abca1519@linux.intel.com>
Date:   Tue, 5 Sep 2023 09:22:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on EMR
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
References: <20230901142028.298051-1-kan.liang@linux.intel.com>
 <ZPRGmoXKvOCFrK26@gmail.com>
 <37afe50a-44f1-7fb1-c4c0-1e45c38c9a6d@linux.intel.com>
 <ZPYrjW9+hIOJODHY@gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZPYrjW9+hIOJODHY@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-04 3:10 p.m., Ingo Molnar wrote:
> 
> * Liang, Kan <kan.liang@linux.intel.com> wrote:
> 
>>
>>
>> On 2023-09-03 4:40 a.m., Ingo Molnar wrote:
>>>
>>> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The MSR UNC_CBO_CONFIG, which was used to detect the number of CHAs on
>>>> SPR, is broken on EMR XCC. It always returns 0.
>>>>
>>>> Roll back to the discovery method, which can give the correct number for
>>>> this case.
>>>>
>>>> Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
>>>> Reported-by: Stephane Eranian <eranian@google.com>
>>>> Reported-by: Yunying Sun <yunying.sun@intel.com>
>>>> Tested-by: Yunying Sun <yunying.sun@intel.com>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>>  arch/x86/events/intel/uncore_snbep.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>>> index d49e90dc04a4..c41d7d46481c 100644
>>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>>> @@ -6475,7 +6475,9 @@ void spr_uncore_cpu_init(void)
>>>>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>>>>  	if (type) {
>>>>  		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
>>>> -		type->num_boxes = num_cbo;
>>>> +		/* The MSR doesn't work on the EMR XCC. Roll back to the discovery method. */
>>>> +		if (num_cbo)
>>>> +			type->num_boxes = num_cbo;
>>>
>>> So in the zero case we don't write type->num_boxes and leave it as-is.
>>>
>>> How does this fall back to the discovery method, is the existing (default?) 
>>> value of type->num_boxes some special value?
>>>
>>
>> Starts from SPR, the basic uncore PMON information are retrieved from
>> the discovery table (resides in an MMIO space populated by BIOS.). It is
>> called the discovery method. The existing value of the type->num_boxes
>> is from the discovery table.
>>
>> On some SPR variants, there is a firmware bug. So the value from the
>> discovery table is incorrect. We use the value from
>> SPR_MSR_UNC_CBO_CONFIG to replace the one from the discovery table.
>> 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
>>
>> Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
>> XCC (It works well for other EMR variants). But the above firmware bug
>> doesn't impact the EMR XCC. So this patch NOT lets the value from the
>> SPR_MSR_UNC_CBO_CONFIG replace the existing value from the discovery table.
> 
> Thanks - the comment & changelog should probably reflect this background.
> 

I will update the comment & changelog and send a V2.

Thanks,
Kan
