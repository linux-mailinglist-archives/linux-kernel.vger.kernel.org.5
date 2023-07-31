Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251AE768F49
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGaH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjGaH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:58:02 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F11AD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1bbbd92497fso8343545fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790279; x=1691395079;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqlNPjVNBo1smZbmnxbRjUE+Z5KQuPdPjf++YfsVJrs=;
        b=DNNaLh+AKM4E2K//frxeVMd+4Kfz3jaFY7VPrS9vZy4VAGR674+q243HaYTPnZiriP
         0EULYT30twT1iLAzfmATFlG2nEQgA9VizxAVrQCtkT5dg/XhCM5AN7Osc92pbfTDtCVD
         ZEtMBu4T9wQ/1HxIH7/kpQjwhAVwEtKuxZwWBlxAJcSwFsKnbnSYIvqye2Mid0JKwyN0
         OaTJ31n/Ga8VB87uHDj54BiJbvDZSqftXx6P2c5Em+jOiivPCu1j2ot4bndiLCmXcLhA
         HU+ifs8wCw31VMToLCeL2RfC6kfxBSXiTgBg57pG80NGAcDbY7Xq5Xmtb/UrOmcp7SPA
         hRZA==
X-Gm-Message-State: ABy/qLYJvgab/NMfghNlT9aLiYR/RiqGpV30Voij2ts12W8iYzLSXYKI
        zid1hhmMmT/u/GBgY54s30MxHBxiz3dJSw8M7RNbtUDD9kGt
X-Google-Smtp-Source: APBJJlEjE1ph2iCy4jYhnl82jclJZG+l8w2MbX5LTGTQDvQcETXfFSYU0v5NnBIn/Fak4MFm3Seib/7Ca/CHPgGtReRt4M1BKjG0
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8aa:b0:1bb:8ad0:1fa7 with SMTP id
 eb42-20020a056870a8aa00b001bb8ad01fa7mr11237206oab.7.1690790278983; Mon, 31
 Jul 2023 00:57:58 -0700 (PDT)
Date:   Mon, 31 Jul 2023 00:57:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7fbdd0601c3c9c5@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING: refcount bug in xp_put_pool
From:   syzbot <syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com>
To:     aleksander.lobakin@intel.com, andrii@kernel.org, ast@kernel.org,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=101a8319a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=8ada0057e69293a05fd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146dbe31a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11656a7ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz

The issue was bisected to:

commit 9f78bf330a66cd400b3e00f370f597e9fa939207
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Thu Feb 16 08:30:47 2023 +0000

    xsk: support use vaddr as ring

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13541155a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d41155a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17541155a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com
Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 5078 at lib/refcount.c:28 refcount_warn_saturate+0x140/0x1f0 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 5078 Comm: kworker/0:3 Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Workqueue: events drain_vmap_area_work
RIP: 0010:refcount_warn_saturate+0x140/0x1f0 lib/refcount.c:28
Code: 0a 31 ff 89 de e8 f0 3e 65 fd 84 db 0f 85 6e ff ff ff e8 b3 43 65 fd 48 c7 c7 c0 33 c8 8a c6 05 64 ce 74 0a 01 e8 60 99 2b fd <0f> 0b e9 4f ff ff ff e8 94 43 65 fd 0f b6 1d 4a ce 74 0a 31 ff 89
RSP: 0018:ffffc90000007d88 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff88807190d940 RSI: ffffffff814d5b56 RDI: 0000000000000001
RBP: ffff888071110460 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888071110460
R13: ffff8880710d24e8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557361650 CR3: 00000000476b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 xp_put_pool+0x8a/0x1e0 net/xdp/xsk_buff_pool.c:286
 xsk_destruct+0x95/0x140 net/xdp/xsk.c:1601
 __sk_destruct+0x4d/0x770 net/core/sock.c:2163
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x7fb/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 common_interrupt+0xae/0xd0 arch/x86/kernel/irq.c:247
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
RIP: 0010:stack_trace_consume_entry+0xaf/0x160 kernel/stacktrace.c:93
Code: c0 03 38 d0 7c 08 84 d2 0f 85 90 00 00 00 8b 43 0c 85 c0 75 53 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 80 3c 02 00 <0f> 85 92 00 00 00 8d 45 01 89 43 10 48 8b 03 48 8d 2c e8 48 b8 00
RSP: 0018:ffffc90003d7f6d8 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffc90003d7f7b8 RCX: 0000000000000000
RDX: 1ffff920007afef7 RSI: ffffffff81cffbd8 RDI: ffffc90003d7f7c4
RBP: 0000000000000000 R08: ffffc90003d7f72c R09: ffffffff8f40e62e
R10: ffffc90003d7f6f8 R11: 000000000000e4d6 R12: ffffffff8174c470
R13: ffffc90003d7f7b8 R14: 0000000000000000 R15: ffff88807190d940
 arch_stack_walk+0x7f/0xf0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 save_stack+0x160/0x1f0 mm/page_owner.c:128
 __reset_page_owner+0x5a/0x190 mm/page_owner.c:149
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2478
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:427
 apply_to_pte_range mm/memory.c:2735 [inline]
 apply_to_pmd_range mm/memory.c:2779 [inline]
 apply_to_pud_range mm/memory.c:2815 [inline]
 apply_to_p4d_range mm/memory.c:2851 [inline]
 __apply_to_page_range+0x5ed/0xdb0 mm/memory.c:2885
 kasan_release_vmalloc+0xa8/0xc0 mm/kasan/shadow.c:544
 __purge_vmap_area_lazy+0x8b9/0x2160 mm/vmalloc.c:1770
 drain_vmap_area_work+0x54/0xd0 mm/vmalloc.c:1804
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2603
 worker_thread+0x687/0x1110 kernel/workqueue.c:2754
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	38 d0                	cmp    %dl,%al
   2:	7c 08                	jl     0xc
   4:	84 d2                	test   %dl,%dl
   6:	0f 85 90 00 00 00    	jne    0x9c
   c:	8b 43 0c             	mov    0xc(%rbx),%eax
   f:	85 c0                	test   %eax,%eax
  11:	75 53                	jne    0x66
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 da             	mov    %rbx,%rdx
  20:	48 c1 ea 03          	shr    $0x3,%rdx
  24:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
* 28:	0f 85 92 00 00 00    	jne    0xc0 <-- trapping instruction
  2e:	8d 45 01             	lea    0x1(%rbp),%eax
  31:	89 43 10             	mov    %eax,0x10(%rbx)
  34:	48 8b 03             	mov    (%rbx),%rax
  37:	48 8d 2c e8          	lea    (%rax,%rbp,8),%rbp
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
