Return-Path: <linux-kernel+bounces-132228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104858991A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F64C1C214D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592AA137C24;
	Thu,  4 Apr 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3okz3d6"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB171B40;
	Thu,  4 Apr 2024 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271439; cv=none; b=RHKczRZdFERtUKDuCptZo03XY0hpXZP/801G7uwUexSrM51r0Q0kL/IlCXi5a7C044XMjFunBWwtooKYLQ6YPNa+f1Xb8LK5GvEVL1xoN3J1UkiHEbRPNWDY+JMbZUyddi3jyZ4Uo5k1xwTiuEgOqXtsryPCfkw68myuZ8tXEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271439; c=relaxed/simple;
	bh=r8oa3TV7u67F2dKKiK9LkfQdog75HitDV1nG+sxvt2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF+AsZZrGXj4c0Ukr2TpbC2AZqTkYFWHYD5AvYSiIvSlcQajLA6xq7vkfZb5VPPyauRBRqgSNAM5oOE1ZOKpLj4xSn6g7uNjVXYNiArfajB9LH/Ib/wey5dEBY5Gw3MkCJgf5NTBiwoUYhzqQ2mN4BuHnAikwV9xGj2BVzINhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3okz3d6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ddd1624beso866378f8f.1;
        Thu, 04 Apr 2024 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712271436; x=1712876236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8Y/0FBc6X/EtKXau0Qf+nlfqNdcdxQlAMfTvPoQeI0=;
        b=c3okz3d6+91H/C88RajrrkdmktIFt6eZaOlzdRHpaiADhEh8v8K1iQLoY0EmO4QLxX
         AYXGWqjGCg4zXQpE3d4sVmbEvVgpc1YPn9eUWflpXQcwaBLiv1N0p+oXuq/fSqUbCoBZ
         OXf3hVkE+wZME2rM90eWmk4J0sETq3hTb9cJetcYAcRvjHZKXWf/U+q9UuGDIOEa1Ugi
         BvDjvqyT3OCpIQGiSrLxZJO5zXcgCs7B/buNXC3ttmH6PEZARI00w84Th67UWD+q/j+y
         +9FH09j+W95sm3BM+exqQfQGnl7T/3LvfNuJO41OYF2TNduuq/cY6dwATHrG6f6VpTfP
         TdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271436; x=1712876236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8Y/0FBc6X/EtKXau0Qf+nlfqNdcdxQlAMfTvPoQeI0=;
        b=Dnsb+dVtBeVXU6Q9XU9TZ0uAXMLwbEbSWS5p1IZTiUPc2X4qGuAaYPPeeTDYseaPT9
         bzGoROI9i4NzWhr7/OHUBF3dH3Thxb6cAOpIJfrVN2vniHOJ++wefTexPSdQp4lYwgyI
         hB9J7G7SNKZY+gVXHQIp2I6NxC+Unb7i5yD6IlHMF3p4EETrv4ZoofdZdEc0bwqfK4SD
         BNrSq+tYDCD7KPekJG6sREVdMz9xUYP1lGIcn7J35zr0M4MksM5WOINGGzY+vCZj6xlv
         fmpKXSVN7lDmAQ/66HGaMi5Qngqf6t9ByWWK/oRUbi1gW6v6aQqIouFAtW8DD3ncC2+j
         d/tg==
X-Forwarded-Encrypted: i=1; AJvYcCUqH5iPszHOJXJbGtT/FEpUGF2XG5FMjXidxkt8zm2CgohioJhVY/Wdxhy9SHa7qcQJljGuVY2ZLIjWv1cjJbgACJy0xvkEasVmig6HSMTy1ZPsxzahzs4JWbNA1Ylo0HSo
X-Gm-Message-State: AOJu0YyYcbgUlIieB61MRltiqa59lR0Oj9ZwZ0qiWhnj9LswLaHr3uDQ
	mEsN4SjKHWir0uQhiiOKXNZaqXdyEQivz2MN+b3eCiWwZOt9CytvS4NjF7PEqcwxQkZc+QSzAIb
	PNykKuVTds2MwpmCPteFp2VAUpcQ=
X-Google-Smtp-Source: AGHT+IF3Nh4FYYKX55U6jOpOab6/MctiH1JFvCuQfG6hhtIN2gwBYUeuBqo9lbWfS+doAekfX0VqbiOdUpqMUH+sGIY=
X-Received: by 2002:adf:e742:0:b0:341:b5ca:9e9c with SMTP id
 c2-20020adfe742000000b00341b5ca9e9cmr535343wrn.25.1712271435557; Thu, 04 Apr
 2024 15:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e9a8d80615163f2a@google.com> <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
In-Reply-To: <20240403184149.0847a9d614f11b249529fd02@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 15:57:04 -0700
Message-ID: <CAADnVQ+meL1kvXUehDT3iO2mxiZNeSUqeRKYx1C=3c0h=NSiqA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
To: Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:56=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Mon, 01 Apr 2024 22:19:25 -0700 syzbot <syzbot+186522670e6722692d86@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
>
> Thanks.  Cc: bpf@vger.kernel.org

