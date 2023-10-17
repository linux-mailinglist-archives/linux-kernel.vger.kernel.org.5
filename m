Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2E7CCE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjJQUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjJQUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:43:57 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73792;
        Tue, 17 Oct 2023 13:43:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 274CF60174;
        Tue, 17 Oct 2023 22:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697575429; bh=JUBD9sFg6gvWejh9DwTAaOrqXlxrXwgq3KheNQfZO8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IxXnZqiOMQYOhBd2Ar0GQ+jYggFnGnghwG8AkKw5qUw/Boi5G8Q6dugd8zxtn7RnR
         9GwSu9NHWSKbxEW/FSsMYOhn0e62WsGN/Z+rbY7ckTTHRIwjyscYVI4IzPM9Kr/60D
         LLYLufqvkaHAjIlxn55Qrpb5E6UOiQ9yWFZOsUGJCBN/sHK4UiP3o6iEq+uCAVSeg5
         f3lFPxy5DmmsiG/tbV3ACO+kiVVnUG6z4FjYpvY2d3H3aLHQrE8fQPMz+eD49Tlgc7
         7rUeNItQSnvlZNSyz7YWa1L1lBgToXDCZyfbz8HkLvMVdeVVV/RYNzzCq46CUzMpLx
         u5Z0Tc+J+uDJw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9gsXl7XC6Y2V; Tue, 17 Oct 2023 22:43:38 +0200 (CEST)
Received: from [192.168.1.6] (78-0-136-77.adsl.net.t-com.hr [78.0.136.77])
        by domac.alu.hr (Postfix) with ESMTPSA id 646035FD95;
        Tue, 17 Oct 2023 22:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697575418; bh=JUBD9sFg6gvWejh9DwTAaOrqXlxrXwgq3KheNQfZO8I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=upAsRbHFMNjM4mBoNTk3F/pixfpKaIMm4pFPoXTSkyEnA48BJnwIkHB4AqKK8uait
         Gr57NtZMz3YHRZ+E5JNSHSblCeakHJHDkZbbc1hCWDm4qXYjddiKareulvvvlpoG0t
         pwyXCOuMQoDpP6TghxVs+aWCbyID518txf+XFAWglcY3Ss81aFZejyFEcuijnCtvj3
         nCapve3ZyZz/nD601EZUurEj1BOEAewo9khbHk8nhT7kyeQWFE6ZqTi9T3TWmYAvn8
         7zgaFiQ7qRG9EceSZlKaTYiBkc/aqaciWXoE5kT2y3NyUaxrZi2WBeDH9bvpOVRLo7
         lFGwFw5CePjKQ==
Message-ID: <992dcaf7-2b24-4e91-8c69-a5471da209ae@alu.unizg.hr>
Date:   Tue, 17 Oct 2023 22:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] r8169: fix the KCSAN reported data-race in rtl_tx
 while reading TxDescArray[entry].opts1
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231016214753.175097-1-mirsad.todorovac@alu.unizg.hr>
 <20231016214753.175097-3-mirsad.todorovac@alu.unizg.hr>
 <20231017200138.GB1940501@kernel.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231017200138.GB1940501@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 22:01, Simon Horman wrote:
> On Mon, Oct 16, 2023 at 11:47:56PM +0200, Mirsad Goran Todorovac wrote:
>> KCSAN reported the following data-race:
>>
>> ==================================================================
>> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>>
>> race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by interrupt on cpu 21:
>> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
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
>> value changed: 0xb0000042 -> 0x00000000
>>
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> ==================================================================
>>
>> The read side is in
>>
>> drivers/net/ethernet/realtek/r8169_main.c
>> =========================================
>>     4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>     4356                    int budget)
>>     4357 {
>>     4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>>     4359         struct sk_buff *skb;
>>     4360
>>     4361         dirty_tx = tp->dirty_tx;
>>     4362
>>     4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>     4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>>     4365                 u32 status;
>>     4366
>>   → 4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>>     4368                 if (status & DescOwn)
>>     4369                         break;
>>     4370
>>     4371                 skb = tp->tx_skb[entry].skb;
>>     4372                 rtl8169_unmap_tx_skb(tp, entry);
>>     4373
>>     4374                 if (skb) {
>>     4375                         pkts_compl++;
>>     4376                         bytes_compl += skb->len;
>>     4377                         napi_consume_skb(skb, budget);
>>     4378                 }
>>     4379                 dirty_tx++;
>>     4380         }
>>     4381
>>     4382         if (tp->dirty_tx != dirty_tx) {
>>     4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>>     4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>>     4385
>>     4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>>     4387                                               rtl_tx_slots_avail(tp),
>>     4388                                               R8169_TX_START_THRS);
>>     4389                 /*
>>     4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>>     4391                  * too close. Let's kick an extra TxPoll request when a burst
>>     4392                  * of start_xmit activity is detected (if it is not detected,
>>     4393                  * it is slow enough). -- FR
>>     4394                  * If skb is NULL then we come here again once a tx irq is
>>     4395                  * triggered after the last fragment is marked transmitted.
>>     4396                  */
>>     4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>     4398                         rtl8169_doorbell(tp);
>>     4399         }
>>     4400 }
>>
>> tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONCE() fixes
>> this KCSAN warning.
>>
>>     4366
>>   → 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
>>     4368                 if (status & DescOwn)
>>     4369                         break;
>>     4370
>>
>> Fixes: ^1da177e4c3f4 ("initial git repository build")
> 
> Hi Mirsad,
> 
> The fixes tag above seems wrong.

Hi, Simon,

It is taken directly from "git blame" as you can check for yourself.

It is supposed to tag the commits prior to the introduction of git.

If you have a better idea how to denote those, I will be happy to learn,
but I have no better clue than what "git blame" gives ...

Best regards,
Mirsad Todorovac
  
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: nic_swsd@realtek.com
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: netdev@vger.kernel.org
>> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Acked-by: Marco Elver <elver@google.com>
> 
> ...
