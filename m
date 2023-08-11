Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8D778DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjHKLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:39:23 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372FE26A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:39:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 403C160002;
        Fri, 11 Aug 2023 11:39:16 +0000 (UTC)
Message-ID: <dff5c443-bebf-9bd9-af1c-85ebfb7c2aec@ghiti.fr>
Date:   Fri, 11 Aug 2023 13:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -fixes] riscv: uaccess: Return the number of bytes
 effectively copied
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20230811110304.1613032-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230811110304.1613032-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 13:03, Alexandre Ghiti wrote:
> It was reported that the riscv kernel hangs while executing the test
> in [1].
>
> Indeed, the test hangs when trying to write a buffer to a file. The
> problem is that the riscv implementation of raw_copy_from_user() does not
> return the number of bytes written when an exception happens and is fixed
> up.


I'll respin another version as the changelog and the title are 
incorrect: the uaccess routines should not return the number of bytes 
copied but actually the number of bytes not copied (this is what this 
patch implements).

I'll wait for feedbacks before doing so!

Sorry about that!

Alex


>
> generic_perform_write() pre-faults the user pages and bails out if nothing
> can be written, otherwise it will access the userspace buffer: here the
> riscv implementation keeps returning it was not able to copy any byte
> though the pre-faulting indicates otherwise. So generic_perform_write()
> keeps retrying to access the user memory and ends up in an infinite
> loop.
>
> Note that before the commit mentioned in [1] that introduced this
> regression, it worked because generic_perform_write() would bail out if
> only one byte could not be written.
>
> So fix this by returning the number of bytes effectively written in
> __asm_copy_[to|from]_user() and __clear_user(), as it is expected.
>
> [1] https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/
>
> Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
> Reported-by: Bo YU <tsu.yubo@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/#t
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Closes: https://lore.kernel.org/linux-riscv/ZNOnCakhwIeue3yr@aurel32.net/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   arch/riscv/lib/uaccess.S | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index ec486e5369d9..09b47ebacf2e 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -17,8 +17,11 @@ ENTRY(__asm_copy_from_user)
>   	li t6, SR_SUM
>   	csrs CSR_STATUS, t6
>   
> -	/* Save for return value */
> -	mv	t5, a2
> +	/*
> +	 * Save the terminal address which will be used to compute the number
> +	 * of bytes copied in case of a fixup exception.
> +	 */
> +	add	t5, a0, a2
>   
>   	/*
>   	 * Register allocation for code below:
> @@ -176,7 +179,7 @@ ENTRY(__asm_copy_from_user)
>   10:
>   	/* Disable access to user memory */
>   	csrc CSR_STATUS, t6
> -	mv a0, t5
> +	sub a0, t5, a0
>   	ret
>   ENDPROC(__asm_copy_to_user)
>   ENDPROC(__asm_copy_from_user)
> @@ -228,7 +231,7 @@ ENTRY(__clear_user)
>   11:
>   	/* Disable access to user memory */
>   	csrc CSR_STATUS, t6
> -	mv a0, a1
> +	sub a0, a3, a0
>   	ret
>   ENDPROC(__clear_user)
>   EXPORT_SYMBOL(__clear_user)
