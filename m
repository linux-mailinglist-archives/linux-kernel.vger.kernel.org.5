Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000A27D9CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbjJ0PO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbjJ0PO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:14:56 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC518F;
        Fri, 27 Oct 2023 08:14:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1814D6019B;
        Fri, 27 Oct 2023 17:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1698419688; bh=p7ODZLJ9pR+OkCbxiJqEj6697Tap5k6NrQ8fJuyEBHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ka83Su7UkcsnO8NKa7/AkboNEZ48wdf59nrq+IVTXntrdqH9Yz0cZrUCQpTTUDZrA
         /Ov7guXkApklX/M0i3HhMdMpAy5VmiWlqkVLkINvknhyvdLn56iLzrQZUIUdHqAyzW
         g6DEaB/pF2uomNx8iiFen4Kgc/huyGunpya9JGeFWIf1AKsRj7svdnnI9YDbMOhusQ
         /Wl/cDe5vYzhMnR8IL0cCFVxN6SXF8mAxaDHJ1tNtZ8DtQWwx71O0uybtF47BZAHbo
         MyCImpjwO82vxJxhDMko6Y8qRUUv70XcElLYTGU20MT/UXrZ9DdksPxo+1CmZezrUO
         rXHFFYrLm146w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LU3qcBOAwqib; Fri, 27 Oct 2023 17:14:45 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:646f:d9a1:a315:536c] (unknown [IPv6:2001:b68:2:2600:646f:d9a1:a315:536c])
        by domac.alu.hr (Postfix) with ESMTPSA id 522C960197;
        Fri, 27 Oct 2023 17:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698419685; bh=p7ODZLJ9pR+OkCbxiJqEj6697Tap5k6NrQ8fJuyEBHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CQC3antG1ZlMXyK9uViqsnfh4BWYi7vu/f3gKiWZz97WnJZbA+YIy0SF7mBLS4o4d
         RLZxR1XM3fdzTw3gBVIKJizaD6m2dI+ohkfLUjOZu/HSem2t1iHYbhfTNHx4vXnytH
         0tpLbQ/4nAAXbUrpZ1UGkaFaGxDdPn0pcYunYSVYetrN0whkKOZ8Vl07bEuradGrzz
         uPmR8V5vgUHUKy0lG5myqXJZA3hJpas1MxJGYCX6bTgkfUKrEyJ/pr3+eW05FZza9O
         lygh6pfO+lyDgAkRDF4+mp0q6150RZTOy833H52t+PXvl8XGu6GbcoE4HdDEQJUlM8
         RRv8D5ohFCSjg==
Message-ID: <1093eb64-6b24-4b5a-bd6c-f48014d79ec8@alu.unizg.hr>
Date:   Fri, 27 Oct 2023 17:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20230927184158.243575-1-mirsad.todorovac@alu.unizg.hr>
 <0a201a6f-90dd-403c-97d0-94372be1e3e6@gmail.com>
 <42e14bf6-73a0-400a-966a-09a86ecbeff0@alu.unizg.hr>
 <cf476467-fee1-4c96-ab63-2bbf183faaba@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <cf476467-fee1-4c96-ab63-2bbf183faaba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2023 11:23 PM, Heiner Kallweit wrote:
