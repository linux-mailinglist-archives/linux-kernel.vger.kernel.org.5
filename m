Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC067E120A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKECSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKECSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 22:18:47 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC7D9;
        Sat,  4 Nov 2023 19:18:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0E44E60171;
        Sun,  5 Nov 2023 03:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699150717; bh=fYaMEKBQxJ0g6H5yjgzGnUoFYpoWiOWtlqqdR6WqekU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lc3SxlZQBQgiBsc37quMzDH5CEKIAA3iBIWm70pZYl7dMyHNEbliMdB+cggmqTgEh
         DEB8NNMzumM13NSk2g+POKAudb3IPp6Nvso/l51AvjYNz3QOG8n/wmzl3Iqrggw51g
         HneJPmfBY+GRMplb6kIg3pcHYVDbqYUBQorSVhfuIE1txsCAHnOFOZ03Hf+koWsiA4
         suA6wx9uRZSQMi76073SoCXmJdLoe07buhWvwkCIrGqpHlE6fSikVkLe719DClwMnD
         XYjFUDhx7R3NsINVX2Bq3JP5cw765YbsT6YIvGV51bWoFiYTDj9gVAf7c0nVOdodzB
         7dbkmWlTv2GxA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m7dYu-niWWke; Sun,  5 Nov 2023 03:18:34 +0100 (CET)
Received: from [192.168.1.6] (78-2-200-71.adsl.net.t-com.hr [78.2.200.71])
        by domac.alu.hr (Postfix) with ESMTPSA id 22FE66016E;
        Sun,  5 Nov 2023 03:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699150714; bh=fYaMEKBQxJ0g6H5yjgzGnUoFYpoWiOWtlqqdR6WqekU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cGdW/9LcotJcSSC4jzDb96UCipjLSmnF8baXykkwR4yDLl//I03PlyGDWOz1QMUeV
         JwaOUZ4ThybwMA7My7TzQJ8ntpVBjJfLQrd0d1PnBnJwiXotYz7ebI7rD4Ezgx3Mn2
         7u+JxEphDBaCfpqdA5dQ7n8ECaFVDhG2X3nyVYu34q4ufAviKRyOv/d/rlsLAHaCMI
         hzZxAWbh+NV+TlstT44PmmDNUmjLc9d6xV0rHsFJZYBWKF/IFk6iZkQTkeObT9T/WE
         2EJGw8qYLfdr+TG+GGV8iEK7OFkicuapF24Gvimci7djWPGAtNa7yuEJvCpeaaQYo8
         bHaAR7GFhpbRA==
