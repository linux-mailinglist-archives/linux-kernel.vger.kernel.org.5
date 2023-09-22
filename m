Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF647AB2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjIVNZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:25:40 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFEBE8;
        Fri, 22 Sep 2023 06:25:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8CDC20003;
        Fri, 22 Sep 2023 13:25:29 +0000 (UTC)
Message-ID: <d589a999-d4dd-2768-b2d5-89dec64a4a42@ovn.org>
Date:   Fri, 22 Sep 2023 15:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
        dev@openvswitch.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>
Content-Language: en-US
To:     netdev@vger.kernel.org
References: <20220619003919.394622-1-i.maximets@ovn.org>
From:   Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net] net: ensure all external references are released in
 deferred skbuffs
In-Reply-To: <20220619003919.394622-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 02:39, Ilya Maximets wrote:
> Open vSwitch system test suite is broken due to inability to
> load/unload netfilter modules.  kworker thread is getting trapped
> in the infinite loop while running a net cleanup inside the
> nf_conntrack_cleanup_net_list, because deferred skbuffs are still
> holding nfct references and not being freed by their CPU cores.
> 
> In general, the idea that we will have an rx interrupt on every
> CPU core at some point in a near future doesn't seem correct.
> Devices are getting created and destroyed, interrupts are getting
> re-scheduled, CPUs are going online and offline dynamically.
> Any of these events may leave packets stuck in defer list for a
> long time.  It might be OK, if they are just a piece of memory,
> but we can't afford them holding references to any other resources.
> 
> In case of OVS, nfct reference keeps the kernel thread in busy loop
> while holding a 'pernet_ops_rwsem' semaphore.  That blocks the
> later modprobe request from user space:
> 
>   # ps
>    299 root  R  99.3  200:25.89 kworker/u96:4+
> 
>   # journalctl
>   INFO: task modprobe:11787 blocked for more than 1228 seconds.
>         Not tainted 5.19.0-rc2 #8
>   task:modprobe     state:D
>   Call Trace:
>    <TASK>
>    __schedule+0x8aa/0x21d0
>    schedule+0xcc/0x200
>    rwsem_down_write_slowpath+0x8e4/0x1580
>    down_write+0xfc/0x140
>    register_pernet_subsys+0x15/0x40
>    nf_nat_init+0xb6/0x1000 [nf_nat]
>    do_one_initcall+0xbb/0x410
>    do_init_module+0x1b4/0x640
>    load_module+0x4c1b/0x58d0
>    __do_sys_init_module+0x1d7/0x220
>    do_syscall_64+0x3a/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> At this point OVS testsuite is unresponsive and never recover,
> because these skbuffs are never freed.
> 
> Solution is to make sure no external references attached to skb
> before pushing it to the defer list.  Using skb_release_head_state()
> for that purpose.  The function modified to be re-enterable, as it
> will be called again during the defer list flush.
> 
> Another approach that can fix the OVS use-case, is to kick all
> cores while waiting for references to be released during the net
> cleanup.  But that sounds more like a workaround for a current
> issue rather than a proper solution and will not cover possible
> issues in other parts of the code.
> 
> Additionally checking for skb_zcopy() while deferring.  This might
> not be necessary, as I'm not sure if we can actually have zero copy
> packets on this path, but seems worth having for completeness as we
> should never defer such packets regardless.
> 
> CC: Eric Dumazet <edumazet@google.com>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Happy Friday! :)

Resurrecting this thread because I managed to reproduce the issue again
on a latest 6.6.0-rc1.

(It doesn't mean we need to accept this particular patch, I just think
that it's an appropriate discussion thread.)

It's a bit different testsuite this time.  Last year I had an issue with
OVS testsuite, today I have an issue with OVN testsuite.  Their structure
is very similar, but OVN tests are a fair bit more complex.

The story is the same:  Each test loads a pack of kernel modules including
OVS and nf_conntrack, sends some traffic, verifies OVN functionality,
stops OVN/OVS and unloads all the previously loaded modules to clean up
the space for the next tests.

Kernel hangs in the same way as before waiting for nf_conntrack module
to be unloaded:

  13 root R  100.0  933:17.98 kworker/u80:1+netns

  CPU: 12 PID: 13 Comm: kworker/u80:1 Not tainted 6.6.0-rc1+ #7
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc36 04/01/2014
  Workqueue: netns cleanup_net
  RIP: 0010:nf_ct_iterate_cleanup+0x35/0x1e0 [nf_conntrack]
  Code: 56 41 55 41 54 49 89 fc 55 31 ed 53 e8 a4 db a8
        ed 48 c7 c7 20 e9 e2 c0 e8 48 f3 a8 ed 39 2d 7e
        2d 01 00 77 14 e9 05 01 00 00 <83> c5 01 3b 2d 6e
        2d 01 00 0f 83 f6 00 00 00 48 8b 15 75 2d 01 00
  RSP: 0018:ffffb23040073d98 EFLAGS: 00000202
  RAX: 000000000001ce57 RBX: ffff98dbfac73958 RCX: ffff98e31f732b38
  RDX: ffff98dbfac00000 RSI: ffffb23040073dd0 RDI: ffffffffc0e2e920
  RBP: 000000000000e72b R08: ffff98e31f732b38 R09: ffff98e31f732b38
  R10: 000000000001d5ce R11: 0000000000000000 R12: ffffffffc0e1b080
  R13: ffffb23040073e28 R14: ffff98dbc47b0600 R15: ffffb23040073dd0
  FS:  0000000000000000(0000) GS:ffff98e31f700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f98bd7bca80 CR3: 000000076f420004 CR4: 0000000000370ee0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <NMI>
   ? nmi_cpu_backtrace+0x82/0xf0
   ? nmi_cpu_backtrace_handler+0xd/0x20
   ? nmi_handle+0x5e/0x150
   ? default_do_nmi+0x40/0x100
   ? exc_nmi+0x112/0x190
   ? end_repeat_nmi+0x16/0x67
   ? __pfx_kill_all+0x10/0x10 [nf_conntrack]
   ? nf_ct_iterate_cleanup+0x35/0x1e0 [nf_conntrack]
   ? nf_ct_iterate_cleanup+0x35/0x1e0 [nf_conntrack]
   ? nf_ct_iterate_cleanup+0x35/0x1e0 [nf_conntrack]
   </NMI>
   <TASK>
   nf_conntrack_cleanup_net_list+0xac/0x140 [nf_conntrack]
   cleanup_net+0x213/0x3b0
   process_one_work+0x177/0x340
   worker_thread+0x27e/0x390
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xe2/0x110
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>

Since this testsuite is different from what I had issues with before,
I don't really know when the issue first appeared.  It may have been
there even last year.

I can reproduce the issue with ubuntu 6.2.0-32-generic kernel, but
I don't see it with the latest 5.14.0-284.25.1.el9_2.x86_64 on RHEL9.
It doesn't necessarily mean that RHEL9 doesn't have the issue though,
the testsuite is not 100% reliable.

I'll try to dig deeper and bisect the problem on the upstream kernel.

For now it seems like the issue is likely in IPv6 code, because the
tests that trigger it are mostly IPv6-related.

Best regards, Ilya Maximets.
