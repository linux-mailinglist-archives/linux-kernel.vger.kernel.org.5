Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD187CCB74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjJQS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:59:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4EC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:59:08 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ccfe703184so517511a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569147; x=1698173947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0tDD5P7+6OVGU87+NU+cMxED/+YecSW+UcudC/L34Vk=;
        b=Jd7jAX9GC+fyQpOdy/q3ORq0tZ3UQVSohlzzrli2ZoMyNTKO5y+y3AweJcV3DsmqFj
         uC3sdH6o22/ZLwr8B14rz6ZfUYwBXjby629SPjtqSBPiFgluDx2GAh4IbSoUNQnEaqxQ
         Lw+MTd01229oaXbC7KZADWuzexi3rnFjgsNj+vRdwQzqFt8Jp7/ohjBofKD47I0tPi6w
         vTfeHEOuer2f8qYNLJeBI3KOQWcTLvWFrgkRfOJRS+tZ9hyFyfvWF1vGe5VBY2+bd45M
         C0wnA58+Eu861ZC/P2rv2XFZvzHk17KsaUOAlP6b+QMYlS4r9eaQoSt5aLPzsLJZF5mM
         qskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569147; x=1698173947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tDD5P7+6OVGU87+NU+cMxED/+YecSW+UcudC/L34Vk=;
        b=NzdQVEX4Ej32wdrvuS9/Tr0EbzXAfxDQaRyRgFWXB86hHjB9JQBQfHoufB5IuetFbI
         R4UUDw4weaCG2AUS41G8ra5v0K4zc//6gOrOGIAueQ63FRFMn+HGrYuEA1DR9FzVvbKA
         ONw2wyVslxmf/d3z2vV9AunlvppaRZCBgt5XxN+DrTjh2XdQG4yPNkN/JMWMcPIH1fgH
         DoKEFkDI5OFbxzjf9eoa+QcMxWCEmexSNDjVAXH152dFEP7FR39PFn1VLLk6qeoUkV2L
         a58+6Rt4NjmC1k/8zmiqL7VKOlFeOWjRVcH6jsRuKl1e5ot5MwIXRBHyWEni44zkijQj
         uZyw==
X-Gm-Message-State: AOJu0Yww/Dq49crlZAePxALOkHjnwvWm2jKJBWQDDroNI/WbbbBz/fqJ
        Z0ySLpioMu0ycFbStqyBXQISIeNzV8fJmVcjps7bQYml2AQQIw==
X-Google-Smtp-Source: AGHT+IFr8IpgL7VTRL1hbOnenjJ+fFVx8rRhJed5ARD1RBaGS5ubusZ76E2vpdnuC1dJMEeqcz4o02CglN6DWqD/ATY=
X-Received: by 2002:a05:6870:1196:b0:1e9:ac92:9ab6 with SMTP id
 22-20020a056870119600b001e9ac929ab6mr3282321oau.46.1697569147266; Tue, 17 Oct
 2023 11:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004b632f0607d07fb0@google.com>
