Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE676E9E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjHCNSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjHCNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:18:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F432E6F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:18:23 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 373DIL50004362;
        Thu, 3 Aug 2023 22:18:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Thu, 03 Aug 2023 22:18:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 373DIA4l004327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Aug 2023 22:18:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60d4dc52-9281-9266-4294-b514bd09e6e8@I-love.SAKURA.ne.jp>
Date:   Thu, 3 Aug 2023 22:18:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
To:     Michal Hocko <mhocko@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de> <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
 <20230727151029.e_M9bi8N@linutronix.de>
 <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
 <649fa1a7-4efd-8cc7-92c7-ac7944adc283@I-love.SAKURA.ne.jp>
 <ZMfETPzGfpPP7F79@dhcp22.suse.cz>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZMfETPzGfpPP7F79@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/07/31 23:25, Michal Hocko wrote:
> On Sat 29-07-23 20:05:43, Tetsuo Handa wrote:
>> On 2023/07/29 14:31, Tetsuo Handa wrote:
>>> On 2023/07/28 0:10, Sebastian Andrzej Siewior wrote:
>>>> On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
>>>>>> Anyway, please do not do this change only because of printk().
>>>>>> IMHO, the current ordering is more logical and the printk() problem
>>>>>> should be solved another way.
>>>>>
>>>>> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
>>>>> rejected.
>>>>
>>>> My understanding is that this patch gets applied and your objection will
>>>> be noted.
>>>
>>> My preference is that zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
>>> allocations, which is a low-hanging fruit towards GFP_LOCKLESS mentioned at
>>> https://lkml.kernel.org/r/ZG3+l4qcCWTPtSMD@dhcp22.suse.cz and
>>> https://lkml.kernel.org/r/ZJWWpGZMJIADQvRS@dhcp22.suse.cz .
>>>
>>> Maybe we can defer checking zonelist_update_seq till retry check like below,
>>> for this is really an infrequent event.
>>>
>>
>> An updated version with comments added.
> 
> Seriously, don't you see how hairy all this is? And for what? Nitpicking
> something that doesn't seem to be a real problem in the first place?

Seriously, can't you find "zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
allocations, which is a low-hanging fruit towards GFP_LOCKLESS" !?

My initial proposal was
"[PATCH] mm/page_alloc: don't check zonelist_update_seq from atomic allocations"
at https://lkml.kernel.org/r/dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp .
Compared to that version, this what-you-call-hairy version has an improvement that

-	return read_seqbegin(&zonelist_update_seq);
+	return data_race(READ_ONCE(zonelist_update_seq));

can eliminate

	while ((__seq = seqprop_sequence(s)) & 1)
		cpu_relax();

path. There is no need to wait for completion of rebuilding zonelists, for
rebuilding zonelists being in flight (indicated by zonelist_update_seq being odd)
does not mean that allocation never succeeds. When allocation did not fail,
this "while" loop becomes nothing but a waste of CPU time, And it is very likely
that rebuilding zonelists being not in flight from the beginning.

We can make zonelist_iter_begin() (which is always called as long as
__alloc_pages_slowpath() is called) faster and simpler, which is an improvement
even without considering printk() and lockdep/KCSAN related problems.

