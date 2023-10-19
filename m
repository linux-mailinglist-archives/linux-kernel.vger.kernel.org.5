Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42637CF916
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbjJSMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjJSMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:37:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3ED91
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046C4C433C8;
        Thu, 19 Oct 2023 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697719051;
        bh=+6WjsLik/mT7DRZ52304GX0OlGSRTcYphDgt+xJktvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k9YWca4ZBzrXC+Kbyx7KSVfQOfqUeAVC6E8O2jFODDW5jsYDYuQHIr2yQs64Fb/sp
         9W+xQiQuby6F1GzQ/qVZ12WHjF9/zsfsfqWlLPSNHnq/iX+Ykr5tTewg1lGPyzrncE
         A3iKkr5jtnp6i2Vi86VEWGg4+nBxMM47qBYH0dcteiL3dYrwYGmmaDNHE7xHs54jtX
         IUdhBT5pGlwk5qoLMavvdw3ZBOD+hFjanB5gH7l5Kk7vnmNGYX1J4Msc89py0KLr4f
         EStwd7oa4c4jKnqLHYGnJS4ztTfIcfsaghF0366QyW3gjUlefuLvKlmuaJtul5Zn7E
         Lsp9UMZmXK8eQ==
Message-ID: <05066f9d-b8c9-4a22-b573-928df4263e49@kernel.org>
Date:   Thu, 19 Oct 2023 14:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop> <87pm1c3wbn.ffs@tglx>
 <20231018103146.4856caa8@gandalf.local.home>
 <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
 <20231018140035.107f5177@gandalf.local.home>
 <98f9ff35-5d71-4706-afe1-7e039afbcaaf@paulmck-laptop>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <98f9ff35-5d71-4706-afe1-7e039afbcaaf@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 20:13, Paul E. McKenney wrote:
> On Wed, Oct 18, 2023 at 02:00:35PM -0400, Steven Rostedt wrote:
>> On Wed, 18 Oct 2023 10:55:02 -0700
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>
>>>> If everything becomes PREEMPT_RCU, then the above should be able to be
>>>> turned into just:
>>>>
>>>>                 if (!disable_irq)
>>>>                         local_irq_disable();
>>>>
>>>>                 rcu_momentary_dyntick_idle();
>>>>
>>>>                 if (!disable_irq)
>>>>                         local_irq_enable();
>>>>
>>>> And no cond_resched() is needed.  
>>>
>>> Even given that CONFIG_PREEMPT_RCU=n still exists, the fact that
>>> run_osnoise() is running in kthread context with preemption and everything
>>> else enabled (am I right?), then the change you suggest should work fine.
>>
>> There's a user space option that lets you run that loop with preemption and/or
>> interrupts disabled.
> 
> Ah, thank you.  Then as long as this function is not expecting an RCU
> reader to span that call to rcu_momentary_dyntick_idle(), all is well.
> This is a kthread, so there cannot be something else expecting an RCU
> reader to span that call.

Sorry for the delay, this thread is quite long (and I admit I should be paying
attention to it).

It seems that you both figure it out without me anyways. This piece of
code is preemptive unless a config is set to disable irq or preemption (as
steven mentioned). That call is just a ping to RCU to say that things
are fine.

So Steven's suggestion should work.

>>>>> Again. There is no non-preemtible RCU with this model, unless I'm
>>>>> missing something important here.  
>>>>
>>>> Daniel?  
>>>
>>> But very happy to defer to Daniel.  ;-)
>>
>> But Daniel could also correct me ;-)
> 
> If he figures out a way that it is broken, he gets to fix it.  ;-)

It works for me, keep in the loop for the patches and I can test and
adjust osnoise accordingly. osnoise should not be a reason to block more
important things like this patch set, and we can find a way out in
the osnoise tracer side. (I might need an assistance from rcu
people, but I know I can count on them :-).

Thanks!
-- Daniel
> 						Thanx, Paul

