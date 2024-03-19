Return-Path: <linux-kernel+bounces-106957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A987F5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91291C21B33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D147BB0D;
	Tue, 19 Mar 2024 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="PvYy4bbC"
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540B7BAE5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710818246; cv=none; b=KVFwXuj6c59OVEqLWAmjPDM5oZyg3/8e3NKZjPyyJtRveP/iF2fedeIG7T/HqImxR8yHVIF3bmJ4NvTdVPp5c6knGBGtuf+MSYOPk7sfeC+2HCby4435LIo90nUzwbMaa3LJ54LIHR9wiYj/XTXKws5cM6ca6qcV/+VnIuzir1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710818246; c=relaxed/simple;
	bh=zQcc3jxKfVQ2PUuIjCsWgbLI7wBdLmJQ1WeBWFM1saU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o4DQCpwu+ziZ3rU+C+8J8K/E9UZOLSQUH85qHt4ka+RxwPlDgsNlajMypDh0Nbf5UZeysgDYvM8VnJwUSVAkJiPwEDvMkIysjj40h1naaku/Omwfpv2jO9JHwwIOCvw/dVJcC9nLQPjen1D+MsxE1DQkLY6y3n/uYH/N7uKdxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=PvYy4bbC; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1710818244; bh=XGDkgB5unVzSxGvf5tmV1LkBUwsiz/E+a+Vzkcg7yZ8=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=PvYy4bbCdIXJWEwsy5MzB3cS6Q2JH23hg2zSzb0wP995crx2HGDsoT5tt0orjuzeW
	 sngf2Sq35dRa8qRBDxYQgnDG7704KtQIxIdUlv8n03bmsM5/LpGSQ+Ig5bA5EebZsF
	 HopdNOzwTsjYEcnI6Kqk5/7IkZB87qlY4EOw24KryPQJiiYIOAhU/RiBjrmt5S7+Qi
	 O1stTmY7I3pf7wyZYw98UeFtLjxy+proH0bLWmzwUcnX0iNjUk4+ZRTUD9SvhP2tzT
	 tk6eeqrRhLsHAaMskdBg2RN6kzXcBrXPqqnsXWFSh+T6/fj5Ic7hOh8a4fYro5Bdvn
	 yPqJk8wSimveQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 2527DD001E7;
	Tue, 19 Mar 2024 03:17:20 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
From: Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <Zfh5DYkxNAm-mY_9@boqun-archlinux>
Date: Mon, 18 Mar 2024 20:17:07 -0700
Cc: Benno Lossin <benno.lossin@proton.me>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-GUID: 0yLkaEkWSF4_UXEdezHhbfjnJH5PAumf
X-Proofpoint-ORIG-GUID: 0yLkaEkWSF4_UXEdezHhbfjnJH5PAumf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403190024

On Mar 18, 2024, at 10:25=E2=80=AFAM, Boqun Feng <boqun.feng@gmail.com> =
wrote:
> On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
>> From: Laine Taffin Altman <alexanderaltman@me.com>
>>=20
>> It is not enough for a type to be a ZST to guarantee that zeroed =
memory
>> is a valid value for it; it must also be inhabited. Creating a value =
of
>> an uninhabited type, ZST or no, is immediate UB.
>> Thus remove the implementation of `Zeroable` for `Infallible`, since
>> that type is not inhabited.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
>> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
>> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>=20
> I think either in the commit log or in the code comment, there better =
be
> a link or explanation on "(un)inhabited type". The rest looks good to
> me.

Would the following be okay for that purpose?

A type is inhabited if at least one valid value of that type exists; a
type is uninhabited if no valid values of that type exist.  The terms
"inhabited" and "uninhabited" in this sense originate in type theory,
a branch of mathematics.

In Rust, producing an invalid value of any type is immediate undefined
behavior (UB); this includes via zeroing memory.  Therefore, since an
uninhabited type has no valid values, producing any values at all for
it is UB.

The Rust standard library type `core::convert::Infallible` is
uninhabited, by virtue of having been declared as an enum with no
cases, which always produces uninhabited types in Rust.  Thus, remove
the implementation of `Zeroable` for `Infallible`, thereby avoiding
the UB.

Thanks,
Laine

>=20
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>=20
> Regards,
> Boqun
>=20
>> ---
>> rust/kernel/init.rs | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
>> index 424257284d16..538e03cfc84a 100644
>> --- a/rust/kernel/init.rs
>> +++ b/rust/kernel/init.rs
>> @@ -1292,8 +1292,8 @@ macro_rules! impl_zeroable {
>>     i8, i16, i32, i64, i128, isize,
>>     f32, f64,
>>=20
>> -    // SAFETY: These are ZSTs, there is nothing to zero.
>> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, =
Infallible, (),
>> +    // SAFETY: These are inhabited ZSTs, there is nothing to zero =
and a valid value exists.
>> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
>>=20
>>     // SAFETY: Type is allowed to take any value, including all =
zeros.
>>     {<T>} MaybeUninit<T>,
>>=20
>> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
>> --=20
>> 2.42.0
>>=20
>>=20
>>=20


