Return-Path: <linux-kernel+bounces-43254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A786841176
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647F11C231D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDF3F9E6;
	Mon, 29 Jan 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6sg7Flo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77A6F064;
	Mon, 29 Jan 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551206; cv=none; b=fNYd2u90g+1ARtcNAjxSiEdtjV2FdWtrhJR8kI8H+NGipGxxbUu97afPNK93ZuH2e1szK2xg0MbWzCQtXRiexETirWWCHhBYn9K+C3hqvt0YXFdRoYQ68l4tuu6dA5gB4WEMF2hjoq3A2ktxh57BEoXyWnOFzm5NdXAMrV7//S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551206; c=relaxed/simple;
	bh=PQPKnWvo8y+dj5G/W0m18inRi0Qo3ZLYZqplpuP1bt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv8E09QQKWO8sRtIwJH/OCBufkGMjyfFAXaGxTW0EohBOmPNx1bF2E7sBfAWhoS9O3IwogTDWMQuv0hEDaDpbO911XgFHUOZzIs4Zc9roo4ENxkMplAnILovSNhDALhUdSTZXpOORm0/+angIVQQZLuoK0sVvVHmAGk4+IkEWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z6sg7Flo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nUaCpWIQKZnRWHaoO9ygLf4yYLLy6m9z7KXvSuxXHYs=; b=Z6sg7FloIK7TT9Uz6gOs/cXEGW
	MMhZ3DDDlapkaIxgXoEcD+P/f28ZbpQ7wILt7c9kRuRbNeVVrc/047UE5fRz11/o1Lj/gldY7Pghq
	8rjcuvNZqxzRuvUgW2TuCb1haYVv2twq4AB0gntHlUhuI1KjLN6F9Stg7lotDcLOm/e5WSDFGI3N1
	93wMVUNYt0f1334r0l3wgENnU21gMFliEVVVWGGyY+rW8HfY+qDHDthxTN4Iqp/naKq+LhkehNgS6
	4MVS55mImQKFWR59qTlAR/ArUf2tk2cQb1u4XkJ8yTpWnh5QKjBBFFoNePYHxMUlG/YVHIJZKz6KD
	KTCfELAA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUVvF-00000007KGd-3pzC;
	Mon, 29 Jan 2024 17:59:53 +0000
Date: Mon, 29 Jan 2024 17:59:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Message-ID: <ZbfnmX1J8iLV8UnO@casper.infradead.org>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-alice-mm-v1-3-d1abcec83c44@google.com>

On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.

OK ...

> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method. Finally, the struct can be renamed to
> `Pages<ORDER>`, and the type alias `Page = Pages<0>` can be introduced.

This description concerns me because it reads like you're not keeping
up with the current thinking in MM about what pages are and how we're
improving the type hierarchy.  As in, we're creating one instead of
allowing the current mish-mash of absolutely everything to continue.

Are you the right person to ask about the operations that Binder does
with a page so we can figure out where it fits in the type hierarchy?

> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.

Everything about this says "This is what a first year comp sci student
thinks will be fast".  Oh well, the thinking here isn't your fault.

> @@ -127,6 +129,24 @@ int rust_helper_signal_pending(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
>  
> +struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
> +{
> +       return alloc_pages(gfp_mask, order);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
> +
> +void *rust_helper_kmap_local_page(struct page *page)
> +{
> +       return kmap_local_page(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
> +
> +void rust_helper_kunmap_local(const void *addr)
> +{
> +       kunmap_local(addr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);

I remain opposed to all these fidgetty little helpers.  Particularly
when they're noops on machines without HIGHMEM, which is ~all of them.

> +/// A bitwise shift for the page size.
> +pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;

Does PAGE_SHIFT really need to be as large as 'usize'?  If it's more
than 63 by the time I retire, I'll be shocked.  If it's more than 127
by the time I die, I'll be even more shocked.  And it won't get to 255
by the heat death of the universe.

> +/// The number of bytes in a page.
> +pub const PAGE_SIZE: usize = 1 << PAGE_SHIFT;

This is appropriately usize.

> +/// A bitwise mask for the page size.
> +pub const PAGE_MASK: usize = PAGE_SIZE - 1;

Are you trying to get somebody killed?

include/asm-generic/page.h:#define PAGE_MASK    (~(PAGE_SIZE-1))

Defining PAGE_MASK to be the opposite set of bits in C and Rust is
going to bite us all day every day for a decade.

> +impl Page {
> +    /// Allocates a new set of contiguous pages.
> +    pub fn new() -> Result<Self, AllocError> {
> +        // SAFETY: These are the correct arguments to allocate a single page.
> +        let page = unsafe {
> +            bindings::alloc_pages(
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
> +                0,
> +            )
> +        };

This feels too Binder-specific to be 'Page'.  Pages are not necessarily
allocated with GFP_HIGHMEM, nor are they necessarily zeroed.  Maybe you
want a BinderPage type?


