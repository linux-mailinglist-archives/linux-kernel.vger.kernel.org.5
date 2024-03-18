Return-Path: <linux-kernel+bounces-106685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F387F1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB90A1F216CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25658222;
	Mon, 18 Mar 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCU4dwkg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3858136
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796773; cv=none; b=p6XSb8vmn+31Hv6rqkmzpqsnlQICHbKGr1Vm+YWy1rozksgmoaGPzpgzp1Jskbm0+tdMLphLy6A79HNy2sIqkt8/XFy+1ymLys6V+S9wY86p0YTfemMhPZB39pqDlftpXOqg9ebnNsKzEsLCUcHwEpe02/oP9sqAbnE/EyUClX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796773; c=relaxed/simple;
	bh=2YHPoaBQsYT0YkSAWvrUDogtcYPNLnmpMuPQ1F2h7q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKauv5w6JvUMDBnrMAb9qPSYTjiUSeyvs95e0fnXdTUt2rwTscJhitIVPgLE90z0OiI4UzSnx/tTVSr0zRpuMSy9sbCI1Rcy7OAmZQBpJwd1NqH5seHzFtdZLsYZBRxiYJ4aE8CJ0lYVWxCkU0xg1z3s/UmDATsqP2/3tf6fTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCU4dwkg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso232066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710796770; x=1711401570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k4g9Luo3bAdRb+VgV0WA5X8hJ3aXO3GEXSTe7Flz9U=;
        b=JCU4dwkg4KtiVMDdiOVd+9BcD0yMBZoCgNnWQLCTZyfn3hGUFLNLWHGWDWUYtaacMT
         Y0oprrMuFz/Ry7nc3bZQNCldm98WlazyKzDdmpM7C+Z00zdq/NOsvRuXCC1SgDfG+bJk
         K3WMBzqvar+gndfwRmrZEBhtkHDEKI/v6UbsKZmBdJO07GgKkXSwz5lUfAfxzixEQuIi
         0WoXGx3Wi45QJsKooayIHqRmHP7j92pNCFK5NBORqd4UU+5jHCSjkAclfxueEC0htQpt
         2Op76bXDeY1WAUCNGS9reSSgnMNtiKybSj/u1cTJ7iX6dzoW+pQEZYgFb8XSwkBmBuga
         rz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796770; x=1711401570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k4g9Luo3bAdRb+VgV0WA5X8hJ3aXO3GEXSTe7Flz9U=;
        b=e3elKZ6XPs+9EabygQITtfXAb9CD+CKsE9oKNEKW77hvyYxke9QWtyN/o2/yxywGv4
         YOaWMGcYRZOMmn4Cc8/7CUiXPo+TXzDcYnp0m06E6p1YHG6nMvrQfJhrIX3E3XVbLSsA
         Uqi8ZX9NmaeT8WxpOYdNZfXWt3IFAJz02i/rjhL/bHhgXUH33+zIm7Jsw7VWK93P812q
         mclwZDvB8vf92w3vJc+EdV7iFXauMon3ujllR4lDVQZOH5CheLqvn5XdnewAe9qYzoRs
         T1mCRWHNLXBFq8sJJVp+pTgsToV2aykz6K6dg9y5EjQ4atX8P3pNo+J3mSIZ9VvHQD0B
         ya9w==
X-Forwarded-Encrypted: i=1; AJvYcCUgXzJp9wPbrfhmg4BFSI2oTB3iU1wARySudrTrqGWeKcCNG/SItYNDshMbKWYHI9EpFrw/1m82NootrOmqw0G3UQuEEAM7nEZF9KTU
X-Gm-Message-State: AOJu0Yy8ykthkEXHhBl5sdfp8fOUNvqRTHWo3RfWuNC5INg91+ejnkFJ
	EfvJH+uKG1pnJpNDmBTnN7IQ29G/qMib6tzTcWcUy+FCr42WGIx3PqL8KgUanzGomxVCvktqxim
	f2FO3yKl1ATkQfOuY6hbWW2FcogixBNWK+y1D
X-Google-Smtp-Source: AGHT+IEqBcJlc9hk11QYxUUW3Tt+HncgIEKlWgi7wAcHPn1nVS0sddMMhyd9YD1iPGbupGFNo8jCUcOQlDuC3ema1Aw=
X-Received: by 2002:a17:906:168a:b0:a46:9985:b264 with SMTP id
 s10-20020a170906168a00b00a469985b264mr5879888ejd.62.1710796770210; Mon, 18
 Mar 2024 14:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com> <20240318210917.GA4210@cmpxchg.org>
In-Reply-To: <20240318210917.GA4210@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 14:18:51 -0700
Message-ID: <CAJD7tkZhCt_r1uULbfe4eg=zo7=o7muJ787wyEw1yN7x+ijYGA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:09=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Mar 18, 2024 at 01:17:19PM -0700, Yosry Ahmed wrote:
> > On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-=
09-36' ..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043ab=
e180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c=
23dffc38e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1=
588b7805de3
> > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GN=
U ld (GNU Binutils for Debian) 2.40
> > > > userspace arch: arm
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d=
231180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba795=
9180000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/=
vmlinux-e5eb28f6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b=
4add/zImage-e5eb28f6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > kernel BUG at include/linux/scatterlist.h:187!
> > >
> > > Looks like the provided buffer is invalid:
> > >
> > > #ifdef CONFIG_DEBUG_SG
> > > BUG_ON(!virt_addr_valid(buf));
> > > #endif
> > >
> > > which is "src" from:
> > >
> > > sg_init_one(&input, src, entry->length);
> > >
> > > Looking at the surrounding code and recent history, there's this
> > > commit that stands out:
> > >
> > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > >
> > > which has the effect of, IIUC, using the zpool mapped memory directly
> > > as src, instead of acomp_ctx->buffer (which was previously the case,
> > > as zsmalloc was not sleepable).
> > >
> > > This might not necessarily be a bug with that commit itself, but migh=
t
> > > have revealed another bug elsewhere.
> > >
> > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take =
a
> > > closer look later.
> >
> > I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=3Dy,
> > and it seems like zs_map_object() may return a highmem address if the
> > compressed object is entirely in a single page to avoid copying to a
> > buffer:
> >
> > if (off + class->size <=3D PAGE_SIZE) {
> >    /* this object is contained entirely within a page */
> >    area->vm_addr =3D kmap_atomic(page);
> >    ret =3D area->vm_addr + off;
> >    goto out;
> > }
> >
> > The virt_addr_valid() check seems to indicate that we expect a direct
> > map address in sg_init_one(), right?
>
> If the page is highmem, kmap_atomic() establishes a temporary mapping
> to it in the direct map, such that we have a legit kernel pointer to
> the memory. Otherwise the memcpy() in zswap also wouldn't work... Am I
> missing something?

IIUC kmap_atomic() establishes a mapping in the kernel portion of the
address space, but not a direct map mapping (i.e. not a linear
mapping), right?

Does virt_addr_valid() check for addresses being in the kernel portion
of the address space, or it being a linear mapping? I thought it
checks for the latter.

