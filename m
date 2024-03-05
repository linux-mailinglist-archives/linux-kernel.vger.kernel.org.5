Return-Path: <linux-kernel+bounces-91616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D07871442
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65966B228A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F123717D;
	Tue,  5 Mar 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIywen2I"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BB3CF4B;
	Tue,  5 Mar 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609330; cv=none; b=ZgP6+P835Wc59fgAorSfj21ri3p7wJ0oXiVoRgiI+ElxBhpt5H3vWSU0POjeOmO+l3Xh8XqXgemEqjb/1UDgpEZI5OnjnNxzlg+PwrxikhG2HxVSl8e2l8mIKFI2i5Qr5nHa2Adxa75z9JBItqjlBW0FlR2jndzZS0VWm0xAaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609330; c=relaxed/simple;
	bh=RMzA9rsJeXJ+NZUU8skMoi7MVTR2cmvx/sC1vW5T8zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNZKShuDxgsAMVmPcYIInKcfrKifENNgxIPRj1vMyoDoOOJRdih0IPCDJoRfRayj1hnXC1t4QePIXwGDHQomy1tgvCa/pdxF+GHCf9nR8IYY18kG6HRg1I2QjO08evcp3O9FHM3AOsYzQMy0AKNTwL9jNgOl+La1hsJxnKnhCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIywen2I; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a452877ddcaso232665566b.3;
        Mon, 04 Mar 2024 19:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709609327; x=1710214127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QJKuDK8BEZDzB9t4thrSaIr8oltYP1pSdpjVP1pzNg=;
        b=PIywen2IYpiVYbtuecQrlc+B6PnmdldC4TitlAWiIt7BLH8XRTnTdFFju4p6vF8g9p
         Md3ojoJfzKbsCaPRjmlfd/HLmXAoC3p/cCf/bdwMgLBZmro/EHJSoQjV8eg9a9uho2yz
         6tFPF2J5oua8ksAABkq/9RWgDXTf2fhR3kZeDxxakdTP18tcGIK/BUr/DDTloS6qIUAj
         gCsi3frigv0nbpzFTgrNTSJ18lZyerKTQmn2s7xgE1uL3uQEDup8GWEfIEPQ9SwFX3s0
         yXKxCI8/XhcMbvRuZzTE2wt0+ovhh1lG7YDeVB713brj5gb7YmTSuMknYHV+S0zmsJuB
         eGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609327; x=1710214127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QJKuDK8BEZDzB9t4thrSaIr8oltYP1pSdpjVP1pzNg=;
        b=L/6VaYWBf+36Fp16lNhbG9tsIeuWD1eev7YSSnh/MM1JERYfoob61zUIwjca5MP0jt
         lTSbAHU2Ppj/yx5zQybTn3dVQZF8Rz6MiL+gPeh/e15p5kvn+D5SHeeJP9UevMNW/CAA
         Z4aG6i1OJ6vQuzNsG8sSHuTq2hiujMbsbd/ja/zVtb7zBsKqzjaO+8mOYmDJyDw3p/nY
         f2kS/3WEE/IisiJMKmf/NELAXUxXBQVsxW5mhyA/z1xWvBekQVEp7gyghgXNFKSnlTA9
         bGx7RdHIIxNNSnH6aPIvKVsaKN/jjz1XqZKzmculL7agJF6HkJnrCUIRl7DfBj1yayu6
         E1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVg6wbv/aUxTyILOMPtwMugNqQL3foPFoZSIGiMvQiVhwGkDV0Lr1ldxAKFRPVvdxZBxvPdsJiBstoZ2UGd5DiW96ecLO9a1IeU4dik/7Kg0s14C8WiQkQtlWBrWnZTPa6f3X1vJQ==
X-Gm-Message-State: AOJu0Yx5xGbfIydTbn4pYb0P6M80kvNeWl8SCy4YI1mjQ6ap8wKOykHh
	gMdb1e0ZTpGFkNDxwfbuyuMpbw5NXUz9GBoGQlRlPLx0/pHlyPuMz8cz/sLwNGhjuTEkyt/v+ks
	pFcC9Nl0QwcxZFBVN+qpKEV7tlag=
