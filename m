Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAB7841F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHVNZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjHVNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:25:28 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE5BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:25:25 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26ecc4795a4so3240892a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710725; x=1693315525;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8tCLlfYWwH9oVnkEMQ4vi3aMZyRFbKfbJii5+GgfwI=;
        b=bJBtRuh3UlIMhoDFyVn5Wig3bUVOC354nYnMWCCHCK2xF7G4oS4zywzi2+tGlpfg2v
         taeOB/EQS37Y3bMxXd2ktmxFXF0iL2OC7zohX5R1apekzOTNsfTxkNQWnViAGoFRpAZr
         mkjgvZZ0AllwD7VYMlPmV1jD4usltROTRbK0RtTpskIPu+aJ1aGDDHGJq3Pi02aKu/B2
         p8QGwQVbcNOZgswsfGWgyTm/4Ayl/iZ2DrISHiBSj7p6kLKy2FT2pwjd2a3ruzl1SYio
         L0fBCVLffc58EB/96RrXTI2E4emq7vkOZ82+XF0K5uKkrTWTaxqgcVbaW3oxn/X06M2R
         e+qQ==
X-Gm-Message-State: AOJu0YwQ3ZXwGSZuqtK7SrejnpuMXy6b70AM42Qf2zVSrB0ac2J6sDzC
        XoLG0t+0jXaNHrEvKiQn+fxci6nJlD/VhZTSwGsmK1GtoklY
X-Google-Smtp-Source: AGHT+IHk7nQgshRmG/SJq9nqbmttR2fjK8aksej7wuHZ4B+u9BwSB7PbBC+mdnokOj6zGWZVVONDtvCR8Ny0vgbePOO1x20O7rlm
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c381:b0:26d:2126:aa49 with SMTP id
 h1-20020a17090ac38100b0026d2126aa49mr2467401pjt.2.1692710725247; Tue, 22 Aug
 2023 06:25:25 -0700 (PDT)
Date:   Tue, 22 Aug 2023 06:25:25 -0700
In-Reply-To: <20230822114553.2719-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c6b7f060382ed69@google.com>
Subject: Re: [syzbot] [batman?] WARNING in call_netdevice_notifiers_info
From:   syzbot <syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

t/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 __sys_sendto+0x255/0x340 net/socket.c:2134
 __do_sys_sendto net/socket.c:2146 [inline]
 __se_sys_sendto net/socket.c:2142 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f372a07e7dc
Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
RSP: 002b:00007ffd0be0cda0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f372acc4620 RCX: 00007f372a07e7dc
RDX: 000000000000002c RSI: 00007f372acc4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd0be0cdf4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f372acc4670 R15: 0000000000000000
 </TASK>


