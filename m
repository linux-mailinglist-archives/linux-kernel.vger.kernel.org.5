Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E897C4F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjJKJgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJKJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:36:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369FD91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:36:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2A13106F;
        Wed, 11 Oct 2023 02:37:18 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.93.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001133F762;
        Wed, 11 Oct 2023 02:36:36 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:36:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm
 after finalizing cpucaps
Message-ID: <ZSZsogqIgG863ucA@FVFF77S0Q05N>
References: <20230907133410.3817800-1-mark.rutland@arm.com>
 <a56ea45c-f1cb-4f9a-bfc9-d6af3282b13a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56ea45c-f1cb-4f9a-bfc9-d6af3282b13a@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Oct 11, 2023 at 10:30:39AM +0200, Daniel Lezcano wrote:
> On 07/09/2023 15:34, Mark Rutland wrote:
> > We attempt to initialize each CPU's arch_timer event stream in
> > arch_timer_evtstrm_enable(), which we call from the
> > arch_timer_starting_cpu() cpu hotplug callback which is registered early
> > in boot. As this is registered before we initialize the system cpucaps,
> > the test for ARM64_HAS_ECV will always be false for CPUs present at boot
> > time, and will only be taken into account for CPUs onlined late
> > (including those which are hotplugged out and in again).
> > 
> > Due to this, CPUs present and boot time may not use the intended divider
> > and scale factor to generate the event stream, and may differ from other
> > CPUs.
> > 
> > Correct this by only initializing the event stream after cpucaps have been
> > finalized, registering a separate CPU hotplug callback for the event stream
> > configuration. Since the caps must be finalized by this point, use
> > spus_have_final_cap() to verify this.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> 
> Applied thanks

This got folded into a larger series that we were hoping to take through the arm64 tree:

  https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-1-mark.rutland@arm.com/
  https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-2-mark.rutland@arm.com/

I think that won't conflict, since all that's changed is the commit text, but
it might be worth dropping this patch for now to avoid the risk of a conflict.

Thanks,
Mark.