In-Reply-To: <0000000000004b632f0607d07fb0@google.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Tue, 17 Oct 2023 19:58:56 +0100
Message-ID: <CAJwJo6ZGXO07=QvW4fgQfbsDzQPs9xj5sAQ1zp=mAyPMNbHYww@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in reweight_entity
To:     mingo@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        syzbot <syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW,
Managed to locally reproduce it twice on 58720809f527 (tag: v6.6-rc6)
Linux 6.6-rc6 + TCP-AO patches on the top.
(but can't reproduce reliably at will)

[dima@Mindolluin linux-tcp-ao]$ ./scripts/faddr2line vmlinux
reweight_entity+0x3b0/0x490
reweight_entity+0x3b0/0x490:
__update_min_deadline at kernel/sched/fair.c:805
(inlined by) min_deadline_update at kernel/sched/fair.c:819
(inlined by) min_deadline_cb_propagate at kernel/sched/fair.c:825
(inlined by) reweight_entity at kernel/sched/fair.c:3660

[  258.450573] TCP: AO key not found for (10.0.1.1,
58651)->(10.0.254.1, 7018) S keyid: 100 L3index: 0
[  259.482680] ==================================================================
[  259.483732] BUG: KASAN: slab-use-after-free in reweight_entity+0x3b0/0x490
[  259.484564] Read of size 8 at addr ffff88800859dcf0 by task
unsigned-md5_ip/2535

[  259.485593] CPU: 0 PID: 2535 Comm: unsigned-md5_ip Not tainted 6.6.0-rc6+ #7
[  259.486393] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS Arch Linux 1.16.2-2-2 04/01/2014
[  259.487445] Call Trace:
[  259.487783]  <TASK>
[  259.488057]  dump_stack_lvl+0x46/0x70
[  259.488578]  print_report+0xc5/0x610
[  259.489099]  ? lock_acquire+0x162/0x3d0
[  259.489641]  ? __virt_addr_valid+0xbe/0x130
[  259.490211]  kasan_report+0xbe/0xf0
[  259.490902]  ? reweight_entity+0x3b0/0x490
[  259.491683]  ? reweight_entity+0x3b0/0x490
[  259.492475]  reweight_entity+0x3b0/0x490
[  259.493319]  enqueue_task_fair+0x944/0xc90
[  259.494146]  activate_task+0x95/0x1b0
[  259.494932]  ttwu_do_activate+0x91/0x3c0
[  259.495645]  try_to_wake_up+0x423/0xd60
[  259.496425]  ? sched_ttwu_pending+0x260/0x260
[  259.497543]  ? _raw_spin_unlock+0x29/0x40
[  259.498301]  wake_up_q+0x6f/0xf0
[  259.498889]  __mutex_unlock_slowpath+0x19b/0x3e0
[  259.500191]  ? bit_wait_io_timeout+0xc0/0xc0
[  259.501691]  ? reacquire_held_locks+0x280/0x280
[  259.502634]  ? rcu_is_watching+0x34/0x50
[  259.503485]  __rtnl_unlock+0x3f/0x80
[  259.504089]  netdev_run_todo+0x1b7/0x840
[  259.504721]  ? generic_xdp_install+0x2a0/0x2a0
[  259.505394]  ? __kmem_cache_free+0x192/0x2b0
[  259.506021]  ? rtnl_newlink+0x59/0x70
[  259.506562]  rtnetlink_rcv_msg+0x200/0x650
[  259.507088]  ? rtnl_getlink+0x590/0x590
[  259.507600]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  259.508247]  ? find_held_lock+0x8a/0xa0
[  259.508750]  ? local_clock_noinstr+0x9/0xb0
[  259.509254]  netlink_rcv_skb+0xdd/0x210
[  259.509751]  ? rtnl_getlink+0x590/0x590
[  259.510214]  ? netlink_ack+0x840/0x840
[  259.511082]  ? lock_sync+0x100/0x100
[  259.511775]  ? __rcu_read_unlock+0x6b/0x2a0
[  259.512822]  ? netlink_deliver_tap+0xfe/0x620
[  259.513527]  netlink_unicast+0x2f3/0x480
[  259.514105]  ? netlink_attachskb+0x440/0x440
[  259.514642]  netlink_sendmsg+0x3c0/0x6e0
[  259.515108]  ? netlink_unicast+0x480/0x480
[  259.515572]  ? netlink_unicast+0x480/0x480
[  259.516030]  __sock_sendmsg+0x73/0xc0
[  259.516425]  __sys_sendto+0x18b/0x210
[  259.516878]  ? __ia32_sys_getpeername+0x50/0x50
[  259.517435]  ? mark_held_locks+0x1a/0x80
[  259.517949]  __x64_sys_sendto+0x72/0x80
[  259.518457]  do_syscall_64+0x35/0x80
[  259.518945]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  259.519626] RIP: 0033:0x7f62cf55f9ec
[  259.520117] Code: 89 4c 24 1c e8 a5 63 f7 ff 44 8b 54 24 1c 8b 3c
24 45 31 c9 89 c5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 04 24 e8 f1 63 f7 ff 48
8b 04
[  259.522762] RSP: 002b:00007ffddd3c4c90 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[  259.523854] RAX: ffffffffffffffda RBX: 00007ffddd3c4cd0 RCX: 00007f62cf55f9ec
[  259.524768] RDX: 0000000000000044 RSI: 00007ffddd3c4cd0 RDI: 0000000000000006
[  259.525679] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  259.526585] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
[  259.528558] R13: 0000000000000006 R14: 00007ffddd3c4cfc R15: 00007ffddd3c4d08
[  259.529452]  </TASK>

