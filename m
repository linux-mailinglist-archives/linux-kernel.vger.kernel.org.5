Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF057A4648
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjIRJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbjIRJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:44:26 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0A185;
        Mon, 18 Sep 2023 02:43:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DE40D60173;
        Mon, 18 Sep 2023 11:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695030210; bh=UAR54t9dMY0nehsS36lVh7rquLz3fO7dCaJ7AB/uei8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MqIPTgkE6TPSeY4Co3P2P7Z68rWEDAoEg3lfQ/3fzRofDhcPfj/zOH0HtkJ/zsmkf
         A6RGxb4rqzeiubXv0jIh62zbF22Le8bCHjcy0aMhzZf/4qIC8Z8bUQSrLiHYrOv5bS
         LNhpqqQgzrsAKRNFRbd6vopGfUdoZqlNFpSqidLZ2WJ3n51IeW/IMZ8sweHEKT+3jA
         +2vuLpKklBT1CfXfBJc7mTV+E2wDZ8wWh0obewxRfGdBXdz0PwUnHbFcBCsLxmXKUL
         R/cKwAgnLRuuneAn6yFkSPYn81UvxRYU01E4MIi5naldBrxOaJEdfeXKpst1Q4fsvM
         hJMYmHYhDuJ0g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vWS9WHmqcIL9; Mon, 18 Sep 2023 11:43:28 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
        by domac.alu.hr (Postfix) with ESMTPSA id 0BCBD6015E;
        Mon, 18 Sep 2023 11:43:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695030208; bh=UAR54t9dMY0nehsS36lVh7rquLz3fO7dCaJ7AB/uei8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y65HsXdzy0F67RF3vCvoNdtG+ujRx5uXi4xPzWZT917Ko6oXDZpP1qDJOCAwfAI0+
         LtdCfnOH+rz5vfBsuZDkK9S30OkcqVlmrZWBOlp2VCUdkYsEE0yxoYv3jhdXrWuPbq
         iwHV6pHSdGr1omIhVkQhTSw30+mhS40D5ZEp64F0FIKZhRhpzd3uGC/cmOjjOkWjGe
         Tkd29LCDcE394qkHIM3z30zDQ+v/Fz3OU5blcUn6ewzbVtmFEdSDAa+lBhY0ihqsH0
         HvpT53W8l3xAWxd0QQ4iJvi9cMT/bAIfbyYwIInf8ui5gTUP2PWdeOmN0GRInHpnYp
         0K+QszwkKKnkQ==
Message-ID: <3e306b0a-24b8-60d4-c516-1db738d79e92@alu.unizg.hr>
Date:   Mon, 18 Sep 2023 11:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: BUG: KCSAN: data-race in rtl8169_poll
To:     Eric Dumazet <edumazet@google.com>
Cc:     nic_swsd@realtek.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
 <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 09:41, Eric Dumazet wrote:
> On Mon, Sep 18, 2023 at 8:15 AM Mirsad Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> Hi all,
>>
>> In the vanilla torvalds tree kernel on Ubuntu 22.04, commit 6.6.0-rc1-kcsan-00269-ge789286468a9,
>> KCSAN discovered a data-race in rtl8169_poll():
>>
>> [ 9591.740976] ==================================================================
>> [ 9591.740990] BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>>
>> [ 9591.741060] race at unknown origin, with read to 0xffff888109773130 of 4 bytes by interrupt on cpu 21:
>> [ 9591.741073] rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
>> [ 9591.741135] __napi_poll (net/core/dev.c:6527)
>> [ 9591.741149] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
>> [ 9591.741161] __do_softirq (kernel/softirq.c:553)
>> [ 9591.741175] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
>> [ 9591.741185] irq_exit_rcu (kernel/softirq.c:647)
>> [ 9591.741194] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
>> [ 9591.741206] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
>> [ 9591.741217] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
>> [ 9591.741227] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>> [ 9591.741237] call_cpuidle (kernel/sched/idle.c:135)
>> [ 9591.741249] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
>> [ 9591.741259] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>> [ 9591.741268] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
>> [ 9591.741281] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>>
>> [ 9591.741300] value changed: 0x80003fff -> 0x34044510
>>
>> [ 9591.741314] Reported by Kernel Concurrency Sanitizer on:
>> [ 9591.741322] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #4
>> [ 9591.741334] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 9591.741343] ==================================================================
>>
>> (The taint is not from the proprietary module, but triggered from the previous reported and unfixed bug.)
>>
>> Apparently, it is this code:
>>
>> static int rtl8169_poll(struct napi_struct *napi, int budget)
>> {
>>          struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
>>          struct net_device *dev = tp->dev;
>>          int work_done;
>>
>>          rtl_tx(dev, tp, budget);
>>
>> →       work_done = rtl_rx(dev, tp, budget);
>>
>>          if (work_done < budget && napi_complete_done(napi, work_done))
>>                  rtl_irq_enable(tp);
>>
>>          return work_done;
>> }
>>
>> and
>>
>> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
>> {
>>          struct device *d = tp_to_dev(tp);
>>          int count;
>>
>>          for (count = 0; count < budget; count++, tp->cur_rx++) {
>>                  unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
>>                  struct RxDesc *desc = tp->RxDescArray + entry;
>>                  struct sk_buff *skb;
>>                  const void *rx_buf;
>>                  dma_addr_t addr;
>>                  u32 status;
>>
>> →               status = le32_to_cpu(desc->opts1);
>>                  if (status & DescOwn)
>>                          break;
>>
>>                  /* This barrier is needed to keep us from reading
>>                   * any other fields out of the Rx descriptor until
>>                   * we know the status of DescOwn
>>                   */
>>                  dma_rmb();
>>
>>                  if (unlikely(status & RxRES)) {
>> .
>> .
>> .
>>
>> The reason isn't obvious, so it might be interesting if this is a valid report and whether it caused spurious corruption
>> of the network data on Realtek 8169 compatible cards ...
>>
> 
> I think this is pretty much expected.
> 
> Driver reads a piece of memory that the hardware can modify.
> 
> Adding data_race() annotations could avoid these false positives.
> 
>> Hope this helps.
>>
>> Best regards,
>> Mirsad Todorovac

Well, another approach was this quick fix that eliminated all those rtl8169_poll() KCSAN warnings.

If READ_ONCE(desc->opts1) fixed it, then maybe there is more to this than meets the eye?

-------------------------------------------------
  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..051551ee2a15 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4427,7 +4427,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
                 dma_addr_t addr;
                 u32 status;
  
-               status = le32_to_cpu(desc->opts1);
+               status = le32_to_cpu(READ_ONCE(desc->opts1));
                 if (status & DescOwn)
                         break;
  
