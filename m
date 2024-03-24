Return-Path: <linux-kernel+bounces-112626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A4887C23
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD281F2176A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4D3171D1;
	Sun, 24 Mar 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="ulT+xelw"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3A171A2;
	Sun, 24 Mar 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711273622; cv=none; b=gf1dkgp/2hmGaoJ92iNLJs1PweJTqRKhE/Eeq6O8wZcqPT23+1DIqpyMmFHGBZnuqAlrXJcXRgTNdhNAjJjIGgaYVcQ6XhF+QauQuqasezcrmYuihRrsJVVIj0lECut/wgZ+lCD6IT0R/+Jz+td46D1q4OkJoxLKwi12VeMBQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711273622; c=relaxed/simple;
	bh=vg22wvRaImHSRK29DouL3P4j14EI5HioU/goXeuQ9Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM3jnqhATVvu4QOosTkH06d4XqhtK5vCWezWRvtn5k1E5dHOmUYrxYkdT5y6EowKTlgLFJxYR/6Sz9uoLm67chz82lJZ/harB1+dev6g7U4gwCN0jXskQG1dUUuXoGsTiD/4h203cY6qs5Uk6OuGgy+6Q4OlJ/tVdEeq3L8Nq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=ulT+xelw; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711273594; x=1711878394; i=kernel@valentinobst.de;
	bh=lHy1y6Ut+eu8IfdG9YkmmRwgAlBAOPmUhT80g/+ou1w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ulT+xelw3AL8dQR42xHakYbrq+fM+g0S2BYsYsX6qqMyNp4ETbAUx1cTTrt25m0n
	 oE9rWgtKFRe58SD3zLONrRXTFwjtjgJy0aqqKl+7knLK3dXxXWVZappb1nSMCvmCd
	 JGMjfULA4thymTXwPTfT1+3dbYDR3Udhd0us2GLq+kQnUVBqSn0Am5d9OTro4Aec0
	 J4qMPPtDvNXWm+XFh5VaObP7fkGYuDDliC14izWLmtADWDLC1CWb47r0VP9KraZdb
	 0KzSoZxjXlzBD4oTKPYYvvCSiZ/HiZukO5lhQSQfGdX7ryMxlvGq8GKIvtOtIuAjM
	 YZFt2U3fAhgZFAR+WA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.speedport.ip ([80.133.136.30]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MORR2-1rOOph1hJW-00Ptuv; Sun, 24 Mar 2024 10:40:27 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	heghedus.razvan@protonmail.com,
	jstultz@google.com,
	lina@asahilina.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	wedsonaf@gmail.com,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v2] rust: time: add Ktime
Date: Sun, 24 Mar 2024 10:40:23 +0100
Message-ID: <20240324094023.22317-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <Zf2kio8NYG5DEgyY@tardis>
References: <Zf2kio8NYG5DEgyY@tardis>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nzzrJCoj6NX4ScKNf3cE9I7BlD3VPm5Gm02o18PQBGUmaVQDxZI
 dCiOZmo+b0fi9z+78xk3llzXNs8sgCIfDuOd0Pa+eoRrVbDdOlbv1/8TNaFuj9cuDCtcDNf
 NBgqRnMJUTs/NQk/lN8MloHL6LMduGECsMtypxrmeRfidNB6WNttSxbs6BjVE+j8C3aW3SF
 ckJSBqmBSEEem0+vRFn1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YQ9nLrGc6/I=;kSJPO86pOaRelClRwbqa+ChiguD
 P32qYOc5mP3LWY4cPk2L9/64D9v8NeCyJRWzze/UyhFRhOqgHLUbDWixI2LFksC+bXQlwGl+o
 gS7bdUYHrACYgDxuyt8IN0y0I7oNKH0J1xQ10bDWbZHshSHeLUuYP8ZCtxeJTIPLonw82i7HU
 nVsEr1tw/ob3ULQgDU1FEMrq2l+xash2lc3sL25KkNwRphd/oOdGeIM79TOLGYqvJwBHr3lUm
 OH6e9BT75dCzvJ6Fi7OlWIMa7M6BiYjL6NGa/ibV6jESwSCGWVc8IHTRzoT1EO6A6j1KVhr1T
 wwBbYFfvr+8M7EZhJULski9qH89XM/Qvizjelh6rhFUXoFgoiJWYLKUaVLHkxpYfcrZdw9UG+
 DWY2iZMyK8t5nQ5RaEoccEl2ArWwwAWac4bY8us7VBCnx6DxZGEVIio7kkoVpCm2ajXwmUCQd
 hTRe4C4zTpLQDXFdhOdwhwiIXKCrkCvy327XyR54OrXuP1G+rARxeJllT6pm39wR4GAupFA76
 OfXOFEIQwl5timAgIcxwMpiTxE+NZgA4rTickFBZoAl96Wf88WW2UuZOw/xTQmA29v4TFWeJn
 CDEwAywaYxPPGkB8z7Bv11kg+Pk+8NRMhw18PuHfzNoyJq7edEe8027qd5aaOUNq6fQ3RFs6m
 ToVq8lueRtxeAwYdjzxv3VjkwIPPBVRxNOJ59BI0J3u7KJ6lykfl9dVnzcIyhdapbZ94/Rrf4
 1/TM7RTaL+7kjVC9Z/8UCGAQIJIklz32rWzofkN7HUJQwYtb9iXqVo=