X-Google-Smtp-Source: AGHT+IEDtonzYkx06LNLyN9IEWoJm1ngNQAo134vLqcwoy6xfOUTDb+TH4fHTgtYSUUQZsup/0uu0m8MAVS5NaKNknE=
X-Received: by 2002:a17:906:c294:b0:a43:fd9d:a64 with SMTP id
 r20-20020a170906c29400b00a43fd9d0a64mr6711404ejz.31.1709609327242; Mon, 04
 Mar 2024 19:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOh-5_KzWih=qUxynbn=mMz=UfnPi6UftbyT8+MTDP0jg@mail.gmail.com>
 <CAHC9VhQ3crxcLXbT3fw2k7jYJFKy1VOm25npKpD9ZrwmwKzvJw@mail.gmail.com>
 <CAJ2a_DcSurcF5_G-DjXL_0X=utasy2y8oJ_ywCms-Qhyy6GORQ@mail.gmail.com>
 <CAHC9VhQVqokvnnqLPc8tv0jpewnUKqnWeAzQs-sMj3BLrY5=CA@mail.gmail.com>
 <CAEkJfYOTNdu2rK-7F58sg7XuYk+trdGDBjYo-y0SusxmSeCkFA@mail.gmail.com> <CAHC9VhS=izWYH7uaFcF9vre3GF06FitLXj0uUOKzMAwvq29OEw@mail.gmail.com>
In-Reply-To: <CAHC9VhS=izWYH7uaFcF9vre3GF06FitLXj0uUOKzMAwvq29OEw@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 5 Mar 2024 11:28:35 +0800
Message-ID: <CAEkJfYP6jG5c5Ng4P1=QL_MVXT+5GJy_LTQUxnwQ0Peqo2v7-Q@mail.gmail.com>
Subject: Re: [Bug] WARNING: zero-size vmalloc in sel_write_load
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-kernel@vger.kernel.org, "xrivendell7@gmail.com" <xrivendell7@gmail.com>, 
	syzkaller@googlegroups.com, selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Mar 4, 2024 at 9:32=E2=80=AFPM Sam Sun <samsun1006219@gmail.com> =
