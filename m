Return-Path: <linux-kernel+bounces-110125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6B885A66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6332281FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F884FD7;
	Thu, 21 Mar 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDDvbZRT"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1984A5A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030309; cv=none; b=DD4hoa2ULZyajvR6C5d0ws91KMsoKEo5tvyDDmqL0Aqi72M+VpXHo7rB+8wWWEcbiQpWpW9gx/cUWHb7YtrodIjczlhTisGGLUDt93R609/RWsYdksbdoLtxkrKWHE2fdiJSP8zDGCXRrWs374JZJnDTlgZQ5dKRsB5qQkMb/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030309; c=relaxed/simple;
	bh=3B+X67e3QFN64speoGIjrADStYrLAT5tuVafIoMIefY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/DmWyV0NGy+ey0aqk6dfuCivxWRxd6kEFZ+z3yiVZ5vksFVIbrC/zsZjFmJ0J+i1PeX4r29WqjNrRFT7FtcXESyTDLJl2Xzn3BU1MhvDf4bTZZnkUoykOt2hU4F72iB/NmnLl//F2dt5cZCceb/Yzzf+WvGbIZO2IKDLsz4iuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDDvbZRT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430baec7bb5so18972341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711030307; x=1711635107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck4TkMLqNJOKAoGnoaiXGuXYDSdMyWKTEEYgwReH5mM=;
        b=pDDvbZRTKvrF+tfVPggq4ntsQZE2jbNnObJIs+v1rvnetHoDpNVDnHxFnivcjZayDX
         VMsj8dQbRljoYeiedWeeHwUwPz34xYJOENGjp/NJRPyhRFads0QqOVsrq2z4OPRat8e2
         srJSEglkXvPAy+TMq+JAYgB8h1RwlDo0npkCjKefT540TAJGAhLTFfxI6NP4UeLyy0Yn
         p3BH4+MbMnoInKswx5R0CVMaYMCbXDUJqbIBO5/nemqCTkitoL7s9ANpcfqCN89jMAoi
         fdZzS8wqQguFnqcv3HmE2XK4874NoKNQgbhXeDA53geVImWR4EQ80KRhupnDUZcC43Es
         vCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030307; x=1711635107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck4TkMLqNJOKAoGnoaiXGuXYDSdMyWKTEEYgwReH5mM=;
        b=ogSl9GLSUlTT7C62jtB7MF5pzyJpxfAz2Rbpo5NO+ZPU1NixmqtTP/zT6/po4qh3nm
         yvUGg+FSnapKafPReMb6WZeHRR7tAAXmoKcq3WkOA2woR4R+KqNaJCLxZBCj5dsiqJ6p
         J3IJYchQDgnMh+9bicMSOBWE7cxMOkNCSTwYn4VV8imYi9R6lERDVOXyArKcHf6u5cnB
         rBm9oCcEUgQnaG+5AvLf6A0JsOGJw1+wWXe4ZyxfOtWuFUGCLKUQPkBv2F0LTpiPwXFn
         kLRKGraC4bFVDBBhcOe715H7KWK6Ivreqsan+gPeO7L5wCzD02VXrlLq+1SoEqKWl4wu
         kPEA==
X-Forwarded-Encrypted: i=1; AJvYcCVOkdwEsNYrLeQRtIh830rz9pQ6NfGtTEe3POZU0NioApQbX+INNrj9BHH4gW68eMWal3fexarXZFLxtBE9wnvzU5bsl4bAo17WCmGf
X-Gm-Message-State: AOJu0YzJrLKKueN9GVBKb78P7PfopfEc9muMl0NjTCpF4Qxrxb1oUGMP
	Gsc8kHiVR0RqNgv/7pQwQ5WOkP2Tac+Zh8DIEKly//ANBi8aviTcBR7uFP7QGKuyJg1AX9x2ybu
	46BIsR7SLRVhpYnKEPODSEUN55tACued3xIi5
X-Google-Smtp-Source: AGHT+IEJGECJT5cE+zG3WClI4hruLgbFNuhTreSMkwaj1+QR6Jyy2aFP6npQQ2UlYF+85K169vu4856UO9uV7AucCO4=
X-Received: by 2002:a05:620a:4509:b0:78a:2d35:3071 with SMTP id
 t9-20020a05620a450900b0078a2d353071mr3931578qkp.38.1711030306353; Thu, 21 Mar
 2024 07:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
 <20240320084630.2727355-1-aliceryhl@google.com> <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me>
 <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com> <e088f9a2-c0aa-41b6-993b-01adb5fba929@proton.me>
In-Reply-To: <e088f9a2-c0aa-41b6-993b-01adb5fba929@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Mar 2024 15:11:35 +0100
Message-ID: <CAH5fLggy1ci+gu2eVzjo0nHtNzT=+NgaaU5WAwq8qHrhu1QCYw@mail.gmail.com>
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

On Thu, Mar 21, 2024 at 2:56=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 3/21/24 14:42, Alice Ryhl wrote:
> > On Thu, Mar 21, 2024 at 2:16=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 3/20/24 09:46, Alice Ryhl wrote:
> >>>> On 3/11/24 11:47, Alice Ryhl wrote:
> >>>>> +/// A pointer to a page that owns the page allocation.
> >>>>> +///
> >>>>> +/// # Invariants
> >>>>> +///
> >>>>> +/// The pointer points at a page, and has ownership over the page.
> >>>>
> >>>> Why not "`page` is valid"?
> >>>> Do you mean by ownership of the page that `page` has ownership of th=
e
> >>>> allocation, or does that entail any other property/privilege?
> >>>
> >>> I can add "at a valid page".
> >>
> >> I don't think that helps, what you need as an invariant is that the
> >> pointer is valid.
> >
> > To me "points at a page" implies that the pointer is valid. I mean, if
> > it was dangling, it would not point at a page?
> >
> > But I can reword to something else if you have a preferred phrasing.
>
> I would just say "`page` is valid" or "`self.page` is valid".
>
> >>>>> +    /// Runs a piece of code with this page mapped to an address.
> >>>>> +    ///
> >>>>> +    /// The page is unmapped when this call returns.
> >>>>> +    ///
> >>>>> +    /// It is up to the caller to use the provided raw pointer cor=
rectly.
> >>>>
> >>>> This says nothing about what 'correctly' means. What I gathered from=
 the
