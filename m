Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBF80CF75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbjLKPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjLKPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:25:19 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD11E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IwEWgbkoYJm7uABHz8pQkFOpv075TP+Bit3Au8JGFAk=; b=Syz6wYtlu/8QrxUdaACh7bWWG5
        qaTTRogpCDQJN/UuccLVi7i0CpMz1Q8OzvfsKC1JIR5KSrw771Df+Mc5WhvS89R0bEQ9xFH/Qv2yi
        SIjZMxjrucuvQQnc2zPmFUk26DLlv9v4ESpAuQC24oSjXHQIAQFiCmtwsry041eFKwILi6shaXVGz
        N8BY3AP7jUbV8zpUJS6CZsPYre3w8Imhduy4ZHroZZXRF9YMXbJc9eLmE7zMspUjaKlw8JzlWdS2H
        eXL4HfnVQ8qKqfs/Ekv4wfS6QmQaHDCfLSzJXTkbG9XfVzPpsrZ5/Ldz3ZDMy/V9+u4dR31WMRiUO
        ZVv2jZsA==;
Received: from [167.98.27.226] (helo=[172.16.100.86])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1rCi9j-00FAzE-4h; Mon, 11 Dec 2023 15:25:16 +0000
Message-ID: <8002710f-66f4-32aa-df45-fb8901773a26@codethink.co.uk>
Date:   Mon, 11 Dec 2023 15:25:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] riscv: lib: Implement optimized memchr function
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com, heiko@sntech.de,
        bjorn@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231208141839.174284-1-ivan.orlov@codethink.co.uk>
 <20231211-b65c8d828ace61714b0eacf5@orel>
From:   Ivan Orlov <ivan.orlov@codethink.co.uk>
In-Reply-To: <20231211-b65c8d828ace61714b0eacf5@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ivan.orlov@codethink.co.uk
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 15:08, Andrew Jones wrote:
>> As you can see, the new function shows much better results even for
>> the small arrays of 256 elements, therefore I believe it could be a
>> useful addition to the existing riscv-specific string functions.
> 
> Looks good, but do we want to maintain both this version and a zbb
> version? I'd expect a zbb version to be even better.
> 

Hi Andrew,

Yes, ZBB analog would be much better, and if we use ZBB operations we 
could avoid the most part of bit magic happening there.

>> +	add t1, x0, a2
> 
> move t1, a2
> 
> and for the remainder of the function s/x0/zero/
> 

Alright, will be fixed in the next version.
>> +	sltiu t2, a2, MIN_BORDER
>> +	bnez t2, 6f
>> +
>> +	// get the number of bytes we should iterate before alignment
> 
> I'm not sure, but I think even in assembly we prefer the /* */ comment
> format.
> 
>> +	andi t0, a0, SZREG - 1
>> +	beqz t0, 4f
>> +
>> +	# get the SZREG - t0
> 
> I'm 99% sure we don't want to use the # comment syntax.
> 
>> +	xor t0, t0, SZREG - 1
> 
> xori?
> 

Hmm, I'm surprised that it is actually compilable... Yeah, should be fixed
>> +	addi t0, t0, 1
>> +
>> +	sub a2, a2, t0
> 
> nit: Looks a bit odd to put a blank line above the sub line above,
> instead of above the below comment.
> 
>> +	// iterate before alignment
>> +1:
>> +	beq t0, x0, 4f
>> +	lbu t2, 0(a0)
>> +	beq t2, a1, 3f
>> +	addi t0, t0, -1
> 
> This addi t0... isn't necessary if we do
> 

Yeah, sounds reasonable, we can make it faster
> 	add t0, a0, t0
> 1:
> 	beq a0, t0, 4f
> 	...
> 	...
> 	addi a0, a0, 1
> 	j 1b
> 
>> +	addi a0, a0, 1
>> +	j 1b
>> +
>> +2:
>> +	// found a word. Iterate it until we find the target byte
>> +	li t1, SZREG
>> +	j 6f
> 
> These instructions seem oddly placed among the rest.
> 
>> +3:
>> +	ret
> 
> And this is an odd place to put this ret (after unconditional jump and
> in the middle of the function). We can just put a label at the bottom ret.
> 

I agree, thanks!
>> +
>> +4:
>> +	// get the count remainder
>> +	andi t1, a2, SZREG - 1
>> +
>> +	// align the count
>> +	sub a2, a2, t1
>> +
>> +	// if we have no words to iterate, iterate the remainder
>> +	beqz a2, 6f
>> +
>> +	// from 0xBA we will get 0xBABABABABABABABA
>> +	li t3, REP_01
>> +	mul t3, t3, a1
> 
> I don't think we want to implement an optimized assembly function with
> mul. We can just use a few shifts and ors.
> 
> 	slli	t3, a1, 8
> 	or	t3, t3, a1
> 	slli	t4, t3, 16
> 	or	t3, t4, t3
> #if __riscv_xlen == 64
> 	slli	t4, t3, 32
> 	or	t3, t4, t3
> #endif
> 

Nice point, thanks! Will be optimized :)
>> +
>> +	add a2, a2, a0
>> +
>> +	li t4, REP_01
>> +	li t5, REP_80
>> +
>> +5:
>> +	REG_L t2, 0(a0)
>> +
>> +	// after this xor we will get one zero byte in the word if it contains the target byte
>> +	xor t2, t2, t3
>> +
>> +	// word v contains the target byte if (v - 0x01010101) & (~v) & 0x80808080 is positive
> 
> s/is positive/is not zero/
> 
>> +	sub t0, t2, t4
>> +
>> +	not t2, t2
>> +
>> +	and t0, t0, t2
>> +	and t0, t0, t5
>> +
>> +	bnez t0, 2b
>> +	addi a0, a0, SZREG
>> +	bne a0, a2, 5b
>> +
>> +6:
>> +	// iterate the remainder
>> +	beq t1, x0, 7f
>> +	lbu t4, 0(a0)
>> +	beq t4, a1, 3b
>> +	addi a0, a0, 1
>> +	addi t1, t1, -1
> 
> Same comment as above about being able to drop the addi t1...
> 
>> +	j 6b
>> +
>> +7:
>> +	addi a0, x0, 0
> 
> li a0, 0
> 
>> +	ret
>> +SYM_FUNC_END(memchr)
>> +SYM_FUNC_ALIAS(__pi_memchr, memchr)
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew
>

Thanks a lot for the review!

--
Kind regards,
Ivan Orlov
