Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68396780442
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357477AbjHRDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357542AbjHRDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:13:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 492C530E1;
        Thu, 17 Aug 2023 20:13:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 664EDD75;
        Thu, 17 Aug 2023 20:13:44 -0700 (PDT)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 708173F762;
        Thu, 17 Aug 2023 20:12:59 -0700 (PDT)
Message-ID: <366bcaff-3c54-0c4d-633f-b6ef37c4e3f4@arm.com>
Date:   Fri, 18 Aug 2023 08:42:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V13 - RESEND 00/10] arm64/perf: Enable branch stack
 sampling
To:     Will Deacon <will@kernel.org>
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
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230731130538.GA24881@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20230731130538.GA24881@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 18:35, Will Deacon wrote:
> Hi Anshuman,

Hello Will,

My apologies for the delayed response on this particular thread.

> 
> On Tue, Jul 11, 2023 at 01:54:45PM +0530, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on 6.5-rc1.
>>
>> Changes in V13:
> 
> I had a go at reviewing this series and, aside from the macro issue I've
> already pointed out, I really struggled with the way that you've put the
> series together:
> 
>   - You incrementally introduce dead code, forcing the reviewer to keep
>     previous patches in their head awaiting for a caller to come along
>     later.

Another way of looking at this would be to prepare existing infrastructure
ready for an upcoming implementation which requires them later. This helps
avoid doing all the changes together in a single code block/patch, making
the entire function addition a giant monolith ?

Don't we allow patch series to build on functions and structures, which are
dead at the beginning, before enabling the entire function with a new config
selectable right at the end ? The only difference here is, these are changes
to various structures without their corresponding utilization some where in
the patch but the real question here would be - is this way of organizing the
patch series not allowed as per the kernel coding standards or guidelines ?

Regardless, if you prefer the suggested style for the series, I could switch
to it.

> 
>     Example: Patch 4 literally just adds a new struct to the kernel.

Which again follows the same principle as explained above, and Mark had acked
that patch earlier. I had assumed that validated the principle about prior
infrastructure building based patch series organization.

> 
>   - You change arch/arm/, where this driver shouldn't even be _compiled_
>     despite adding CONFIG_ARM64_BRBE.

These stubs are necessary to protect PMU drivers built on arm32 which share
basic branch record processing abstraction at ARMV8 PMU level. It compiles
successfully both on arm32 and arm64 platforms with these changes. Subject
line for this patch clearly mentions that as well.

arm64/perf: Add branch stack support in ARMV8 PMU

This is adding abstraction for branch stack support, not the implementation.
This actual implementation will come in the driver and gets enabled via the
new config CONFIG_ARM64_BRBE.

> 
>     Example: Patch 5 adds some BRBE stubs to
>              arch/arm/include/asm/arm_pmuv3.h

Those are not BRBE stubs. Instead those are branch records processing stubs
which is a higher abstraction layer at ARMV8 PMU level, before getting down
into arm64 specific branch records implementation via FEAT_BRBE enabled in
a subsequent driver patch.

armv8_pmu driver is shared for arm32 and arm64. The patch is adding generic
branch record stubs for both architectures, ensuring the armv8_pmu continues
to be built successfully, and finally adds the arm64 implementation with
FEAT_BRBE in the following patches.

> 
>   - You undo/rework code that was introduced earlier in the series
> 
>     Example: armv8pmu_branch_read() is introduced as a useless stub in
>              patch 5, rewritten in patch 6 and then rewritten again in
> 	     patch 10. Why should I waste time reviewing three versions
> 	     of this function?

[PATCH 5/10] adds callback for the branch records processing abstraction at
ARMV8 PMU level, without an implementation any where. The ARMV8 PMUV3 based
arm64 real implementation gets added later on via the BRBE driver, enabled
with new CONFIG_ARM64_BRBE.

armv8pmu_branch_read() is present at all these places.

1. arch/arm/include/asm/arm_pmuv3.h:	Stub to protect the arm32 build
2. arch/arm64/include/asm/perf_event.h:	Default stub without CONFIG_ARM64_BRBE
3. arch/arm64/include/asm/perf_event.h:	Declaration with CONFIG_ARM64_BRBE
4. drivers/perf/arm_brbe.c:		Definition with CONFIG_ARM64_BRBE
5. drivers/perf/arm_pmuv3.c:		Actual call site during PMU IRQ

armv8pmu_branch_read()

- Gets added in [PATCH 5] as branch records stub without an implementation
- Gets defined in [PATCH 6] in the BRBE driver (via CONFIG_ARM64_BRBE)
- Gets re-defined in [PATCH 10] where the new stitching gets implemented

Patch 6 added basic BRBE functionality. But patch 10 adds the necessary logic
to stitch cached records to provide the maximum records possible without loss
of continuity. I kept it separate to keep the complexity away. But I understand
we could fold it in to single patch 6.

> 
>   - You make unrelated cosmetic changes to the existing code inside
>     patches adding new features.
> 
>     Example: Patch 5 randomly removes some comments from the existing
>              code.

Mark had suggested to drop those comments earlier. I could still collect these
unrelated comments removal, on a pre-requisite patch, if that is better. Just
thought them to be too minor changes for a patch in itself.

https://lore.kernel.org/all/Y8AZXQJUO6h5mlgq@FVFF77S0Q05N/

Update: I have posted this cosmetic change as a separate patch which has been
picked up for next merge window.

