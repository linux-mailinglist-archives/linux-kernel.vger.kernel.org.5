Return-Path: <linux-kernel+bounces-62154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C516F851C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814EE282542
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8554D9E1;
	Mon, 12 Feb 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwQaXKJd"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CB4D599
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760543; cv=none; b=Iipxjsp96TSTsR/KHSoZbIFZm6NnlFnmqVopUWV6Sz6sqGYOa29FZoxJF8mW58VKjipfTIQzwhL9479dXxyVNDUVDMfSRkdzEaeUtET6BgXklCSgGJp6D2wsy5XPQysMw/vK1Tp+O4vLK8CJL87uApCKuFpspLiqAdvT8q8f9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760543; c=relaxed/simple;
	bh=AjfIG3FbrI4qj1C9ijHY/3PzoaLGAnDtnjc9YtoIDTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYh3ZsiCpDCsRd6y1ZDqlxc5JD96F6ZqcEBtvycelh+tlpXkMGZC6GRIJzlAgLTwHc9DhRTAG2FAtbwgVgg3rOsELC0tX+mDWkRQJ800OZIcjFvBC150HBCBexwMo59AtVt0fxSBSSHbZ4naAKOZbxoJakRblpSEUL17Ckx5E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lwQaXKJd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60492a2593fso32306207b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707760540; x=1708365340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibbf95D/DPxNHAmAmXw9pZ4Q4Pwc6N36L6CG1Igt1Yo=;
        b=lwQaXKJdF3CiP7ZprjHlR6Meh3r3VVXEl3OBBr+cTZTLf9KtF2CxTPijOwDguXN2/t
         PRbJSC1hHQKib/tIS4Jkr9aG1f6JFZgL+H8UeSPi7JCtMHdUX8un0OOjbNeBTsCnUsnn
         tvGfJxdQxr/zx9YWljtgJj9imycB0wTbAlTaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760540; x=1708365340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibbf95D/DPxNHAmAmXw9pZ4Q4Pwc6N36L6CG1Igt1Yo=;
        b=M7wWxp2n8c8kS2b+Xr5TDPlX84n6ni6NMAMm/ZOqEmKKmdQ4ymD9vmWIL+k2Cr76h5
         PJAOoTxfflXxwP17JepP5exIsa7cWUJszKcqHWZTncy2NRGx9vFcTczgarDW8FJVgtyW
         lWXETwQ8VQ9wvdNmrKdtx8XtGGe7FNjRzSqTiaVpkwmo/k9zCdqfEdr4bYeYCOWXp11h
         HYuuw3JaGB5kxr1Hgg1ZFtlCAI3NbPqeKxXOV/yAypvPP/mjhQ0uCh94i4VPTm4dK2ut
         AVFcEEbWVbfb2+LkTDv00xbRAb/ZEunNzZVbXBFnvSEfjBJFEtcUKnH1ODUUmYlAjyj5
         YKmA==
X-Forwarded-Encrypted: i=1; AJvYcCVGffomB5X8CvXWVOnEP4XIxDzqAoU3xRCCaSjChwjjhO4dR4nK4Y9kUuWhJ0j41amkVznttqPpj1nJ+2gT3vU+YEWONjVW39QTcdiL
X-Gm-Message-State: AOJu0YxuMnzX5FSBZqLuY0BuPYrZ8zRVr8SzYq3dn+Jf/4JNE3tjb9pX
	wthDhXoWRJ0XTs4SYzGvUQx1vu1t8g4zifpv6104I4pmb1b1Ned7eLc2vr2UyzbEL57ILNFd56H
	7hr68OGMNZi3Ml3Dl9wAgGJrCMFY+yIkaxDNc
X-Google-Smtp-Source: AGHT+IEa8+3Rwz7HkRgRqMMOinUlLUJ0s4XumoObAfVWOz8MaCs9O05SVXp7j5hJL3yG5M/pzTJzNCGmBX5TxQ0kXvs=
X-Received: by 2002:a0d:ed46:0:b0:607:74b2:578a with SMTP id
 w67-20020a0ded46000000b0060774b2578amr1421659ywe.6.1707760540308; Mon, 12 Feb
 2024 09:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209150657.1.I45addf7579e1233fa97c05ba72120cd1c57b4310@changeid>
 <202402091551.16A4A2A7F@keescook> <65ba51bc65b24c13af4ce02e79f78dee@AcuMS.aculab.com>
