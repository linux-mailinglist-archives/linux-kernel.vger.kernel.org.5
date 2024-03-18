Return-Path: <linux-kernel+bounces-106619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3187F10D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A011C220E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA675786A;
	Mon, 18 Mar 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhnQYmor"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A424AEF5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793081; cv=none; b=N725BEBRgXFqT6p7q5B9ApBcpYsWgXUDdETLWUaH0cyGYsKxPA/JFCwKkEUhtRFfYb5L3J514YzH3gsbsH2R/QjaLY+93ENHHeUPLRTREi2POdpN+RnWBI8TePRKWAF8xP/MgUm6Cuw7GU4iiMGn6pIeGkz0NE8yJ56xzfcm798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793081; c=relaxed/simple;
	bh=hjN0l13EXFwYl+Fi46xsFRR8nXeuW1SbIcm0c4xTl/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTWWcom25KpNR2WfaOQCw9IaevEvSbHDvQUDRicA0J9ZyO0ppFhgDTm0iZUoZYy0IlOXTuN4BSGJ+/fsxv2QrHUxa1N94vc0Jy5CRA69fpzZuuFxC8OwOSiF0h2q7yb2T4GbA4nOBdHIqApHZgnhjusUsmF5KKXHIrt+SmJlQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhnQYmor; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d28051376eso78209261fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710793078; x=1711397878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yot0vG/EvXqiKrPizPMgdy7ntkGix/8bUop8nR7PDI=;
        b=YhnQYmor+H/vysnrZPT5thpTQ6+etoP5yhZQ+2XhfyoHhk1pHUXjvfOjtXh92XhzNy
         Xsat5oq6Ez9TDoXnG7fXOcyuH4CDj4fhUVWEkUkhxX5Sg+FLDKlQGT7/q+Fv1OavcVyQ
         85LhmlFucrXFFGpCCxp7qT1xJFXRbnb6rbi/T+T2VAF6Cay9EwS58OuKNyKUumG+57No
         +3ib2NWQ+ivA5VEfmgAfN6jgAdGaZEpF9bY4UJUGUMLarY4RV0U4LHBA2nbLHthDUVR8
         iZUZ9uH0j1CkD5MmHPDe09XzoSW0PuaIc9VxThBfBcrUb2hTekJ8B4c0g0WiutmUuXhs
         oQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710793078; x=1711397878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yot0vG/EvXqiKrPizPMgdy7ntkGix/8bUop8nR7PDI=;
        b=MesbZnHaHexhXLNL0gO0Z8pwOUgwSU737skQgT2NIgO7TwXo9j5nX9O4Y7TVTcwgS3
         qP1/FWk7y/d6XZd0I1yzqy9mN2jrai8GmkFMBnXY0qo1vKCG1p2x4nglMGra5mht13ft
         a/q3B6KOL9QM1IM1IO7IqcSX9o9O1BYVCkdB3nKwMfqOQMsumaX9NllXo54dvI8cMpl6
         jXMtTsJUcvb8QgnMi0BTbG9nZOKt6abl74IKLy9sMiUeaKOW8qlLi7nxy5/Ib42jaXnW
         ut1jkMjXUtHWFe1FTHUZMMc8AipEcG8CDINi97n8/81LsgqsjAlvNm+7MyYJbwtg2/Ts
         AiUA==
X-Forwarded-Encrypted: i=1; AJvYcCXujbcJ24xJyI1eVJz8jOTD2JErmSaa4IS4m3Et1f7AQQCMEU1Zlu08Ru4Mj3wmzVoagd4J7xX4SgwEFqo1cjXvligOHwyNgNkkJfBb
X-Gm-Message-State: AOJu0YxV80Em9Ta65/28Bdr6Z9o7/H+hWkhWwakAla5ybFXZJA86GiGw
	QTOhR/NYlHqX13hhDp2ggXCUJBbRESWg7HTVmUKe5iX5lYrIUoGDBo40l0xJlE5k6RrRowkOgzq
	xZWzQzds+BAiUxx1Xz+/YrI7VDUx2L9tCPoVN
X-Google-Smtp-Source: AGHT+IGluCNAxWphJY5oLf7BFcHLws0WcrzT30WgUrnw7Jkn1prWk0RP85ZHuA6LYv3BSHTdGTTpJral8jcNKEIrlhU=
X-Received: by 2002:a2e:84d7:0:b0:2d4:7373:2a5b with SMTP id
 q23-20020a2e84d7000000b002d473732a5bmr5882184ljh.47.1710793077757; Mon, 18
 Mar 2024 13:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
In-Reply-To: <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Mar 2024 13:17:19 -0700
Message-ID: <CAJD7tkbEuFkGuQeYjKS02rQoAAKOKieAJ1P2mwukirW3e2JN9A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Nhat Pham <nphamcs@gmail.com>
Cc: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-3=
6' ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043abe180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c23df=
fc38e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1588b=
7805de3
> > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d2311=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba7959180=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmli=
nux-e5eb28f6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add=
/zImage-e5eb28f6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/scatterlist.h:187!
>
> Looks like the provided buffer is invalid:
>
> #ifdef CONFIG_DEBUG_SG
> BUG_ON(!virt_addr_valid(buf));
> #endif
>
> which is "src" from:
>
> sg_init_one(&input, src, entry->length);
>
> Looking at the surrounding code and recent history, there's this
> commit that stands out:
>
> mm/zswap: remove the memcpy if acomp is not sleepable
> (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
>
> which has the effect of, IIUC, using the zpool mapped memory directly
> as src, instead of acomp_ctx->buffer (which was previously the case,
> as zsmalloc was not sleepable).
>
> This might not necessarily be a bug with that commit itself, but might
> have revealed another bug elsewhere.
>
> Anyway, cc-ing the author, Barry Song, to fact check me :) Will take a
> closer look later.

I am not a highmem expert, but the reproducer has CONFIG_HIGHMEM=3Dy,
and it seems like zs_map_object() may return a highmem address if the
compressed object is entirely in a single page to avoid copying to a
buffer:

if (off + class->size <=3D PAGE_SIZE) {
   /* this object is contained entirely within a page */
   area->vm_addr =3D kmap_atomic(page);
   ret =3D area->vm_addr + off;
   goto out;
}

The virt_addr_valid() check seems to indicate that we expect a direct
map address in sg_init_one(), right?

