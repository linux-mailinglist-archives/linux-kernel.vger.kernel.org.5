Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B587E13FC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjKEPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKEPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:00:59 -0500
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955BCC;
        Sun,  5 Nov 2023 07:00:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 243D960171;
        Sun,  5 Nov 2023 16:00:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699196451; bh=qvKSHw3J6qeuAYrLlbIvC3dVidyWm6Vnzsr7vkATR+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MtRtEqFGFyFMQkBVpSg5GWe+QlzfAMMx+FjCyoEi5uMrrFcYhoeB1qwKtNGh1rZS+
         YMJNXLLSQU0cGlXVDJH9UUiy5TAlTCBle4ERk4z0C4Q3KYjeuxOseTlRrh4J3BsnJR
         1xQY55Rs3/o1o8gYR+0npOKabbGg19O4U2PRbYo3jtCYGpQ1W9a7jKK+UsKWnNFlq3
         ohdYQq8d5Vk7AX34MLSS7tm4p4e3XCblQ2IuwPhcglcbPLtnUj9349VQyt3mp72pD1
         PAKj50SzUaLmpEYa3145H1EUQCQiPWT4YvWPE0t5hyheZAE9OL4okXJthHVaJgWZ10
         c9s2L5Uc8gLug==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j1eLVgwG0RiU; Sun,  5 Nov 2023 16:00:48 +0100 (CET)
