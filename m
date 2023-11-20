Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408C97F213A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTXIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:08:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B51A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:08:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B7BC433C8;
        Mon, 20 Nov 2023 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700521699;
        bh=CFqoX8V2WNEiSzZISkGpjZgqDIO60dgqCnVyQdufY0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pm0ocCOuOM935pl00FZ7y8WqMAQHOpgOGaD6c9Umz3wSPv+b+ywRvOFVrGqJDsjpe
         MOsKExWGV46pb4wNHQhYNdmWdwFDRVCR/NvTlAfJC8ZM0zlAVG239yHgDJBfDTh0wJ
         5LibP1FfBpF5Cnazh/45hzIPRACn0/CDLcwOYP6Iqmd1SaJ5Oc2HzW07QFFy7Nslwn
         Tn0X8yTzXAP70Gn8/WJ9CKIXnxzSTXPbukl5EMSXBQ6uXbqxGX11uklzQfh/I/Hux8
         f4kJEYXAQR/Hsg36Qvqtp9TMUhuYYzAyQubKIN/oQJclZXgxyXYXTm0EuwEnbzWrhY
         YXmhg5H72w8Jw==
Date:   Mon, 20 Nov 2023 16:08:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     WANG Rui <wangrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Record pc instead of offset in la-abs
 relocation
Message-ID: <20231120230817.GA2116806@dev-arch.thelio-3990X>
References: <20231116130331.241395-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116130331.241395-1-wangrui@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On Thu, Nov 16, 2023 at 09:03:31PM +0800, WANG Rui wrote:
> To clarify, the previous version functioned flawlessly. However, it's
> worth noting that the LLVM's LoongArch backend currently lacks support
> for cross-section label calculations. With this patch, we enable the use
> of clang to compile relocatable kernels.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Thanks a lot for the patch! This fixes the CONFIG_RELOCATABLE build for
me as well.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Something I noticed while testing is that a kernel linked with ld.lld
does not boot while one linked with ld.bfd did. I think this might be
the same issue that Xuerui filed on our issue tracker but I figured I
would mention it in case not:
https://github.com/ClangBuiltLinux/linux/issues/1883

Cheers,
Nathan

> ---
>  arch/loongarch/include/asm/asmmacro.h | 3 +--
>  arch/loongarch/include/asm/setup.h    | 2 +-
>  arch/loongarch/kernel/relocate.c      | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
> index c9544f358c33..655db7d7a427 100644
> --- a/arch/loongarch/include/asm/asmmacro.h
> +++ b/arch/loongarch/include/asm/asmmacro.h
> @@ -609,8 +609,7 @@
>  	lu32i.d	\reg, 0
>  	lu52i.d	\reg, \reg, 0
>  	.pushsection ".la_abs", "aw", %progbits
> -	768:
> -	.dword	768b-766b
> +	.dword	766b
>  	.dword	\sym
>  	.popsection
>  #endif
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
> index a0bc159ce8bd..ee52fb1e9963 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -25,7 +25,7 @@ extern void set_merr_handler(unsigned long offset, void *addr, unsigned long len
>  #ifdef CONFIG_RELOCATABLE
>  
>  struct rela_la_abs {
> -	long offset;
> +	long pc;
>  	long symvalue;
>  };
>  
> diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
> index 6c3eff9af9fb..288b739ca88d 100644
> --- a/arch/loongarch/kernel/relocate.c
> +++ b/arch/loongarch/kernel/relocate.c
> @@ -52,7 +52,7 @@ static inline void __init relocate_absolute(long random_offset)
>  	for (p = begin; (void *)p < end; p++) {
>  		long v = p->symvalue;
>  		uint32_t lu12iw, ori, lu32id, lu52id;
> -		union loongarch_instruction *insn = (void *)p - p->offset;
> +		union loongarch_instruction *insn = (void *)p->pc;
>  
>  		lu12iw = (v >> 12) & 0xfffff;
>  		ori    = v & 0xfff;
> -- 
> 2.42.1
> 
> 
