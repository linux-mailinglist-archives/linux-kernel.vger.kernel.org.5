Return-Path: <linux-kernel+bounces-121645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E787688EB88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EEA29FBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8A14D299;
	Wed, 27 Mar 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CuZb1UjW"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3C130AF0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557937; cv=none; b=DRyDc621aGw2aKU8GipO9df1Klg8lglkT7b1VxD2yF7bXRHtNEF25wPM5anVBFQFepZ0QQnxpIw+C8YsP7BNU3t4QovkJHE6wBYmLCqzlagx4W9qCsxUGI2voExr3b9xNQOtmBGeA4hBp4MKJwZnze9SgnS8HElJBR+8262Xmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557937; c=relaxed/simple;
	bh=im+hs9xa1puCwNxQaY39vHOrcV3J947UuQJoHdhyznk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=decWeaJe45m4SwUmIb5IT1ELb8iK4QMKN5M8xtcD8D2F1DCCAkZTIxghQWon04KKXf5O8HhjAj7p14JvFoplZ2enqdqAOngHSrwY4lESfJcZkmjfb696at7kL8e/cRAU/PwlWSUl0j3syQtI/XhAAsjrlPkrJ5iUy5g+YzCP1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CuZb1UjW; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711557932; x=1711817132;
	bh=jF78QPjL6DlPZkbvtbKwmHduwM2y6T23zimXyjNJ41Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CuZb1UjWVr/UOJKrZSZyBj61bGhVXLe456n8AFnW2tvLiTeSYKkYySypKavni6vJI
	 Z15C2mwMGrB1QfPhzBx/hzzdpye+3VMa1l6MKw0TB72o3SHo6VmqT0aKD1cBisfWkP
	 IrOO3lzSBA8s7eymwHNN/0Wzug+oQu87WhMxT0TG41nrk5bs9Lz1u7KmrBSBhU3fOE
	 x29vcuDerzd+S+B5bxB1tDw1/47+KO84AokNvlrgie6Mq08TNc++1BXNJgaAQwvWbh
	 Z5bd276zDkEkG9YKBA5eb7mFB5svNkhu3enS2UWc5GERQphb+wWEBX4O30zLdNIU0v
	 KqI6RvN35a+pQ==
Date: Wed, 27 Mar 2024 16:45:11 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 02/10] rust: alloc: introduce the `VecExt` trait
Message-ID: <73c58833-71a9-493c-8f9c-78f7557ec3e2@proton.me>
In-Reply-To: <20240327023531.187880-3-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-3-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 03:35, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
> methods available in `Vec` even though it doesn't implement them. It is
> implemented with `try_reserve` and `push_within_capacity`.
>=20
> This is in preparation for switching to the upstream `alloc` crate.
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/alloc.rs         |  1 +
>  rust/kernel/alloc/vec_ext.rs | 48 ++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs           |  1 +
>  rust/kernel/prelude.rs       |  2 ++
>  4 files changed, 52 insertions(+)
>  create mode 100644 rust/kernel/alloc/vec_ext.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


