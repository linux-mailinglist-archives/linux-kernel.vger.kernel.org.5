Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901507F071F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKSPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:20:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234B138;
        Sun, 19 Nov 2023 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700407211; x=1701012011; i=deller@gmx.de;
        bh=NrAauS97WMgXb29QxSDYy5SYjfzRH02yEZ7tWmfZOHs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=IaA0KTU1AQQUu4xaH+Hfivzl5HQ77+f7h+uwDJ743LACx69v/4R9x2A0ydyOjbfv
         cBTZL+cL0tPsj1+Fy7hG+AVGyaNQnyeRteAU+xSA4IaOaAegjWyehS+nXAMY7Uid+
         4Pvab0GQnzhXl+w56zQ4XFjaJ9UFu04gYFxDN+A2v4rbtIuWqLMqycuw9y0jhndIu
         nIEkZFbsHHSmC1DqW8tyUjmBb5dCCX1RnQ6DJoraFtbIiQmyf6vx0vv+FhKEqxn5U
         MexqVZciIOEuLZg0DMM8dziV4wvEQ5GyoBoi6G/inFESnKCEPrdXQos16qON7bv+9
         pz2Jm5qZHPMqXBPkcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.64]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1raEKT1hjC-00fNzA; Sun, 19
 Nov 2023 16:20:11 +0100
Message-ID: <ec0ef169-17b0-4dea-9378-7af8bae0662b@gmx.de>
Date:   Sun, 19 Nov 2023 16:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Fix mmap_base calculation when stack grows
 upwards
Content-Language: en-US
To:     Sam James <sam@gentoo.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        matoro <matoro_mailinglist_kernel@matoro.tk>
References: <ZVH2qeS1bG7/1J/l@p100> <87msv9ke78.fsf@gentoo.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87msv9ke78.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+i+rPWxrYjvogDTXbPHwzGD07k2twyoaINiYryyz3+OrNBQALf
 s3COOCFztNj8Ynj8ZmEf5FBcd5Sfyu/FOqkR5raQg7uyulJ+dFV2u0DnL8QfV5O6ljqewOL
 dEqVwnTrnJPV/YGOj+Bc/mCjZ7ZZbJ1pNT0yYfoBQn3U3rszdf0hKhM3SSlCyspcaEYb8TM
 wLY3cTNKXZLIU8AgN4V6w==
UI-OutboundReport: notjunk:1;M01:P0:9oCZA0DOFmE=;mmAvAJ/YDocSX7PBH7dXzQG8xL7
 Sn4YO8sM9iP1eWv2hIXegnJLdgDhSrkycZWmocyw0sJjpMND9vvA0JtSbTW1O3y6tqehW5VdS
 gwBz8p5BRxXaGq1k4Ns5EKqRuBvqGmTmV9I8gcHe1SLn5h+NNp1zDGQ00QstjoLutcLy94Vhl
 opyTJmDjUTpePe+B0O5ckA0mlLRmsKWAXW4MFTcteYoRg3HXlmVqTP9SSBtPwtCCCGcFVz6u9
 dHL6gDcXFu74yi4BrHsHPWF5XUInJ5v+HvuCjGkX39eros1CSi/ufuoRgSIo1ycs2AtjjJtPY
 dDR5uGaO0PLuc5QkQuSUftNSym8N9oGG/0YjIJP7OsqaXe62vrRC/LwDHLXUXXM3LQu/bXVap
 954ikMwyWDIlUn9okGODl8t7O+dnobnT7Y+mEgykQUOuhjKszvqGLH4Dr4dFHFkPGdkfLl8PR
 /KNYk6lI9qjyfeVQQTEjaSn6u0aZBliknHRj+fh2zSQJq+0dpWTreXmis9qoZrmZzQK/cjeN2
 Xgx2jEOTyEb9ldBZTqU56RSBBKHidVvN7P/jhKvZYaIEEqhQ2+zgdrIDNkFpewYD+S8gNqLUL
 QTNkbAXZnrTjoTTG59iR7RVFtJwl/sINedK1hAIwfTWGzWUl+t3ohmZBCq8qLcT1lxkolGAEx
 V5S26nNCviXeDTlUcmE/eWfjzvk3pPgLalUVyEjvT+urGZ8BkD1a5XF2fUAQMIwm/33txAcA1
 RTX5/H2A68aOJ1nlBYAE2hiuCOH/Gw/rkhO0L8P2WhNAzkNVasrbIqFqa8dffFg4scJ0aLQg4
 hxybrkSLcSCFSmsQdrMZC6SomeErur7N4hEUoXrpi/owiCFsUI7PvkLs66o+4huAtGwQW3JNW
 b/iz1syueQkklc/iM2qXoqVmu15AtmgRBA9IRaiTihpzAai6+gDEkYpsrOtX1zjiOOUHjhGbU
 ZIsDAcoimcMkMkOTCXIEjNPM/Fc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/23 15:30, Sam James wrote:
