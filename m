Return-Path: <linux-kernel+bounces-148687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4E8A862E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EC91F211C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AA21422B5;
	Wed, 17 Apr 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHZGXw63"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA81411DF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364822; cv=none; b=NEy5JN3GyNC3hHIAzzrR5ICgqBzyFCE5EWGuk57pbK3/exbSF0hwo1qwdZwziCKJXrpNGuaS8pTzHCOHZVuG7VKnAeWbYZ7a15hGWMFOzToCHf4eqlO8PmMkF10giZc0ogR1yBoD/PBS2dvUdubH47gVn1pOTr38e/2tkcC1zyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364822; c=relaxed/simple;
	bh=CG7A0XS5Xdpm61BM+Mu/W9XBB/wYmjyn3UwZ2G16VmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dodomxhYV306ur0oPeJ69/GX7l90r4Fqq4ePdPMiRAL7R3xnvWCyzLiieVjVzqeRHfvp1aoeN7Ejl8LFSoIMM0gBDs59N9Wf6b4LNAjqZaDuXNC7kt55BjsJPHj7A9BqFBf8sxyhiCk/dvH721rcJk5UhB/7Lu7dxr+6TKp7E/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHZGXw63; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47b99c0cce3so531796137.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713364819; x=1713969619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9STrnlwuu+n4JzHQ1nF68oOe1/KL3VmX4gpavyNIyiA=;
        b=aHZGXw638ZeW9a/y7K3QuwK5Q5gkaSAnb+mqwZ8H1Z6ZLwXzHGQYUFsksagZt903FA
         UA/KIqjG9+MZqzvSwZOK/1blT2kS8sNmPK5Dp6920edLid4KNdEylWt8rgVBte44U/bz
         QgQK82WB87LkQHk4mU7cBH+ShVRH0AXQV1u1BFLH/sSjR+mXnJOtYhbgGHtC2qJBjFVI
         1G5cjKYiouzotV7gONGaIiMRfPlQvv6vQAEcu1A0m0WON5yfxy5AF2MwKnHRn3US9Ays
         AA4nApWCdVOcumPJKgLVnMDqWBlbY89DsltEkp3N40z7BGa3LOYVKWwaewLWGNn5aPKt
         FVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364819; x=1713969619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9STrnlwuu+n4JzHQ1nF68oOe1/KL3VmX4gpavyNIyiA=;
        b=kNSNc+1hZpCmr0QFSQChrQEzCy3ND21uBGkZHsmG8F3iCDwIZMJ+Y/X0GbQJOmiAFX
         P1xdZYICR1L97hN7pIpc8eTsMesiM6IUBnhgxsh7lePga+W+w8J6F1RP/bEY7FHoSKRb
         Awy6lY/ULoLSUgzK8i+wNc4P0o4/UInABsutrRmO6xTMVMsT9FoAUubqja54tWVMSDws
         odbpZzxZ7M8RqGpOjRe09ZfMRX4giQ5Z31ZQQpAIxjUKyFXDLUl8x5o5rVEtgj1ig9Rw
         LaDiPiDy3HyQYo6q51hUALx8hdvhaCxCgHi73aRdgWaUeetNskEn3/+kZqDU02rInwdc
         6CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3bFDhHoStyAPfcNlE9f1p1qmdAaK9ahu9MzmSJcVH7WrHA4EM4/I8zyJ7KS363mWjF4CcwNZEO8hmgnCVDsnfRs9ZbQAjuSgYGgip
X-Gm-Message-State: AOJu0Yy29W9xBSO/DkL1UOg2FreDE9miINn6UEGGWNjJXjdSKsKOQEcm
	Ky+rkcea5i1HWVCUxhwjepjzJ5b8XQqgtU1HjoTFoE9v4YY/7mu1qIAaUXhrLk+R9LRsRSjMMo4
	54Uqy3zi0Jn7EIJT3PA8HFKRBFNmCShapMii1
X-Google-Smtp-Source: AGHT+IEAhdkE9/+u7jKI1qVzSkpiUAFnT/Mz0cfCADATqN+blmQ68F1aCON7VI4CU5CS05totk8sdgrrvWMi3cB58MI=
X-Received: by 2002:a05:6122:882:b0:4c8:90e5:6792 with SMTP id
 2-20020a056122088200b004c890e56792mr16551902vkf.7.1713364818511; Wed, 17 Apr
 2024 07:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
 <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com> <20240417152802.6b7a7384@eugeo>
