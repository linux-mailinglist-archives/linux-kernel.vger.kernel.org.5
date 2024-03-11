Return-Path: <linux-kernel+bounces-99138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07188783EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ADB281D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE294207B;
	Mon, 11 Mar 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIAENAAL"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012941C79
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171370; cv=none; b=AescSSiWoYxjxFjiOKnkkKhSGz9w/hIHvhxBB8+dVKj0YKoZe0ft+b+7w3+PS9jW6/bB+6kV2XjQtHGipv1zANgddorre51YTsjaiHkKoTm1nG3GhoUtKCeNiOLNXl0HnrMY3/QgOPogHnFI7ZkgC1NX9quri1kKElkPkWZ84mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171370; c=relaxed/simple;
	bh=+TFJGNd6gtuXyVSjKPNx6v7esE1qzyA/q0/YLIW3AUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrHzEQszgzBFx3mbtyjF7mocBAFuTt3snm6ugDu6j1WUNAQyfIx+zjOpyg2WMIDDugJQCPcHk0KZOXBCQTO+Bn2O3Ojs/IUixVTxUVsc7IoHQTwU1poytA/v1OAxNUeaRkjiz4ZaVl8nGf2gpspmBll9mnKITNDwcnutQasvLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIAENAAL; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4affeacaff9so702336e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710171367; x=1710776167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24qTNoLs6OcqX3v5jGkIQkQ7lTAMQ9f6UIdQZ2fHpP0=;
        b=KIAENAALQk4P9P7ryI6fFjmvnroDAtvAK2xb62phI1z+pamAQI0ih6CgqkMms76Bp0
         fDoGKNYEfPFjIRNnM/ZK0LSkXzl0VuakLrH8j6necoUzFhDDRDXC4TI+TYodsxHcawP9
         ZISi4mH/q7FPAyJxfz9jKOraI9FgxYouOcdw5E1Qv0bpcNxdXmvp90WVOeNGtM5cNWip
         DqoJDI72kNpgIXxsZutbC9KTRvvDzg+i01uv6hSg+WPSsguaqwb9SfoMArC0cuYUpdkZ
         KXW/Tf0khiM7tSX3S9hls/cB6h5knIdAhqLajxlBTtbG6s7CfAZheyTIms95l+rcQxo6
         7oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171367; x=1710776167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24qTNoLs6OcqX3v5jGkIQkQ7lTAMQ9f6UIdQZ2fHpP0=;
        b=NAlN9YeiXOWwC/RwoKNETef65xQfhPOEAzL2Mm54y0ZbR6m5OrjsBaGL8ZJ5J01IcZ
         6tkBqPS3XvXQz3nolqC+cYCJdXaBqPYxBygfbZxcRlnIv0CNSIiIdkem63qOLEsfmNxH
         +JH4DYO2apYXS3qi+xtMrd3dxgb5yy8XdteolBZYyYHgGfGRyiFoA47EkSLLVfThmH0a
         SBY6SRa04vTnpcfvaL0PppG+E1rviDIOZSzZpBI6//wn+Vk23s33DJ1WnU6EpHZbJKWy
         kESKndOrKvLq1HtKV4ig/jcgjLTzyXjy57XCXhFmzQ7PKZid6RqxB6JWYcOHTeE6oLgy
         C17g==
X-Forwarded-Encrypted: i=1; AJvYcCUlRhNY9A5pWUlRIY4bLULb6WAmnS23jQqmc5/8eZc6CfMziPY3/AwKjK9Y3m3L/gVrSCNxxYPBUXjqZIoJ/6m4n2OwDabRrRyctgmH
X-Gm-Message-State: AOJu0YxDbLeabGGoPNUN6GSAP30UR26Aa/3kM1tUHQK/hCS0D6Ffw5Py
	hWfglRm3oeiJ0NzTWurzBEcpOFU2Ux+OWf2KVo3fhfx1T7EdYYWxf3kjmGdeuheQFbK6r+PhF6Q
	NSP8iP7TsXOdV384RyCWlj+ZzOESDqcUVdcBF
