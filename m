Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E17C696C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjJLJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjJLJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:24:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7B6F91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:24:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7DB13D5;
        Thu, 12 Oct 2023 02:25:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD6A3F762;
        Thu, 12 Oct 2023 02:24:49 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:24:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
Message-ID: <ZSe7XnMPOpIO-VIF@FVFF77S0Q05N>
References: <20231009075631.193208-1-anshuman.khandual@arm.com>
 <ffb41c00-1df8-e4bb-deff-c2d1cfb15ec0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb41c00-1df8-e4bb-deff-c2d1cfb15ec0@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:59:19AM +0100, James Clark wrote:
> On 09/10/2023 08:56, Anshuman Khandual wrote:
> > PMMIR_EL1 needs to be captured in 'armpmu->reg_pmmir', for all appropriate
> > PMU version implementations where the register is available and reading it
> > is valid . Hence checking for bus slot event presence is redundant and can
> > be dropped.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v6.6-rc5.
> >  
> >  drivers/perf/arm_pmuv3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> > index 1e72b486c033..9fc1b6da5106 100644
> > --- a/drivers/perf/arm_pmuv3.c
> > +++ b/drivers/perf/arm_pmuv3.c
> > @@ -1129,7 +1129,7 @@ static void __armv8pmu_probe_pmu(void *info)
> >  			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> >  
> >  	/* store PMMIR register for sysfs */
> > -	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
> > +	if (is_pmuv3p4(pmuver))
> >  		cpu_pmu->reg_pmmir = read_pmmir();
> >  	else
> >  		cpu_pmu->reg_pmmir = 0;
> 
> 
> This does have the side effect of showing non-zero values in caps/slots
> even when the STALL_SLOT event isn't implemented. I think that's the
> scenario that the original commit (f5be3a61fd) was trying to avoid:
> 
>   /sys/bus/event_source/devices/armv8_pmuv3_0/caps/slots is exposed
>   under sysfs. [If] Both ARMv8.4-PMU and STALL_SLOT event are
>   implemented, it returns the slots from PMMIR_EL1, otherwise it will
>   return 0.

We check for the STALL_SLOT event becuase (at the time) the ARM ARM said:

| If STALL_SLOT is not implemented, it is IMPLEMENTATION DEFINED whether the
| PMMIR System registers are implemented.

... and this was necessary to avoid triggering an UNDEFINED exception if we
attempted to read PMMIR on a CPU which didn't actually implement it.

See: 

  https://lore.kernel.org/linux-arm-kernel/20200720101518.GA11516@willie-the-truck/
  https://lore.kernel.org/linux-arm-kernel/20200720105019.GA54220@C02TD0UTHF1T.local/
  https://lore.kernel.org/linux-arm-kernel/20200720105410.GD11516@willie-the-truck/

As I promised in that thread, I did raise that with our architects. According
to the bug I filed against the architecture, this was tightened such that
ARMv8.4-PMU gauaranteed the presence of PMMIR, and that should have changed
between the G.a and G.b releases of the ARM ARM.

Anshuman, can you go and check that the wording did chaange between G.a and G.b?

Assuming it did (and the wording in the latest J.a release is also fine),
please update the commit message to describe the history above.

Thanks,
Mark.
