Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D077B827
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjHNMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjHNMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:02:50 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB21737
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:02:33 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b29b33f0cso3336061a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014553; x=1692619353;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0fXzWuVaGScEGMdNSruH+faBEzXvuF7ifcN0ipXaiM=;
        b=H10CNoJF7IuEpnJh2qB/WS9jm1oVpS2RMjvqNbnY2kOeZ3x6l40i+7kAcRWttbbkCR
         MJkJ2hpg2ILQijFBROMQELXsn8eod7HOXY9gb9fWWQ+BUGpL6ugierIp0Y68opUjf2Rw
         SagMVezk1xtZ9bzCqF5m+99LNKdBKfXcclzTuYKbldPgRv08Bj0/vhfE3LUiDFqhPlwY
         sTqFME76oAlLVuzVwHyTBxzdiEMWk5Mg4bONO29jZxcBfmqBa0A9dANMJOELmXHD81on
         nhkdeLWG7v8V1G8qKnTX3LA1kFlSi2Df5o/06BMeLHQJXfBd00CLge6njSFhfYfdCLvW
         BYlw==
X-Gm-Message-State: AOJu0YzRwIQ98LMx5zSdHUkQorprbl2gwytbPsEKYMHoMLP8x6uywZs0
        654JoUfCmyTza2G5KvL3mh6jQKJ8PLbjo6GVEznh2ACaOFz/
X-Google-Smtp-Source: AGHT+IGMFYU/aG7xiryT1YHLnkYqQfA1e1jLpUElias0Zc6excNQmAeA6bbDuFDOPMUfp3b8IqzTwNWjFD6VIP4Ur6Qn3O4NW+eH
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ea13:b0:263:49d3:8024 with SMTP id
 w19-20020a17090aea1300b0026349d38024mr1770636pjy.1.1692014552860; Mon, 14 Aug
 2023 05:02:32 -0700 (PDT)
Date:   Mon, 14 Aug 2023 05:02:32 -0700
In-Reply-To: <20230814111358.1427-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060ce460602e0d647@google.com>
Subject: Re: [syzbot] [dri?] [reiserfs?] WARNING: bad unlock balance in vkms_vblank_simulate
From:   syzbot <syzbot+5671b8bcd5178fe56c23@syzkaller.appspotmail.com>
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
general protection fault in cpuacct_charge

REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
general protection fault, probably for non-canonical address 0xdffffc0020008027: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000100040138-0x000000010004013f]
CPU: 0 PID: 5465 Comm: syz-executor.0 Not tainted 6.5.0-rc5-next-20230808-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:cpuacct_charge+0x194/0x3e0 kernel/sched/cpuacct.c:342
Code: 85 ed 0f 84 89 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 4c 01 e2 48 8d bd 18 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 99 01 00 00 48 8b 9d 18 01 00 00 49 83 fd 07
RSP: 0018:ffffc90004d86ba0 EFLAGS: 00010006
RAX: 0000000020008027 RBX: ffff8880b980ff01 RCX: 0000000000000001
RDX: fffffbfff1876d40 RSI: ffffffff8a6c9c60 RDI: 0000000100040138
RBP: 0000000100040020 R08: 0000000000000000 R09: fffffbfff1d5a29a
R10: ffffffff8ead14d7 R11: 0000000000000800 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff8c3b6a00 R15: 000000000046b680
FS:  00007fd3413446c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000ff01 CR3: 000000007db2c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cgroup_account_cputime include/linux/cgroup.h:718 [inline]
 update_curr+0x550/0xaf0 kernel/sched/fair.c:1125
 put_prev_entity+0xa2/0x170 kernel/sched/fair.c:5223
 pick_next_task_fair+0x783/0x1200 kernel/sched/fair.c:8123
 __pick_next_task kernel/sched/core.c:6014 [inline]
 pick_next_task kernel/sched/core.c:6089 [inline]
 __schedule+0x493/0x59f0 kernel/sched/core.c:6675
 preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:7023
 irqentry_exit+0x35/0x80 kernel/entry/common.c:433
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:650
RIP: 0010:memmove+0x28/0x1b0 arch/x86/lib/memmove_64.S:44
Code: c3 90 f3 0f 1e fa 48 89 f8 48 39 fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 83 fa 20 0f 82 01 01 00 00 48 89 d1 <f3> a4 c3 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48
RSP: 0018:ffffc90004d86f20 EFLAGS: 00010286
RAX: ffff8880656ccfb4 RBX: 0000000000000002 RCX: fffffffffd51ea6e
RDX: ffffffffffffffe0 RSI: ffff8880681ae516 RDI: ffff8880681ae526
RBP: 0000000000000020 R08: ffff8880656ccf84 R09: 0000766972705f73
R10: 667265736965722e R11: 0000766972705f73 R12: 0000000000000001
R13: 0000000000000000 R14: ffff8880656ccfa4 R15: 0000000000000010
 leaf_paste_entries+0x43c/0x920 fs/reiserfs/lbalance.c:1377
 balance_leaf_finish_node_paste_dirent fs/reiserfs/do_balan.c:1295 [inline]
 balance_leaf_finish_node_paste fs/reiserfs/do_balan.c:1321 [inline]
 balance_leaf_finish_node fs/reiserfs/do_balan.c:1364 [inline]
 balance_leaf+0x9476/0xcd90 fs/reiserfs/do_balan.c:1452
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x62a/0x7c0 fs/reiserfs/stree.c:2157
 reiserfs_add_entry+0x936/0xd20 fs/reiserfs/namei.c:565
 reiserfs_mkdir+0x68a/0x9a0 fs/reiserfs/namei.c:860
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:891 [inline]
 reiserfs_xattr_init+0x57f/0xbb0 fs/reiserfs/xattr.c:1007
 reiserfs_fill_super+0x2139/0x3150 fs/reiserfs/super.c:2175
 mount_bdev+0x1f3/0x350 fs/super.c:1424
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1547
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd34067e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd341343ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fd341343f80 RCX: 00007fd34067e1ea
RDX: 0000000020001100 RSI: 0000000020000040 RDI: 00007fd341343f40
RBP: 0000000020001100 R08: 00007fd341343f80 R09: 0000000000000080
R10: 0000000000000080 R11: 0000000000000246 R12: 0000000020000040
R13: 00007fd341343f40 R14: 00000000000010f6 R15: 00000000200000c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:cpuacct_charge+0x194/0x3e0 kernel/sched/cpuacct.c:342
Code: 85 ed 0f 84 89 00 00 00 49 bc 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 4c 01 e2 48 8d bd 18 01 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 99 01 00 00 48 8b 9d 18 01 00 00 49 83 fd 07
RSP: 0018:ffffc90004d86ba0 EFLAGS: 00010006

RAX: 0000000020008027 RBX: ffff8880b980ff01 RCX: 0000000000000001
RDX: fffffbfff1876d40 RSI: ffffffff8a6c9c60 RDI: 0000000100040138
RBP: 0000000100040020 R08: 0000000000000000 R09: fffffbfff1d5a29a
R10: ffffffff8ead14d7 R11: 0000000000000800 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff8c3b6a00 R15: 000000000046b680
FS:  00007fd3413446c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000ff01 CR3: 000000007db2c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 ed                	test   %ebp,%ebp
   2:	0f 84 89 00 00 00    	je     0x91
   8:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
   f:	fc ff df
  12:	4c 89 f2             	mov    %r14,%rdx
  15:	48 c1 ea 03          	shr    $0x3,%rdx
  19:	4c 01 e2             	add    %r12,%rdx
  1c:	48 8d bd 18 01 00 00 	lea    0x118(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 99 01 00 00    	jne    0x1ce
  35:	48 8b 9d 18 01 00 00 	mov    0x118(%rbp),%rbx
  3c:	49 83 fd 07          	cmp    $0x7,%r13


Tested on:

commit:         71cd4fc4 Add linux-next specific files for 20230808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e1ad53a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e36b5ba725f7349d
dashboard link: https://syzkaller.appspot.com/bug?extid=5671b8bcd5178fe56c23
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1525213da80000

