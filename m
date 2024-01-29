Return-Path: <linux-kernel+bounces-43525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23C841529
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAD51F23526
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B131586FC;
	Mon, 29 Jan 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+Lauid6"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D8157E79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563678; cv=none; b=HS8Ml0OMFVaBwn4RnXm2qh5qj8spqraRqDFFR1PlmQgjHmjwNcqpnb7EN87dwpg1nqqqOPLxDnEO5jLv7+ysBtSWn1OK4YumqDAE9PQWoqjuyg8y+gbvRVOuEHkCm61UNOXEoyZgunJT2ATvMX6cWkcGVgNhRYkEyo9oosJPRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563678; c=relaxed/simple;
	bh=umDEiWFPLY+J0E0ZohRjUVyk/OqulVHRAScoRzh7bR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCtvuaUMbcSxWHGMBCzA4IXoRywVrPBl9/m79hPISdYWmypixveFyWCKsH1bTcxeD8Mvx2G+/XWWlt+PfmhXQ1BrV1XJIdUBqZfczgTwC6pgy1UFL5dU2mZcxroBRaBRxD8T0vOCdZJd5/oVBhfF33w5HrUlMSTn3v2ads11HtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+Lauid6; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso780727241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706563676; x=1707168476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brAWAuHMK3TSM8Xhcazu9ZlxC5Vo2cjLsypBIp5RI5M=;
        b=b+Lauid6/sncQ8zdpURq6tuBnpJKxj/VteVas6YE9A/+3KT7xw/IuhLteGHRZLKR2Q
         Z7UF+H0Kt1VZxKRrPOpO9gEpG9wN+mwzu665p/3S+twin3MONIMmSxa9YttBJlQ/JsxM
         8J13qkgdjmekWQrnyFpsgWcv4aKHc2zq4v578ID3AbQPJP0ODnQdp1pZqOJ0dnUMzgSi
         WE0SGKQWedajKs2aJIXNA6L8+16xAfQchIASkPIyqoZZXocL6cbjnOXybiUyME1GKcA0
         Se7tIsGFFk7dQbd4qiQzPswzF3XHdxdVjeufyl7zPqn+MhIDXd1pw2+/yxT+JQXu3a6j
         aWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563676; x=1707168476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brAWAuHMK3TSM8Xhcazu9ZlxC5Vo2cjLsypBIp5RI5M=;
        b=lt2iZ6E7s6EYaXtcvwG8vmGBIhSDWyx3zYIKeAD0a4/PDIUN63F3mJ6fthfGsbw4wD
         VudPmhjzxkEI+EGrR/otbLMD7s3Eo3E/sUA14dRpbEz5Jih7B9vBzZymeCs77iSErB0R
         C34NcJUGAKBI57JtR7tw2CTdttrVgSQ+8V/v4uWC5XRQC6eyO3Hsht9qm4i/tbcqbRZJ
         1jGXZaafdG7fBBVk7p8V1F9ET6uNdkonpPIK1V6ObLLwZEo6osCqUMHfQmM98NOGK7ud
         FWRIOvmZ6eTsrXnpkaZJFFgFGEoWiBJbGhi8Ew7hW8esJJUY0zHZf9hT9tn0k6cKJWqx
         8VMA==
X-Gm-Message-State: AOJu0YyU6S+wMeHruPaC72SuY6bkXwVYRsoh1jIT81ayRkqDtF1oIAe+
	/CuU2YVl2EePKqM+1kwArCVkvWh9Qv6+lAKFiuFLGpZznU+37RfQEIHdhM/mmiQ9R+BVFI9ohHs
	asmckLz5O6vxZvE6IdubH9sCILOwKxI728aTm
X-Google-Smtp-Source: AGHT+IFj5xck2ZZMU+sBSPYdylP/U9nNDCaRvFkvDK5pc2OQBzprbb2S01cfLCABG6cBuYniOj+KiU6IznAyfqEqbhs=
X-Received: by 2002:a05:6102:317a:b0:46b:3d9c:99cc with SMTP id
 l26-20020a056102317a00b0046b3d9c99ccmr2810766vsm.9.1706563675784; Mon, 29 Jan
 2024 13:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com> <ZbfnmX1J8iLV8UnO@casper.infradead.org>
In-Reply-To: <ZbfnmX1J8iLV8UnO@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Jan 2024 22:27:43 +0100
Message-ID: <CAH5fLgjFRTTOa4Xjvxr1pmpFKv1o3Mm76iAQ6j-ST0jQ7DWyCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
To: Matthew Wilcox <willy@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, liam.howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > Adds a new struct called `Page` that wraps a pointer to `struct page`.
> > This struct is assumed to hold ownership over the page, so that Rust
> > code can allocate and manage pages directly.
>
> OK ...

Thank you for taking your time to review my wrappers!

> > This patch only adds support for pages of order zero, as that is all
> > Rust Binder needs. However, it is written to make it easy to add suppor=
t
> > for higher-order pages in the future. To do that, you would add a const
> > generic parameter to `Page` that specifies the order. Most of the
> > methods do not need to be adjusted, as the logic for dealing with
> > mapping multiple pages at once can be isolated to just the
> > `with_pointer_into_page` method. Finally, the struct can be renamed to
> > `Pages<ORDER>`, and the type alias `Page =3D Pages<0>` can be introduce=
d.
>
> This description concerns me because it reads like you're not keeping
> up with the current thinking in MM about what pages are and how we're
> improving the type hierarchy.  As in, we're creating one instead of
> allowing the current mish-mash of absolutely everything to continue.

