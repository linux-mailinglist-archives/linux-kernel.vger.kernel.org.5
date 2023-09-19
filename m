Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD97A59DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjISGUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISGUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:20:20 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA10100;
        Mon, 18 Sep 2023 23:20:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6617C60155;
        Tue, 19 Sep 2023 08:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695104409; bh=woPvcKe79CYkQ2AvG97Pj0aOHdKJVfgt2q+EnnaKbWQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=layxwJH5xda/2jKtAaRk0PI6lLM76vhjOOW5OCBCifAVFmOJbFsWAzlEnFBpRlhwm
         iHCHY2uDCztJcIPEDDKKmn2Hr2Ym4QZk8X+RBd/lE0ZZbHULYqRg11fyk8K9Q34LNj
         oeUAcwhPGLJwRi5U+EtYSRNIqkDnNi1aiWO9EImNAfIAyHLnQeypIVkxnwBmDXrLJM
         x3h9uskOkL52ZeQPpwBwnSMMhl7mB8of6CbRpNOOKC5MZ6Q+vX28W2UwNW0ccKQ3GG
         ggrQBKGfDQqkCr6kyLGB+zQwSugwih+H9Kix918uLKOM+vJgl83jkXrb4sUzvpZco/
         shIhfonkgketQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 308612uK-p4d; Tue, 19 Sep 2023 08:20:06 +0200 (CEST)
Received: from [192.168.1.6] (78-0-136-157.adsl.net.t-com.hr [78.0.136.157])
        by domac.alu.hr (Postfix) with ESMTPSA id 57CA460152;
        Tue, 19 Sep 2023 08:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695104406; bh=woPvcKe79CYkQ2AvG97Pj0aOHdKJVfgt2q+EnnaKbWQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=HxsaBibsxN3mZBdwy5rffnfl4M7I3hTF2/W4MTgskp/qoUd4QwVqhDlAmQXxfJ3vb
         W9OuaFDuTdYkw4Ft5ob5rmenL6wSuHhtZ19M2bt9l0vObWFITlGot7I8N/5Svlrh12
         GGU4YHZmMRjskmtggS2KVvU/4uTJV+oPRL+ZEoUiFLyT+P/1h8rGrcedo7DRumnbLp
         p8Z27/ffbAvDnOckKvmEiDQhuw/8QH+icwDRGFKpxWXkMiz+68CrB/b7xlvGxKQRYj
         3iNnFOldjrHIJlpP48BtJFRXRjekvGe6KtsEnU78cr0WtnaFd34jttg1/jlh6f8h44
         3uC9RiAqc4y4A==
Message-ID: <dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr>
Date:   Tue, 19 Sep 2023 08:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: BUG: KCSAN: data-race in rtl8169_poll
To:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>
Cc:     nic_swsd@realtek.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
 <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com>
 <3e306b0a-24b8-60d4-c516-1db738d79e92@alu.unizg.hr>
 <CANn89iKyLdvSF11aHvg-Ytr+HbnHb4QXMie2N5GpZhxSHx-XtA@mail.gmail.com>
 <CANpmjNNYGax0BfjA98ViGsM4rVrcaNx_SKdetgt+-SzFqB-7zg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNNYGax0BfjA98ViGsM4rVrcaNx_SKdetgt+-SzFqB-7zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 13:44, Marco Elver wrote:
