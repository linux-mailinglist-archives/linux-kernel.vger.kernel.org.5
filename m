Return-Path: <linux-kernel+bounces-108633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD9880D81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE91D1C209E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF63B791;
	Wed, 20 Mar 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vaqqdUZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2039AFE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924396; cv=none; b=Z/DB4uG/7fJ1jwdQm0yHTacGrMcL5r9IC8qonFfOpkGXMyWGHgYyOwNS0p0CmrXvY9CljIO2OvbBcEijLu/T2N72mH8HS0ErOyvmmyhA9uHNFe8/k0d32nyJ+NnyWwuJWpBo33Zprj93MAHNVy73ojfKAaSQxqXg8+p3iVMssz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924396; c=relaxed/simple;
	bh=Q4ONw+59Vbz8TiQ9wHPgnNATdK0mtXhgpFJ6lJ0jOhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iam70jvSEaYT+4Ym2yeq2u4YD+IUQTuOhqNZ2rU9I3GJh3w1/4HUiGxAp7oP0PTC3hBjfl6yq3Lhji+w6UECtBB6z9ZBu0BjDgY47p5EMFufn0jucL7sCha65X1CM8j42wQib/62lviE5OUoRtV+/61GVfP/t13h7hVdeL0ZptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vaqqdUZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so123837637b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710924393; x=1711529193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UK1n2ZUFasdNJS4tL/dUBZ9HzwBNAKoJUXbp2GIlPGA=;
        b=4vaqqdUZnGKFg+6XPkgEheNFHBlx5J/Q2SqcMubHub38gB9tO+l9OyOs6Q2uUtEYI+
         v4Xer7mgjPGEUWNw+q7AcfufydzBRIdPNgQ53z+Pofx3QFniRWIQpg5RehVdBT0tOrqM
         4LMESATryICogY53F6aY/oayfQmhOFAj9XqgidE1EMFoLAQV0NLfa4l6CqNAGtH8e3yx
         M3KW/SNsA+HTRVAPS8nIO18veKNf9SPpYiMmUCd/OKk3/HY6qCeklkqqaOXcLh9KBmCR
         vB1MgAlBaDO3zwIzP7jFM1APIcnRLzM+uDa+Oao1fZUsEvTECFkSP9JOrhQkU50VLDwX
         SG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924393; x=1711529193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK1n2ZUFasdNJS4tL/dUBZ9HzwBNAKoJUXbp2GIlPGA=;
        b=Aj1HWbNqUrXcH+iHjxbh63E+jNtios2cPyMdc3R5WqiR1VjW0YoT6phxB7BHI+WWy5
         SsCwD4EoPxgmFBna3DNx2O17tTOfD9VKCeEvR2XqXiBuDuVGz1WtB6yZtFRWJdh80Bp8
         tbLEydpIbuphiufQAZI03AqOXV7mWwYbeJ/JUEIHVymP/l3gEMyRVoGBaScoXhsE0YCE
         JJxHQg2xD/46MF+coWoGxtbtJODQEim4l0/seZnSD1YiAn9DAxZdEJ3g4JXI8O6HwPhd
         KurtX3UuuUMTqVBfljW1fPV0sDdGHbAwCdA4E51IYw8/8dYO+cZQbWYvr4RTFfsHdH8n
         mkjg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kJkDFBbIowuodW+NQkKk9D1u+qyh7HgzceM4v2s3v5aaFh0qui6Nov5kiiJU+bKa9HefZUz64Meu4vOAG5Ezb4bcTp1p/BHpzPmn
X-Gm-Message-State: AOJu0YzP2nymTuAPf1thjtbkonM6xRg3kz0xiRX5dvk4qvB+HuW6f7PM
	mZoZkQQ9Do28CwvLqKdMhTMTrzACdSqiEbY+dI7HAvkJGkbLDa3H51pWXomCz8C+aKZWNHkG0nh
	50nhjryUgfUEktw==
X-Google-Smtp-Source: AGHT+IHhO69PTaN4boKOvVHCOJk+p5noJ7sGfzArQ8mOhKPuKZfczEJL2sh4BtJrZ5uOiOp76ApjmtaKNMUWfnM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:124b:b0:dc2:398d:a671 with SMTP
 id t11-20020a056902124b00b00dc2398da671mr4614173ybu.10.1710924393527; Wed, 20
 Mar 2024 01:46:33 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:46:30 +0000
In-Reply-To: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320084630.2727355-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, arnd@arndb.de, arve@android.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

> On 3/11/24 11:47, Alice Ryhl wrote:
> > +/// A pointer to a page that owns the page allocation.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer points at a page, and has ownership over the page.
> 
> Why not "`page` is valid"?
> Do you mean by ownership of the page that `page` has ownership of the
> allocation, or does that entail any other property/privilege?

