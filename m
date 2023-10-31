Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0AD7DC501
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjJaDvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjJaDvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:51:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D867DA;
        Mon, 30 Oct 2023 20:51:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 38F3360173;
        Tue, 31 Oct 2023 04:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698724276; bh=wAByPrIeqskUlLE5RJQre4suY8u+DwNLdrNXyDdTsSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=inDV0yolir6Ic66YpXC80ySoacQmO2MCqqhqSHsrxpvvlndmGQzX3H7muovkIdkIQ
         fckqBOLheeXOgUjNJLViPpQyIl+XeiX1Iy53rk5YOYNxbQjsrRVkl5FidiHYK77Eqc
         YBtF4xublh8qBFW98M6KNE8uqTHMdrIDdZkZ44PIJH72QCaOUmM0lUZAh2o9pX4ROd
         hWkXFLL++Yridv0aSxPq3vQHHRHRpnLcpqQ8Yo5QJyel4CjKPnzziYZTwkUfZ520Yu
         2RnPllUoH9B/NUuPON5s8PU+3YLU1/NJUhHbP7osoX+VygnnlH/jXsFaMvbUP9wdDJ
         TNwIRQGUDhALA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h9CMYgsOMj6U; Tue, 31 Oct 2023 04:51:13 +0100 (CET)
Received: from [192.168.1.6] (78-3-40-166.adsl.net.t-com.hr [78.3.40.166])
        by domac.alu.hr (Postfix) with ESMTPSA id 43C9860171;
        Tue, 31 Oct 2023 04:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698724273; bh=wAByPrIeqskUlLE5RJQre4suY8u+DwNLdrNXyDdTsSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J3nLHOzebMra/rg4q957eSJhSLZIo9aPqPOmEbGe515ZaRUzQVGMlDrue8bBOkkCf
         9LBZfDl1XtP3MSrv6y5GhZdNReOs/e8ckTa8hSwJmdWBHQYOs87Y+4lqsOUlaXkOnn
         BHlUR0z1xrPyUZ5idHLuKY/UlMogU0KBSXAoXeYGVq4l9JFWxQEuH0VFqVL4DxX6VD
         h8ksADkhvpEnx9VZ9JOn6Xqjmz9hiORgT+/unkZeZOsd6LTpCW3fHhgMNqDr3m/J9L
         RxXb7dnQzyznfzk2eq/v+ndKBtkbEqj3GKVPKazQ8MUEv/oasEeUm4J5K7FIVKBGgM
         FFFTB8xpy2PCw==
Message-ID: <19e2d5fc-7e30-4bb2-943c-f83b44099192@alu.unizg.hr>
Date:   Tue, 31 Oct 2023 04:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
 <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
 <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
 <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 00:14, Jacob Keller wrote:
> 
> 
> On 10/30/2023 3:08 PM, Heiner Kallweit wrote:
>> On 30.10.2023 22:50, Jacob Keller wrote:
>>>
>>>
>>> On 10/29/2023 4:04 AM, Mirsad Goran Todorovac wrote:> A pair of new
>>> helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
>>>> are introduced.
>>>>
>>>> The motivation for these helpers was the locking overhead of 130 consecutive
>>>> r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
>>>> if the PHY is powered-down.
>>>>
>>>> To quote Heiner:
>>>>
>>>>      On RTL8411b the RX unit gets confused if the PHY is powered-down.
>>>>      This was reported in [0] and confirmed by Realtek. Realtek provided
>>>>      a sequence to fix the RX unit after PHY wakeup.
>>>>
>>>> A series of about 130 r8168_mac_ocp_write() calls is performed to program the
>>>> RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
>>>> spin_unlock_irqrestore().
>>>>
>>>> Each mac ocp write is made of:
>>>>
>>>>      static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>>                        u32 data)
>>>>      {
>>>>          if (rtl_ocp_reg_failure(reg))
>>>>              return;
>>>>
>>>>          RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
>>>>      }
>>>>
>>>>      static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
>>>>                      u32 data)
>>>>      {
>>>>          unsigned long flags;
>>>>
>>>>          raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>>>>          __r8168_mac_ocp_write(tp, reg, data);
>>>>          raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>>>      }
>>>>
>>>> Register programming is done through RTL_W32() macro which expands into
>>>>
>>>>      #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))
>>>>
>>>> which is further (on Alpha):
>>>>
>>>>      extern inline void writel(u32 b, volatile void __iomem *addr)
>>>>      {
>>>>          mb();
>>>>          __raw_writel(b, addr);
>>>>      }
>>>>
>>>> or on i386/x86_64:
>>>>
>>>>      #define build_mmio_write(name, size, type, reg, barrier) \
>>>>      static inline void name(type val, volatile void __iomem *addr) \
>>>>      { asm volatile("mov" size " %0,%1": :reg (val), \
>>>>      "m" (*(volatile type __force *)addr) barrier); }
>>>>
>>>>      build_mmio_write(writel, "l", unsigned int, "r", :"memory")
>>>>
>>>> This obviously involves iat least a compiler barrier.
>>>>
>>>> mb() expands into something like this i.e. on x86_64:
>>>>
>>>>      #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
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
>>>>      static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>>>      {
>>>>
>>>>          ...
>>>>
>>>>          /* The following Realtek-provided magic fixes an issue with the RX unit
>>>>           * getting confused after the PHY having been powered-down.
>>>>           */
>>>>
>>>>          static const struct recover_8411b_info init_zero_seq[] = {
>>>>              { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
>>>>              ...
>>>>          };
>>>>
>>>>          ...
>>>>
>>>>          r8168_mac_ocp_write_seq(tp, init_zero_seq);
>>>>
>>>>          ...
>>>>
>>>>      }
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
>>>
>>>
>>> I might have chosen to send some of this information as the cover letter
>>> for the series instead of just as part of the commit message for [1/5],
>>> but either way:
>>>
>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Cover letter is still missing, and there's a v5 already.
>> Good example why we have the "max one version per day" rule.
>>
>> There's still some issues with the series, see my review comments
>> for v5. As-is I'd NAK the series.

I realise we need to keep the development process coherent. I am sorry that
my inexperience in the patch submission process made the whole series look bad.

As I previously stated to Mr. Kallweit, I will do the required number of iterations
to ensure the quality of the patches (I saw some go up to over 20 versions).

> Heh, ya. A v5 was sent without there being a single (public) comment on
> the list prior to my reviewing. I didn't notice the v5, and my mail
> scripts pointed out this series didn't have anyone who'd looked at it
> yet.. I guess I could have searched for and noticed a newer version.

Well, dear Sir,

I see I owe you an apology for I did not know about the "max one version per day"
rule. I was warned however not to overwhelm the maintainers by Guillaume Nault in
January and somehow I hypomanicaly OCD'd on this. My fault entirely.

I hope we can mend this.

I guess this is my time to take a break, do some homework and return to the drawing
board.

Besides, now we are in the merge window anyway, so I should thank Mr. Kallweit for
the special attention and for making an exception.

Am I allowed to keep Mr. Keller's Reviewed-by: tags on the reviewed diffs provided
that I fix the cover letter issue and objections?

Have a nice day.

Regards,
Mirsad