> >>>> implementation is that the supplied pointer is valid for the executi=
on
> >>>> of `f` for `PAGE_SIZE` bytes.
> >>>> What other things are you allowed to rely upon?
> >>>>
> >>>> Is it really OK for this function to be called from multiple threads=
?
> >>>> Could that not result in the same page being mapped multiple times? =
If
> >>>> that is fine, what about potential data races when two threads write=
 to
> >>>> the pointer given to `f`?
> >>>>
> >>>>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T=
) -> T {
> >>>
> >>> I will say:
> >>>
> >>> /// It is up to the caller to use the provided raw pointer correctly.
> >>> /// The pointer is valid for `PAGE_SIZE` bytes and for the duration i=
n
> >>> /// which the closure is called. Depending on the gfp flags and kerne=
l
> >>> /// configuration, the pointer may only be mapped on the current thre=
ad,
> >>> /// and in those cases, dereferencing it on other threads is UB. Othe=
r
> >>> /// than that, the usual rules for dereferencing a raw pointer apply.
> >>> /// (E.g., don't cause data races, the memory may be uninitialized, a=
nd
> >>> /// so on.)
> >>
> >> I would simplify and drop "depending on the gfp flags and kernel..." a=
nd
> >> just say that the pointer is only valid on the current thread.
> >
> > Sure, that works for me.
> >
> >> Also would it make sense to make the pointer type *mut [u8; PAGE_SIZE]=
?
> >
> > I think it's a trade-off. That makes the code more error-prone, since
> > `pointer::add` now doesn't move by a number of bytes, but a number of
> > pages.
>
> Yeah. As long as you document that the pointer is valid for r/w with
> offsets in `0..PAGE_SIZE` bytes, leaving the type as is, is fine by me.
>
>
> >>> It's okay to map it multiple times from different threads.
> >>
> >> Do you still need to take care of data races?
> >> So would it be fine to execute this code on two threads in parallel?
> >>
> >>       static PAGE: Page =3D ...; // assume we have a page accessible b=
y both threads
> >>
> >>       PAGE.with_page_mapped(|ptr| {
> >>           loop {
> >>               unsafe { ptr.write(0) };
> >>               pr_info!("{}", unsafe { ptr.read() });
> >>           }
> >>       });
> >
> > Like I said, the usual pointer rules apply. Two threads can access it
> > in parallel as long as one of the following are satisfied:
> >
> > * Both accesses are reads.
> > * Both accesses are atomic.
> > * They access disjoint byte ranges.
> >
> > Other than the fact that it uses a thread-local mapping on machines
> > that can't address all of their memory at the same time, it's
> > completely normal memory. It's literally just a PAGE_SIZE-aligned
> > allocation of PAGE_SIZE bytes.
>
> Thanks for the info, what do you think of this?:
>
> /// It is up to the caller to use the provided raw pointer correctly. The=
 pointer is valid for reads
> /// and writes for `PAGE_SIZE` bytes and for the duration in which the cl=
osure is called. The
> /// pointer must only be used on the current thread. The caller must also=
 ensure that no data races
> /// occur: when mapping the same page on two threads accesses to memory w=
ith the same offset must be
> /// synchronized.

I would much rather phrase it in terms of "the usual pointer" rules. I
mean, the memory could also be uninitialized if you don't pass
__GFP_ZERO when you create it, so you also have to make sure to follow
the rules about uninitialized memory. I don't want to be in the
business of listing all requirements for accessing memory here.

> >> If this is not allowed, I don't really like the API. As a raw version =
it
> >> would be fine, but I think we should have a safer version (eg by takin=
g
> >> `&mut self`).
> >
> > I don't understand what you mean. It is the *most* raw API that `Page`
> > has. I can make them private if you want me to. The API cannot take
> > `&mut self` because I need to be able to unsafely perform concurrent
> > writes to disjoint byte ranges.
>
> If you don't need these functions to be public, I think we should
> definitely make them private.
> Also we could add a `raw` suffix to the functions to make it clear that
> it is a primitive API. If you think that it is highly unlikely that we
> get a safer version, then I don't think there is value in adding the
> suffix.

The old code on the Rust branch didn't have these functions, but
that's because the old `read_raw` and `write_raw` methods did all of
these things directly in their implementation:

* Map the memory so we can get a pointer.
* Get a pointer to a subslice (with bounds checks!)
* Do the actual read/write.

I thought that doing this many things in a single function was
convoluted, so I decided to refactor the code by extracting the "get a
pointer to the page" logic into `with_page_mapped` and the "point to
subslice with bounds check" logic into `with_pointer_into_page`. That
way, each function has only one responsibility, instead of mixing
three responsibilities into one.

So even if we get a safer version, I would not want to get rid of this
method. I don't want to inline its implementation into more
complicated functions. The safer method would call the raw method, and
then do whatever additional logic it wants to do on top of that.

Alice

