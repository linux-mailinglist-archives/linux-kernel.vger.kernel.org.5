Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79049770179
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjHDN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHDN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:27:58 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739D4C0A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:27:33 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 374DRMAA042544;
        Fri, 4 Aug 2023 22:27:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 04 Aug 2023 22:27:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 374DRLxE042538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Aug 2023 22:27:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2505f6d3-5a10-49e7-960f-12c31a62a366@I-love.SAKURA.ne.jp>
Date:   Fri, 4 Aug 2023 22:27:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de> <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
 <20230727151029.e_M9bi8N@linutronix.de>
 <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
 <649fa1a7-4efd-8cc7-92c7-ac7944adc283@I-love.SAKURA.ne.jp>
 <ZMfETPzGfpPP7F79@dhcp22.suse.cz>
 <60d4dc52-9281-9266-4294-b514bd09e6e8@I-love.SAKURA.ne.jp>
 <ZMu+kn/g4idBcycV@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZMu+kn/g4idBcycV@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/03 23:49, Michal Hocko wrote:
> On Thu 03-08-23 22:18:10, Tetsuo Handa wrote:
>> On 2023/07/31 23:25, Michal Hocko wrote:
>>> On Sat 29-07-23 20:05:43, Tetsuo Handa wrote:
>>>> On 2023/07/29 14:31, Tetsuo Handa wrote:
>>>>> On 2023/07/28 0:10, Sebastian Andrzej Siewior wrote:
>>>>>> On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
>>>>>>>> Anyway, please do not do this change only because of printk().
>>>>>>>> IMHO, the current ordering is more logical and the printk() problem
>>>>>>>> should be solved another way.
>>>>>>>
>>>>>>> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
>>>>>>> rejected.
>>>>>>
>>>>>> My understanding is that this patch gets applied and your objection will
>>>>>> be noted.
>>>>>
>>>>> My preference is that zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
>>>>> allocations, which is a low-hanging fruit towards GFP_LOCKLESS mentioned at
>>>>> https://lkml.kernel.org/r/ZG3+l4qcCWTPtSMD@dhcp22.suse.cz and
>>>>> https://lkml.kernel.org/r/ZJWWpGZMJIADQvRS@dhcp22.suse.cz .
>>>>>
>>>>> Maybe we can defer checking zonelist_update_seq till retry check like below,
>>>>> for this is really an infrequent event.
>>>>>
>>>>
>>>> An updated version with comments added.
>>>
>>> Seriously, don't you see how hairy all this is? And for what? Nitpicking
>>> something that doesn't seem to be a real problem in the first place?
>>
>> Seriously, can't you find "zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
>> allocations, which is a low-hanging fruit towards GFP_LOCKLESS" !?
> 
> I do not think we have concluded that we want to support GFP_LOCKLESS.
> This might be trivial straightforward now but it imposes some constrains
> for future maintainability. So far we haven't heard about many usecases
> where this would be needed and a single one is not sufficient IMHO.

When you introduced a word GFP_LOCKLESS in the link above, I was wondering the meaning
of "LESS" part. Since we know that it is difficult to achieve "hold 0 lock during memory
allocation", "hold least locks during memory allocation" will be at best. Therefore,
GFP_LOCKLESS is as misleading name as GFP_ATOMIC. GFP_LOCK_LEAST or GFP_LEAST_LOCKS will
represent the real behavior better.

Like I said

  I consider that memory allocations which do not do direct reclaim should be geared
  towards less locking dependency.

in the thread above, I still believe that this what-you-call-hairy version (which
matches "hold least locks during memory allocation" direction) is better than
"[PATCH v3 2/2] mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save()."
(which does not match "hold least locks during memory allocation"). My version not
only avoids possibility of deadlock, but also makes zonelist_iter_begin() faster and
simpler.

Not holding zonelist_update_seq lock is trivially doable compared to removing
__GFP_KSWAPD_RECLAIM from GFP_ATOMIC. Please give me feedback about which line of my
proposal is technically unsafe, instead of discarding my proposal with negative words
like "hairy".