> On 22.10.2023 19:24, Mirsad Todorovac wrote:
>> On 9/27/23 21:52, Heiner Kallweit wrote:
>>> On 27.09.2023 20:41, Mirsad Goran Todorovac wrote:
>>>> KCSAN reported the following data-race:
>>>>
>>>> ==================================================================
>>>> BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r8169]
>>>>
>>>> write (marked) to 0xffff888102474b74 of 4 bytes by task 5358 on cpu 29:
>>>> rtl8169_start_xmit (drivers/net/ethernet/realtek/r8169_main.c:4254) r8169
>>>> dev_hard_start_xmit (./include/linux/netdevice.h:4889 ./include/linux/netdevice.h:4903 net/core/dev.c:3544 net/core/dev.c:3560)
>>>> sch_direct_xmit (net/sched/sch_generic.c:342)
>>>> __dev_queue_xmit (net/core/dev.c:3817 net/core/dev.c:4306)
>>>> ip_finish_output2 (./include/linux/netdevice.h:3082 ./include/net/neighbour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:233)
>>>> __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:293)
>>>> ip_finish_output (net/ipv4/ip_output.c:328)
>>>> ip_output (net/ipv4/ip_output.c:435)
>>>> ip_send_skb (./include/net/dst.h:458 net/ipv4/ip_output.c:127 net/ipv4/ip_output.c:1486)
>>>> udp_send_skb (net/ipv4/udp.c:963)
>>>> udp_sendmsg (net/ipv4/udp.c:1246)
>>>> inet_sendmsg (net/ipv4/af_inet.c:840 (discriminator 4))
>>>> sock_sendmsg (net/socket.c:730 net/socket.c:753)
>>>> __sys_sendto (net/socket.c:2177)
>>>> __x64_sys_sendto (net/socket.c:2185)
>>>> do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>>>> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>>>>
>>>> read to 0xffff888102474b74 of 4 bytes by interrupt on cpu 21:
>>>> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4397 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>>>> __napi_poll (net/core/dev.c:6527)
>>>> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>>>> __do_softirq (kernel/softirq.c:553)
>>>> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>>>> irq_exit_rcu (kernel/softirq.c:647)
>>>> common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
>>>> asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
>>>> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>>>> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>>>> call_cpuidle (kernel/sched/idle.c:135)
>>>> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>>>> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>>>> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>>>> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>>>
>>>> value changed: 0x002f4815 -> 0x002f4816
>>>>
>>>> Reported by Kernel Concurrency Sanitizer on:
>>>> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>>>> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>>> ==================================================================
>>>>
>>>> The write side of drivers/net/ethernet/realtek/r8169_main.c is:
>>>> ==================
>>>>      4251         /* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
>>>>      4252         smp_wmb();
>>>>      4253
>>>>    → 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
>>>>      4255
>>>>      4256         stop_queue = !netif_subqueue_maybe_stop(dev, 0, rtl_tx_slots_avail(tp),
>>>>      4257                                                 R8169_TX_STOP_THRS,
>>>>      4258                                                 R8169_TX_START_THRS);
>>>>
>>>> The read side is the function rtl_tx():
>>>>
>>>>      4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>>>      4356                    int budget)
>>>>      4357 {
>>>>      4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
>>>>      4359         struct sk_buff *skb;
>>>>      4360
>>>>      4361         dirty_tx = tp->dirty_tx;
>>>>      4362
>>>>      4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>>>      4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
>>>>      4365                 u32 status;
>>>>      4366
>>>>      4367                 status = le32_to_cpu(tp->TxDescArray[entry].opts1);
>>>>      4368                 if (status & DescOwn)
>>>>      4369                         break;
>>>>      4370
>>>>      4371                 skb = tp->tx_skb[entry].skb;
>>>>      4372                 rtl8169_unmap_tx_skb(tp, entry);
>>>>      4373
>>>>      4374                 if (skb) {
>>>>      4375                         pkts_compl++;
>>>>      4376                         bytes_compl += skb->len;
>>>>      4377                         napi_consume_skb(skb, budget);
>>>>      4378                 }
>>>>      4379                 dirty_tx++;
>>>>      4380         }
>>>>      4381
>>>>      4382         if (tp->dirty_tx != dirty_tx) {
>>>>      4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
>>>>      4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>>>>      4385
>>>>      4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
>>>>      4387                                               rtl_tx_slots_avail(tp),
>>>>      4388                                               R8169_TX_START_THRS);
>>>>      4389                 /*
>>>>      4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
>>>>      4391                  * too close. Let's kick an extra TxPoll request when a burst
>>>>      4392                  * of start_xmit activity is detected (if it is not detected,
>>>>      4393                  * it is slow enough). -- FR
>>>>      4394                  * If skb is NULL then we come here again once a tx irq is
>>>>      4395                  * triggered after the last fragment is marked transmitted.
>>>>      4396                  */
>>>>    → 4397                 if (tp->cur_tx != dirty_tx && skb)
>>>>      4398                         rtl8169_doorbell(tp);
>>>>      4399         }
>>>>      4400 }
>>>>
>>>> Obviously from the code, an earlier detected data-race for tp->cur_tx was fixed in the
>>>> line 4363:
>>>>
>>>>      4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
>>>>
>>>> but the same solution is required for protecting the other access to tp->cur_tx:
>>>>
>>>>    → 4397                 if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>>>      4398                         rtl8169_doorbell(tp);
>>>>
>>>> The write in the line 4254 is protected with WRITE_ONCE(), but the read in the line 4397
>>>> might have suffered read tearing under some compiler optimisations.
>>>>
>>>> The fix eliminated the KCSAN data-race report for this bug.
>>>>
>>>> It is yet to be evaluated what happens if tp->cur_tx changes between the test in line 4363
>>>> and line 4397. This test should certainly not be cached by the compiler in some register
>>>> for such a long time, while asynchronous writes to tp->cur_tx might have occurred in line
>>>> 4254 in the meantime.
>>
>>> netif_subqueue_completed_wake() has barriers ensuring that no cached value for tp->cur_tx
>>> is used in line 4397. I'm not aware of any reported issues with an obvious link to the
>>> potentential issue you describe.
>>> I don't have a strong opinion on these patches. They shouldn't hurt, and if they make
>>> KCSAN happy, why not.
>>
>> Hi, Mr. Kallweit,
>>
>> Your words have been taken with great weight and serious concern on my behalf, so I took
>> some time to investigate (even after the patches were Ack-ed).
>>
> No need to be so formal. I'm just a hobbyist developer who once suddenly
> found himself in a maintainer position ;)

Well, if "manners maketh men" as they said, then it is better to start 
more conservative I suppose, than the other way around - start friendly 
and end in a formal communication :-)

