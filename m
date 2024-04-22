Return-Path: <linux-kernel+bounces-153674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C98AD17D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010C81C229AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68123153596;
	Mon, 22 Apr 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dfWvv06A"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA4153583
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801825; cv=none; b=ZRN35gp0V2Z+VItsi0xjsU0tY5mcD7f5W2+vBPQGxwBINMMNQYdmWXMkgu5wphWpP6k5pbHciJu7akIxMP50dtxoorRrtwlSCPZP4eAh5UVdId4e8lHvfai5E9FKYcz8I+CfPQ9AFYjLu4AhPF0jSvpF7aSG1DgZZxNNzmd/YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801825; c=relaxed/simple;
	bh=o7xInYt7mqYcLYiHYrPWO6hUeUy4Gvju/GrSYq5PzB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATx4wQnjUeDNTfKaHZGWQ8YPdFOxF9ZuRun0q6tfUny/evt4z/TMTwLHke4ffIJmV43o20pXpgHJh7QQyGMICvZjoEzbag+flQKfOJTSZ5Bre9vVVskWIbnenuYJoMCcFHb3lUzXMTknovjn8num2Vt+V7LOadJ/jTOGXaZu53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfWvv06A; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5af23552172so414191eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713801820; x=1714406620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4dSFLclJoGUNND2F9ap2xz5ZtpVXhVADCdCntPAVe8=;
        b=dfWvv06AZRMLJVv1USulOI04Fp7UOmhchHotMiVhxrtySN9nmSaVcWCw0F1W3jZhV9
         7imvK5oeC+g9ywUNpQCNQtV1jEJDW//wKDJG1hKglZZzcM9ODGEWickcrnHHd0DkHN5c
         o9OVwqTFZXL7O7W9Xc9Ih8Pd+vGS3WvNzugvMcDROHui2q1mUCHXcqJ/QlnQwA4efeRE
         PsmJmQC02pFlVfTIXnT5fmlO4uGxDNKb4YoRd87ij9hlD4/bkEqYi8j2KKsVF1RStkBx
         qdFgyWPKFviItBgK/rsokYCeGAgq5Kg9dsBrCaJoe+TPYuF6/bfaFQSU2IvlyhkHuCdw
         GYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713801820; x=1714406620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4dSFLclJoGUNND2F9ap2xz5ZtpVXhVADCdCntPAVe8=;
        b=IilYE8TZV4kiKwxcaqqfU9NDMYQnWq+DmdZkTmVS8ozSDQFpciVZQpLur1YBHrZ0At
         ba3yvQyhHxSzBTYpFP3ETob1k9c+/cdDLhQO882byMOcRIFgcESeTwoSfJgLN0pOja5V
         h1d5xMLSPVig55a7AlXKuKZJYjgII+CMYW2NnontMurUwnEqHB2cZvZjynczxgfLDIgz
         K1tzrnIl9U0XrFYnvzUkZPrByRclWEBYEAxEQYgxg8Duef17dOfILPGkRzxlZ3QbU4l9
         JS2IiUJOfJeDXtr0XcrKUFtfuiiydsWRKdVqaIo+RIwgY2iolUyS3InMytpwaf4IDS//
         yMIw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5NeukSh+b4SLwPvKuLhhaDbI/BOMYvdCgt+kkAPFaEWx21Zhn3ctJcYnaXqUzqENl1NKG9mPTFhEJf6wqpjub0SbpPwOHEP1j9o+
X-Gm-Message-State: AOJu0YzcIOQfiRYMJhc9ir7Is6UMHcy5CHV4AGQAwmB813FefrNXvifK
	lQYZJK0lk5oYEVRPSs6RcfPbKPmOMYKJpy9K/EJgh+FZwhEysQR95tJdbhJwCY/liSYfiOpfVZ3
	KoptFQW28IZFfAXqGnzBfdaUN0/JUdGWK/Wqm
X-Google-Smtp-Source: AGHT+IFJobejGLyCoyenfsOS02ghwo0U1T7zg7dlHbo0B7PeCmw9xCl22bfNLsNgpLJQff80FnaKoYqE1avaLLAXWss=
X-Received: by 2002:a05:6358:f109:b0:18b:3c71:fa14 with SMTP id
 jh9-20020a056358f10900b0018b3c71fa14mr2257779rwb.5.1713801820334; Mon, 22 Apr
 2024 09:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004792a90615a1dde0@google.com> <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
 <ZiLzUgbW6dw-FYtf@google.com> <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
In-Reply-To: <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 22 Apr 2024 09:03:26 -0700
Message-ID: <CAKH8qBt-PgGmM3B6-oyt_VFaB4R+2ywcHfCGCQfUj-w+iHTDOg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	syzbot <syzbot+838346b979830606c854@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:37=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> On Sat, 20 Apr 2024 at 00:42, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 04/19, Alexei Starovoitov wrote:
> > > On Mon, Apr 8, 2024 at 8:53=E2=80=AFPM syzbot
> > > <syzbot+838346b979830606c854@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git=
kernel..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1259622=
3180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36=
f0cab495a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D838346b97=
9830606c854
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134ec=
bb5180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a8b3=
d180000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2=
ae/disk-fe46a7dd.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/=
vmlinux-fe46a7dd.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f=
5322/bzImage-fe46a7dd.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> > > >
> > > > BUG: unable to handle page fault for address: 0000001000000112
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0
> > > > Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > > > CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-=
08951-gfe46a7dd189e #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/27/2024
> > > > RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
> > > > Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e f=
a 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00=
 c9 c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
> > > > RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
> > > > RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
> > > > RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
> > > > R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
> > > > R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
> > > > FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> > > >  __bpf_prog_run include/linux/filter.h:657 [inline]
> > > >  bpf_prog_run include/linux/filter.h:664 [inline]
> > > >  bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
> > > >  __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.=
c:1830
> > > >  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> > > >  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> > > >  __do_sys_setsockopt net/socket.c:2343 [inline]
> > > >  __se_sys_setsockopt net/socket.c:2340 [inline]
> > > >  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> > > >  do_syscall_64+0xfb/0x240
> > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > This one looks interesting.
> > > But I cannot reproduce it.
> > >
> > > Bjorn or Stan,
> > >
> > > Could you take a look?
> > >
> > > Probably a race in xdp dispatcher setup or the way cgroup-lsm
> > > logic is doing it.
> >
> > Managed to repro it by hacking the C reproducer to attach bpf prog
> > to /sys/fs/cgroup instead of syzkallers custom path. Will try to
> > poke it a bit more..
>
> Stan, did you get anywhere? Please share your hack, where you manage
> to reproduce the issue.

Yes, I think the problem is more naive. The syszbot reproducer manages to a=
ttach
cgroup_skb program to a cgroup_sockopt hook :-/. I'll try to send a
patch this week
to fix it (need to write a proper selftest as well).

> Cheers,
> Bj=C3=B6rn

