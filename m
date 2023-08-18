Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76FA78126C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379211AbjHRR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379349AbjHRR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4FA4239;
        Fri, 18 Aug 2023 10:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4103D636C6;
        Fri, 18 Aug 2023 17:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADDDC433C8;
        Fri, 18 Aug 2023 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692381389;
        bh=/Rf58M8gtyESv/VVjU+NzYwrlirZy3Vk0Jr0DlEJR3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNRfNZ+obfwQM8FVxLCzcEqhcZvOovTgVaaFwCzQMAZYVRwSETaREr60zfegxA94w
         LljW9Ef56+j3Hg3tCrMo3brpmIUO4DKLBSESIiuPlGK7/HSA6F5VLlisFXr5WrJnQP
         P7AcHo/+xxbVegNS1DM3o7AiJRi9ryxraCKa3UnktBOSD43E9j1bZ6qerKwSwzNZNb
         MA1GpMLPtx8G+0w2XdtNizsc4DH5cCmI1TesdUHtHKXPoF8CgXfOpcqxcTs3ZoKalK
         9/MTCTut4LoVlzj7CKoLdWBibAapHWhz9KKY7vhhjFiUMvokRfLiWvr2qkaFgXrzYO
         7MsM1Y2epIYXw==
Date:   Fri, 18 Aug 2023 18:56:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 - RESEND 00/10] arm64/perf: Enable branch stack
 sampling
Message-ID: <20230818175623.GA16509@willie-the-truck>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230731130538.GA24881@willie-the-truck>
 <366bcaff-3c54-0c4d-633f-b6ef37c4e3f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366bcaff-3c54-0c4d-633f-b6ef37c4e3f4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 08:42:56AM +0530, Anshuman Khandual wrote:
> On 7/31/23 18:35, Will Deacon wrote:
> > I had a go at reviewing this series and, aside from the macro issue I've
> > already pointed out, I really struggled with the way that you've put the
> > series together:
> > 
> >   - You incrementally introduce dead code, forcing the reviewer to keep
> >     previous patches in their head awaiting for a caller to come along
> >     later.
> 
> My apologies for the delayed response on this particular thread.

It's ok, I'm in no rush to merge it.

> Another way of looking at this would be to prepare existing infrastructure
> ready for an upcoming implementation which requires them later. This helps
> avoid doing all the changes together in a single code block/patch, making
> the entire function addition a giant monolith ?

I'm not after another way of looking at it, I'm telling you that the way
you have structured this is needlessly difficult to review. Yes, we often
split large patches into incremental changes, but that doesn't mean that
breaking a driver up into pieces of dead code and dummy type definitions
is useful. Look at how I structured the original SPE driver for example:

https://lore.kernel.org/all/1507811438-2267-1-git-send-email-will.deacon@arm.com/

The driver code itself lives entirely in patch 7, with the earlier patches
adding self-contained core functionality on which the driver depends. I
didn't add an empty 'struct arm_spe_pmu' did I? This isn't rocket science.

> Don't we allow patch series to build on functions and structures, which are
> dead at the beginning, before enabling the entire function with a new config
> selectable right at the end ? The only difference here is, these are changes
> to various structures without their corresponding utilization some where in
> the patch but the real question here would be - is this way of organizing the
> patch series not allowed as per the kernel coding standards or guidelines ?
> 
> Regardless, if you prefer the suggested style for the series, I could switch
> to it.

Please don't imply that I'm being difficult with an unusual reviewer
preference for how this should be structured. Ask any of your colleagues in
the Arm kernel team and I suspect you'll hear similar concerns to mine.
As I said before, try putting yourself in the shoes of the reviewer and
you'll soon see how needlessly difficult you're making things.

> >     Example: Patch 4 literally just adds a new struct to the kernel.
> 
> Which again follows the same principle as explained above, and Mark had acked
> that patch earlier. I had assumed that validated the principle about prior
> infrastructure building based patch series organization.

I don't think an ack validates any principles about anything.

> >   - You change arch/arm/, where this driver shouldn't even be _compiled_
> >     despite adding CONFIG_ARM64_BRBE.
> 
> These stubs are necessary to protect PMU drivers built on arm32 which share
> basic branch record processing abstraction at ARMV8 PMU level. It compiles
> successfully both on arm32 and arm64 platforms with these changes. Subject
> line for this patch clearly mentions that as well.

But they shouldn't be needed. When CONFIG_ARM64_BRBE is not selected, no
branch record processing functions should be needed, empty or otherwise.
The callers should not exist in the first place (i.e. the empty definitions
should live in the core driver code, not in the arch header, or the calling
code should not be compiled at all).

> arm64/perf: Add branch stack support in ARMV8 PMU
> 
> This is adding abstraction for branch stack support, not the implementation.
> This actual implementation will come in the driver and gets enabled via the
> new config CONFIG_ARM64_BRBE.
> 
> > 
> >     Example: Patch 5 adds some BRBE stubs to
> >              arch/arm/include/asm/arm_pmuv3.h
> 
> Those are not BRBE stubs. 

Oh, come off it. You literally have a useless comment:

/* BRBE stubs */

which is apparently even more useless than I thought. Now, can we stop
wasting time arguing about which level of abstraction you think these
are at and start focussing on removing them, please?

