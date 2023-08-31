Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469478E6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbjHaG4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjHaG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:56:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A49B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:56:08 -0700 (PDT)
X-QQ-mid: bizesmtp79t1693464956tdecde1n
Received: from [10.4.6.71] ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 31 Aug 2023 14:55:54 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: lm7sZZPcOdZf/fpUyXb4FSBHuUW/npZsyyFuhkWADSPcz7fzI9mIBI2LDSPQ8
        7qiMc4NaSIsMG0o7EU8hmj/v31OANN92+WG8sXN7NW3tBpAxxhXl1it1Wz+QCqVfdgkc3ux
        zfVKFnhnw7+/Gf7uA7CFzPwU9vWxuIT66t7icyBwGLKxikmq+XGLxZqBsVWrKfyKLa8sUw5
        omj/MI+0sXtHn09hY/yvGUFKWdMa5aNUkAukfEiUIgyuns+7KJmFSSgpdb2JxqBI1Naa8nr
        hNaKF4eFwxc/KSyJV4HIZwhDJLmLLhJQAimyHd3+7ywHusMU1ZmXkUnZtD37dfLlOyWHh6s
        +Kt2oHCQVV27A1XomWSfkJ3XpaQbQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17274139541364043981
Message-ID: <FBD24A55B409E4DF+71a45adc-2e20-ea3c-a8ea-7341862991c6@tinylab.org>
Date:   Thu, 31 Aug 2023 14:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: kexec: Cleanup riscv_kexec_relocate
To:     Andreas Schwab <schwab@suse.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mick@ics.forth.gr, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
 <mvmmsy956xa.fsf@suse.de>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <mvmmsy956xa.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andreas:

在 2023/8/30 15:24, Andreas Schwab 写道:
> On Aug 30 2023, Song Shuai wrote:
> 
>> @@ -52,21 +42,27 @@ SYM_CODE_START(riscv_kexec_relocate)
>>   	 * the start of the loop below so that we jump there in
>>   	 * any case.
>>   	 */
>> -	la	s8, 1f
>> -	sub	s8, s8, s7
>> -	csrw	CSR_STVEC, s8
>> +	la	s6, 1f
>> +	sub	s6, s6, s4
>> +	csrw	CSR_STVEC, s6
>> +
>> +	/*
>> +	 * With C-extension, here we get 42 Bytes and the next
>> +	 * .align directive would pad zeros here up to 44 Bytes.
>> +	 * So manually put a nop here to avoid zeros padding.
>> +	*/
>> +	nop
>>   
>>   	/* Process entries in a loop */
>>   .align 2
> 
> While you are at it, I'd suggest being explicit about .palign
> vs. .balign.
> 
How about this commemt:

Due to the stvec.BASE 4-byte alignment constraint, the following .align
(alias of .p2align) directive will align the next instruction to
a 4-byte boundary by padding zeros for this .rodata section.

With C-extension, here we get 42 Bytes and would be padded with zeros
up to 44 Bytes. So manually put a nop here to avoid it.

-- 
Thanks
Song Shuai

