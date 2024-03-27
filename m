Return-Path: <linux-kernel+bounces-120754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44988DC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601681C27EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2A51C5D;
	Wed, 27 Mar 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dPX6nrSl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434B7FBD5;
	Wed, 27 Mar 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539090; cv=none; b=IVu+D3R5wPgll+Jgv6BtedJWTV71mnwHaTR7uDfTDT3i84+yuAcc7EXRa5mkwEhvemCtsy4q/c1EBgt7Bj/8wraZyKwaugWUyx3YgZhuEkTSbqhKs2cNimN4h3bNauYPF2fgKvWVJ92gEZbp7D7RNtQrsADETPMbIcfgobukGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539090; c=relaxed/simple;
	bh=qlHAixuXWiIW20mFlDDIQCSWORvB+zfn/vDiVt8QhCM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVQszPe3/n88OBbB7/Y7HR0U5CME9OCyEOsFe2TZZz65I1wSoNPcvsaHtsoze/qROUNpQav230yKgwwyoVOoksGra0BTybSfXCJCdrVf70u6RW+KjIM6ypwDiOI1UohYS7NWA/TwIUbgAdXodslnH19/5a9BU24NSbnXs5U2m6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dPX6nrSl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711539086; x=1711798286;
	bh=YemPlwTUqK2re1xP2YFxKbLQSvS96km8r51Bibx9wFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dPX6nrSltm+a/i+1Q/lgDa617BzeAJM/Fk6Ac35gz+WA539tozygRNmaGTAZ21kaO
	 LRxTU+l43CZ5YK3ZDE/JWGlXUiQfpN7eD2E/zEjYOa9182iaaa3QQFq6sioBnFgSJw
	 62pwp8QVYwOmB83aSuoVy+IqdLXUu8KccdnEHmfMZhVIpsUFwYQgXtjVNv4bVvDjGB
	 6TxIJAdT7A/bxy5UHMd7WFq849eh61Ytltq2yJMmFO40XkLs4a+5oEVxSlr8eYbGmp
	 gmt4j5iu3wjdCGoy5JkaV6PYOIrTdu9SBWEHsYRdbJwJa08wQdHZFGmT+KH2lQINkS
	 S/V80fKuvs7dA==
