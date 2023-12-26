Return-Path: <linux-kernel+bounces-11546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2A81E7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67902B21AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06C4F20A;
	Tue, 26 Dec 2023 15:28:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB554EB35
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ba9fee55d4so522707439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 07:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703604499; x=1704209299;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pAn0BFZph+5Rj0b0QLg8WiGaWGsuSYeAKIPJ2kKAdI=;
        b=Vy+tKSP2t7GOm77LFG626RQNhHrwwE1Pl+OKNZycWoComZZ0sJONr6ILgnxT8Ab2TO
         x3xkZz/RFiYJm+hUtTn40YraBjAV6DqRHZZkuNDZERNOZDNE5wq1TbJgRDRk3XEAoL4W
         ioIBDHJsVmhEpiEZRROGm+YeCcW/3vjeCHTl/XiAjYfUuNneWmT1qxEUqhfjBgwrm4F/
         RX088BGjjbBYGFUkkPs8BJ9h/8aMBhVi4vk6HyDgsLFED3BoHZq083J1aKch7DKYNApA
         3FZomGlKxAgqYDrDAvPT3OZak6iHBhOdxEwjeQIWJx5JRagIp0FVG3iOEWNO4tzDy0fX
         19Lg==
X-Gm-Message-State: AOJu0YxncOH+G0oE5eiSE8LxeiUbr3t5MG3WeqmYFy2SO2MD35OAzU8m
	eLISuiZfvO8dkIUDfLOyyhuYFXdOy2NwYgwZodFW2XAuTOK/
X-Google-Smtp-Source: AGHT+IH4q7OAZUXBqXguzRyaZLmuPPxjcRofsCk0Zyz8LyN1S4PlW6j5tcIVnhsJBK9kYVIoclt3PWhtVI9E0xug5jbL5wJx//hn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:35f:f683:f769 with SMTP id
 j14-20020a056e02154e00b0035ff683f769mr682360ilu.5.1703604499709; Tue, 26 Dec
 2023 07:28:19 -0800 (PST)
Date: Tue, 26 Dec 2023 07:28:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b05cd060d6b5511@google.com>
Subject: [syzbot] [crypto?] general protection fault in scatterwalk_copychunks (5)
From: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39676dfe5233 Add linux-next specific files for 20231222
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=172080a1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=3eff5e51bf1db122a16e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f6e26e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c399e9e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/360542c2ca67/disk-39676dfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/900dfb21ca8a/vmlinux-39676dfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c94a2a3ea0e0/bzImage-39676dfe.xz

The issue was bisected to:

commit 7bc134496bbbaacb0d4423b819da4eca850a839d
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Mon Dec 18 11:50:31 2023 +0000

    mm/zswap: change dstmem size to one page

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f60c36e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f60c36e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f60c36e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Fixes: 7bc134496bbb ("mm/zswap: change dstmem size to one page")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5065 Comm: syz-executor140 Not tainted 6.7.0-rc6-next-20231222-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scatterwalk_map_and_copy+0x151/0x1d0 crypto/scatterwalk.c:67
 scomp_acomp_comp_decomp+0x3a3/0x780 crypto/scompress.c:149
 crypto_acomp_compress include/crypto/acompress.h:302 [inline]
 zswap_store+0x98b/0x2430 mm/zswap.c:1666
 swap_writepage+0x8e/0x220 mm/page_io.c:198
 pageout+0x399/0x9e0 mm/vmscan.c:656
 shrink_folio_list+0x2f47/0x3ea0 mm/vmscan.c:1319
 reclaim_folio_list+0xe4/0x3a0 mm/vmscan.c:2104
 reclaim_pages+0x483/0x6a0 mm/vmscan.c:2140
 madvise_cold_or_pageout_pte_range+0x129e/0x1f70 mm/madvise.c:526
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
 __walk_page_range+0x630/0x770 mm/pagewalk.c:395
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 madvise_pageout_page_range mm/madvise.c:585 [inline]
 madvise_pageout+0x32c/0x820 mm/madvise.c:612
 madvise_vma_behavior+0x1cc/0x1b50 mm/madvise.c:1031
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
 do_madvise+0x333/0x660 mm/madvise.c:1440
 __do_sys_madvise mm/madvise.c:1453 [inline]
 __se_sys_madvise mm/madvise.c:1451 [inline]
 __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1451
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f15a5e14b69
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde7b4a5c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f15a5e14b69
RDX: 0000000000000015 RSI: 0000000000c00304 RDI: 0000000020000000
RBP: 0000000000000000 R08: 00005555565c6610 R09: 00005555565c6610
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffde7b4a808 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f0 48 c1 e8 03       	lock shr $0x3,%rax
   5:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   9:	0f 85 81 01 00 00    	jne    0x190
   f:	49 8d 44 24 08       	lea    0x8(%r12),%rax
  14:	4d 89 26             	mov    %r12,(%r14)
  17:	48 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdi
  1e:	fc ff df
  21:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 38          	movzbl (%rax,%rdi,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 47 01 00 00    	jle    0x181
  3a:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3f:	41                   	rex.B


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