X-Google-Smtp-Source: AGHT+IHotLlyMXwfOyIElaxvo0ldp7L63Jyp2BMKJO64eBDYWmVK2gGP51zDfyABuoDgg2TfQTqEHJvayFo3QqmLehw=
X-Received: by 2002:a05:6122:1896:b0:4d3:48b9:3c91 with SMTP id
 bi22-20020a056122189600b004d348b93c91mr3273186vkb.5.1710171367252; Mon, 11
 Mar 2024 08:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
 <20240228-arc-for-list-v2-2-ae93201426b4@google.com> <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me>
 <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com> <7976d136-3cf7-427d-a047-41c29d25ad32@proton.me>
In-Reply-To: <7976d136-3cf7-427d-a047-41c29d25ad32@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Mar 2024 16:35:56 +0100
Message-ID: <CAH5fLghFKVBucpLGEXQ9CdRZRreEhT+u8tPFi+A9-+CX9_Mz1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 4:15=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 3/11/24 10:03, Alice Ryhl wrote:
> > On Sat, Mar 9, 2024 at 2:02=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >>
> >> On 2/28/24 14:00, Alice Ryhl wrote:
> >>> +        // SAFETY: If the refcount reaches a non-zero value, then we=
 have destroyed this `Arc` and
> >>> +        // will return without further touching the `Arc`. If the re=
fcount reaches zero, then there
> >>> +        // are no other arcs, and we can create a `UniqueArc`.
> >>
> >> This comment is not explaining why it is safe to call
> >> `refcount_dec_and_test` on `refcount`.
> >> It dose however explain what you are going to do, so please keep it, b=
ut
> >> not as a SAFETY comment.
> >
> > I'll reword.
> >
> >>> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(ref=
count) };
> >>> +        if is_zero {
> >>> +            // SAFETY: We have exclusive access to the arc, so we ca=
n perform unsynchronized
> >>> +            // accesses to the refcount.
> >>> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_I=
NIT(1)) };
> >>> +
> >>> +            // SAFETY: We own one refcount, so we can create a `Uniq=
ueArc`. It needs to be pinned,
> >>> +            // since an `Arc` is pinned.
> >>
> >> The `unsafe` block is only needed due to the `new_unchecked` call, whi=
ch
> >> you could avoid by using `.into()`. The `SAFETY` should also be an
> >> `INVARIANT` comment instead.
> >>
> >>> +            unsafe {
> >>> +                Some(Pin::new_unchecked(UniqueArc {
> >>> +                    inner: Arc::from_inner(me.ptr),
> >>> +                }))
> >>> +            }
> >
> > The from_inner method is also unsafe.
>
> Ah I missed that, might be a good reason to split the block.
> It confused me that the SAFETY comment did not mention why calling
> `new_unchecked` is sound.

I don't mind splitting up the unsafe block into several pieces.

> > I think that using new_unchecked here makes more sense. That method is
> > usually used in the case where something is already pinned, whereas
> > into() is usually used to pin something that was not previously
> > pinned.
>
> I get your argument, but doing it this way avoids an unsafe function
> call. I think it would be fine to use `.into()` in this case.
> Splitting the unsafe block would also be fine with me.

If you are okay with splitting the unsafe block instead, then I prefer
that. I don't think avoiding unsafe blocks is always the best answer;
especially not when you're already using unsafe right next to it.

This reminds me of NonNull::new_unchecked(Box::into_raw(my_box)) vs
NonNull::from(Box::leak(my_box)). The latter is safe, but I don't
necessarily think that makes it the better choice. It's also important
that your code carries the right intent.

Another way to go around it could be to add UniqueArc::from_raw or
from_inner methods, as well as from_raw_pinned and from_inner_pinned,
and then use those here.

Alice

