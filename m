Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51C7DBC45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjJ3PCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjJ3PCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:02:41 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A7CC;
        Mon, 30 Oct 2023 08:02:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B6BEE60173;
        Mon, 30 Oct 2023 16:02:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698678153; bh=22eTnrSXo0qveDQ6OiPbF7NrLKb+fZPtAQAqeW8kU8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P0eIBBWfra5yh6tZgQYYqc9+NhKc/aRpoMq3fIrsejz34Su96imEMjemIMFDjSEAF
         JFM/7ZSJ5z7438LpnJIF05Wbs8SmxKfiQwpvcA+29eBYqrC1p11RlrksTWVkq3zwMI
         5tKG1PIaE5nPQxggM6AUy7ffmuz4VC+COmdugJXxeSzpux1mnzj19YJRedj2+e953j
         CgFn5+TTjGtJq/lhEGbAvcZFR41nLZIOKC0K/YUtmICCzwm8KP5pQAky7mbNgcdUhl
         23RNUajnfDAlkudCg9rJ+7/++zmNOs1F/9myDkwuMNVm7JjP1FtOy4UtZ26wQsvLXq
         DBVjx8qPASg8w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aqxIGnWhPxeg; Mon, 30 Oct 2023 16:02:30 +0100 (CET)
Received: from [192.168.1.6] (78-3-40-166.adsl.net.t-com.hr [78.3.40.166])
        by domac.alu.hr (Postfix) with ESMTPSA id E10A560171;
        Mon, 30 Oct 2023 16:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698678150; bh=22eTnrSXo0qveDQ6OiPbF7NrLKb+fZPtAQAqeW8kU8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vidJ07S1laWKU2C4d5BsRAwOT8IZhx4veNylAVJ+xUsYrlPtbEZpV4+BwcB6nJ6TT
         wiygdvlcG6KYpPyClEhgkRAOn4LkA+QCKotPvLhLg3D9ftDR+zQwXP13eAyuxB6BJM
         hN5dmTlvsp5V6vaErw3+8TofMkvKRM7RIiI+AvCy/TfHbs1V9Q5zodYnDKgQWVc464
         SU2s2vckll0/joZXmmmzHitYCkCHRH1HNeGhqwYFuWSjvHUHFzRUiVDwk3RRvZokg2
         n7UazbOwaYQb8VKeD+djuYvc2s8uOq2HQ1HnB5y8o1o2KxiJYlHcicEDecMn0joXTc
         a/MBqnYuSeoIw==
Message-ID: <e9cb3842-3492-4b85-b7ad-77605a5836c3@alu.unizg.hr>
Date:   Mon, 30 Oct 2023 16:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] r8169: Coalesce mac ocp write and modify for 8125
 and 8125B start to reduce spinlocks
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
 <20231029183600.451694-6-mirsad.todorovac@alu.unizg.hr>
 <7fd8c40d-5209-4f7c-8c69-5138d0eb0bc5@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <7fd8c40d-5209-4f7c-8c69-5138d0eb0bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 15:02, Heiner Kallweit wrote:
