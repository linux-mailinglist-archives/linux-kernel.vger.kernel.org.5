Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFC7604EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGYBwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYBwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:52:44 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BD1B3;
        Mon, 24 Jul 2023 18:52:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VoAl.6s_1690249956;
Received: from 30.221.109.71(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VoAl.6s_1690249956)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 09:52:37 +0800
Message-ID: <f452ad3e-c0cd-8d02-48af-f20497875b68@linux.alibaba.com>
Date:   Tue, 25 Jul 2023 09:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
To:     Song Shuai <suagrfillet@gmail.com>, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, robh@kernel.org,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230724100917.309061-1-suagrfillet@gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/24 下午6:09, Song Shuai 写道:
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
Reviewed-by: Xianting Tian  <xianting.tian@linux.alibaba.com>
