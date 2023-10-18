Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E097CDC46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:52:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61DAFA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:52:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289F92F4;
        Wed, 18 Oct 2023 05:52:54 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272B63F762;
        Wed, 18 Oct 2023 05:52:12 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:52:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement
 optional at boot
Message-ID: <ZS_U9pqhLJ83h5Ig@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
> Aarch32 compatibility mode is enabled at compile time through
> CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
> (for both processes and syscalls) be enabled at boot time using
> a kernel parameter. Also, it provides a mean for distributions 
> to set their own default without sacrificing compatibility support,
> that is users can override default behaviour through the kernel
> parameter.

Can you elaborate on *why* people want such a policy?

> *** Notes about syscall management ***
> VBAR_EL1 register, which holds the exception table address,
> is setup very early in the boot process, before parse_early_param().
> This means that it's not possible to access boot parameter before
> setting the register. Also, setting the aforementioned register
> for secondary cpus is done later in the boot flow.
> Several ways to work around this has been considered, among which:
> 
> * resetting VBAR_EL1 to point to one of two vector tables (the
>   former with 32-bit exceptions handler enabled and the latter
>   pointing to unhandled stub, just as if CONFIG_COMPAT is enabled)
>   depending on the proposed boot parameter. This has the disadvantage
>   to produce a somewhat messy patchset involving several lines,
>   has higher cognitive load since there are at least three places
>   where the register is getting changed (not near to each other),
>   and have implications on other code segments (namely kpti, kvm
>   and vdso), requiring special care.
> 
> * patching the vector table contents once the early param is available.
>   This has most of the implications of the previous option
>   (except maybe not impacting other code segments), plus it sounds
>   a little 'hackish'.
> 
> The chosen approach involves conditional executing 32-bit syscalls
> depending on the parameter value.

Why does the compat syscall path need to do anything?

On arm64 it's not possible to issue compat syscalls from a native 64-bit task.
If you prevent the loading of AArch32 binaries, none of the compat syscalls
will be reachable at all.

That's the proper way to implement this, and we already have logic for that as
part of the mismatched AArch32 support.

> This of course results in a little performance loss, but has the following
> advantages:

A performance loss for what relative to what?

How much of a performance loss?

Mark.

> * all the cons from previously explained alternatives are solved
> * users of 32-bit apps on 64-bit kernel are already suffering from
>   performance losses due to 32-bit apps not fully leveraging the 64-bit
>   processor, so they are already aware of this
> * users of 32-bit apps on 64-bit kernel are believed
>   to be a minority and most of the time there are sources available
>   to be recompiled for 64-bit as a workaround for better performance
> 
> It worth mentioning that users of 64-bit apps are, of course,
> unaffected.
> 
> Based on the work from Nikolay Borisov, see:
> Link: https://lkml.org/lkml/2023/6/23/387
> 
> Andrea della Porta (4):
>   arm64: Introduce aarch32_enabled()
>   arm64/process: Make loading of 32bit processes depend on
>     aarch32_enabled()
>   arm64/entry-common: Make Aarch32 syscalls' availability depend on
>     aarch32_enabled()
>   arm64: Make Aarch32 emulation boot time configurable
> 
>  .../admin-guide/kernel-parameters.txt         |  7 ++++
>  arch/arm64/Kconfig                            |  9 +++++
>  arch/arm64/include/asm/compat.h               | 12 +++++++
>  arch/arm64/kernel/entry-common.c              | 33 +++++++++++++++++--
>  arch/arm64/kernel/process.c                   |  2 +-
>  5 files changed, 59 insertions(+), 4 deletions(-)
> 
> -- 
> 2.35.3
> 
