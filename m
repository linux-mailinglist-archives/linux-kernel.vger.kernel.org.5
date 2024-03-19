Return-Path: <linux-kernel+bounces-107390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C987FBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47C2283901
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF954BF7;
	Tue, 19 Mar 2024 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HCIfy9Nv"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4187E0FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844468; cv=none; b=G1PryhRNKv1ikiYklS5Ol1+AaPl+n4n3QWjTaIohRIkGsHVWjQdpWrmPC26cjDIQrK3Hex3yJY4PLKixCjUmw4IX1PEU2rC7aCOnAnvjXHPlVfOQyI/2L7NjC/uZVnoOYBNOCyFV49/MMrH5HyinKaNspHZLe8gzTLb+LLrcY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844468; c=relaxed/simple;
	bh=KLogwV2OS1MNnUFlL5AcMmAn08FTAGvABUZ8HooE6Y0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSCQcTnVfURMAL48XxQ5jIggQ4Hr6txX5EJtuiAe4eLGvyCRGanhjEej67FiG+mIlbY4W8Z/tLwtntwBBn7cMbbGD2yoOyTcj6gbKl0yoeg9BJ6uXHw+PEXmASdrSUcV6qhN1za1iBDH7EJTa+aCEvTdXTnhgYeRULgfPcdaoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HCIfy9Nv; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710844457; x=1711103657;
	bh=pnd8r6xQikPsi4m0u6vjrij5QyJs+H6K9/tYGMWmGiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HCIfy9NvbRmbm17kGo5n0tigQVz37JL7zfGqklTYumIlbsPvY7XExh5dtIdcTczIT
	 I1AV5Wk88OaoYqDoYKzvtDVdoLV3wEQMKK1+MqHFJzwbFT8CMJZ9hklIiUbEGikjdN
	 AJdJRkINSrjbHRcUJIndu/yR+Zcd/8INFK15njwznxXG5Id74unXcBxC/788C5mmzi
	 EdwNq5FPti953gzA37/8Dib4fDuyVS4QaVyaFV5xhiNtaJeCbN4znhrFvPkJoOhf28
	 EibK+rjMAyfhZSxlaH9erGsoGcIdeKG4Z2JjDkdcTlBTV86VdPWW/QX7wldluQQhKw
	 8qFHyq7fzEhqg==
Date: Tue, 19 Mar 2024 10:34:01 +0000
To: Laine Taffin Altman <alexanderaltman@me.com>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me>
In-Reply-To: <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
References: <20240313230713.987124-1-benno.lossin@proton.me> <Zfh5DYkxNAm-mY_9@boqun-archlinux> <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com> <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home> <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/19/24 06:28, Laine Taffin Altman wrote:
> On Mar 18, 2024, at 9:39=E2=80=AFPM, Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>> On Mon, Mar 18, 2024 at 08:17:07PM -0700, Laine Taffin Altman wrote:
>>> On Mar 18, 2024, at 10:25=E2=80=AFAM, Boqun Feng <boqun.feng@gmail.com>=
 wrote:
>>>> On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
>>>>> From: Laine Taffin Altman <alexanderaltman@me.com>
>>>>>
>>>>> It is not enough for a type to be a ZST to guarantee that zeroed memo=
ry
>>>>> is a valid value for it; it must also be inhabited. Creating a value =
of
>>>>> an uninhabited type, ZST or no, is immediate UB.
>>>>> Thus remove the implementation of `Zeroable` for `Infallible`, since
>>>>> that type is not inhabited.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zer=
oed` function")
>>>>> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
>>>>> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
>>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>>
>>>> I think either in the commit log or in the code comment, there better =
be
>>>> a link or explanation on "(un)inhabited type". The rest looks good to
>>>> me.
>>>
>>> Would the following be okay for that purpose?
>>>
>>> A type is inhabited if at least one valid value of that type exists; a
>>> type is uninhabited if no valid values of that type exist.  The terms
>>> "inhabited" and "uninhabited" in this sense originate in type theory,
>>> a branch of mathematics.
>>>
>>> In Rust, producing an invalid value of any type is immediate undefined
>>> behavior (UB); this includes via zeroing memory.  Therefore, since an
>>> uninhabited type has no valid values, producing any values at all for
>>> it is UB.
>>>
>>> The Rust standard library type `core::convert::Infallible` is
>>> uninhabited, by virtue of having been declared as an enum with no
>>> cases, which always produces uninhabited types in Rust.  Thus, remove
>>> the implementation of `Zeroable` for `Infallible`, thereby avoiding
>>> the UB.
>>>
>>
>> Yeah, this works for me. Thanks!
>=20
> Great!  Should it be re-sent or can the new wording be incorporated upon =
merge?

I can re-send it for you again, or do you want to send it yourself?
I think it is also a good idea to add a link to [1] in the code, since
the above explanation is rather long and fits better in the commit
message.

--=20
Cheers,
Benno

[1]: https://doc.rust-lang.org/nomicon/exotic-sizes.html#empty-types