> Instead those are branch records processing stubs
> which is a higher abstraction layer at ARMV8 PMU level, before getting down
> into arm64 specific branch records implementation via FEAT_BRBE enabled in
> a subsequent driver patch.
> 
> armv8_pmu driver is shared for arm32 and arm64. The patch is adding generic
> branch record stubs for both architectures, ensuring the armv8_pmu continues
> to be built successfully, and finally adds the arm64 implementation with
> FEAT_BRBE in the following patches.
> 
> > 
> >   - You undo/rework code that was introduced earlier in the series
> > 
> >     Example: armv8pmu_branch_read() is introduced as a useless stub in
> >              patch 5, rewritten in patch 6 and then rewritten again in
> > 	     patch 10. Why should I waste time reviewing three versions
> > 	     of this function?
> 
> [PATCH 5/10] adds callback for the branch records processing abstraction at
> ARMV8 PMU level, without an implementation any where. The ARMV8 PMUV3 based
> arm64 real implementation gets added later on via the BRBE driver, enabled
> with new CONFIG_ARM64_BRBE.
> 
> armv8pmu_branch_read() is present at all these places.
> 
> 1. arch/arm/include/asm/arm_pmuv3.h:	Stub to protect the arm32 build
> 2. arch/arm64/include/asm/perf_event.h:	Default stub without CONFIG_ARM64_BRBE
> 3. arch/arm64/include/asm/perf_event.h:	Declaration with CONFIG_ARM64_BRBE
> 4. drivers/perf/arm_brbe.c:		Definition with CONFIG_ARM64_BRBE
> 5. drivers/perf/arm_pmuv3.c:		Actual call site during PMU IRQ
> 
> armv8pmu_branch_read()
> 
> - Gets added in [PATCH 5] as branch records stub without an implementation
> - Gets defined in [PATCH 6] in the BRBE driver (via CONFIG_ARM64_BRBE)
> - Gets re-defined in [PATCH 10] where the new stitching gets implemented
> 
> Patch 6 added basic BRBE functionality. But patch 10 adds the necessary logic
> to stitch cached records to provide the maximum records possible without loss
> of continuity. I kept it separate to keep the complexity away. But I understand
> we could fold it in to single patch 6.

I don't know what you're trying to say here, but you seem to be reiterating
my point that you're adding armv8pmu_branch_read() three times during the
patch series.

Cutting to the main part of your email:

> > So, please, can you post a v14 which:
> > 
> >   1. Fixes the broken register access macros>
> 
> Already fixed.

Thank you, and what a horrifying assembler/compiler divergence that turned
out to be!

> > >   2. Adds some meaningful tests at the end of the series
> 
> We already have some branch stack sampling tests for perf subsystem.
> 
> tools/perf/tests/shell/test_brstack.sh
> 
> James Clark is also trying to get some BRBE specific tests added there.
> 
> https://gitlab.arm.com/linux-arm/linux-jc/-/commit/3a7ddce70c2daadb63fcc511de0a89055ca48b32
> 
> Are you looking for some thing more ? Any particular suggestions ?

That looks great, but afaict it's 8 months old and hasn't been posted to the
mailing list. Did I miss it? Why isn't it part of this series?

> >   3. Squashes the new driver code (i.e. at least everything in
> >      arm_brbe.c and possibly just everything under drivers/perf/) down
> >      into a single patch
> 
> Please find the code change stats in drivers/perf/ directory for your reference.
> 
>  drivers/perf/arm_brbe.c             | 716 ++++++++++++++++++++++++++++
>  drivers/perf/arm_brbe.h             | 270 +++++++++++
>  drivers/perf/arm_pmu.c              |  12 +-
>  drivers/perf/arm_pmuv3.c            | 110 ++++-
> 
> Squashing drivers/perf/arm_brbe.c and drivers/perf/arm_brbe.h will blur these
> functions and fold them back into the base driver addition itself.

It's hard to know what to do with a diffstat, so I'll wait for v14 (but
please note that this is too late for 6.6 now).

> - Base BRBE implementation enabling perf branch stack sampling support
> - sched_task() saving off older branch records when task schedules out
> - PMU IRQ branch records management accommodating saved older branch records

Why would we want a driver that doesn't handle IRQs or context switching? I
don't think you gain anything by splitting the driver like this.

> In order to summerize the patch series re-organization again, V14 will contain
> the patches in order.
> 
> 1.  drivers: perf: arm_pmu: Add new sched_task() callback
> 2.  arm64/perf: Add BRBE registers and fields
> 3.  arm64/perf: Add branch stack support in struct arm_pmu
> 4.  arm64/perf: Add branch stack support in struct pmu_hw_events
> 5.  arm64/perf: Add branch stack support in ARMV8 PMU
> 6.  arm64/perf: Enable branch stack events via FEAT_BRBE
>  
> I am just wondering if both PATCH 3 and PATCH 4 should be folded into PATCH 5
> which adds the perf branch stack sampling abstraction at ARMV8 PMU level.

I can't tell from just the subjects, but patches 3-5 (and possibly 6)
sound like they should be the same patch?

But again, subject lines and diffstats aren't especially helpful.

Will
