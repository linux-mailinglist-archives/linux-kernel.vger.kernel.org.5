Return-Path: <linux-kernel+bounces-133595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF389A614
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045711C2143F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF08175548;
	Fri,  5 Apr 2024 21:31:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B211C36
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352688; cv=none; b=EKq+7XsDR62NMqNtRMxpLE2heBFSK3cKKf9OP7dGEebVWgrF+8mj/uC/1ZryoPmRX3GYgGrCzhUCpbri8bt8qroYlBVq68F8syQRykdBh3fY6VVZDqJEAMesGNEkDFbFZzUflC5DXNGZ1gSaVwOfadUWluOCVGDA2yHIdoUd1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352688; c=relaxed/simple;
	bh=FRLtxSONMOouDsn4wyAvikya6KQgc1UrBTJ1ne8dHq4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n/1kS09BzC8rIuDcR8Ddq5n8F9fF7Dmao5kBPKCxm2zVH9H26OAz8aSjrEZ728F3mLst/Pcj6cSvY9lpBpxfTSt3FQ05eVJcfCTJ5SXGrLRAlQKeCBwu7d05BJL+ugRpXEcPVTyJ1XllM4u9ApbM4vfPZvJL62gA21z2aRIMpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so191026739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352686; x=1712957486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrEpjgdUb2GCRVHdwon4b7KaRnfRkMs2GbvFH+7Fj9I=;
        b=njxUsTaxE2vu1i0LyktoS+vfYo6oA02hHsvEM+y6TYbauZYq/zpFF4sVzfUscG2YIU
         P647sphavNUDod1RbX5uQEeJ6EjIfZwyMgxRQBoGTP74pCme8w1X2+tPw+JQMWOAR9Ea
         fx5Hoeoq+3NS8qRAXPY6RsUYlShUWEKYJbpJueldsLVFoAXujGXl7UsU+kzndLUzI4FM
         tGc1wYX60cd3OfxInOHKag0jyBlT/Vv20JsVTBBi2Nlmt5K4TPmmGmsib/3+2f8RhLXX
         CLN+p9QmP4pEY3WCRryvAsXvm9Q675SlbRFQW/vm/Kc6jN548sHF/704EAQmgc+FTivc
         NvmA==
X-Forwarded-Encrypted: i=1; AJvYcCX+tAoqEa08B670gK7tR0GrAwr8M9DuIr0X5ONYB9G6dq/OCOHJyFJLP5AgtNvNHMQ9uC7HOf5Z4/O8dsAZ3Vifuk6/k0omyNp5e3hU
X-Gm-Message-State: AOJu0YwGwzx5TchXGXtjdRs89Sb7eHGP7qGvt6qGfijSsicdDTBVLrId
	pnM8m7Ra3+e2y5A3+MVnKAWsPOuusQIh2mMdL48sKOZMeblPQdP6sM9RI04ORWBzZSA0tITqjtT
	XlvMtuKiFFeUXb5gkhHa8tEkKC1bP5VSgIKcV8pym1pk22+8rDGFTwk0=
X-Google-Smtp-Source: AGHT+IHiyeAJwARR0I9m1Os0dLgK2+Z6jsCH31VDkQ547QvENHkmaLRVIoJlbQkS0tTJn5kqAjTPeCfmbFwtwPmpkRefDx+Lr9Wb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:da49:0:b0:7d5:caeb:7e29 with SMTP id
 o9-20020a5eda49000000b007d5caeb7e29mr9330iop.1.1712352685849; Fri, 05 Apr
 2024 14:31:25 -0700 (PDT)
Date: Fri, 05 Apr 2024 14:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000920d5e0615602dd1@google.com>
Subject: [syzbot] [mm?] WARNING in hugetlb_change_protection (2)
From: syzbot <syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d3bd3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=b07c8ac8eee3d4d8440f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ab0de180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d6139180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5067 at mm/hugetlb.c:6947 hugetlb_change_protection+0x1195/0x1e20 mm/hugetlb.c:6947
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor335 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:hugetlb_change_protection+0x1195/0x1e20 mm/hugetlb.c:6947
Code: e6 09 48 b8 00 fe ff ff ff ff ff 07 49 21 c6 49 09 de 48 b8 00 00 00 00 00 00 00 c0 49 09 c6 48 ff 44 24 78 e9 97 00 00 00 90 <0f> 0b 90 48 83 bc 24 90 00 00 00 00 4c 8b 6c 24 28 4c 8b 74 24 08
RSP: 0018:ffffc9000397f580 EFLAGS: 00010212
RAX: 0000000000000000 RBX: f7ffffffffffffff RCX: ffff888078080000
RDX: ffff888078080000 RSI: fffffffffffffa00 RDI: f7ffffffffffffff
RBP: ffffc9000397f830 R08: ffffffff81f379ee R09: 1ffffd40000dfa8e
R10: dffffc0000000000 R11: fffff940000dfa8f R12: dffffc0000000000
R13: fffffffffffffa00 R14: 000000000000001e R15: ffff88801bf51810
FS:  000055556d838380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000002c45c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 change_protection+0x361/0x35f0 mm/mprotect.c:537
 mprotect_fixup+0x883/0xb80 mm/mprotect.c:653
 do_mprotect_pkey+0x903/0xe20 mm/mprotect.c:809
 __do_sys_mprotect mm/mprotect.c:830 [inline]
 __se_sys_mprotect mm/mprotect.c:827 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:827
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fedc2b27369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff43f189c8 EFLAGS: 00000246 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007fff43f18b98 RCX: 00007fedc2b27369
RDX: 0000000000000006 RSI: 0000000000800000 RDI: 0000000020000000
RBP: 00007fedc2b9a610 R08: 00007fff43f18b98 R09: 00007fff43f18b98
R10: 00007fff43f18b98 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff43f18b88 R14: 0000000000000001 R15: 0000000000000001
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

