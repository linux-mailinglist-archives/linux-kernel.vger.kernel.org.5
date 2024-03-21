Return-Path: <linux-kernel+bounces-110134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC1885A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550281C20A08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE21585290;
	Thu, 21 Mar 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AHLGL+X9"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56C85266
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030580; cv=none; b=f3HPGJOhNa2g+lJmMQ282iE0JxuTqRQZI65QZqhV8KxmGbvH6KlKaRUBLEGKFx0QVn+2NWvuthqnaL0k6JGpxopgW8lDylx45upHCvaNjVGFTQ/B01c0jNqqgFUdJa5ZrBhKXqHbR8tV5nEsdriZH0Z73VV8dXasAkLKBucftOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030580; c=relaxed/simple;
	bh=4JpfyFYi13F0eeoXOWgJCB2zwugzgo3FJPnG58UQB0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9bLeD0NLSFveEbiaLRgq9aowOP0F905vbpMrZY3JPqJjZdrA7NrifjLmTq+p3dZKQWpdAcgRSJ0zkRXGHLrEJW4Z9h8Mx3WZ1CfKQeohT7Iyuc6CeD8oeGO7/AIB4FKlvLMZAWqF/iqA2ilOWY1s40IRT/REy22/wY193Fhedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHLGL+X9; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3a4101721so650892b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711030578; x=1711635378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PbBzEMEXXAeq4LLgNricDK4jILoebAZr7BEjc950wk=;
        b=AHLGL+X9gIL1tBMKihOLkdE82qvJKGQdEUcP6lsEGJv+pW1pf5pvv2pSNrODs4F8C7
         KUjK1O4rTn6ka/sY5S2fsMWv8GZncznh0/Q/TlCZAFWd1ICqdef6pzWSM6A7aEAErDnt
         cMZozOdbcydU5FHkLc/WLKbLXlrY1e87YVohjNLsLPyRy8zoKivmuGQqpkJIf1Wcdp/l
         VOMWVLjDR7TaqFirw6Rvq3Ef4tyBmb36IJmafwDaVzl+Y7D2CtBK59SvdALi82XzuHFn
         4LxB0v7p39LuMV4SoH22HxVBiILdJX3cQ66Gc8u7Lc09mAEuZmILW06kwHDvS2WuevSB
         uNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030578; x=1711635378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PbBzEMEXXAeq4LLgNricDK4jILoebAZr7BEjc950wk=;
        b=sd8y7ihyfk01/ScO8IgFYIGWImY72LYPHwZysEQiiOLj8ehKBjssTLHhlDLyjsQ150
         0DceI/LDxccb3kYaEUW2ddFM58zIePK6YeskjCjG4pNljEZ/wokasA3F1+gR0xgV/6PM
         ez2UnfM0501fge/nIF5oCJUCLhHyFBRUNdqXrvCiJ3DqCqQJe51DK4lsqnr6OFdvYiA9
         UVIEmTGXaC5zhN96XzKHR4kTmFlYrimI6nkuPHin6qqnWkm3gOFjGQRm6gv6DfJouPrW
         owJgTZHRp1YThDy9DWrKOVsEjmbYkGZQ7fURBr5qWN0heoNuzgpnJ6Iyw3gJ/UNN9Xvo
         Ku4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuX/9lkbrpC7SpPIzn/vvq9f7+Qnryyla3X7kLMmIvGRSTUOv8v+eN7snKNBsRash/qM7iUOIS5f8mZDeIEvWOXAoRl4LKxyuCL3hd
X-Gm-Message-State: AOJu0YyEumMOo9EpZ4o6jhKSBBYj1oevaV4gVZFs83WawNpNtEMvesIN
	w82j7JMNcHsNKiSDhg8V/XLsEuvDFboniRkmdnCdo7A+7l723DuKdyWLw8KdjDl2OkijjECOO0W
	gE111bFtoY4LskQDLe0m6NxYCPLUy5jJMjkdY
