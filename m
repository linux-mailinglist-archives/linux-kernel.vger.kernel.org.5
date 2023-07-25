Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07827760C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjGYIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGYIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:01:41 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CED9113
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:01:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B749E0008;
        Tue, 25 Jul 2023 08:01:34 +0000 (UTC)
Message-ID: <68b2b7d8-a826-cd4d-d083-1f1819eb5d76@ghiti.fr>
Date:   Tue, 25 Jul 2023 10:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: remove redundant mv instructions
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725053835.138910-1-namcaov@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230725053835.138910-1-namcaov@gmail.com>
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

Hi Nam,


On 25/07/2023 07:38, Nam Cao wrote:
> Some mv instructions were useful when first introduced to preserve a0 and
> a1 before function calls. However the code has changed and they are now
> redundant. Remove them.
>
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>   arch/riscv/kernel/head.S | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 11c3b94c4534..3710ea5d160f 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -289,10 +289,6 @@ clear_bss:
>   	blt a3, a4, clear_bss
>   clear_bss_done:
>   #endif
> -	/* Save hart ID and DTB physical address */
> -	mv s0, a0
> -	mv s1, a1
> -
>   	la a2, boot_cpu_hartid
>   	XIP_FIXUP_OFFSET a2
>   	REG_S a0, (a2)
> @@ -306,7 +302,7 @@ clear_bss_done:
>   	la a0, __dtb_start
>   	XIP_FIXUP_OFFSET a0
>   #else
> -	mv a0, s1
> +	mv a0, a1
>   #endif /* CONFIG_BUILTIN_DTB */
>   	call setup_vm
>   #ifdef CONFIG_MMU


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

