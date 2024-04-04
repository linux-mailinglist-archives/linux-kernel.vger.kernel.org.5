Return-Path: <linux-kernel+bounces-131577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B888989AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B88528497E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24012A173;
	Thu,  4 Apr 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okxy2CJ6"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088211292FB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240067; cv=none; b=V/BXQZ3kuczYrmJduQvQAN1GdqZcW+6XcOQCHnjDh667o9rASQoBk+VTgVO7Q8tevTcskDVg52UlsHgjwmCNa24ElUStD0U2A2L+HzhCvID+Rnros2nAL2gIWe5HVUJ37gyvPA3+dKx4RF4wtG+y/lDxOkyLu3Qh1eaQzSohSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240067; c=relaxed/simple;
	bh=wPNv0rAK4gkp3iAr/PUWZQQ3gdHika88yZSnlZ8mFvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUxg2M8Sfllu1T1o5xum249ijTH0LEf2dswK+zZ21GFhpd9dxYZUdRurUKfB7SYAfGs8uaOZrXYPImcrjXHtS29g7nRBAo72pSyH2UK/4P+FxSSQ5bkyE3zeOUAJYvJUMhGSZ9AcYIIV1bt2do8d64c813ZQxgSoHUuaq/vRXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okxy2CJ6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6157c30fbc9so10648087b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712240065; x=1712844865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThTdXKBRbeKtfvxTpWolYFeuiHKpOFysUOKZwvjPsjg=;
        b=okxy2CJ6E8ANDm6XcWeBcpjHXxBvRT+JcI391ITweCFOMARdfwi6DhCuJ7Lw1dtxou
         IMZAoI0j+1fX/qBKrMBNDSH/Kc52iHTN0k+Dj2BWoSW3izh9AiOVyQHhowK1jABkg080
         iYNZZ3PqSDtjnOhL3TWZIkOEv7vpaEw7OTSCBiHYsJDd/eeJ8h/+/EA2iTa0RXAKitLy
         e1ddeovga09M+7bieiIAFMteTfNKgMpfkNoF1SjU+S6UTY0odYMN/4RoFSsI/4olRM+0
         Hr+yQTjZOM8Zc78I/oMWm5FgFI8UrDmv9iPVl0jSarmbn+CQLlyizAdyegUy/370So+i
         SuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240065; x=1712844865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThTdXKBRbeKtfvxTpWolYFeuiHKpOFysUOKZwvjPsjg=;
        b=ko1/BQW0o2zHr5ATtEWmtSMlVSYn2iLZJAyNWW+h7EYn8g3qKac0pbtiSZQOrspYIR
         m7tLIraXuXqxDIPBPT902X10geKLfdu4Pv0ctJaojBr5w7VLCRpPuVJrv7xpO5DHkCE3
         r0Y1mEDQoGmRgtXP6UXXHDysuA1tt8Y9f4+CciwnVj1h6MFzV6UcljPaHI1Hgqc+awzm
         vPgMdqpzuLnCz6wkvCFGorr3vFrhvZaMJKmINHZNTsMTZIdT1621mkmGzFLRLUXZ5mSS
         pIrbjf29hi/JX6zCOMM94SKookoHcNDrYkG22E9jcMOfCxUVCb78yw6kRfmksIoN2Csu
         TRnA==
X-Forwarded-Encrypted: i=1; AJvYcCWMVWuHfk/FJlQsUZ+zW5SItCD2ODk1nB4j6E46qGkbC8uaq3C0zxt5cB0+MN5LhmSwXncmyk44JyDTIEim3HOD2zX3rS62KSOkRFir
X-Gm-Message-State: AOJu0YwmM2VF/MZviPrWIHyzFyFtxef6+n2UGTLPcPNNac93TzbEZP08
	kbroUs+G2b6tFYFTBVIlhHZU563XuFBWtJyhRuuQVyPx/TjwGWHvPYbKqHmBhkovPVqubJP8cju
	IhoQQS0U3Rj3XL5CoKK05lRs3AWYp6qYaI7e2
