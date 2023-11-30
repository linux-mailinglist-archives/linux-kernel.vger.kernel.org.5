Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816357FEE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjK3MIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbjK3MIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:08:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18525C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fXPMZud/4qMKPZCD7uWLEjX+yvZbhSmy6NLzEdFPQkA=; b=ZSYC1tpYLTtE4qOg8/FfymSkpL
        e3ngl7iO9PpO5TBjDvQjEfHqq1bQOJSZjmoW7rTKupa7R4vbm3KctCoEbXRCCldsfXih8af2wuvqQ
        CG2GoVD/PThQRAa/qZao4y2j5zgsrBrkdvJDd4ys06LGpYisCKI4g7D7FDGBVyHNjcQTR80P2IEAp
        BTX9e6ihNAg6ZAgvcMweGshSjGvpbe97hJQsNOXD3xtOosyLMxWEnTPoWzVVxpMUFFsPmyIsbqUbs
        5nwNU581/SMHxDHtdkRiojqudN9qyQEZNZ/S96OokGz0puo8MTXN86ZnmSNHein+v/xyBwzvSyp9z
        bAOmWO5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8fqK-00EQ0c-EH; Thu, 30 Nov 2023 12:08:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6E3F300293; Thu, 30 Nov 2023 13:08:31 +0100 (CET)
Date:   Thu, 30 Nov 2023 13:08:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231130120831.GB20153@noisy.programming.kicks-ass.net>
References: <20231130120552.6735-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130120552.6735-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:05:52PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Having KASLR enabled makes debugging a kernel completely useless because
> virtual addresses are not stable, leading to people poking at kernel
> internals to have to go and rebuild with RANDOMIZE_BASE=off.
> 
> Just disable it on debugging builds where it is not needed anyway.

Works for me, but I have "nokaslr no_hash_pointers" on all my machines
by now. It goes right along with "debug ignore_loglevel
sysrq_always_enabled earlyprintk=serial,ttyS0,115200" :-)

> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c456c9b1fc7c..da94354b1b75 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2159,7 +2159,7 @@ config RELOCATABLE
>  
>  config RANDOMIZE_BASE
>  	bool "Randomize the address of the kernel image (KASLR)"
> -	depends on RELOCATABLE
> +	depends on RELOCATABLE && !DEBUG_KERNEL
>  	default y
>  	help
>  	  In support of Kernel Address Space Layout Randomization (KASLR),
> -- 
> 2.42.0.rc0.25.ga82fb66fed25
> 
