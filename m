Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D9576972B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjGaNH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGaNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFED19A1;
        Mon, 31 Jul 2023 06:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D726114E;
        Mon, 31 Jul 2023 13:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6A9C433C8;
        Mon, 31 Jul 2023 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690808745;
        bh=ejuYroiiwipxR4dunI4bi/87YX/fRkCJNQkz4ShUrEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdpthuuNV3oDz82oelKQEMy3FCcBAH6sGGtWW+oTZYkLij06psSHvxUwaJsK3v3oz
         KXTsLnsJ0BJkq2p4wODCRZ0VRT0YgDjnfuKwDKyaYyTS1Pjro0359VKft6BMWu4jOe
         dEyEgrTjztThzGFkEcBbAQJTjqcdc5W/MbYL21a8jNBHeHUgbhtgy7ouymW4ppSF8e
         iGW2VGV2ADlulP16QKVh3HR33tmpLKkP9SiK+Ym2o0t/DMTlQaRK+8tBjDxxEprVUL
         MF2mpdpg0Zj2ltmsx0z+yr3V5bFzl4myj7GazGQSysvqsf96mon3ni5tMtEXJN3Vsh
         o4CjT6vyf9bHA==
Date:   Mon, 31 Jul 2023 14:05:39 +0100
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
Message-ID: <20230731130538.GA24881@willie-the-truck>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711082455.215983-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, Jul 11, 2023 at 01:54:45PM +0530, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.5-rc1.
> 
> Changes in V13:

I had a go at reviewing this series and, aside from the macro issue I've
already pointed out, I really struggled with the way that you've put the
series together:

  - You incrementally introduce dead code, forcing the reviewer to keep
    previous patches in their head awaiting for a caller to come along
    later.

    Example: Patch 4 literally just adds a new struct to the kernel.

  - You change arch/arm/, where this driver shouldn't even be _compiled_
    despite adding CONFIG_ARM64_BRBE.

    Example: Patch 5 adds some BRBE stubs to
             arch/arm/include/asm/arm_pmuv3.h

  - You undo/rework code that was introduced earlier in the series

    Example: armv8pmu_branch_read() is introduced as a useless stub in
             patch 5, rewritten in patch 6 and then rewritten again in
	     patch 10. Why should I waste time reviewing three versions
	     of this function?

  - You make unrelated cosmetic changes to the existing code inside
    patches adding new features.

    Example: Patch 5 randomly removes some comments from the existing
             code.

  - The commit messages are, at best, useless and err more on the side
    of nonsensical.

    Example: Look at patch 3:

    | This updates 'struct arm_pmu' for branch stack sampling support being added
    | later. This adds an element 'reg_trbidr' to capture BRBE attribute details.
    | These updates here will help in tracking any branch stack sampling support.
    |
    | This also enables perf branch stack sampling event on all 'struct arm pmu',
    | supporting the feature but after removing the current gate that blocks such
    | events unconditionally in armpmu_event_init(). Instead a quick probe can be
    | initiated via arm_pmu->has_branch_stack to ascertain the support.

    If I remove everything that isn't just describing the code, I'm left with:

    - 'reg_trbidr' captures BRBE attribute details
    - These updates here will help in tracking any branch stack sampling support.
    - perf branch stack sampling event is now enabled when it is supported
    - Probing is quick

    But crucial information is missing:

    * What is BRBE?
    * What is a BRBE attribute?
    * How are the details of an attribute captured?
    * How do these "updates" (which ones?) help in tracking branch stack sampling?
    * What is being tracked and why?
    * How quick is the probing and why do we care?
    * What is the perf branch stack sampling event and what does it mean
      to enable it? Does it offer something useful to the user?
    * Why do we want any of this?

(these examples are not intended to be an exhaustive list of things that
need fixing)

Overall, this makes the code needlessly difficult to review. However, I
don't reckon it's too much effort on your side to fix the things above.
You've been doing this for long enough (on the author and reviewer side)
that I hope you see what I'm getting at. If not, try reviewing your own
patches right before you hit 'git send-email'; I pretty much always find
a problem with my own code that way.

So, please, can you post a v14 which:

  1. Fixes the broken register access macros
  2. Adds some meaningful tests at the end of the series
  3. Squashes the new driver code (i.e. at least everything in
     arm_brbe.c and possibly just everything under drivers/perf/) down
     into a single patch
  4. Does any _necessary_ cleanup or refactoring at the start of the
     series, leaving out cosmetic stuff for now
  5. Rewrites the commit messages following the guidelines in
     submitting-patches.rst. You don't need to talk about specific C
     expressions; we have the code for that already and if it's doing
     something subtle then you can add a comment.
  6. Resolves the open CYCLES_COUNT issue from Yang and Suzuki

Cheers,

Will