[  259.529950] Allocated by task 31:
[  259.530390]  kasan_save_stack+0x21/0x40
[  259.530904]  kasan_set_track+0x21/0x30
[  259.531399]  __kasan_slab_alloc+0x62/0x70
[  259.531946]  kmem_cache_alloc_node+0x187/0x370
[  259.532551]  copy_process+0x2c4/0x3460
[  259.533080]  kernel_clone+0xf6/0x570
[  259.533553]  user_mode_thread+0xab/0xe0
[  259.534067]  call_usermodehelper_exec_work+0x78/0xb0
[  259.534713]  process_one_work+0x439/0x8d0
[  259.535240]  worker_thread+0x393/0x680
[  259.535733]  kthread+0x1ad/0x1f0
[  259.536192]  ret_from_fork+0x2d/0x50
[  259.536682]  ret_from_fork_asm+0x11/0x20

[  259.537439] Freed by task 21:
[  259.537837]  kasan_save_stack+0x21/0x40
[  259.538350]  kasan_set_track+0x21/0x30
[  259.538864]  kasan_save_free_info+0x27/0x40
[  259.539427]  __kasan_slab_free+0x106/0x180
[  259.539932]  kmem_cache_free+0x1d4/0x460
[  259.540437]  delayed_put_task_struct+0x131/0x170
[  259.541068]  rcu_core+0x63d/0x1470
[  259.541494]  __do_softirq+0x10f/0x51b

[  259.542145] Last potentially related work creation:
[  259.542746]  kasan_save_stack+0x21/0x40
[  259.544124]  __kasan_record_aux_stack+0x94/0xa0
[  259.545804]  __call_rcu_common.constprop.0+0x47/0x620
[  259.546507]  __schedule+0x74c/0x1490
[  259.547010]  schedule+0x81/0xe0
[  259.547458]  schedule_timeout+0x138/0x2a0
[  259.548006]  rcu_gp_fqs_loop+0x1c0/0x990
[  259.548522]  rcu_gp_kthread+0x307/0x3a0
[  259.549032]  kthread+0x1ad/0x1f0
[  259.549471]  ret_from_fork+0x2d/0x50
[  259.549965]  ret_from_fork_asm+0x11/0x20

[  259.550727] Second to last potentially related work creation:
[  259.551493]  kasan_save_stack+0x21/0x40
[  259.552017]  __kasan_record_aux_stack+0x94/0xa0
[  259.552609]  __call_rcu_common.constprop.0+0x47/0x620
[  259.553263]  wait_consider_task+0xad9/0x1a50
[  259.553868]  do_wait+0x3b7/0x530
[  259.554351]  kernel_wait4+0xf0/0x1c0
[  259.554841]  __do_sys_wait4+0xf5/0x100
[  259.555417]  do_syscall_64+0x35/0x80
[  259.555978]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

[  259.556927] The buggy address belongs to the object at ffff88800859dc40
                which belongs to the cache task_struct of size 7616
[  259.558500] The buggy address is located 176 bytes inside of
                freed 7616-byte region [ffff88800859dc40, ffff88800859fa00)

[  259.560279] The buggy address belongs to the physical page:
[  259.561018] page:ffffea0000216600 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x8598
[  259.562223] head:ffffea0000216600 order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  259.563253] memcg:ffff8880061adcc1
[  259.563701] flags: 0x100000000000840(slab|head|node=0|zone=1)
[  259.564489] page_type: 0xffffffff()
[  259.564968] raw: 0100000000000840 ffff888001270500 ffffea0000132000
dead000000000002
[  259.565986] raw: 0000000000000000 0000000080040004 00000001ffffffff
ffff8880061adcc1
[  259.566960] page dumped because: kasan: bad access detected

[  259.567919] Memory state around the buggy address:
[  259.568556]  ffff88800859db80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  259.569494]  ffff88800859dc00: fc fc fc fc fc fc fc fc fa fb fb fb
fb fb fb fb
[  259.570401] >ffff88800859dc80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  259.571290]                                                              ^
[  259.572200]  ffff88800859dd00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  259.573044]  ffff88800859dd80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  259.574019] ==================================================================
[  259.575110] Disabling lock debugging due to kernel taint

And the second hit:

[   36.796236] TCP: AO key not found for (10.0.1.1,
35779)->(10.0.254.1, 7018) S keyid: 100 L3index: 0
[   37.869018] ==================================================================
[   37.870095] BUG: KASAN: slab-use-after-free in reweight_entity+0x3b0/0x490
[   37.870728] Read of size 8 at addr ffff88800fd51f70 by task
unsigned-md5_ip/1488