In-Reply-To: <65ba51bc65b24c13af4ce02e79f78dee@AcuMS.aculab.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Mon, 12 Feb 2024 09:55:29 -0800
Message-ID: <CANFp7mVm6QQ0+rm_VJ6MJbVDM+agyTd+5cEwE3EneSxS1-z70w@mail.gmail.com>
Subject: Re: [PATCH] minmax: Add notes to min_t and max_t
To: David Laight <David.Laight@aculab.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pmalani@chromium.org" <pmalani@chromium.org>, 
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Herve Codina <herve.codina@bootlin.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 4:04=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Kees Cook
> > Sent: 09 February 2024 23:56
> >
> > On Fri, Feb 09, 2024 at 03:07:02PM -0800, Abhishek Pandit-Subedi wrote:
> > > Both min_t and max_t are problematic as they can hide issues when
> > > comparing differently sized types (and especially differently signed
> > > types). Update the comments to nudge users to other options until
> > > there is a better fix for these macros.
> > >
> > > Link: https://lore.kernel.org/all/01e3e09005e9434b8f558a893a47c053@Ac=
uMS.aculab.com/
> > > Link: https://lore.kernel.org/all/CAHk-
> > =3DwhwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com/
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > > Andy Shevchenko made me aware of this particular footgun in
> > > https://lore.kernel.org/linux-usb/ZcZ_he1jYx8w57mK@smile.fi.intel.com=
/.
> > >
> > > While David + others work on the full fix, I'm hoping to apply a
> > > bandaid in the form of comments so the problem doesn't get worse by d=
evs
> > > (**cough** me **cough**) inadvertently doing the wrong thing.
>
> I'm not sure that adding a comment here actually helps.
> If you read it you probably know what is happening!
>
> With the changes I did (which I think got back-ported at least
> one release) it is actually moderately unlikely that you'll need
> to use min_t() or max_t() (and especially clamp_val() - definitely
> an accident waiting to happen).
>
> I think there is only one clamp_val() that can't just be replaced
> with clamp().
>
> I did post an updated set that really just reduce the generated
> line length - I probably need to report them to wake people up.
>
> > I think a better example for the docs would be something like u16
> > (rather than size_t) which shows very quickly the potential for
> > truncation. See, for example:
> >
> > https://lore.kernel.org/all/20230811054528.never.165-kees@kernel.org/
>
> (I'd found that one when I tried to build with min_t() being min().
> The bug was reported not long after!)
>
> Or an example using 'unsigned char' - there are some very dubious
> ones lurking.
>
> Also look at the code in tcp/udp that validates the length argument
> to getsockopt().
> It checks for negative after doing min_t(unsigned, len, 4).
> It has always been thus, well before min_t() was added.
>
> ...
> > >  /**
> > >   * min_t - return minimum of two values, using the specified type
> > > + *
> > > + * Note: Downcasting types in this macro can cause incorrect results=
 Prefer to
> > > + * use min() which does typechecking.
> > > + *
> > > + * Prefer to use clamp if you are trying to compare to size_t.
> > > + *
> > > + * Don't:
> > > + *   min_t(size_t, buf_size, sizeof(foobar))
> > > + *
> > > + * Do:
> > > + *  clamp(buf_size, 0, sizeof(foobar))
>
> I'm not at all sure that is actually helpful.
> It might be better to just note that min_t(unsigned type, int val, xxx)
> will convert a negative value to a large positive one.
>
> In you case size_t is just the wrong type.
> You need to change the type of the constant (to int) not the
> type of the variable.
> So you want:
>         min(buf_size, (int)sizeof(foobar))
>
> I'm not at all sure that min_t() (casting both args) is actually
> a good idea, requiring the codes explicitly cast one (usually only
> one needs a cast) is likely to be less buggy, more obvious, and
> less typing.
>
> I think min_t() exists because it is an exact replacement for
> a static inline function where the cast was implicit in the call.
>
> Linus didn't like the change that would allow:
>         min(int_size, sizeof(fubar))
> (ie implicitly casting unsigned constants to int before
> the compare.)
> It does make the defines rather more complicated.
>
> Thinking... it might me easier to add smin() (cf umin())
> that will convert an unsigned constant to int
> (and error for non-constant unsigned arguments).
> That would be much safer than min_t() and save all the extra
> complication min() would need, and also annotate the source.

I seemed to have somehow entirely missed umin and the static assert
you added as it does exactly the thing that I would want out of the
docs. https://lore.kernel.org/all/fe7e6c542e094bfca655abcd323c1c98@AcuMS.ac=
ulab.com/

I went back to my working tree (on 6.6) and rebased and I see the
following error:
  min(16, buf_size) signedness error, fix types or consider umin()
before min_t()

This works great! Thanks for adding this!

>
> A long term plan would be to remove all the min_t() and max_t().
> Sorting out some patches for simple cases (both args unsigned
> and the same size would be a start) isn't that hard.
> But they do need to get applied.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>

Please consider this patch closed/abandoned since
https://lore.kernel.org/all/fe7e6c542e094bfca655abcd323c1c98@AcuMS.aculab.c=
om/
is already merged.

