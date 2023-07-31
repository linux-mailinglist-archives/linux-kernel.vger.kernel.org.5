Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE110769115
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGaJGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:06:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C3851980;
        Mon, 31 Jul 2023 02:06:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63E33D75;
        Mon, 31 Jul 2023 02:07:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.89.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929E73F59C;
        Mon, 31 Jul 2023 02:06:14 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:06:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 - RESEND 02/10] arm64/perf: Add BRBE registers and
 fields
Message-ID: <ZMd5gCOHqnGRc0Ja@FVFF77S0Q05N>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-3-anshuman.khandual@arm.com>
 <20230728162011.GA22050@willie-the-truck>
 <89ce4bc4-00c5-a763-3179-e1d3e9f198b7@arm.com>
 <937468a1-b325-7d05-8daf-765f911c9240@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937468a1-b325-7d05-8daf-765f911c9240@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 08:03:21AM +0530, Anshuman Khandual wrote:
> 
> 
> On 7/28/23 22:22, James Clark wrote:
> > 
> > 
> > On 28/07/2023 17:20, Will Deacon wrote:
> >> On Tue, Jul 11, 2023 at 01:54:47PM +0530, Anshuman Khandual wrote:
> >>> This adds BRBE related register definitions and various other related field
> >>> macros there in. These will be used subsequently in a BRBE driver which is
> >>> being added later on.
> >>>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Marc Zyngier <maz@kernel.org>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Tested-by: James Clark <james.clark@arm.com>
> >>> Reviewed-by: Mark Brown <broonie@kernel.org>
> >>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>> ---
> >>>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
> >>>  arch/arm64/tools/sysreg         | 158 ++++++++++++++++++++++++++++++++
> >>>  2 files changed, 261 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> >>> index b481935e9314..f95e30c13c8b 100644
> >>> --- a/arch/arm64/include/asm/sysreg.h
> >>> +++ b/arch/arm64/include/asm/sysreg.h
> >>> @@ -163,6 +163,109 @@
> >>>  #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
> >>>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
> >>>  
> >>> +#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
> >>> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
> >>> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))
> >>
> >> It's that time on a Friday but... aren't these macros busted? I think you
> >> need brackets before adding the offset, otherwise wouldn't, for example,
> >> target registers 0-15 all access info register 0 and __SYS_BRBTGT(16) would
> >> then start accessing source register 0?
> >>
> >> I'm surprised that the compiler doesn't warn about this, but even more
> >> surprised that you managed to test this.
> >>
> >> Please tell me I'm wrong!
> >>
> >> Will
> > 
> > No I think you are right, it is wrong. Luckily there is already an
> > extraneous bracket so you you can fix it by moving one a place down:
> > 
> >   sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 2))
> > 
> > It's interesting because the test [1] is doing quite a bit and looking
> > at the branch info, and that src and targets match up to function names.
> > I also manually looked at the branch buffers and didn't see anything
> > obviously wrong like things that looked like branch infos in the source
> > or target fields. Will have to take another look to see if it would be
> > possible for the test to catch this.
> > 
> > James
> > 
> > [1]:
> > https://gitlab.arm.com/linux-arm/linux-jc/-/commit/3a7ddce70c2daadb63fcc511de0a89055ca48b32
> 
> ((((n) & 0x10)) >> 2 + 2) ---> ((((n) & 0x10) >> 2) + 2)
> 
> The additional brackets are useful in explicitly telling the compiler but
> what it the compiler is just doing the right thing implicitly i.e computing
> the shifting operation before doing the offset addition.

No; that is not correct. In c, '+' has higher precedence than '>>'.

For 'a >> b + c' the compiler *must* treat that as 'a >> (b + c)', and not as
'(a >> b) + c'

That's trivial to test:

| [mark@gravadlaks:~]% cat shiftadd.c 
| #include <stdio.h>
| 
| unsigned long logshiftadd(unsigned long a,
|                           unsigned long b,
|                           unsigned long c)
| {
|         printf("%ld >> %ld + %ld is %ld\n",
|                a, b, c, a >> b + c);
| }
| 
| int main(int argc, char *argv)
| {
|         logshiftadd(0, 0, 0);
|         logshiftadd(0, 0, 1);
|         logshiftadd(0, 0, 2);
|         printf("\n");
|         logshiftadd(1024, 0, 0);
|         logshiftadd(1024, 0, 1);
|         logshiftadd(1024, 0, 2);
|         printf("\n");
|         logshiftadd(1024, 2, 0);
|         logshiftadd(1024, 2, 1);
|         logshiftadd(1024, 2, 2);
| 
|         return 0;
| }
| [mark@gravadlaks:~]% gcc shiftadd.c -o shiftadd
| [mark@gravadlaks:~]% ./shiftadd 
| 0 >> 0 + 0 is 0
| 0 >> 0 + 1 is 0
| 0 >> 0 + 2 is 0
| 
| 1024 >> 0 + 0 is 1024
| 1024 >> 0 + 1 is 512
| 1024 >> 0 + 2 is 256
| 
| 1024 >> 2 + 0 is 256
| 1024 >> 2 + 1 is 128
| 1024 >> 2 + 2 is 64

> During testing, all > those captured branch records looked alright.

I think we clearly need better testing here.

Thanks,
Mark.