[   37.871569] CPU: 1 PID: 1488 Comm: unsigned-md5_ip Not tainted 6.6.0-rc6+ #10
[   37.872272] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS Arch Linux 1.16.2-2-2 04/01/2014
[   37.873054] Call Trace:
[   37.873275]  <IRQ>
[   37.873455]  dump_stack_lvl+0x46/0x70
[   37.873780]  print_report+0xc5/0x610
[   37.874147]  ? __virt_addr_valid+0xbe/0x130
[   37.874544]  kasan_report+0xbe/0xf0
[   37.874870]  ? reweight_entity+0x3b0/0x490
[   37.875240]  ? reweight_entity+0x3b0/0x490
[   37.875588]  reweight_entity+0x3b0/0x490
[   37.875923]  task_tick_fair+0x8e/0x3e0
[   37.876257]  ? lock_is_held_type+0xbf/0x110
[   37.876621]  scheduler_tick+0xef/0x210
[   37.876944]  update_process_times+0xb9/0xd0
[   37.877314]  tick_sched_handle+0x37/0x90
[   37.877660]  tick_sched_timer+0x84/0xa0
[   37.877989]  ? tick_sched_do_timer+0x100/0x100
[   37.878437]  __hrtimer_run_queues+0x35e/0x600
[   37.878828]  ? enqueue_hrtimer+0x140/0x140
[   37.879254]  ? kvm_clock_get_cycles+0x14/0x30
[   37.879652]  ? ktime_get_update_offsets_now+0xd9/0x1d0
[   37.880146]  hrtimer_interrupt+0x1b4/0x360
[   37.880506]  __sysvec_apic_timer_interrupt+0xb7/0x280
[   37.880941]  sysvec_apic_timer_interrupt+0x85/0xb0
[   37.881379]  </IRQ>
[   37.881565]  <TASK>
[   37.881751]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   37.882204] RIP: 0010:insert_header+0x3cf/0x8a0
[   37.882600] Code: 8b 7c 24 20 e8 32 17 ec ff 49 c7 47 38 00 00 00
00 48 89 df e8 12 fa ff ff 48 83 c4 60 89 e8 5b 5d 41 5c 41 5d 41 5e
41 5f c3 <48> 8d 6b 10 e9 f4 fd ff ff 31 db 4c 89 ef e8 fe 16 ec ff 49
89 5d
[   37.884196] RSP: 0018:ffffc9000114f240 EFLAGS: 00000286
[   37.884656] RAX: 00000000ffffffff RBX: ffff88800fd72590 RCX: ffffffff8e5cb5f1
[   37.885266] RDX: 1ffffffff1db04b4 RSI: 0000000000000008 RDI: ffffffff8ed825a1
[   37.885857] RBP: 000000000000000d R08: 0000000000000000 R09: fffffbfff1db04b4
[   37.886475] R10: ffffffff8ed825a7 R11: 0000000000000001 R12: 0000000000000013
[   37.887087] R13: ffff88800fd72690 R14: ffffffff8ed827a0 R15: ffffffff8ed825a0
[   37.887681]  ? memcmp+0x41/0xa0
[   37.887972]  __register_sysctl_table+0x57d/0xac0
[   37.888378]  ? proc_sys_evict_inode+0xa0/0xa0
[   37.888751]  ? rcu_is_watching+0x34/0x50
[   37.889134]  ? register_net_sysctl_sz+0xef/0x200
[   37.889531]  __addrconf_sysctl_register+0x16f/0x270
[   37.889954]  ? inet6_netconf_notify_devconf+0x100/0x100
[   37.890408]  ? lockdep_init_map_type+0xe8/0x390
[   37.890798]  addrconf_sysctl_register+0xa5/0xd0
[   37.891213]  ipv6_add_dev+0x4d5/0x890
[   37.891537]  addrconf_notify+0x21a/0xad0
[   37.891876]  ? cfg80211_netdev_notifier_call+0x31/0x750
[   37.892336]  ? lockdep_rtnl_is_held+0x16/0x20
[   37.892732]  notifier_call_chain+0x56/0x180
[   37.893130]  register_netdevice+0x83d/0x960
[   37.893487]  ? unregister_netdevice_queue+0x1e0/0x1e0
[   37.893911]  ? alloc_netdev_mqs+0x78a/0x800
[   37.894318]  vrf_newlink+0x8b/0x4f0
[   37.894654]  __rtnl_newlink+0x7ea/0xc90
[   37.895011]  ? rtnl_setlink+0x250/0x250
[   37.895351]  ? reacquire_held_locks+0x280/0x280
[   37.895753]  ? kasan_unpoison+0x40/0x60
[   37.896112]  ? rtnl_newlink+0x36/0x70
[   37.896439]  rtnl_newlink+0x4f/0x70
[   37.896749]  rtnetlink_rcv_msg+0x1f8/0x650
[   37.897263]  ? rtnl_getlink+0x590/0x590
[   37.897616]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[   37.898089]  ? find_held_lock+0x8a/0xa0
[   37.898462]  ? local_clock_noinstr+0x9/0xb0
[   37.898896]  netlink_rcv_skb+0xdd/0x210
[   37.899709]  ? rtnl_getlink+0x590/0x590
[   37.900112]  ? netlink_ack+0x840/0x840
[   37.900468]  ? lock_sync+0x100/0x100
[   37.900784]  ? __rcu_read_unlock+0x6b/0x2a0
[   37.901198]  ? netlink_deliver_tap+0xfe/0x620
[   37.901583]  netlink_unicast+0x2f3/0x480
[   37.901926]  ? netlink_attachskb+0x440/0x440
[   37.902318]  netlink_sendmsg+0x3c0/0x6e0
[   37.902662]  ? netlink_unicast+0x480/0x480
[   37.903037]  ? netlink_unicast+0x480/0x480
[   37.903396]  __sock_sendmsg+0x73/0xc0
[   37.903725]  __sys_sendto+0x18b/0x210
[   37.904084]  ? __ia32_sys_getpeername+0x50/0x50
[   37.904521]  ? mark_held_locks+0x1a/0x80
[   37.904892]  __x64_sys_sendto+0x72/0x80
[   37.905257]  do_syscall_64+0x35/0x80
[   37.905584]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   37.906053] RIP: 0033:0x7fb3d69e69ec
[   37.906379] Code: 89 4c 24 1c e8 a5 63 f7 ff 44 8b 54 24 1c 8b 3c
24 45 31 c9 89 c5 48 8b 54 24 10 48 8b 74 24 08 45 31 c0 b8 2c 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 04 24 e8 f1 63 f7 ff 48
8b 04
[   37.907987] RSP: 002b:00007fff52147f60 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[   37.908695] RAX: ffffffffffffffda RBX: 00007fff52147fa0 RCX: 00007fb3d69e69ec
[   37.909335] RDX: 0000000000000044 RSI: 00007fff52147fa0 RDI: 0000000000000006
[   37.909978] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   37.910597] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000038
[   37.911224] R13: 0000000000000006 R14: 00007fff52147fcc R15: 00007fff52147fd8
[   37.911894]  </TASK>

[   37.912609] Allocated by task 817:
[   37.913277]  kasan_save_stack+0x21/0x40
[   37.913712]  kasan_set_track+0x21/0x30
[   37.914070]  __kasan_slab_alloc+0x62/0x70
[   37.914436]  kmem_cache_alloc_node+0x187/0x370
[   37.914835]  copy_process+0x2c4/0x3460
[   37.915187]  kernel_clone+0xf6/0x570
[   37.915502]  user_mode_thread+0xab/0xe0
[   37.915837]  call_usermodehelper_exec_work+0x78/0xb0
[   37.916288]  process_one_work+0x439/0x8d0
[   37.916652]  worker_thread+0x393/0x680
[   37.917001]  kthread+0x1ad/0x1f0
[   37.917343]  ret_from_fork+0x2d/0x50
[   37.917673]  ret_from_fork_asm+0x11/0x20

[   37.918208] Freed by task 0:
[   37.918471]  kasan_save_stack+0x21/0x40
[   37.918833]  kasan_set_track+0x21/0x30
[   37.919192]  kasan_save_free_info+0x27/0x40
[   37.919576]  __kasan_slab_free+0x106/0x180
[   37.919967]  kmem_cache_free+0x1d4/0x460
[   37.920337]  delayed_put_task_struct+0x131/0x170
[   37.920762]  rcu_core+0x63d/0x1470
[   37.921113]  __do_softirq+0x10f/0x51b

[   37.921613] Last potentially related work creation:
[   37.922097]  kasan_save_stack+0x21/0x40
[   37.922460]  __kasan_record_aux_stack+0x94/0xa0
[   37.922875]  __call_rcu_common.constprop.0+0x47/0x620
[   37.923353]  __schedule+0x74c/0x1490
[   37.923685]  schedule+0x81/0xe0
[   37.923989]  schedule_timeout+0x138/0x2a0
[   37.924365]  rcu_gp_fqs_loop+0x1c0/0x990
[   37.924737]  rcu_gp_kthread+0x307/0x3a0
[   37.925112]  kthread+0x1ad/0x1f0
[   37.925416]  ret_from_fork+0x2d/0x50
[   37.925753]  ret_from_fork_asm+0x11/0x20

