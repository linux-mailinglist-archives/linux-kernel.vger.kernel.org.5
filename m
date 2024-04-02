Return-Path: <linux-kernel+bounces-128820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAF895FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E692833C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA24205F;
	Tue,  2 Apr 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fBq6ghhy"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E503A1CB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099574; cv=none; b=sm6i/wubpLC7Y18srv4Enc32mhCb2xmPVxACs/bYzcfZ7wHz4AtTMahs7eGwe71YeddX5aZRcCJqzj06hMjjrOT/dwwYrycap1bqOOv2MK1A9LZ5Omy3q7DMN5RgZkXqPPhPebZXyr6WvSzngW3NwHVkTJPhgiRAZ0bxZog47z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099574; c=relaxed/simple;
	bh=ISUfOU57QgrLWxhCGJ/GHKVno9fuuJDzYoEuzYMJAlM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdVIu2nBfh2arzX9OQWreNj7MIt4rl8cUhtZNXOeUqMGjTUSlNvyzh0U22yO7k6S/uda8AKq/3BnhLy2CEknHNfoxnr/dgxMoN/62xnx+fDrqOF43uUxGCr40xteXRMM3XcjfF/2TfZFEFnLOgM1khdd5D+urIpI2/tkxU2Cfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fBq6ghhy; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=udn2gpk5o5abrkg5wd27zn4c7i.protonmail; t=1712099570; x=1712358770;
	bh=a9z7KkY1+VPo5bgUnt999smbqG9zGxvsVoJhcl2u2YU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fBq6ghhyMkczJShIhIj7q3jMiQonmrv0u5/Jxt8kS+1uxdrFkddxiHkrWfMdaa9nL
	 P9/v/DZ9TnAkQDRI8jFZxu2QC+IRKmBuStd4x3hCBbQdJPtsPUy1vjzMWKfUxOKQak
	 bBDoxH85PlKUdI6wxbx92gevDGQig3xI24XViNJcOoWbwkPwSna2gLHwvzh4lDr558
	 zqmMyabkyxtnqmz14PAWpgYx8MR2ObHK2Pfk00xUm+uwGwnsh16cAqPL2Km+ZmGZ8t
	 MGPx2gKMUztbkhs0ggH/GCOUTyWTImn7S71dbjh9v9N1qqSvIcBuOI4X8SI+epLLS1
	 B3jxXQtqxQc4A==
Date: Tue, 02 Apr 2024 23:12:45 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: sync: implement `Default` for `LockClassKey`
Message-ID: <0d6378ce-8099-4e04-b4a2-3663f01b8d9e@proton.me>
In-Reply-To: <20240401212303.537355-2-ojeda@kernel.org>
References: <20240401212303.537355-1-ojeda@kernel.org> <20240401212303.537355-2-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.24 23:23, Miguel Ojeda wrote:
> In the upcoming Rust 1.78.0, Clippy suggests to implement `Default` even
> when `new()` is `const`, since `Default::default()` may call `const`
> functions even if it is not `const` itself [1]:
>=20
>      error: you should consider adding a `Default` implementation for `Lo=
ckClassKey`
>        --> rust/kernel/sync.rs:31:5
>         |
>      31 | /     pub const fn new() -> Self {
>      32 | |         Self(Opaque::uninit())
>      33 | |     }
>         | |_____^
>=20
> Thus implement it.
>=20
> Link: https://github.com/rust-lang/rust-clippy/pull/10903 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   rust/kernel/sync.rs | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


