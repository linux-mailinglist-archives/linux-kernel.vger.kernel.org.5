Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970B7DB2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjJ3FwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJ3FwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:52:23 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F0C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 22:52:21 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6cd019c925cso5771221a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 22:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698645140; x=1699249940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBfdO/RhCB/Iy6DY0lnEId3NOPicW2yAdEaziERx33Y=;
        b=sV8+YVKwcsI8/CciBr+jNHma1DpM02jOvEcMQ9RVMP4nzaO9pKY8+Zk4rV8K1SwNkZ
         n5F0x1/BEz/WW//ehvTBki4d4hwh4cZq90FxsdJ6AuYUZGMkCo6vbCpfEPX9hYskMJkN
         bXvmpVwfQr5uDQaoagZY/eKyV8+eBrIeR3OJy/cfpQtNu5kjAWefBSeIawdNpmlpggBG
         KUVzlXUtaU5X2Igwf7MT1XRTaCeLGdpr2Gn6Gz4OCZOOef+eXvCLbIqw+F6p7whC/JOj
         mvYQIG3ic/mF9/+WLKKTh2QpmosVjWJKPvtb1mUBzQMp295nvCUXSJur0NRmZ98t7A4m
         emJA==
X-Gm-Message-State: AOJu0YyBdgrSYZ3dOiho8KdL98Ld2sZ3tU0815N0ywC4eDlca+/KTn8r
        hjzO9kVKeuareYade1gXtrTTUstFjFcAcEMLSehdNdxrDA8u
X-Google-Smtp-Source: AGHT+IEsmNsVfeWACmYMw6i/EQwgAm3YDN0n9U8hhyZrzM1BEWh133D/GO/CKqRs4ORr/KuncNQ4P4XKPC9rh2Thh0oVvAUYkdBl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:50d:b0:1e9:a417:e8de with SMTP id
 j13-20020a056870050d00b001e9a417e8demr4652726oao.4.1698645140599; Sun, 29 Oct
 2023 22:52:20 -0700 (PDT)
Date:   Sun, 29 Oct 2023 22:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000347a250608e8a4d1@google.com>
Subject: [syzbot] [net?] general protection fault in tls_merge_open_record
From:   syzbot <syzbot+40d43509a099ea756317@syzkaller.appspotmail.com>
To:     borisp@nvidia.com, davem@davemloft.net, edumazet@google.com,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    66f1e1ea3548 Add linux-next specific files for 20231027
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b621fd680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2911330219149de4
dashboard link: https://syzkaller.appspot.com/bug?extid=40d43509a099ea756317
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1552332d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0bf12f215f2/disk-66f1e1ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5e854ca6e2c3/vmlinux-66f1e1ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25e8c098714e/bzImage-66f1e1ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40d43509a099ea756317@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 12569 Comm: syz-executor.0 Not tainted 6.6.0-rc7-next-20231027-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:put_page include/linux/mm.h:1544 [inline]
RIP: 0010:tls_merge_open_record+0x4b9/0x7f0 net/tls/tls_sw.c:669
Code: 85 e4 0f 85 b6 02 00 00 e8 54 62 67 f8 4d 89 f4 48 b8 00 00 00 00 00 fc ff df 49 83 e4 fc 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 02 00 00 4d 8b 6c 24 08 31 ff 4d 89 ef 41 83
RSP: 0018:ffffc9000ae9f498 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888068caa000 RCX: ffffffff89219a8e
RDX: 0000000000000001 RSI: ffffffff89219a9c RDI: 0000000000000008
RBP: ffff888068cab000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff81dfefa3 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fa3e0ea76c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020173000 CR3: 00000000279dd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tls_push_record+0x290f/0x3070 net/tls/tls_sw.c:726
 bpf_exec_tx_verdict+0xdee/0x1230 net/tls/tls_sw.c:819
 tls_sw_splice_eof+0x194/0x470 net/tls/tls_sw.c:1242
 sock_splice_eof+0x86/0xb0 net/socket.c:1116
 direct_file_splice_eof+0x86/0xb0 fs/splice.c:1151
 do_splice_eof fs/splice.c:944 [inline]
 splice_direct_to_actor+0x710/0xa30 fs/splice.c:1117
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb3a/0x1310 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fa3e007cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3e0ea70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa3e019c050 RCX: 00007fa3e007cae9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007fa3e00c847a R08: 0000000000000000 R09: 0000000000000000
R10: 00000000f2090293 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa3e019c050 R15: 00007ffcc0dbba98
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:put_page include/linux/mm.h:1544 [inline]
RIP: 0010:tls_merge_open_record+0x4b9/0x7f0 net/tls/tls_sw.c:669
Code: 85 e4 0f 85 b6 02 00 00 e8 54 62 67 f8 4d 89 f4 48 b8 00 00 00 00 00 fc ff df 49 83 e4 fc 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 02 00 00 4d 8b 6c 24 08 31 ff 4d 89 ef 41 83
RSP: 0018:ffffc9000ae9f498 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888068caa000 RCX: ffffffff89219a8e
RDX: 0000000000000001 RSI: ffffffff89219a9c RDI: 0000000000000008
RBP: ffff888068cab000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff81dfefa3 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fa3e0ea76c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020347000 CR3: 00000000279dd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 e4                	test   %esp,%esp
   2:	0f 85 b6 02 00 00    	jne    0x2be
   8:	e8 54 62 67 f8       	call   0xf8676261
   d:	4d 89 f4             	mov    %r14,%r12
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	49 83 e4 fc          	and    $0xfffffffffffffffc,%r12
  1e:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 ed 02 00 00    	jne    0x321
  34:	4d 8b 6c 24 08       	mov    0x8(%r12),%r13
  39:	31 ff                	xor    %edi,%edi
  3b:	4d 89 ef             	mov    %r13,%r15
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