> Subject: [PATCH] rust: time: Add clock source reading functionality
>
> Introduce wrappers around `ktime_t` with a time duration type `KTime`
> and a timestamp type `Instant`.
>
> Rust Binder will use these bindings to compute how many milliseconds a
> transaction has been active for when dumping the current state of the
> Binder driver. This replicates the logic in C Binder [1].
>
> For a usage example in Rust Binder, see [2].
>
> The `ktime_get` method cannot be safely called in NMI context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [3] or a similar tool will be used to check it in the future.
>
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830=
fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103 [2]
> Link: https://rust-for-linux.com/klint [3]
> Originally-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Originally-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/time.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 25a896eed468..50cc063aa9b4 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -4,6 +4,15 @@
>  //!
>  //! This module contains the kernel APIs related to time and timers tha=
t
>  //! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies=
h).
> +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> +
> +use crate::pr_err;
> +use core::marker::PhantomData;
> +
> +/// The number of nanoseconds per millisecond.
> +pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies =3D core::ffi::c_ulong;
> @@ -18,3 +27,152 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>      // matter what the argument is.
>      unsafe { bindings::__msecs_to_jiffies(msecs) }
>  }
> +
> +/// A kernel time duration.
> +///
> +/// This type basically wraps the `ktime_t` with one restriction: it sh=
ould only be used for
> +/// representing a time duration, in other words, it's not the type for=
 timestamps.
> +#[repr(transparent)]
> +#[derive(Debug, Copy, Clone, PartialEq, PartialOrd)]
> +pub struct KTime {
> +    inner: bindings::ktime_t,
> +}
> +
> +impl KTime {
> +    /// Create a [`KTime`] from a raw `ktime_t`.
> +    #[inline]
> +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> +        Self { inner }
> +    }

Eventually we might want to be able to create instances of types that
represent durations in const contexts, e.g., for fixed thresholds or
fixed offsets to relative timers. Would it make sense to '/fn/const fn/'
for the `KTime` (or `Ktime`) methods that support it?

[For that use case the naming/signature `from_raw(inner: bindings::ktime_t=
)`
could maybe also be changed to something like `new(duration: i64)`, i.e.,
make it sound less like an internal API.]

	- Best Valentin

> +
> +    /// Divide the number of nanoseconds by a compile-time constant.
> +    #[inline]
> +    fn divns_constant<const DIV: i64>(self) -> i64 {
> +        self.to_ns() / DIV
> +    }
> +
> +    /// Returns the number of nanoseconds.
> +    #[inline]
> +    pub fn to_ns(self) -> i64 {
> +        self.inner
> +    }
> +
> +    /// Returns the number of milliseconds.
> +    #[inline]
> +    pub fn to_ms(self) -> i64 {
> +        self.divns_constant::<NSEC_PER_MSEC>()
> +    }
> +}
> +
> +impl core::ops::Sub for KTime {
> +    type Output =3D KTime;
> +
> +    #[inline]
> +    fn sub(self, other: KTime) -> KTime {
> +        Self {
> +            inner: self.inner - other.inner,
> +        }
> +    }
> +}
> +
> +/// Represents a clock, that is, a unique time source and it can be que=
ried for the current time.
> +pub trait Clock: Sized {
> +    /// Returns the current time for this clock.
> +    fn now() -> Instant<Self>;
> +}
> +
> +/// Marker trait for clock sources that are guaranteed to be monotonic.
> +pub trait Monotonic {}
> +
> +/// An instant in time associated with a given clock source.
> +#[derive(Debug)]
> +pub struct Instant<T: Clock> {
> +    ktime: KTime,
> +    _type: PhantomData<T>,
> +}
> +
> +impl<T: Clock> Clone for Instant<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: Clock> Copy for Instant<T> {}
> +
> +impl<T: Clock> Instant<T> {
> +    fn new(ktime: KTime) -> Self {
> +        Instant {
> +            ktime,
> +            _type: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the time elapsed since an earlier [`Instant`], or None =
if the argument is a later
> +    /// Instant.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::time::{Clock, clock::KernelTime};
> +    ///
> +    /// let a =3D KernelTime::now();
> +    /// let b =3D KernelTime::now();
> +    ///
> +    /// // `KernelTime` is monotonic.
> +    /// assert_eq!(a.since(b), None);
> +    /// assert_eq!(b.since(a).map(|d| d.to_ns() >=3D 0), Some(true));
> +    ///
> +    /// ```
> +    pub fn since(&self, earlier: Instant<T>) -> Option<KTime> {
> +        if self.ktime < earlier.ktime {
> +            None
> +        } else {
> +            Some(self.ktime - earlier.ktime)
> +        }
> +    }
> +}
> +
> +impl<T: Clock + Monotonic> Instant<T> {
> +    /// Returns the time elapsed since this [`Instant`].
> +    ///
> +    /// This is guaranteed to return a non-negative result, since it is=
 only implemented for
> +    /// monotonic clocks.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::time::{Clock, clock::KernelTime};
> +    ///
> +    /// let a =3D KernelTime::now();
> +    ///
> +    /// // `KernelTime` is monotonic.
> +    /// assert!(a.elapsed().to_ns() >=3D 0);
> +    ///
> +    /// ```
> +    pub fn elapsed(&self) -> KTime {
> +        self.since(T::now()).unwrap_or_else(|| {
> +            pr_err!(
> +                "Monotonic clock {} went backwards!",
> +                core::any::type_name::<T>()
> +            );
> +            KTime::from_raw(0)
> +        })
> +    }
> +}
> +
> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source (`CLOCK_MON=
OTONIC`).
> +    pub struct KernelTime;
> +
> +    impl Monotonic for KernelTime {}

nit: blank line missing

> +    impl Clock for KernelTime {
> +        #[inline]
> +        fn now() -> Instant<Self> {
> +            // SAFETY: It is always safe to call `ktime_get` outside of=
 NMI context.
> +            Instant::<Self>::new(KTime::from_raw(unsafe { bindings::kti=
me_get() }))
> +        }
> +    }
> +}

