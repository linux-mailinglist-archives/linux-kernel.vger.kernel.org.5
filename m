Return-Path: <linux-kernel+bounces-51285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181208488B6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894881F23683
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051DF9EB;
	Sat,  3 Feb 2024 20:37:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF4DDA6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992654; cv=none; b=Z2kabwAy6jvCPO49IZ6qKC3+VirUiNHqyhdp5OkD9scXd156hYeZcbEP1zN6XE00aiUQ1eA6JL+1WQV0wytIV5ZuMPQhPxZrO6BOyaGN6klMSR3hduLPTNPzgtZe/MJvuu2oL9JDY97uFQGH+72XOWrTG/6im7uf/9o1mBym2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992654; c=relaxed/simple;
	bh=wBBRLSoXKM/Q1L3RhtNInbA41YBJ/N2xAypsEMoXXC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aS+7+cLHeADHBaAcNuc3Xg8U3OBHpPnCfkcGT5po3t8WGbKzrsbrAbYOsWst5jluqFLiaealcrZlnv5Na1kOAgwovkVlofz76LlKsOn9cK7p1qBRW6WYv5NKMKxtK5TiqjpFwQa+tJix6nldG3kZCChYY2jyD6HlXcXplikrX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b685b342so12827655ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 12:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706992652; x=1707597452;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4/8pPw0qEVPE2XnJpht9ePBXzZQA321R8c7/YF2YtA=;
        b=csJP7VISIMU8QJ6EGrx4vuMxDk5d34x4Qp+Lmme2LlateRFi7EHTArVpwhRK3D+Ykn
         yOnambXKNFm47No3wCe+Kt054A+7BEEJp2R/n+fxEIuHd/E3TThf1ghM+/EyI8xFsfNB
         yFSmY4EEvIYHsjYEmHVydqrN7dSr0EBOPt71yngZWyj5G3+vZuO3BMIkBlgB7+4H/m3n
         jrq7omEDntWvK+Tqw9vtZd7AqOEjQMU15vYxD0CfuE4g54B3sHmGMmtY6K+d5JUvUzWl
         Qt3qw1f+SxmmEyrq98YrETpAEX0kdHIxg/fWUcaLcnN+sksWYZi9mrAJLHdgPIN12+fG
         1Erg==
X-Gm-Message-State: AOJu0YzvT+SgMx1xUf3yb8xaD88bldzX7zKk3Ezkd10z0TXAFFbJAJmR
	CYN9UpIA2hVzt4Fq6RKumPuZhi+0AhiNbhG5w1AsiBZXLq+Ngjszc4cIPsmKXs8w6XpSfvohjc2
	H2+hRizdBjpw6CeLycY637TdOSTbBRoJ6PA8ZhL2KIPWnbtJEhYtdzDc=
X-Google-Smtp-Source: AGHT+IEOO96TlqBUS4vftgXm1dBobSNB0Awmnwgkr5wjLuXwcS8cPTEWZbcnFgbo1QiNBY+VrlvYbuAPkG/iAMiAPrKh6zFE2sQK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:363:9d58:805b with SMTP id
 m13-20020a056e021c2d00b003639d58805bmr547328ilh.3.1706992652400; Sat, 03 Feb
 2024 12:37:32 -0800 (PST)
Date: Sat, 03 Feb 2024 12:37:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae47f90610803260@google.com>
Subject: [syzbot] [mm?] WARNING in zswap_folio_swapin
From: syzbot <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174537bbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=17a611d10af7d18a7092
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-861c0981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b2b204c7b4a0/vmlinux-861c0981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/170ec316e557/bzImage-861c0981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com

 kcov_ioctl+0x4f/0x720 kernel/kcov.c:704
 __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:971
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
page has been migrated, last migrate reason: compaction
------------[ cut here ]------------
WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 folio_lruvec include/linux/memcontrol.h:775 [inline]
WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 zswap_folio_swapin+0x47d/0x5a0 mm/zswap.c:381
Modules linked in:
CPU: 2 PID: 5104 Comm: syz-fuzzer Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:folio_lruvec include/linux/memcontrol.h:775 [inline]
RIP: 0010:zswap_folio_swapin+0x47d/0x5a0 mm/zswap.c:381
Code: e8 d8 9f ae ff 45 84 e4 0f 85 e7 fc ff ff e8 9a a4 ae ff 48 c7 c6 20 9a da 8a 48 89 df e8 2b 1a ee ff c6 05 d1 8f 4b 0d 01 90 <0f> 0b 90 e9 c3 fc ff ff e8 76 a4 ae ff 48 c7 c6 60 99 da 8a 48 89
RSP: 0018:ffffc9000397f8c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000a74300 RCX: ffffc9000397f720
RDX: ffff88801a064800 RSI: ffffffff81d98145 RDI: ffffffff8b2fdc00
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1e76002
R10: ffffffff8f3b0017 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000000069a1 R15: 0000000000000003
FS:  000000c000056490(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000030623000 CR3: 000000001c68c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 swap_cluster_readahead+0x4fb/0x710 mm/swap_state.c:685
 swapin_readahead+0x132/0xe60 mm/swap_state.c:886
 do_swap_page+0x4a6/0x30f0 mm/memory.c:3898
 handle_pte_fault mm/memory.c:5147 [inline]
 __handle_mm_fault+0x13a0/0x4900 mm/memory.c:5285
 handle_mm_fault+0x47a/0xa10 mm/memory.c:5450
 do_user_addr_fault+0x30b/0x1030 arch/x86/mm/fault.c:1364
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x5d/0xc0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x46d3b9
Code: fe 7f 44 1f 80 c5 f8 77 c3 80 3d 84 7c c7 01 01 75 0d c5 f9 ef c0 48 81 fb 00 00 00 02 73 13 48 89 d9 48 c1 e9 03 48 83 e3 07 <f3> 48 ab e9 65 fe ff ff c5 fe 7f 07 48 89 fe 48 83 c7 20 48 83 e7
RSP: 002b:000000c00108b700 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000400
RDX: 000000c00258f002 RSI: 00000000222172b0 RDI: 000000c00258fffa
RBP: 000000c00108b758 R08: 0000000000000000 R09: 000000000000a000
R10: 000000c002588000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 000000c000508ea0 R15: 000000c000056400
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

