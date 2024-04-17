Return-Path: <linux-kernel+bounces-148827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E625F8A87D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149531C21E99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD71494BF;
	Wed, 17 Apr 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3p6VRU/8"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F338DEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368173; cv=none; b=BzokjpIAASD93iFtoOzuMk9psayvF2f5PO1Im7LgODMYJJcvhcciGS4IRnj77cYTefs8tPsIu3q2WmLV1hpekmVuugM5P25UMpYgIEwlUqWK3t+YiFwZt1sHH9IqJFzNXM8F79Yu+LQ8pY5cayus5SyRIxuc5Sbfs14eVnQlWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368173; c=relaxed/simple;
	bh=VIrsNerujZ8+PtTYveVk1Mj9pGEnbz49H9qMK6+Fxpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+FQt7aRdnPHN4QCf+iDKU6fUortkWshR3VmyXo/oPb5GiEj9H0oAZPCNBxbqRb+QPZ+WRmUx1hIEdmJ5wdCtbfRM7WZKuFfGs8N/60QOiKfqzyxfUyIfD7Le1H/HsxRvPmP4twoY6Ff+LpRTVjx5Su8FDd7YzlM0K5iqOCHW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3p6VRU/8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa3f0fcd46so3674098eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713368170; x=1713972970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7STbkb0kc4uO9A+FOCYz3iBH+d6D+yCiN6yb3DAcBlQ=;
        b=3p6VRU/8l5jGbAXpiq+/cmcRQEw9OLMH0AiPdehFBb2bfGPIY7BFpU5crhXaBnPkmB
         775oABNgKmHx+3oiDc99AZScDcO628KQrMkc7wQYwPPxykY52A3JuyMm5pPJRDvN7Ze0
         bOORR5I96olz3LGdb+tW3pGor1qSIeIrY+50iNgEQkHYdto5TEgwa0GGOhsWYULD8No/
         EsEwtU+xqClfrBXPw8xZ9iBy4Psb6ye8XID6P7z7oUhAVnLUVP4RP93tkEHDJPcMW4Pf
         9OX5kxRi/CX87/+fNzXLMBpCOXM2IHrkG63EjWxh6P7gN+4zTgLcQVn8GdcKyhOhq4Za
         7BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713368170; x=1713972970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7STbkb0kc4uO9A+FOCYz3iBH+d6D+yCiN6yb3DAcBlQ=;
        b=jv/+A8swL19FEm1y5vY3meL4E83ZCFTE+bN7yvwHj/FES1H2IRU4XL84Cmoawf/gIO
         uVDq+1ikpftEtQoTyNBUIjPT1K69W8ObMsAI98TigNSf/nGxjw7ZMZwNzDOGH5M6CkfX
         dGTyp05xyFw2X8NDQlUGecbGmGmhbuJrn9jxpGNUZRgxW7FoTqTwJ1OT31p05L1Nl5bl
         qqaICzAFJpb1WkRbQocecgHLlk3FJJapJj8IP1Tl/ezAdsXMzo/DdcuHNcuX1z6cqudb
         JS8lBjM1bOqmUcLwIthsRLWCvR92BvMHtKVJtni7TKtfIW6o1410X+pGXztLpavwK7t4
         JmLw==
X-Forwarded-Encrypted: i=1; AJvYcCXwRZA5XxbR8uiRYMR9eiCXEBwq36O1K/OqJDTHLzsvRLeTX+PBSobw9dRzCFWlCdCiTUPfYGc326wepCvdAiEMEKcXSYkopmPnSqSQ
X-Gm-Message-State: AOJu0YzPunvkNhQmfsJDN43g1pJDVjBa6sO7jC887WYOHiofb+THQ4/P
	AEQjwCiCJuSyxXOQ3Ef51OOp1SuA9XvHvixFzr36tm6hePrVCbozFN6sRVImZBynegvdscAwjFI
	PNinmi6kdeXV8/BSWem1gxkeqWbK/slsYNesW
X-Google-Smtp-Source: AGHT+IEMzi3flnGGABxiUZthG7GHk4bJeCL8d7G0v1u9soflo+40Qg2LO67Au8RewgmGKPOf25nQ1dU2JqYa7YwdIKc=
X-Received: by 2002:a05:6358:688b:b0:186:2720:2122 with SMTP id
 z11-20020a056358688b00b0018627202122mr13281274rwh.2.1713368170317; Wed, 17
 Apr 2024 08:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
 <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com> <20240417152802.6b7a7384@eugeo>
 <CAH5fLgjcO0mrQ=X2QG1qS+sTpWDnBfGxXGWn-3wBQzn3MP8pQQ@mail.gmail.com> <b7305f21-3e0b-4bfe-8902-5fc9367c2291@proton.me>