I suspect the issue is not on bpf side.
Looks like the bug is somewhere in arm32 bits.
copy_from_kernel_nofault() is called from lots of places.
bpf is just one user that is easy for syzbot to fuzz.
Interestingly arm defines copy_from_kernel_nofault_allowed()
that should have filtered out user addresses.
In this case ffffffe9 is probably a kernel address?
But the kernel is doing a write?
Which makes no sense, since copy_from_kernel_nofault is probe reading.

arm folks,
pls take a look.

> > syzbot found the following issue on:
> >
> > HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kern=
el...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1060bd41180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D43f1e0cbdb8=
52271
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D186522670e672=
2692d86
> > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D157511291=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10136341180=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/8ead8862021c/non_bootable_disk-317c7bc0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/49458dc4ddf2/vmli=
nux-317c7bc0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/031f516e5544=
/zImage-317c7bc0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
> >
> > 8<--- cut here ---
> > Unable to handle kernel paging request at virtual address ffffffe9 when=
 write
> > [ffffffe9] *pgd=3D80000080007003, *pmd=3Ddeffd003, *pte=3D00000000
> > Internal error: Oops: a07 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 3001 Comm: syz-executor291 Not tainted 6.9.0-rc1-syzkaller =
#0
> > Hardware name: ARM-Versatile Express
> > PC is at copy_from_kernel_nofault mm/maccess.c:38 [inline]
> > PC is at copy_from_kernel_nofault+0xb8/0x12c mm/maccess.c:24
> > LR is at copy_from_kernel_nofault+0x24/0x12c mm/maccess.c:31
> > pc : [<804361f0>]    lr : [<8043615c>]    psr: a0000013
> > sp : df96dc90  ip : df96dc90  fp : df96dcac
> > r10: 00000000  r9 : df96dd40  r8 : ffffffe9
> > r7 : 83d33c00  r6 : 00000005  r5 : ffffffe9  r4 : ffffffe9
> > r3 : fffffff2  r2 : 00000000  r1 : 00000005  r0 : 00000001
> > Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 30c5387d  Table: 8434d080  DAC: 00000000
> > Register r0 information: non-paged memory
> > Register r1 information: non-paged memory
> > Register r2 information: NULL pointer
> > Register r3 information: non-paged memory
> > Register r4 information: non-paged memory
> > Register r5 information: non-paged memory
> > Register r6 information: non-paged memory
> > Register r7 information: slab task_struct start 83d33c00 pointer offset=
 0 size 3072