[   37.926280] The buggy address belongs to the object at ffff88800fd51ec0
                which belongs to the cache task_struct of size 7616
[   37.927547] The buggy address is located 176 bytes inside of
                freed 7616-byte region [ffff88800fd51ec0, ffff88800fd53c80)

[   37.928923] The buggy address belongs to the physical page:
[   37.929463] page:ffffea00003f5400 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0xfd50
[   37.930370] head:ffffea00003f5400 order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   37.931313] memcg:ffff888006cc0f41
[   37.931735] flags: 0x100000000000840(slab|head|node=0|zone=1)
[   37.932434] page_type: 0xffffffff()
[   37.932787] raw: 0100000000000840 ffff888001270500 dead000000000122
0000000000000000
[   37.933502] raw: 0000000000000000 0000000080040004 00000001ffffffff
ffff888006cc0f41
[   37.934220] page dumped because: kasan: bad access detected

[   37.934911] Memory state around the buggy address:
[   37.935377]  ffff88800fd51e00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   37.936063]  ffff88800fd51e80: fc fc fc fc fc fc fc fc fa fb fb fb
fb fb fb fb
[   37.936729] >ffff88800fd51f00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   37.937445]                                                              ^
[   37.938101]  ffff88800fd51f80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   37.938817]  ffff88800fd52000: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   37.939655] ==================================================================
[   37.940196] Disabling lock debugging due to kernel taint


