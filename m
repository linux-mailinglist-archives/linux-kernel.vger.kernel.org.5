Return-Path: <linux-kernel+bounces-125733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D1892B4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB261F21DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329862554B;
	Sat, 30 Mar 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MGxxuQcr"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB0125DB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805427; cv=none; b=c8dpjMgCBeqJQkwTmXAQUnzZOE2yFH71jSeUWBp4vWuXjqX1PKXvGNEtXAZ/5Us8rxmVF4D6ONTc7RMCbHC6Hb15l6ye1EX+i9knXOs8PkgXeR4Cf14Q9aDtZ17X3LdpfOVArupE9md86AXvkPdbvwvdTDh8t6gLq499EG70WSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805427; c=relaxed/simple;
	bh=GLLwLtiEelDru1aU0jJLyGv2vCHKaxAMXL3mAm4EGIc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6JuroylYZcs/MrEjN6DbxiS09VnrkAiqoVZxe1MWAN+4iG8WGopZFpUezSRrUt5Ers8xaS0uS06wtsBQI3uJr9E7uGcrq8+R4DTOx/yAvWoVpClOwfrCXTjnQVL/BWjiz7MKqyb7ZYnr8L8YT6k5vx9qN0eLMdgvseQmf3jLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MGxxuQcr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711805423; x=1712064623;
	bh=+HEtdPx7OqmXqU11OfG7F3JXZQBoM0zTuzWJZUMp+2c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MGxxuQcr8IDcwNs75Wb20ZUSh4dEwScMcwvr4+oBW1H1aF5OYZpns20LEjjMbfUUo
	 /IT0ZWxhu9Nv1SUShOWgh+grbfEGPGbvwKvHOmLL71f62SaLJ/5mysAiuIV+2BvmOX
	 AzeIjxotNW4ObdrOKteOPCuFNjbY56gKSk+L5V8xArLG5eSiuXEjtRbKna5cM4X39N
	 inXZ7IBj99QAHRpqMFis5Tb7m+Zu6mjbzRuqO+tQkYYYufj5ueytc1AxZ15WdJnxCG
	 CF77vZ4UCUnvY0n9fSQfx8hiU8IDKszenaXJybL4ypGaToUSirluVSTqWADeUTqSss
	 MCXgjZvF426EA==
Date: Sat, 30 Mar 2024 13:30:17 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 07/10] rust: alloc: update `VecExt` to take allocation flags
Message-ID: <59c5bda5-6116-42f1-bf8e-47eba02e2ecb@proton.me>
In-Reply-To: <20240328013603.206764-8-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com> <20240328013603.206764-8-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.03.24 02:36, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> We also rename the methods by removing the `try_` prefix since the names
> are available due to our usage of the `no_global_oom_handling` config
> when building the `alloc` crate.
>=20
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/alloc/vec_ext.rs | 158 +++++++++++++++++++++++++++++++----
>   rust/kernel/error.rs         |  11 +--
>   rust/kernel/lib.rs           |   1 -
>   rust/kernel/str.rs           |   6 +-
>   rust/kernel/types.rs         |   4 +-
>   samples/rust/rust_minimal.rs |   6 +-
>   6 files changed, 152 insertions(+), 34 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

[...]

>   impl<T> VecExt<T> for Vec<T> {
> -    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveErro=
r> {
> +    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, Allo=
cError> {
>           let mut v =3D Vec::new();
> -        v.try_reserve(capacity)?;
> +        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
>           Ok(v)
>       }
>=20
> -    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
> -        if let Err(retry) =3D self.push_within_capacity(v) {
> -            self.try_reserve(1)?;
> -            let _ =3D self.push_within_capacity(retry);
> -        }
> +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> +        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> +        let s =3D self.spare_capacity_mut();
> +        s[0].write(v);

I haven't checked the codegen, but this could result in an additional
bound check. We don't need to care about this now, but at some point we
should do a performance test. There are probably other things that I
have missed.

--=20
Cheers,
Benno

> +
> +        // SAFETY: We just initialised the first spare entry, so it is s=
afe to increase the length
> +        // by 1. We also know that the new length is <=3D capacity becau=
se of the previous call to
> +        // `reserve` above.
> +        unsafe { self.set_len(self.len() + 1) };
>           Ok(())
>       }

[...]


