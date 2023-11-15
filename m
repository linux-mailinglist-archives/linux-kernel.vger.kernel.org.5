Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9E7EC1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjKOL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbjKOL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:56:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AC12F;
        Wed, 15 Nov 2023 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049357; x=1731585357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rIkeGWe0vKeWaaGNiLfcCs1mZGJqvuSfSNOI2QChTzM=;
  b=eJoOEaygiOlOgsnYY4L6NGhMdA5EigBPjCvNg+gJvmfyEmdcm+qH4njI
   E4Vg+ckS6iFng7e4CgR2mXUjLhHa3tBd5QYOafmcrWqTSltdTpB9Xxgrj
   hj48CpB8GnHm3KogMBl2pCXK9cCsWwKmeT4F3b/9TiKBg8A4CxJ87oFbP
   lO4q/OqPB1qlyiCAXbrH0eVEMTY0hHF7o6C1ZDD8ap6uoQoPSdZO2DNsJ
   z4Ci5M/W6cnme843amNAp0uTkIhO52ABh076AkXTB/PtgfBAalbwqCCRq
   Yj876bcz/2Ccj8XdoQwmMFpyat62aLQ+9ZKYWFmYAj6Lh+24jvO093ArL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393720174"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393720174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753452"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753452"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:53 -0800
Message-ID: <bb08dc5d-8287-45e1-9b53-f56676768e60@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231109111146.qrnekz6ykyzrcpbd@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231109111146.qrnekz6ykyzrcpbd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 7:11 pm, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:20AM -0500, Faizal Rahim wrote:
>> Retrieve adjusted cycle_time and interval values through new APIs.
>> Note that in some cases where the original values are required,
>> such as in dump_schedule() and setup_first_end_time(), direct calls
>> to cycle_time and interval are retained without using the new APIs.
>>
>> Added a new field, correction_active, in the sched_entry struct to
>> determine the entry's correction state. This field is required due
>> to specific flow like find_entry_to_transmit() -> get_interval_end_time()
>> which retrieves the interval for each entry. During positive cycle
>> time correction, it's known that the last entry interval requires
>> correction. However, for negative correction, the affected entry
>> is unknown, which is why this new field is necessary.
> 
> I agree with the motivation, but I'm not sure if the chosen solution is
> correct.
> 
> static u32 get_interval(const struct sched_entry *entry,
> 			const struct sched_gate_list *oper)
> {
> 	if (entry->correction_active)
> 		return entry->interval + oper->cycle_time_correction;
> 
> 	return entry->interval;
> }
> 
> What if the schedule looks like this:
> 
> 	sched-entry S 0x01 125000000
> 	sched-entry S 0x02 125000000
> 	sched-entry S 0x04 125000000
> 	sched-entry S 0x08 125000000
> 	sched-entry S 0x10 125000000
> 	sched-entry S 0x20 125000000
> 	sched-entry S 0x40 125000000
> 	sched-entry S 0x80 125000000
> 
> and the calculated cycle_time_correction is -200000000? That would
> eliminate the entire last sched-entry (0x80), and the previous one
> (0x40) would run for just 75000000 ns. But your calculation would say
> that its interval is −75000000 ns (actually reported as an u32 positive
> integer, so it would be a completely bogus value).
> 
> So not only is the affected entry unknown, but also the amount of cycle
> time correction that applies to it is unknown.
> 

Just an FYI, my cycle time extension test for sending packets fails without 
updating the interval and cycle_time – the duration doesn't extend 
properly. I only observe proper extension when this patch is included.

In patch series v1, interval and cycle_time were updated directly. However, 
due to concerns in v1 comments about updating the fields directly, v2 
doesn't do that.

Regarding the concern about negative correction exceeding the interval 
value, I've checked the logic in get_cycle_time_correction() that sets 
cycle_time_correction, I don't see the possibility of this happening.... 
Still, if it does, it suggests an error much earlier than the 
get_interval() call. So, I propose a failure check in 
get_cycle_time_correction(). If the correction value is negative and 
consumes the entire entry interval or more, we set the negative 
cycle_time_correction to some arbitrary value, maybe half of the interval, 
just to mitigate the impact of the unknown error that occurred earlier.

What do you think ?

> I'm looking at where we need get_interval(), and it's from:
> 
> taprio_enqueue_one()
> -> is_valid_interval()
>     -> find_entry_to_transmit()
>        -> get_interval_end_time()
> -> get_packet_txtime()
>     -> find_entry_to_transmit()
> 
> I admit it's a part of taprio which I don't understand too well. Why do
> we perform such complex calculations in get_interval_end_time() when we
> should have struct sched_entry :: end_time precomputed and available for
> this purpose (although it was primarily inteded for advance_sched() and
> not for enqueue())?
> 
> Vinicius, do you know?
