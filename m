Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E387CD6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJRImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjJRImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:42:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFAFB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:42:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3488C433C7;
        Wed, 18 Oct 2023 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697618540;
        bh=OrfcLUwCJcdGJ8Ez94xY0DGx3glfePdaB3+hm47573c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOnHKduTHXeWOJNfkUsAPfv0A6Zvl01LjA27dhPOdPo6Swu8aMEHugieJAu3zqsYG
         /U0Fmc+KWiYv2sXAqRYoybeG4fYYnwJ2CG1hz0e3EZ4fstYmLCjKvbeRp3PZBbr7zF
         eRyw9JEdBgRbKCOOlgh4ILLAnKhDz94HDAfg1RUKRTDtfDCK+o4SdyvVKQ+HV6kcZl
         6WuMOgo55ldYB2VNan+DN/x8/rwmWPOtUQDFj5tVJxmCR/PD6dhF71ZXdk1xoCcMJp
         aT8cqFFE5kDfEn+ZNUBYJGKjgdVHS8m+AqD/n0Qd4axXGOcP2zuFhlxrIVnfHYKUm1
         uIc33Ay9WaWJg==
Date:   Wed, 18 Oct 2023 10:42:14 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: Re: [PATCH v3 5/5] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <ZS+aZnRFkGkJ+vK9@lpieralisi>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
 <20231006125929.48591-6-lpieralisi@kernel.org>
 <ZS6YAvoz3JApFtOo@lpieralisi>
 <86v8b5mc5v.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v8b5mc5v.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:44:28PM +0100, Marc Zyngier wrote:
> On Tue, 17 Oct 2023 15:19:46 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > On Fri, Oct 06, 2023 at 02:59:29PM +0200, Lorenzo Pieralisi wrote:
> > > The GIC architecture specification defines a set of registers
> > > for redistributors and ITSes that control the sharebility and
> > > cacheability attributes of redistributors/ITSes initiator ports
> > > on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
> > > GITS_BASER<n>).
> > > 
> > > Architecturally the GIC provides a means to drive shareability
> > > and cacheability attributes signals and related IWB/OWB/ISH barriers
> > > but it is not mandatory for designs to wire up the corresponding
> > > interconnect signals that control the cacheability/shareability
> > > of transactions.
> > > 
> > > Redistributors and ITSes interconnect ports can be connected to
> > > non-coherent interconnects that are not able to manage the
> > > shareability/cacheability attributes; this implicitly makes
> > > the redistributors and ITSes non-coherent observers.
> > > 
> > > So far, the GIC driver on probe executes a write to "probe" for
> > > the redistributors and ITSes registers shareability bitfields
> > > by writing a value (ie InnerShareable - the shareability domain the
> > > CPUs are in) and check it back to detect whether the value sticks or
> > > not; this hinges on a GIC programming model behaviour that predates the
> > > current specifications, that just define shareability bits as writeable
> > > but do not guarantee that writing certain shareability values
> > > enable the expected behaviour for the redistributors/ITSes
> > > memory interconnect ports.
> > > 
> > > To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> > > GICC/GICR/ITS subtables non-coherent flags to determine whether the
> > > respective components are non-coherent observers and force the shareability
> > > attributes to be programmed into the redistributors and ITSes registers.
> > > 
> > > An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> > > the MADT revision, in that it is essential to check the MADT revision
> > > before checking for flags that were added with MADT revision 7 so that
> > > if the kernel is booted with ACPI tables (MADT rev < 7) it skips parsing
> > > the newly added flags (that should be zeroed reserved values for MADT
> > > versions < 7 but they could turn out to be buggy and should be ignored).
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
> > >  drivers/irqchip/irq-gic-common.h |  8 ++++++++
> > >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> > >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> > >  include/linux/acpi.h             |  3 +++
> > >  5 files changed, 45 insertions(+)
> > 
> > Hi Marc,
> > 
> > just a quick note to ask if, from an ACPI binding POW
> 
> I guess you mean POV. POW has an entirely different meaning... :-/
> 
> > this patch and related approach make sense to you.
> > 
> > If so, we can start the process to get the ACPI changes drafted
> > in:
> > 
> > https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> > 
> > and deployed in this patch into the ACPI specs, I can log
> > an "ACK" in the tianocoreBZ entry above (we will be able to
> > rework the code as much as we want, this is just for the
> > bindings).
> 
> I'm OK with the overall shape of it. However, I wonder what the
> rationale is for spreading the redistributor property all over the map
> (in both GICC and GICR structures), while it could be set once and for
> all in the core MADT flags (32 bits, of which only one is in use).
> 
> It is bad enough that there are two ways of getting the GICR regions.
> Why can't the properties that apply to all of the be common?

I don't think we are allowed to add arch specific flags to the MADT
since those, supposedly, are cross-architecture (and the only one
defined is quite old, though x86 specific).

The reason behind spreading the property is the nature of GICC/GICR
subtables themselves - we wanted to apply flags only in subtables
relevant to the components in question.

We could try to add a global flag to the MADT but I would not be
surprised if the ECR would be rejected then for the reason I explained
above.

Thanks,
Lorenzo