In-Reply-To: <20240417152802.6b7a7384@eugeo>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Apr 2024 16:40:07 +0200
Message-ID: <CAH5fLgjcO0mrQ=X2QG1qS+sTpWDnBfGxXGWn-3wBQzn3MP8pQQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
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
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Mon, 15 Apr 2024 07:13:53 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > A pointer to an area in userspace memory, which can be either read-only
> > or read-write.
> >
> > All methods on this struct are safe: attempting to read or write on bad
> > addresses (either out of the bound of the slice or unmapped addresses)
> > will return `EFAULT`. Concurrent access, *including data races to/from
> > userspace memory*, is permitted, because fundamentally another userspac=
e
> > thread/process could always be modifying memory at the same time (in th=
e
> > same way that userspace Rust's `std::io` permits data races with the
> > contents of files on disk). In the presence of a race, the exact byte
> > values read/written are unspecified but the operation is well-defined.
> > Kernelspace code should validate its copy of data after completing a
> > read, and not expect that multiple reads of the same address will retur=
n
> > the same value.
> >
> > These APIs are designed to make it difficult to accidentally write
> > TOCTOU bugs. Every time you read from a memory location, the pointer is
> > advanced by the length so that you cannot use that reader to read the
> > same memory location twice. Preventing double-fetches avoids TOCTOU
> > bugs. This is accomplished by taking `self` by value to prevent
> > obtaining multiple readers on a given `UserSlicePtr`, and the readers
> > only permitting forward reads. If double-fetching a memory location is
> > necessary for some reason, then that is done by creating multiple
> > readers to the same memory location.
> >
> > Constructing a `UserSlicePtr` performs no checks on the provided
> > address and length, it can safely be constructed inside a kernel thread
> > with no current userspace process. Reads and writes wrap the kernel API=
s
> > `copy_from_user` and `copy_to_user`, which check the memory map of the
> > current process and enforce that the address range is within the user
> > range (no additional calls to `access_ok` are needed).
> >
> > This code is based on something that was originally written by Wedson o=
n
> > the old rust branch. It was modified by Alice by removing the
> > `IoBufferReader` and `IoBufferWriter` traits, and various other changes=
.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/helpers.c         |  14 +++
> >  rust/kernel/lib.rs     |   1 +
> >  rust/kernel/uaccess.rs | 304 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 319 insertions(+)
> >
> > diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>
> > +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> > +/// [`clone_reader`]: UserSliceReader::clone_reader
> > +pub struct UserSlice {
> > +    ptr: *mut c_void,
> > +    length: usize,
> > +}
>
> How useful is the `c_void` in the struct and new signature? They tend
> to not be very useful in Rust. Given that provenance doesn't matter
> for userspace pointers, could this be `usize` simply?
>
> I think `*mut u8` or `*mut ()` makes more sense than `*mut c_void` for
> Rust code even if we don't want to use `usize`.

I don't have a strong opinion here. I suppose a usize could make
sense. But I also think c_void is fine, and I lean towards not
changing it. :)

> Some thinking aloud and brainstorming bits about the API.
>
> I wonder if it make sense to have `User<[u8]>` instead of `UserSlice`?
> The `User` type can be defined like this:
>
> ```rust
> struct User<T: ?Sized> {
>    ptr: *mut T,
> }
> ```
>
> and this allows arbitrary T as long as it's POD. So we could have
> `User<[u8]>`, `User<u32>`, `User<PodStruct>`. I imagine the
> `User<[u8]>` would be the general usage and the latter ones can be
> especially helpful if you are trying to implement ioctl and need to
> copy fixed size data structs from userspace.

Hmm, we have to be careful here. Generally, when you get a user slice
via an ioctl, you should make sure to use the length you get from
userspace. In binder, it looks like this:

let user_slice =3D UserSlice::new(arg, _IOC_SIZE(cmd));

so whichever API we use, we must make sure to get the length as an
argument in bytes. What should we do if the length is not a multiple
of size_of(T)?

Another issue is that there's no stable way to get the length from a
`*mut [T]` without creating a reference, which is not okay for a user
slice.

Alice