On Mon, 16 Oct 2023 at 08:41, syzbot
<syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1413e691680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3908cdfd655fd839c82f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a055f9680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103ef619680000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9a3dad63.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98467f6633b7/vmlinux-9a3dad63.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/93b5cb4a26b0/bzImage-9a3dad63.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in __update_min_deadline kernel/sched/fair.c:805 [inline]
> BUG: KASAN: slab-use-after-free in min_deadline_update kernel/sched/fair.c:819 [inline]
> BUG: KASAN: slab-use-after-free in min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
> BUG: KASAN: slab-use-after-free in reweight_entity+0x8e3/0xa60 kernel/sched/fair.c:3660
> Read of size 8 at addr ffff888022a59a70 by task syz-executor206/5331
>
> CPU: 3 PID: 5331 Comm: syz-executor206 Not tainted 6.6.0-rc5-syzkaller-00267-g9a3dad63edbe #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  __update_min_deadline kernel/sched/fair.c:805 [inline]
>  min_deadline_update kernel/sched/fair.c:819 [inline]
>  min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
>  reweight_entity+0x8e3/0xa60 kernel/sched/fair.c:3660
>  entity_tick kernel/sched/fair.c:5317 [inline]
>  task_tick_fair+0xee/0xcd0 kernel/sched/fair.c:12392
>  scheduler_tick+0x210/0x650 kernel/sched/core.c:5657
>  update_process_times+0x19f/0x220 kernel/time/timer.c:2076
>  tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
>  tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
>  __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
>  __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
>  __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
>  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
> RIP: 0010:rcu_is_watching+0x39/0xb0 kernel/rcu/tree.c:699
> Code: a5 cf 08 48 c7 c3 e8 6d 03 00 83 f8 07 89 c5 77 7a 48 8d 3c ed 40 ba 5c 8c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 54 48 03 1c ed 40 ba 5c 8c 48 b8 00 00 00 00 00 fc
> RSP: 0018:ffffc90003cc73d8 EFLAGS: 00000a06
> RAX: dffffc0000000000 RBX: 0000000000036de8 RCX: 1ffffffff1d9a7c0
> RDX: 1ffffffff18b974b RSI: ffffffff8ae90aa0 RDI: ffffffff8c5cba58
> RBP: 0000000000000003 R08: 0000000000000007 R09: ffffffffff600000
> R10: 00007fcac0348000 R11: dffffc0000000000 R12: ffffc90003cc7488
> R13: ffffffff81747dc0 R14: ffffc90003cc7500 R15: ffff88802787c780
>  kernel_text_address kernel/extable.c:113 [inline]
>  kernel_text_address+0x62/0xd0 kernel/extable.c:94
>  __kernel_text_address+0xd/0x30 kernel/extable.c:79
>  unwind_get_return_address+0x78/0xe0 arch/x86/kernel/unwind_orc.c:369
>  arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
>  stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slab.c:3237 [inline]
>  slab_alloc mm/slab.c:3246 [inline]
>  __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
>  kmem_cache_alloc+0x159/0x400 mm/slab.c:3432
>  kmem_cache_zalloc include/linux/slab.h:710 [inline]
>  alloc_buffer_head+0x21/0x140 fs/buffer.c:3023
>  folio_alloc_buffers+0x2e7/0x7f0 fs/buffer.c:935
>  folio_create_empty_buffers+0x36/0x470 fs/buffer.c:1648
>  ext4_block_write_begin+0xcc4/0xf10 fs/ext4/inode.c:1024
>  ext4_da_write_begin+0x40a/0x8c0 fs/ext4/inode.c:2890
>  generic_perform_write+0x278/0x600 mm/filemap.c:3969
>  ext4_buffered_write_iter+0x11f/0x3c0 fs/ext4/file.c:299
>  ext4_file_write_iter+0x7f7/0x1860 fs/ext4/file.c:717
>  call_write_iter include/linux/fs.h:1956 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x650/0xe40 fs/read_write.c:584
>  ksys_write+0x12f/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fcac0348789
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff03860d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcac0348789
> RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff03860d7c
> R13: 00007fff03860d90 R14: 00007fff03860dd0 R15: 0000000000000015
>  </TASK>
>
> Allocated by task 2:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slab.c:3237 [inline]
>  kmem_cache_alloc_node+0x173/0x540 mm/slab.c:3509
>  alloc_task_struct_node kernel/fork.c:173 [inline]
>  dup_task_struct kernel/fork.c:1110 [inline]
>  copy_process+0x41c/0x73f0 kernel/fork.c:2327
>  kernel_clone+0xfd/0x920 kernel/fork.c:2909
>  kernel_thread+0xc0/0x100 kernel/fork.c:2971
>  create_kthread kernel/kthread.c:411 [inline]
>  kthreadd+0x4fb/0x7d0 kernel/kthread.c:746
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
> Freed by task 21:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  __cache_free mm/slab.c:3370 [inline]
>  __do_kmem_cache_free mm/slab.c:3557 [inline]
>  kmem_cache_free+0x104/0x380 mm/slab.c:3582
>  put_task_struct include/linux/sched/task.h:136 [inline]
>  put_task_struct include/linux/sched/task.h:123 [inline]
>  delayed_put_task_struct+0x21b/0x2b0 kernel/exit.c:226
>  rcu_do_batch kernel/rcu/tree.c:2139 [inline]
>  rcu_core+0x805/0x1bb0 kernel/rcu/tree.c:2403
>  __do_softirq+0x218/0x965 kernel/softirq.c:553
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
>  __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
>  put_task_struct_rcu_user kernel/exit.c:232 [inline]
>  put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
>  context_switch kernel/sched/core.c:5385 [inline]
>  __schedule+0xee9/0x5a10 kernel/sched/core.c:6695
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
>  schedule_timeout+0x278/0x2c0 kernel/time/timer.c:2143
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common+0x3e0/0x5f0 kernel/sched/completion.c:116
>  kthread_stop+0x18e/0x5f0 kernel/kthread.c:709
>  kvm_mmu_pre_destroy_vm+0x44/0x60 arch/x86/kvm/mmu/mmu.c:7160
>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1313 [inline]
>  kvm_put_kvm+0x254/0xad0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1373
>  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1396
>  __fput+0x3f7/0xa70 fs/file_table.c:384
>  __fput_sync+0x47/0x50 fs/file_table.c:465
>  __do_sys_close fs/open.c:1572 [inline]
>  __se_sys_close fs/open.c:1557 [inline]
>  __x64_sys_close+0x87/0xf0 fs/open.c:1557
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Second to last potentially related work creation:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
>  __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
>  put_task_struct_rcu_user kernel/exit.c:232 [inline]
>  put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
>  context_switch kernel/sched/core.c:5385 [inline]
>  __schedule+0xee9/0x5a10 kernel/sched/core.c:6695
>  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
>  schedule_timeout+0x278/0x2c0 kernel/time/timer.c:2143
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common+0x3e0/0x5f0 kernel/sched/completion.c:116
>  kthread_stop+0x18e/0x5f0 kernel/kthread.c:709
>  kvm_mmu_pre_destroy_vm+0x44/0x60 arch/x86/kvm/mmu/mmu.c:7160
>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1313 [inline]
>  kvm_put_kvm+0x254/0xad0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1373
>  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1396
>  __fput+0x3f7/0xa70 fs/file_table.c:384
>  __fput_sync+0x47/0x50 fs/file_table.c:465
>  __do_sys_close fs/open.c:1572 [inline]
>  __se_sys_close fs/open.c:1557 [inline]
>  __x64_sys_close+0x87/0xf0 fs/open.c:1557
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff888022a599c0
>  which belongs to the cache task_struct of size 8960
> The buggy address is located 176 bytes inside of
>  freed 8960-byte region [ffff888022a599c0, ffff888022a5bcc0)
>
> The buggy address belongs to the physical page:
> page:ffffea00008a9600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22a58
> head:ffffea00008a9600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0x1()
> raw: 00fff00000000840 ffff88810005a500 ffffea00009ffb10 ffffea0000bf6410
> raw: 0000000000000000 ffff888022a599c0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 4949, tgid 4949 (dhcpcd-run-hook), ts 26983961004, free_ts 23254563577
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
>  prep_new_page mm/page_alloc.c:1543 [inline]
>  get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
>  __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
>  __alloc_pages_node include/linux/gfp.h:237 [inline]
>  kmem_getpages mm/slab.c:1356 [inline]
>  cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
>  cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
>  ____cache_alloc mm/slab.c:2999 [inline]
>  ____cache_alloc mm/slab.c:2982 [inline]
>  __do_cache_alloc mm/slab.c:3182 [inline]
>  slab_alloc_node mm/slab.c:3230 [inline]
>  kmem_cache_alloc_node+0x481/0x540 mm/slab.c:3509
>  alloc_task_struct_node kernel/fork.c:173 [inline]
>  dup_task_struct kernel/fork.c:1110 [inline]
>  copy_process+0x41c/0x73f0 kernel/fork.c:2327
>  kernel_clone+0xfd/0x920 kernel/fork.c:2909
>  __do_sys_clone+0xba/0x100 kernel/fork.c:3052
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1136 [inline]
>  free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
>  free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
>  slab_destroy mm/slab.c:1608 [inline]
>  slabs_destroy+0x85/0xc0 mm/slab.c:1628
>  cache_flusharray mm/slab.c:3341 [inline]
>  ___cache_free+0x2b7/0x420 mm/slab.c:3404
>  qlink_free mm/kasan/quarantine.c:166 [inline]
>  qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:185
>  kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
>  __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
>  kasan_slab_alloc include/linux/kasan.h:188 [inline]
>  slab_post_alloc_hook mm/slab.h:762 [inline]
>  slab_alloc_node mm/slab.c:3237 [inline]
>  kmem_cache_alloc_node+0x173/0x540 mm/slab.c:3509
>  __alloc_skb+0x287/0x330 net/core/skbuff.c:640
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6313
>  sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2795
>  unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  sock_write_iter+0x29b/0x3d0 net/socket.c:1158
>  call_write_iter include/linux/fs.h:1956 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x650/0xe40 fs/read_write.c:584
>  ksys_write+0x1f0/0x250 fs/read_write.c:637
>
> Memory state around the buggy address:
>  ffff888022a59900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888022a59980: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> >ffff888022a59a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                              ^
>  ffff888022a59a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888022a59b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> ----------------
> Code disassembly (best guess), 3 bytes skipped:
>    0:   48 c7 c3 e8 6d 03 00    mov    $0x36de8,%rbx
>    7:   83 f8 07                cmp    $0x7,%eax
>    a:   89 c5                   mov    %eax,%ebp
>    c:   77 7a                   ja     0x88
>    e:   48 8d 3c ed 40 ba 5c    lea    -0x73a345c0(,%rbp,8),%rdi
>   15:   8c
>   16:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1d:   fc ff df
>   20:   48 89 fa                mov    %rdi,%rdx
>   23:   48 c1 ea 03             shr    $0x3,%rdx
> * 27:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2b:   75 54                   jne    0x81
>   2d:   48 03 1c ed 40 ba 5c    add    -0x73a345c0(,%rbp,8),%rbx
>   34:   8c
>   35:   48                      rex.W
>   36:   b8 00 00 00 00          mov    $0x0,%eax
>   3b:   00 fc                   add    %bh,%ah
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup



-- 
             Dmitry
