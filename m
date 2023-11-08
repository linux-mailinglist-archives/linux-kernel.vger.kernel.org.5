Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAB7E4FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHEwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjKHEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:52:43 -0500
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265D13A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 20:52:40 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id 2E3D148F45; Tue,  7 Nov 2023 20:52:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2AA5548F41;
        Tue,  7 Nov 2023 20:52:39 -0800 (PST)
Date:   Tue, 7 Nov 2023 20:52:39 -0800 (PST)
From:   Christoph Lameter <cl@linux.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-Reply-To: <87bkc4vp89.fsf@oracle.com>
Message-ID: <385909b5-3077-42d4-07ef-7ae915d24b5a@linux.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com> <549c1cba-5cad-7706-de85-d61376db25cc@linux.com> <87bkc4vp89.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023, Ankur Arora wrote:

> This came up in an earlier discussion (See
> https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/) and Thomas mentioned
> that preempt_enable/_disable() overhead was relatively minimal.
>
> Is your point that always-on preempt_count is far too expensive?

Yes over the years distros have traditionally delivered their kernels by 
default without preemption because of these issues. If the overhead has 
been minimized then that may have changed. Even if so there is still a lot 
of code being generated that has questionable benefit and just 
bloats the kernel.

>> These are needed to avoid adding preempt_enable/disable to a lot of primitives
>> that are used for synchronization. You cannot remove those without changing a
>> lot of synchronization primitives to always have to consider being preempted
>> while operating.
>
> I'm afraid I don't understand why you would need to change any
> synchronization primitives. The code that does preempt_enable/_disable()
> is compiled out because CONFIG_PREEMPT_NONE/_VOLUNTARY don't define
> CONFIG_PREEMPT_COUNT.

In the trivial cases it is simple like that. But look f.e.
in the slub allocator at the #ifdef CONFIG_PREEMPTION section. There is a 
overhead added to be able to allow the cpu to change under us. There are 
likely other examples in the source.

And the whole business of local data 
access via per cpu areas suffers if we cannot rely on two accesses in a 
section being able to see consistent values.

> The intent here is to always have CONFIG_PREEMPT_COUNT=y.

Just for fun? Code is most efficient if it does not have to consider too 
many side conditions like suddenly running on a different processor. This 
introduces needless complexity into the code. It would be better to remove 
PREEMPT_COUNT for good to just rely on voluntary preemption. We could 
probably reduce the complexity of the kernel source significantly.

I have never noticed a need to preemption at every instruction in the 
kernel (if that would be possible at all... Locks etc prevent that ideal 
scenario frequently). Preemption like that is more like a pipe dream.

High performance kernel solution usually disable 
overhead like that.


