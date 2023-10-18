Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B57CDC50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJRMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjJRMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:53:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22335127
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:52:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8AB02F4;
        Wed, 18 Oct 2023 05:53:39 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8B613F762;
        Wed, 18 Oct 2023 05:52:57 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:52:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 2/4] arm64/process: Make loading of 32bit processes
 depend on aarch32_enabled()
Message-ID: <ZS_VJ29tFbEwNHAS@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <a40565807874c9ca82d60c118225ee65fe668fcd.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40565807874c9ca82d60c118225ee65fe668fcd.1697614386.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:20PM +0200, Andrea della Porta wrote:
> Major aspect of Aarch32 emulation is the ability to load 32bit
> processes.
> That's currently decided (among others) by compat_elf_check_arch().
> 
> Make the macro use aarch32_enabled() to decide if Aarch32 compat is
> enabled before loading a 32bit process.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Why can't you make system_supports_32bit_el0() take the option into account
instead?

Mark.

> ---
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 657ea273c0f9..96832f1ec3ee 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -601,7 +601,7 @@ unsigned long arch_align_stack(unsigned long sp)
>  #ifdef CONFIG_COMPAT
>  int compat_elf_check_arch(const struct elf32_hdr *hdr)
>  {
> -	if (!system_supports_32bit_el0())
> +	if (!system_supports_32bit_el0() || !aarch32_enabled())
>  		return false;
>  
>  	if ((hdr)->e_machine != EM_ARM)
> -- 
> 2.35.3
> 
