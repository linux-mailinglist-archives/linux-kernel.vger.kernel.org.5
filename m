Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6E75F8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGXNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGXNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:45:51 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACEB4200
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:43:45 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.4.179])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qNvpr-002awt-2z; Mon, 24 Jul 2023 14:42:51 +0100
Message-ID: <e75d0e92-1e6e-43c2-1935-00f22df5579d@codethink.co.uk>
Date:   Mon, 24 Jul 2023 14:42:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: Fix local irq restore when flags indicates irq
 disabled
Content-Language: en-GB
To:     "luxu.kernel" <luxujoy@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        luxu.kernel@bytedance.com
References: <20230724132736.124106-1-luxu.kernel@bytedance.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230724132736.124106-1-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 14:27, luxu.kernel wrote:
> When arch_local_irq_restore() is called with flags indicating irqs
> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> implementation based on csr_set() function only sets SR_IE bit of
> CSR_STATUS when SR_IE bit of flags is high and does nothing when
> SR_IE bit of flags is low.
> 
> This commit supplies csr clear operation when calling irq restore
> function with flags indicating irq disabled.
> 
> Signed-off-by: luxu.kernel <luxu.kernel@bytedance.com>

real-names are required for signoff

> ---
>   arch/riscv/include/asm/irqflags.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
> index 08d4d6a5b7e9..7c31fc3c3559 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
>   /* set interrupt enabled status */
>   static inline void arch_local_irq_restore(unsigned long flags)
>   {
> -	csr_set(CSR_STATUS, flags & SR_IE);
> +	if (flags & SR_IE)
> +		csr_set(CSR_STATUS, SR_IE);
> +	else
> +		csr_clear(CSR_STATUS, SR_IE);
>   }
>   
>   #endif /* _ASM_RISCV_IRQFLAGS_H */

I think this is correct, I wonder how long this has been going on
without anyone noticing?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

