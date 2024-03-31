Return-Path: <linux-kernel+bounces-126315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4189351E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4B228CC34
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2414A4D2;
	Sun, 31 Mar 2024 16:51:50 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091B147C96
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903910; cv=none; b=ZAhZYIBkSU3V0sYE2C+UZLNViqJ+jfAaSMediRs7Qb09FBobkXt0vDabOUtE1bk1861R2+R/2EN+V+tVEO1Zkx2Qg88GuajHty85EdTJ8utXzsSkopuBUZU8vtuhAMovJpzVjnvxnZEGKdEE35bMJnXd5csepHfG70WPhFedb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903910; c=relaxed/simple;
	bh=FJwaCrcsbx46KYXlej3LDo3OIU6XmBedbME/xLqnmIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bK/WdlWTACAeS35bTXecjfDlFY9PIBM2zzp2356lXG95KCYcaFH9VIhRXnogg8Q+0AW8KsdrZHFPY1/bbejR1bOddr51xmborTVI0PsZF7dN+G00zTOPTwTpKh2NL5RfAcrqgwTLmrB+WdKaBA14STmdcL+iUqFYzyVMtaWq5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so380894039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 09:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711903908; x=1712508708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWi+xxebPwCtzvfcEwh3iq1Wozho9WuQdoVRFI9vCQI=;
        b=E+ZTTDQZV9PO0gan45OnMdliBy6W7N06o5KLRaRVzmgEZ2w9Bs/+Aj9DZ5g/WWi1bN
         DxdxiQPwaC5hvkV93bGNcSLE9QSagRI5eEON63akTUSkTmHGwaeJz5fzkzhjXOSkIfE9
         I/il8XIQkkGBNxK5VwHPrTlvXFCaV88kSWSKzKJZ72imd8/uRyYIkLhspNzSubJgyubk
         +TMcAa2yPiDm9WSsJy8DeQlVrPAT5aZ9wgte4tTo33aVc5h+MCOmnKQ5YyTwuqD29WB4
         Uu/qpxKBMUNVLcfUKocbqIeXSaZKlkH/Sf/QWRvr+b4y4NdDddKE1ZQDbbBLKI0j6Hwq
         sBIw==
X-Gm-Message-State: AOJu0YwiTlqBTr0cFp6WHiKzToFsBccuBJf8NP0xkTNtAaUWSsxFZRsB
	Z/Mp1RzUyQ81Ud3uhcesZ+6KVgfdc4Ez4tef401gbTssxIZpErv3KG4V0DDqQjQrXy3jfTZ6bxl
	NZhBgs5yGdvGAEl3CTI8UUztwYoYBN83Ow4XlHgT3Af1uWFhg8+X3byNqPA==
X-Google-Smtp-Source: AGHT+IHbvf8nFhsl2yEW9IPactlIxbLPienbr6eSp7vqpwKxRRd1/Qx1JDy4J1Sjv3sPUmkHbC4PyWbo8kQypOQ3t4vuFY76udNv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1606:b0:7c8:d517:1008 with SMTP id
 x6-20020a056602160600b007c8d5171008mr173709iow.0.1711903907874; Sun, 31 Mar
 2024 09:51:47 -0700 (PDT)
Date: Sun, 31 Mar 2024 09:51:47 -0700
In-Reply-To: <0000000000009b38080614c49bdb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000519f900614f7b0f8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kvm?] WARNING in mmu_free_root_page
From: syzbot <syzbot+dc308fcfcd53f987de73@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kvm?] WARNING in mmu_free_root_page
Author: phind.uet@gmail.com

On 3/29/2024 11:55 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=127c0546180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=dc308fcfcd53f987de73
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110481f1180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177049a5180000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-928a87ef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7979568a5a16/vmlinux-928a87ef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1bc6e1d480e3/bzImage-928a87ef.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dc308fcfcd53f987de73@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5187 at arch/x86/kvm/mmu/mmu.c:3579 mmu_free_root_page+0x36c/0x3f0 arch/x86/kvm/mmu/mmu.c:3579
> Modules linked in:
> CPU: 0 PID: 5187 Comm: syz-executor400 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:mmu_free_root_page+0x36c/0x3f0 arch/x86/kvm/mmu/mmu.c:3579
> Code: 00 49 8d 7d 18 be 01 00 00 00 e8 8f 32 c0 09 31 ff 41 89 c6 89 c6 e8 13 e7 6f 00 45 85 f6 0f 85 5d fe ff ff e8 25 ec 6f 00 90 <0f> 0b 90 e9 4f fe ff ff e8 17 ec 6f 00 90 0f 0b 90 e9 79 fe ff ff
> RSP: 0018:ffffc90002fb7700 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88801e0186c8 RCX: ffffffff811d855d
> RDX: ffff888022f9a440 RSI: ffffffff811d856b RDI: 0000000000000005
> RBP: ffff888024c50370 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff938d6090 R12: 1ffff920005f6ee1
> R13: ffffc90000fae000 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007fe2bd3e76c0(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055ccab488ee8 CR3: 000000002d4ee000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   kvm_mmu_free_roots+0x621/0x710 arch/x86/kvm/mmu/mmu.c:3631
>   kvm_mmu_unload+0x42/0x150 arch/x86/kvm/mmu/mmu.c:5638
>   kvm_mmu_reset_context arch/x86/kvm/mmu/mmu.c:5596 [inline]
>   kvm_mmu_after_set_cpuid+0x14d/0x300 arch/x86/kvm/mmu/mmu.c:5585
>   kvm_vcpu_after_set_cpuid arch/x86/kvm/cpuid.c:386 [inline]
>   kvm_set_cpuid+0x1ff1/0x3570 arch/x86/kvm/cpuid.c:460
>   kvm_vcpu_ioctl_set_cpuid2+0xe7/0x160 arch/x86/kvm/cpuid.c:527
>   kvm_arch_vcpu_ioctl+0x26b7/0x4310 arch/x86/kvm/x86.c:5946
>   kvm_vcpu_ioctl+0xa2c/0x1090 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4620
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:904 [inline]
>   __se_sys_ioctl fs/ioctl.c:890 [inline]
>   __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fe2bd42e06b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:00007fe2bd3e5710 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fe2bd3e5de0 RCX: 00007fe2bd42e06b
> RDX: 00007fe2bd3e5de0 RSI: 000000004008ae90 RDI: 0000000000000006
> RBP: 0000000000000000 R08: 0000000000000007 R09: 00000000000000eb
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000080
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000006
>   </TASK>
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
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
Shadow TDP

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

