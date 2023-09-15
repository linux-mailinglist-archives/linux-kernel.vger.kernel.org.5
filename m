Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54897A20B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjIOOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:19:26 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C6F3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1694787557; bh=176LZTE9f+ZeUVaUfrPwdkcY1mDZJcgB9YwcRXOgUNM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M3PoYplXoLAUov40mxtbCoQp8PGM+SnXBpOpmDdNA1WhCxr9e4zdGzPdncYzd+2de
         eDcaHXvk2D7czctgwSAXLhmGCy5EXzIPpHikXD6ZP55jyxhJCj7DyzWOPjL20VsIr2
         1p8+n2irKhIcgH7fkmkw7bDXzxriGwR04w2nqNXQ=
Received: from [192.168.9.172] (unknown [101.88.25.36])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 67FF16010F;
        Fri, 15 Sep 2023 22:19:17 +0800 (CST)
Message-ID: <2bbc2df8-5fcf-b216-7aa0-192e27bac6e7@xen0n.name>
Date:   Fri, 15 Sep 2023 22:19:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <ZQC5jS/Kc/JiBEOa@p100>
 <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
 <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
 <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
 <1160d063-8396-b126-15ca-a46807ec4258@gmx.de>
 <644b77db-7214-88c3-7ba6-9c805a134e63@roeck-us.net>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <644b77db-7214-88c3-7ba6-9c805a134e63@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/23 22:07, Guenter Roeck wrote:
> Hi Helge,
>
> On 9/15/23 03:10, Helge Deller wrote:
>> On 9/15/23 11:23, Huacai Chen wrote:
>>> On Fri, Sep 15, 2023 at 4:16 PM Helge Deller <deller@gmx.de> wrote:
>>>>
>>>> On 9/15/23 05:22, Huacai Chen wrote:
>>>>> Hi Helge,
>>>>>
>>>>> On Wed, Sep 13, 2023 at 3:18 AM Helge Deller <deller@gmx.de> wrote:
>>>>>>
>>>>>> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection 
>>>>>> even
>>>>>> more") the lockdep code uses is_kernel_core_data(), 
>>>>>> is_kernel_rodata()
>>>>>> and init_section_contains() to verify if a lock is located inside a
>>>>>> kernel static data section.
>>>>>>
>>>>>> This change triggers a failure on LoongArch, for which the 
>>>>>> vmlinux.lds.S
>>>>>> script misses to put the locks (as part of in the .data.rel symbols)
>>>>>> into the Linux data section.
>>>>>> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
>>>>>> into the kernel data section (from _sdata to _edata).
>>>>>>
>>>>>> Additionally, move other wrongly assigned symbols too:
>>>>>> - altinstructions into the _initdata section,
>>>>
>>>>> I think altinstructions cannot  be put into _initdata because it will
>>>>> be used by modules.
>>>>
>>>> No.
>>>> arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of 
>>>> the kernel
>>>> and altinstructions are replaced before modules are loaded.
>>>> For altinstructions in modules the linker script 
>>>> scripts/module.lds.S is used.
>>
>>> OK, then what about .got/.plt? It seems arm64 also doesn't put them in
>>> the data section.
>>
>> arm64 seems to throw away all plt entries already at link time (and 
>> just keeps
>> the got.plt in the read-only data section).
>> It even checks at link time, that there are no plt entries in the 
>> binary:
>>          ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure 
>> linkages detected!")
>>
>> I don't know for loongarch, but if you need the plt entries for 
>> loongarch, it's
>> safest & best to put them into the read-only data section too, which 
>> is what my patch does.
>> Up to now, you have them completely outside of code & data sections.
>>
>> In the end you need to decide for your platform. My patch is a 
>> suggestion, which I think
>> is correct (untested by me, but Guenter replied he tested it).
>> But to fix the lockdep problem at minimum the move of the .data.rel 
>> section
>> is needed.
>>
>
> Just my $0.02 .. it might make sense to concentrate on the minimum to 
> get the immediate
> problem fixed. Loongarch maintainers can then decide at their own pace 
> if they want
> to apply any of the other changes you suggested. After all, unless I 
> am missing
> something, those additional changes are not really needed in stable 
> releases.

Sorry for coming late, but as reviewer of arch/loongarch, I'd agree with 
Guenter and Helge here: let's fix the immediate problem and investigate 
the rest later -- it's not like the problems are *definitely* orthogonal 
in this case, and at least *some* progress would be appreciated.

I'll try to reproduce the problem and test the fix during the weekend, 
so hopefully Huacai can get the fix in before -rc2 or -rc3. Thanks for 
the attention and fix.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

