Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517417F90AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjKZBm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:42:25 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C9AF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 17:42:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2A95D60197;
        Sun, 26 Nov 2023 02:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700962948; bh=UAhRIrnrkgFZfN3e3DDnvTSP38sFyBdr2yNLRMbRT5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e9Vp/QPKrIHA+9N+OLUyT+4+ChPAobPEI6VaRaMPUkHxJ0L4Fv5T7yWisfcuwAVDp
         RfXD2fkDLGy8WxRhFyWOxUvykGnfgKgLgqd+qQglwfeQniwdMVGtQ7nA3AffxU9yix
         vcTQEBggcJBFArF8L2iTWj7+AJTPaf5TkIQP/DVGsvW22sPmae/9FT3uLVs4o2PsVB
         APV0COhO7OLaPo9Ozj6xTJ4vVn/eUUXbsn78vPPJo60oJel0CEN6yGaamj14CgteKp
         xNRIN+CbGzxtH/5lOxmTOYJQGghcoe2RqEXPWb4EteUDRaob7SYB8MN00+PglIbxo8
         1xwtGvjkDBJUg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iMleNKkgsH2k; Sun, 26 Nov 2023 02:42:25 +0100 (CET)
Received: from [192.168.1.6] (78-0-136-201.adsl.net.t-com.hr [78.0.136.201])
        by domac.alu.hr (Postfix) with ESMTPSA id 7AD4860186;
        Sun, 26 Nov 2023 02:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700962945; bh=UAhRIrnrkgFZfN3e3DDnvTSP38sFyBdr2yNLRMbRT5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IOrcEGb3OokPKraptRB816GBkQi3DWvGAX/NdwaEmv82abgWhd1/Kw29gVpKaL4vw
         7RGhsfN+7x9+NDXufA7bGgQ7GBKcUmkYW+nWKjfICwRVB2tZzDzkqKhwjM11VomPeA
         TiHNCEbsIk6LoefrgwM/jho8l0zIswCla3FrrUBOq4E0x7Q28hpWj1dIRWinrYAvH8
         DcGBnv6Bz9xOCOQMeumAO8ctcNhn3YlcJ3PSEopgCiW64g86RkVi84n9OsO8BbyAJT
         NoNHAP8tfbu3o7kbVujyr58SN0n3emn4kNvHY9lZ2Zw6P/40ij3C1gdWYLRjYV5wmU
         mJJom3qzxoIAw==
Message-ID: <9c03b89f-b2d6-4046-8797-f0ac50a632cf@alu.unizg.hr>
Date:   Sun, 26 Nov 2023 02:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] r8169: Coalesce mac ocp write and modify for 8125
 and 8125B start to reduce spinlocks
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     hkallweit1@gmail.com, linux-kernel@vger.kernel.org
References: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
 <11941121-205b-44fd-86ee-1b86a52a3211@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <11941121-205b-44fd-86ee-1b86a52a3211@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Akira,

On 10/31/23 09:23, Akira Yokosawa wrote:
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

It surely did help, thx for the ref.

However, note this quote from the very perfbook:

=============
Quick Quiz 7.19: p.110
How might the lock holder be interfered with?

Answer:
If the data protected by the lock is in the same cache line
as the lock itself, then attempts by other CPUs to acquire
the lock will result in expensive cache misses on the part
of the CPU holding the lock. This is a special case of
false sharing, which can also occur if a pair of variables
protected by different locks happen to share a cache line.
In contrast, if the lock is in a different cache line than the
data that it protects, the CPU holding the lock will usually
suffer a cache miss only on first access to a given variable.
Of course, the downside of placing the lock and data
into separate cache lines is that the code will incur two
cache misses rather than only one in the uncontended case.

As always, choose wisely!

=============

In other words, in the contended case the lock data cannot be simultaneously in two core's cache
lines, so the cache miss logic will have to do something expensive.

Table E.1: Performance of Synchronization Mechanisms
on 16-CPU 2.8 GHz Intel X5550 (Nehalem) System       (page 480 of the perfbook)

Operation	Cost (ns)	Ratio
				(cost/clock)
--------------------------------------------
Clock period	0.4 		1.0
--------------------------------------------
Same-CPU
CAS 		12.2 		33.8
lock 		25.6 		71.2
--------------------------------------------
On-Core
Blind CAS	12.9		35.8
CAS 		7.0 		19.4
--------------------------------------------
Off-Core
Blind CAS 	31.2 		86.6
CAS 		31.2 		86.5
--------------------------------------------
Off-Socket
Blind CAS 	92.4 		256.7
CAS 		95.9 		266.4
--------------------------------------------
Off-System
Comms Fabric 	2,600 		7,220
Global Comms 	195,000,000 	542,000,000

Table E.2: CPU 0 View of Synchronization Mechanisms
on 12-CPU Intel Core i7-8750H CPU @ 2.20 GHz

Operation 	Cost (ns)	Ratio
				(cost/clock)	CPUs
----------------------------------------------------
Clock period 	0.5 		1.0
----------------------------------------------------
Same-CPU 					0
CAS 		6.2 		13.6
lock 		13.5		29.6
----------------------------------------------------
On-Core 					6
Blind CAS 	6.5 		14.3
CAS 		16.2 		35.6
----------------------------------------------------
Off-Core 					1–5
Blind CAS 	22.2 		48.8 		7–11
CAS 		53.6 		117.9
----------------------------------------------------
Off-System
Comms Fabric 	5,000 		11,000
Global Comms 	195,000,000 	429,000,000

So, on those systems, in the lock contended case and one threat acquiring and releasing
spinlock 11 times like in the RTL8125 driver, the cost can mount up from 770 clock to
266 × 11 ~ 2660 + 266 = 2926 clock cycles. 95 × 11 ns = 950 + 95 ns = 1045 ns.

(In the worst case, that two threads contend each time for acquiring the lock.
The minimum cost is 25.6 × 11 = 256 + 25.6 ns = 281.6 ns for the uncontended case.
For the Nehalem system. But the lock were added for the concurrent access in the
first place. Besides, the Realtek logic might be confused in the rare case that the
MMIO programming sequence is not sequential, but interrupted when the lock is released
instead of adding MMIO instructions in uninterrupted bulk sequence. So, it is risky
to release the lock before the sequence is finished.)

So, my calculations below weren't exaggerated. Locking is faster if the lock is cached
on the local core, but the downside is that we need them exactly to synchronise what is
happening between the threads on two independent cores.

>> Doing that in storm of 10 lock/unlock pairs amounts to 500 cycles or 125 ns in the best case
>> on a 4 GHz CPU.
>>
>> But I trust that you as the maintainer have the big picture and greater insight in the actual hw.

Hope this helps.

Best regards,
Mirsad Todorovac

