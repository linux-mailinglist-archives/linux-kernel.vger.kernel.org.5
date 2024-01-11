Return-Path: <linux-kernel+bounces-23881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9943D82B327
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7B41C26A45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DF5025F;
	Thu, 11 Jan 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDaQmyGx"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC145487AC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f3da7ba2bfso56762247b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704991224; x=1705596024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVv8eBb/CwcvJCElZQunsaE8crnUx0tkNXTdCJiaHdI=;
        b=SDaQmyGxoUrjdoPswF6jPASAc2NhF1nx1qYRpx9JGLpmoJkDOPk942iR6kJDUKUKAY
         RfBXCJ02KHx4Tycn0nal9lKTKL9iYCoB2+w70gNxOCxvjB+d+eQvAES81vEiKy1RlZ44
         gZzjWw/BAcz9EMpHn1t1ZQP96r7KxpkBmP6YAlNTX/HmT4yfX5Ipz0xmlYQDm8cBEn8B
         uebj0iuRs2AUIX1r5tM0iF7ZLnxB1E3X8HbE8H/CqO54FxxgSRv+uWJjGkcdHHDcq1Y6
         9181BhgP8+gpba6loDaShgtLefgu7+puAjl4EOtX49OsI4d7QorsQJW70361Q9TGjEsS
         TDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991224; x=1705596024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVv8eBb/CwcvJCElZQunsaE8crnUx0tkNXTdCJiaHdI=;
        b=gghXCy4X74rnSMNiGRm4xZ6bLK4G7AjeYJTb9esSH0C6afScMHJy81L9ihq/099e9/
         1M9NBQFl10vpd9qcN20l4LHRRN9zjnNdovztJP6IXKOglmrrqvkX+unt1wb4oqeprWno
         DcIEu4siEDkdGaQegw77wfQmMPm3e3lsL+skaTu8Po8tRX6MKe2IBq2sn1+OJtwgf1jr
         +4nKdF/oMXPPUYu70smpxOFr/5dOUkxbMDEYrwh99/zM5RpwSFC3Lx83mZPabXgvhyTX
         zHnV/Z4l4Gt/kqW4Y2I8KBwNRvxgoovpg/3z9tMaon7vG7ihM/q366r7lEux0TonVnKp
         K9nA==
X-Gm-Message-State: AOJu0YzZTFgJzNKcSBBx1mSiPDJH4ksMoIeXtvxWP1ogh5IuYvgNZU7K
	9WyQ2LSuQR/JeAzPIHPnsW6J7NC9Pkm7xMaQHNpG8Xprnuwh
X-Google-Smtp-Source: AGHT+IEu4g55t2jqrRt3jfTSN2JwMwiRh1Lgge0tAotRb9M3udJ9v/AjXsD4LIq13qUSa9B8fcImN9fxsaioVsX7AYE=
X-Received: by 2002:a81:ae0f:0:b0:5e8:6e8f:d47a with SMTP id
 m15-20020a81ae0f000000b005e86e8fd47amr45722ywh.75.1704991223426; Thu, 11 Jan
 2024 08:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000011d709060eadffd3@google.com>
In-Reply-To: <00000000000011d709060eadffd3@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 08:40:11 -0800
Message-ID: <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>
Cc: aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
<syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e2425464bc87 Add linux-next specific files for 20240105
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14941cdee8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056b9349f3da=
8c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D705209281e36404=
998f6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125d0a09e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc7331e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2f738185e2cf/dis=
k-e2425464.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46/vmlinu=
x-e2425464.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a9945c8223f4/b=
zImage-e2425464.xz
>
> The issue was bisected to:
>
> commit adef440691bab824e39c1b17382322d195e1fab0
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Wed Dec 6 10:36:56 2023 +0000
>
>     userfaultfd: UFFDIO_MOVE uABI
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11cb6ea9e8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13cb6ea9e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb6ea9e8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>
>  do_one_initcall+0x128/0x680 init/main.c:1237
>  do_initcall_level init/main.c:1299 [inline]
>  do_initcalls init/main.c:1315 [inline]
>  do_basic_setup init/main.c:1334 [inline]
>  kernel_init_freeable+0x692/0xc30 init/main.c:1552
>  kernel_init+0x1c/0x2a0 init/main.c:1442
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:1035!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-2024010=
5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]

From a quick look, I think the new ioctl is being used against a
file-backed page and that's why PageAnonExclusive() throws this error.
I'll confirm if this is indeed the case and will add checks for that
case. Thanks!

> RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff e8 7=
9 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 62 c6=
 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  userfaultfd_move fs/userfaultfd.c:2047 [inline]
>  userfaultfd_ioctl+0x683/0x6420 fs/userfaultfd.c:2169
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> RIP: 0033:0x7f4bada9b3e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff2c1d6998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fff2c1d6b68 RCX: 00007f4bada9b3e9
> RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> RBP: 00007f4badb0e610 R08: 00007fff2c1d6b68 R09: 00007fff2c1d6b68
> R10: 00007fff2c1d6b68 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fff2c1d6b58 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
> RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff e8 7=
9 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 62 c6=
 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
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

