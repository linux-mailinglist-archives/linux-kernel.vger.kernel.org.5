Return-Path: <linux-kernel+bounces-159620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71BB8B3127
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DED5285FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C013C3D9;
	Fri, 26 Apr 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttPfssHo"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A613BC14
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115612; cv=none; b=fSl8UsY//zqBtQGMSUorg49XlfV5GxQn2512i6n/CNBleeeVthOW8/DMyjhbJ0RhNwM+F6YP7OlWwVP1UE8OswjXVvxuz7Vfmlqp5+qDaWpwTrEBpCpwlFCyWdFgkD1jSuSt+JeI5MgioLg25VpOxucjgiFBeU7hYRk1MAQYnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115612; c=relaxed/simple;
	bh=k+NB7JMmOJfVGxCrRyXHvyTuixX/Pa9rlRYhz6PsS38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW+BapWBfw1E85kdSU9W3aWDZbFnmEIZCAFxciBwn/Z/S5vlSujXWP4N/TxZYqX7pfQC9t+qpSZ04gPlMDZFtANSRZXgVMXCXTY/8vq3qaySyknYr8WPxV6dAs1xguKI/J9q+rc3oStrBWNmc2Uk0he6frC4Ure5J6y4irMvr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttPfssHo; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7ed6cf3e7f8so683933241.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115609; x=1714720409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PteTKUkLdI4YjMSnQZKKT6B1AyC9xLcHreBvLXZqBtc=;
        b=ttPfssHodpNnFSOAG610UTxAbpTX/WGrAZErlEBtJfgnKCB2nM+kZj5QoBn6kZ+YpR
         xnBeh88saSs49nB4QFZ2U3ZXd7QwnD0/SGSQL4kjQWHa4BMZYwQVq75NVUAWxBruUVjO
         5oKFc3Jr4G2qqi7Zv2SGyuEmWN1dPqXPEuW8XWKJ1RqFtMX5vWW3jECh+1r0ulcS715F
         BmKbJb6zoQfJFKVc4l1H8JnG6Cg0g31ubkeoRg2o5R3BYkimwLspXKkf5yOL8MSOqktr
         Rvsollo1Mbw0kGncke8VyJglURojXw7JuU4PRAS22k8O/rRHfLyTIVcgwjR1pZ65KRHD
         NJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115609; x=1714720409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PteTKUkLdI4YjMSnQZKKT6B1AyC9xLcHreBvLXZqBtc=;
        b=LPkHvm6WshfBH/I3YIPO81rzcBDqKoSM7YpwCpMrZMz7GWaBWJSShMgOk5HRF1C4Yd
         nzruSojcK8csZNF64TK3LdNC6rqQD+Eu/0Ij3wR0HtaaCMhSD3MZRxlDfNyk/l6faeGA
         5FqcGtLRmTw7kWw91SnuXnVy6gBHCYS+tNk6xXqvqT35xDVNQfVl9MFTuh9V9Y6a7IFy
         2OLcN2ujKfbdyAsbf8CZG/JKREWNt8EnQmBPkizJAfl70Y/e4LgreEgpQVhk6o3R7O9o
         S9nzVH/5gF3QIIL8p7KVZfKU1F8SuvfKeRXZSAk54HypEQoVneps+snETA297gRRy7bc
         T5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/MxmJmAbFqljgktM3by04Z73CeyDHp/jRfTMygF/eTuld9QhH5obetam/rip9W6sDFvvCaqaED5Xa/UqAUCAxObr56WnGmFjYXB4
X-Gm-Message-State: AOJu0Yz6Z2H0T7REFjBW9iFUd4IQ0z5mDEPo9txgoF5yuO71LMsar1nu
	9dQrqj2Ut7p/w7Zeo0Ymr8uFQtc/o9fnhRvnNthXyh8Jqt93tGRpYY5pJ9pytZX/gstOM7o25Zw
	4qbk3GGGeYe06FV5QLsgUu/8lP3RiSt9FZp0y
