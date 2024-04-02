Return-Path: <linux-kernel+bounces-127971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223E8953D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C071AB26558
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055747EF10;
	Tue,  2 Apr 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fQ9D4KJY"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537A335A7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062212; cv=none; b=l0lHbMjfak2CJvQMbfQsq6dXE8IOn9QKVuD0sl4zfISMFFnXo5OsjGspOgPPxzK9GuNGCm0FOBeleWa/BlWhVZ1/os4YrBXRQmYmnfXjYRnF+bs3dNdcnh9QKxtk3/flU72R++CU22X3I+brxJ5n5Gqsy36LklRmbqq28IK8ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062212; c=relaxed/simple;
	bh=YVfCRrIMjM3qNuE6jVIeiRm1+M5zgpz+svQs64HzCW0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSm9RcEbQPMbuMxws7MNQ+pX+REQDFYdwSxEyG9yQ+p5bDIc1gt+zCHZ4Z05w4sfrfJI9mcbHm5SCOQyp2BxmdsnhzD4tOBz4TBbb1N8mEGHlHOWH5oR8QgW+d/0/BbuicjUN7Zft9S7JbiyMGxgRG68MhY4oYkYoEpnySt6A0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fQ9D4KJY; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712062207; x=1712321407;
	bh=ZUFnwo0hp9HoIfPTPou9zjyCN3N2Lvg27XoRrnqIoh0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fQ9D4KJY95UiYMArX95Cts4UjPgLLnT/HzPfMsQYBPWBDdL/yQNLKDp5xLSDyg0nW
	 xg88m7J2ayG01IAueCEPNQl6YxVwwJ9gAYJ8zXnHIEQdTUz9Amwvo7lOlcOsp3SZzI
	 hyFHkJ35hY2+OCToMYVaXrmfxRUNCs0S32JdEc9PvCZ/rF0Iv4XlpcU+9NtxXn7a7k
	 Z/UTfjZ83lik9QA4RCP0NO3mOMUTXnQ9EuO8IV5VhjhP5yINlbNtZX9P/5b8dLI4o0
	 dvE8L/+hw5WxFYn5cygGxZJREviNxukFVacXSwC1wDcnKa3AkgyrSRyvcKh9Mz2LjY
	 7XEpFRJ2jhLPQ==
Date: Tue, 02 Apr 2024 12:49:58 +0000
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Obei Sideg <linux@obei.io>
Subject: Re: [PATCH] rust: types: Make Opaque::get const
Message-ID: <512ad3fa-37d0-470e-9f4c-bd185d9b897f@proton.me>
In-Reply-To: <20240401214543.1242286-1-boqun.feng@gmail.com>
References: <20240401214543.1242286-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.24 23:45, Boqun Feng wrote:
> To support a potential usage:
>=20
>      static foo: Opaque<Foo> =3D ..; // Or defined in an extern block.
>=20
>      ...
>=20
>      fn bar() {
>          let ptr =3D foo.get();
>      }
>=20
> `Opaque::get` need to be `const`, otherwise compiler will complain
> because calls on statics are limited to const functions.
>=20
> Also `Opaque::get` should be naturally `const` since it's a composition
> of two `const` functions: `UnsafeCell::get` and `ptr::cast`.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>   rust/kernel/types.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


