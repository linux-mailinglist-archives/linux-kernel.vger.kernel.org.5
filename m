Return-Path: <linux-kernel+bounces-110104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76F885A11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA96B21FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8083CBD;
	Thu, 21 Mar 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN4BfZDq"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA483CD3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028586; cv=none; b=rSOPJshaXDC5vWf0JY83uWxoMRbawzGDC1d6mRk0vU2d1pzgiJ/6jhJj1uQJR/XOFXC1T5Unb6bR8jlj4/6XuZmszeQRge9SoZBq9FMTFD7X55rOkC2nWION62YAmg6NAc9kKHLO/5bmEDsfYjmr6h+l6+5fEpVhqLxNK5VD7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028586; c=relaxed/simple;
	bh=Glii2nHLfaBzdSZO2EKVirfpspWb+nv9s2Bi5rvMmyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMlJg9/5aYHwYWGvOelYRLTR5u/QlAFZELXV/dot2DeKmkRuOpAMpOXHxGTVErM8l/s2WaMt6cvdBr5lfCsov/Ck6r+2Yf6vHPDLGrNlXDXS+G7YIxJJjYH+kXkz90AvEnA9hzKkeo+tkoookE5pZ4L03w9/AawwA0viF2AUF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GN4BfZDq; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4767347552bso640747137.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711028584; x=1711633384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vO+ESJOepqx5jEo9fnNt4JlqMEXC9syS7LVjRc4fMA=;
        b=GN4BfZDqlr1aZNG6VZB9igAvDFeCJ/mxOdKifLN0jqPHQJLtoKtqIu4cqzrCW+dhR3
         +kOImPBgZm3bYlphGQsjx3sWigI710oCWWBfZAA4PcXkKN3bJWcfSgBTdxnqoMtUwkql
         jPaLbYHmQzb87KmgmjNwRyhcUd0l0w/U/YVfAwbRg0GRFCwjXhw9FaqsmZ9UZ5NjJm40
         x6oRFeKRxBN3Y3MwcfxVbDNpmKZTGQxI3GiuWR4sJnBIFcF8LEfIG2w/tSXPVXMLwc3d
         BkkDQhITorI9JXR16+ENkjEcD0SDHrodmS8C/oqIzJCq9e/M/SZlcqismaQzejvIEIRP
         F6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711028584; x=1711633384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vO+ESJOepqx5jEo9fnNt4JlqMEXC9syS7LVjRc4fMA=;
        b=BoLTML/IKmshn2U9D7BfuZb81Vy2EfH8WUvpwo5BMbO/HABIulQp/GpuYBkscaowvj
         lq5Zrbxj3MIh9AJL5hUugL2HEdpJ7aih1wYgpvlGDHn90kgP61X9GjMs6/lWAgynjxyc
         b7T01zIT5eIyfGy4d4vKmP8Ii4Sky/pQ2dUvi0q+ECntBdhgHJ+1LuOAgBepuPszeqpY
         hIk6ei3fsqAUNrgrVy1Ua8jDW0T2h0rvi7JY/UX0KlYEzxQbjB2CODn7KzhwohUYyGUu
         /6WUW+xlQTK6/XPYMFfmauJTC+VoBwSEzjmNuEHCNdiETgmJ3nrmZvZB51envNu6zkPc
         x81A==
X-Forwarded-Encrypted: i=1; AJvYcCVgkIVOyP1AL9NFLUfxzwxLZecC0vmSIpCGC5bbExxE5CFTcY1lXX/aPL+yJqVSrsiCG9OYiaPOTv7cb0h2e6TCNPTDgTL5eSvbxobB
X-Gm-Message-State: AOJu0Yytw0xKivgv8HrsyW4jS8NALJr4xJwsfk7anPlzEx0ocv64edbE
	RerV0I+DvjbomOm/n09XFbneH4/hbRD28ifvI9bcEwDKE+QD2zbRl1Emc6GnoNzo/+XjAVYyFdh
	HBHW1iwqTEYZhqy43JmKF2nJ75n0Qs+JqCwLu
