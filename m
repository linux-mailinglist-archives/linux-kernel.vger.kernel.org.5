Return-Path: <linux-kernel+bounces-112535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA4887B41
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB11C20404
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421B1C02;
	Sun, 24 Mar 2024 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN2IuuFG"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723563B;
	Sun, 24 Mar 2024 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241450; cv=none; b=ohQTCsKwCpvpY/1QtIibnLbN42WtPijLuGV/wrDqNOm3hihvK66tzDoKfgkOIN7DX+4Po6qIiSmXAP9ihBLzSvTtaQr5fdFJtmmAXXWFYfkppv3E0fwLGyXHXgg6b9azryYb6AuCJLMuOOPO4JVq8Z5WODXEkyOnuRMNUmgMshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241450; c=relaxed/simple;
	bh=6+3n5jGyQ2Zf+BUw/Fg23lhslfgdOfy3aqLiWiy6NlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAlyi14CVhp4O1EjPiTv654ItwASDEffP8Z+N9SONOwAAfiAU1mDu6qednEyY21tT8Oc2dHMlP/WdqtIHs11lcuWpRmcCm5tFsR8j2lgn262kR6JZwHu5CegxGz36uq9FMneC55bYiEQOvJFACsaux5+qPv7tz/50zHe6vqFuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN2IuuFG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so1273955a12.0;
        Sat, 23 Mar 2024 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711241447; x=1711846247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd+E+wjGsxttwBVcnZu6WwsovFEvT79fd7mf/2LSTkw=;
        b=mN2IuuFGZ98rs0DnC38CpeTse1nZIF3dukqqscjy70bwvODnuXTAbl6wJoxuhxVdh8
         B0S/j/UtOyMqrv08OAEWcZq/E46+LS+oY1RtznNR8/igdLV4UIrYDurK7sbExTqbwH5y
         Av82U5K/EPkBIsXpfrM/TrCiOeEVLjSR+L4ZDjr/5qdLzgG/ElVqu+5rqze76N8EqxS9
         j+HUkwDIKP+n/CpwMXm53wXC8aeCNJTc3rrCWmocxh1bHroHqV7U/ipZQPGZku4YjQx5
         nVv5CG7rS5MRyYJ9jQS5QOB9eEv2TZPu5LzOXu6QU4rNuXGLxeFBhxxHMuCDs/csQSg5
         cssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241447; x=1711846247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd+E+wjGsxttwBVcnZu6WwsovFEvT79fd7mf/2LSTkw=;
        b=napeW6EBGpqoNONvpbyrZYCawXjAUvwGjGmKudVqf1XwPjCHzOrsba6EO87shVCrFT
         EPjH4WdITYvCd+7eesZGd1nBIVUhInJpeKZ3NbejDR+VsskEYVNZsRZ8n3g7MREFVyvL
         EFeu9kEc7gehIcwBRbtVbwPeKQWOSH/Nw8hfcBagMFiR662kl6MsmDm5NiAOD7ZY7YCz
         4cX+7gdhMP5DvYQzjpNU1r64y7J5KijZfXtYkB4wLNzvM+01wEkMx8ZmgmPySKhFZ760
         fb48bEsjCNX1K4vCxGzLPFVBYforQRw1oGFF23Yef5mVRTt5R6WuELJJ1yV/1f4pJZRi
         jxMA==
X-Forwarded-Encrypted: i=1; AJvYcCUGqb6kSyNzYzdkQFkKsFHp8ttBuyLNtqZU7YtAooaPKimgATu7mHGRWta6WKdF92l6u5/1Xy/cTHoZ6ueD6MEsw2X1kDHtIVujIJc3cQubMKf7GuTWzBIOOeABxOhLIISRoX2v3R6T/e6AVuV9l2zp0e2NJwXGIMzW
X-Gm-Message-State: AOJu0YyB2u6NB3SAeNs/zbiWb7d5oYA44OKt3D/FAQq0Pew/wmYdCe0B
	8sQN8UEDQZ5NP/2dnwE1fmivBoEoL9A4+HXMoo3ZGGszCJCm8nZursl3+npTBUj040KgHJp/b8T
	xCdgt3znAN9gzDfkgZcf9GRfZ+4A=
