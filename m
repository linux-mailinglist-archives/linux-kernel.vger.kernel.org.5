Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7C27C008F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjJJPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjJJPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:43:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA9F93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:43:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D059CC15;
        Tue, 10 Oct 2023 08:44:34 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CA503F7A6;
        Tue, 10 Oct 2023 08:43:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:43:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, wanghuiqiang@huawei.com,
        wangwudi@hisilicon.com, guohanjun@huawei.com,
        yangyicong@hisilicon.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
Message-ID: <ZSVxNanrFunWZLNm@FVFF77S0Q05N.cambridge.arm.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010123033.23258-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 08:30:30PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> HiSilicon system timer is a memory mapped platform timer compatible with
> the arm's generic timer specification. The timer supports both SPI and
> LPI interrupt and can be enumerated through ACPI DSDT table. Since the
> timer is fully compatible with the spec, it can reuse most codes of the
> arm_arch_timer driver. However since the arm_arch_timer driver only
> supports GTDT and SPI interrupt, this series support the HiSilicon system
> timer by:
> 
> - refactor some of the arm_arch_timer codes and export the function to
>   register a arch memory timer by other drivers
> - retrieve the IO memory and interrupt resource through DSDT in a separate
>   driver, then setup and register the clockevent device reuse the arm_arch_timer
>   function
> 
> Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).

This seems like an oversight; there *should* be a generic way of describing
this, and I've poked our BSA and ACPI architects to figure out how this is
supposed to work. The lack of a way to do that seems like a major oversight and
something that needs to be solved.

I'll try to get back to you shortly on that.

Regardless of that, I do not think this should be a separate driver, and I'm
very much not keen on having vendor-specific companion drivers like this. Using
LPIs isn't specific to HiSilicon, and this should be entirely common (and if we
need a DSDT device, should use a common HID too).

Thanks,
Mark.

> 
> Yicong Yang (3):
>   clocksource/drivers/arm_arch_timer: Split the function of
>     __arch_timer_setup()
>   clocksource/drivers/arm_arch_timer: Extend and export
>     arch_timer_mem_register()
>   clocksource/drivers: Add HiSilicon system timer driver
> 
>  drivers/clocksource/Kconfig          |  10 +++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/arm_arch_timer.c | 123 +++++++++++++++------------
>  drivers/clocksource/timer-hisi-sys.c |  68 +++++++++++++++
>  include/clocksource/arm_arch_timer.h |   2 +
>  5 files changed, 148 insertions(+), 56 deletions(-)
>  create mode 100644 drivers/clocksource/timer-hisi-sys.c
> 
> -- 
> 2.24.0
> 
