Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FA78E038
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjH3THW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245215AbjH3OuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:50:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49228FF;
        Wed, 30 Aug 2023 07:50:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFF72F4;
        Wed, 30 Aug 2023 07:50:41 -0700 (PDT)
Received: from bogus (unknown [10.57.36.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E910F3F64C;
        Wed, 30 Aug 2023 07:49:59 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:49:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oza Pawandeep <quic_poza@quicinc.com>, catalin.marinas@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, will@kernel.org,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230830144902.z4om5ltsmo4c6ij3@bogus>
References: <20230829201101.3330337-1-quic_poza@quicinc.com>
 <a4811a5e1df589573a27771749a68d34@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4811a5e1df589573a27771749a68d34@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:07:35PM +0100, Marc Zyngier wrote:
> On 2023-08-29 21:11, Oza Pawandeep wrote:
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
> 
> Isn't that what should be exposed by GTDT when ACPI_GTDT_ALWAYS_ON
> is set on the relevant interrupt and EL? The arch timer already
> deals with that.
> 
> Why do we need anything else?
> 

OK, let me try to write down my understanding here:

1. DT -> "always-on" property in the timer device node
   ACPI -> ACPI_GTDT_ALWAYS_ON flags in GDTD table

  The above 2 indicates if the timer is always on or will it stop in
  (deeper) lower idle states. This flag is used in the driver to set the
  clock source feature appropriate so that this clock source can be
  selected as broadcast timer or not.

2. DT-> "local-timer-stop" property in each idle state
   ACPI -> Core context Lost and other flags as shown above in each _LPI

   These above are used to indicate if the timer is stopped(in case of DT)
   and other contexts (only in ACPI though not used in the kernel) are lost

Not sure why the information was not used in both place(both with DT and
ACPI). One of the discussion I can remember for ACPI was to ensure the
flags can be set appropriately if the context was saved/restored by the
firmware and not related to the hardware power domain related property.

That said, I don't have a strong argument as why the other was not used
here in this case. Since I added LPI support, I used this LPI flag(probably
looking at the DT implementation) and this patch is just changing from
blanket whole flags check to just "Core context Lost" bit in the flag as
the other bits (GICR/GICD/Trace context loss) can be still set on this
platform where core context is not lost as the timers are always on.

Yes it is duplication of the data in the ACPI spec as well as DT. Not
sure if this needs to be fixed though(bit worried about backward
compatibility with broken firmware/DT)

--
Regards,
Sudeep
