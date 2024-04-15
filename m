Return-Path: <linux-kernel+bounces-144870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC488A4C05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDC91C21E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CFB47A7F;
	Mon, 15 Apr 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jggoFhwR"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFD3BB25;
	Mon, 15 Apr 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174899; cv=none; b=PQmhOG9V/DmOBqLa7mjMpRIJ4C1YRgbODroePcU+XNUyLLPeStBirf2fWVUiakUoiUWtWYE2ptMdNohnAGzcALpAPy5OyHEjgJLpl5kLOIoyNq4p4RJkPvEoQV1HMKhoQBTmqH+YBGJYNwTAVLj0/fFK161SsRAchb8GbnV0DK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174899; c=relaxed/simple;
	bh=5g24jBRQ5fF3UkTMQfAJxotvoOH2so5edFW4DlrEWsw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJXQZU5+lMR0OPU2a8B06AvcmrUqje8D0z8OG+nrTDCnMm17x1b2RHHmclWZB7R5bf5UOfSy9iOZOa00/BBOGgfhiRdwQzCXXmqeyPEAxAN2N/DQpebC26LROksM0Q1JYYx0/pIppmRhmghlaSCYDcoU9lalWVqUZvYw9O1ualQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jggoFhwR; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713174895; x=1713434095;
	bh=t8wo9oBZ3T0/ktHZWfSC05XgtiqQfwhxlvieiuSqOyE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jggoFhwRhcdTbNRIjpMSKlUsYFgcBrwbZEv0XKICXZ8SZPsbHOcIXYuq/dxBy0cDF
	 qoDDh3Ni4OIeKz/VGQANYpA6Exrf2VZgtBS2maIQBHWev6wdib9L3F0vESKTl77V3O
	 LA3y+KsfIZiUOTlBzOnX11tuCPIMRExAHvRpoA8nM+5zF/V0cYolbZGa3HDk3vqeww
	 /B9Wn1zV3fPR+GToPiAHa6og1a/3BVIoFXlEDVUXds/WmpNsGuQlBSbexqvEETwZuG
	 yHi9RJhIugbXYN1o22owWxWSrtvAWJpOiFkCqp1F2rHvcT8Cchp0EjOQR0AKfOdxOi
	 CYBfqXaQQpd7Q==
Date: Mon, 15 Apr 2024 09:54:07 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 4/4] rust: add abstraction for `struct page`
Message-ID: <7918eb1a-2c3a-4c5a-b309-1306573dbd1f@proton.me>
In-Reply-To: <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.24 09:13, Alice Ryhl wrote:
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
>=20
> The page type has various methods for reading and writing into the page.
> These methods will temporarily map the page to allow the operation. All
> of these methods use a helper that takes an offset and length, performs
> bounds checks, and returns a pointer to the given offset in the page.
>=20
> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method.
>=20
> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.
>=20
> This code is based on Wedson's page abstractions from the old rust
> branch, but it has been modified by Alice by removing the incomplete
> support for higher-order pages, by introducing the `with_*` helpers
> to consolidate the bounds checking logic into a single place, and by
> introducing gfp flags.
>=20
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  20 ++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/page.rs             | 240 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 263 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