In-Reply-To: <b7305f21-3e0b-4bfe-8902-5fc9367c2291@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Apr 2024 17:35:58 +0200
Message-ID: <CAH5fLgjCbvZxSnjzibiFzyEz1Qjw3bAw=qU4sjrBrgosMBKKnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:27=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 17.04.24 16:40, Alice Ryhl wrote:
> > On Wed, Apr 17, 2024 at 4:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wro=
te:
> >>
> >> On Mon, 15 Apr 2024 07:13:53 +0000
> >> Alice Ryhl <aliceryhl@google.com> wrote:
> >>
> >>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >>>
> >>> A pointer to an area in userspace memory, which can be either read-on=
ly
> >>> or read-write.
> >>>
> >>> All methods on this struct are safe: attempting to read or write on b=
ad
> >>> addresses (either out of the bound of the slice or unmapped addresses=
)
> >>> will return `EFAULT`. Concurrent access, *including data races to/fro=
m
> >>> userspace memory*, is permitted, because fundamentally another usersp=
ace
> >>> thread/process could always be modifying memory at the same time (in =
the
> >>> same way that userspace Rust's `std::io` permits data races with the
> >>> contents of files on disk). In the presence of a race, the exact byte
> >>> values read/written are unspecified but the operation is well-defined=
.
> >>> Kernelspace code should validate its copy of data after completing a
> >>> read, and not expect that multiple reads of the same address will ret=
urn
> >>> the same value.
> >>>
> >>> These APIs are designed to make it difficult to accidentally write
> >>> TOCTOU bugs. Every time you read from a memory location, the pointer =
is
> >>> advanced by the length so that you cannot use that reader to read the
> >>> same memory location twice. Preventing double-fetches avoids TOCTOU
> >>> bugs. This is accomplished by taking `self` by value to prevent
> >>> obtaining multiple readers on a given `UserSlicePtr`, and the readers
> >>> only permitting forward reads. If double-fetching a memory location i=
s
> >>> necessary for some reason, then that is done by creating multiple
> >>> readers to the same memory location.
> >>>
> >>> Constructing a `UserSlicePtr` performs no checks on the provided
> >>> address and length, it can safely be constructed inside a kernel thre=
ad
> >>> with no current userspace process. Reads and writes wrap the kernel A=
PIs
> >>> `copy_from_user` and `copy_to_user`, which check the memory map of th=
e
> >>> current process and enforce that the address range is within the user
> >>> range (no additional calls to `access_ok` are needed).
> >>>
> >>> This code is based on something that was originally written by Wedson=
 on
> >>> the old rust branch. It was modified by Alice by removing the
> >>> `IoBufferReader` and `IoBufferWriter` traits, and various other chang=
es.
> >>>
> >>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> >>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> >>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >>> ---
> >>>   rust/helpers.c         |  14 +++
> >>>   rust/kernel/lib.rs     |   1 +
> >>>   rust/kernel/uaccess.rs | 304 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>   3 files changed, 319 insertions(+)
> >>>
> >>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >>
> >>> +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> >>> +/// [`clone_reader`]: UserSliceReader::clone_reader
> >>> +pub struct UserSlice {
> >>> +    ptr: *mut c_void,
> >>> +    length: usize,
> >>> +}
> >>
> >> How useful is the `c_void` in the struct and new signature? They tend
> >> to not be very useful in Rust. Given that provenance doesn't matter
> >> for userspace pointers, could this be `usize` simply?
> >>
> >> I think `*mut u8` or `*mut ()` makes more sense than `*mut c_void` for
> >> Rust code even if we don't want to use `usize`.
> >
> > I don't have a strong opinion here. I suppose a usize could make
> > sense. But I also think c_void is fine, and I lean towards not
> > changing it. :)
> >
> >> Some thinking aloud and brainstorming bits about the API.
> >>
> >> I wonder if it make sense to have `User<[u8]>` instead of `UserSlice`?
> >> The `User` type can be defined like this:
> >>
> >> ```rust
> >> struct User<T: ?Sized> {
> >>     ptr: *mut T,
> >> }
> >> ```
> >>
> >> and this allows arbitrary T as long as it's POD. So we could have
> >> `User<[u8]>`, `User<u32>`, `User<PodStruct>`. I imagine the
> >> `User<[u8]>` would be the general usage and the latter ones can be
> >> especially helpful if you are trying to implement ioctl and need to
> >> copy fixed size data structs from userspace.
> >
> > Hmm, we have to be careful here. Generally, when you get a user slice
> > via an ioctl, you should make sure to use the length you get from
> > userspace. In binder, it looks like this:
> >
> > let user_slice =3D UserSlice::new(arg, _IOC_SIZE(cmd));
> >
> > so whichever API we use, we must make sure to get the length as an
> > argument in bytes. What should we do if the length is not a multiple
> > of size_of(T)?
>
> We could print a warning and then just floor to the next multiple of
> `size_of::<T>()`. I agree that is not perfect, but if one uses the
> current API, one also needs to do the length check eventually.

Right now, the length check happens when you call `read::<T>` and get
EFAULT if the size of T is greater than the length of the user slice.
That works pretty well. And there are real-world use-cases for
userspace passing in a length longer than what the kernel expects -
often adding fields to the end of the struct is how the kernel makes
ioctls extensible. So I don't think printing a warning in that case
would be good.

In Binder, I also have use-cases where I alternate between reading
bytes and various different structs. Basically, I read two user slices
in lockstep, where the next value in one userslice determines whether
I should read some amount of bytes or a specific struct from the other
user slice. That's much easier with the current API than this
proposal.

> > Another issue is that there's no stable way to get the length from a
> > `*mut [T]` without creating a reference, which is not okay for a user
> > slice.
>
> Seems like `<* const [T]>::len` (feature `slice_ptr_len`) [1] was just
> stabilized 5 days ago [1].
>
> [1]: https://doc.rust-lang.org/std/primitive.pointer.html#method.len-1
> [2]: https://github.com/rust-lang/rust/pull/123868

Okay.

Alice