X-Google-Smtp-Source: AGHT+IGDUpNqNE89JPxkJnDxFJf7/PVFTdmFLJF3gZOL+YcWNT1lfbQ0eNtc40hL79Zon1479pqusNFqd3fCHU1wudQ=
X-Received: by 2002:a81:a0c9:0:b0:608:ecd0:f894 with SMTP id
 x192-20020a81a0c9000000b00608ecd0f894mr2430209ywg.1.1712240064820; Thu, 04
 Apr 2024 07:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-2-b1c59ba7ae3b@google.com> <36306930-0390-4342-830d-03c11ec4a3a7@proton.me>
In-Reply-To: <36306930-0390-4342-830d-03c11ec4a3a7@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 16:14:14 +0200
Message-ID: <CAH5fLghHmuHxw1BL1F2-VF5KUXQLOwMqW6PfiAoLBXRE0Gyu=g@mail.gmail.com>
Subject: Re: [PATCH 2/9] rust: list: add tracking for ListArc
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:52=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I think the commit one-line description sounds a bit strange, how about
> "rust: list: add ListArc tracking strategies"?
>
> On 02.04.24 14:16, Alice Ryhl wrote:
> > @@ -33,19 +34,64 @@ pub trait ListArcSafe<const ID: u64 =3D 0> {
> >      unsafe fn on_drop_list_arc(&self);
> >  }
> >
> > +/// Declares that this type is able to safely attempt to create `ListA=
rc`s at any time.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that `try_new_list_arc` does not return `=
true` if a `ListArc` already
> > +/// exists.
> > +pub unsafe trait TryNewListArc<const ID: u64 =3D 0>: ListArcSafe<ID> {
> > +    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Re=
turns `true` if the
> > +    /// conversion was successful.
> > +    fn try_new_list_arc(&self) -> bool;
> > +}
> > +
> >  /// Declares that this type supports [`ListArc`].
> >  ///
> > -/// When using this macro, it will only be possible to create a [`List=
Arc`] from a [`UniqueArc`].
> > +/// When using this macro, you may choose between the `untracked` stra=
tegy where it is not tracked
> > +/// whether a [`ListArc`] exists, and the `tracked_by` strategy where =
the tracking is deferred to a
> > +/// field of the struct. The `tracked_by` strategy can be combined wit=
h a field of type
> > +/// [`AtomicListArcTracker`] to track whether a [`ListArc`] exists.
> >  #[macro_export]
> >  macro_rules! impl_list_arc_safe {
> >      (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untra=
cked; } $($rest:tt)*) =3D> {
> > -        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t=
 {
> > +        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {
>
> This change seems unintentional.

Will fix.

> >              unsafe fn on_create_list_arc_from_unique(&mut self) {}
> >              unsafe fn on_drop_list_arc(&self) {}
> >          }
> >          $crate::list::impl_list_arc_safe! { $($rest)* }
> >      };
> >
> > +    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
> > +        tracked_by $field:ident : $fty:ty;
> > +    } $($rest:tt)*) =3D> {
> > +        impl$(<$($generics)*>)? ListArcSafe<$num> for $t {
>
> Here you also want to access `ListArcSafe` via
> `$crate::list::ListArcSafe`.

Will fix.

> > +            unsafe fn on_create_list_arc_from_unique(&mut self) {
> > +                let me =3D self as *mut Self;
> > +                let field: *mut $fty =3D unsafe { ::core::ptr::addr_of=
_mut!((*me).$field) };
>
> I think we should also have `SAFETY` comments in macros.
>
> Also why can't this be done using safe code?:
>
>      let field: &mut $fty =3D &mut self.$field;

Not sure why. Probably a historical accident. Will change it to be safe.

> > +                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on=
_create_list_arc_from_unique(
> > +                        &mut *field
> > +                ) };
>
> Formatting? rustfmt gives me this:
>
>                  unsafe {
>                      <$fty as $crate::list::ListArcSafe<$num>>::on_create=
_list_arc_from_unique(
>                          &mut *field
>                      )
>                  };
>
> (maybe the `;` should be inside the `unsafe` block in this case?)

I can make the change, but rustfmt does not affect macros.

Alice