https://lore.kernel.org/all/20230802090853.1190391-1-anshuman.khandual@arm.com/

> 
>   - The commit messages are, at best, useless and err more on the side
>     of nonsensical.
> 
>     Example: Look at patch 3:
> 
>     | This updates 'struct arm_pmu' for branch stack sampling support being added
>     | later. This adds an element 'reg_trbidr' to capture BRBE attribute details.
>     | These updates here will help in tracking any branch stack sampling support.
>     |
>     | This also enables perf branch stack sampling event on all 'struct arm pmu',
>     | supporting the feature but after removing the current gate that blocks such
>     | events unconditionally in armpmu_event_init(). Instead a quick probe can be
>     | initiated via arm_pmu->has_branch_stack to ascertain the support.
> 
>     If I remove everything that isn't just describing the code, I'm left with:
> 
>     - 'reg_trbidr' captures BRBE attribute details
>     - These updates here will help in tracking any branch stack sampling support.
>     - perf branch stack sampling event is now enabled when it is supported
>     - Probing is quick

I understand your concern here but this series has done many roundabouts, during
the course of its development including multiple rewrites for the same function.
Current 'reg_trbidr' construct was just added during V12. These high churns kept
on adding new problems each time. I will try, and update the commit message here
as suggested.

> 
>     But crucial information is missing:
> 
>     * What is BRBE?
>     * What is a BRBE attribute?

Just wondering - should this be part of cover-letter or in patch commit message ?

>     * How are the details of an attribute captured?
>     * How do these "updates" (which ones?) help in tracking branch stack sampling?
>     * What is being tracked and why?
>     * How quick is the probing and why do we care?
>     * What is the perf branch stack sampling event and what does it mean
>       to enable it? Does it offer something useful to the user?
>     * Why do we want any of this?

I will certainly be more careful in keeping these questions in mind while rewriting
the commit messages.

> 
> (these examples are not intended to be an exhaustive list of things that
> need fixing)

There has been a very small set of folks reviewing and testing the series, hence
the assumption that every one knows about the context was slowly slipping into
the commit messages as well. But I will keep this in mind while re-writing the
commit messages next time around.

>> Overall, this makes the code needlessly difficult to review. However, I
> don't reckon it's too much effort on your side to fix the things above.

Sure, will get on fixing these things as suggested.

> You've been doing this for long enough (on the author and reviewer side)
> that I hope you see what I'm getting at. If not, try reviewing your own
> patches right before you hit 'git send-email'; I pretty much always find
> a problem with my own code that way.

Thanks, I will try and incorporate your valuable suggestions going forward.

> 
> So, please, can you post a v14 which:
> 
>   1. Fixes the broken register access macros>

Already fixed.

> >   2. Adds some meaningful tests at the end of the series

We already have some branch stack sampling tests for perf subsystem.

tools/perf/tests/shell/test_brstack.sh

James Clark is also trying to get some BRBE specific tests added there.

https://gitlab.arm.com/linux-arm/linux-jc/-/commit/3a7ddce70c2daadb63fcc511de0a89055ca48b32

Are you looking for some thing more ? Any particular suggestions ?

>   3. Squashes the new driver code (i.e. at least everything in
>      arm_brbe.c and possibly just everything under drivers/perf/) down
>      into a single patch

Please find the code change stats in drivers/perf/ directory for your reference.

 drivers/perf/arm_brbe.c             | 716 ++++++++++++++++++++++++++++
 drivers/perf/arm_brbe.h             | 270 +++++++++++
 drivers/perf/arm_pmu.c              |  12 +-
 drivers/perf/arm_pmuv3.c            | 110 ++++-

Squashing drivers/perf/arm_brbe.c and drivers/perf/arm_brbe.h will blur these
functions and fold them back into the base driver addition itself.

- Base BRBE implementation enabling perf branch stack sampling support
- sched_task() saving off older branch records when task schedules out
- PMU IRQ branch records management accommodating saved older branch records

But sure, if that is something preferred, will try and fold them down into a
single patch. But will keep the higher level abstraction for branch records
processing at ARV8 PMU level (shared between arm32 and arm64) in a separate
patch before the BRBE based implementation.

>   4. Does any _necessary_ cleanup or refactoring at the start of the
>      series, leaving out cosmetic stuff for now

Sure, will send out a clean up patch dropping those comments first.

Update: Already sent that patch

https://lore.kernel.org/all/20230802090853.1190391-1-anshuman.khandual@arm.com/

>   5. Rewrites the commit messages following the guidelines in
>      submitting-patches.rst. You don't need to talk about specific C
>      expressions; we have the code for that already and if it's doing
>      something subtle then you can add a comment.

Sure, will try and improve the commit message as suggested.

>   6. Resolves the open CYCLES_COUNT issue from Yang and Suzuki

Already fixed.

In order to summerize the patch series re-organization again, V14 will contain
the patches in order.

1.  drivers: perf: arm_pmu: Add new sched_task() callback
2.  arm64/perf: Add BRBE registers and fields
3.  arm64/perf: Add branch stack support in struct arm_pmu
4.  arm64/perf: Add branch stack support in struct pmu_hw_events
5.  arm64/perf: Add branch stack support in ARMV8 PMU
6.  arm64/perf: Enable branch stack events via FEAT_BRBE
 
I am just wondering if both PATCH 3 and PATCH 4 should be folded into PATCH 5
which adds the perf branch stack sampling abstraction at ARMV8 PMU level.

- Anshuman