X-Google-Smtp-Source: AGHT+IH1GhLlXNu4wxRQeu+7VChdoCTU8z8vep/jUAaVa3Bryzp6hSNIggybceHZBLWQE5A0E2b8n907yBmYmdsHWyQ=
X-Received: by 2002:a50:9b4e:0:b0:565:9e16:60da with SMTP id
 a14-20020a509b4e000000b005659e1660damr2050000edj.30.1711241446487; Sat, 23
 Mar 2024 17:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
In-Reply-To: <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sat, 23 Mar 2024 20:50:35 -0400
Message-ID: <CABWLsetXQ8Xj-RECoyC7mp4YrdSsPwmSvkS36Eq2JKLfAYULuw@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, eadavis@qq.com
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Edward

On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi Andrei,
>
> looks like the refactoring of stack access introduced a bug.
> See the reproducer below.
> positive offsets are not caught by check_stack_access_within_bounds().

check_stack_access_within_bounds() tries to catch positive offsets;
It does: [1]

err =3D check_stack_slot_within_bounds(env, min_off, state, type);
if (!err && max_off > 0)
  err =3D -EINVAL; /* out of stack access into non-negative offsets */

Notice the max_off > 0 in there.
And we have various tests that seem to check that positive offsets are
rejected. Do you know what the bug is?
I'm thinking maybe there's some overflow going on, except that UBSAN
reported an index of -1 as being the problem.

Edward, I see that you've been tickling the robot trying to narrow the issu=
e;
perhaps you've figured it out?

If the bug is not immediately apparent to anyone, I would really appreciate=
 a
bit of tutoring around how to reproduce and get verifier logs. I have tried=
 a
bunch of cases of constant- and variable-offset accesses, and couldn't repr=
o. I
can run syzkaller's repro on its own vm image, and indeed it crashes. But I=
'm
not sure how to get verifier logs out of the C reproducer.  Alternatively, =
I'm
not sure how to figure out the actual BPF program corresponding to the "syz
repro" in [2] and turn it into a test_progs test. How do you guys do it?

Thanks a lot!

[1] https://github.com/torvalds/linux/blob/70293240c5ce675a67bfc48f419b0930=
23b862b3/kernel/bpf/verifier.c#L6695
[2] https://syzkaller.appspot.com/x/repro.syz?x=3D1763a479180000


> So both slot and spi become negative and access
> stack[spi].slot_type[slot % BPF_REG_SIZE]
> returns garbage.
>
> On Tue, Mar 19, 2024 at 11:12=E2=80=AFAM syzbot
> <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12fed769180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a19=
3d440
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D33f4297b5f927=
648741a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1763a4791=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c38711180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/d=
isk-0740b642.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmli=
nux-0740b642.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead=
/bzImage-0740b642.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7190:12
> > index -1 is out of range for type 'u8[8]' (aka 'unsigned char[8]')
> > CPU: 0 PID: 5071 Comm: syz-executor474 Not tainted 6.8.0-syzkaller-0522=
6-g0740b6427e90 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 02/29/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
> >  check_stack_range_initialized+0x1668/0x19a0 kernel/bpf/verifier.c:7190
> >  check_helper_mem_access+0x2eb/0xfa0 kernel/bpf/verifier.c:7294
> >  check_helper_call+0x263c/0x7220 kernel/bpf/verifier.c:10252
> >  do_check+0x9e29/0x10530 kernel/bpf/verifier.c:17801
> >  do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20500
> >  do_check_main kernel/bpf/verifier.c:20591 [inline]
> >  bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21261
> >  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
> >  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
> >  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f8416194629
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffdc6f0fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007ffdc6f0ff88 RCX: 00007f8416194629
> > RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
> > RBP: 00007f8416207610 R08: 0000000000000000 R09: 00007ffdc6f0ff88
> > R10: 00000000fffffff8 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffdc6f0ff78 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > ---[ end trace ]---
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