> On Mon, 18 Sept 2023 at 12:39, Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Mon, Sep 18, 2023 at 11:43 AM Mirsad Todorovac
>> <mirsad.todorovac@alu.unizg.hr> wrote:
>>>
>>> On 9/18/23 09:41, Eric Dumazet wrote:
>>>> On Mon, Sep 18, 2023 at 8:15 AM Mirsad Todorovac
>>>> <mirsad.todorovac@alu.unizg.hr> wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> In the vanilla torvalds tree kernel on Ubuntu 22.04, commit 6.6.0-rc1-kcsan-00269-ge789286468a9,
>>>>> KCSAN discovered a data-race in rtl8169_poll():
>>>>>
>>>>> [ 9591.740976] ==================================================================
>>>>> [ 9591.740990] BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>>>>>
>>>>> [ 9591.741060] race at unknown origin, with read to 0xffff888109773130 of 4 bytes by interrupt on cpu 21:
>>>>> [ 9591.741073] rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>>>>> [ 9591.741135] __napi_poll (net/core/dev.c:6527)
>>>>> [ 9591.741149] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>>>>> [ 9591.741161] __do_softirq (kernel/softirq.c:553)
>>>>> [ 9591.741175] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>>>>> [ 9591.741185] irq_exit_rcu (kernel/softirq.c:647)
>>>>> [ 9591.741194] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
>>>>> [ 9591.741206] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
>>>>> [ 9591.741217] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>>>>> [ 9591.741227] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>>>>> [ 9591.741237] call_cpuidle (kernel/sched/idle.c:135)
>>>>> [ 9591.741249] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>>>>> [ 9591.741259] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>>>>> [ 9591.741268] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>>>>> [ 9591.741281] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>>>>
>>>>> [ 9591.741300] value changed: 0x80003fff -> 0x34044510
>>>>>
>>>>> [ 9591.741314] Reported by Kernel Concurrency Sanitizer on:
>>>>> [ 9591.741322] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #4
>>>>> [ 9591.741334] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>>>> [ 9591.741343] ==================================================================
>>>>>
>>>>> (The taint is not from the proprietary module, but triggered from the previous reported and unfixed bug.)
>>>>>
>>>>> Apparently, it is this code:
>>>>>
>>>>> static int rtl8169_poll(struct napi_struct *napi, int budget)
>>>>> {
>>>>>           struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
>>>>>           struct net_device *dev = tp->dev;
>>>>>           int work_done;
>>>>>
>>>>>           rtl_tx(dev, tp, budget);
>>>>>
>>>>> →       work_done = rtl_rx(dev, tp, budget);
>>>>>
>>>>>           if (work_done < budget && napi_complete_done(napi, work_done))
>>>>>                   rtl_irq_enable(tp);
>>>>>
>>>>>           return work_done;
>>>>> }
>>>>>
>>>>> and
>>>>>
>>>>> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
>>>>> {
>>>>>           struct device *d = tp_to_dev(tp);
>>>>>           int count;
>>>>>
>>>>>           for (count = 0; count < budget; count++, tp->cur_rx++) {
>>>>>                   unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
>>>>>                   struct RxDesc *desc = tp->RxDescArray + entry;
>>>>>                   struct sk_buff *skb;
>>>>>                   const void *rx_buf;
>>>>>                   dma_addr_t addr;
>>>>>                   u32 status;
>>>>>
>>>>> →               status = le32_to_cpu(desc->opts1);
>>>>>                   if (status & DescOwn)
>>>>>                           break;
>>>>>
>>>>>                   /* This barrier is needed to keep us from reading
>>>>>                    * any other fields out of the Rx descriptor until
>>>>>                    * we know the status of DescOwn
>>>>>                    */
>>>>>                   dma_rmb();
>>>>>
>>>>>                   if (unlikely(status & RxRES)) {
>>>>> .
>>>>> .
>>>>> .
>>>>>
>>>>> The reason isn't obvious, so it might be interesting if this is a valid report and whether it caused spurious corruption
>>>>> of the network data on Realtek 8169 compatible cards ...
>>>>>
>>>>
>>>> I think this is pretty much expected.
>>>>
>>>> Driver reads a piece of memory that the hardware can modify.
>>>>
>>>> Adding data_race() annotations could avoid these false positives.
>>>>
>>>>> Hope this helps.
>>>>>
>>>>> Best regards,
>>>>> Mirsad Todorovac
>>>
>>> Well, another approach was this quick fix that eliminated all those rtl8169_poll() KCSAN warnings.
>>>
>>> If READ_ONCE(desc->opts1) fixed it, then maybe there is more to this than meets the eye?
>>>
>>> -------------------------------------------------
>>>    drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 6351a2dc13bc..051551ee2a15 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>>>                   dma_addr_t addr;
>>>                   u32 status;
>>>
>>> -               status = le32_to_cpu(desc->opts1);
>>> +               status = le32_to_cpu(READ_ONCE(desc->opts1));
>>>                   if (status & DescOwn)
>>>                           break;
>>>
>>
>> This is also working, but in this case we already have barriers (
>> dma_rmb() here)
>> to synchronize host side and hardware (when flipping DescOwn) bit.
> 
> READ_ONCE() does not imply any (strong) barriers (it does imply
> address-dependency barriers, i.e. ordering dependent reads/writes, but
> if that can be relied upon if the concurrent writer is a device and
> not CPU I don't know).
> 
> So in this case pairing READ_ONCE() with dma_rmb() is perfectly
> reasonable: writes to desc->opts1 can happen concurrently, and the
> READ_ONCE() ensures the compiler doesn't mess up that access; later
> reads must be ordered by dma_rmb().
> 
> The data race here is a consequence of a concurrent write with the
> read of desc->opts1. The dma_rmb() does not prevent that from
> happening, and therefore we still have to mark the racing access.

Hi,

As I understood, this patch stops the KCSAN data-race warning for this line, so adding data_race() annotation
is not needed?

Should we proceed to a formal patch?

1. BTW, there is a similar data-race in the rtl8169_poll, as I already have your attention:

[  707.765194] ==================================================================
[  707.765207] BUG: KCSAN: data-race in rtl8169_poll (/home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4368 /home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4581) r8169

[  707.765278] race at unknown origin, with read to 0xffff888144acf5e0 of 4 bytes by interrupt on cpu 21:
[  707.765290] rtl8169_poll (/home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4368 /home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
[  707.765353] __napi_poll (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:6527)
[  707.765367] net_rx_action (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:6596 /home/marvin/linux/kernel/torvalds2/net/core/dev.c:6727)
[  707.765380] __do_softirq (/home/marvin/linux/kernel/torvalds2/kernel/softirq.c:553)
[  707.765393] do_softirq.part.0 (/home/marvin/linux/kernel/torvalds2/kernel/softirq.c:454)
[  707.765403] __local_bh_enable_ip (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/preempt.h:27 /home/marvin/linux/kernel/torvalds2/kernel/softirq.c:381)
[  707.765413] __dev_queue_xmit (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:4368)
[  707.765425] ip_finish_output2 (/home/marvin/linux/kernel/torvalds2/./include/linux/netdevice.h:3082 /home/marvin/linux/kernel/torvalds2/./include/net/neighbour.h:526 /home/marvin/linux/kernel/torvalds2/./include/net/neighbour.h:540 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:233)
[  707.765436] __ip_finish_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:311 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:293)
[  707.765447] ip_finish_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:328)
[  707.765458] ip_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:435)
[  707.765468] ip_send_skb (/home/marvin/linux/kernel/torvalds2/./include/net/dst.h:458 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:127 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:1486)
[  707.765478] udp_send_skb (/home/marvin/linux/kernel/torvalds2/net/ipv4/udp.c:963)
[  707.765491] udp_sendmsg (/home/marvin/linux/kernel/torvalds2/net/ipv4/udp.c:1246)
[  707.765501] inet_sendmsg (/home/marvin/linux/kernel/torvalds2/net/ipv4/af_inet.c:840 (discriminator 4))
[  707.765511] sock_sendmsg (/home/marvin/linux/kernel/torvalds2/net/socket.c:730 /home/marvin/linux/kernel/torvalds2/net/socket.c:753)
[  707.765525] __sys_sendto (/home/marvin/linux/kernel/torvalds2/net/socket.c:2177)
[  707.765535] __x64_sys_sendto (/home/marvin/linux/kernel/torvalds2/net/socket.c:2185)
[  707.765545] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
[  707.765558] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)

[  707.765574] value changed: 0xb000004a -> 0x00000000

[  707.765588] Reported by Kernel Concurrency Sanitizer on:
[  707.765596] CPU: 21 PID: 3816 Comm: Chrome_ChildIOT Not tainted 6.6.0-rc2-kcsan-00003-g16819584c239-dirty #11
[  707.765608] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  707.765615] ==================================================================

This one does not seem so easy to patch:

drivers/net/ethernet/realtek/r8169_main.c:4363-4380:
----------------------------------------------------
	while (READ_ONCE(tp->cur_tx) != dirty_tx) {
		unsigned int entry = dirty_tx % NUM_TX_DESC;
		u32 status;

		status = le32_to_cpu(tp->TxDescArray[entry].opts1);
→		if (status & DescOwn)
			break;

		skb = tp->tx_skb[entry].skb;
		rtl8169_unmap_tx_skb(tp, entry);

		if (skb) {
			pkts_compl++;
			bytes_compl += skb->len;
			napi_consume_skb(skb, budget);
		}
		dirty_tx++;
	}
------------------------------------------------------

drivers/net/ethernet/realtek/r8169_main.c:4363-4380:
------------------------------------------------------
static int rtl8169_poll(struct napi_struct *napi, int budget)
{
	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
	struct net_device *dev = tp->dev;
	int work_done;

→	rtl_tx(dev, tp, budget);

	work_done = rtl_rx(dev, tp, budget);

	if (work_done < budget && napi_complete_done(napi, work_done))
		rtl_irq_enable(tp);

	return work_done;
}
------------------------------------------------------

2. The similar data race is here:

[ 8953.703581] ==================================================================
[ 8953.703653] BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r8169]

