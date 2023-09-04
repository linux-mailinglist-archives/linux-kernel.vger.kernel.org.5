Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EED791AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351163AbjIDPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIDPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:37:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3F1AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693841858; x=1725377858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=spade1S1q1sMpAzi81lGCbx6Z4cyNguRbdOukaFjToM=;
  b=HgIr47xvvM7pd09xNBDDHSLURYrNzzSmfdmCwxTbXXlLLMlVjtX+HCl7
   6jQo2cNSeyogSKoqmdRQMUmb11vTTci6N7UK6ZMNwshFJzNm+wJyP3A2B
   40k6nMl2mS6O09WBUJQTkGiJfx3lPp+l3MwNt6e+TNh182c86e0FN6i1T
   6wngyvMZjxnZNYoCycdE8Yirm32T9k3zB4pxJBi+sNhFpEiYgUj/qnSu5
   4CoCRACykVEhWise/lsm6WEWh3StKZvNi6ds3nnp6JRiBC7PDSz0tL4dc
   4UZe+CQfXHpb18+n/UmZqKG5ZB7Y5Hsnr1lVlASbkoLqKQKXUcbyE4g0P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375513312"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375513312"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="770036958"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="770036958"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:37:37 -0700
Received: from [10.212.36.166] (kliang2-mobl1.ccr.corp.intel.com [10.212.36.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9CE7D580D37;
        Mon,  4 Sep 2023 08:37:36 -0700 (PDT)
Message-ID: <37afe50a-44f1-7fb1-c4c0-1e45c38c9a6d@linux.intel.com>
Date:   Mon, 4 Sep 2023 11:37:35 -0400
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
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZPRGmoXKvOCFrK26@gmail.com>
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



On 2023-09-03 4:40 a.m., Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The MSR UNC_CBO_CONFIG, which was used to detect the number of CHAs on
>> SPR, is broken on EMR XCC. It always returns 0.
>>
>> Roll back to the discovery method, which can give the correct number for
>> this case.
>>
>> Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
>> Reported-by: Stephane Eranian <eranian@google.com>
>> Reported-by: Yunying Sun <yunying.sun@intel.com>
>> Tested-by: Yunying Sun <yunying.sun@intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index d49e90dc04a4..c41d7d46481c 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -6475,7 +6475,9 @@ void spr_uncore_cpu_init(void)
>>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>>  	if (type) {
>>  		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
>> -		type->num_boxes = num_cbo;
>> +		/* The MSR doesn't work on the EMR XCC. Roll back to the discovery method. */
>> +		if (num_cbo)
>> +			type->num_boxes = num_cbo;
> 
> So in the zero case we don't write type->num_boxes and leave it as-is.
> 
> How does this fall back to the discovery method, is the existing (default?) 
> value of type->num_boxes some special value?
> 

Starts from SPR, the basic uncore PMON information are retrieved from
the discovery table (resides in an MMIO space populated by BIOS.). It is
called the discovery method. The existing value of the type->num_boxes
is from the discovery table.

On some SPR variants, there is a firmware bug. So the value from the
discovery table is incorrect. We use the value from
SPR_MSR_UNC_CBO_CONFIG to replace the one from the discovery table.
38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")

Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
XCC (It works well for other EMR variants). But the above firmware bug
doesn't impact the EMR XCC. So this patch NOT lets the value from the
SPR_MSR_UNC_CBO_CONFIG replace the existing value from the discovery table.


Thanks,
Kan
