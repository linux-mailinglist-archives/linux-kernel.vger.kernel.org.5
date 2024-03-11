Return-Path: <linux-kernel+bounces-99120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6178783A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B351F2126D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44C4E1CB;
	Mon, 11 Mar 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="acLkFnhn"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CD4CDE5;
	Mon, 11 Mar 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170116; cv=none; b=U7NDGSmakSZuzx5539m1t11NzXE7mqBBhhQn2w9ROFG3nc4a/SMryWJlQplr6kumvZx4q/HUyxemftdUSRZBwTVFWiB05fukm3Xachk6rnSw0ew7Wd1/Ab7FUMxxAd2i8C0zxLIjmVD09TbNdUP+bJDopkY55laJzP+2WRUz1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170116; c=relaxed/simple;
	bh=XhKg+cZDfP4nwiES2xcSxwW8Bp0lPtWE0a+CMh4TiHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOzg7HKebUJYNnkBbzglrZrIdtS4AvtcIzPZB8rVsWyKs5Kw7Nm9BShqmjQxWqM2F73gQnJDagY33h6TbuCDDG9Bp/FrsNUMlFf22XqKwbbrQRd7XppDKZRtS2bDMfqUaY6y+cNrLlj7ClS94Y5cvAaobHa7wqtvv80+VBLxp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=acLkFnhn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710170107; x=1710429307;
	bh=lvIfeHpCjGpzhOm0s3JzfmunEER00+7bS6vjwTGAn0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=acLkFnhna3Qw1IgdbexjecmXi8V7354RT7VL4FaPfplLHk7SsRygD/jbOAHvZCH7d
	 kWIkaEOjdlFrHnV9ZChUoxeJoaoYRKQzWbyRsGL2d7aCUASmD9ZqSt+WE3BP4+x6nS
	 TkVith2TxdnjCeEJ7AVYzgMf/KuoaUeR6fGdCr1XmFty3yRc1Vwyp5jHN1IviPt9g/
	 HoTTCouvKi/29S3gJ1+Uw+k0pGaP72oUxc4l9ryghJ31P1IukMWC9MdVD+6kfH+ffx
	 yEkRxKIyxe9wp/pDJrXHvIvnCp/rAtfhXp2AqJB2rcbHpruRwR1dcjuyQVgCEwM6JE
	 gkLCmwTVgMEhw==
Date: Mon, 11 Mar 2024 15:15:00 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
Message-ID: <7976d136-3cf7-427d-a047-41c29d25ad32@proton.me>
In-Reply-To: <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com>
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com> <20240228-arc-for-list-v2-2-ae93201426b4@google.com> <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me> <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/24 10:03, Alice Ryhl wrote:
> On Sat, Mar 9, 2024 at 2:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 2/28/24 14:00, Alice Ryhl wrote:
>>> +        // SAFETY: If the refcount reaches a non-zero value, then we h=
ave destroyed this `Arc` and
>>> +        // will return without further touching the `Arc`. If the refc=
ount reaches zero, then there
>>> +        // are no other arcs, and we can create a `UniqueArc`.
>>
>> This comment is not explaining why it is safe to call
>> `refcount_dec_and_test` on `refcount`.
>> It dose however explain what you are going to do, so please keep it, but
>> not as a SAFETY comment.
>=20
> I'll reword.
>=20
>>> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refco=
unt) };
>>> +        if is_zero {
>>> +            // SAFETY: We have exclusive access to the arc, so we can =
perform unsynchronized
>>> +            // accesses to the refcount.
>>> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INI=
T(1)) };
>>> +
>>> +            // SAFETY: We own one refcount, so we can create a `Unique=
Arc`. It needs to be pinned,
>>> +            // since an `Arc` is pinned.
>>
>> The `unsafe` block is only needed due to the `new_unchecked` call, which
>> you could avoid by using `.into()`. The `SAFETY` should also be an
>> `INVARIANT` comment instead.
>>
>>> +            unsafe {
>>> +                Some(Pin::new_unchecked(UniqueArc {
>>> +                    inner: Arc::from_inner(me.ptr),
>>> +                }))
>>> +            }
>=20
> The from_inner method is also unsafe.

Ah I missed that, might be a good reason to split the block.
It confused me that the SAFETY comment did not mention why calling
`new_unchecked` is sound.

> I think that using new_unchecked here makes more sense. That method is
> usually used in the case where something is already pinned, whereas
> into() is usually used to pin something that was not previously
> pinned.

I get your argument, but doing it this way avoids an unsafe function
call. I think it would be fine to use `.into()` in this case.
Splitting the unsafe block would also be fine with me.

--=20
Cheers,
Benno


