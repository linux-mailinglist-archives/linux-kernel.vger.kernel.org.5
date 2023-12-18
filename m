Return-Path: <linux-kernel+bounces-4094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0678177DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06305285407
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DB4FF6C;
	Mon, 18 Dec 2023 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DUFcRNPp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B61E4B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702918080; x=1703177280;
	bh=v9pawaLRbD7XrwXq4qwwGdgIqJMcYyLCy05mpVqZ3CA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DUFcRNPp7GOnQ+4wIEfz/C2icJzXFGsrbCoyU1El+zHbqH72NYFcNyY4f4Zuia4er
	 gSli4iaDXHMow1Alx9yqLiSZGIILWIQeALYV8iOhHkkTsRZjEx6M4rYJWAA00fypeh
	 8fj/QH/rDqch1AUleBFiLTLOoZ4YgUt79814entLObYZPx/5uPnPJiaaEeUYpWRY4i
	 w1U50XDd7zIg6dHx4nQwaz/9YLw6felElDtJF1Bwzeia52PfmYwuEis4QeBkmo0pNU
	 s9goCpzNdHA75ueJVslmo8g2O2xpGG8J+9F8A0WrycW4H5heDUgW6zTrcu5N8Y3NTV
	 yFbLFrElE0HRQ==
Date: Mon, 18 Dec 2023 16:47:42 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev, FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH] rust: support `srctree`-relative links
Message-ID: <1779a7c6-bacc-4c3f-a30d-0dcd6865e1e0@proton.me>
In-Reply-To: <20231215235428.243211-1-ojeda@kernel.org>
References: <20231215235428.243211-1-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/16/23 00:54, Miguel Ojeda wrote:
> Some of our links use relative paths in order to point to files in the
> source tree, e.g.:
>=20
>     //! C header: [`include/linux/printk.h`](../../../../include/linux/pr=
intk.h)
>     /// [`struct mutex`]: ../../../../include/linux/mutex.h
>=20
> These are problematic because they are hard to maintain and do not suppor=
t
> `O=3D` builds.
>=20
> Instead, provide support for `srctree`-relative links, e.g.:
>=20
>     //! C header: [`include/linux/printk.h`](srctree/include/linux/printk=
.h)
>     /// [`struct mutex`]: srctree/include/linux/mutex.h
>=20
> The links are fixed after `rustdoc` generation to be based on the absolut=
e
> path to the source tree.
>=20
> Essentially, this is the automatic version of Tomonori's fix [1],
> suggested by Gary [2].
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/r/20231026.204058.2167744626131849993.fuj=
ita.tomonori@gmail.com [1]
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Link: https://lore.kernel.org/rust-for-linux/20231026154525.6d14b495@euge=
o/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This is nice.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


