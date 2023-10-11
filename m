Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034037C505C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbjJKKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjJKKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:38:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD77394
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:38:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5035C1480;
        Wed, 11 Oct 2023 03:39:38 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33993F762;
        Wed, 11 Oct 2023 03:38:55 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:38:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jonathan.cameron@huawei.com, prime.zeng@huawei.com,
        wanghuiqiang@huawei.com, wangwudi@hisilicon.com,
        guohanjun@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
Message-ID: <ZSZ7OiySl1wcG3CD@FVFF77S0Q05N.cambridge.arm.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
 <874jiymo2l.wl-maz@kernel.org>
 <a170493f-cd9f-a0d9-432a-2ae07d18d429@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a170493f-cd9f-a0d9-432a-2ae07d18d429@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:10:11AM +0800, Yicong Yang wrote:
> On 2023/10/11 0:36, Marc Zyngier wrote:
> > On Tue, 10 Oct 2023 13:30:30 +0100,
> > Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> HiSilicon system timer is a memory mapped platform timer compatible with
> >> the arm's generic timer specification. The timer supports both SPI and
> >> LPI interrupt and can be enumerated through ACPI DSDT table. Since the
> >> timer is fully compatible with the spec, it can reuse most codes of the
> >> arm_arch_timer driver. However since the arm_arch_timer driver only
> >> supports GTDT and SPI interrupt, this series support the HiSilicon system
> >> timer by:
> >>
> >> - refactor some of the arm_arch_timer codes and export the function to
> >>   register a arch memory timer by other drivers
> >> - retrieve the IO memory and interrupt resource through DSDT in a separate
> >>   driver, then setup and register the clockevent device reuse the arm_arch_timer
> >>   function
> >>
> >> Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).
> > 
> > This strikes me as pretty odd. LPIs are, by definition, *edge*
> > triggered. The timer interrupt must be *level* triggered. So there
> > must be some bridge in the middle that is going to regenerate edges on
> > EOI, and that cannot be architectural.
> > 
> > What am I missing?
> 
> In our case, if the timer is working on LPI mode, it's not directly connected
> to the GIC. It'll be wired to hisi-mbigen irqchip which will send LPIs to the
> GIC.

In that case, the timerr itself isn't using an LPI: it's wired to a secondary
interrupt controller, and the secondary interrupt controller is using an LPI.

The BSA doesn't describe that as a permitted configuration.

I think there are two problems here:

(1) The BSA spec is wrong, and shouldn't say "or LPI" here as it simply doesn't
    make sense.

    I think this should be fixed by removing the "or LPI" wording form the BSA
    spec for this interrupt.

(2) This platform is not compatible with the BSA, and is not compatible with
    the existing ACPI bindings in the GTDT.

Do you actually need this wakeup timer?

Thanks,
Mark.