> On 29.10.2023 19:36, Mirsad Goran Todorovac wrote:
>> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
>> the startup of 8125 and 8125B involve implicit spin_lock_irqsave() and
>> spin_unlock_irqrestore() on each invocation.
>>
>> Coalesced with the corresponding helpers r8168_mac_ocp_write_seq() and
>> r8168_mac_ocp_modify_seq() into sequential write or modidy with a sinqle
>> pair of spin_lock_irqsave() and spin_unlock_irqrestore(), these calls
>> reduce overall lock contention.
>>
>> Fixes: f1bce4ad2f1ce ("r8169: add support for RTL8125")
>> Fixes: 0439297be9511 ("r8169: add support for RTL8125B")
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: nic_swsd@realtek.com
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
>> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>> v5:
>>   added unlocked primitives to allow mac ocs modify grouping
>>   applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>>   some formatting fixes to please checkpatch.pl
>>
>> v4:
>>   fixed complaints as advised by Heiner and checkpatch.pl
>>   split the patch into five sections to be more easily manipulated and reviewed
>>   introduced r8168_mac_ocp_write_seq()
>>   applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
>>
>> v3:
>>   removed register/mask pair array sentinels, so using ARRAY_SIZE().
>>   avoided duplication of RTL_W32() call code as advised by Heiner.
>>
>>   drivers/net/ethernet/realtek/r8169_main.c | 75 +++++++++++++----------
>>   1 file changed, 44 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 50fbacb05953..0778cd0ba2e0 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -3553,6 +3553,28 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>>   
>>   static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>   {
>> +	static const struct e_info_regmaskset e_info_8125_common_1[] = {
>> +		{ 0xd3e2, 0x0fff, 0x03a9 },
>> +		{ 0xd3e4, 0x00ff, 0x0000 },
>> +		{ 0xe860, 0x0000, 0x0080 },
>> +	};
>> +
>> +	static const struct e_info_regmaskset e_info_8125_common_2[] = {
>> +		{ 0xc0b4, 0x0000, 0x000c },
>> +		{ 0xeb6a, 0x00ff, 0x0033 },
>> +		{ 0xeb50, 0x03e0, 0x0040 },
>> +		{ 0xe056, 0x00f0, 0x0030 },
>> +		{ 0xe040, 0x1000, 0x0000 },
>> +		{ 0xea1c, 0x0003, 0x0001 },
>> +		{ 0xe0c0, 0x4f0f, 0x4403 },
>> +		{ 0xe052, 0x0080, 0x0068 },
>> +		{ 0xd430, 0x0fff, 0x047f },
>> +		{ 0xea1c, 0x0004, 0x0000 },
>> +		{ 0xeb54, 0x0000, 0x0001 },
>> +	};
>> +
>> +	unsigned long flags;
>> +
>>   	rtl_pcie_state_l2l3_disable(tp);
>>   
>>   	RTL_W16(tp, 0x382, 0x221b);
>> @@ -3560,47 +3582,38 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>   	RTL_W16(tp, 0x4800, 0);
>>   
>>   	/* disable UPS */
>> -	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>> +
>> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>> +	__r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>>   
>>   	RTL_W8(tp, Config1, RTL_R8(tp, Config1) & ~0x10);
>>   
>> -	r8168_mac_ocp_write(tp, 0xc140, 0xffff);
>> -	r8168_mac_ocp_write(tp, 0xc142, 0xffff);
>> +	__r8168_mac_ocp_write(tp, 0xc140, 0xffff);
>> +	__r8168_mac_ocp_write(tp, 0xc142, 0xffff);
>>   
>> -	r8168_mac_ocp_modify(tp, 0xd3e2, 0x0fff, 0x03a9);
>> -	r8168_mac_ocp_modify(tp, 0xd3e4, 0x00ff, 0x0000);
>> -	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
>> +	__r8168_mac_ocp_modify_seq(tp, e_info_8125_common_1);
>>   
>>   	/* disable new tx descriptor format */
>> -	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>> +	__r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>>   
>> -	if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>> -		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
>> -	else
>> -		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>> +	if (tp->mac_version == RTL_GIGA_MAC_VER_63) {
>> +		__r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
>> +		__r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
>> +	} else {
>> +		__r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>> +		__r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
>> +	}
>> +
>> +	__r8168_mac_ocp_modify_seq(tp, e_info_8125_common_2);
>> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>   
>> -	if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>> -		r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
>> -	else
>> -		r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0020);
>> -
>> -	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
>> -	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
>> -	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
>> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
>> -	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>> -	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
>> -	r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
>> -	r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
>> -	r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
>> -
>> -	r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
>> -	r8168_mac_ocp_modify(tp, 0xeb54, 0x0000, 0x0001);

[1] I think we have a candidate for a squeeze here in this driver.

>>   	udelay(1);
>> -	r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
>> -	RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
>>   
>> -	r8168_mac_ocp_write(tp, 0xe098, 0xc302);
>> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>> +	__r8168_mac_ocp_modify(tp, 0xeb54, 0x0001, 0x0000);
>> +	RTL_W16(tp, 0x1880, RTL_R16(tp, 0x1880) & ~0x0030);
>> +	__r8168_mac_ocp_write(tp, 0xe098, 0xc302);
>> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>>   
>>   	rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);
>>   
> 
> All this manual locking and unlocking makes the code harder
> to read and more error-prone. Maybe, as a rule of thumb:
> If you can replace a block with more than 10 mac ocp ops,
> then fine with me
As I worked with another German developer, Mr. Frank Heckenbach from the GNU Pascal project,
I know that Germans are pedantic and reliable :-)

If this rtl_hw_start_8125_common() is called only once, then maybe every memory bus cycle
isn't worth saving, and then maybe the additional complexity isn't worth adding (but it
was fun doing, and it works with my NIC).

AFAIK, a spin_lock_irqsave()/spin_unlock_irqrestore() isn't a free lunch as you know, and I read
from the manuals that on modern CPUs a locked ADD $0, -128(%esp) or something takes about 50
clock cycles, in which all cores have to wait.

Doing that in storm of 10 lock/unlock pairs amounts to 500 cycles or 125 ns in the best case
on a 4 GHz CPU.

But I trust that you as the maintainer have the big picture and greater insight in the actual hw.

Elon Musk said that the greatest error in engineering is optimising stuff that never should
have been written.

As I like my RTL 8125b NIC to be fast (TM), I am not giving up on it.

Just recalled that you mentioned that it supports RSS. Is it feasible to add it to the r8169
driver?

It is OK for me that we have a formal and less formal mode of communication and switch between
them.

Thank you for all your quick reviews, much obliged, thank you for partially accepting the patches,
but I think I need to sleep over it before submitting a new version.

Regards,
Mirsad Todorovac
