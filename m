Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF37CB5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjJPVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjJPVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:52:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3622BA1;
        Mon, 16 Oct 2023 14:52:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E39BD60189;
        Mon, 16 Oct 2023 23:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697493165; bh=breKMwt7w6VJh9o7hgoXVounUXb3N/Qe3NZUJalqboI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dRtBDgohXCnaY4JUIV/qAvAP/4qDOw0rpGC/T3GEeHrhhgQSoOLXD6+Drx8R2Vf+Q
         FRBNa/ranrPc38aAzvjelZ1RPGNQ04xbBWjuADG8CKv0zdr3tYdnTj6jiGwrqDBIBe
         R/NSy5DEwg2RQ4SRIXM0WV75enGa7jCyh1ZBHK1wz6xjJOPo8ALqxq1Rmph11Em40Y
         dlKUl0mVGZ8kg4AzDwEpmELC+f575lk/NrwGwnH+BFhEao+Bwba/RXP0EiqYnVBLIm
         H+6IhbIsF4bmiBY9Plt9lex2Zxt2kx2vVizu+jNI22aTHOrBcLY2bG2fDN+ZwBX+/5
         cAK0DUZugr9pg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lcHBQu9R40vF; Mon, 16 Oct 2023 23:52:42 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-223.adsl.net.t-com.hr [78.3.40.223])
        by domac.alu.hr (Postfix) with ESMTPSA id A89ED60186;
        Mon, 16 Oct 2023 23:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697493162; bh=breKMwt7w6VJh9o7hgoXVounUXb3N/Qe3NZUJalqboI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MaBBLw/b1Gx2SnJzOMu8HVSKYN48AaJCebT9us7vcvhHPtdNtvw4wS6hCA3sbZKP3
         hPyXYTAezJSiWQWaC1yHbBLK6Pd2DBGt7Dd1DJwiN4f7AxsAd1YJiNLfw046Qrv9Zq
         YTLAZve5inb7rawvPhPusTPcO0Qlry4J3Se8TViRp4Vz/ZIo0NnZeU9WgIrMnTZDA9
         r6fWQR9W6kQ3cV3ijH49Oy/LZwsOHuoreP08kBQegnj48lxVEgCwRRS4s4VPSr3Xh/
         QCqOjTzk9uuzC4pifiQqr3u2sGOFU2LDyxupQVsXhxGzqaIRd2IOF+Jx1r+SjwDi6f
         +8/i5KZKV0nLA==
Message-ID: <3c64ef22-9e06-402e-a6e2-4e063143ed71@alu.unizg.hr>
Date:   Mon, 16 Oct 2023 23:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] r8169: fix the KCSAN reported data race in rtl_rx
 while reading desc->opts1
To:     Marco Elver <elver@google.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20231014031257.178630-1-mirsad.todorovac@alu.unizg.hr>
 <20231014031257.178630-3-mirsad.todorovac@alu.unizg.hr>
 <CANpmjNMsct0Y6j3Q1A0+_z6Zuy86SceRAzRn_iVqr0kaX5+Kfw@mail.gmail.com>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CANpmjNMsct0Y6j3Q1A0+_z6Zuy86SceRAzRn_iVqr0kaX5+Kfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/23 09:35, Marco Elver wrote:
> On Sat, 14 Oct 2023 at 05:16, Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> KCSAN reported the following data-race bug:
>>
>> ==================================================================
>> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>>
>> race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by interrupt on cpu 21:
>> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>> __napi_poll (net/core/dev.c:6527)
>> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>> __do_softirq (kernel/softirq.c:553)
>> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>> irq_exit_rcu (kernel/softirq.c:647)
>> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
>> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
>> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>> call_cpuidle (kernel/sched/idle.c:135)
>> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>
>> value changed: 0x80003fff -> 0x3402805f
>>
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> ==================================================================
>>
>> drivers/net/ethernet/realtek/r8169_main.c:
>> ==========================================
>>     4429
>>   → 4430                 status = le32_to_cpu(desc->opts1);
>>     4431                 if (status & DescOwn)
>>     4432                         break;
>>     4433
>>     4434                 /* This barrier is needed to keep us from reading
>>     4435                  * any other fields out of the Rx descriptor until
>>     4436                  * we know the status of DescOwn
>>     4437                  */
>>     4438                 dma_rmb();
>>     4439
>>     4440                 if (unlikely(status & RxRES)) {
>>     4441                         if (net_ratelimit())
>>     4442                                 netdev_warn(dev, "Rx ERROR. status = %08x\n",
>>
>> Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear up the access to
>> desc->opts1 which can be written to concurrently. READ_ONCE() should prevent that from
>> happening:
>>
>>     4429
>>   → 4430                 status = le32_to_cpu(READ_ONCE(desc->opts1));
>>     4431                 if (status & DescOwn)
>>     4432                         break;
>>     4433
>>
>> As the consequence of this fix, this KCSAN warning was eliminated.
>>
>> Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_private")
>> Suggested-by: Marco Elver <elver@google.com>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: nic_swsd@realtek.com
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Double sign-off? Otherwise,
> 
> Acked-by: Marco Elver <elver@google.com>

Missed that one, sorry.

Fixed it in v2 of the patch.

Best regards,
Mirsad Todorovac
  
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 281aaa851847..81be6085a480 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>>                  dma_addr_t addr;
>>                  u32 status;
>>
>> -               status = le32_to_cpu(desc->opts1);
>> +               status = le32_to_cpu(READ_ONCE(desc->opts1));
>>                  if (status & DescOwn)
>>                          break;
>>
>> --
>> 2.34.1
>>
