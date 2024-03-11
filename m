Return-Path: <linux-kernel+bounces-99044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0B8782BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6458283F45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ECE446C9;
	Mon, 11 Mar 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ASD/9UEH"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D743ADC;
	Mon, 11 Mar 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169493; cv=none; b=TI28fP1zwh2WyJL8DL6sRLB/k2hGNVJZBzby71xGbR/qhVvrcKu3FMFJ+DmyPiVYGhrFX7Pntmm0+qOtxpv3KYb94YM0KLfjqQlaVkPB5HSjh80L56IxokIEqDiqQ281C11guOPfG1kSYwswxeOT6FrJ5a0GDIMBUwb7GC11FUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169493; c=relaxed/simple;
	bh=rPsgfa/jUXlF5r6wmYl3H5nz8wyQaYnNMQgu78ADxjY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2ZHBsRdQKr/go3n2EeCz2fMaXebqElBDm2VOKL3ruiqQjDsQAePBLwIPAmb04v905wlY3VievaZw2NEVS6MwWQo4rMXTJzLktPCI8YAGKkJNnp6NQ41691774bsjW8SKhvtYCJ89m9MzymsQQ3w/R6Wws08a4Z0WFMjTLqMcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ASD/9UEH; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710169474; x=1710428674;
	bh=zjHIIFeLLaVTxCN34fAudxAbK5EtaRui6gv1zvCRSVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ASD/9UEHSWfJcYBolLhibajFVC0F4Uk5qIEsPLr3kEt2RCOrn0Dsw4+i4tRef80C6
	 7lHJ5QvzmZ5MpEpCYcysss5Y5gkTFTSaOiWnBnw9h2J12pQzED1VHD9uqElt4UqJnz
	 R39eB//CrgwG6rtC9ioQBCYV7btwXkenDmM7+TgBSjQZKdQsCNQ4xYeSaPKy4mhvrQ
	 dgJbrARDXxaL5OHGCTYFlPgwQZj7Bal+TUkod6LphVpgkXHAxTDTYC4IZCkb1XzkyE
	 5XG3WrwsHZPe3Br3W45KJ/rJn2nKLr9e+wh5D4QaZGF1i2RBepxwU7hP1rrUGktWM7
	 YS7l2ZJ1vpPPQ==
Date: Mon, 11 Mar 2024 15:04:27 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: sync: add `ArcBorrow::from_raw`
Message-ID: <4aef25d7-5135-4444-a461-fdef02f969e0@proton.me>
In-Reply-To: <CAH5fLggWwOLR0c-MR_p=Tw4vS8RHAEhJZsMLyx9rhYo=eVu+9g@mail.gmail.com>
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com> <20240228-arc-for-list-v2-1-ae93201426b4@google.com> <e09ed8fc-d305-4740-8c6e-7308a634b822@proton.me> <CAH5fLggWwOLR0c-MR_p=Tw4vS8RHAEhJZsMLyx9rhYo=eVu+9g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/24 09:58, Alice Ryhl wrote:
> On Sat, Mar 9, 2024 at 1:56=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>> +    /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously bee=
n deconstructed with
>>> +    /// [`Arc::into_raw`].
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// * The provided pointer must originate from a call to [`Arc::in=
to_raw`].
>>> +    /// * For the duration of the lifetime annotated on this `ArcBorro=
w`, the reference count must
>>> +    ///   not hit zero.
>>> +    /// * For the duration of the lifetime annotated on this `ArcBorro=
w`, there must not be a
>>> +    ///   [`UniqueArc`] reference to this value.
>>
>> I am a bit confused, this feels to me like it should be guaranteed by
>> `UniqueArc` and not by this function. Currently there is not even a way
>> of getting a `*const T` from a `UniqueArc`.
>> So I think we can remove this requirement and instead have the
>> requirement for creating `UniqueArc` that not only the refcount is
>> exactly 1, but also that no `ArcBorrow` exists.
>=20
> If you combine this with `into_unique_or_drop` that is introduced in
> the next patch of this series, then you could perform these
> operations:
>=20
> * Arc::into_raw
> * ArcBorrow::from_raw
> * Arc::from_raw
> * Arc::into_unique_or_drop
> * And then use the ArcBorrow
>=20
> If we drop the final safety requirement from `ArcBorrow::from_raw`,
> then the above would be allowed. The refcount does not hit zero at any
> point during these operations. The only unsafe functions are
> Arc::into_raw, Arc::from_raw, and ArcBorrow::from_raw, so this safety
> requirement must go on one of them. It seems to me that, out of these,
> ArcBorrow::from_raw is the most appropriate choice.
>=20
> Thoughts?

I see, it is a bit unfortunate that we have to put the constraint onto
`ArcBorrow::from_raw`, but I also do not see a better place. Thus:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