[ 8953.703778] write (marked) to 0xffff88811a274b74 of 4 bytes by task 4011 on cpu 0:
[ 8953.703789] rtl8169_start_xmit (/home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4254) r8169
[ 8953.703852] dev_hard_start_xmit (/home/marvin/linux/kernel/torvalds2/./include/linux/netdevice.h:4889 /home/marvin/linux/kernel/torvalds2/./include/linux/netdevice.h:4903 /home/marvin/linux/kernel/torvalds2/net/core/dev.c:3544 /home/marvin/linux/kernel/torvalds2/net/core/dev.c:3560)
[ 8953.703866] sch_direct_xmit (/home/marvin/linux/kernel/torvalds2/net/sched/sch_generic.c:342)
[ 8953.703879] __dev_queue_xmit (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:3817 /home/marvin/linux/kernel/torvalds2/net/core/dev.c:4306)
[ 8953.703891] ip_finish_output2 (/home/marvin/linux/kernel/torvalds2/./include/linux/netdevice.h:3082 /home/marvin/linux/kernel/torvalds2/./include/net/neighbour.h:526 /home/marvin/linux/kernel/torvalds2/./include/net/neighbour.h:540 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:233)
[ 8953.703903] __ip_finish_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:311 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:293)
[ 8953.703914] ip_finish_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:328)
[ 8953.703925] ip_output (/home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:435)
[ 8953.703935] ip_send_skb (/home/marvin/linux/kernel/torvalds2/./include/net/dst.h:458 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:127 /home/marvin/linux/kernel/torvalds2/net/ipv4/ip_output.c:1486)
[ 8953.703945] udp_send_skb (/home/marvin/linux/kernel/torvalds2/net/ipv4/udp.c:963)
[ 8953.703958] udp_sendmsg (/home/marvin/linux/kernel/torvalds2/net/ipv4/udp.c:1246)
[ 8953.703968] inet_sendmsg (/home/marvin/linux/kernel/torvalds2/net/ipv4/af_inet.c:840 (discriminator 4))
[ 8953.703978] sock_sendmsg (/home/marvin/linux/kernel/torvalds2/net/socket.c:730 /home/marvin/linux/kernel/torvalds2/net/socket.c:753)
[ 8953.703992] __sys_sendto (/home/marvin/linux/kernel/torvalds2/net/socket.c:2177)
[ 8953.704002] __x64_sys_sendto (/home/marvin/linux/kernel/torvalds2/net/socket.c:2185)
[ 8953.704012] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
[ 8953.704025] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)

