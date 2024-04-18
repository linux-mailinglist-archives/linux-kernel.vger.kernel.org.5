Return-Path: <linux-kernel+bounces-150149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F68A9B03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB61C20B50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795515FD16;
	Thu, 18 Apr 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFyHH5p3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96215FA6B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446286; cv=none; b=XPSL3vGx/y6RdThUVtwwJxGa3BtrKUCeMH2FbBFGX0hDPrsOVtyhKvR8etmhnw9s404zPSeadmstA+XacGBbEPcUdab/tqDd5RK9cxZXi0GVzlcCCzn4hsF3enlm4kUCqaBJciE+ctItIpLJrpj8IUAp0ubffrXDAUvYQXevaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446286; c=relaxed/simple;
	bh=g0lDcg5sk4wjgWLkv294Wu+ievcxVOJOIGYTzRJialY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SepEtUH30itq2Cc0uU8iDJwNUbT2SsN4YDbISJEV+PGmBu7/e709bZkMtPHowT3xPuxrNPGcnqZ2rbv0fZ+OXvI7NkbvAiaYAW2o1a3yfjLnueOX7eDkxr4cuHN8WYp0Pcl8fbhGvn/AliVI+L8SiXEJ63Qs30ePhwSwuJbvWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFyHH5p3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-618769020bcso9053447b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713446284; x=1714051084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNRbWAZ6Q5MqN+iLHn0qNU1jdPOPQHBoqFwuo6lZ8Oc=;
        b=tFyHH5p3JQxDb9pVBlV7RW8DnMEMtJSJTzWVUaWoBUQYgmr9G8wovoubNwfsbK1od3
         1Efg2QnShvFAC+csWW+nG7Zyq8/PfKJ5YQ4h/7GAkjF7RLdbqgc4OACUHzfOYYrw52DH
         /ZTqmcSzosWRqRdtUha3/eu3dnfB8z/UrS47uv/wiuHZdYz8BqcaJSHxcLrhIwL56mDD
         rH3w2zUdGC9yQLridnhBrOc1TAhUqCe2u0o9GGsdIYmVSLRW72J1wrPwcVrVLPkDIkNP
         MJczmmgYwVeM+J8zOCnmmS4hlDEeMaTo5c5VaVfsh6jwvVirJ2a23U/2yYDLfkPRtcL1
         bczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446284; x=1714051084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRbWAZ6Q5MqN+iLHn0qNU1jdPOPQHBoqFwuo6lZ8Oc=;
        b=TjcGUO8ini1EvGNBIOe41nnioQrYMVOijHCMC/PSXvGp+Z39/UYT2zX8KqLvrxmnbN
         zrDJCyetDfebwDyDrEr+k4ZznyLzZTlF+S9XFqap+ZpUq+mV3Vnn1Wl5O4dTJVnnz80/
         RtqNeErcDRn0DPOv0dzGD8Kk4g1vQdzjljGb6yqmIDdrKkkTabkyxJwNt2oEW0y0U2ij
         CC8OMxq2B6zmchvx7IhqMb5YSXPP0eiKlxB11TQzipZcZ9IRnEz6mOvIFnccHC6wndx4
         yvfEWoo4dD8LqXFBoJXIA0/LcGVYmNEmg6aHJwcWqJ8HqhAOPJgbTD+vsfDBmRUVpXtT
         v+zg==
X-Forwarded-Encrypted: i=1; AJvYcCXdG85MlIi1SNszc6VXKXVXK4pmKYVtX4IOcALfOx1k0feUkWvXfOrttSdmNucS5eHXGG8+kWAPUMwy1MwuR6/02Z1oTNFCGa6lncNK
X-Gm-Message-State: AOJu0Yw65UrNme+yf31mvW6koM7BS3Up2RU5rY8mI8bVfTREjpzhvuh8
	FmAH4tamsvIwQDocpqLtTLPNrcS0a588HukGmuLbTo0eIKvHsvbwonfcO8dP2L+h3ba2qJWi4h0
	reaSxmL+ha2B6Wg5WlP7No6z6clhCJ+uXuyW3
X-Google-Smtp-Source: AGHT+IE2p3Omlwm3EzGg+l2X0TwISReBp7wfKSeqHifZGecA9H/wvlgdStZ8NcRwsmoz0C14lmxeng8EglXkjwSno5E=
X-Received: by 2002:a05:690c:6206:b0:61b:1be9:bbcb with SMTP id
 hl6-20020a05690c620600b0061b1be9bbcbmr3057153ywb.44.1713446283553; Thu, 18
 Apr 2024 06:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com> <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
In-Reply-To: <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Apr 2024 15:17:51 +0200
Message-ID: <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 18.04.24 10:59, Alice Ryhl wrote:
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 8fad61268465..9c57c6c75553 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -409,3 +409,67 @@ pub enum Either<L, R> {
> >      /// Constructs an instance of [`Either`] containing a value of typ=
e `R`.
> >      Right(R),
> >  }
> > +
> > +/// Types for which any bit pattern is valid.
> > +///
> > +/// Not all types are valid for all values. For example, a `bool` must=
 be either zero or one, so
> > +/// reading arbitrary bytes into something that contains a `bool` is n=
ot okay.
> > +///
> > +/// It's okay for the type to have padding, as initializing those byte=
s has no effect.
> > +///
> > +/// # Safety
> > +///
> > +/// All bit-patterns must be valid for this type. This type must not h=
ave interior mutability.
>
> What is the reason for disallowing interior mutability here? I agree
> that it is necessary for `AsBytes`, but I don't think we need it here.
> For example it is fine to convert `u8` to `UnsafeCell<u8>`. Niches also
> should not be a problem, since eg `Option<UnsafeCell<NonNull<u8>>>`
> already fails the "All bit-patterns must be valid for this type".

If T: FromBytes allows transmuting &[u8; size_of::<T>] into &T, then
it would be a problem as you could then use it to modify the original
&[u8].

Alice

