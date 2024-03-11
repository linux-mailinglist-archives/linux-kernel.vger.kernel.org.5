Return-Path: <linux-kernel+bounces-99149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F6878417
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47ED1C2154A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E735143AD8;
	Mon, 11 Mar 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Qt71fEwr"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3F3FE52
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171938; cv=none; b=uFXlWd08cR3vWdj+iXvde8OEEvVhq3w2jVrucVDit+XslVNmBO1OP98xPvPkiP4in4F9SBCLn325+v9odizIDe29Rqk6d3icgMBZIWzDb5IC9NiLuAox08eb+UOJl+cfa7WtrpAe9ze4opgx2dxsjMOFY/8exmnssyybO/KFOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171938; c=relaxed/simple;
	bh=YmWvNHgeoO2qUzlr8oO4c0XpZFyXwaKL14GKAp7jKoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajh+ZbTz5wZv3WyLvT/eNo3OBcBgEt3dQjaHJ1qWC1bWluOMPYUQB1cX/pxYzpWl6+IzWo0uCWkwLCFORmALLZGGq92PCbMYOLs/vUsgLvTOuGotefSxQnsgbe2KefGf19aNBXAzPK+3Xz09YB3Eh5SmM/AvYfAlmORf5wmD8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qt71fEwr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4726608233fso398465137.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710171935; x=1710776735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7l2H+uWp5+4ryc+ja7QawCO/3D+Ky/JNQh3rE/M1g/E=;
        b=Qt71fEwrV4qrwIqxrLBAxnHllEFKqQlQhGsktENdh5UtHhs0IbQdwE7OAZQ1GAndZk
         tPvPDCmldNwrU5X1HN73ijgyqp9kECUN/hir6hfEpF8N+SideH2KC5PKf5vwMBkuboNX
         IDWQFjS1rkT7j2bseWT49rbJt2vedfCMQhPbJuFXBRofL5QjI/JQTIdgCRttXbonlCBd
         Qfb9PNp20e4Oi2UbbjJzoFNaHB/wC1+VUrZFtJXN+i/I1D3CcBg28k1tzq55PdidrIRU
         Wu5HQb0Tzt98VSi71RF4Wib8FHSn7UGg0Awptx0dcCoJQLPvXYLkoLOD+DsgVrvjI7rO
         BnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171935; x=1710776735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7l2H+uWp5+4ryc+ja7QawCO/3D+Ky/JNQh3rE/M1g/E=;
        b=TGyd+1xEo4s/yrdYMdvJEtUH25N59aNKpuA0urkNh0Jmh26HOUIS2KaS4RyRXYIXSx
         aXnlglRYBBnyLTamo+OeQAnZZM4sbM031ONI+Dt8o49xFgxmT5yEbGiCvI548PLdMpaE
         Q/nxGkNVdNrepGd8PjBSMc+GR/KuxVrOyLkMDWcFuM7kAAheQ/GgD6ZNx/8WCIWN70Mw
         2bgImJZVYL2ah8lHpKpwhINTlnKaiAUxWg2kdpH9sejw8OIYm/Bq5zJVEAXwhZWDW6RU
         ynPteQLlH4QzY/KpftI1y3FRRLoJq2j2SoWraG1vK81+XgBUywqsgj8qMD3RE3TTm1Az
         rNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4YoJhVrc5hrgTi+87c7vewJsGt/VhsgfKI92IMtpYmi6ZKlCfkfMBejMfg9zvVBamc1Ycyy0hvp6VwhERL/FTPUUe0gvkULSgtod
X-Gm-Message-State: AOJu0Yy9EVRSdW7L9lr8KVZbVyqEjCuiHXKH+FKM92HAjV3+/dqqQZbM
	jArl17pKHklFOmeUxYHhJPWPED3KFrfjWztrQQGwndhm7nwHoiiyLa7Qx1iTOKppn8OtCHRLGYQ
	cpQO5J0unoUFrm7IN+ZxixcfrQR1YszICBb+Q