X-Google-Smtp-Source: AGHT+IEY6tPxGSAoyXAMZ9xl7MkAtpE3MXWty6FU1VWiNNbdMvog3QBTWAS/HBT1lxBzTi/ClX+7Jxe7L8pspE2mwbU=
X-Received: by 2002:a05:6102:457:b0:47b:614e:cbd with SMTP id
 e23-20020a056102045700b0047b614e0cbdmr1763298vsq.31.1714115609277; Fri, 26
 Apr 2024 00:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com> <20240425171358.54dc96e4@eugeo>
In-Reply-To: <20240425171358.54dc96e4@eugeo>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Apr 2024 09:13:18 +0200
Message-ID: <CAH5fLgjHALMTsWNj_rRBZTgKPTPzWBEo=5VVahS_Vxag-nizPA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 6:14=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 18 Apr 2024 08:59:19 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > Add safe methods for reading and writing Rust values to and from
> > userspace pointers.
> >
> > The C methods for copying to/from userspace use a function called
> > `check_object_size` to verify that the kernel pointer is not dangling.
> > However, this check is skipped when the length is a compile-time
> > constant, with the assumption that such cases trivially have a correct
> > kernel pointer.
> >
> > In this patch, we apply the same optimization to the typed accessors.
> > For both methods, the size of the operation is known at compile time to
> > be size_of of the type being read or written. Since the C side doesn't
> > provide a variant that skips only this check, we create custom helpers
> > for this purpose.
> >
> > The majority of reads and writes to userspace pointers in the Rust
> > Binder driver uses these accessor methods. Benchmarking has found that
> > skipping the `check_object_size` check makes a big difference for the
> > cases being skipped here. (And that the check doesn't make a difference
> > for the cases that use the raw read/write methods.)
> >
> > This code is based on something that was originally written by Wedson o=
n
> > the old rust branch. It was modified by Alice to skip the
> > `check_object_size` check, and to update various comments, including th=
e
> > notes about kernel pointers in `WritableToBytes`.
> >
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> > ---
> >  rust/kernel/types.rs   | 64 ++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/uaccess.rs | 79 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 141 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 8fad61268465..9c57c6c75553 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> >
> > +/// Types that can be viewed as an immutable slice of initialized byte=
s.
> > +///
> > +/// If a struct implements this trait, then it is okay to copy it byte=
-for-byte to userspace. This
> > +/// means that it should not have any padding, as padding bytes are un=
initialized. Reading
> > +/// uninitialized memory is not just undefined behavior, it may even l=
ead to leaking sensitive
> > +/// information on the stack to userspace.
> > +///
> > +/// The struct should also not hold kernel pointers, as kernel pointer=
 addresses are also considered
> > +/// sensitive. However, leaking kernel pointers is not considered unde=
fined behavior by Rust, so
> > +/// this is a correctness requirement, but not a safety requirement.
> > +///
> > +/// # Safety
> > +///
> > +/// Values of this type may not contain any uninitialized bytes. This =
type must not have interior
> > +/// mutability.
> > +pub unsafe trait AsBytes {}
> > +
> > +// SAFETY: Instances of the following types have no uninitialized port=
ions.
> > +unsafe impl AsBytes for u8 {}
> > +unsafe impl AsBytes for u16 {}
> > +unsafe impl AsBytes for u32 {}
> > +unsafe impl AsBytes for u64 {}
> > +unsafe impl AsBytes for usize {}
> > +unsafe impl AsBytes for i8 {}
> > +unsafe impl AsBytes for i16 {}
> > +unsafe impl AsBytes for i32 {}
> > +unsafe impl AsBytes for i64 {}
> > +unsafe impl AsBytes for isize {}
> > +unsafe impl AsBytes for bool {}
> > +unsafe impl AsBytes for char {}
> > +unsafe impl AsBytes for str {}
> > +// SAFETY: If individual values in an array have no uninitialized port=
ions, then the array itself
> > +// does not have any uninitialized portions either.
> > +unsafe impl<T: AsBytes> AsBytes for [T] {}
>
> nit: I would move `str` to here, since `str` is essentially `[u8]` with
> UTF-8 guarantee.
>
> > +unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}

Yes ... but the safety comment here talks about arrays and their
individual values. I don't think it transfers cleanly to str, and that
the other safety comment fits str better.

Alice

