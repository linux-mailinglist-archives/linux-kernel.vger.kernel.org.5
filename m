Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B27C8D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJMSt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:49:58 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136283
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697222992;
        bh=5lJYynDVEnZ8b1vOKPXx6IKj1N5D/WYZRCy3pdZBk9g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kTyupYGOBFQ+FOo49cXR/LNgg1bHI49BVwQhTQtsMIDJPHpsbq2qONbpsiLQr740Q
         JSUFYoTT4XbkCEzyc6mR/PlHjx8g8LR2fb09kRn+ImPbRdNiY9lOQJtU//zI+r4mxV
         M3vWkiD64qZ5yyZ9o7Chp6sB8K0ZJ8UEO98OauQG6NcAg7zo3MW4yKNw2rS7I5dgnT
         OK9I0VOGoVnmkyxQIUVcfeWryh6R5vNNm0ae8lCQf2DX53uXnolJppOF38pBf+4p7R
         WqV+Bx/bbXlqK+B3S5f/Gls/d9doxwqLuAVKvO+SBU1Cs7GoMeDK8eI+eBK8TodyuE
         krPkiDFQdBrag==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S6bCh2l5yz1X8t;
        Fri, 13 Oct 2023 14:49:52 -0400 (EDT)
Message-ID: <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com>
Date:   Fri, 13 Oct 2023 14:49:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, parri.andrea@gmail.com,
        charlie@rivosinc.com, rehn@rivosinc.com
