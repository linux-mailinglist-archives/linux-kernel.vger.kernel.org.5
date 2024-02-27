Return-Path: <linux-kernel+bounces-83514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA98869A88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E92872AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834F145B1D;
	Tue, 27 Feb 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CE81Ecs2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F3145337;
	Tue, 27 Feb 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048248; cv=none; b=OYjvTX04eLCdFDAuvXGP8xxt0WGIWu5TrrD6G/ZkJE/qhonF9MgAR3W82aeCOW/cQV7o4Yy8GKYW2I2WUWSBhcXqF4JLDC6gUwYO08rSKju60IjeIwW7wGyx9q01GR0cUW1Mb7oUkI7sPZE+9/rKEFqO44tKxziiUzmRkw62+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048248; c=relaxed/simple;
	bh=X81n8MnRy+roWIGU70795zeVAGENQmKZ8zQ4q9p1YG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CguvW4fiM0ZGs2uyKqDawRbni12PAJN91QfOiSWQMvawqC232RUB13J/Wy38lNVuLJIS8e8QkUkEqRENVo5sVTzzOjDURsu2vv61Gl0UILtMYPbSVS9UNfrsrAhzPMrpgK4O5lv38U3sDazX2pinqbKYg2oo+esmXWeOt6LXE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CE81Ecs2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=048Rd0Tnfw7wUdrVUDBOkaiJ20Lu58pUzR90H15XFkE=; b=CE81Ecs2WMvq5uJ4+l/IRss8nC
	cPO8AUcaqJV/X10HslcSeuRVYnBOqXQC7AeQYm6nPeryy/k+r7WspXf23n2wHzDQ1j9kX5GrSbwyP
	liiVgkvDPg/CTZL7M9vvERLT52Smk7Vpjeyx0ieaj4WtsukEUykYWpTCkxzHYmVEj/pTE2sLNLPv5
	z+7+tf2QUpUy3QdICA+EgCoN6pNma9oXxOjyostxHd8gmAB3HKiiM//a3K+Ombv4i/PND2Q9Xe3rj
	FgWfrqlgYPkOKTBpZMtGSOQsbRldl66R/rSQ5AvpHG7IOiPMe6serX2FTErKR8jo0INoJz4wZm8SY
	dFbvABwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezW3-00000002jiD-46dS;
	Tue, 27 Feb 2024 15:37:12 +0000
Date: Tue, 27 Feb 2024 15:37:11 +0000
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
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
Message-ID: <Zd4Bp6ohjb7H9poA@casper.infradead.org>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-alice-mm-v2-4-d821250204a6@google.com>

On Thu, Feb 08, 2024 at 03:47:54PM +0000, Alice Ryhl wrote:
> +impl Page {
> +    /// Allocates a new page.
> +    pub fn new() -> Result<Self, AllocError> {
> +        // SAFETY: These are the correct arguments to allocate a single page.
> +        let page = unsafe {
> +            bindings::alloc_pages(
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,

I thought I raised this last time, but this is over-specialised for
Binder's purposes.  Many places that want to allocate a page want
different GFP flags from this; they shouldn't even be the default flags.
So either what you're defining here is a BinderPage, or new() needs
to take GFP flags.


