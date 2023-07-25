Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29A760C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGYHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjGYHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:46:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21797;
        Tue, 25 Jul 2023 00:46:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7306D1BF20C;
        Tue, 25 Jul 2023 07:46:22 +0000 (UTC)
Message-ID: <aee383e3-0e62-716e-4b07-f7557d63cc74@ghiti.fr>
Date:   Tue, 25 Jul 2023 09:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
Content-Language: en-US
To:     Song Shuai <suagrfillet@gmail.com>, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
        anup@brainfault.org, robh@kernel.org, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230724100917.309061-1-suagrfillet@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,


On 24/07/2023 12:09, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
> from the physical start of the kernel to the actual start of the DRAM.
>
> The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].
>
> Export kernel_map.va_kernel_pa_offset in vmcoreinfo to help Crash translate
> the kernel virtual address correctly.
>
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/ [1]
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>   arch/riscv/kernel/crash_core.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> index b351a3c01355..55f1d7856b54 100644
> --- a/arch/riscv/kernel/crash_core.c
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -18,4 +18,6 @@ void arch_crash_save_vmcoreinfo(void)
>   	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>   #endif
>   	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
> +						kernel_map.va_kernel_pa_offset);
>   }


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for that and for the instructions on how to reproduce the problem 
BTW!

Alex


