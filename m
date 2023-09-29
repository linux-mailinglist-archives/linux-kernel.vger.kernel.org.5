Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993E7B3769
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjI2QBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2QBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:01:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13B9C139;
        Fri, 29 Sep 2023 09:01:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D9A91FB;
        Fri, 29 Sep 2023 09:01:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752033F59C;
        Fri, 29 Sep 2023 09:01:16 -0700 (PDT)
Date:   Fri, 29 Sep 2023 17:01:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Oza Pawandeep <quic_poza@quicinc.com>, catalin.marinas@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230929160114.eq5omxyauu27two7@bogus>
References: <20230918172140.2825357-1-quic_poza@quicinc.com>
 <20230929150459.GA30623@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929150459.GA30623@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:04:59PM +0100, Will Deacon wrote:
> On Mon, Sep 18, 2023 at 10:21:40AM -0700, Oza Pawandeep wrote:
> > Arm® Functional Fixed Hardware Specification defines LPI states,
> > which provide an architectural context loss flags field that can
> > be used to describe the context that might be lost when an LPI
> > state is entered.
> > 
> > - Core context Lost
> >         - General purpose registers.
> >         - Floating point and SIMD registers.
> >         - System registers, include the System register based
> >         - generic timer for the core.
> >         - Debug register in the core power domain.
> >         - PMU registers in the core power domain.
> >         - Trace register in the core power domain.
> > - Trace context loss
> > - GICR
> > - GICD
> > 
> > Qualcomm's custom CPUs preserves the architectural state,
> > including keeping the power domain for local timers active.
> > when core is power gated, the local timers are sufficient to
> > wake the core up without needing broadcast timer.
> > 
> > The patch fixes the evaluation of cpuidle arch_flags, and moves only to
> > broadcast timer if core context lost is defined in ACPI LPI.
> > 
> > Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> > ---
> > 
> > Notes:
> >     Will/Catalin: Rafael has acked and he prefers to take it via arm64 tree
> > 
> > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > index 4d537d56eb84..269d21209723 100644
> > --- a/arch/arm64/include/asm/acpi.h
> > +++ b/arch/arm64/include/asm/acpi.h
> > @@ -9,6 +9,7 @@
> >  #ifndef _ASM_ACPI_H
> >  #define _ASM_ACPI_H
> >  
> > +#include <linux/cpuidle.h>
> >  #include <linux/efi.h>
> >  #include <linux/memblock.h>
> >  #include <linux/psci.h>
> > @@ -44,6 +45,23 @@
> >  
> >  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
> >  	trbe_interrupt) + sizeof(u16))
> > +/*
> > + * Arm® Functional Fixed Hardware Specification Version 1.2.
> > + * Table 2: Arm Architecture context loss flags
> > + */
> > +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> > +
> > +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
> > +							unsigned int *sflags)
> 
> Why can't this just be 'static inline'?
> 
> > +{
> > +	if (arch_flags & CPUIDLE_CORE_CTXT)
> > +		*sflags |= CPUIDLE_FLAG_TIMER_STOP;
> > +}
> > +#define arch_update_idle_state_flags _arch_update_idle_state_flags
> 
> Usually, the function and the macro have the same name for this pattern,
> so I think it would be more consistent to drop the leading underscore
> from the C function name.
>

Sorry that's me telling him looking at some other example I think. I don't
have a strong opinion, just referred examples doing this way I guess.

Oza, please check it to as it was before I requested this.

--
Regards,
Sudeep
