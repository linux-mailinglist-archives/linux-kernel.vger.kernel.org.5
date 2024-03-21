Return-Path: <linux-kernel+bounces-109730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03848854F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C12835A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E3D58107;
	Thu, 21 Mar 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5iu9dpJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4D50249;
	Thu, 21 Mar 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006396; cv=none; b=G58VLFwVswb3bAr8bfX6O2ktQiLgDaKKFlcdnyVeNdQRXUGGDueyeiVBt8a3cGicIWuy1xt5o0E/gysuRlMfDcvQXLQWcp2k1rX7CtNv/1W4tjhSLhYSi8iswlEuBipG57QRmksjeSAwXcaSAQpYPDP7AaAu+7UpDd1DIva71Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006396; c=relaxed/simple;
	bh=lfzYv1h/czzT9o64k4FnzumtWG84f3GYHXjhGITWGuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULDBPT+9SIu7dxDAZqehQCWtjNrrpYqHM3o4CKG0lVWRKJs6HynHxYleugqQPGTWugpf0X3eoEgPiJxqg6DIfb+ItsMcOppad2/tpurSjeMVTbfOeAinu1S/hlAA9uwMD4PFJgRryRLjO6R1BJR7BybVBO87/ETuHJpVhg1etn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5iu9dpJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512e39226efso556020e87.0;
        Thu, 21 Mar 2024 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711006392; x=1711611192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG8H4iDFAc1t3qHbj1kNsgeA823fPcekBzV63RYaF6Y=;
        b=H5iu9dpJIKM4W0dQ1UDl4PQiT+epi4Pv9u8lY/B7zQg/2tMabFqNaYvM7aVktEcz0q
         4EkPppBs3G0wN5AH12LqoXbvpRaQIf6JHW1+w3uBCJJ5D2gLJ+sLRKIHYoFaVm8qPC6Q
         dH6jipdhjTUP+EPDcFGJpvW+uJQ3jY8n7x3BgkEXPsCo43OLgSXxXT8+HAkvLjXR5u2Y
         va7XeaBY83ZT1UhJvYCy7AMyeUtIw2uM/rINP1bFwfS/nQ07Knb9MdSJiyhKpeTE4MDA
         C/K4KZmkyBxIKHCQPKZbdpQoxHwJxNiDp66QthCCzNxP826wuE2ypcAXSXiogPOafd3c
         a7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711006392; x=1711611192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG8H4iDFAc1t3qHbj1kNsgeA823fPcekBzV63RYaF6Y=;
        b=LpMSPJKCT3LdLqKWpQevQng6nJeqNnDDrJxlPRu41cAHA0oWEZuqnJkKa3YOjg9p8R
         SOezB00xo9eBm3d+xXJn1Whe+nsZwQCIwYn3KdGE7ffseAcoC6Z0RN5IrnECDYty+dmP
         KxOcn7IcgkoxobDwaNf1kmRpYGYHJf4YaD0m1eO65pliEbAGMzgN2PaV3WlpLUmsXsg8
         eqLZ0aWrNMbsCi4w6LXTTi7zOh26npaiMx+fLZrZR3622nUFbkTipUTWiojsh9JQzxVl
         31wYisfOt2g1fRjkqUyL9rR1NHqPwY37//JE1eeA2GgW3sxl2YZk1MFLsGwCwhTdEDf9
         5ZNg==
X-Forwarded-Encrypted: i=1; AJvYcCUYy8feWioiBS2lv49ptXT8y0kZsE3ETHWzZatG7s+jVEjgLv3c5yBERrnt3Bi7agOMLb1PHV/9FbCZuQlc25CID+hKtJjB/cLfevFpbhowMyKwei8v70QyfagE5G3YVv4SGINe164K7v/BfCgQk1QuOvUK2AQpl+WS
X-Gm-Message-State: AOJu0Yx/U1x1YQiL178qfjUoV8guYLeJAlmaTG0nfwCNpxIUzcOud5NC
	b8QWvma73FTdusNBgouvV3MeYkK2MCWfAvno5ScZDoub00mhAx7m6RS+vydS7FtrmZ0JU2R+qzV
	ivWUtfj1qaVgHRMPxo/aTBxPgNds=
X-Google-Smtp-Source: AGHT+IEApP00m/eNqfI3dQObKbZkEHXNDVuDCg5UQNMFtE5SgkvyNvn3H5REA2w2PUA2mgku3Cb75eMAOS/VazJuZLQ=
X-Received: by 2002:a19:8c5d:0:b0:513:a1eb:c084 with SMTP id
 i29-20020a198c5d000000b00513a1ebc084mr2105258lfj.7.1711006391935; Thu, 21 Mar
 2024 00:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com>
In-Reply-To: <0000000000003dc8e00614076ab6@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 00:33:00 -0700
Message-ID: <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
Subject: stack access issue. Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds
 in check_stack_range_initialized
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

looks like the refactoring of stack access introduced a bug.
See the reproducer below.
positive offsets are not caught by check_stack_access_within_bounds().
So both slot and spi become negative and access
stack[spi].slot_type[slot % BPF_REG_SIZE]
returns garbage.

On Tue, Mar 19, 2024 at 11:12=E2=80=AFAM syzbot
<syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12fed76918000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d=
440
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D33f4297b5f92764=
8741a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1763a479180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c3871118000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/dis=
k-0740b642.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmlinu=
x-0740b642.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead/b=
zImage-0740b642.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7190:12
> index -1 is out of range for type 'u8[8]' (aka 'unsigned char[8]')
> CPU: 0 PID: 5071 Comm: syz-executor474 Not tainted 6.8.0-syzkaller-05226-=
g0740b6427e90 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
>  check_stack_range_initialized+0x1668/0x19a0 kernel/bpf/verifier.c:7190
>  check_helper_mem_access+0x2eb/0xfa0 kernel/bpf/verifier.c:7294
>  check_helper_call+0x263c/0x7220 kernel/bpf/verifier.c:10252
>  do_check+0x9e29/0x10530 kernel/bpf/verifier.c:17801
>  do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20500
>  do_check_main kernel/bpf/verifier.c:20591 [inline]
>  bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21261
>  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
>  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f8416194629
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdc6f0fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffdc6f0ff88 RCX: 00007f8416194629
> RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
> RBP: 00007f8416207610 R08: 0000000000000000 R09: 00007ffdc6f0ff88
> R10: 00000000fffffff8 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffdc6f0ff78 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ---[ end trace ]---
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