Warning: Permanently added '10.128.1.138' (ED25519) to the list of known hosts.
2023/08/22 13:24:01 fuzzer started
2023/08/22 13:24:01 connecting to host at 10.128.0.169:36627
2023/08/22 13:24:01 checking machine...
2023/08/22 13:24:01 checking revisions...
2023/08/22 13:24:01 testing simple program...
[   57.017895][ T5023] cgroup: Unknown subsys name 'net'
[   57.181711][ T5023] cgroup: Unknown subsys name 'rlimit'
[   58.562226][ T5023] Adding 124996k swap on ./swap-file.  Priority:0 extents:1 across:124996k FS
[   58.575443][ T5021] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5021 'syz-fuzzer'
[   58.704723][ T5028] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[   58.712819][ T5028] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[   58.720864][ T5028] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[   58.729629][ T5028] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[   58.737964][ T5028] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[   58.746482][ T5028] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[   58.873127][ T5026] chnl_net:caif_netlink_parms(): no params data found
[   58.927097][ T5026] bridge0: port 1(bridge_slave_0) entered blocking state
[   58.936670][ T5026] bridge0: port 1(bridge_slave_0) entered disabled state
[   58.944713][ T5026] bridge_slave_0: entered allmulticast mode
[   58.960073][ T5026] bridge_slave_0: entered promiscuous mode
[   58.969547][ T5026] bridge0: port 2(bridge_slave_1) entered blocking state
[   58.976767][ T5026] bridge0: port 2(bridge_slave_1) entered disabled state
[   58.983915][ T5026] bridge_slave_1: entered allmulticast mode
[   58.990913][ T5026] bridge_slave_1: entered promiscuous mode
[   59.012878][ T5026] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[   59.024772][ T5026] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[   59.051026][ T5026] team0: Port device team_slave_0 added
[   59.059189][ T5026] team0: Port device team_slave_1 added
[   59.078141][ T5026] batman_adv: batadv0: Adding interface: batadv_slave_0
[   59.085319][ T5026] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   59.112318][ T5026] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
[   59.125419][ T5026] batman_adv: batadv0: Adding interface: batadv_slave_1
[   59.132742][ T5026] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   59.159529][ T5026] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   59.191088][ T5026] hsr_slave_0: entered promiscuous mode
[   59.197913][ T5026] hsr_slave_1: entered promiscuous mode
[   59.290486][ T5026] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   59.301306][ T5026] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   59.311233][ T5026] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   59.322571][ T5026] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   59.344435][ T5026] bridge0: port 2(bridge_slave_1) entered blocking state
[   59.351796][ T5026] bridge0: port 2(bridge_slave_1) entered forwarding state
[   59.361448][ T5026] bridge0: port 1(bridge_slave_0) entered blocking state
[   59.369739][ T5026] bridge0: port 1(bridge_slave_0) entered forwarding state
[   59.424526][ T5026] 8021q: adding VLAN 0 to HW filter on device bond0
[   59.440733][ T5037] bridge0: port 1(bridge_slave_0) entered disabled state
[   59.450802][ T5037] bridge0: port 2(bridge_slave_1) entered disabled state
[   59.468337][ T5026] 8021q: adding VLAN 0 to HW filter on device team0
[   59.482456][   T22] bridge0: port 1(bridge_slave_0) entered blocking state
[   59.492153][   T22] bridge0: port 1(bridge_slave_0) entered forwarding state
[   59.506339][ T5038] bridge0: port 2(bridge_slave_1) entered blocking state
[   59.513883][ T5038] bridge0: port 2(bridge_slave_1) entered forwarding state
[   59.676572][ T5026] 8021q: adding VLAN 0 to HW filter on device batadv0
[   59.709625][ T5026] veth0_vlan: entered promiscuous mode
[   59.721272][ T5026] veth1_vlan: entered promiscuous mode
[   59.746020][ T5026] veth0_macvtap: entered promiscuous mode
[   59.754854][ T5026] veth1_macvtap: entered promiscuous mode
[   59.774188][ T5026] batman_adv: batadv0: Interface activated: batadv_slave_0
[   59.783611][ T5026] 
[   59.785948][ T5026] ============================================
[   59.792214][ T5026] WARNING: possible recursive locking detected
[   59.798351][ T5026] 6.5.0-rc6-syzkaller-00126-gd44036cad311-dirty #0 Not tainted
[   59.805885][ T5026] --------------------------------------------
[   59.812077][ T5026] syz-executor.0/5026 is trying to acquire lock:
[   59.818521][ T5026] ffffffff8e3e0f68 (rtnl_mutex){+.+.}-{3:3}, at: batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   59.829840][ T5026] 
[   59.829840][ T5026] but task is already holding lock:
[   59.837516][ T5026] ffffffff8e3e0f68 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e2/0xd30
[   59.847166][ T5026] 
[   59.847166][ T5026] other info that might help us debug this:
[   59.855838][ T5026]  Possible unsafe locking scenario:
[   59.855838][ T5026] 
[   59.865689][ T5026]        CPU0
[   59.869922][ T5026]        ----
[   59.874173][ T5026]   lock(rtnl_mutex);
[   59.878846][ T5026]   lock(rtnl_mutex);
[   59.883701][ T5026] 
[   59.883701][ T5026]  *** DEADLOCK ***
[   59.883701][ T5026] 
[   59.892540][ T5026]  May be due to missing lock nesting notation
[   59.892540][ T5026] 
[   59.901828][ T5026] 1 lock held by syz-executor.0/5026:
[   59.907302][ T5026]  #0: ffffffff8e3e0f68 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x3e2/0xd30
[   59.919046][ T5026] 
[   59.919046][ T5026] stack backtrace:
[   59.926250][ T5026] CPU: 0 PID: 5026 Comm: syz-executor.0 Not tainted 6.5.0-rc6-syzkaller-00126-gd44036cad311-dirty #0
[   59.938381][ T5026] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
[   59.948991][ T5026] Call Trace:
[   59.952408][ T5026]  <TASK>
[   59.955527][ T5026]  dump_stack_lvl+0xd9/0x1b0
[   59.960423][ T5026]  __lock_acquire+0x2971/0x5de0
[   59.966018][ T5026]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   59.972780][ T5026]  lock_acquire+0x1ae/0x510
[   59.978452][ T5026]  ? batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   59.986470][ T5026]  ? lock_sync+0x190/0x190
[   59.991286][ T5026]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   59.998306][ T5026]  ? preempt_count_sub+0x150/0x150
[   60.005708][ T5026]  __mutex_lock+0x181/0x1340
[   60.011037][ T5026]  ? batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   60.018701][ T5026]  ? batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   60.030519][ T5026]  ? find_held_lock+0x2d/0x110
[   60.036618][ T5026]  ? mutex_lock_io_nested+0x11a0/0x11a0
[   60.042288][ T5026]  ? batadv_hardif_min_mtu+0x18e/0x3f0
[   60.048474][ T5026]  ? reacquire_held_locks+0x4b0/0x4b0
[   60.054147][ T5026]  ? batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   60.061299][ T5026]  ? rtnl_lock+0x9/0x20
[   60.067412][ T5026]  batadv_hardif_activate_interface.part.0+0x1a1/0x340
[   60.075096][ T5026]  batadv_hard_if_event+0x6be/0x1670
[   60.081119][ T5026]  ? smc_pnet_netdev_event+0x85/0x7b0
[   60.087273][ T5026]  ? lockdep_rtnl_is_held+0x26/0x30
[   60.093222][ T5026]  notifier_call_chain+0xb6/0x3b0
[   60.098670][ T5026]  ? batadv_hardif_disable_interface+0xec0/0xec0
[   60.105830][ T5026]  call_netdevice_notifiers_info+0xb9/0x130
[   60.112104][ T5026]  __dev_notify_flags+0x12d/0x2e0
[   60.118141][ T5026]  ? dev_change_name+0x7c0/0x7c0
[   60.123456][ T5026]  ? dev_set_allmulti+0x30/0x30
[   60.128510][ T5026]  ? slab_free_freelist_hook+0x10b/0x1e0
[   60.134258][ T5026]  dev_change_flags+0x122/0x170
[   60.139177][ T5026]  do_setlink+0x1a2a/0x3fa0
[   60.143797][ T5026]  ? rtnl_bridge_getlink+0x8c0/0x8c0
[   60.149364][ T5026]  ? unwind_next_frame+0xe41/0x2020
[   60.154588][ T5026]  ? __module_address+0x55/0x3b0
[   60.159565][ T5026]  ? bpf_ksym_find+0x124/0x1b0
[   60.164361][ T5026]  ? write_profile+0x450/0x450
[   60.169272][ T5026]  ? is_bpf_text_address+0x9b/0x1a0
[   60.174510][ T5026]  ? kernel_text_address+0x85/0xf0
[   60.180023][ T5026]  ? __kernel_text_address+0xd/0x30
[   60.185454][ T5026]  ? unwind_get_return_address+0x55/0xa0
[   60.191233][ T5026]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   60.197426][ T5026]  ? __nla_validate_parse+0x58a/0x2530
[   60.203002][ T5026]  ? nla_get_range_signed+0x370/0x370
[   60.208760][ T5026]  ? stack_trace_save+0x96/0xd0
[   60.213729][ T5026]  ? filter_irq_stacks+0x90/0x90
[   60.218785][ T5026]  ? __stack_depot_save+0x39/0x510
[   60.224291][ T5026]  ? __nla_parse+0x40/0x50
[   60.228910][ T5026]  __rtnl_newlink+0xc04/0x18c0
[   60.233709][ T5026]  ? rtnl_link_unregister+0x260/0x260
[   60.239133][ T5026]  rtnl_newlink+0x67/0xa0
[   60.243561][ T5026]  ? __rtnl_newlink+0x18c0/0x18c0
[   60.248605][ T5026]  rtnetlink_rcv_msg+0x439/0xd30
[   60.253569][ T5026]  ? rtnl_getlink+0xb40/0xb40
[   60.258628][ T5026]  ? netdev_core_pick_tx+0x390/0x390
[   60.264034][ T5026]  netlink_rcv_skb+0x16b/0x440
[   60.269237][ T5026]  ? rtnl_getlink+0xb40/0xb40
[   60.273959][ T5026]  ? netlink_ack+0x1370/0x1370
[   60.278780][ T5026]  ? netlink_deliver_tap+0x1b1/0xd00
[   60.284179][ T5026]  netlink_unicast+0x539/0x800
[   60.288975][ T5026]  ? netlink_attachskb+0x880/0x880
[   60.294186][ T5026]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   60.300111][ T5026]  ? __phys_addr_symbol+0x30/0x70
[   60.305192][ T5026]  ? __check_object_size+0x323/0x740
[   60.310487][ T5026]  netlink_sendmsg+0x93c/0xe30
[   60.315269][ T5026]  ? netlink_unicast+0x800/0x800
[   60.320225][ T5026]  ? bpf_lsm_socket_sendmsg+0x9/0x10
[   60.325521][ T5026]  ? netlink_unicast+0x800/0x800
[   60.330562][ T5026]  sock_sendmsg+0xd9/0x180
[   60.334990][ T5026]  __sys_sendto+0x255/0x340
[   60.339517][ T5026]  ? __ia32_sys_getpeername+0xb0/0xb0
[   60.345034][ T5026]  ? reacquire_held_locks+0x4b0/0x4b0
[   60.350448][ T5026]  ? preempt_count_sub+0x150/0x150
[   60.355769][ T5026]  ? __rseq_handle_notify_resume+0x5f2/0x1010
[   60.361888][ T5026]  ? preempt_count_sub+0x150/0x150
[   60.367153][ T5026]  __x64_sys_sendto+0xe0/0x1b0
[   60.372033][ T5026]  ? syscall_enter_from_user_mode+0x26/0x80
[   60.378058][ T5026]  do_syscall_64+0x38/0xb0
[   60.382630][ T5026]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.388622][ T5026] RIP: 0033:0x7f372a07e7dc
[   60.393141][ T5026] Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
[   60.413916][ T5026] RSP: 002b:00007ffd0be0cda0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[   60.424512][ T5026] RAX: ffffffffffffffda RBX: 00007f372acc4620 RCX: 00007f372a07e7dc
[   60.432609][ T5026] RDX: 000000000000002c RSI: 00007f372acc4670 RDI: 0000000000000003
[   60.441019][ T5026] RBP: 0000000000000000 R08: 00007ffd0be0cdf4 R09: 000000000000000c
executing program
[   60.449348][ T5026] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
[   60.457780][ T5026] R13: 0000000000000000 R14: 00007f372acc4670 R15: 0000000000000000
[   60.466494][ T5026]  </TASK>
[   60.785109][ T4431] Bluetooth: hci0: command 0x0409 tx timeout
executing program
[   62.865081][ T4431] Bluetooth: hci0: command 0x041b tx timeout
[   64.945041][ T4431] Bluetooth: hci0: command 0x040f tx timeout
executing program
[   67.025170][ T4431] Bluetooth: hci0: command 0x0419 tx timeout
executing program


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build140395884=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at d216d8a03
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d216d8a03b50bef82eac746d227230835f061640 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230818-113734'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d216d8a03b50bef82eac746d227230835f061640 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230818-113734'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=d216d8a03b50bef82eac746d227230835f061640 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230818-113734'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"d216d8a03b50bef82eac746d227230835f061640\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=160228b7a80000


Tested on:

commit:         d44036ca net: dsa: felix: fix oversize frame dropping ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=f8812454d9b3ac00d282
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c59b5fa80000

