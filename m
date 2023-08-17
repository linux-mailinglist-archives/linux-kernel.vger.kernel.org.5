Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1E77F564
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbjHQLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350297AbjHQLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:37:32 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA3F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:37:31 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf0b05bbaeso13597925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272250; x=1692877050;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xelir9/rKPczq8oru/RtYCQP8k46PiSLeHtuzlhb+mU=;
        b=Y5KM+yPmj+fXPdMGlA65/8pyq2O7A8m7q0K3Y9K8wWQDDnSCCov5Q8+I14kemWAyQC
         aJ3fYS1IV1rG8m0ejb6NPiMp4Xac0usmf14kSquhh7/ejtev7DRxCdB1bBcYSFEs9CGZ
         6VxLVraO9hkvuWcYWXu+lp0HOmiZuwD8sZ6wNmmpm0yXvJRWasXG5qKl1yNyys7hL8az
         Oo5TrmD3pD29DxRGuW7qkUr3CcVEtVuHtz+m2d/0zBwVeRku6/ZLpTyGrksWpDR5ujnz
         +sD7wbAD0YndE2PWmuaepE8g4C4LaU4r551POxjWefHnBXnKXxRue4NlY7ubH94voN6b
         hl7Q==
X-Gm-Message-State: AOJu0YzahLEaytpbzCoVRYEbi7QvNuMA1+SXNnvyUzOctkICT5TqymKL
        QYMIXPA9ct3j/B8iVGRXWt3xGdb3C/9su7qAske7pGgkr9Uf
X-Google-Smtp-Source: AGHT+IHRDPRqWh9woIH+w6J3I2tojN8zTsS84bpO9sQ5wIVcuqSpxEuFqYyONUGSAX/7MgJzKw3GUfnzagW2kXiQ/aZ6XZUk6IXb
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4c3:b0:1bc:599a:7362 with SMTP id
 o3-20020a170902d4c300b001bc599a7362mr2115987plg.9.1692272250768; Thu, 17 Aug
 2023 04:37:30 -0700 (PDT)
Date:   Thu, 17 Aug 2023 04:37:30 -0700
In-Reply-To: <20230817102842.1706-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed5b006031cd65a@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: rcu detected stall in
 wg_ratelimiter_gc_entries (2)
From:   syzbot <syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in process_one_work

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 2685 jiffies s: 52849 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.5.0-rc5-syzkaller-00194-gace0ab3a4b54-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x0/0x20 kernel/kcov.c:303
Code: d6 fe ff ff 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b 0c 24 0f b7 d6 0f b7 f7 bf 03 00 00 00 e9 b8 fe ff ff 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 48 8b 0c 24 89 f2 89 fe bf 05 00 00 00 e9 9a fe ff ff
RSP: 0018:ffffc90000007e38 EFLAGS: 00000046
RAX: 0000000000000001 RBX: ffff8880b982b980 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000004e R12: ffff8880b982b880
R13: 177c2886f5028478 R14: ffff8880719ee340 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa162667440 CR3: 000000000c776000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1654 [inline]
 __hrtimer_run_queues+0x964/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1098 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:queue_delayed_work_on+0x9a/0x130 kernel/workqueue.c:1908
Code: ff 48 89 ee e8 c7 26 31 00 48 85 ed 75 42 e8 2d 2b 31 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 ab 26 31 00 48 85 db 75 71 <e8> 11 2b 31 00 44 89 e8 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc90000117cb0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801664d940 RSI: ffffffff8154ddd6 RDI: 0000000000000007
RBP: 0000000000000200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000004e R12: ffff88801465ad00
R13: 0000000000000001 R14: ffff888028eae000 R15: 00000000000003e8
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


Tested on:

commit:         ace0ab3a Revert "vlan: Fix VLAN 0 memory leak"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=160073c3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=c1cc0083f159b67cb192
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c69eefa80000

