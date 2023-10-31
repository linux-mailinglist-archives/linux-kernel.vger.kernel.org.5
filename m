Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5E7DCDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbjJaN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjJaN1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:27:11 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D326DE;
        Tue, 31 Oct 2023 06:27:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id CFCFF60173;
        Tue, 31 Oct 2023 14:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1698758825; bh=DanNm88XUgY4cCmYA7veb/t2Jr/OILbimm0AI4lsrT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ItcdqIY9GM5QifCpq9Abm65YP4B7CzfMMwuseV7iSD+uB+clgHtlFNJuF8SI2m5dS
         Uj6jJprtTm3yqEtuQGuKvxCy77zAiL6dsh9RDiQY5Y5sE8KL/fTP31W2XuaiKSNC6z
         NL2nS8sFUB4wSZ0+XIpGFoUo4A8JuIPmjFHIGHeUaVLRr8cTuf4qpodODFCJYzND9D
         E7xBBgiTFQMGYyMG0TeotoR9tEF2I7BRb3jDVuzInTblxSNSn8dzfYLax5Z+8ydcK7
         w6bgxbHeGjlfg0xtCDVkRsr9qiYC5CfFJVbOd99A4wCJ5hlF2oiP/QcCpW+Zhfgujz
         kYz2qPjmyKhIQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0iR53ivx4SLh; Tue, 31 Oct 2023 14:27:03 +0100 (CET)
Received: from [IPV6:2001:b68:2:2600:14cd:7d53:817e:e1c2] (unknown [IPv6:2001:b68:2:2600:14cd:7d53:817e:e1c2])
        by domac.alu.hr (Postfix) with ESMTPSA id 5285460171;
        Tue, 31 Oct 2023 14:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698758823; bh=DanNm88XUgY4cCmYA7veb/t2Jr/OILbimm0AI4lsrT0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fOxCpz9X2f0LPSlfhPwMC0UeFb48WzHt0CGBgfS2vTv1wNxl7c4MXxpmcnQDs5r69
         y2dMPSuzPmCleLCIldt5s0+NWbASYvLCThFvOPCtrAauqM9MF2hfBTuuAIzVEuxlVQ
         eI90jOFPv0UzyQhv8lRNe9K3tA5jNo15rfERel7BMNa3r21WneDjsK3NOYIYX96OPG
         4xRli/Hp7nCvxYeoay3aPWd3bGXa+ljtstrRZRsWTpg2sF0940Jgx0mC9HDBpvnLoJ
         AXRG8z+HmuMK8wL/aafwKUIPLJJX/nLSnIVdQ0DbHqZ2xlD3gMfcoI1n6bW8WIzBxC
         HJauN30ew34rw==
Message-ID: <06ac1128-92dc-4330-a68b-ae29dfd7105e@alu.unizg.hr>
Date:   Tue, 31 Oct 2023 14:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery
 programming instructions to reduce spinlock stalls
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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
 <11f59506-406a-463b-94c1-fe20246a102f@alu.unizg.hr>
 <7fa02dd1-c894-4980-8439-4dc1e22d3634@lunn.ch>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <7fa02dd1-c894-4980-8439-4dc1e22d3634@lunn.ch>
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



On 10/31/2023 1:38 PM, Andrew Lunn wrote:
> On Tue, Oct 31, 2023 at 04:35:19AM +0100, Mirsad Todorovac wrote:
>> On 10/31/23 02:21, Andrew Lunn wrote:
>>>> I will not contradict, but the cummulative amount of memory barriers on each MMIO read/write
>>>> in each single one of the drivers could amount to some degrading of overall performance and
>>>> latency in a multicore system.
>>>
>>> For optimisations, we like to see benchmark results which show some
>>> improvements. Do you have any numbers?
>>
>> Hi, Andrew,
>>
>> Thank you for your interest in RTL NIC driver optimisations.
>>
>> My knowledge about the timing costs of synchronisation is mostly theoretical.
> 
> The kernel tends to be very practical. Maybe try to turn the
> theoretical knowledge into practice. Write a benchmark test, or see if
> any of the existing RT Linux tests show there is a real problem here,
> and your changes fix it.

I stand corrected. Real benchmarks would indeed say more than the visual
inspection of the code.

As I see, as a maintainer of the PHYLIB you certainly have a greater
insight. What I've done is maybe too aggressive "loophole optimisation",
without much consideration of what Mr. Heiner Kallweit addressed as hot 
paths and not so hot (less trodden) paths.

Best regards,
Mirsad Todorovac