That's very possible. I have a good understanding about how C binder
interacts with pages, but I don't know too much about the abstractions
that Binder is not using.

> Are you the right person to ask about the operations that Binder does
> with a page so we can figure out where it fits in the type hierarchy?

I can definitely answer questions about that. If we can find another
abstraction that is not too far away from what we are doing today,
then I am open to looking into whether we can do that instead of the
current approach. However, I want to avoid large deviations from C
Binder, at least before I get Rust binder into the kernel tree.

A short overview of what Binder does:
* Every process will mmap a region of memory. This memory region will
contain the data for all incoming transactions sent to that process.
Only the kernel can modify these pages.
* Binder has a data structure that keeps track of where the
allocations in this mmap'd region are. It has functionality to find an
open interval of a given size (so it's essentially an allocator). This
is called the "range allocator".
* The pages in this region are allocated lazily whenever the range
allocator starts using the page.
* When the range allocator stops using a page, it is marked as unused
and put on an LRU list.
* There's a custom shrinker that can free pages not currently used by
any allocation.

So when process A sends a transaction to process B using the
appropriate ioctl, process A will go into the range allocator for
process B and reserve a range for the transaction that A is sending.
If any pages in the resulting range are missing, then new pages are
allocated, and process A will vm_insert_page them into process B's
mmap. Then, process A will map the page with kmap_local_page, and use
copy_from_user to copy data *directly* from A's userspace into a page
in process B's address space.

Note that transactions don't have uniform sizes. Think of them as
arbitrary buffers provided by userspace. They will generally not be
larger than a few hundred bytes each, but larger transactions are
possible. The mmap for a process is usually 4 MB.

The biggest user of Page is here in the RFC:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-19-08ba9197f=
637@google.com/

The range allocator is defined here:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f6=
37@google.com/

> > Rust Binder needs to manage pages directly as that is how transactions
> > are delivered: Each process has an mmap'd region for incoming
> > transactions. When an incoming transaction arrives, the Binder driver
> > will choose a region in the mmap, allocate and map the relevant pages
> > manually, and copy the incoming transaction directly into the page. Thi=
s
> > architecture allows the driver to copy transactions directly from the
> > address space of one process to another, without an intermediate copy
> > to a kernel buffer.
>
> Everything about this says "This is what a first year comp sci student
> thinks will be fast".  Oh well, the thinking here isn't your fault.

Ultimately, I am just replicating what C Binder does.

I had a long discussion with Liam Howlett at Plumbers where we
discussed various alternatives to the hand-rolled stuff that Binder
does. Liam thought that we may be able to replace the entire thing
with maple trees. These are things that I definitely want to
experiment with, but I am reluctant to try replacing the entire thing
with a maple tree, at least until I get Rust Binder into the kernel
tree.

In general, there are many places in Binder where we are hand-rolling
something that has an alternative elsewhere in the kernel, but
replacing them is not always trivial. The hand-rolled versions often
have Binder-specific optimizations that make it a regression to
replace it with the general thing.

> > @@ -127,6 +129,24 @@ int rust_helper_signal_pending(struct task_struct =
*t)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> >
> > +struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int orde=
r)
> > +{
> > +       return alloc_pages(gfp_mask, order);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
> > +
> > +void *rust_helper_kmap_local_page(struct page *page)
> > +{
> > +       return kmap_local_page(page);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
> > +
> > +void rust_helper_kunmap_local(const void *addr)
> > +{
> > +       kunmap_local(addr);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
>
> I remain opposed to all these fidgetty little helpers.  Particularly
> when they're noops on machines without HIGHMEM, which is ~all of them.

I don't disagree with you, but there's not much I can do about them. I
can wrap them in #ifdef HIGHMEM if they are no-ops or exported without
HIGHMEM?

> > +/// A bitwise shift for the page size.
> > +pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
>
> Does PAGE_SHIFT really need to be as large as 'usize'?  If it's more
> than 63 by the time I retire, I'll be shocked.  If it's more than 127
> by the time I die, I'll be even more shocked.  And it won't get to 255
> by the heat death of the universe.

Rust usually requires that both operands to an integer operation are
of the same integer type, requiring explicit conversions if that is
not the case. That is why I am using usize here.

However, it seems like Rust doesn't actually require that for the <<
operator, so I guess it doesn't matter much for this particular
constant.

> > +/// A bitwise mask for the page size.
> > +pub const PAGE_MASK: usize =3D PAGE_SIZE - 1;
>
> Are you trying to get somebody killed?
>
> include/asm-generic/page.h:#define PAGE_MASK    (~(PAGE_SIZE-1))
>
> Defining PAGE_MASK to be the opposite set of bits in C and Rust is
> going to bite us all day every day for a decade.

Oops, that's embarrassing. Thank you for catching that. I'll make sure
to change it.

> > +impl Page {
> > +    /// Allocates a new set of contiguous pages.
> > +    pub fn new() -> Result<Self, AllocError> {
> > +        // SAFETY: These are the correct arguments to allocate a singl=
e page.
> > +        let page =3D unsafe {
> > +            bindings::alloc_pages(
> > +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings=
::__GFP_HIGHMEM,
> > +                0,
> > +            )
> > +        };
>
> This feels too Binder-specific to be 'Page'.  Pages are not necessarily
> allocated with GFP_HIGHMEM, nor are they necessarily zeroed.  Maybe you
> want a BinderPage type?

We can add a constructor that takes a flag argument, so this type
doesn't necessarily have to be tied to those specific arguments.

Alice