[ 8953.704042] read to 0xffff88811a274b74 of 4 bytes by interrupt on cpu 21:
[ 8953.704053] rtl8169_poll (/home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4397 /home/marvin/linux/kernel/torvalds2/drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
[ 8953.704114] __napi_poll (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:6527)
[ 8953.704127] net_rx_action (/home/marvin/linux/kernel/torvalds2/net/core/dev.c:6596 /home/marvin/linux/kernel/torvalds2/net/core/dev.c:6727)
[ 8953.704140] __do_softirq (/home/marvin/linux/kernel/torvalds2/kernel/softirq.c:553)
[ 8953.704152] __irq_exit_rcu (/home/marvin/linux/kernel/torvalds2/kernel/softirq.c:427 /home/marvin/linux/kernel/torvalds2/kernel/softirq.c:632)
[ 8953.704163] irq_exit_rcu (/home/marvin/linux/kernel/torvalds2/kernel/softirq.c:647)
[ 8953.704172] sysvec_apic_timer_interrupt (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
[ 8953.704186] asm_sysvec_apic_timer_interrupt (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:645)
[ 8953.704197] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:291)
[ 8953.704207] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
[ 8953.704217] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
[ 8953.704229] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
[ 8953.704238] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
[ 8953.704247] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
[ 8953.704260] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)

[ 8953.704279] value changed: 0x0002f84c -> 0x0002f84d

[ 8953.704293] Reported by Kernel Concurrency Sanitizer on:
[ 8953.704301] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00003-g16819584c239-dirty #16
[ 8953.704313] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 8953.704320] ==================================================================

I am unable to say if this could spuriously corrupt data and/or cause dropped packets which are probably
fixed by the upper level protocols?

   4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
   4356                    int budget)
   4357 {
   4358         unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
   4359         struct sk_buff *skb;
   4360
   4361         dirty_tx = tp->dirty_tx;
   4362
   4363         while (READ_ONCE(tp->cur_tx) != dirty_tx) {
   4364                 unsigned int entry = dirty_tx % NUM_TX_DESC;
   4365                 u32 status;
   4366
→ 4367                 status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
   4368                 if (status & DescOwn)
   4369                         break;
   4370
   4371                 skb = tp->tx_skb[entry].skb;
   4372                 rtl8169_unmap_tx_skb(tp, entry);
   4373
   4374                 if (skb) {
   4375                         pkts_compl++;
   4376                         bytes_compl += skb->len;
   4377                         napi_consume_skb(skb, budget);
   4378                 }
   4379                 dirty_tx++;
   4380         }
   4381
   4382         if (tp->dirty_tx != dirty_tx) {
   4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
   4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
   4385
   4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl, bytes_compl,
   4387                                               rtl_tx_slots_avail(tp),
   4388                                               R8169_TX_START_THRS);
   4389                 /*
   4390                  * 8168 hack: TxPoll requests are lost when the Tx packets are
   4391                  * too close. Let's kick an extra TxPoll request when a burst
   4392                  * of start_xmit activity is detected (if it is not detected,
   4393                  * it is slow enough). -- FR
   4394                  * If skb is NULL then we come here again once a tx irq is
   4395                  * triggered after the last fragment is marked transmitted.
   4396                  */
→ 4397                 if (tp->cur_tx != dirty_tx && skb)
   4398                         rtl8169_doorbell(tp);
   4399         }
   4400 }

The conflicting code is:

   4251         /* rtl_tx needs to see descriptor changes before updated tp->cur_tx */
   4252         smp_wmb();
   4253
→ 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
   4255

All of those are being patched with READ_ONCE() around the variable that is accessed concurrently:

------------------------------------------------
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..361b90007148 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4364,7 +4364,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
                 unsigned int entry = dirty_tx % NUM_TX_DESC;
                 u32 status;
  
-               status = le32_to_cpu(tp->TxDescArray[entry].opts1);
+               status = le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].opts1));
                 if (status & DescOwn)
                         break;
  
@@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
                  * If skb is NULL then we come here again once a tx irq is
                  * triggered after the last fragment is marked transmitted.
                  */
-               if (tp->cur_tx != dirty_tx && skb)
+               if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
                         rtl8169_doorbell(tp);
         }
  }
@@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
                 dma_addr_t addr;
                 u32 status;
  
-               status = le32_to_cpu(desc->opts1);
+               status = le32_to_cpu(READ_ONCE(desc->opts1));
                 if (status & DescOwn)
                         break;
  
---

Just like in line 4363, tp->cur_tx in line 4397 is prone to data-race unless enclosed in READ_ONCE().

There are no additional data-races reported by the KCSAN for rtl8169 driver ATM.

Best regards,
Mirsad Todorovac

