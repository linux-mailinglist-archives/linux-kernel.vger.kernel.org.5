Return-Path: <linux-kernel+bounces-110092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1878859F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0181C21A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9F84A54;
	Thu, 21 Mar 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7Bh47gm"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC95730E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027709; cv=none; b=uWGavIbVBbLcXKn6eYcO3R1Q+zT6Rv4NuqU7gneQ6ypYm5+Tn3mnCgR3G2GR9oE9GK5o2Igr8nnjKEPkFMmWwMe9+q+/gZeM6/laGm/f5IlCoJBuQi68aDJ18raPYP+2pdKNGhjIRjoN60F9VsCvk1MSBbJdD5XpXf0e86JTdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027709; c=relaxed/simple;
	bh=Fq8KLFQJSw1OvZB7PQpHngU+2ITGmNUv3F3KHyGJK8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHQBHtbPPXFGH7GHJkukrZlrxMtwZvJ1AAcJCHmI8mufyIdI25v7fu3rgDXYNIg958uJwD03VUzSwHEHyHzSD0u6UoWFNO2BrBQyIb1zgGYcdcxSY5KEjIWdg0SdO4QHFHYQWgv132CFQH6CFbm9jmIeHYt7LLZf/D2RcPN3dMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7Bh47gm; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e03e591693so377020241.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711027706; x=1711632506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWH+6eW0sGOMBcqq3GR/+5MQ85rnPGezuZLizVnSsrs=;
        b=S7Bh47gmFs7ZNPFCC1HtGc//w3tte6KUhETVhV1mXSi+p6SM7wAeHXGOm4s+iUmYZQ
         E0qfXt4LDO1ZHd3tkQb27pltMOxjJLtBgsbhgXRvm3OeXDZqlhf2/vfTkzfqEJ8kFozL
         KOpBVxR2K8n1G48KLUuWzEqa5lJKfFtkZ1FeM359E7orsTsxBTUwbHtBIG3frbL+QD83
         58FusM2sYlqZ+vbK7ShNAc9bzAvx4JA3+u5TR6ozPm7BadfQhsfm/z41qcvysxRQ0jpb
         R5aTZbRrDFyPipWnyibVV/G/a8En3MGb53+y4xC+Gl/KqhRuIyZ7SLIx1Tq9/0oVfrNA
         52Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711027706; x=1711632506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWH+6eW0sGOMBcqq3GR/+5MQ85rnPGezuZLizVnSsrs=;
        b=ikFMGWnxZQmAY1gc4jjryY9ei745+TMVjUR81gDH5SewCewWySzGVdHYIfcKUeo6Lr
         7t8eb4SVZcX2ud5eKq3VDmcblujwDFxZ0SA3bb70hfmVS3JaNbRWc9qq3Tm+DtjGAqSi
         we8bJ68Xg8PnHQpPRXYZzo3UEZRXt0IIkKsebCTiCjK+Oob9McOKgyd2UjZ6EMxqRB9Y
         fl2q2awn9DPyaf5KN04qY6yDaH6sh3/WpNYDp7wsHi7DrHutAhzwohIsI4n03gYR3x6g
         20Z7rvU5WCfyyTkOKwy+tmSImfqdkm2+Qy9vvsHUx+RvCXSu/uPmW0dLJsqthUg7sLZe
         QTSw==
X-Forwarded-Encrypted: i=1; AJvYcCXQWhKNG0nv/m0NVPaNmTaFVDVZ1cFjHxcBs3GcNnBlTmgYyq6qhzQC7NmvNl/BacLk91JDQprUcG0iHILJex4dOR4CW7cYHeHSkg/6
X-Gm-Message-State: AOJu0Yz+Gw2klFZRl+lmMmRG9SR8lqHKEvOgaE9hBaa1cZqP8nHe89nc
	pkqCoicNb1HoqqD0OJtV2/zLdepT9JsVLcQ3flegXIAfGdSjNClxIhX8sCNJgdLt14rBw+5QTUV
	vnwD25AkonpYwvJTwAIg5U5bA+eBFTvNgMMCf
X-Google-Smtp-Source: AGHT+IE+j+Qli1XePxAilxL5R4FQhkJSRHtQ+wFvcX+d7554bq37l+EQBnd62M0HSJSkW5gjbHPTrWC84iG4Aiv+Geg=
X-Received: by 2002:a05:6122:20a2:b0:4d3:36b9:2c26 with SMTP id
 i34-20020a05612220a200b004d336b92c26mr20776441vkd.14.1711027706376; Thu, 21
 Mar 2024 06:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-8-a37886783025@google.com> <20240320-massieren-lackschaden-9b30825babec@brauner>
In-Reply-To: <20240320-massieren-lackschaden-9b30825babec@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Mar 2024 14:28:15 +0100
Message-ID: <CAH5fLgjeet1nhycCqdaKE9CSY02XW85jn302zNEjJNQaJ1czGQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] rust: file: add `DeferredFdCloser`
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:22=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Feb 09, 2024 at 11:18:21AM +0000, Alice Ryhl wrote:
> >
> > +/// Helper used for closing file descriptors in a way that is safe eve=
n if the file is currently
> > +/// held using `fdget`.
> > +///
> > +/// Additional motivation can be found in commit 80cd795630d6 ("binder=
: fix use-after-free due to
> > +/// ksys_close() during fdget()") and in the comments on `binder_do_fd=
_close`.
> > +pub struct DeferredFdCloser {
> > +    inner: Box<DeferredFdCloserInner>,
> > +}
> > +
> > +/// SAFETY: This just holds an allocation with no real content, so the=
re's no safety issue with
> > +/// moving it across threads.
> > +unsafe impl Send for DeferredFdCloser {}
> > +unsafe impl Sync for DeferredFdCloser {}
> > +
> > +/// # Invariants
> > +///
> > +/// If the `file` pointer is non-null, then it points at a `struct fil=
e` and owns a refcount to
> > +/// that file.
> > +#[repr(C)]
> > +struct DeferredFdCloserInner {
> > +    twork: mem::MaybeUninit<bindings::callback_head>,
> > +    file: *mut bindings::file,
> > +}
> > +
> > +impl DeferredFdCloser {
>
> So the explicitly deferred close is due to how binder works so it's not
> much of a general purpose interface as I don't recall having other
> codepaths with similar problems. So this should live in the binder
> specific rust code imo.

Hmm. Are there really no other ioctls that call ksys_close on a
user-provided fd?

As far as I can tell, this kind of deferred API is the only way for us
to provide a fully safe Rust api for closing an fd. Directly calling
ksys_close must unsafely assert that the fd does not have an active
fdget call. So it makes sense to me as an API that others might want
to use.

Still I can move it elsewhere if necessary.

Alice

