Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE07B6B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjJCO3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbjJCO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:29:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BF5AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:29:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE72EC433C8;
        Tue,  3 Oct 2023 14:29:44 +0000 (UTC)
Date:   Tue, 3 Oct 2023 15:29:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add handler for MOPS exceptions
Message-ID: <ZRwlVgWTqtCRi/jz@arm.com>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
 <20230922112508.1774352-2-kristina.martsenko@arm.com>
 <87sf734ofv.wl-maz@kernel.org>
 <9f731870-ed36-d2e4-378b-f7fbf338ebd6@arm.com>
 <ZRPnpHwiRhrYwfSM@linux.dev>
 <87h6ndmixh.wl-maz@kernel.org>
 <0f99fa65-c8c1-5d5c-d9b0-5436b7592656@arm.com>
 <86ttr9nkey.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ttr9nkey.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:55:33PM +0100, Marc Zyngier wrote:
> On Mon, 02 Oct 2023 15:06:33 +0100,
> Kristina Martsenko <kristina.martsenko@arm.com> wrote:
> > On 29/09/2023 10:23, Marc Zyngier wrote:
> > > On Wed, 27 Sep 2023 09:28:20 +0100,
> > > Oliver Upton <oliver.upton@linux.dev> wrote:
> > >> On Mon, Sep 25, 2023 at 04:16:06PM +0100, Kristina Martsenko wrote:
> > >>>> What is the rationale for advancing the state machine? Shouldn't we
> > >>>> instead return to the guest and immediately get the SS exception,
> > >>>> which in turn gets reported to userspace? Is it because we rollback
> > >>>> the PC to a previous instruction?
> > >>>
> > >>> Yes, because we rollback the PC to the prologue instruction. We advance the
> > >>> state machine so that the SS exception is taken immediately upon returning to
> > >>> the guest at the prologue instruction. If we didn't advance it then we would
> > >>> return to the guest, execute the prologue instruction, and then take the SS
> > >>> exception on the middle instruction. Which would be surprising as userspace
> > >>> would see the middle and epilogue instructions executed multiple times but not
> > >>> the prologue.
> > >>
> > >> I agree with Kristina that taking the SS exception on the prologue is
> > >> likely the best course of action. Especially since it matches the
> > >> behavior of single-stepping an EL0 MOPS sequence with an intervening CPU
> > >> migration.
> > >>
> > >> This behavior might throw an EL1 that single-steps itself for a loop,
> > >> but I think it is impossible for a hypervisor to hide the consequences
> > >> of vCPU migration with MOPS in the first place.
> > >>
> > >> Marc, I'm guessing you were most concerned about the former case where
> > >> the VMM was debugging the guest. Is there something you're concerned
> > >> about I missed?
> > > 
> > > My concern is not only the VMM, but any userspace that perform
> > > single-stepping. Imagine the debugger tracks PC by itself, and simply
> > > increments it by 4 on a non-branch, non-fault instruction.
> > > 
> > > Move the vcpu or the userspace around, rewind PC, and now the debugger
> > > is out of whack with what is executing. While I agree that there is
> > > not much a hypervisor can do about that, I'm a bit worried that we are
> > > going to break existing SW with this.
> > > 
> > > Now the obvious solution is "don't do that"...
> > 
> > If the debugger can handle the PC changing on branching or faulting
> > instructions, then why can't it handle it on MOPS instructions? Wouldn't
> > such a debugger need to be updated any time the architecture adds new
> > branching or faulting instructions? What's different here?
> 
> What is different is that we *go back* in the instruction stream,
> which is a first. I'm not saying that the debugger I describe above
> would be a very clever piece of SW, quite the opposite. But the way
> the architecture works results in some interesting side-effects, and
> I'm willing to bet that some SW will break (rr?).

The way the architecture works, either with or without Kristina's
single-step change, a debugger would get confused. At least for EL0, I
find the proposed (well, upstreamed) approach more predictable - it
always restarts from the prologue in case of migration between CPUs with
different MOPS implementation (which is not just theoretical AFAIK).
It's more like these three instructions are a bigger CISC one ;) (though
the CPU can step through its parts).

A more transparent approach would have been to fully emulate the
instructions in the kernel and advance the PC as expected but I don't
think that's even possible. An implementation may decide to leave some
bytes to be copied by the epilogue but we can't know that in software,
it's a microarchitecture thing.

There is the case of EL1 debugging itself (kgdb) and it triggers a MOPS
exception to EL2. It would look weird for the guest but I guess the only
other option is to disable MCE2 and let EL1 handle the mismatch MOPS
option itself (assuming it knows how to; it should be fine for Linux). I
think I still prefer Kristina's proposal for KVM as more generic, with
the downside of breaking less usual cases like the kernel
single-stepping itself.

-- 
Catalin
