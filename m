Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FF77F564E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjKWCNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKWCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:13:15 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E5D43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700705597;
        bh=/iv6gHY+vJGMSPrVKbAaM5xdtaRFsSNH4rODAL5Qm/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JUxXpa2kpeCMpLtm+AkR3IqmWuVsA+w1oQ5TgjRdq6z/uW/Tu+n+n7z5CISQm3T+l
         y8i7ltnVNv7hzsy+n+ql7+sJyRDXXLfM2Knpq33vQEcej3wRJr+ERuAOnrZoMfLBGG
         ZSjrxQrgYSOGvQgwUpjULsga43Sev4hTZ57xMDlvD7fa1YE0/s8hFYgPxMTnAoqb+x
         lizz/2lYu5g/E8ahvsIYmAgGQo6OkP21vMbcPvEvbmQPcE6ESNDm2VAKKOHswDjCmr
         2QzNCBlAyUZl/9cAUmLJT+Dig7Vs3TeJx0At3oHMphI2pf9IlsRIIMWuIX05NmnMpN
         aIHHdxK0npN0A==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SbM8s2tjLz1dHp;
        Wed, 22 Nov 2023 21:13:17 -0500 (EST)
Message-ID: <790b8b57-43ac-447a-96b9-150e5b3a4237@efficios.com>
Date:   Wed, 22 Nov 2023 21:13:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Andrea Parri <parri.andrea@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, rehn@rivosinc.com,
        paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
 <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com> <ZU0sliwUQJyNAH1y@andrea>
 <ZV6lxsRmuN7bYFnD@ghost>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZV6lxsRmuN7bYFnD@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-22 20:07, Charlie Jenkins wrote:
> On Thu, Nov 09, 2023 at 08:24:58PM +0100, Andrea Parri wrote:
>> Mathieu, all,
>>
>> Sorry for the delay,
>>
>>> AFAIR this patch implements sync_core_before_usermode which gets used by
>>> membarrier_mm_sync_core_before_usermode() to handle the uthread->kthread->uthread
>>> case. It relies on switch_mm issuing a core serializing instruction as well.
>>>
>>> Looking at RISC-V switch_mm(), I see that switch_mm() calls:
>>>
>>>    flush_icache_deferred(next, cpu);
>>>
>>> which only issues a fence.i if a deferred icache flush was required. We're
>>> missing the part that sets the icache_stale_mask cpumask bits when a
>>> MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked.
>>
>> [...]
>>
>>> The only part where I think you may want to keep some level of deferred
>>> icache flushing as you do now is as follows:
>>>
>>> - when membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked,
>>>    call a new architecture hook which sets cpumask bits in the mm context
>>>    that tells the next switch_mm on each cpu to issue fence.i for that mm.
>>> - keep something like flush_icache_deferred as you have now.
>>>
>>> Otherwise, I fear the overhead of a very expensive fence.i would be too
>>> much when processes registering with MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
>>> and start doing fence.i on each and every switch_mm().
>>>
>>> So you'd basically rely on membarrier to only issue IPIs to the CPUs which are
>>> currently running threads belonging to the mm, and handle the switch_mm with
>>> the sync_core_before_usermode() for uthread->kthread->uthread case, and implement
>>> a deferred icache flush for the typical switch_mm() case.
>>
>> I've (tried to) put this together and obtained the two patches reported below.
>> Please let me know if this aligns with your intentions and/or there's interest
>> in a proper submission.

 >
 > This looks good to me, can you send out a non-RFC? I just sent out
 > patches to support userspace fence.i:
 > 
https://lore.kernel.org/linux-riscv/20231122-fencei-v1-0-bec0811cb212@rivosinc.com/T/#t.
 >
 > - Charlie
 >

Hi Andrea,

Yes, please send those as non-RFC patches. They align well with my 
intentions.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