Date: Wed, 27 Mar 2024 11:31:10 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>, Heghedus Razvan <heghedus.razvan@protonmail.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/5] rust: time: Add Instant::elapsed() for monotonic clocks
Message-ID: <9EAfAZHp8DflAFFp9hRs3vo2uuwLkwdGSRUVLQiIpCMHcKvjE95lT-VnO8DzJbL7u5Tw66qe-0_R56nwJsdcpeRGeS0794WzOPPexJZR9PA=@proton.me>
In-Reply-To: <ZgNxy70__7-x0c-8@Boquns-Mac-mini.home>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-6-boqun.feng@gmail.com> <kZmwObXVcyEJFVR3I05Nab0WdjcccDVARoOm6U9EmXhd89fxYRjvNmEAUZsueWTUlBlHp8jpU3i2YfgN9aWCLZameta0tPT_OgQdBOWUIko=@proton.me> <ZgMNVNOjoLH4S4Fb@boqun-archlinux> <ZgNxy70__7-x0c-8@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 02:09, Boqun Feng wrote:
> On Tue, Mar 26, 2024 at 11:00:52AM -0700, Boqun Feng wrote:
>> On Tue, Mar 26, 2024 at 05:13:38PM +0000, Benno Lossin wrote:
>>> On 24.03.24 23:33, Boqun Feng wrote:
>>>> This is a convenient way to do:
>>>>
>>>> =09t1 =3D Clock::now();
>>>> =09...
>>>> =09delta =3D  Clock::now() - t1;
>>>>
>>>> Hence add it.
>>>>
>>>> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
>>>> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
>>>> Co-developed-by: Asahi Lina <lina@asahilina.net>
>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>>> ---
>>>>   rust/kernel/time.rs | 25 +++++++++++++++++++++++++
>>>>   1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>>>> index 5cd669cbea01..cd1e45169517 100644
>>>> --- a/rust/kernel/time.rs
>>>> +++ b/rust/kernel/time.rs
>>>> @@ -114,6 +114,31 @@ fn sub(self, other: Self) -> Self::Output {
>>>>       }
>>>>   }
>>>>
>>>> +impl<T: Clock + Monotonic> Instant<T> {
>>>> +    /// Returns the time elapsed since this [`Instant`].
>>>> +    ///
>>>> +    /// This provides a convenient way to calculate time elapsed sinc=
e a previous [`Clock::now`].
>>>> +    /// Note even though the function only exists for monotonic clock=
s, it could still return
>>>> +    /// negative [`Duration`] if the current time is earlier than the=
 time of `&self`, and this
>>>> +    /// could happen if `&self` is a timestamp generated by a [`Insta=
nt`] + [`Duration`].
>>>
>>> But there currently is no way to add an `Instant<T>` to a `Duration`.
>>>
>>
>> This is kinda the disadvantages of "upstreaming the bits you only need",
>> we know for sure there will be a way to generate an `Instant` with an
>> addition of a `Duration`. I can of course provide that function in this
>> series. But let's settle down on "negative durations" first.
>>
>=20
> Hmm... I'd like to propose a change here. After some thoughts, I think
> we should have two timestamp types: `Instant` and `KTime`, where
> `Instant` represents solely a reading of a clocksource, and `KTime` is
> just the normal timestamp. This means the only way to get an `Instant`
> is via `Clock::now()`, and you cannot get an `Instant` by `Instant` +
> `Duration` (this could return a `KTime`). And a `Instant` can always
> `into_ktime()` return a `KTime` which support add/sub a duration. But
> again you cannot get an `Instant` from a `KTime`.
>=20
> Having this setup means for the same monotonic clocksource,
> `Clock::now()` is always later than any `Instant`, since any `Instant`
> must be created by a previous `Clock::now()`. And this makes a lot of
> sense. Moreover, I could introduce `KTime` in a later patchset, since
> `Instant` and `Duration` can fulfill the current requirement. We still
> need two duration types though...

I also wanted to suggest this. Another name for `KTime` could be
`Timestamp`. I think `Timedelta` is a good fit for a duration-like type
that allows negative values.

I don't remember exactly what binder needed the time stuff for, but
given that you cannot create negative durations with this design, I
think going for the `Duration` and `Instant` approach in this series
should be fine, right?
If then later you want to compute `Timedelta`s between `Timestamp`s we
can have another series.

>=20
> Regards,
> Boqun
>=20
>>>> +    ///
>>>> +    /// But for typical usages, it should always return non-negative =
[`Duration`]:
>>>> +    ///
>>>> +    /// # Examples
>>>> +    ///
>>>> +    /// ```
>>>> +    /// use kernel::time::{Clock, clock::KernelTime};
>>>> +    ///
>>>> +    /// let ts =3D KernelTime::now();
>>>> +    ///
>>>> +    /// // `KernelTime` is monotonic.
>>>> +    /// assert!(ts.elapsed().to_ns() >=3D 0);
>>>
>>> Now that I thought a bit more about the design, I think allowing
>>> negative durations is a bad idea.
>>> Do you disagree?
>>>
>>
>> So yes, I don't think allowing negative duration is really good design.
>> But as I mentioned in the cover letter, I hope to support cases where:
>>
>> =09d =3D ts2 - ts1;
>> =09ts =3D ts3 + d;
>>
>> =09(where ts1, ts2, ts3 is Instant, and d is of course Duration)
>>
>> without any branch instruction in the asm code. It's useful in the case
>> where ts1 is a old time base, and ts3 is the new one, and you want to
>> "remain" the delta between ts2 and t1 and apply that on ts3. To me there
>> are three options to achieve that: 1) allow negative durations (this
>> also mirrors what `ktime_t` represents for timedelta AKAIU), 2) have
>> a timedelta type that differs from Duration, and it can be negative, 3)
>> provide a function to do the above calculation for `Instant`. I choose
>> the first one because it's quick and simple (also easy to map to
>> `ktime_t`). But I don't have my own preference on these three options.

I think that if the strongest motivation for allowing negative duration
is "it is more performant, since we don't need as many branches", then
the motivation for disallowing negative durations is stronger.

I think having multiple types is the solution.

--=20
Cheers,
Benno