> > Register r8 information: non-paged memory
> > Register r9 information: 2-page vmalloc region starting at 0xdf96c000 a=
llocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
> > Register r10 information: NULL pointer
> > Register r11 information: 2-page vmalloc region starting at 0xdf96c000 =
allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
> > Register r12 information: 2-page vmalloc region starting at 0xdf96c000 =
allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
> > Process syz-executor291 (pid: 3001, stack limit =3D 0xdf96c000)
> > Stack: (0xdf96dc90 to 0xdf96e000)
> > dc80:                                     df96ddb8 ffffffe9 00000005 ff=
ffffff
> > dca0: df96dccc df96dcb0 8037c428 80436144 df96ddb8 00000000 8037c40c ff=
ffffff
> > dcc0: df96dd64 df96dcd0 7f011aa0 8037c418 ffffffe9 df96dd40 802ff648 81=
182b54
> > dce0: df96dd64 df96dd30 35702575 00000000 828c0a94 40000013 00000000 00=
000000
> > dd00: df96dcf0 00000000 df96dd74 df96dd18 df96dd2c df96dd20 81182b64 81=
898a78
> > dd20: df96dd64 df96dd30 802ff648 81182b54 ffffffe9 df96dd40 00000005 00=
000000
> > dd40: df96ddb8 00000000 df969000 842879c0 df969030 df96de30 df96ddfc df=
96dd68
> > dd60: 8149c734 7f011a00 804d0184 8089c164 00000000 83d33c00 804b4cdc 80=
4d0124
> > dd80: 8260ca3c df96de30 00000001 df96de2c 80468494 00000000 df96ddb8 00=
000000
> > dda0: 00000001 00000000 19df2b20 00000014 00000000 00000000 df969000 00=
000000
> > ddc0: 00000000 00000000 84497800 f655f23e df96ddfc 842879c0 00000000 df=
96dec0
> > dde0: 83f79c00 84497800 00000000 0000000e df96de64 df96de00 8149d6a0 81=
49c5d0
> > de00: df96de30 00000000 00000000 df96de98 20000080 00000000 df969000 00=
000000
> > de20: 828ffe80 82fe0000 8051cdd4 00000000 00000000 f655f23e 80395130 df=
969000
> > de40: 00000028 df96de98 0000000a 20000080 00000028 00000000 df96df8c df=
96de68
> > de60: 8039c858 8149d388 81c66394 84342c0c fcd9275f 00a00000 20000000 83=
d33c00
> > de80: df96dee0 df96dfb0 df96dea4 df96de98 8089c348 df96dee0 20000080 00=
000000
> > dea0: 83d33c00 df96ded0 00000008 00000000 00000008 80426e10 df96deec df=
96dec8
> > dec0: 00000003 02000000 0000000e 00000055 20000140 00000000 20000380 00=
000000
> > dee0: 00000000 04000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > df00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00=
000000
> > df40: 00000000 00000000 00000000 00000000 00000000 00000000 20000000 f6=
55f23e
> > df60: 80216078 ffffffff 00000000 0008e050 00000182 80200288 83d33c00 00=
000182
> > df80: df96dfa4 df96df90 8039dd98 8039b934 20000080 00000000 00000000 df=
96dfa8
> > dfa0: 80200060 8039dd78 ffffffff 00000000 0000000a 20000080 00000028 00=
000000
> > dfc0: ffffffff 00000000 0008e050 00000182 20000100 00000000 00000001 00=
003a97
> > dfe0: 7ec66c70 7ec66c60 00010748 0002e890 00000010 0000000a 00000000 00=
000000
> > Call trace:
> > [<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (bpf_probe_re=
ad_kernel_common include/linux/bpf.h:2909 [inline])
> > [<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (____bpf_prob=
e_read_kernel kernel/trace/bpf_trace.c:240 [inline])
> > [<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (bpf_probe_re=
ad_kernel+0x1c/0x44 kernel/trace/bpf_trace.c:237)
> >  r7:ffffffff r6:00000005 r5:ffffffe9 r4:df96ddb8
> > [<8037c40c>] (bpf_probe_read_kernel) from [<7f011aa0>] (bpf_prog_244768=
d4818575ac+0xac/0xc0)
> >  r7:ffffffff r6:8037c40c r5:00000000 r4:df96ddb8
> > [<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_dispatc=
her_nop_func include/linux/bpf.h:1234 [inline])
> > [<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (__bpf_prog_=
run include/linux/filter.h:657 [inline])
> > [<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_prog_ru=
n include/linux/filter.h:664 [inline])
> > [<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_test_ru=
n+0x170/0x388 net/bpf/test_run.c:425)
> >  r9:df96de30 r8:df969030 r7:842879c0 r6:df969000 r5:00000000 r4:df96ddb=
8
> > [<8149c5c4>] (bpf_test_run) from [<8149d6a0>] (bpf_prog_test_run_skb+0x=
324/0x6cc net/bpf/test_run.c:1058)
> >  r10:0000000e r9:00000000 r8:84497800 r7:83f79c00 r6:df96dec0 r5:000000=
00
> >  r4:842879c0
> > [<8149d37c>] (bpf_prog_test_run_skb) from [<8039c858>] (bpf_prog_test_r=
un kernel/bpf/syscall.c:4240 [inline])
> > [<8149d37c>] (bpf_prog_test_run_skb) from [<8039c858>] (__sys_bpf+0xf30=
/0x1ef0 kernel/bpf/syscall.c:5649)
> >  r10:00000000 r9:00000028 r8:20000080 r7:0000000a r6:df96de98 r5:000000=
28
> >  r4:df969000
> > [<8039b928>] (__sys_bpf) from [<8039dd98>] (__do_sys_bpf kernel/bpf/sys=
call.c:5738 [inline])
> > [<8039b928>] (__sys_bpf) from [<8039dd98>] (sys_bpf+0x2c/0x48 kernel/bp=
f/syscall.c:5736)
> >  r10:00000182 r9:83d33c00 r8:80200288 r7:00000182 r6:0008e050 r5:000000=
00
> >  r4:ffffffff
> > [<8039dd6c>] (sys_bpf) from [<80200060>] (ret_fast_syscall+0x0/0x1c arc=
h/arm/mm/proc-v7.S:66)
> > Exception stack(0xdf96dfa8 to 0xdf96dff0)
> > dfa0:                   ffffffff 00000000 0000000a 20000080 00000028 00=
000000
> > dfc0: ffffffff 00000000 0008e050 00000182 20000100 00000000 00000001 00=
003a97
> > dfe0: 7ec66c70 7ec66c60 00010748 0002e890
> > Code: 9a000007 e3a03000 e4942000 e3530000 (e5852000)
> > ---[ end trace 0000000000000000 ]---
> > ----------------
> > Code disassembly (best guess):
> >    0: 9a000007        bls     0x24
> >    4: e3a03000        mov     r3, #0
> >    8: e4942000        ldr     r2, [r4], #0
> >    c: e3530000        cmp     r3, #0
> > * 10: e5852000        str     r2, [r5] <-- trapping instruction
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
>

