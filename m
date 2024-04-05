Return-Path: <linux-kernel+bounces-132314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FA8992DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FCA1F24BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A44CA7D;
	Fri,  5 Apr 2024 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjvXmYhI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C56FDC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281496; cv=none; b=fxU1+NJVCQtVOqR9aFgCuqSsUckS4nRoOKSY7SbSx/Npun4Ll4fmGVB5qzz4ae52Yo0e7+xTF8nTzvgB+3HlCsbXbrdPXbQfwpxEY0QWkNdwK1V4YRHOCe6ukqbThfIXk6g5iYuIs3PHD7xC709f50RllOtNV/lbFCJVkIklgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281496; c=relaxed/simple;
	bh=Xepmayyzx+BrYwLfi4PTyaYuTe8X0qkhDxMdO5rQ50w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nns2CB90O0IYH7J+KbQP/Vp22whjaDRG7zpuHECRmkTBRHluE7qaiB7FKIAQVDaJW0ci49Kq7nYpJIXXIRPSr1BDAfI887xOWQO45RTABPoq5e9FHbJ6ZAFaSoe5T0BR1E3vVXV0pbxQlRPrcf1pxo/92JRJjU9nPioIMYQxeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjvXmYhI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41549a13fabso22685e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712281492; x=1712886292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v4H4iPqjB8TunHOy2slwnPiBChxNL6+GU28qrAJ2tc=;
        b=EjvXmYhImWnTHg31T+t52GUzd7/lmuXbCWidHSXWV6VceZFeVi89liWgDnMyGQuNgw
         xAXn8tTwFv/hYBHnnApjxQsoQtDwfAKOaggLDlLpwEgL5cbuTryPLfrJumk8ng93hb7s
         FiG2GMUOPUVBbibh95Ws2AIsOfAvMYuqU1ZOoBp8sf2dxLp1kE98nuPqChKfQqLDmtWl
         eU0SdurvqGmRf1fe/9Cy1CpxhPPajMrvbWh3OzG4o2/Hif9jvpWtg4zB1aI3eXLZFy6l
         UuBmh0xoVDaGGj5PKbrgG3BViqvYsT8+A7PY2bit2iJA+/VTnTs/JHJBdphoq/0oKIRJ
         y5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712281492; x=1712886292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v4H4iPqjB8TunHOy2slwnPiBChxNL6+GU28qrAJ2tc=;
        b=K+QtZAeVsoh9GXMyDB3xCnusMiLagbCgy3G74agAuC2P23MAUV1ABcNV7B2EFCggme
         JI0TG45Qo/hb0/5dlGRaIghMzWFf/6bGPiwG7YIKOqp4t/7OE3hd7Xf3cDXoJ5oS6kxR
         NxrIo9WghYflAVQQbMHnpB5qbZdejtD+L/LNSGI9oxpjcp7Mvbjy8Z6lN7ExC3HZmz6g
         k2EDeRoQo9a7eDsA+tIwM2dlvtIHtuTZQMVQ2myGTG3Y2JWWV3i0ei+OphTta30HT1hG
         ymsXfPk9/jOI+SOhXVMMQg/EaJkX4+RIqDhxUWPvyXvEPkc+m8ulVuT62aWLUMpEDnLY
         xffQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDuWEkDgZqZc+1KH75DmzaoXuOX5UOUrmD/JvX/01xt9Lh0YfoVhPNFa7CRLtt8wV3YjrMFeB6uyFrPOkxp7m1+kTldmarwMyKHeRu
X-Gm-Message-State: AOJu0YwqIrLvvNWH/c+4EaVxI2ay92vzhicK8jD5W+gQkO202Fe71DPC
	y+Suc/d+ucHuzdSGeaoivCp52snWzRm/XMaEmtXKuvroJqgzxi8RXG2l+BKjJmD3i6umSjojOTO
	Hd9DhldSdaP4kbv0CwrxgtGCTUsNIL80vG4Z4
X-Google-Smtp-Source: AGHT+IGNzIkQ++HioHaYuqE7uw4+4B36YZSB6w3+Tg0LxaP/dZ3YAvcMaWHCFpEbt6RAzkDLWFaYIQaBqhYgu/NfxDo=
X-Received: by 2002:a05:600c:5125:b0:414:daa3:c192 with SMTP id
 o37-20020a05600c512500b00414daa3c192mr258752wms.0.1712281492429; Thu, 04 Apr
 2024 18:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007545d00615188a03@google.com> <20240403180752.f95e1b77e033b5e03164c160@linux-foundation.org>
 <CAJD7tkakCEg9zkwCrBr8GyObO7b9KOD6rUgyqniFN+YTCePd0A@mail.gmail.com>
