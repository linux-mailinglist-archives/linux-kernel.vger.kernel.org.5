Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCC0811913
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjLMQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjLMQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:19:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713010B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:19:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2AC433C9;
        Wed, 13 Dec 2023 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484390;
        bh=rtYsdGUgzG4gShOq5eir9uSz6Dv02AOWRgbvbC1z6QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSNZEtlyKCT/FLY4w9ZppFBut3oFTo86KvXQ19A5ut2LSqARZgZyhF61vRtVNrlEe
         Ay6EDQ78iJiWMBryaP7r58sTbMMPPeFtYOwsHvf0y/xUOHdevS95ZXyDZ5996bVweU
         sv4KhhPsk0N6ZxNbb6aTXaRmvvfIxXMebINNc1JCdEbg3xS5+77zm0cfnfALLOjYaI
         LOX2IHnhNjki/2k4b+A3P3mcp4sjgIq92Q/94wAC7sdnVuHgtC7eESr3vtcaq3I9gA
         6uX/hRFS0gmB3XF6ZMoRq4x6IVDRMvD7vXlc24FhXwedhXTL2t+QN7yPIx4aLREPb6
         C/OnndWIpOX3Q==
Date:   Wed, 13 Dec 2023 16:19:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>, ardb@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 04/12] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <20231213161944.GA32062@willie-the-truck>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-5-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-5-samuel.holland@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:54:34PM -0800, Samuel Holland wrote:
> arm64 provides an equivalent to the common kernel-mode FPU API, but in a
> different header and using different function names. Add a wrapper
> header, and export CFLAGS adjustments as found in lib/raid6/Makefile.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/Makefile          |  9 ++++++++-
>  arch/arm64/include/asm/fpu.h | 17 +++++++++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/fpu.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..485ac389ac11 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -30,6 +30,7 @@ config ARM64
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
> +	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 9a2d3723cd0f..4a65f24c7998 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -36,7 +36,14 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
>  $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>  endif
>  
> -KBUILD_CFLAGS	+= -mgeneral-regs-only	\
> +# The GCC option -ffreestanding is required in order to compile code containing
> +# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
> +CC_FLAGS_FPU	:= -ffreestanding
> +# Enable <arm_neon.h>
> +CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
> +CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
> +
> +KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
>  		   $(compat_vdso) $(cc_has_k_constraint)
>  KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS	+= $(compat_vdso)

Can you use this to replace the same logic in arch/arm64/lib/Makefile,
like you do for arch/arm/?

Will