wrote:
> > On Tue, Mar 5, 2024 at 4:45=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Mon, Mar 4, 2024 at 3:11=E2=80=AFPM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > > On Mon, 4 Mar 2024 at 20:19, Paul Moore <paul@paul-moore.com> wrote=
:
> > > > > On Mon, Mar 4, 2024 at 9:08=E2=80=AFAM Sam Sun <samsun1006219@gma=
il.com> wrote:
> > > > > >
> > > > > > Dear developers and maintainers,
> > > > > >
> > > > > > We encountered a warning in function sel_write_load(). It is te=
sted on
> > > > > > kernel 6.8.0-rc7. Bug report is listed below.
> > > > > >
> > > > > > ```
> > > > > > WARNING: CPU: 1 PID: 8109 at mm/vmalloc.c:3247
> > > > > > __vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > > > > Modules linked in:
> > > > > > CPU: 1 PID: 8109 Comm: syz-executor370 Not tainted 6.7.0-rc7 #1
> > > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.1=
5.0-1 04/01/2014
> > > > > > RIP: 0010:__vmalloc_node_range+0x10a0/0x1490 mm/vmalloc.c:3247
> > > > > > Code: 65 48 2b 04 25 28 00 00 00 0f 85 98 02 00 00 48 81 c4 70 =
01 00
> > > > > > 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 71 43 b7 ff 90 =
<0f> 0b
> > > > > > 90 45 31 e4 eb a1 e8 63 43 b7 ff 48 8b 4c 24 40 31 f6 45 31
> > > > > > RSP: 0018:ffffc90002adf9c0 EFLAGS: 00010293
> > > > > > RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81cdc1=
94
> > > > > > RDX: ffff888022124ec0 RSI: ffffffff81cdd16f RDI: 00000000000000=
07
> > > > > > RBP: 0000000000000000 R08: 0000000000000007 R09: 00000000000000=
00
> > > > > > R10: 0000000000000000 R11: 0000000000000001 R12: ffff888107373a=
48
> > > > > > R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90002adfe=
c8
> > > > > > FS:  00005555560953c0(0000) GS:ffff888135c00000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000020000010 CR3: 000000010503d000 CR4: 0000000000750e=
f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> > > > > > PKRU: 55555554
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __vmalloc_node mm/vmalloc.c:3385 [inline]
> > > > > >  vmalloc+0x6b/0x80 mm/vmalloc.c:3418
> > > > > >  sel_write_load+0x27f/0x19d0 security/selinux/selinuxfs.c:603
> > > > > >  vfs_write+0x2a9/0xd80 fs/read_write.c:582
> > > > > >  ksys_pwrite64 fs/read_write.c:699 [inline]
> > > > > >  __do_sys_pwrite64 fs/read_write.c:709 [inline]
> > > > > >  __se_sys_pwrite64 fs/read_write.c:706 [inline]
> > > > > >  __x64_sys_pwrite64+0x1f3/0x250 fs/read_write.c:706
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> > > > > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > > > > RIP: 0033:0x7f40e7728f8d
> > > > > > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 =
f8 48
> > > > > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 =
<48> 3d
> > > > > > 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > > > RSP: 002b:00007fff5bf39508 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000012
> > > > > > RAX: ffffffffffffffda RBX: 00007fff5bf39708 RCX: 00007f40e7728f=
8d
> > > > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
03
> > > > > > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff5bf397=
08
> > > > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000000=
01
> > > > > > R13: 00007fff5bf396f8 R14: 00007f40e77a6530 R15: 00000000000000=
01
> > > > > >  </TASK>
> > > > > > ```
> > > > > >
> > > > > > The cause of this bug is that in sel_write_load(), parameter "c=
ount"
> > > > > > is controlled by user, which could be zero. It is passed to vma=
lloc()
> > > > > > as an argument.
> > > > > >
> > > > > > If you have any questions, please contact us.
> > > > > > Reported by: Yue Sun <samsun1006219@gmail.com>
> > > > > > Reported by: xingwei lee <xrivendell7@gmail.com>
> > > > >
> > > > > Everything appears to be working as expected, vmalloc() caught th=
e
> > > > > zero-length allocation request, emitted the warning, returned NUL=
L to
> > > > > sel_write_load(), and sel_write_load() handled the error conditio=
n
> > > > > triggered by vmalloc(0) returning NULL.  Did you see any unexpect=
ed
> > > > > behavior beyond this warning message above?
> > > >
> > > > Probably because kernel warnings should not be reachable from
> > > > userspace ...
> > >
> > > My question was asking if the reporter was seeing any unexpected
> > > behavior *beyond* the warning message.  I wanted to make sure they
> > > weren't seeing anything else on their system that we should also take
> > > into account.
> >
> > I didn't see any unexpected behavior beyond this warning message. You
> > are right, everything appears to be working as expected. Like
> > Christian said, I enabled kernel panic_on_warn config. I thought
> > kernel warning was something worthy to report, but I was wrong. In
> > future reports, I will check carefully to eliminate kernel warnings
> > like "vmalloc zero" and "page size alloc too large" if they don't have
> > unexpected behaviors. Sorry for wasting your time analyzing it, and
> > thanks for pointing out my mistake!
>
> Thanks for the quick reply, I just wanted to make sure there wasn't
> some other bug that was also triggered by passing a 0 count value; I'm
> glad to hear there isn't.  Regardless, there is likely some value in
> protecting against 0 count/size values and I just posted a patch to do
> just that (and some other misc cleanups to sel_write_load()).
>
> --
> paul-moore.com

Maybe I should compile the kernel without panic_on_warn config, so
that I can see how zero count / size values are passed through code
and check if there is another potential threat. Thanks for your
advice!

Best Regards,
Yue

