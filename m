Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C97E0E9D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjKDJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjKDJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:35:04 -0400
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42038D51
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:35:00 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1qzD3H-005Hsg-R6; Sat, 04 Nov 2023 09:34:48 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1qzD3C-00AsqC-1V;
        Sat, 04 Nov 2023 09:34:47 +0000
Message-ID: <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
Date:   Sat, 4 Nov 2023 09:34:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
To:     Nadav Amit <nadav.amit@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
Content-Language: en-US
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2023 09:25, Nadav Amit wrote:
> I was reading (again) the x86 C macro of “alternative()” and I was a bit
> surprised it does clobber the flags (“cc”) as a precaution.
> 
>    #define alternative(oldinstr, newinstr, ft_flags) \
> 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
> 
> Actually there seems to be only one instance of problematic cases - in um/32-bit:
> 
>    #define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
>    #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
>    #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
> 
> Presumably, if XMM or XMM2 are not supported, there would be instances where addl
> would be able to change eflags arithmetic flags without the compiler being aware
> of it.
> 
> As it only affects 32-bit Linux UM - I don’t easily have an environment to test
> the fix. An alternative (word-pun unintended) is to add “cc” as a precaution
> to the alternative macro.
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

Application alternatives in um is presently a NOP. It always uses the 
"blunt and heavy instrument" - the most conservative option.

It is on the TODO list.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

