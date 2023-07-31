Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD2769C40
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGaQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjGaQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:22:40 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E688E78
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690820551; bh=KXu0pOSJ+Yi7H0N8jumb2xkFoohQyaUvR6lhW0va5Ts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZTlXul5QjkJDbwZKFvqqsa2YhpTRwjsyKvlrXBT9TrlOFnZdDUjvMZ4/katyWQ6/D
         htWKfeZ7hMQ/hnFhOI3nn+xCtHgsKjspOHeSq7YFP8agvzvgVdZonO1L3afJmNt6Bd
         bprSnmRBShnjws/v6MguTHhSyqC2sI7e6+c6vgtY=
Received: from [192.168.9.172] (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E063C600A6;
        Tue,  1 Aug 2023 00:22:30 +0800 (CST)
Message-ID: <94bd0300-a920-a0d7-244b-6caeba5fff26@xen0n.name>
Date:   Tue, 1 Aug 2023 00:22:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: Allow usage of LSX/LASX in the kernel
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230722072201.2677516-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230722072201.2677516-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 15:22, Huacai Chen wrote:
> Allow usage of LSX/LASX in the kernel by extending kernel_fpu_begin()
> and kernel_fpu_end().
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/kernel/kfpu.c | 55 +++++++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
> index 5c46ae8c6cac..ec5b28e570c9 100644
> --- a/arch/loongarch/kernel/kfpu.c
> +++ b/arch/loongarch/kernel/kfpu.c
> @@ -8,19 +8,40 @@
>   #include <asm/fpu.h>
>   #include <asm/smp.h>
>   
> +static unsigned int euen_mask = CSR_EUEN_FPEN;
> +
> +/*
> + * The critical section between kernel_fpu_begin() and kernel_fpu_end()
> + * is non-reentrant. It is the caller's responsibility to avoid reentrance.
> + * See drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c as an example.
> + */
>   static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +static DEFINE_PER_CPU(unsigned int, euen_current);
>   
>   void kernel_fpu_begin(void)
>   {
> +	unsigned int *euen_curr;
> +
>   	preempt_disable();
>   
>   	WARN_ON(this_cpu_read(in_kernel_fpu));
>   
>   	this_cpu_write(in_kernel_fpu, true);
> +	euen_curr = this_cpu_ptr(&euen_current);
>   
> -	if (!is_fpu_owner())
> -		enable_fpu();
> +	*euen_curr = csr_xchg32(euen_mask, euen_mask, LOONGARCH_CSR_EUEN);
> +
> +#ifdef CONFIG_CPU_HAS_LASX
> +	if (*euen_curr & CSR_EUEN_LASXEN)
> +		_save_lasx(&current->thread.fpu);
> +	else
> +#endif
> +#ifdef CONFIG_CPU_HAS_LSX
> +	if (*euen_curr & CSR_EUEN_LSXEN)
> +		_save_lsx(&current->thread.fpu);
>   	else
> +#endif
> +	if (*euen_curr & CSR_EUEN_FPEN)
>   		_save_fp(&current->thread.fpu);
>   
>   	write_fcsr(LOONGARCH_FCSR0, 0);
> @@ -29,15 +50,41 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin);
>   
>   void kernel_fpu_end(void)
>   {
> +	unsigned int *euen_curr;
> +
>   	WARN_ON(!this_cpu_read(in_kernel_fpu));
>   
> -	if (!is_fpu_owner())
> -		disable_fpu();
> +	euen_curr = this_cpu_ptr(&euen_current);
> +
> +#ifdef CONFIG_CPU_HAS_LASX
> +	if (*euen_curr & CSR_EUEN_LASXEN)
> +		_restore_lasx(&current->thread.fpu);
>   	else
> +#endif
> +#ifdef CONFIG_CPU_HAS_LSX
> +	if (*euen_curr & CSR_EUEN_LSXEN)
> +		_restore_lsx(&current->thread.fpu);
> +	else
> +#endif
> +	if (*euen_curr & CSR_EUEN_FPEN)
>   		_restore_fp(&current->thread.fpu);
>   
> +	*euen_curr = csr_xchg32(*euen_curr, euen_mask, LOONGARCH_CSR_EUEN);
> +
>   	this_cpu_write(in_kernel_fpu, false);
>   
>   	preempt_enable();
>   }
>   EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +
> +static int __init init_euen_mask(void)
> +{
> +	if (cpu_has_lsx)
> +		euen_mask |= CSR_EUEN_LSXEN;
> +
> +	if (cpu_has_lasx)
> +		euen_mask |= CSR_EUEN_LASXEN;
> +
> +	return 0;
> +}
> +arch_initcall(init_euen_mask);

I've stressed this code a bit with my RAID5/6 LASX patch applied, then 
running $(nproc) copies of vector workload while letting the kernel 
repeatedly scrub a RAID6 array created from a bunch of loop devices, and 
there wasn't signs of context corruption either side. Although I only 
tested for a few minutes (so a Tested-by isn't appropriate yet), the 
code LGTM nevertheless, so...

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

