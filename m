Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E67D890A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjJZTkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZTkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:40:23 -0400
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 12:40:20 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8F2198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:40:20 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 39DF428183E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:30:15 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 21D85C0067
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:30:12 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A20D813C2B0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:30:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A20D813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698348611;
        bh=li3xoh48UJwhDebRgzv2QBZBeaEojdUKiyD0CE6LCEk=;
        h=Date:To:From:Subject:From;
        b=PW4MUgPnofcJoXrqwKPbchn4qPN19YfATmcD7t9+R5vZaXDbve6kSikrnQTQb4LQ3
         P3zLlUd3iAAKnjRjOslBv7h/YigyiIcGVnt9Ubpz8narB83K3742zGKnDv9q0CHkR/
         pQZsxJe/R6UqfLoX2aETrq001r/D55dsDc6PytoY=
Message-ID: <c89ce73b-ae3f-b24e-e515-5634e25d2eea@candelatech.com>
Date:   Thu, 26 Oct 2023 12:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: KASAN splat and crash related to remove_entity_load_avg,
 wireless-next tree
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698348612-siakpkCJpGdd
X-MDID-O: us5;ut7;1698348612;siakpkCJpGdd;<greearb@candelatech.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While testing wifi today on a wireless-next + local hacks tree,
I saw this splat and crash.

The wireless-next I'm using is based on 6.6.0-rc5.

Let me know if you have any suggestions for debugging this further.  I think
it is probably not directly related to wifi or networking, but system was under
heavy network churn (wifi radios going up and down due to other issue)
when it happened.

==================================================================
BUG: KASAN: user-memory-access in remove_entity_load_avg+0x31/0x100
Read of size 8 at addr 00000ff81e1bc400 by task swapper/4/0

CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W          6.6.0-rc5+ #2
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Call Trace:
  <IRQ>
  dump_stack_lvl+0x57/0x90
  kasan_report+0xb9/0xf0
  ? remove_entity_load_avg+0x31/0x100
  remove_entity_load_avg+0x31/0x100
  unregister_fair_sched_group+0x195/0x3c0
  sched_unregister_group_rcu+0x14/0x30
  ? rcu_core+0x52e/0xd70
  rcu_core+0x56e/0xd70
  ? rcu_core+0x52e/0xd70
  ? rcu_gp_kthread+0x230/0x230
  ? ktime_get+0x51/0xb0
  ? mark_held_locks+0x24/0x90
  __do_softirq+0x100/0x51c
  __irq_exit_rcu+0x81/0xa0
  irq_exit_rcu+0x5/0x10
  sysvec_apic_timer_interrupt+0x6b/0x80
  </IRQ>
  <TASK>
  asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:cpuidle_enter_state+0x28c/0x320
Code: 04 86 4c 8d 6c c5 18 41 f6 45 40 20 0f 84 d3 fd ff ff 8b 7b 04 e8 f4 d4 9f fe e9 c6 fd ff ff e8 0a 05 d0 fe fb 0f 1f 44 00 00 <e9> 3e fe ff ff e8 8a 6b
RSP: 0018:ffff888112d17db8 EFLAGS: 00000202
RAX: 000000000298b5e9 RBX: ffffe8ffffc00d30 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff826d55c6
RBP: ffffffff83ad5a00 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff83f1ae57 R11: 0000000000000001 R12: 0000000000000004
R13: 000002a8d053572f R14: 0000000000000004 R15: 0000000000000000
  ? cpuidle_enter_state+0x286/0x320
  ? cpuidle_enter_state+0x286/0x320
  cpuidle_enter+0x37/0x60
  do_idle+0x28b/0x2f0
  ? arch_cpu_idle_exit+0x30/0x30
  ? schedule_idle+0x32/0x40
  cpu_startup_entry+0x2b/0x30
  start_secondary+0x197/0x1c0
  ? set_cpu_sibling_map+0xc20/0xc20
  secondary_startup_64_no_verify+0x166/0x16b
  </TASK>
==================================================================
BUG: unable to handle page fault for address: 00000ff81e1bc400
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 4 PID: 0 Comm: swapper/4 Tainted: G    B   W          6.6.0-rc5+ #2
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
RIP: 0010:remove_entity_load_avg+0x31/0x100
Code: 48 89 fd 48 8d bf 98 00 00 00 53 e8 99 de 3a 00 48 8b 9d 98 00 00 00 48 8d bb 80 00 00 00 4c 8d b3 c0 00 00 00 e8 7f de 3a 00 <48> 8b bb 80 00 00 00 49
RSP: 0018:ffff88841e009db0 EFLAGS: 00010286
RAX: 0000000000000001 RBX: 00000ff81e1bc380 RCX: ffffffff811dcb11
RDX: fffffbfff0922fc1 RSI: 0000000000000008 RDI: ffffffff84917e00
RBP: ffff888129f77000 R08: 0000000000000001 R09: fffffbfff0922fc0
R10: ffffffff84917e07 R11: fffffffffffe0f90 R12: ffff88813ce614b8
R13: ffff888128ba8120 R14: 00000ff81e1bc440 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff88841e000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000ff81e1bc400 CR3: 0000000003696001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  ? __die+0x1a/0x60
  ? page_fault_oops+0x1ea/0x550
  ? remove_entity_load_avg+0x31/0x100
  ? dump_pagetable+0x410/0x410
  ? syslog_print+0x3c0/0x3c0
  ? do_user_addr_fault+0x47f/0x8d0
  ? exc_page_fault+0x5d/0xf0
  ? asm_exc_page_fault+0x22/0x30
  ? add_taint+0x21/0x90
  ? remove_entity_load_avg+0x31/0x100
  unregister_fair_sched_group+0x195/0x3c0
  sched_unregister_group_rcu+0x14/0x30
  ? rcu_core+0x52e/0xd70
  rcu_core+0x56e/0xd70
  ? rcu_core+0x52e/0xd70
  ? rcu_gp_kthread+0x230/0x230
  ? ktime_get+0x51/0xb0
  ? mark_held_locks+0x24/0x90
  __do_softirq+0x100/0x51c
  __irq_exit_rcu+0x81/0xa0
  irq_exit_rcu+0x5/0x10
  sysvec_apic_timer_interrupt+0x6b/0x80
  </IRQ>
  <TASK>
  asm_sysvec_apic_timer_interrupt+0x16/0x20
RIP: 0010:cpuidle_enter_state+0x28c/0x320
Code: 04 86 4c 8d 6c c5 18 41 f6 45 40 20 0f 84 d3 fd ff ff 8b 7b 04 e8 f4 d4 9f fe e9 c6 fd ff ff e8 0a 05 d0 fe fb 0f 1f 44 00 00 <e9> 3e fe ff ff e8 8a 6b
RSP: 0018:ffff888112d17db8 EFLAGS: 00000202
RAX: 000000000298b5e9 RBX: ffffe8ffffc00d30 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff826d55c6
RBP: ffffffff83ad5a00 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff83f1ae57 R11: 0000000000000001 R12: 0000000000000004

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

