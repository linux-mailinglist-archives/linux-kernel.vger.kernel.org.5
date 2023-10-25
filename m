Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41647D6E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbjJYOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjJYOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:04:37 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D918A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698242671;
        bh=BETV4KNiAreEsHtti0xML6K5ApKQpOTbKlT/YsBc0xI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SmBKWMxzorv+YQ5OGvpMGhELk2uO66JUCmEDEvuLQAbMBGVaP/m1oWxE1oekRmOnu
         GGVWOlkrSVmPm41hbiMQv2UeUsJZzjCRUAdsn2Ex3eYPP7+v5cmZh9ecMurpdJZODO
         M4aSXUX4ScurEl8tl3Nv6x5Wly6W6/FnbOaDFAQzXAG7ll+Mdp8RZDG2oTdK/9CBH6
         axMbsY5sqlgA79BsneJ5yGDqENVn2dBjKHgyCVHjMmlSj9j2X9MlJhRTGBseUVt7ll
         jBnUehbz4/Rq6u2pyjajBHdtiZKHP87zo6K41dYWODa6IQyoFV5P0ZD2I8QN2vfbHI
         zmetcTSCyXKjw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SFrJv3Jhdz1YyP;
        Wed, 25 Oct 2023 10:04:31 -0400 (EDT)
Message-ID: <57b3b129-9d89-4008-b160-b77116c4e8e0@efficios.com>
Date:   Wed, 25 Oct 2023 10:04:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <20231025075646.GB37471@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231025075646.GB37471@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25 03:56, Peter Zijlstra wrote:
> On Thu, Oct 19, 2023 at 12:05:22PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e93e006a942b..463e75084aed 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2090,6 +2090,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>>   
>>   #endif /* SCHED_DEBUG */
>>   
>> +static __always_inline bool sched_util_fits_capacity_active(void)
>> +{
>> +	return sched_feat(UTIL_EST) && sched_feat(UTIL_FITS_CAPACITY);
>> +}
> 
> This generates pretty terrible code; it cannot collapse this into a
> single branch. And since sched_feat is at best a debug interface for
> people who knows wtf they're doing, just make this UTIL_FITS_CAPACITY
> with a comment or so.

OK, change applied for the next round, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

