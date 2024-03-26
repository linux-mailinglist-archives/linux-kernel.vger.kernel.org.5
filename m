Return-Path: <linux-kernel+bounces-119541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1A88CA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286D0B277B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785481CD30;
	Tue, 26 Mar 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IhThkzkP"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443C1CA95
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472631; cv=none; b=Dn+s1YTvkljIzIRQaMiDz650iGFt0Q0JZ1h1dZfOHnaCoBXfOS6RVhTdzvsf3lWBSkkHV/29/JYlxYZRmKgUllMS7d9x6oNFCnfRvASTU0uFu8OMEzBJof9d7Ii405YxjHCE/Zw2of0gq6+KHpxwrCXvCenJXSucaMtr5SX0ioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472631; c=relaxed/simple;
	bh=wOZNZfomGTf09846FMrd2stSkyFpKdRYfI18SIaqofY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wtj0RzV+ZNcXzDz2gCHtvVjjzf4GooxJZJs484k7VBiZnXbqFWRlweMTmu3wEoBkpOpu8geoMWa3fO7sPYZQkJbJ1gTdKl907eZodyaDe6r+VtAxAIEP1wqsaHVjKEs0hcV+xsg2saDPefGGdUw0jI8ma9X+NCLwCDGI7bSnCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IhThkzkP; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4q2uozfqpzck3c7isjb5szza2i.protonmail; t=1711472627; x=1711731827;
	bh=rtXdk3BS/YRFaYMhxgJIWorIJjeDwKo7k6/Ds/zUnk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IhThkzkPWttmF06bgJPyLmmbKIqfLs4Zv341oKnGjka7RHSUH/HQZjg/luJtpzB9T
	 fF1exY1cbkHThksDlYw6h8S4FpzfWNjaqlwNE6gcJtgmqaWMo+NVuDBG/F749L8+5p
	 oj9NWhBK4yghTgxnS2HImZ2Nhga68jn0jyVWZcP71+xdTj4DI/4rZYhuPysNDaPqnF
	 7zGCvUYTUW54gP8EzHDVvdt8RXBZ7369ItneM1kovMPmLtw6ERps8AtBfpKPygzaS8
	 2R3EWjZBE0MRZQzdTWiq4UTAaRFTVQ4JV0m/QyMyM4LIZkoCnuISBfxZC3r8mJ9zpc
	 lsXT3t3PY6WCA==
Date: Tue, 26 Mar 2024 17:03:41 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>, Heghedus Razvan <heghedus.razvan@protonmail.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 4/5] rust: time: Support reading CLOCK_MONOTONIC
Message-ID: <4wFCQqSgpLIPmdFau6MTL1XLLB73d9Tuv5y-VFnXTDc1DFuTnmNV-GLtF582V5yz8s9ogWP_4U0NK3ei6sZlD1oLl929f8ADoT5K9bO6uKs=@proton.me>
In-Reply-To: <20240324223339.971934-5-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-5-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.03.24 23:33, Boqun Feng wrote:
> Rust Binder will need to read CLOCK_MONOTONIC to compute how many
> milliseconds a transaction has been active for when dumping the current
> state of the Binder driver. This replicates the logic in C Binder [1].
>=20
> For a usage example in Rust Binder, see [2].
>=20
> Hence add the support for CLOCK_MONOTONIC read.
>=20
> The `ktime_get` method cannot be safely called in NMI context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [3] or a similar tool will be used to check it in the future.
>=20
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830f=
ab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103 [2]
> Link: https://rust-for-linux.com/klint [3]
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

With the nit fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> @Alice, I still put the link to the usage of Android binder here, if you
> want to remove that, please let me know.
>=20
>  rust/kernel/time.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 0f9f5605ed48..5cd669cbea01 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -113,3 +113,22 @@ fn sub(self, other: Self) -> Self::Output {
>          Duration::new(self.inner.wrapping_sub(other.inner))
>      }
>  }
> +
> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source (`CLOCK_MONO=
TONIC`).
> +    pub struct KernelTime;
> +
> +    /// `CLOCK_MONOTONIC` is monotonic.
> +    impl Monotonic for KernelTime {}
> +
> +    impl Clock for KernelTime {
> +        #[inline]
> +        fn now() -> Instant<Self> {
> +            // SAFETY: It is always safe to call `ktime_get` outside of =
NMI context.
> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })

I don't think the turbofish syntax (the `::<Self>` part) is needed here.

--=20
Cheers,
Benno

> +        }
> +    }
> +}
> --
> 2.44.0
> 

