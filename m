Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B105B7A1CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjIOKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjIOKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:46:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E17DD;
        Fri, 15 Sep 2023 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694774810; x=1726310810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A4k+Kycs5eiCi32oXVEr6wYi9aLQvheDDXp0X3nUgNg=;
  b=FMkrh2N0tLgiYm58yyAcfyLtgio4MvXQxJcKkpb8myMMLoxVTiEc1kOJ
   dpHtM2EMrL5reyp+wdVCqZDqQhwmjdTgg8LkC9vTdpXVUaZbj1/q3EITg
   OFilelYDtGQsH1/vOk9II2IX/eEttF5IUSE6ofGvcoZi6fBjMrqEq0bNx
   sCGtTDZycFt2RQ0/oXew/ohjcZ3LjGqcD7MIfTe2/JePU9gBlxxio5XDC
   lkDhKZ08dOik+ZK0na1MTbBCrUw55LpLOR+LKWD6nLsqBe9H5D8HKRmVj
   sPjVsSP1vlI5Uqv7Y30FFrJGAbqbwPAOptB3cMEs62c862LpZDTNIAVc5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465583143"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="465583143"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 03:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="748165841"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="748165841"
Received: from andreipo-mobl1.ger.corp.intel.com (HELO [10.252.48.105]) ([10.252.48.105])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 03:46:48 -0700
Message-ID: <11672c6d-e021-eeda-5907-3fefb307ce9d@linux.intel.com>
Date:   Fri, 15 Sep 2023 13:46:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] tracing/synthetic: Print out u64 values properly
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
 <20230915150101.ef50c4774ab85aa2ff7431ec@kernel.org>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <20230915150101.ef50c4774ab85aa2ff7431ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 15/09/2023 09:01, Masami Hiramatsu (Google) wrote:
> Hi Tero,
>
> On Mon, 11 Sep 2023 17:17:04 +0300
> Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
>> The synth traces incorrectly print pointer to the synthetic event values
>> instead of the actual value when using u64 type. Fix by addressing the
>> contents of the union properly.
> Thanks for pointing it out.
> But I would like to see a new "case 8:" print code instead of changing
> "default". Can you keep the default as it is and add "case 8:" case there?

Are you sure about that? I think keeping the default as is would just 
print out a useless pointer value to the synth event itself (which is 
what happened with u64 type.)

Anyways, that requires a new patch to be created on top as this has hit 
the mainline as a fix already.

-Tero


>
> Thanks,
>
>> Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   kernel/trace/trace_events_synth.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
>> index 7fff8235075f..070365959c0a 100644
>> --- a/kernel/trace/trace_events_synth.c
>> +++ b/kernel/trace/trace_events_synth.c
>> @@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
>>   		break;
>>   
>>   	default:
>> -		trace_seq_printf(s, print_fmt, name, val, space);
>> +		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
>>   		break;
>>   	}
>>   }
>> -- 
>> 2.40.1
>>
>
