Return-Path: <linux-kernel+bounces-100922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C709879FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1AE1F22327
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27A482F4;
	Tue, 12 Mar 2024 23:34:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047746B9F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286460; cv=none; b=iNl8eqc+tTtwYLWq0iP2zS3S5mQXkY2Co5UFVIGhUMq9Q3G+8UZB20v/xpX+D1SymRVxa/iJOmBssBLt/tnASybcWsKfCuESyTI5w/m9rUD2rb0a1hug6LK+eMzolT5qU2oxV2+0zlWWBrz3m4zcHZWQpTumihYRVSuCyrm6qZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286460; c=relaxed/simple;
	bh=V7syQIGbhXqZa7yG7MS9Fg5zwZhxVP5/3Hh9+AgrMrw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JVZriRf1L8dh8q8ROsm8ra6QNu41LTVxBzgJYaObHQO6b2q0GPuAfztGjdDyP506pvYGxDug2pNWr1eJ409eDxuP68oECdTr+sFmlSDrYmoHjHynrfsu3Ws041YX6XRQYIQFoZlY3XA7N928BQLnfZnKHl8Rp/QiA/i/BCZtoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so466238939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710286457; x=1710891257;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEWH2f4pPeXnjbOWATLfxyixb6PBlvjcil5UWl1vltk=;
        b=G+VD4cYhmAzsxXnlbiu6CZZHnOlSe7MjqUH4pKmdAh/C3pq5IpzHFx3VhGHcVxJZeO
         Ht/l4lajZd0SViMeFvoUgynzD+gLI7Y/ogcqGShLjQu065bXTukJT+zNwEQ9vYFokd4f
         dQvKTswCfez6BCTsquoB48OAgKP/19FJH9pu8oKRl7O8UB7M/VOvsKrGLf6D+MRIzev+
         Q2x5ldYGrB1JydlMD0QKBF1JN0XGDdYQgla2T90N20GjD3jgzW9iLLiqenX2dh+ZI1Zh
         O4SR4jL8nLn9EbfXR8VEZhLLqwY9mmDeIBYNGseEakAO12Ap0RE/zrO7fX2QNJJXxwXU
         Zaig==
X-Forwarded-Encrypted: i=1; AJvYcCUWL/H0qlhIKuKkb+GSds24ODgmShHNG4IvU4w7AhysBn2O0EwK+xhzwhNbqivkVSdv7SBbnCHXrDLJgdomQ9uBKJExVRMwmFribNCM
X-Gm-Message-State: AOJu0YyW5J6tAoCcc6eeyJVaUT0Nz8YojR7URcR9PgNLk7RkuI0lGoI2
	64kU/pReTtBGwyV2ULATvO1Qw9W7J4mZZhH13QZI+Zb/Nn7CtLsVKXOuW+fGZp5NojtKejb7VLK
	9vjQyhDux57DEN3EtzdnWk/V8q/EULAMaF2LY037w+rB/VmJSukpX/04=
X-Google-Smtp-Source: AGHT+IEqGWfgtwFpTAfKiDt4Erh4fadFZ7nx728ouYTYhgElBrXaqg1LSv7ie0il63xWcclz5E5mIzkOOC89nVZPpFKMAvNw3s+u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1696:b0:7c8:afc3:3f70 with SMTP id
 s22-20020a056602169600b007c8afc33f70mr326799iow.4.1710286457683; Tue, 12 Mar
 2024 16:34:17 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:34:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6526f06137f18cc@google.com>
Subject: [syzbot] [kvm?] WARNING in clear_dirty_gfn_range
From: syzbot <syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    855684c7d938 Merge tag 'x86_tdx_for_6.9' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11776f71180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b384ef2b2d70c33
dashboard link: https://syzkaller.appspot.com/bug?extid=900d58a45dcaab9e4821
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1536da66180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c5078e180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-855684c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a13a9aaebd09/vmlinux-855684c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/acac43529544/bzImage-855684c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5165 at arch/x86/kvm/mmu/tdp_mmu.c:1526 clear_dirty_gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:1526
Modules linked in:
CPU: 1 PID: 5165 Comm: syz-executor417 Not tainted 6.8.0-syzkaller-01185-g855684c7d938 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:clear_dirty_gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:1526
Code: 00 31 ff 48 b8 00 00 00 00 00 00 30 00 48 21 d8 49 89 c5 48 89 c6 e8 e9 9c 6c 00 4d 85 ed 0f 84 b8 fe ff ff e8 cb a1 6c 00 90 <0f> 0b 90 e9 aa fe ff ff e8 bd a1 6c 00 e8 a8 39 53 00 31 ff 89 c6
RSP: 0018:ffffc900039a7570 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 06200000310acb77 RCX: ffffffff81204937
RDX: ffff888022a8c880 RSI: ffffffff81204945 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0020000000000000 R11: 0000000000000002 R12: ffffc900039a75c8
R13: 0020000000000000 R14: 0000000000000200 R15: 0000000000000001
FS:  000055556ed44380(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000027762000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_tdp_mmu_clear_dirty_slot+0x24f/0x2e0 arch/x86/kvm/mmu/tdp_mmu.c:1557
 kvm_mmu_slot_leaf_clear_dirty+0x38b/0x490 arch/x86/kvm/mmu/mmu.c:6783
 kvm_mmu_slot_apply_flags arch/x86/kvm/x86.c:12962 [inline]
 kvm_arch_commit_memory_region+0x299/0x490 arch/x86/kvm/x86.c:13031
 kvm_commit_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1751 [inline]
 kvm_set_memslot+0x4d3/0x13e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1994
 __kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2129 [inline]
 __kvm_set_memory_region+0xdbc/0x1520 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2020
 kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2150 [inline]
 kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2162 [inline]
 kvm_vm_ioctl+0x151c/0x3e20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5152
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4e1b1860f9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd21061f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffdd21063c8 RCX: 00007f4e1b1860f9
RDX: 0000000020000180 RSI: 000000004020ae46 RDI: 0000000000000004
RBP: 00007f4e1b1f9610 R08: 00007ffdd21063c8 R09: 00007ffdd21063c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdd21063b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