Message-ID: <ac19c886-9d71-4b4f-b5d4-42111dddb8ee@alu.unizg.hr>
Date:   Sun, 5 Nov 2023 03:18:32 +0100
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
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/23 23:37, Heiner Kallweit wrote:
> On 04.11.2023 23:15, Mirsad Goran Todorovac wrote:
>> The motivation for these helpers was the locking overhead of 130 consecutive
>> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
>> if the PHY is powered-down.
>>
>> To quote Heiner:
>>
>>      On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>      This was reported in [0] and confirmed by Realtek. Realtek provided
>>      a sequence to fix the RX unit after PHY wakeup.
>>
>> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
>> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
>> spin_unlock_irqrestore().
>>
>> Each mac ocp write is made of:
>>
>>      static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>                        u32 data)
>>      {
>>          if (rtl_ocp_reg_failure(reg))
>>              return;
>>
>>          RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>      }
>>
>>      static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>                      u32 data)
>>      {
>>          unsigned long flags;
>>
>>          raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>          __r8168_mac_ocp_write(tp, reg, data);
>>          raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>      }
>>
>> Register programming is done through RTL_W32() macro which expands into
>>
>>      #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>
>> which is further (on Alpha):
>>
>>      extern inline void writel(u32 b, volatile void __iomem *addr)
>>      {
>>          mb();
>>          __raw_writel(b, addr);
>>      }
>>
>> or on i386/x86_64:
>>
>>      #define build_mmio_write(name, size, type, reg, barrier) \
>>      static inline void name(type val, volatile void __iomem *addr) \
>>      { asm volatile("mov" size " %0,%1": :reg (val), \
>>      "m" (*(volatile type __force *)addr) barrier); }
>>
>>      build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>
>> This obviously involves iat least a compiler barrier.
>>
>> mb() expands into something like this i.e. on x86_64:
>>
>>      #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
>>
>> This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
>> memory barrier, writel(), and spin_unlock_irqrestore().
>>
>> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
>> a lock storm that will stall all of the cores and CPUs on the same memory controller
>> for certain time I/O takes to finish.
>>
>> In a sequential case of RTL register programming, the writes to RTL registers
>> can be coalesced under a same raw spinlock. This can dramatically decrease the
>> number of bus stalls in a multicore or multi-CPU system.
>>
>> Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
>> provided to reduce lock contention:
>>
>>      static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>      {
>>
>>          ...
>>
>>          /* The following Realtek-provided magic fixes an issue with the RX unit
>>           * getting confused after the PHY having been powered-down.
>>           */
>>
>>          static const struct recover_8411b_info init_zero_seq[] = {
>>              { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>>              ...
>>          };
>>
>>          ...
>>
>>          r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>
>>          ...
>>
>>      }
>>
>> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
>> functions that only changed the function names and the ending of the line, so the actual
>> hex data is unchanged.
>>
>> To repeat, the reason for the introduction of the original commit
>> was to enable recovery of the RX unit on the RTL8411b which was confused by the
>> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
>> into a series of about 500+ memory bus locks, most waiting for the main memory read,
>> modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
>> the programming sequence to reach RTL NIC registers.
>>
>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
>>
>> v6:
>>   proceeded according to Jacob Keller's suggestions by creating a cover page and reducing
>>   the text within the commits. Applying to the net-next tree as Heiner Kallweit requested.
>>
>> v5:
>>   attempted some new optimisations, which were rejected, but not all and not completely.
>>
>> v4:
>>   fixed complaints as advised by Heiner and checkpatch.pl.
>>   split the patch into five sections to be more easily manipulated and reviewed
>>   introduced r8168_mac_ocp_write_seq()
>>   applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
>>
>> v3:
>>   removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>   avoided duplication of RTL_W32() call code as advised by Heiner.
>>
>> Mirsad Goran Todorovac (5):
>>    r8169: Coalesce r8169_mac_ocp_write/modify calls to reduce spinlock
>>      stalls
>>    r8169: Coalesce RTL8411b PHY power-down recovery calls to reduce
>>      spinlock stalls
>>    r8169: Coalesce mac ocp write and modify for 8168H start to reduce
>>      spinlocks
>>    r8169: Coalesce mac ocp commands for 8125 and 8125B start to reduce
>>      spinlock contention
>>    r8169: Coalesce mac ocp commands for rtl_hw_init_8125 to reduce
>>      spinlocks
>>
>>   drivers/net/ethernet/realtek/r8169_main.c | 304 +++++++++++-----------
>>   1 file changed, 150 insertions(+), 154 deletions(-)
>>
> 
> You still write:
> "a lock storm that will stall all of the cores and CPUs on the same memory controller"
> even though you were informed that that's not the case.
> There's no actual problem, therefore your Fixes tags are incorrect.
> Also net-next is closed at the moment.
> In patches 3-5 I see no benefit. And I have doubts whether the small benefit in
> patch 2 is worth adding all the helpers in patch 1.

After some thought, I would like to have a consensus on these patches, rather than someone
feels defeated or outvoted.

So I will try to reach some common ground, if you think the cause is worth it.

Why is adding six lines of a helper a problem worse than removing 130 lines of callers?

I would hate to think that the Linux kernel developer community became the place where
Authority has higher weight than Reason and Logic.

I have no personal gain from improving these drivers other than the Galactic credits.

One thing I wouldn't like and do not like is the Windows drivers being better because
their programmers are more innovative.

Best regards,
Mirsad Todorovac