X-Google-Smtp-Source: AGHT+IGbHcSwV0tp9Z7u5q5TuD4gz3pUF9aDonvWzWjiUCNh9u+14/r0E4UHD8HP+FDgq/qNj2CrunBmD3+cpXAD0XI=
X-Received: by 2002:a05:6102:3b8b:b0:473:2d92:dd4f with SMTP id
 z11-20020a0561023b8b00b004732d92dd4fmr2346249vsu.26.1710171935231; Mon, 11
 Mar 2024 08:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
 <20240228-arc-for-list-v2-2-ae93201426b4@google.com> <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me>
 <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com>
 <7976d136-3cf7-427d-a047-41c29d25ad32@proton.me> <CAH5fLghFKVBucpLGEXQ9CdRZRreEhT+u8tPFi+A9-+CX9_Mz1w@mail.gmail.com>
In-Reply-To: <CAH5fLghFKVBucpLGEXQ9CdRZRreEhT+u8tPFi+A9-+CX9_Mz1w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Mar 2024 16:45:24 +0100
Message-ID: <CAH5fLgj-CH+DmvUjPe2Kacs6QQUQ0qj8ctFrx_jjJg-w1Xrc_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 4:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Mar 11, 2024 at 4:15=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
> >
> > On 3/11/24 10:03, Alice Ryhl wrote:
> > > On Sat, Mar 9, 2024 at 2:02=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> > >>
> > >> On 2/28/24 14:00, Alice Ryhl wrote:
> > >>> +        // SAFETY: If the refcount reaches a non-zero value, then =
we have destroyed this `Arc` and
> > >>> +        // will return without further touching the `Arc`. If the =
refcount reaches zero, then there
> > >>> +        // are no other arcs, and we can create a `UniqueArc`.
> > >>
> > >> This comment is not explaining why it is safe to call
> > >> `refcount_dec_and_test` on `refcount`.
> > >> It dose however explain what you are going to do, so please keep it,=
 but
> > >> not as a SAFETY comment.
> > >
> > > I'll reword.
> > >
> > >>> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(r=
efcount) };
> > >>> +        if is_zero {
> > >>> +            // SAFETY: We have exclusive access to the arc, so we =
can perform unsynchronized
> > >>> +            // accesses to the refcount.
> > >>> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT=
_INIT(1)) };
> > >>> +
> > >>> +            // SAFETY: We own one refcount, so we can create a `Un=
iqueArc`. It needs to be pinned,
> > >>> +            // since an `Arc` is pinned.
> > >>
> > >> The `unsafe` block is only needed due to the `new_unchecked` call, w=
hich
> > >> you could avoid by using `.into()`. The `SAFETY` should also be an
> > >> `INVARIANT` comment instead.
> > >>
> > >>> +            unsafe {
> > >>> +                Some(Pin::new_unchecked(UniqueArc {
> > >>> +                    inner: Arc::from_inner(me.ptr),
> > >>> +                }))
> > >>> +            }
> > >
> > > The from_inner method is also unsafe.
> >
> > Ah I missed that, might be a good reason to split the block.
> > It confused me that the SAFETY comment did not mention why calling
> > `new_unchecked` is sound.
>
> I don't mind splitting up the unsafe block into several pieces.
>
> > > I think that using new_unchecked here makes more sense. That method i=
s
> > > usually used in the case where something is already pinned, whereas
> > > into() is usually used to pin something that was not previously
> > > pinned.
> >
> > I get your argument, but doing it this way avoids an unsafe function
> > call. I think it would be fine to use `.into()` in this case.
> > Splitting the unsafe block would also be fine with me.
>
> If you are okay with splitting the unsafe block instead, then I prefer
> that. I don't think avoiding unsafe blocks is always the best answer;
> especially not when you're already using unsafe right next to it.
>
> This reminds me of NonNull::new_unchecked(Box::into_raw(my_box)) vs
> NonNull::from(Box::leak(my_box)). The latter is safe, but I don't
> necessarily think that makes it the better choice. It's also important
> that your code carries the right intent.
>
> Another way to go around it could be to add UniqueArc::from_raw or
> from_inner methods, as well as from_raw_pinned and from_inner_pinned,
> and then use those here.

After looking at the code, I've changed my mind. I will write it like this:

Some(Pin::from(UniqueArc { inner: ManuallyDrop::into_inner(me) }))

With an INVARIANT comment. Does that make sense for you?

Alice