X-Google-Smtp-Source: AGHT+IFpF8BS4GfselaMHG+IryrYPtK57pw+o2yCIAHSrUdVDoy4xFzEjFVwLzlJP0+H8lVOFbL+cmq9d4teTS+XZZU=
X-Received: by 2002:a05:6102:3588:b0:476:c74a:1544 with SMTP id
 h8-20020a056102358800b00476c74a1544mr934771vsu.6.1711028583745; Thu, 21 Mar
 2024 06:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
 <20240320084630.2727355-1-aliceryhl@google.com> <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me>
In-Reply-To: <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Mar 2024 14:42:52 +0100
Message-ID: <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
To: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maco@android.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	surenb@google.com, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:16=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 3/20/24 09:46, Alice Ryhl wrote:
> >> On 3/11/24 11:47, Alice Ryhl wrote:
> >>> +/// A pointer to a page that owns the page allocation.
> >>> +///
> >>> +/// # Invariants
> >>> +///
> >>> +/// The pointer points at a page, and has ownership over the page.
> >>
> >> Why not "`page` is valid"?
> >> Do you mean by ownership of the page that `page` has ownership of the
> >> allocation, or does that entail any other property/privilege?
> >
> > I can add "at a valid page".
>
> I don't think that helps, what you need as an invariant is that the
> pointer is valid.

To me "points at a page" implies that the pointer is valid. I mean, if
it was dangling, it would not point at a page?

But I can reword to something else if you have a preferred phrasing.

> >>> +    /// Runs a piece of code with this page mapped to an address.
> >>> +    ///
> >>> +    /// The page is unmapped when this call returns.
> >>> +    ///
> >>> +    /// It is up to the caller to use the provided raw pointer corre=
ctly.
> >>
> >> This says nothing about what 'correctly' means. What I gathered from t=
he
> >> implementation is that the supplied pointer is valid for the execution
> >> of `f` for `PAGE_SIZE` bytes.
> >> What other things are you allowed to rely upon?
> >>
> >> Is it really OK for this function to be called from multiple threads?
> >> Could that not result in the same page being mapped multiple times? If
> >> that is fine, what about potential data races when two threads write t=
o
> >> the pointer given to `f`?
> >>
> >>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) =
-> T {
> >
> > I will say:
> >
> > /// It is up to the caller to use the provided raw pointer correctly.
> > /// The pointer is valid for `PAGE_SIZE` bytes and for the duration in
> > /// which the closure is called. Depending on the gfp flags and kernel
> > /// configuration, the pointer may only be mapped on the current thread=
,
> > /// and in those cases, dereferencing it on other threads is UB. Other
> > /// than that, the usual rules for dereferencing a raw pointer apply.
> > /// (E.g., don't cause data races, the memory may be uninitialized, and
> > /// so on.)
>
> I would simplify and drop "depending on the gfp flags and kernel..." and
> just say that the pointer is only valid on the current thread.

Sure, that works for me.

> Also would it make sense to make the pointer type *mut [u8; PAGE_SIZE]?

I think it's a trade-off. That makes the code more error-prone, since
`pointer::add` now doesn't move by a number of bytes, but a number of
pages.

> > It's okay to map it multiple times from different threads.
>
> Do you still need to take care of data races?
> So would it be fine to execute this code on two threads in parallel?
>
>      static PAGE: Page =3D ...; // assume we have a page accessible by bo=
th threads
>
>      PAGE.with_page_mapped(|ptr| {
>          loop {
>              unsafe { ptr.write(0) };
>              pr_info!("{}", unsafe { ptr.read() });
>          }
>      });

Like I said, the usual pointer rules apply. Two threads can access it
in parallel as long as one of the following are satisfied:

* Both accesses are reads.
* Both accesses are atomic.
* They access disjoint byte ranges.

Other than the fact that it uses a thread-local mapping on machines
that can't address all of their memory at the same time, it's
completely normal memory. It's literally just a PAGE_SIZE-aligned
allocation of PAGE_SIZE bytes.

> If this is not allowed, I don't really like the API. As a raw version it
> would be fine, but I think we should have a safer version (eg by taking
> `&mut self`).

I don't understand what you mean. It is the *most* raw API that `Page`
has. I can make them private if you want me to. The API cannot take
`&mut self` because I need to be able to unsafely perform concurrent
writes to disjoint byte ranges.

Alice