Received: from [192.168.1.6] (78-2-200-35.adsl.net.t-com.hr [78.2.200.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 3CE3E6016E;
        Sun,  5 Nov 2023 16:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699196448; bh=qvKSHw3J6qeuAYrLlbIvC3dVidyWm6Vnzsr7vkATR+A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n86Od7xMdYA+BHmtFvweKT25Xz3tW0zwgV3XPlYD4xWG4EiC307gZ5jsyYFY2p4uC
         0dBFN9JjzjSFMD+MiRVRYJZsHSpMEpgZYYud2DD86aDqkkysE9/GS3+YjfsCGDEis0
         C4OkANhgURzYuz5eevCsEHDLcL06ht+myuTD1iDrEZP+Rax1vmUGsAk8hWb6fqaKSs
         aUBnbrRqUEdkzqjxNMgOaN3ylC0v/dhhW3Q6LdhgFoiRpvo9ssUoGsMca8avRqvAkc
         zp1HbiooJasctY1TUhWUsqfQBRN+JmxDCDcrYOd1ChfOWwcmMFbx7ZaqoP3qBkSYkS
         hV48oAJ57kPKA==
Message-ID: <d63fc409-f662-4776-84ed-e4b8e7848ae5@alu.unizg.hr>
Date:   Sun, 5 Nov 2023 16:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
 <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
 <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
 <716b3dc3-231e-4fd2-b892-707c0d636d00@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <716b3dc3-231e-4fd2-b892-707c0d636d00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/23 10:20, Heiner Kallweit wrote:
> On 05.11.2023 01:15, Mirsad Todorovac wrote:
>>
>>
>> On 11/4/23 23:37, Heiner Kallweit wrote:
>>> On 04.11.2023 23:15, Mirsad Goran Todorovac wrote:
>>>> The motivation for these helpers was the locking overhead of 130 consecutive
>>>> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
>>>> if the PHY is powered-down.
>>>>
>>>> To quote Heiner:
>>>>
>>>>       On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>>>       This was reported in [0] and confirmed by Realtek. Realtek provided
>>>>       a sequence to fix the RX unit after PHY wakeup.
>>>>
>>>> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
>>>> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
>>>> spin_unlock_irqrestore().
>>>>
>>>> Each mac ocp write is made of:
>>>>
>>>>       static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>>                         u32 data)
>>>>       {
>>>>           if (rtl_ocp_reg_failure(reg))
>>>>               return;
>>>>
>>>>           RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>>>       }
>>>>
>>>>       static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>>                       u32 data)
>>>>       {
>>>>           unsigned long flags;
>>>>
>>>>           raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>>           __r8168_mac_ocp_write(tp, reg, data);
>>>>           raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>       }
>>>>
>>>> Register programming is done through RTL_W32() macro which expands into
>>>>
>>>>       #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>>>
>>>> which is further (on Alpha):
>>>>
>>>>       extern inline void writel(u32 b, volatile void __iomem *addr)
>>>>       {
>>>>           mb();
>>>>           __raw_writel(b, addr);
>>>>       }
>>>>
>>>> or on i386/x86_64:
>>>>
>>>>       #define build_mmio_write(name, size, type, reg, barrier) \
>>>>       static inline void name(type val, volatile void __iomem *addr) \
>>>>       { asm volatile("mov" size " %0,%1": :reg (val), \
>>>>       "m" (*(volatile type __force *)addr) barrier); }
>>>>
>>>>       build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>>>
>>>> This obviously involves iat least a compiler barrier.
>>>>
>>>> mb() expands into something like this i.e. on x86_64:
>>>>
>>>>       #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>>>
>>>> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
>>>> memory barrier, writel(), and spin_unlock_irqrestore().
>>>>
>>>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>>>> a lock storm that will stall all of the cores and CPUs on the same memory controller
>>>> for certain time I/O takes to finish.
>>>>
>>>> In a sequential case of RTL register programming, the writes to RTL registers
>>>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>>>> number of bus stalls in a multicore or multi-CPU system.
>>>>
>>>> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
>>>> provided to reduce lock contention:
>>>>
>>>>       static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>>       {
>>>>
>>>>           ...
>>>>
>>>>           /* The following Realtek-provided magic fixes an issue with the RX unit
>>>>            * getting confused after the PHY having been powered-down.
>>>>            */
>>>>
>>>>           static const struct recover_8411b_info init_zero_seq[] = {
>>>>               { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>>>>               ...
>>>>           };
>>>>
>>>>           ...
>>>>
>>>>           r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>>
>>>>           ...
>>>>
>>>>       }
>>>>
>>>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>>>> functions that only changed the function names and the ending of the line, so the actual
>>>> hex data is unchanged.
>>>>
>>>> To repeat, the reason for the introduction of the original commit
>>>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>>>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
>>>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>>>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>>>> the programming sequence to reach RTL NIC registers.
>>>>
>>>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>>>
>>>> v6:
>>>>    proceeded according to Jacob Keller's suggestions by creating a cover page and reducing
>>>>    the text within the commits. Applying to the net-next tree as Heiner Kallweit requested.
>>>>
>>>> v5:
>>>>    attempted some new optimisations, which were rejected, but not all and not completely.
>>>>
>>>> v4:
>>>>    fixed complaints as advised by Heiner and checkpatch.pl.
>>>>    split the patch into five sections to be more easily manipulated and reviewed
>>>>    introduced r8168_mac_ocp_write_seq()
>>>>    applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
>>>>
>>>> v3:
>>>>    removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>>>    avoided duplication of RTL_W32() call code as advised by Heiner.
>>>>
>>>> Mirsad Goran Todorovac (5):
>>>>     r8169: Coalesce r8169_mac_ocp_write/modify calls to reduce spinlock
>>>>       stalls
>>>>     r8169: Coalesce RTL8411b PHY power-down recovery calls to reduce
>>>>       spinlock stalls
>>>>     r8169: Coalesce mac ocp write and modify for 8168H start to reduce
>>>>       spinlocks
>>>>     r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce
>>>>       spinlock contention
>>>>     r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce
>>>>       spinlocks
>>>>
>>>>    drivers/net/ethernet/realtek/r8169_main.c | 304 +++++++++++-----------
>>>>    1 file changed, 150 insertions(+), 154 deletions(-)
>>>>
>>
>> Hi, Mr. Kallweit,
>>
>> So good to hear so soon from you. I'm encouraged that you are positive about improving
>> the speed and reducing the size of the Realtek drivers.
>>
>>> You still write:
>>> "a lock storm that will stall all of the cores and CPUs on the same memory controller"
>>> even though you were informed that that's not the case.
>>
>> I was not convinced. There is no such thing as a free lunch, and there is no locking
>> without affecting other cores, or locking would not make sense.
>>
>>> There's no actual problem, therefore your Fixes tags are incorrect.
>>
>> Mea culpa - my mistake, I will fix that in the next version.
>>
>>> Also net-next is closed at the moment.
>>
>> There is no problem with that, as these are only optimisation fixes, not zero day
>> exploits. I am a patient person.
>>
>>> In patches 3-5 I see no benefit. And I have doubts whether the small benefit in
>>> patch 2 is worth adding all the helpers in patch 1.
>>
>> I merely followed and mimed driver style from the constructions like this one:
>>
>>          static const struct ephy_info e_info_8168e_1[] = {
>>                  { 0x00, 0x0200, 0x0100 },
>>                  { 0x00, 0x0000, 0x0004 },
>>                  { 0x06, 0x0002, 0x0001 },
>>                  { 0x06, 0x0000, 0x0030 },
>>                  { 0x07, 0x0000, 0x2000 },
>>                  { 0x00, 0x0000, 0x0020 },
>>                  { 0x03, 0x5800, 0x2000 },
>>                  { 0x03, 0x0000, 0x0001 },
>>                  { 0x01, 0x0800, 0x1000 },
>>                  { 0x07, 0x0000, 0x4000 },
>>                  { 0x1e, 0x0000, 0x2000 },
>>                  { 0x19, 0xffff, 0xfe6c },
>>                  { 0x0a, 0x0000, 0x0040 }
>>          };
>>
>>          rtl_set_def_aspm_entry_latency(tp);
>>
>>          rtl_ephy_init(tp, e_info_8168e_1);
>>
>> Here you did not think that introducing an array reduced code readability.
>>
>> My ideal is a lockless driver using RCU, and you seem to prefer lock/unlock
>> on each RTL_W32() write. I am convinced that a driver with less
>> raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() pairs would scale better
>> with more NICs and more cores.
>>
> Then please focus on hot paths where it actually could make a difference,
> and provide numbers instead of a purely theoretical discussion.

I will comply.

RTL8411b losing PHY that requires this expensive reset probably doesn't happen
anyway on the Linux servers. :-/

I have done my homework and I see that you are also co-maintainer of the net PHYLIB,
so your insight on this matter is undoubtedly greater after five years of experience
in maintaining the driver.

Learning about the network stack and the PHY layer is however a formidable thought
very interesting task. The whole area of making multimedia more responsive on Linux
and Windows graphic interface is very challenging, and I could pass it with my day
job as research.

But as I said, I have to catch up with a lot of homework.

>> You said nothing to convinced me otherwise.
>>
>> But I am merely defending my point, this by no means implies disrespect or overlooking
>> your contribution to the source as a coder and a a maintainer.
>>
>> Realtek NICs are known as cheap NIC for motherboards, but they are becoming more ubiquitous,
>> and it is logical to use less locking, as locking is expensive. "barrier" in writev()
>> guarantees sequential orders of write, and locking and unlocking on each read/modify/write
>> is unnecessary overhead, IMHO.
>>
>> As the conclusion, I would like to emphasise that improving lock contention for the code
>> is by no means a personal attack on the maintainer or a breach of the Code of Conduct.
>>
>> If you are so much against the changes which Mr. Jacob Keller from Intel reviewed,
>> maybe we can cool emotions and start thinking rationally.
>>
>> Additionally, I would like to "inline" many functions, as I think that call/return
>> sequences with stack frame generation /destruction are more expensive than inlining the
>> small one liners.

> Mainline standard is to let the compiler decide on inlining.
  
>> But I will certainly respect your opinion on the matter as a maintainer.
>>
>> What I realise that I might be optimising the cold paths of the code, but from your emails
>> it seems like nothing is worth optimising in this driver, and with all due respect Sir,
>> I think that is dead wrong.
> 
> Nobody ever said that, and if you look at the history of the driver you'll see a lot of
> optimizations that have been added over time. Ideally an optimization improves both:
> performance and code readability
> Code readability is important for maintainability and weighs higher for me than a minor
> performance optimization in a code path that is very rarely used.

I see.

However, you do use lookup tables for programming with fn rtl_ephy_init().

If this would be more readable, I can unroll the table so it is one entry per line
like e_info_8168e_1 was made?

Then the actual function call adds nothing to readability and the ease of maintanance,
as the principle { address, value } and { address, mask, value } would be preserved.

In fact, some programming books advise separating data from code for readability and
efficiency sake.

I admit that the 8125 optimisation I proposed is minimal locking but hard to read and
maintain. (It defies the KISS principle.)

Thank you for your time and patience with me.

I always like more that things are explained through Spock logic than by a call to authority
(which is BTW the argumentum-ad-hominem logical fallacy).

(This is of course not the case with the sacred texts, where I use quotes from the relevant
authorities.)

Have a nice day and I wish you a blessed Sunday.

I should probably catch up with the documentation before using any more of your valuable time
and energy. I hope to reciprocate.

Best regards,
Mirsad Todorovac
  
>> Of course, I am tempted to comply to the authority as a kernel newbie, but I was reminded
>> in the spirit that this is exactly what the guys in Chernobyl did while maintaining the
>> reactor that malfunctioned: they did not dare to question the authority telling them that
>> everything is alright.
>>
>> Have a nice evening, and please do not take these words as a breach of the Code or a
>> personal attack. I believe we are on the same side, and that is making this driver better.
>>
>> The Linux kernel developer community was my last hope that this human race has a force
>> to improve the mankind and make it worth surviving.
>>
>> But sometimes it is more honourable to go down with the ship and preserve the honour.
>>
>> Best regards,
>> Mirsad Todorovac
