Return-Path: <linux-kernel+bounces-43458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE195841419
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862461F24A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39376053;
	Mon, 29 Jan 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLQTzX0B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF267602C;
	Mon, 29 Jan 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559565; cv=none; b=p/Co7MljbzCAc0m9vhHk2Ue5lYyok6vvweBqPjlNTjKdBkYBKIa19B4hlNoyNDEoacCYNZO5X0BfF42D3hilcu9gWPdGP1JSRfbx/pj18oEPlW0QqZso4+X68X+IZx334gBndHS8fu6fmhe3nsotm3FYuDLoshRPuiDiEYFVBvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559565; c=relaxed/simple;
	bh=zBCohKNvRGhj7gfexT0mPaUTjd2BuLf8CXnzCM5fCPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV1Snh7i1GLd4rYkRT77DrXLXa7BYuKhKj5QYKfdz463Yon4weKaMkIobtd/9I8VZUZGtTJDFQjtyLYEGGVrLibr7avYo1fKE3H66NWN9WI8a1tyjqgAOsT/a0Tx7aJpP5j42seRDqnEYwe7G+lESk1OcWKxn5YDmKvxq4ZHrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLQTzX0B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WAigPmVNmrZ4Q7NScBbnGOHfNcKGdxLaLpMpEktixVw=; b=fLQTzX0B2kYvB5i93Y4XIvbGMc
	dm9ecb4yVk5wybSuBljWIkleLuSyQ+mMl1Dxvj7yWn21F4JhMRWxn0+9oCv7tRwP6tdD+euHOiAhC
	Zo1XZHkbL/FLYK49Ucm0dmV/chfpFGtcKdy51xhkmwSVtH7CFvdq2xZMg1ZF9X81K2Le1kDaWcksS
	E22VHU7BwhPIgw0UT7SOS6zY26Hn0G42CRc08Ions+kWCPRGnglT3bs8H63h3B91lCJOj+ehwZkJw
	lYJpFLjfRvYD0rIXA99z0WQkDlD+kpDM92/1lTAZC+dAJxXroKVExnN8OJfIubl/tmp9v7wjLUOE8
	5Sp5KOeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUY63-00000007eMk-11Xv;
	Mon, 29 Jan 2024 20:19:11 +0000
Date: Mon, 29 Jan 2024 20:19:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Message-ID: <ZbgIP88JtKAP7hyP@casper.infradead.org>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
 <ZbfnmX1J8iLV8UnO@casper.infradead.org>
 <Zbf0-o-8m_V9gSzZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbf0-o-8m_V9gSzZ@google.com>

On Mon, Jan 29, 2024 at 06:56:58PM +0000, Carlos Llamas wrote:
> On Mon, Jan 29, 2024 at 05:59:53PM +0000, Matthew Wilcox wrote:
> > On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > > This patch only adds support for pages of order zero, as that is all
> > > Rust Binder needs. However, it is written to make it easy to add support
> > > for higher-order pages in the future. To do that, you would add a const
> > > generic parameter to `Page` that specifies the order. Most of the
> > > methods do not need to be adjusted, as the logic for dealing with
> > > mapping multiple pages at once can be isolated to just the
> > > `with_pointer_into_page` method. Finally, the struct can be renamed to
> > > `Pages<ORDER>`, and the type alias `Page = Pages<0>` can be introduced.
> > 
> > This description concerns me because it reads like you're not keeping
> > up with the current thinking in MM about what pages are and how we're
> > improving the type hierarchy.  As in, we're creating one instead of
> > allowing the current mish-mash of absolutely everything to continue.
> > 
> > Are you the right person to ask about the operations that Binder does
> > with a page so we can figure out where it fits in the type hierarchy?
>  
> I would guess you are suggesting a transition to folios here? I don't

I don't think folios are the right type to use.  Folios are for files and
anonymous memory; things which are managed on the LRU, have refcounts and
mapcounts, can be found with an rmap, need private data, belong to memory
control groups, belong to either an inode or an anon_vma, and so on.

It's _possible_ that Binder fits this use case well enough, but my
guess is that it needs its own type, or maybe it's the initial example
of a different type from folios (right now we have three types: folios,
slabs and ptdescs, but more are on their way).

> The only concern I have is that we've implemented a binder LRU-shrinker
> mechanism. We add the unused pages to our freelist and give them back to
> the system on demand. However, if a new transaction requests the unused
> page before it gets reclaimed it is simply removed from this freelist.
> This is convenient as we avoid taking the mmap sem during this process.
> I don't know how this mechanism would look with folios though?

This doesn't seem like too much of a problem.  The key thing is that
with memdescs, you get to define your own data type of whatever size
makes sense for you.  Until then you're limited to what we can fit into
a struct page (and we need to be careful not to step on stuff that other
people look at like the refcount).

