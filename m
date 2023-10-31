Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA657DC4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjJaDff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:35:33 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A97C6;
        Mon, 30 Oct 2023 20:35:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id EA4BD60173;
        Tue, 31 Oct 2023 04:35:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698723324; bh=iNtfxNB5pt2eCNNHJFfnKIbTVqU89Z6PVc3EJaMDuN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YcpsOHX6tS3WnlRciLwR2cLukVL2s6JR5doHLpA1qMqN5EnJZ8D0JpvoMlk0yyW+t
         oEA5D+ROOTB1BwQkQHzs74ddJLmb4aGad8nKk0NLaGCKZmLTWBIX93k+ZUEqUcRVJu
         7RjQVO33OuBOQl7ScYh44d8v2N+9zUftC7d2TK/3r7/Zrutxz0Qwm3jVAVsvNYZDoj
         7a+N+pmbJghWKl+PczQUEcU7ApY4mB8EliHk/KKirNjmu+Bgt6DuPLhWbRqHaTe6y+
         1qRoyhIJvNTjlAD/xQyEzcIsXPJRaMfDA81DT2/Fi/TqfG9zuhOjlZKVLD8EyCqUn/
         YP3y6YAdy02LA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sw94jxlZRWTT; Tue, 31 Oct 2023 04:35:21 +0100 (CET)
Received: from [192.168.1.6] (78-3-40-166.adsl.net.t-com.hr [78.3.40.166])
        by domac.alu.hr (Postfix) with ESMTPSA id EF9CF60171;
        Tue, 31 Oct 2023 04:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698723321; bh=iNtfxNB5pt2eCNNHJFfnKIbTVqU89Z6PVc3EJaMDuN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s4jJX3oCn3a/bhmI5FUq8L0sdoKWz7PTg2N/WhftWsq9j6NdA1mJBk1uhIGBqsB9W
         zuYAu0QsZqru3o9LETWpnn8GuAXlcZtMhNeb9en/y/SlHt8uIyeZ6SGVrIhfA4mhqZ
         IzlYnPnEvRkxSpPhM8j6imf/J69EWiDn918SQxVDT+BxyBUBn/+wfD/qhd38ZDZ2hi
         l1NI+prPMnIoOwPPG7gETIIepGnw8wJtwtjX9pUHGyLU59fXFQ15kyn/tS4is6Pfa3
         UES8gWIQlsG/vptg+aj1uivn7Z08wpJIkEm066COozJuzXvEUT/lA7Lx4rosGEVkGL
         AlZgFvAJ3sX8Q==
Message-ID: <11f59506-406a-463b-94c1-fe20246a102f@alu.unizg.hr>
Date:   Tue, 31 Oct 2023 04:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery
 programming instructions to reduce spinlock stalls
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr>
 <376db5ae-1bb0-4682-b132-b9852be3c7aa@gmail.com>
 <23428695-fcff-495b-ac43-07639b4f5d08@alu.unizg.hr>
 <30e15e9a-d82e-4d24-be37-1b9d1534c082@gmail.com>
 <9f99c3a4-2752-464b-b37d-58a4f8041804@alu.unizg.hr>
 <bd4a59be-c393-4302-9d32-759e7cbfe255@lunn.ch>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <bd4a59be-c393-4302-9d32-759e7cbfe255@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 02:21, Andrew Lunn wrote:
>> I will not contradict, but the cummulative amount of memory barriers on each MMIO read/write
>> in each single one of the drivers could amount to some degrading of overall performance and
>> latency in a multicore system.
> 
> For optimisations, we like to see benchmark results which show some
> improvements. Do you have any numbers?

Hi, Andrew,

Thank you for your interest in RTL NIC driver optimisations.

My knowledge about the timing costs of synchronisation is mostly theoretical.

By the table below, the cost of LOCK CHPXCHG m,616/32/64 is 52 cycles (in case the
memory location is already in the L3 cache I suppose, cache miss can makes things worse,
but we are hitting the same lock repeatedly).

So, we have (in the best case) 52 clocks for lock, 52 for unlock (for the uncontentended
case).

This means 104 cycle x 130 sequential lock+unlock pairs = 13520 clk ~ 3.38 us on a 4 GHz
machine (5.633 us on a 2.4 GHz CPU) while the multicore system does nothing but locking
and unclocking after therecovery from the loss of PHY.

We are talking about the RTl8411b.