>
> Helge Deller <deller@gmx.de> writes:
>
>> Matoro reported various userspace crashes on the parisc platform with k=
ernel
>> 6.6 and bisected it to commit 3033cd430768 ("parisc: Use generic mmap t=
op-down
>> layout and brk randomization").
>>
>> That commit switched parisc to use the common infrastructure to calcula=
te
>> mmap_base, but missed that the mmap_base() function takes care for
>> architectures where the stack grows downwards only.
>>
>> Fix the mmap_base() calculation to include the stack-grows-upwards case
>> and thus fix the userspace crashes on parisc.
>>
>> Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Tested-by: matoro <matoro_mailinglist_kernel@matoro.tk>
>> Fixes: 3033cd430768 ("parisc: Use generic mmap top-down layout and brk =
randomization")
>> Cc:  <stable@vger.kernel.org> # v6.6+
>
> Sorry to be impatient, but pinging this. HPPA is unusable on 6.6.x witho=
ut this patch.

This patch was merged yesterday into Linus's master tree.
Now we just have to wait until it reaches the v6.6 stable tree...

Helge


>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index fd69dfa0cdab..a7c9c0e69e5a 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -140,11 +140,11 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>   	default 8
>>
>>   config ARCH_MMAP_RND_BITS_MAX
>> -	default 24 if 64BIT
>> -	default 17
>> +	default 18 if 64BIT
>> +	default 13
>>
>>   config ARCH_MMAP_RND_COMPAT_BITS_MAX
>> -	default 17
>> +	default 13
>>
>>   # unless you want to implement ACPI on PA-RISC ... ;-)
>>   config PM
>> diff --git a/arch/parisc/include/asm/elf.h b/arch/parisc/include/asm/el=
f.h
>> index 140eaa97bf21..2d73d3c3cd37 100644
>> --- a/arch/parisc/include/asm/elf.h
>> +++ b/arch/parisc/include/asm/elf.h
>> @@ -349,15 +349,7 @@ struct pt_regs;	/* forward declaration... */
>>
>>   #define ELF_HWCAP	0
>>
>> -/* Masks for stack and mmap randomization */
>> -#define BRK_RND_MASK	(is_32bit_task() ? 0x07ffUL : 0x3ffffUL)
>> -#define MMAP_RND_MASK	(is_32bit_task() ? 0x1fffUL : 0x3ffffUL)
>> -#define STACK_RND_MASK	MMAP_RND_MASK
>> -
>> -struct mm_struct;
>> -extern unsigned long arch_randomize_brk(struct mm_struct *);
>> -#define arch_randomize_brk arch_randomize_brk
>> -
>> +#define STACK_RND_MASK	0x7ff	/* 8MB of VA */
>>
>>   #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
>>   struct linux_binprm;
>> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/=
asm/processor.h
>> index c05d121cf5d0..982aca20f56f 100644
>> --- a/arch/parisc/include/asm/processor.h
>> +++ b/arch/parisc/include/asm/processor.h
>> @@ -47,6 +47,8 @@
>>
>>   #ifndef __ASSEMBLY__
>>
>> +struct rlimit;
>> +unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
>>   unsigned long calc_max_stack_size(unsigned long stack_max);
>>
>>   /*
>> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_p=
arisc.c
>> index ab896eff7a1d..98af719d5f85 100644
>> --- a/arch/parisc/kernel/sys_parisc.c
>> +++ b/arch/parisc/kernel/sys_parisc.c
>> @@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack=
_max)
>>    * indicating that "current" should be used instead of a passed-in
>>    * value from the exec bprm as done with arch_pick_mmap_layout().
>>    */
>> -static unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
>> +unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
>>   {
>>   	unsigned long stack_base;
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index aa01f6ea5a75..744b4d7e3fae 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -414,6 +414,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stac=
k)
>>
>>   static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim=
_stack)
>>   {
>> +#ifdef CONFIG_STACK_GROWSUP
>> +	/*
>> +	 * For an upwards growing stack the calculation is much simpler.
>> +	 * Memory for the maximum stack size is reserved at the top of the
>> +	 * task. mmap_base starts directly below the stack and grows
>> +	 * downwards.
>> +	 */
>> +	return PAGE_ALIGN_DOWN(mmap_upper_limit(rlim_stack) - rnd);
>> +#else
>>   	unsigned long gap =3D rlim_stack->rlim_cur;
>>   	unsigned long pad =3D stack_guard_gap;
>>
>> @@ -431,6 +440,7 @@ static unsigned long mmap_base(unsigned long rnd, s=
truct rlimit *rlim_stack)
>>   		gap =3D MAX_GAP;
>>
>>   	return PAGE_ALIGN(STACK_TOP - gap - rnd);
>> +#endif
>>   }
>>
>>   void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_=
stack)
>

