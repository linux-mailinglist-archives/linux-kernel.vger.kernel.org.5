Return-Path: <linux-kernel+bounces-126034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702CB89313A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B531C21323
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBAC7764E;
	Sun, 31 Mar 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="drQZw0N5"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57498763EC;
	Sun, 31 Mar 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711880872; cv=none; b=e6gMlreel5UHPKcXWnunhMQGoCd2rA86nQ+cTiFINgVFXBmGFYMlDog7vCjNbpptkM+1yNc2ZLiKGLi4pVBDWT68nobQAawBU5nhLGlevTdPfLhrsfqxHib6SDYEMICaDOgVIlOlEXuA7go0MxeelZPTwQjoQuMvGiH6GkLOcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711880872; c=relaxed/simple;
	bh=L/10QJEhsAIm7eEgjRvTrgcoaqTTGRJhJ9WBna1Dhzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0ks29nkeg+I722LXKQRyPvB2otD09yFrnak5ITlEnAPyTkSlhlLPMUsnTZyq2y0f6JT8yaLRg9IKaAbBRhoV7HjPOptvczG/SgN/OQPtWaVoW6NlRD9iUeFX9/fpqm3DN2hYK6ADYAAD/friSXDYPbPmaFtHlzv9hWFAsbiwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=drQZw0N5; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711880862; x=1712140062;
	bh=xXth9F6mwWUjnYOxzF4GaPch1yXF0oNpcQcxRS44w7o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=drQZw0N5x+P/gZGHHE0jckPV6Ol7xxWmHl241EVA4RqoHZXHzth9hx7sTbBfj4Ju1
	 8pOT0V6UUng3HHCl7BXMkwBefdE3p8A/5KDazXZB07HfNMOQJtA+CDLBT6q/zlyqOt
	 /N2Co0gmGH0WsdP77w9XkNIlQTOPOsjnNsx4MuhJpR0K+5mbXgvpAKHXxcDbYbmwAm
	 jsDoIUaQNFhBKSZfJJ91qnu+ru1ZKdsBBKwQ3KEFporLzFDvJM32o4+gO3LRHTzsUu
	 J5wCxK4v9QdcIiN1vliExlJWEdNH2R9RHfQdUESW7DNEOCuecKuDvDljcJvdy9OS0B
	 uuclS0MVnsaPA==
Date: Sun, 31 Mar 2024 10:27:37 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Finn Behrens <me@kloenk.dev>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: macros: fix soundness issue in `module!` macro
Message-ID: <d41d123e-d682-4685-88f5-e45567cc1975@proton.me>
In-Reply-To: <CANeycqp0o-HKBx6nuGCy9DD6mAwoGWzTR6bm5ceajsUhKcZuQg@mail.gmail.com>
References: <20240327160346.22442-1-benno.lossin@proton.me> <CANeycqp0o-HKBx6nuGCy9DD6mAwoGWzTR6bm5ceajsUhKcZuQg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.24 03:00, Wedson Almeida Filho wrote:
> On Wed, 27 Mar 2024 at 13:04, Benno Lossin <benno.lossin@proton.me> wrote=
:
>> +                    #[cfg(not(MODULE))]
>> +                    #[doc(hidden)]
>> +                    #[no_mangle]
>> +                    pub extern \"C\" fn __{name}_exit() {{
>> +                        __exit()

I just noticed this should be wrapped in an `unsafe` block with a SAFETY
comment. Will fix this in v2.

>> +                    }}
>>
>> -            #[cfg(not(MODULE))]
>> -            #[doc(hidden)]
>> -            #[no_mangle]
>> -            pub extern \"C\" fn __{name}_exit() {{
>> -                __exit()
>> -            }}
>> +                    /// # Safety
>> +                    ///
>> +                    /// This function must
>> +                    /// - only be called once,
>> +                    /// - not be called concurrently with `__exit`.
>=20
> I don't think the second item is needed here, it really is a
> requirement on `__exit`.

Fixed.

>=20
>> +                    unsafe fn __init() -> core::ffi::c_int {{
>> +                        match <{type_} as kernel::Module>::init(&THIS_M=
ODULE) {{
>> +                            Ok(m) =3D> {{
>> +                                // SAFETY:
>> +                                // no data race, since `__MOD` can only=
 be accessed by this module and
>> +                                // there only `__init` and `__exit` acc=
ess it. These functions are only
>> +                                // called once and `__exit` cannot be c=
alled before or during `__init`.
>> +                                unsafe {{
>> +                                    __MOD =3D Some(m);
>> +                                }}
>> +                                return 0;
>> +                            }}
>> +                            Err(e) =3D> {{
>> +                                return e.to_errno();
>> +                            }}
>> +                        }}
>> +                    }}
>>
>> -            fn __init() -> core::ffi::c_int {{
>> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {=
{
>> -                    Ok(m) =3D> {{
>> +                    /// # Safety
>> +                    ///
>> +                    /// This function must
>> +                    /// - only be called once,
>> +                    /// - be called after `__init`,
>> +                    /// - not be called concurrently with `__init`.
>=20
> The second item is incomplete: it must be called after `__init` *succeeds=
*.

Indeed.

>=20
> With that added (which is a different precondition), I think the third
> item can be dropped because if you have to wait to see whether
> `__init` succeeded or failed before you can call `__exit`, then
> certainly you cannot call it concurrently with `__init`.

I would love to drop that requirement, but I am not sure we can. With
that requirement, I wanted to ensure that no data race on `__MOD` can
happen. If you need to verify that `__init` succeeded, one might think
that it is not possible to call `__exit` such that a data race occurs,
but I think it could theoretically be done if the concrete `Module`
implementation never failed.

Do you have any suggestion for what I could add to the "be called after
`__init` was called and returned `0`" requirement to make a data race
impossible?

--=20
Cheers,
Benno

>=20
>> +                    unsafe fn __exit() {{
>> +                        // SAFETY:
>> +                        // no data race, since `__MOD` can only be acce=
ssed by this module and there
>> +                        // only `__init` and `__exit` access it. These =
functions are only called once
>> +                        // and `__init` was already called.
>>                           unsafe {{
>> -                            __MOD =3D Some(m);
>> +                            // Invokes `drop()` on `__MOD`, which shoul=
d be used for cleanup.
>> +                            __MOD =3D None;
>>                           }}
>> -                        return 0;
>>                       }}
>> -                    Err(e) =3D> {{
>> -                        return e.to_errno();
>> -                    }}
>> -                }}
>> -            }}
>>
>> -            fn __exit() {{
>> -                unsafe {{
>> -                    // Invokes `drop()` on `__MOD`, which should be use=
d for cleanup.
>> -                    __MOD =3D None;
>> +                    {modinfo}
>>                   }}
>>               }}
>> -
>> -            {modinfo}
>>           ",
>>           type_ =3D info.type_,
>>           name =3D info.name,
>>
>> base-commit: 4cece764965020c22cff7665b18a012006359095
>> --
>> 2.44.0
>>
>>


