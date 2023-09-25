Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4897ADB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjIYPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIYPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:16:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6DA99C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:16:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FF5FDA7;
        Mon, 25 Sep 2023 08:16:57 -0700 (PDT)
Received: from [10.57.65.61] (unknown [10.57.65.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFC423F5A1;
        Mon, 25 Sep 2023 08:16:16 -0700 (PDT)
Message-ID: <9f731870-ed36-d2e4-378b-f7fbf338ebd6@arm.com>
Date:   Mon, 25 Sep 2023 16:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add handler for MOPS exceptions
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
 <20230922112508.1774352-2-kristina.martsenko@arm.com>
 <87sf734ofv.wl-maz@kernel.org>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <87sf734ofv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2023 15:48, Marc Zyngier wrote:
> Hi Kristina,

Hi Marc,

> On Fri, 22 Sep 2023 12:25:07 +0100,
> Kristina Martsenko <kristina.martsenko@arm.com> wrote:
>>
>> An Armv8.8 FEAT_MOPS main or epilogue instruction will take an exception
>> if executed on a CPU with a different MOPS implementation option (A or
>> B) than the CPU where the preceding prologue instruction ran. In this
>> case the OS exception handler is expected to reset the registers and
>> restart execution from the prologue instruction.
>>
>> A KVM guest may use the instructions at EL1 at times when the guest is
>> not able to handle the exception, expecting that the instructions will
>> only run on one CPU (e.g. when running UEFI boot services in the guest).
>> As KVM may reschedule the guest between different types of CPUs at any
>> time (on an asymmetric system), it needs to also handle the resulting
>> exception itself in case the guest is not able to. A similar situation
>> will also occur in the future when live migrating a guest from one type
>> of CPU to another.
>>
>> Add handling for the MOPS exception to KVM. The handling can be shared
>> with the EL0 exception handler, as the logic and register layouts are
>> the same. The exception can be handled right after exiting a guest,
>> which avoids the cost of returning to the host exit handler.
>>
>> Similarly to the EL0 exception handler, in case the main or epilogue
>> instruction is being single stepped, it makes sense to finish the step
>> before executing the prologue instruction, so advance the single step
>> state machine.
> 
> What is the rationale for advancing the state machine? Shouldn't we
> instead return to the guest and immediately get the SS exception,
> which in turn gets reported to userspace? Is it because we rollback
> the PC to a previous instruction?

Yes, because we rollback the PC to the prologue instruction. We advance the
state machine so that the SS exception is taken immediately upon returning to
the guest at the prologue instruction. If we didn't advance it then we would
return to the guest, execute the prologue instruction, and then take the SS
exception on the middle instruction. Which would be surprising as userspace
would see the middle and epilogue instructions executed multiple times but not
the prologue.

> In the latter case, won't userspace see multiple SS exceptions for the
> middle instruction if trapping from the epilogue? This would be a bit
> surprising, to say the least.

Not sure I follow. Do you mean multiple in a row or multiple in total? Not in a
row (we step the prologue instruction in between), but yes in total (every time
we start executing the middle instruction). And this happens when trapping from
the middle instruction too, not just the epilogue. Do you see a better way of
handling it?

Here is an example of what GDB sees when single stepping a guest while the
guest executes these instructions ("mops ex" are debug prints in kvm; I've
added prologue/main/epilogue comments):

Breakpoint 2, 0xffff80008051b6a4 in ?? ()
0xffff80008051b6a8 in ?? () # prologue
0xffff80008051b6ac in ?? () # main
[   33.615305] mops ex: memcpy: B->A: fwd: main
0xffff80008051b6a8 in ?? () # prologue
0xffff80008051b6ac in ?? () # main
0xffff80008051b6b0 in ?? () # epilogue
[   34.141251] mops ex: memcpy: A->B: fwd: epi
0xffff80008051b6a8 in ?? () # prologue
0xffff80008051b6ac in ?? () # main
0xffff80008051b6b0 in ?? () # epilogue
[   34.209822] mops ex: memcpy: B->A: fwd: epi
0xffff80008051b6a8 in ?? () # prologue
0xffff80008051b6ac in ?? () # main
0xffff80008051b6b0 in ?? () # epilogue
0xffff80008051b6b4 in ?? ()
[...]

Thanks,
Kristina