I can add "at a valid page".

By ownership I mean that we are allowed to pass it to __free_page and
that until we do, we can access the page. If you want me to reword this,
please tell me what you want it to say.

> > +// SAFETY: It is safe to transfer page allocations between threads.
> 
> Why?
> 
> > +unsafe impl Send for Page {}

How about:

// SAFETY: Pages have no logic that relies on them staying on a given
// thread, so moving them across threads is safe.

> > +// SAFETY: As long as the safety requirements for `&self` methods on this type
> > +// are followed, there is no problem with calling them in parallel.
> 
> Why?
> 
> > +unsafe impl Sync for Page {}

How about:

// SAFETY: Pages have no logic that relies on them not being accessed
// concurrently, so accessing them concurrently is safe.

> > +        // SAFETY: The specified order is zero and we want one page.
> 
> This doesn't explain why it is sound to call the function. I expect that
> it is always sound to call this function with valid arguments.
> 
> > +        let page = unsafe { bindings::alloc_pages(gfp_flags, 0) };

How about:

// SAFETY: Depending on the value of `gfp_flags`, this call may sleep.
// Other than that, it is always safe to call this method.

> > +        // INVARIANT: We checked that the allocation succeeded.
> 
> Doesn't mention ownership.
> 
> > +        Ok(Self { page })

How about:

// INVARIANT: We just successfully allocated a page, so we now have
// ownership of the newly allocated page. We transfer that ownership to
// the new `Page` object.

> > +    /// Runs a piece of code with this page mapped to an address.
> > +    ///
> > +    /// The page is unmapped when this call returns.
> > +    ///
> > +    /// It is up to the caller to use the provided raw pointer correctly.
> 
> This says nothing about what 'correctly' means. What I gathered from the
> implementation is that the supplied pointer is valid for the execution
> of `f` for `PAGE_SIZE` bytes.
> What other things are you allowed to rely upon?
> 
> Is it really OK for this function to be called from multiple threads?
> Could that not result in the same page being mapped multiple times? If
> that is fine, what about potential data races when two threads write to
> the pointer given to `f`?
> 
> > +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {

I will say:

/// It is up to the caller to use the provided raw pointer correctly.
/// The pointer is valid for `PAGE_SIZE` bytes and for the duration in
/// which the closure is called. Depending on the gfp flags and kernel
/// configuration, the pointer may only be mapped on the current thread,
/// and in those cases, dereferencing it on other threads is UB. Other
/// than that, the usual rules for dereferencing a raw pointer apply.
/// (E.g., don't cause data races, the memory may be uninitialized, and
/// so on.)

It's okay to map it multiple times from different threads.

> > +        // SAFETY: This unmaps the page mapped above.
> 
> This doesn't explain why it is sound.
> 
> > +        //
> > +        // Since this API takes the user code as a closure, it can only be used
> > +        // in a manner where the pages are unmapped in reverse order. This is as
> > +        // required by `kunmap_local`.
> > +        //
> > +        // In other words, if this call to `kunmap_local` happens when a
> > +        // different page should be unmapped first, then there must necessarily
> > +        // be a call to `kmap_local_page` other than the call just above in
> > +        // `with_page_mapped` that made that possible. In this case, it is the
> > +        // unsafe block that wraps that other call that is incorrect.
> > +        unsafe { bindings::kunmap_local(mapped_addr) };

Why do you say that? The kunmap_local method requires that the address
being unmapped is currently mapped, and that pages are unmapped in
reverse order. The safety comment explains that the page is currently
mapped and that this method cannot be used to unmap them in anything
other than reverse order.

> > +    /// Runs a piece of code with a raw pointer to a slice of this page, with
> > +    /// bounds checking.
> > +    ///
> > +    /// If `f` is called, then it will be called with a pointer that points at
> > +    /// `off` bytes into the page, and the pointer will be valid for at least
> > +    /// `len` bytes. The pointer is only valid on this task, as this method uses
> > +    /// a local mapping.
> 
> This information about the pointer only being valid on this task should
> also apply to `with_page_mapped`, right?
> 
> > +    ///
> > +    /// If `off` and `len` refers to a region outside of this page, then this
> > +    /// method returns `EINVAL` and does not call `f`.
> > +    ///
> > +    /// It is up to the caller to use the provided raw pointer correctly.
> 
> Again, please specify what 'correctly' means.

I will remove the "The pointer is only valid on this task, as this
method uses a local mapping." sentence and copy the same paragraph as
previously (without the `PAGE_SIZE` remark).

Alice