Cc:     paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-13 13:29, Palmer Dabbelt wrote:
> On Mon, 07 Aug 2023 06:19:18 PDT (-0700), parri.andrea@gmail.com wrote:
>>> One more noteworthy detail: if a system call similar to ARM 
>>> cacheflush(2) is implemented for
>>> RISC-V, perhaps an iovec ABI (similar to readv(2)/writev(2)) would be 
>>> relevant to handle
>>> batching of cache flushing when address ranges are not contiguous. 
>>> Maybe with a new name
>>> like "cacheflushv(2)", so eventually other architectures could 
>>> implement it as well ?
>>
>> I believe that's a sensible idea.  But the RISC-V maintainers can provide
>> a more reliable feedback.
> 
> Sorry I missed this, I'm still a bit backlogged from COVID.  A few of us 
> were having a meeting, just to try and summarize (many of these points 
> came up in the thread, so sorry for rehashing things):
> 
> We don't have a fence.i in the scheduling path, as fence.i is very slow 
> on systems that implement it by flushing the icache.  Instead we have a 
> mechanism for deferring the fences (see flush_icache_deferred, though 
> I'm no longer sure that's correct which I'll mention below).  As a 
> result userspace can't do a fence.i directly, but instead needs to make 
> a syscall/vdsocall so the kernel can do this bookkeeping.  There's some 
> proposals for ISA extensions that replace fence.i, but they're still WIP 
> and there's a lot of fence.i-only hardware so we'll have to deal with it.
> 
> When we did this we had a feeling this may be sub-optimal for systems 
> that have faster fence.i implementations (ie, coherent instruction 
> caches), but nobody's gotten around to doing that yet -- and maybe 
> there's no hardware that behaves this way.  The rough plan was along the 
> lines of adding a prctl() where userspace can request the ability to 
> directly emit fence.i, which would then result in the kernel eagerly 
> emitting fence.i when scheduling.  Some of the Java people have been 
> asking for this sort of feature.

There is a membarrier(2) registration scheme to ensure that core serializing
instructions are issued in the relevant scenarios.

See MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE and
Documentation/features/sched/membarrier-sync-core/arch-support.txt

The core serializing instructions are typically issued on return to userspace
on various architectures, else we rely on switch_mm() emitting the fence between
update to rq->curr->mm and return to userspace. And on the rare case where
rq->curr->mm is changed without invoking switch_mm() (transition to a
kernel thread), then we've added the relevant code in the scheduler to add
a core serializing instruction for registered processes.

> 
>  From looking at the membarrier arch/scheduler hooks, I think we might 
> have a bug in our deferred icache flushing mechanism: specifically we 
> hook into switch_mm(), which this comment has me worried about
> 
>          * When switching through a kernel thread, the loop in
>          * membarrier_{private,global}_expedited() may have observed that
>          * kernel thread and not issued an IPI. It is therefore possible to
>          * schedule between user->kernel->user threads without passing 
> though
>          * switch_mm(). Membarrier requires a barrier after storing to
>          * rq->curr, before returning to userspace, so provide them here:

I guess you wonder if the on_each_cpu_mask ipis based on the mm_cpumask(mm)
gives any level of guarantee with respect to switch_mm() modifying this
mask. (in flush_icache_mm())

In membarrier, we decided against using the mm_cpumask for various reasons:

- AFAIR, on some architectures, the mm_cpumask is a superset of the CPUs actually
   used (it's never cleared),
- the point where the mm_cpumask is updated with respect to memory barriers
   in the scheduler code is not as convenient as it is for updates to
   "rq->curr" by the scheduler. This matters for the other purposes of
   membarrier(2) which is to issue memory barriers on all threads belonging
   to a process.

and instead we iterate on each online cpus, and compare the "rq->curr->mm"
pointer to the current task. Then we made sure to document all the
relevant memory barriers and core serializing instruction expectations
around rq->curr->mm update by the scheduler.

But back to the RISC-V flush_icache_mm() scheme, because it does not rely
on "rq->curr" at all, then it all depends on whether the cpu is still in
the mm_cpumask of the mm when that cpu temporarily schedules a kernel thread.
AFAIR, scheduling a kernel thread does not trigger any call to switch_mm
(it an optimization which leaves the mm in place while running the kernel
thread), so the on_each_cpu_mask using the mm_cpumask would be OK.

> 
> Even if there's not a bug in the RISC-V stuff, it seems that we've ended 
> up with pretty similar schemes here and we could remove some 
> arch-specific code by de-duplicating things -- IIRC there was no 
> membarrier when we did the original port, so I think we've just missed a 
> cleanup opportunity.

Actually, membarrier(2) MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE appeared
in Linux 4.16, whereas the initial port of RISC-V appeared in Linux 4.15.
So this de-duplication has been missed by a narrow window :)

Yes, it would make sense to do this de-duplication.

> 
> So I'd propose doing the following:
> 
> * Pick up a patch like this.  Mmaybe exactly this, I'm going to give it 
>   a proper review to make sure.

AFAIR this patch implements sync_core_before_usermode which gets used by
membarrier_mm_sync_core_before_usermode() to handle the uthread->kthread->uthread
case. It relies on switch_mm issuing a core serializing instruction as well.

Looking at RISC-V switch_mm(), I see that switch_mm() calls:

   flush_icache_deferred(next, cpu);

which only issues a fence.i if a deferred icache flush was required. We're
missing the part that sets the icache_stale_mask cpumask bits when a
MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked.


> * Remove the RISC-V implemenation of deferred icache flushes and instead 
>   just call into membarrier.  We might need to add some more bookkeeping 
>   here, but from a quick look it seems membarrier is doing pretty much 
>   the same thing.

The only part where I think you may want to keep some level of deferred
icache flushing as you do now is as follows:

- when membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked,
   call a new architecture hook which sets cpumask bits in the mm context
   that tells the next switch_mm on each cpu to issue fence.i for that mm.
- keep something like flush_icache_deferred as you have now.

Otherwise, I fear the overhead of a very expensive fence.i would be too
much when processes registering with MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
and start doing fence.i on each and every switch_mm().

So you'd basically rely on membarrier to only issue IPIs to the CPUs which are
currently running threads belonging to the mm, and handle the switch_mm with
the sync_core_before_usermode() for uthread->kthread->uthread case, and implement
a deferred icache flush for the typical switch_mm() case.


> * Implement that prctl that allows userspace to ask for permission to do 
>   direct fence.i instructions -- sort of a different project, but if 
>   we're going to be tearing into all this code we might as well do it  now.

But fence.i would only have effects on the hart it is being called from, right ?
What is the use-case for allowing user-space to issue this instruction ?

One more thing: membarrier(2) sync_core only issues things like "fence.i" on
the various cores in the system running threads belonging to the process, but
does not intend to take care of doing any kind of cache invalidation per se
(e.g. invalidating an address range worth of cache). On ARM, this is done by a
separate system call (e.g. cacheflush(2)), or can be done by instructions
available from userspace in some cases.

Do you expect to have a need for flushing only specific icache lines, or is
the intent to always flush the entire icache ?

> 
> Charlie is volunteering to do the work here, so hopefully we'll have 
> something moving forward.

That's great! I hope my feedback will help.

Thanks,

Mathieu

> 
>>
>>   Andrea

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

