Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805B755F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGQJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967F10E5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92C4260FD9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114D7C433C8;
        Mon, 17 Jul 2023 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689585885;
        bh=1atNG0I8maT6hRW62zhhkxbn291UkuuKIfOiDyjE61I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9O7zFzYikarbXy0dAa1DjdyLZ5LDxqhTMQNW67MJ2+81gUFI62cpgJaDjYD/RyQc
         90iZtVqQXSs/XzigkyG5YEPkkDJct2qIlJKM8aBYt8e47sxcW4aMPB+3wGJVOJ2N3b
         QzbM7wRiPfy1qWaG0wiOgxrQpOkbaJdJQtiMR1pwglNFnJHwytFs2IEXfI6ukFhS+j
         QhfCEGpRV7ATIhAs90PQ7mNHlQQDle5+2FQFk+4rC9vjWyoEG5hHpjKPrD52c/wAyM
         ymi2hpnljZ8G/vdRaBOZ4Nqcr2N8OB+W9ruSt3H+C8XcBGHRiSzJFXN/2V04ZbySoU
         I3llDfXeXnGBQ==
Date:   Mon, 17 Jul 2023 10:24:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: enable dead code elimination
Message-ID: <20230717092439.GB7868@willie-the-truck>
References: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:07:39PM +0800, Kefeng Wang wrote:
> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing the
> user to enable dead code elimination. In order for this to work, ensure
> that we keep the necessary tables by annotating them with KEEP, also it
> requires further changes to linker script to KEEP some tables and wildcard
> compiler generated sections into the right place.
> 
> The following comparison is based 6.5-rc2 with defconfig,
> 
> $ ./scripts/bloat-o-meter vmlinux-base vmlinux-new
> add/remove: 3/1106 grow/shrink: 4102/6964 up/down: 35704/-99980 (-64276)
> Function                                     old     new   delta
> ...
> Total: Before=17888959, After=17824683, chg -0.36%
> 
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-44 (-44)
> Data                                         old     new   delta
> ...
> Total: Before=4820808, After=4820764, chg -0.00%
> 
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1096 (-1096)
> RO Data                                      old     new   delta
> ...
> Total: Before=5179123, After=5178027, chg -0.02%
> 
> $ size vmlinux-base vmlinux
>    text	   data	     bss      dec       hex	filename
> 25433734  15385766  630656  41450156  2787aac	vmlinux-base
> 24756738  15360870  629888  40747496  26dc1e8	vmlinux-new
> 
> Memory available after booting, saving 704k on qemu,
> base: 8084532K/8388608K
> new:  8085236K/8388608K

Is that a 0.009% improvement? Is it really worth the hassle?

x86 doesn't select this and risc-v had to turn it off for LLD, so it feels
like we're just creating a rod for our own back by selecting it.

Will

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig              | 1 +
>  arch/arm64/kernel/vmlinux.lds.S | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2511b30d0f6..73bb908ec62f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -148,6 +148,7 @@ config ARM64
>  	select GENERIC_VDSO_TIME_NS
>  	select HARDIRQS_SW_RESEND
>  	select HAS_IOPORT
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 3cd7e76cc562..bb4ce6cd6896 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -238,7 +238,7 @@ SECTIONS
>  	. = ALIGN(4);
>  	.altinstructions : {
>  		__alt_instructions = .;
> -		*(.altinstructions)
> +		KEEP(*(.altinstructions))
>  		__alt_instructions_end = .;
>  	}
>  
> @@ -258,8 +258,9 @@ SECTIONS
>  		INIT_CALLS
>  		CON_INITCALL
>  		INIT_RAM_FS
> -		*(.init.altinstructions .init.bss)	/* from the EFI stub */
> +		KEEP(*(.init.altinstructions .init.bss*))	/* from the EFI stub */
>  	}
> +
>  	.exit.data : {
>  		EXIT_DATA
>  	}
> -- 
> 2.27.0
> 
