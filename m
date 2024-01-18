Return-Path: <linux-kernel+bounces-29631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEFC831100
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A8C1F221D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB5567E;
	Thu, 18 Jan 2024 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="V8N2lGdo"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE95247
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542153; cv=none; b=brTaJjct8PRvlMXiJZM4y2oSYkROjztQ/vTl2QKMn5YmkgWop9wk/ps32KquTMh9ezqhVEgqbw93EflJXtVsvhBmAZF5G434tbvSXiCKC7m/zydUVu9H6uPUpTflag0R3eKInMDjBJoAZaY50539KdniCDzUWzAk3r2WuipgnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542153; c=relaxed/simple;
	bh=xlj2RHPaLDfZVJ5y56EGliycY2/ix8XuMk1/vpmzkzs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UTd96FNFRi0nfexf54cDfal7E6R3DZkPIqhjBSefBQbFMsyl6KUwfqhwfhWydTlMK8aiK7fI3OUg7lc4BGzcGkXtdwSC1LKRgv6+JJyDNq5YvFvbvvriwcYMez7XOzDvjLl7H79Y5GrBJ8FwHoWKGZiQ7iO1Vblg7TI7c+io2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=V8N2lGdo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7dc53ce0so6404387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705542149; x=1706146949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKVfUfnLIMhvvHy1U73q9X8dV57+YjQh0Y8dDSP0oFM=;
        b=V8N2lGdo6ure/t/Ux47MjY5YZUHD0MTR5j16ffsHH3Zg63896U7cyzptu2Y8ZRqm/2
         RznjGo7grxnHwSeS3oGtn2qJLBme0D6zSDRRoNq4hI+FGjzlKJ37UZfpjDmG44vCtpi6
         Z5Ba7RDarqXh60ku8xRfUJiGcSMhxmR792Fyai+7aSvfXVN386KNFDJWmKc5un+Pmp79
         +FE/RblqKFpwBEfUmHZeU2otP2SxGL1K7DH530zwx7i5PunQDgZFD+ZqCrT8buSNuvrX
         ZI5ut7LWjCw4NxXh/ZE8ZCkoqkxbGgTQ2/FXxye/439pnKH1bBCh3co1tdWd2fxpQyzx
         wE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542149; x=1706146949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKVfUfnLIMhvvHy1U73q9X8dV57+YjQh0Y8dDSP0oFM=;
        b=l/nhp5MmJ83gh3IxDokU0ZlRATJ01x72dkxP+nQdwvzhDmBhpNBaYD95w+AnI+Czb1
         2jNVar284C4sZwmx/Q5jiMLIVbYVATPJON7hN/Gb9lwXa9G181jXTE2y9YmvGA3V+YWc
         qV9iP00kw1izcbsjWyg5epOgcFeJW5wBCQfL+iBVMqBz2ypZK0F25mJN8SqYEopvcbTa
         69rkMXt3dhLjv7qdy5KUM7Vz47ZP5Q0dWx4GN3T0y+eQg5fdyXXDF0BOwhywVWjUQq9w
         AcLJZeTkSAi+SxQB4xqVbSuIA7ncE7rIl4nmcfxHEuDByuGBFe1DknmwcmQ7KiNiwJFB
         moNw==
X-Gm-Message-State: AOJu0YxX8iRwU7ZhdL9w679r1RZnLtGVp4fKvVPhlbFOPw/1JIABeRBX
	4LKbRlelfHqwYNr0dh0NuOAstwg96osvnXqAbjDjP0a0fVIBw7xcnFzqZC9+1Z+xtS5HzjP+tIS
	2jZchODBCavak4zDPPowmz5L1JW1M5LJg9EuStA==
X-Google-Smtp-Source: AGHT+IHzLskp3+LbSdEXItZfIpAuNLP0Q+26nlC7cFZ3ZCXbjl0VhD1AurNW479ztW9FR626TmuVrn9fIr4DRhfwg84=
X-Received: by 2002:a81:6c04:0:b0:5f8:5068:7645 with SMTP id
 h4-20020a816c04000000b005f850687645mr89906ywc.82.1705542149056; Wed, 17 Jan
 2024 17:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116231106.168864-1-kernel@valentinobst.de>
In-Reply-To: <20240116231106.168864-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:42:17 -0500
Message-ID: <CALNs47tWivxJhqjC-L8rLQKP420y1zCgCiHSZc5JPNbCVpwxgw@mail.gmail.com>
Subject: Re: [PATCH 10/13] rust: kernel: add doclinks
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:11=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Add doclinks to existing documentation.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/sync/arc.rs  |  6 +++---
>  rust/kernel/sync/lock.rs | 13 +++++++++---
>  rust/kernel/workqueue.rs | 45 ++++++++++++++++++++++++----------------
>  3 files changed, 40 insertions(+), 24 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 6c46b1affca5..936bc549a082 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -365,12 +365,12 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>  /// A borrowed reference to an [`Arc`] instance.
>  ///
>  /// For cases when one doesn't ever need to increment the refcount on th=
e allocation, it is simpler
> -/// to use just `&T`, which we can trivially get from an `Arc<T>` instan=
ce.
> +/// to use just `&T`, which we can trivially get from an [`Arc<T>`] inst=
ance.
>  ///
>  /// However, when one may need to increment the refcount, it is preferab=
le to use an `ArcBorrow<T>`
>  /// over `&Arc<T>` because the latter results in a double-indirection: a=
 pointer (shared reference)
> -/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] elimin=
ates this double
> -/// indirection while still allowing one to increment the refcount and g=
etting an `Arc<T>` when/if
> +/// to a pointer ([`Arc<T>`]) to the object (`T`). An [`ArcBorrow`] elim=
inates this double
> +/// indirection while still allowing one to increment the refcount and g=
etting an [`Arc<T>`] when/if
>  /// needed.

I think it is usually okay to only link the first usage in a section
or paragraph. No harm having more of course.

>  /// # Invariants
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 467249b39f71..f14179d19d4e 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -21,14 +21,21 @@
>  /// # Safety
>  ///
>  /// - Implementers must ensure that only one thread/CPU may access the p=
rotected data once the lock
> -/// is owned, that is, between calls to `lock` and `unlock`.
> -/// - Implementers must also ensure that `relock` uses the same locking =
method as the original
> +/// is owned, that is, between calls to [`lock`] and [`unlock`].
> +/// - Implementers must also ensure that [`relock`] uses the same lockin=
g method as the original
>  /// lock operation.

The second lines of these list items should probably be indented
(doesn't have to be in this patch).

> [...]
> @@ -290,10 +294,11 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> S=
elf::EnqueueOutput
>
>  /// Defines the method that should be called directly when a work item i=
s executed.
>  ///
> -/// This trait is implemented by `Pin<Box<T>>` and `Arc<T>`, and is main=
ly intended to be
> +/// This trait is implemented by `Pin<Box<T>>` and [`Arc<T>`], and is ma=
inly intended to be

`Pin` could be linked too.

> [...]

Just a few nits for this one, nothing blocking.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