In-Reply-To: <CAJD7tkakCEg9zkwCrBr8GyObO7b9KOD6rUgyqniFN+YTCePd0A@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 4 Apr 2024 21:44:14 -0400
Message-ID: <CAOUHufZPLEmrh0x43k2ysqvwYwEotGk8Bw=fwyO9aLXXv0aM9Q@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in __mod_memcg_lruvec_state
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	syzbot <syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Apr 3, 2024 at 6:08=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Tue, 02 Apr 2024 01:03:26 -0700 syzbot <syzbot+9319a4268a640e26b72b@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.ke=
rnel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15fd40c51=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df64ec427e=
98bccd7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9319a4268a6=
40e26b72b
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/7bc7510fe41f/non_bootable_disk-317c7bc0.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/efab473d72c0/vm=
linux-317c7bc0.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/5ba3f56d36=
2d/bzImage-317c7bc0.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 30105 at mm/memcontrol.c:865 __mod_memcg_lruvec_=
state+0x3fa/0x550 mm/memcontrol.c:865
> > > Modules linked in:
> > > CPU: 0 PID: 30105 Comm: syz-executor.2 Not tainted 6.9.0-rc1-syzkalle=
r-00178-g317c7bc0ef03 #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debia=
n-1.16.2-1 04/01/2014
> > > RIP: 0010:__mod_memcg_lruvec_state+0x3fa/0x550 mm/memcontrol.c:865
> > > Code: 45 85 e4 75 1d 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc =
cc cc cc b8 00 04 00 00 e9 80 fd ff ff 89 c6 e9 a0 fd ff ff 90 <0f> 0b 90 e=
9 a7 fc ff ff 48 c7 c7 18 43 e1 8f e8 32 51 f8 ff e9 5e
> > > RSP: 0018:ffffc900034beef8 EFLAGS: 00010202
> > > RAX: 0000000000000292 RBX: 0000000000000001 RCX: 1ffffffff1fc2863
> > > RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024b92bc8
> > > RBP: ffff888024b92000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > > R13: ffff88801c326000 R14: 0000000000000001 R15: ffff888024b92000
> > > FS:  00007f0811bf96c0(0000) GS:ffff88806b000000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000000000cfff1dd CR3: 000000003e4e2000 CR4: 0000000000350ef0
> > > DR0: 0000000000000031 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  __update_lru_size include/linux/mm_inline.h:47 [inline]
> > >  lru_gen_update_size include/linux/mm_inline.h:199 [inline]
> > >  lru_gen_add_folio+0x62d/0xe80 include/linux/mm_inline.h:262
> > >  lruvec_add_folio include/linux/mm_inline.h:323 [inline]
> > >  lru_add_fn+0x3fc/0xd80 mm/swap.c:215
> > >  folio_batch_move_lru+0x243/0x400 mm/swap.c:233
> >
> > Well it beats me.  I assume we failed to update for a new case.  I'll
> > toss this into -next to perhaps shed a bit of light.
> >
> > --- a/mm/memcontrol.c~__mod_memcg_lruvec_state-enhance-diagnostics
> > +++ a/mm/memcontrol.c
> > @@ -860,10 +860,12 @@ void __mod_memcg_lruvec_state(struct lru
> >                 case NR_ANON_THPS:
> >                 case NR_SHMEM_PMDMAPPED:
> >                 case NR_FILE_PMDMAPPED:
> > -                       WARN_ON_ONCE(!in_task());
> > +                       if (WARN_ON_ONCE(!in_task()))
> > +                               pr_warn("stat item index: %d\n", idx);
> >                         break;
> >                 default:
> > -                       VM_WARN_ON_IRQS_ENABLED();
> > +                       if (VM_WARN_ON_IRQS_ENABLED())
> > +                               pr_warn("stat item index: %d\n", idx);
>
> Line 865 from this commit should be this warning (i.e. warning because
> IRQs are enabled). This also makes sense because __update_lru_size()
> should not be updating any of the above stats.
>
> folio_batch_move_lru() in the above call stack should be acquiring the
> lock with IRQs disabled though, so I am not sure what's going on from
> a quick look.
>
> Adding Yu Zhao here.

Probably an RT build where _irqsave doesn't disable IRQ?

