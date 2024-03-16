Return-Path: <linux-kernel+bounces-105212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A787DA95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9ADB21427
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8651BDD5;
	Sat, 16 Mar 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wHcxnIeK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6211BC56;
	Sat, 16 Mar 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710603062; cv=none; b=ARg+tBTr2ZBqTd3cdDpUfnI+uRMNz3nBeAgAbqqqRxy/qeDb46eM7HCRbB7yiTfxzzqG0DSFFzTLdeEwvUJCqC6BvI10TkVKGAbevxLbQANuPmoWz+QiJZXyWxsj2Hdo7hDR8YfHx2NtJQlQQvxynhTVo7Jz/ryNnmGpiSYazy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710603062; c=relaxed/simple;
	bh=fSghzQs8kcGSEE7pAW2QaeYyUehledWsiTewKhhyC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuvIG41l40yDMbp2nWgBucMHov9gbTirFG2cyPZWS2UBOGzvpk5Q4rfJGJ71SMA8tNSPTflaofStxWzHDUwjsgl9MA7DI1jkHhXlSCSeXtQuZmikr95Do3BKsdN6vviTxhm0QKszHIlj8W4i+nPv0dNidRUXJdoSvWaUtcvpWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wHcxnIeK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6NKH9ylLcbG8QjuxQgDshz8FPMhAT6bvoDiWMjFubzQ=; b=wHcxnIeKUYQNDTuF/vCAGoKixu
	vbUOq7RhCmyJGKWswlyAgwqueuPTkAoiW+/nbx+rjweeOzxvXeAviBSZ1S0Qe7QNWULjD6vpFf1bT
	PAGvbvy7pfd4RvyX5yc2KyAU9LbJXDU1UXuxney98cKoNMn8wz5xovjF3JsDabhyVUL0ME3OJU9ss
	iyKFt5f1dikTI+jllk9QG8mX1fspoeSQA6KCeIHC1pLRvY6xfpuUu5HnAEqtI2x1TIzIVyKxlAc8H
	iyLoNEOPJ7MGebzzIP/hPnotIqq1WTbfbt2LqRsvPPNIJrcgk1lQ6HidsowW863QzXWqRZchaMFF0
	1lF2KLdw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlVzj-0000000ClgU-2tv5;
	Sat, 16 Mar 2024 15:30:47 +0000
Date: Sat, 16 Mar 2024 15:30:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, akpm@linux-foundation.org,
	alex.gaynor@gmail.com, arnd@arndb.de, arve@android.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
	gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, surenb@google.com,
	tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <ZfW7J2uS28hlFWcd@casper.infradead.org>
References: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
 <20240311105056.122734-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311105056.122734-1-aliceryhl@google.com>

On Mon, Mar 11, 2024 at 10:50:56AM +0000, Alice Ryhl wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> > +/// Flags for the "get free page" function that underlies all memory allocations.
> > +pub mod flags {
> > +    pub type gfp_t = bindings::gfp_t;
> > +
> > +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The caller requires `ZONE_NORMAL`
> > +    /// or a lower zone for direct access but can direct reclaim.
> > +    pub const GFP_KERNEL: gfp_t = bindings::GFP_KERNEL;
> > +    /// `GFP_ZERO` returns a zeroed page on success.
> > +    pub const __GFP_ZERO: gfp_t = bindings::__GFP_ZERO;
> > +    /// `GFP_HIGHMEM` indicates that the allocated memory may be located in high memory.
> > +    pub const __GFP_HIGHMEM: gfp_t = bindings::__GFP_HIGHMEM;
> > +}
> >
> > [...]
> >
> > +impl Page {
> > +    /// Allocates a new page.
> > +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocError> {
> > +        // SAFETY: The specified order is zero and we want one page.
> > +        let page = unsafe { bindings::alloc_pages(gfp_flags, 0) };
> > +        let page = NonNull::new(page).ok_or(AllocError)?;
> > +        // INVARIANT: We checked that the allocation succeeded.
> > +        Ok(Self { page })
> > +    }
> 
> Matthew Wilcox: You suggested on a previous version that I use gfp flags
> here, or that I rename it to e.g. BinderPage to make it clear that this
> is specific to the kind of pages that Binder needs.

I think what you have here is good.

> In this version I added some gfp flags, but I'm not actually sure that
> the Page abstraction works for all combinations of gfp flags. For
> example, I use kmap_local_page when accessing the page, but is that
> correct if there's a user that doesn't pass GFP_HIGHMEM?

Yes, kmap_local_page() works for non-highmem pages (it's essentially a
no-op)


