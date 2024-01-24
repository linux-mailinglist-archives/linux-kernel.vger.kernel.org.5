Return-Path: <linux-kernel+bounces-36813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18F83A72F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61755B29397
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9311AAB1;
	Wed, 24 Jan 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IApJ7drQ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593E1A286
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093295; cv=none; b=mTUc3aFsO55xa5DWlqHYSlkZIlUNPDmA5lg0srVxXKD3aAl2ngS+OFb+IEnvr3igWVXIjDRxUZ/pNQUCroe8QOnNjSqMuPkOKLapBlfdB6YWrqkeV9CDTBPN20pI9pGbz/3XrLYwtaPf9B6ICNaxhBr7zaHEc1XhH2bePfYfx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093295; c=relaxed/simple;
	bh=vUYNgyEiiBGTAOVgJfsG/RvhaXLEgRGTV9YrpqQM93E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLUZ/ZL7pdGi8pNRwEqdzXh7EYhf0IaOW/J2zPnd1hvQdlDicDynH7IZR7Je6PcfBUSRN9xSr0HDn4pmJbSO0toMPJiV1ciix2wHp9INKSce1/QKsuJ8xv8Z2WVOMg6KQ+udH6bNWs6Rwv+IrJ+NSaQcQa3gzvJ3OGIdwH48LxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IApJ7drQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6818d263cb3so39271856d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706093292; x=1706698092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X39Ts6MX+MiqoaGcJ6Oz7csIP4OtBMZYPm9qrUenbDM=;
        b=IApJ7drQuzmIlJSEapY1e4i/2m3gtppl/DO81wEv2rahsftDKg5ku/nDYLyQgC0fkc
         ugWwmI/su2qadoktaClKNyDv4UrgJDr+aUhBMAhxTgm4NxVJGTqEGrudunGXk9eRHc5Q
         kPs/kXnPKverAsvj5hZw3m6Rn/QpTWDYYKK403D6QFVjOPuPugfoZoD75XZhizr3GDwt
         5c/v18u0Sp8c10dWgL6OSRVhYREt8Ln9Z4UqrWABMy1KccGoqZVG83DNLUe3jjw9UbZR
         pUDPTiNJnNv+7jKZgWoyNsPtfBKpeyzKuGXu8/mp1cc044L+dAfseV789OMDG7t9mDbN
         WX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093292; x=1706698092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X39Ts6MX+MiqoaGcJ6Oz7csIP4OtBMZYPm9qrUenbDM=;
        b=MI01bmoidiWZdo4U+afOG9GYgBLBGj/VZigRV10v/KILBNXXcT+aO0PdiUQTf+JBFK
         ddrJX+oH5+N9RT8Mjn+2Cky8n4N+PuV0A01Kjf8RRrtwge6W9BC6IDW1Vuesopm24Q3e
         ApRNVGVC0ss+aMVkoMYHG5nx3nTN31A18xtf6J7dZyPZ4wmPpPsy/kVQnlCcf9IGA8uz
         E3qfYK+3/upqYN5OKjDTcGFkQMFiTSIOCUJB9UgG+DUMozfnyPsgcl4V8kNZ+3Vp8iXZ
         YD/pTwLcFyvTAXbgjTuuTuwQY805CbnpWWO6kn0Z2jdot//BCqZ7pg5LsOIjFBATJy0o
         RTYg==
X-Gm-Message-State: AOJu0YwxvWJRPriYM7d90A8TCRv/w34wAQl3k/GQY91GQCrX26Io0V9d
	gMEBnfOSPQ64eKZqyzlD85C+jexPF9eFgyqP38JGzZR4p606Ww4CPY1foqVdjUsEhyQtx6mEWpF
	nXCP21K2EY+IRzQ2tIZK7l1pGBdWHY6Nlnrjk
X-Google-Smtp-Source: AGHT+IG/GIxnoyhhLGaRwHzJnw2CsYDhw/Wa9qcMoyzCYt60ApWQxGfmvif7M11I8JdtLap1q9TWl31q5SAh8dAPA98=
X-Received: by 2002:a05:6214:1d04:b0:682:85f5:f009 with SMTP id
 e4-20020a0562141d0400b0068285f5f009mr3313074qvd.130.1706093292445; Wed, 24
 Jan 2024 02:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fd588e060de27ef4@google.com> <20240102080315-mutt-send-email-mst@kernel.org>
 <20240104204531.GB954424@fedora>
In-Reply-To: <20240104204531.GB954424@fedora>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 24 Jan 2024 11:47:32 +0100
Message-ID: <CAG_fn=XmxeUePHFth5asQvHvo3=QSL4tB4yS5_3UVHWYJ=VRnw@mail.gmail.com>
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, bonzini@redhat.com, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Tue, Jan 02, 2024 at 08:03:46AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 01, 2024 at 05:38:24AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kerne=
l.org..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D173df3e9e=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6=
b901aa3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e384=
1ed075a42
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1300b4a=
1e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130b0379e=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4=
/disk-fbafc3e6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vm=
linux-fbafc3e6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4=
a4/bzImage-fbafc3e6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Hi Alexander,
> Please take a look at this KMSAN failure. The uninitialized memory was
> created for the purpose of writing a coredump. vring_map_one_sg() should
> have direction=3DDMA_TO_DEVICE.
>
Hi Stefan,

I took a closer look, and am pretty confident this is a false positive.
I tried adding memset(..., 0xab, PAGE_SIZE << order) to alloc_pages()
and never saw
the 0xab pattern in the buffers for which KMSAN reported an error.

This probably isn't an error in 88938359e2df ("virtio: kmsan:
check/unpoison scatterlist in
vring_map_one_sg()"), which by itself should be doing a sane thing:
report an error if an
uninitialized buffer is passed to it. It is more likely that we're
missing some initialization that
happens in coredump.c

Does anyone have an idea where coredump.c is supposed to be
initializing these pages?
Maybe there are some inline assembly functions involved in copying the data=
?