The other case it the rather new 8125/8125b.

     static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
     {
         rtl_pcie_state_l2l3_disable(tp);

         RTL_W16(tp, 0x382, 0x221b);
         RTL_W8(tp, 0x4500, 0);
         RTL_W16(tp, 0x4800, 0);

         /* disable UPS */
         r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);

         RTL_W8(tp, Config1, RTL_R8(tp, Config1) & ~0x10);

         r8168_mac_ocp_write(tp, 0xc140, 0xffff);
         r8168_mac_ocp_write(tp, 0xc142, 0xffff);

         r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x03a9);
         r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
         r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);

         /* disable new tx descriptor format */
         r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);

         if (tp->mac_version == RTL_GIGA_MAC_VER_63)
                 r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
         else
                 r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);

         if (tp->mac_version == RTL_GIGA_MAC_VER_63)
                 r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
         else
                 r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);

         r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
         r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
         r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
         r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
         r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
         r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
         r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
         r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
         r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);

         r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
         r8168_mac_ocp_modify(tp, 0xeb54, 0x0000, 0x0001);
         udelay(1);
         r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
         RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);

         r8168_mac_ocp_write(tp, 0xe098, 0xc302);

         rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);

         if (tp->mac_version == RTL_GIGA_MAC_VER_63)
                 rtl8125b_config_eee_mac(tp);
         else
                 rtl8125a_config_eee_mac(tp);

         rtl_disable_rxdvgate(tp);
    }

There are 22 calls to mac ocp write/modify, each having a raw_spin_lock_irqsave()/
raw_spin_unlock_irqrestore() pair.

The minimal timing cost is 22x104 = 2288 cycles or a total of 0.572 us on a 4 GHz CPU,
preventing all cores from the memory access. (0.953 us on a 2.4 GHz system).

This does happen only at the startup apparently, but also at each rtl_reset_work(tp)
and rtl8169_up(tp), rtl_open() at driver load, and rtl8169_runtime_resume() called by
the rtl8169_resume().

The revised version does only 2 pairs of raw_spin_lock_irqsave()/
raw_sping_unlock_irqrestore(), but I admit it might be harder to read and maintain.

My knowledge of the Linux kernel network stack isn't that deep, and I can't tell how
often rtl8169_resume() is called in real life and how to reproduce and benchmark that
call.

This is a sort of a "loophole optimisation", I don't have the numbers on the impact
on the entire Linux on i.e. 16 core/32 threads Ryzen 9 7950X CPU.

Probably things would be worse on a 64 core CPU, because the 5.633 us and 0.953 us
would have to be multiplied by the number of blocked cores, amounting to estimated
total CPU cost of 360 us and 61 us respectively. Per NIC reset.

However, I am relatively new to the r8169 driver, I came across while analysing
KCSAN reports since the beginning of August. So ATM I don't have any benchmarks
to confirm the theoretical findings.

I realise that maintainers have to cherry pick patches or the kernel of +35M lines
would become way too cluttered and unmaintainable.

NOTE: The numbers are only valid for a x86_64 system.

Regards,
Mirsad

SOURCE AND REFERENCES:

Synchronization (Source: [1])
===============================================
instruction	operands	ops	latency			
===============================================	
LOCK ADD 	m,r		1	 ~55
XADD 		m,r		4	 10
LOCK XADD 	m,r 		4	 ~51
CMPXCHG 	m8,r8		5	 15
LOCK CMPXCHG 	m8,r8		5	 ~51
CMPXCHG 	m,r16/32/64	6	 14
LOCK CMPXCHG 	m,r16/32/64	6	 ~52
CMPXCHG8B 	m64		18	 15
LOCK CMPXCHG8B 	m64		18	 ~53
CMPXCHG16B 	m128		22	 52
LOCK CMPXCHG16B m128		22	 ~94
===============================================

Explanation of column headings:
Instruction:
	Instruction name. cc means any condition code. For example, Jcc can be JB, JNE,
	etc.

Operands:
	i = immediate constant, r = any register, r32 = 32-bit register, etc., mm = 64 bit
	mmx register, x = 128 bit xmm register, y = 256 bit ymm register, m = any memory
	operand including indirect operands, m64 means 64-bit memory operand, etc.
Ops:
	Number of macro-operations issued from instruction decoder to schedulers. In-
	structions with more than 2 macro-operations use microcode.
Latency:
	This is the delay that the instruction generates in a dependency chain. The num-
	bers are minimum values. Cache misses, misalignment, and exceptions may in-
	crease the clock counts considerably. Floating point operands are presumed to be
	normal numbers. Denormal numbers, NAN's, infinity and exceptions increase the
	delays. The latency listed does not include the memory operand where the listing
	for register and memory operand are joined (r/m).

[1] TL;DR https://www.agner.org/optimize/instruction_tables.pdf
[2] TL;DR http://www.rdrop.com/users/paulmck/scalability/paper/whymb.2010.07.23a.pdf