X-Google-Smtp-Source: AGHT+IH4TEVVFQK/YJPG19j7ZpbabVGsjRX1xScFkHE3KNMxeLkKxELqwdZFyKY+cYQcAqD1S7so3f6XqUodsJZwoyk=
X-Received: by 2002:a05:6808:1292:b0:3c3:865b:5311 with SMTP id
 a18-20020a056808129200b003c3865b5311mr11092810oiw.48.1711030577997; Thu, 21
 Mar 2024 07:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
 <20240320084630.2727355-1-aliceryhl@google.com> <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me>
 <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com>
 <e088f9a2-c0aa-41b6-993b-01adb5fba929@proton.me> <CAH5fLggy1ci+gu2eVzjo0nHtNzT=+NgaaU5WAwq8qHrhu1QCYw@mail.gmail.com>
In-Reply-To: <CAH5fLggy1ci+gu2eVzjo0nHtNzT=+NgaaU5WAwq8qHrhu1QCYw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Mar 2024 15:16:07 +0100
Message-ID: <CAH5fLgiHcru2uFmfwSvTnZvcnxh5Av-UWx1EEvttA0OyzhXSVQ@mail.gmail.com>
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

On Thu, Mar 21, 2024 at 3:11=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Thu, Mar 21, 2024 at 2:56=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
> >
> > On 3/21/24 14:42, Alice Ryhl wrote:
> > > On Thu, Mar 21, 2024 at 2:16=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > >>
> > >> On 3/20/24 09:46, Alice Ryhl wrote:
> > >>>> On 3/11/24 11:47, Alice Ryhl wrote:
> > >>>>> +/// A pointer to a page that owns the page allocation.
> > >>>>> +///
> > >>>>> +/// # Invariants
> > >>>>> +///
> > >>>>> +/// The pointer points at a page, and has ownership over the pag=
e.
> > >>>>
> > >>>> Why not "`page` is valid"?
> > >>>> Do you mean by ownership of the page that `page` has ownership of =
the
> > >>>> allocation, or does that entail any other property/privilege?
> > >>>
> > >>> I can add "at a valid page".
> > >>
> > >> I don't think that helps, what you need as an invariant is that the
> > >> pointer is valid.
> > >
> > > To me "points at a page" implies that the pointer is valid. I mean, i=
f
> > > it was dangling, it would not point at a page?
> > >
> > > But I can reword to something else if you have a preferred phrasing.
> >
> > I would just say "`page` is valid" or "`self.page` is valid".
> >
> > >>>>> +    /// Runs a piece of code with this page mapped to an address=
.
> > >>>>> +    ///
> > >>>>> +    /// The page is unmapped when this call returns.
> > >>>>> +    ///
> > >>>>> +    /// It is up to the caller to use the provided raw pointer c=
orrectly.
> > >>>>
> > >>>> This says nothing about what 'correctly' means. What I gathered fr=
om the
> > >>>> implementation is that the supplied pointer is valid for the execu=
tion
> > >>>> of `f` for `PAGE_SIZE` bytes.
> > >>>> What other things are you allowed to rely upon?
> > >>>>
> > >>>> Is it really OK for this function to be called from multiple threa=
ds?
> > >>>> Could that not result in the same page being mapped multiple times=
? If
> > >>>> that is fine, what about potential data races when two threads wri=
te to
> > >>>> the pointer given to `f`?
> > >>>>
> > >>>>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) ->=
 T) -> T {
> > >>>
> > >>> I will say:
> > >>>
> > >>> /// It is up to the caller to use the provided raw pointer correctl=
y.
> > >>> /// The pointer is valid for `PAGE_SIZE` bytes and for the duration=
 in
> > >>> /// which the closure is called. Depending on the gfp flags and ker=
nel
> > >>> /// configuration, the pointer may only be mapped on the current th=
read,
> > >>> /// and in those cases, dereferencing it on other threads is UB. Ot=
her
> > >>> /// than that, the usual rules for dereferencing a raw pointer appl=
y.
> > >>> /// (E.g., don't cause data races, the memory may be uninitialized,=
 and
> > >>> /// so on.)
> > >>
> > >> I would simplify and drop "depending on the gfp flags and kernel..."=
 and
> > >> just say that the pointer is only valid on the current thread.
> > >
> > > Sure, that works for me.
> > >
> > >> Also would it make sense to make the pointer type *mut [u8; PAGE_SIZ=
E]?
> > >
> > > I think it's a trade-off. That makes the code more error-prone, since
> > > `pointer::add` now doesn't move by a number of bytes, but a number of
> > > pages.
> >
> > Yeah. As long as you document that the pointer is valid for r/w with
> > offsets in `0..PAGE_SIZE` bytes, leaving the type as is, is fine by me.
> >
> >
> > >>> It's okay to map it multiple times from different threads.
> > >>
> > >> Do you still need to take care of data races?
> > >> So would it be fine to execute this code on two threads in parallel?
> > >>
> > >>       static PAGE: Page =3D ...; // assume we have a page accessible=
 by both threads
> > >>
> > >>       PAGE.with_page_mapped(|ptr| {
> > >>           loop {
> > >>               unsafe { ptr.write(0) };
> > >>               pr_info!("{}", unsafe { ptr.read() });
> > >>           }
> > >>       });
> > >
> > > Like I said, the usual pointer rules apply. Two threads can access it
> > > in parallel as long as one of the following are satisfied:
> > >
> > > * Both accesses are reads.
> > > * Both accesses are atomic.
> > > * They access disjoint byte ranges.
> > >
> > > Other than the fact that it uses a thread-local mapping on machines
> > > that can't address all of their memory at the same time, it's
> > > completely normal memory. It's literally just a PAGE_SIZE-aligned
> > > allocation of PAGE_SIZE bytes.
> >
> > Thanks for the info, what do you think of this?:
> >
> > /// It is up to the caller to use the provided raw pointer correctly. T=
he pointer is valid for reads
> > /// and writes for `PAGE_SIZE` bytes and for the duration in which the =
closure is called. The
> > /// pointer must only be used on the current thread. The caller must al=
so ensure that no data races
> > /// occur: when mapping the same page on two threads accesses to memory=
 with the same offset must be
> > /// synchronized.
>
> I would much rather phrase it in terms of "the usual pointer" rules. I
> mean, the memory could also be uninitialized if you don't pass
> __GFP_ZERO when you create it, so you also have to make sure to follow
> the rules about uninitialized memory. I don't want to be in the
> business of listing all requirements for accessing memory here.
>
> > >> If this is not allowed, I don't really like the API. As a raw versio=
n it
> > >> would be fine, but I think we should have a safer version (eg by tak=
ing
> > >> `&mut self`).
> > >
> > > I don't understand what you mean. It is the *most* raw API that `Page=
`
> > > has. I can make them private if you want me to. The API cannot take
> > > `&mut self` because I need to be able to unsafely perform concurrent
> > > writes to disjoint byte ranges.
> >
> > If you don't need these functions to be public, I think we should
> > definitely make them private.
> > Also we could add a `raw` suffix to the functions to make it clear that
> > it is a primitive API. If you think that it is highly unlikely that we
> > get a safer version, then I don't think there is value in adding the
> > suffix.
>
> The old code on the Rust branch didn't have these functions, but
> that's because the old `read_raw` and `write_raw` methods did all of
> these things directly in their implementation:
>
> * Map the memory so we can get a pointer.
> * Get a pointer to a subslice (with bounds checks!)
> * Do the actual read/write.
>
> I thought that doing this many things in a single function was
> convoluted, so I decided to refactor the code by extracting the "get a
> pointer to the page" logic into `with_page_mapped` and the "point to
> subslice with bounds check" logic into `with_pointer_into_page`. That
> way, each function has only one responsibility, instead of mixing
> three responsibilities into one.
>
> So even if we get a safer version, I would not want to get rid of this
> method. I don't want to inline its implementation into more
> complicated functions. The safer method would call the raw method, and
> then do whatever additional logic it wants to do on top of that.

Adding to this: To me, we *do* already have safer versions of this
method. Those are the read_raw and write_raw and fill_zero and
copy_from_user_slice methods.

Alice