>> The question is whether we deal with a data-race or a false positive reported by KCSAN.
>>
>> I can indeed independently confirm that netif_subqueue_completed_wake() eventually expands to
>> call to:
>>
>> include/net/netdev_queues.h:
>> ==============================================
>> /* Variant of netdev_tx_completed_queue() which guarantees smp_mb() if
>>   * @bytes != 0, regardless of kernel config.
>>   */
>> static inline void
>> netdev_txq_completed_mb(struct netdev_queue *dev_queue,
>>              unsigned int pkts, unsigned int bytes)
>> {
>>      if (IS_ENABLED(CONFIG_BQL))
>>          netdev_tx_completed_queue(dev_queue, pkts, bytes);
>>      else if (bytes)
>>          smp_mb();
>> }
>>
>> Obviously, smp_mb() is here.
>>
>> On my __x86_64__ it expands to an ugly hack:
>>
>>          #define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
>>
>> Thus far I concur with your findings.
>>
>> But I see also Mr. Elver's point:
>>
>> 1. With the reference to: [1] https://www.kernel.org/doc/html/v6.2/core-api/wrappers/memory-barriers.html
>> compiler can do some "smart" optimisations that only work on single core, single threaded use.
>>
>> What comes to mind is that "struct rtl8169_private" and its members might not be on the same cache line
>> with the pointer struct rtl8169_private *tp.
>>
>> By the exposed matter in [1], READ_ONCE() provides a way to explain to the compiler that tp->cur_tx can
>> be concurrently modified by the other thread/core.
>>
>> To be honest, I haven't caught a network card error or a driver bug either, but only the KCSAN complaint.
>>
>> It would seem prudent to protect all the variables with the concurrent accesses from several cores/threads
>> or devices through DMA with (READ|WRITE)_ONCE.
>>
> r8169 driver supports one queue only. NAPI softirq guarantees that calls to rtl8169_poll
> are serialized. Threaded NAPI may be a different story, however I'm not aware of any bug
> report related to threaded NAPI.

That sounds all Greek to me. I am not that deep into the network stack.

35M+ lines of the Source still look intimidating. :-/

>> Especially since I don't see where the callback added in drivers/net/ethernet/realtek/r8169_main.c:5277
>> is called from:
>>
>>           netif_napi_add(dev, &tp->napi, rtl8169_poll);
>>
>> I am not trying to be an arbiter nor an authority on the rtl8169 driver, which would obviously be you.
>>
>> However, I feel compelled by something to review all the accesses to tp->cur_tx, tp->cur_tx and other
>> structure members against concurrent access, and systematically. With your permission, of course.
>>
>> I would appreciate your mentoring on the task if you are interested.
>>
>> Mainly, I figured out that in:
>>
>> 4575 static int rtl8169_poll(struct napi_struct *napi, int budget)
>> 4576 {
>> 4577         struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
>> 4578         struct net_device *dev = tp->dev;
>> 4579         int work_done;
>> 4580
>> 4581         rtl_tx(dev, tp, budget);
>> 4582
>> 4583         work_done = rtl_rx(dev, tp, budget);
>> 4584
>> 4585         if (work_done < budget && napi_complete_done(napi, work_done))
>> 4586                 rtl_irq_enable(tp);
>> 4587
>> 4588         return work_done;
>> 4589 }
>>
>> rtl_tx() and rtl_rx() are called in sequence. Is it possible to imagine doing it in parallel?
>>
> Adding a separated TX NAPI is possible, question is whether it's worth the
> effort. Look for users of netif_napi_add_tx() to get an idea of separated TX NAPI.
> I once experimented with it in context of r8169 and didn't really find a benefit.

I guess it might be a bit more scalable. Would completions be too slow 
to handle incoming and outgoing packets?

Certainly, what comes to mind is that we are limited with DMA and what 
it can do.

>> Can the Realtek NIC hardware support that at all and which generations can?
>>
> Well, major issue with Realtek HW is that there's no public datasheets.
> Only source of information is their out-of-tree drivers (r8168, r8101, r8125).
> 
> With regard to RSS: r8125 supports it, r8168 not.

This sounds like a challenge. Currently I happen to have a r8125 and RSS 
seems interesting.

One coleague of mine said that Windows have better drivers, but mostly 
it is because we as the opn source community cannot afford to buy the 
specs for the fancy features in the hw. :-(

Best regards,
Mirsad Todorovac

>> (Of course, Ethernet might be full-duplex, but PCI Express line might not be.)
>>
>> [2] https://www.rambus.com/blogs/pci-express-4/ Full-duplex PCI 4.0 specs.
>>
>> Thank you.
>>
>> Best regards,
>> Mirsad Todorovac
>>
>>>> Fixes: 94d8a98e6235c ("r8169: reduce number of workaround doorbell rings")
>>>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Cc: nic_swsd@realtek.com
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Marco Elver <elver@google.com>
>>>> Cc: netdev@vger.kernel.org
>>>> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>> ---
>>>> v1:
>>>>    the initial patch proposal. fixes the KCSAN warning.
>>>>
>>>>    drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index 6351a2dc13bc..281aaa851847 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>>>>             * If skb is NULL then we come here again once a tx irq is
>>>>             * triggered after the last fragment is marked transmitted.
>>>>             */
>>>> -        if (tp->cur_tx != dirty_tx && skb)
>>>> +        if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
>>>>                rtl8169_doorbell(tp);
>>>>        }
>>>>    }
