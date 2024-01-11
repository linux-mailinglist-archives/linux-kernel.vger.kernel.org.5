Return-Path: <linux-kernel+bounces-23986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49882B4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F91C242B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421554273;
	Thu, 11 Jan 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4B0jS6G"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35E53E28
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed71baa91so4444549276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704998065; x=1705602865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9/LSxgXbzf5A2fx+kbyMyermt+pVACA5FZfB44Fr/E=;
        b=Z4B0jS6GmMbJ5ttd6PDInCFiwqFFPDA51vEj/LafPzSH+H0l3FhjoGS/IPyq9jJa/4
         BmY5Krc6v3Clf0wFP9vHOnQBsmFYFO0bL/dY09vtfRQ0UZ6s9nyWlS75nK/C4wWo77qI
         AjujFZrBjtTljS2/zhHrlqgJw/e2ZgOBiF2GoIck5t6N18qaqkxqrGNFXo2QhqFpFmnc
         igg7y57NdPjR3SnxeIugK8U3RcGwLd20ZRQNZ/NkAq82X5xyMFeY+GkXrcbF6/r0AmaV
         kHkqp4j4i+opNEBbDBNl6YJ4ysKdiz9qw8OWJPeHnr3br1LD/YoIOa0kRiB/W+Y1ks6Z
         1kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998065; x=1705602865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9/LSxgXbzf5A2fx+kbyMyermt+pVACA5FZfB44Fr/E=;
        b=jrUYLPdL0SkN44hHF6VzROMEK+KOaY8fpwDS7PTjc5trvdDfkSPYewYPinKZADdJrd
         aX5HQz5gvOCtY9bSuT3SnlVdXIs4k/zy+eytL5TCAeuKLftwKU/QnqjNndxEBR8+91RJ
         3juTlsIjKiI4OfvPbGMnLemV21dijWjKhCBexxoFBh9MdTpCwsnXPR7iYjXryTxG5UpO
         zoiPsJDNX5+sGNxL/k8tggkSsMvEtvkSA7YWP538RUWsXg+P5NoZRavIveL3PkDunNph
         j1ui5PR3Njsh49yVjTscVZFu/ZZM0Ia+vYUQFJTHZ6u0zvs5ZUudyq8NnecjL2K2Lq0W
         zr/A==
X-Gm-Message-State: AOJu0Yy5qu77WY3eQhKgw0rXzsSkxWl3fpYjlrF4kcMsiJx+wOY04q7Y
	nPQtvr/ODwtvpViwbwZphlTE5dW4RN5AeUFvOkO3Hxnfk1Ub
X-Google-Smtp-Source: AGHT+IGclQ6348ZGqi4qRoksX9ZYj6rpu5oYN3dUpEZNaY7fFXFz3VJbRt+c6yGO48RxgV70QEPOQnaabLEFGuxe5Tw=
X-Received: by 2002:a25:8744:0:b0:dbe:aa02:c3c1 with SMTP id
 e4-20020a258744000000b00dbeaa02c3c1mr79236ybn.0.1704998064904; Thu, 11 Jan
 2024 10:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000011d709060eadffd3@google.com> <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
 <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
In-Reply-To: <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 10:34:13 -0800
Message-ID: <CAJuCfpHTAAPEjMLrcxyG8zW7HA47EinB8CQfKGmBw7gGxqQ=vA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> > <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e2425464bc87 Add linux-next specific files for 202401=
05
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14941cdee=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056b9349=
f3da8c9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D705209281e3=
6404998f6
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125d0a0=
9e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc7331e=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/2f738185e2cf=
/disk-e2425464.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46/vm=
linux-e2425464.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/a9945c8223=
f4/bzImage-e2425464.xz
> > >
> > > The issue was bisected to:
> > >
> > > commit adef440691bab824e39c1b17382322d195e1fab0
> > > Author: Andrea Arcangeli <aarcange@redhat.com>
> > > Date:   Wed Dec 6 10:36:56 2023 +0000
> > >
> > >     userfaultfd: UFFDIO_MOVE uABI
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11cb6e=
a9e80000
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13cb6e=
a9e80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb6ea9e=
80000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > >
> > >  do_one_initcall+0x128/0x680 init/main.c:1237
> > >  do_initcall_level init/main.c:1299 [inline]
> > >  do_initcalls init/main.c:1315 [inline]
> > >  do_basic_setup init/main.c:1334 [inline]
> > >  kernel_init_freeable+0x692/0xc30 init/main.c:1552
> > >  kernel_init+0x1c/0x2a0 init/main.c:1442
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/page-flags.h:1035!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-202=
40105-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 11/17/2023
> > > RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
> >
> > From a quick look, I think the new ioctl is being used against a
> > file-backed page and that's why PageAnonExclusive() throws this error.
> > I'll confirm if this is indeed the case and will add checks for that
> > case. Thanks!
>
> Hmm. Looking at the reproducer it does not look like a file-backed
> memory... Anyways, I'm on it.

Looks like the test is trying to move the huge_zero_page. Wonder how
we should handle this. Just fail or do something else? Adding David
and Peter for feedback.

>
> >
> > > RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> > > Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff =
e8 79 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 6=
2 c6 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> > > RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> > > RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> > > RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> > > R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> > > FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  userfaultfd_move fs/userfaultfd.c:2047 [inline]
> > >  userfaultfd_ioctl+0x683/0x6420 fs/userfaultfd.c:2169
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:871 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:857 [inline]
> > >  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > > RIP: 0033:0x7f4bada9b3e9
> > > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fff2c1d6998 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 00007fff2c1d6b68 RCX: 00007f4bada9b3e9
> > > RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> > > RBP: 00007f4badb0e610 R08: 00007fff2c1d6b68 R09: 00007fff2c1d6b68
> > > R10: 00007fff2c1d6b68 R11: 0000000000000246 R12: 0000000000000001
> > > R13: 00007fff2c1d6b58 R14: 0000000000000001 R15: 0000000000000001
> > >  </TASK>
> > > Modules linked in:
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
> > > RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> > > Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff =
e8 79 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 6=
2 c6 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> > > RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> > > RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> > > RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> > > R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> > > FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup

