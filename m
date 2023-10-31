Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051557DCE02
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjJaNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbjJaNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:39:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611DF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:39:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 47B1160173;
        Tue, 31 Oct 2023 14:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1698759564; bh=pZ/sgbtwHqidxHOPdy7eds8j+rmF6Dny4sFR2wQMQFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n/BTwPaHXWnl5PmWe9VigUcRoCqCgKwMDoRrjSAIUynbgMe33G8hvUAAKZMQLc3VN
         s5l6d5i8aZXs7qr4ZTO4qmSnmxqu/Gq02ysh/8/bBOccZRkCv4DD66z6zrIGDR/dNy
         z+93IEqITFFJsz/0Lqr+DnBiJP7vulUJsjvD7QgUe7QxvKC/U7rrRheJj/rpGvfLAR
         xKYVtVBxwUvvLFVvmDnAZnhhaCO4hobNuMQq+GMlLiyfxHKpnaGlCUWHOi32a6JbeW
         GW0d9BEC6xH440VRZA4CVZo+qmp+4Xliz2mmUZfPevW/VtIFwa5ZLFmRLbAIYmezp+
         /LJTK5sIRXG1Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RxZScxsGEJQT; Tue, 31 Oct 2023 14:39:21 +0100 (CET)
Received: from [IPV6:2001:b68:2:2600:14cd:7d53:817e:e1c2] (unknown [IPv6:2001:b68:2:2600:14cd:7d53:817e:e1c2])
        by domac.alu.hr (Postfix) with ESMTPSA id 21C1C60171;
        Tue, 31 Oct 2023 14:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698759561; bh=pZ/sgbtwHqidxHOPdy7eds8j+rmF6Dny4sFR2wQMQFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W+VUHxir6tu3CUZAq5wV5ItKdlLWb6QjkRwI4i0aB2lItHpT0Hk6pxycIHY4W9tSV
         HTp3qucWtzydjW6fEMW7VnSpREI0M5+PvJqShBmMpy3ZKvraVJmbJeWIN0GbLc6kmx
         X56ISaX0ATI3BXZmynlHu/YNXSJIEnziDE62Wj3gleDSN7kWVNTbJghLxI+FJD1Vrq
         Fj9SlxbzlCkA3H44d0W2l2Pm0iSzQFBGpj2OjhKPAUEPPkTLvEDMbAKam9aLk227iG
         l7ZkvJP1T7RCPWxgDDsCUJIvWhrvcmgLd6Lr+4sq0KbWlu/bgQNoX7v6XVERiRH1vp
         +FVL8l9Odvuzg==
Message-ID: <d9206b2b-64da-41f0-bc64-f2807129277a@alu.unizg.hr>
Date:   Tue, 31 Oct 2023 14:39:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] r8169: Coalesce mac ocp write and modify for 8125
 and 8125B start to reduce spinlocks
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>, mirsad.todorovac@alu.unizg.hr
Cc:     hkallweit1@gmail.com, linux-kernel@vger.kernel.org
References: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
 <11941121-205b-44fd-86ee-1b86a52a3211@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <11941121-205b-44fd-86ee-1b86a52a3211@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2023 9:23 AM, Akira Yokosawa wrote:
> Hello Mirsad,
> 
> [most CCs dropped]
> 
> I'm responding to your comment quoted below.  It caught eyes of me
> who happens to be a reviewer of LKMM and a LaTeX advisor to perfbook.
> 
> On Mon, 30 Oct 2023 16:02:28 +0100, Mirsad Todorovac wrote:
>> On 10/30/23 15:02, Heiner Kallweit wrote:
> [...]
>>>
>>> All this manual locking and unlocking makes the code harder
>>> to read and more error-prone. Maybe, as a rule of thumb:
>>> If you can replace a block with more than 10 mac ocp ops,
>>> then fine with me
>> As I worked with another German developer, Mr. Frank Heckenbach from the GNU Pascal project,
>> I know that Germans are pedantic and reliable :-)
>>
>> If this rtl_hw_start_8125_common() is called only once, then maybe every memory bus cycle
>> isn't worth saving, and then maybe the additional complexity isn't worth adding (but it
>> was fun doing, and it works with my NIC).
>>
>> AFAIK, a spin_lock_irqsave()/spin_unlock_irqrestore() isn't a free lunch as you know, and I read
>> from the manuals that on modern CPUs a locked ADD $0, -128(%esp) or something takes about 50
>> clock cycles, in which all cores have to wait.
> 
> Do you mean, while one of x86 CPUs is executing "lock; addl $0, -4(%esp)"
> aka smp_mb(), bus locking prevents all the other CPUs in the system
> connected to the bus from doing any memory accesses ???
> 
> If it is the case, I believe you are missing the state of the art
> optimization of x86 memory system architecture, where most of atomic
> operations are done using cache locking.  Bus locking is used only
> when it is unavoidable.
> 
> Hint: A short introduction can be found at stackoverflow.com [1].
> Quote of (then) section 7.1.4 from Intel's SDM vol 3A in the answer
> should suffice.
> 
> [1]: https://stackoverflow.com/questions/3339141/x86-lock-question-on-multi-core-cpus
> 
> A reachable link to Intel SDM should be somewhere in perfbook's bibliography.
> The relevant section in Vol 3A is now "2.8.5 Controlling the Processor".
> 
> Hope this helps,
> Akira

Thanks for the tip. I really need to catch up with my homework and the 
documentation.

Yesterday I've lost a friend who worked very hard for her PhD, so I 
wonder again about the purpose of meaning. :-/

Thanks,
Mirsad

>> Doing that in storm of 10 lock/unlock pairs amounts to 500 cycles or 125 ns in the best case
>> on a 4 GHz CPU.
>>
>> But I trust that you as the maintainer have the big picture and greater insight in the actual hw.
> 
