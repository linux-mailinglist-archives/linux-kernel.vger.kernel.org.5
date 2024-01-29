Return-Path: <linux-kernel+bounces-43374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B98412DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD7F1C23CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696141401B;
	Mon, 29 Jan 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i88g7+CT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076614290
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554625; cv=none; b=bXVWK4Kdf10q/XKkCep9lvSfg0vlqgxSwebYxDPFHcmgcequ0MsLJ+1/Bzx8VzkN+bEf596mVk848cyvbHuhXf6YZRjTn+aPXF8nORCu+OWiTcDOyvMQPRrldY7kteHGFBpA0To9UpYM30WEheE3UrlKDlNobeiraydGSCso7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554625; c=relaxed/simple;
	bh=eCIKHW25tT2p1LrDRn9zEEidOIc6tF2QdISFO0hrmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0NY2EvYMACX4HqrHFG8ktj26wxrfgBk8+kK/1Xkv1RXuxpKJF9mPu12RLI1glJ+5PVUTZCLC3C+CShI1yBTnG8NzDN6HG7HbxUlQulDJvaYQO5C7LSc03sb4XzntZgs8LZKJdgP7lP4tsK2BCvb5PIiojBJ3dUfbx9RqnDGKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i88g7+CT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d8da50bfd9so6412595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706554623; x=1707159423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xb1se6XYnX/io6AeNksDGE+479xc8/XFvlgChDKCPRM=;
        b=i88g7+CTIgXwbCU7uf1TZyk47slqQsiLyoXfovCffjXY5Gz7Ypxlef+vTIY67M1qMH
         wQvYktRoFg4xOhv9bhpqv1NUFh4rCpD9HPtEWUtCSOmg3DoeWmj4LZ23cwAKMNawBBmG
         3rhQltjSH1u1JaXSGsxUFOGaKzVi/QGxbuzOeKpnR8GfNEr8qALHK0aWP6GGQhn6GZoF
         PlIIs2uPDYzSUbqpE2s2DML2lfm8TPuxKsJ/5XUpU2F+vwadM/hNPJkv+NiFlffA7d0V
         FzKO1v7Q40p11OPOonrm+5xi/NOf2xDPrFGoEBlFJM6GZbysXc6eGUzhm+roBXJUqnNB
         OwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554623; x=1707159423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb1se6XYnX/io6AeNksDGE+479xc8/XFvlgChDKCPRM=;
        b=ZU/KoEPKaJC0/xCVLRw1f1GAdpCQyBqVamuL7c9OQaA5KMgz/+PU6G8YgJU9KkurB6
         jBrSQ4fzXT1YnXB0zmowKjyXxVal2b9EyLPIRV1fhxSrj/6bVGZhWmtk/wBii/i/qvfX
         zdV0nvskqcdj/Lt4Tjh1vOg6PzXjJ9YywPZRkz3aLvvKn4Fn1xCunguyG3X6qee4VOBz
         gHifuHETHg22KY7C3Jsc8fwop4Iw+yAe314MJsUyodjI+Nkg1HpopqKnmrD67AsFObYj
         xb2NeVvjbAFEkMdoA8cr1cLpaG3GITZ4dyb3AkB292esEMLsR+Et826mZIdysnKAIvEZ
         wqnA==
X-Gm-Message-State: AOJu0Yy581LwPCRig1V04/AB7/xCWf7aM2dwUK88ZWgEvYyPoFfkMZRq
	JxyQgZ8JNtwH+Xi5b9aBIArNSCLtDnMhZK18EFCBvWPxY6XhWBhN5I8EL99fdw==
X-Google-Smtp-Source: AGHT+IHDPJf6Cs1/rFQndlGrqInaTjASmhMPFG6hMvQzgDeukzrXVXyHNQnpPCxBHxyveq9IHhfIWg==
X-Received: by 2002:a17:902:d2ca:b0:1d8:faf7:7f77 with SMTP id n10-20020a170902d2ca00b001d8faf77f77mr1125402plc.24.1706554623320;
        Mon, 29 Jan 2024 10:57:03 -0800 (PST)
Received: from google.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902724600b001d8aadaa7easm4827584pll.96.2024.01.29.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:57:02 -0800 (PST)
Date: Mon, 29 Jan 2024 18:56:58 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Zbf0-o-8m_V9gSzZ@google.com>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
 <ZbfnmX1J8iLV8UnO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfnmX1J8iLV8UnO@casper.infradead.org>

On Mon, Jan 29, 2024 at 05:59:53PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > Adds a new struct called `Page` that wraps a pointer to `struct page`.
> > This struct is assumed to hold ownership over the page, so that Rust
> > code can allocate and manage pages directly.
> 
> OK ...
> 
> > This patch only adds support for pages of order zero, as that is all
> > Rust Binder needs. However, it is written to make it easy to add support
> > for higher-order pages in the future. To do that, you would add a const
> > generic parameter to `Page` that specifies the order. Most of the
> > methods do not need to be adjusted, as the logic for dealing with
> > mapping multiple pages at once can be isolated to just the
> > `with_pointer_into_page` method. Finally, the struct can be renamed to
> > `Pages<ORDER>`, and the type alias `Page = Pages<0>` can be introduced.
> 
> This description concerns me because it reads like you're not keeping
> up with the current thinking in MM about what pages are and how we're
> improving the type hierarchy.  As in, we're creating one instead of
> allowing the current mish-mash of absolutely everything to continue.
> 
> Are you the right person to ask about the operations that Binder does
> with a page so we can figure out where it fits in the type hierarchy?
 
I would guess you are suggesting a transition to folios here? I don't
think there is anything in binder that would impede such a change. The
core idea behind binder IPC is to skip kernel buffering and perform
instead a "copy-once" of messages across users memory. In theory this
seems efficient but I haven't seen any data proving so. So take that
with a grain of salt.

The size of these binder messages is not limited per se and can trigger
the allocation of multiple pages. However, in reality the vast majority
of transactions are under 1K payload. FWICT, it seems reasonable to
switch over to folios.

The only concern I have is that we've implemented a binder LRU-shrinker
mechanism. We add the unused pages to our freelist and give them back to
the system on demand. However, if a new transaction requests the unused
page before it gets reclaimed it is simply removed from this freelist.
This is convenient as we avoid taking the mmap sem during this process.
I don't know how this mechanism would look with folios though?

--
Carlos Llamas

