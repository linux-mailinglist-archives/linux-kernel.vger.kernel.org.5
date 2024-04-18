Return-Path: <linux-kernel+bounces-150677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DFF8AA2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC451F22E11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978317F360;
	Thu, 18 Apr 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="necsN8/n"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5B179204
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468968; cv=none; b=q1MhJARjk87nVJPqmqleUqMbbESJQ/G4wiplmJEaI3Z8f+4LrlJESiRpwxmJnqPueiTuFWyGXPeXS6ICp39I6QF4UhMi4ezcgfpwI0ZKgjbGjjOyvb4pluw3lXqTJl879p89TjFRTsMHzU55xhcR1HwHRaJjE/iK2gMXMsM0fI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468968; c=relaxed/simple;
	bh=4wnmGBPm7QXnFuYr3SnHPxOZEt/EMqUAhmJpVbdQCQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhcdepDtWSxCg2GU33ARyioQqsEwua4/Mvybcg3up6L4jBXjAu5pzmPb94MwmoKQoMkKST53pr9hpvZ7eiUraF4dd87SiJjlAa7Bn8luua3Ch8gb/ZPS1Us01Lcp6774pxYLuDO0MiIDdhXggNPGTWCB96A8gRhvHuwoQa8ahFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=necsN8/n; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4db27d21a22so352506e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713468965; x=1714073765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDw45IBLdxhM9LjWeyHX6+dY7iByC19AmUWN5RO+9ZI=;
        b=necsN8/nbNrlCCZ/hWYYg/qlHEzSSUAe2ndDeoK2YUvEoNjFpGYUGIb1Ks+8yz+E4d
         IybkuIIq/E2x5W7AyKJsXul0NafZ8e3MMYgsMss8gthbxtJpY6qlP5U9+YAekULqwyJp
         YSMaWZzfvnm2x8IYWItnempkbKuhDYBxcdm3aEXWwt2P7BIgL8J3XY5SPwyiXuGwQ44g
         RCyGCIhk4ZNEiQ3AATvSL/gywd7E0OsmAOkNybQr7UgdfAclUNZLfRU8C8U1Gmp8iPGr
         qIlOCRqB1dUIcXnAkGU2yaHeFFk/fDf38bsX20d6jDJBWLP3qPzRhsmpY6TOhSKzeqRJ
         LQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713468965; x=1714073765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDw45IBLdxhM9LjWeyHX6+dY7iByC19AmUWN5RO+9ZI=;
        b=iQCOQZvQnWoCDAWiC9bF/HgBjVuMYN27pstrzDa2piIswS4uDLOpnwF9dodcQqGAIR
         A8oLxU8h8DrVURfn1en3MAtJvP8BrRU5DE5XKYtopxBBZxNx377CvisDb4iqkcsPpSur
         ioNZXUvmcbMSniwrhzNX+21zTl/5zy6EAchNt9wEIqj9epRzmt8EU3w4m3ehKars5jXf
         WKfsYD4XbElfyGdtMcSPuJ3D+Fi6SAu4htgVXJrC33P49xzzTx335FpiBNs+6sFsRLb5
         5TIneTXOXxTXQ9JhHEOA3dt1S9zy4C9i0vpCJGhTPXRlpxZ5BwFqW2GpV+c/s0S/8y+q
         oYYw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmB1S23+D+ar9mXyck3iA9uQ0ZYHICUIiCUMXxlTRwrIzVgzBs2IR+qcN2kV8XB5Sj29b2mST3Ky5r4CLnY4ivBDaFDKKZAGb1QKP
X-Gm-Message-State: AOJu0YybwSl5qGgo7X88IrSfVFVGHlWdssBJ+GBZCsOtLN9mC6RiHW4g
	E6Ax0a80rkXDBTAzsr2H0VLZy4TpIP1RrJMkC1g19EXP0xa8+xWbWtNkYVvngBDFNKTdt0biIh8
	tp0tCMjRuTspZzzfB73URvLfV67PHwL/WMtbN
X-Google-Smtp-Source: AGHT+IHWSmA+AfhQF9/pyCrR3PIU8inWb525EGlHJDtOQVNbZNkBZXIDGXbngqcol+h71pHrWWwtbSq3HJMU/ZUYWPc=
X-Received: by 2002:a05:6122:178f:b0:4d1:4e40:bd6f with SMTP id
 o15-20020a056122178f00b004d14e40bd6fmr4926638vkf.10.1713468965153; Thu, 18
 Apr 2024 12:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com> <5fd684d8-d46d-4009-bcf8-134dab342322@proton.me>
 <CAH5fLgiMLxmmm0AVX_5HQF61FzzN69GCKabrr-uM_oV-rRMuHw@mail.gmail.com>
 <c6239407-8410-49e2-a8a1-16be8468ab88@proton.me> <ZiFWIFMSBbU0i8JF@boqun-archlinux>
In-Reply-To: <ZiFWIFMSBbU0i8JF@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Apr 2024 21:35:53 +0200
Message-ID: <CAH5fLghTqbK-b4z_GJYJF9PFj8JkkKE+dNNpELFZspC2o9Oa1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Thu, Apr 18, 2024 at 7:27=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Apr 18, 2024 at 04:23:06PM +0000, Benno Lossin wrote:
> > On 18.04.24 15:17, Alice Ryhl wrote:
> > > On Thu, Apr 18, 2024 at 3:02=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > >>
> > >> On 18.04.24 10:59, Alice Ryhl wrote:
> > >>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > >>> index 8fad61268465..9c57c6c75553 100644
> > >>> --- a/rust/kernel/types.rs
> > >>> +++ b/rust/kernel/types.rs
> > >>> @@ -409,3 +409,67 @@ pub enum Either<L, R> {
> > >>>       /// Constructs an instance of [`Either`] containing a value o=
f type `R`.
> > >>>       Right(R),
> > >>>   }
> > >>> +
> > >>> +/// Types for which any bit pattern is valid.
> > >>> +///
> > >>> +/// Not all types are valid for all values. For example, a `bool` =
must be either zero or one, so
> > >>> +/// reading arbitrary bytes into something that contains a `bool` =
is not okay.
> > >>> +///
> > >>> +/// It's okay for the type to have padding, as initializing those =
bytes has no effect.
> > >>> +///
> > >>> +/// # Safety
> > >>> +///
> > >>> +/// All bit-patterns must be valid for this type. This type must n=
ot have interior mutability.
> > >>
> > >> What is the reason for disallowing interior mutability here? I agree
> > >> that it is necessary for `AsBytes`, but I don't think we need it her=
e.
>
> Hmm.. technically, if the interior mutability behaves in a way that each
> byte is still initialized during the modification, then it should be
> fine for `AsBytes`, for example and `AtomicI32` (implemented by asm
> blocks)? Not making any change suggestion, just checking my understand.

No, that's UB. When the type is not interior mutable, then any two
loads from the same immutable reference may be assumed to return the
same value. Changing it with an atomic would violate that since the
value changes.

Alice

