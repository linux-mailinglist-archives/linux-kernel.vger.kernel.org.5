Return-Path: <linux-kernel+bounces-131633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6B898A44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8031F2D19B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F31BC46;
	Thu,  4 Apr 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T9sxEjyu"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98E12B95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241419; cv=none; b=E1JhKMECjjaxSMBejn3MvE4kPg00tHFS2FMgVd0Gx/u/5Wz8Gz//XK7ZQBFjZkZbRygTl/5tAv3Te1w6tqv9IDNuB+XAgUiWq9OW2ywIrAkvWK++5VycoTsBPrG+Zugrs3i/Z3+eLtPo/lfCxfEmMeRiBj8jidnjkw/vnBY8ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241419; c=relaxed/simple;
	bh=g5tQ467b5au3ekidhW50/WYDE3pKT7OHsNVp75ID7vE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=na/FB4WVrvmTRHsOYDX0c7zMekKF/0oQHlDJqQk38LI/T+WAl4hjsHVq7g6/tlxL+FfGticDVKATZVjIl1pWgCG1CKSvL5j0zd2eftEhvAKX6Y8fAvwcx0Xmlp2jmX8arg/XGW9XJNxJdY4AjCyJkXpWyiZU1zqA3cSykPNS5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T9sxEjyu; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712241408; x=1712500608;
	bh=sFcdFq5/NQHONR503i97zG4JgDNzJtYW69mQiJroSFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T9sxEjyulG6zzMsMry2SYr2AC7rDKl89spkDwlwT8RGW07Mu2TSMZsKteSG3I5gBY
	 MVUB6lJ2GaeTMS20gDHWvA12BHj1fiiEt139/WDiYKtHB1Uo8DGJYfQaPCei4s6Mkj
	 L+xvQWLrs3cK1JJ3UmEMy5g8okyrExCVgyM3NSJlnmOBv1hL5WDDHNHzc/YgfFA52p
	 OxB3zePnxdYIi8VrJ9Ubfu5ogfYRzdpazUX/CL/nix1OmH6j/NVUPhgTj//0L4Jb8L
	 wY152tO2DfAvPaRsMqmxCGdZXntQrJvT7v+p9PZMCvy7KYPGgz9ryGp92vtu3RAHDd
	 UZeb1vpZnOYlw==
Date: Thu, 04 Apr 2024 14:36:42 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 6/9] rust: list: add iterators
Message-ID: <98449574-4c1b-4281-bbd3-3ac2767020cb@proton.me>
In-Reply-To: <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:17, Alice Ryhl wrote:
> @@ -414,3 +427,92 @@ fn drop(&mut self) {
>          }
>      }
>  }
> +
> +/// An iterator into a [`List`].
> +///
> +/// # Invariants
> +///
> +/// The `current` pointer points at a value in a list, or it is null if =
the iterator has reached

I think "list" should link to [`List`].

> +/// the end of the list. The `stop` pointer points at the first value in=
 the same list, or it is
> +/// null if the list is empty.
> +#[derive(Clone)]
> +pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> +    current: *mut ListLinksFields,
> +    stop: *mut ListLinksFields,
> +    _ty: PhantomData<&'a ListArc<T, ID>>,
> +}
> +
> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<'a, =
T, ID> {
> +    type Item =3D ArcBorrow<'a, T>;
> +
> +    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
> +        if self.current.is_null() {
> +            return None;
> +        }
> +
> +        let current =3D self.current;
> +
> +        // SAFETY: We just checked that `current` is not null, so it is =
in a list, and hence not
> +        // dangling. There's no race because the iterator holds an immut=
able borrow to the list.

This (that the iterator holds an immutable borrow) is not true (there
is no `&List` field in `Iter`), but you can make that an invariant
instead.

> +        let next =3D unsafe { (*current).next };
> +        // INVARIANT: If `current` was the last element of the list, the=
n this updates it to null.
> +        // Otherwise, we update it to the next element.
> +        self.current =3D if next !=3D self.stop {
> +            next
> +        } else {
> +            ptr::null_mut()
> +        };
> +
> +        // SAFETY: The `current` pointer points a value in the list.

Typo: "points a value" -> "points at a value"

I think you should also use consistent naming when referring to the
elements/items/values of a list.

--=20
Cheers,
Benno

> +        let item =3D unsafe { T::view_value(ListLinks::from_fields(curre=
nt)) };
> +        // SAFETY:
> +        // * All values in a list are stored in an `Arc`.
> +        // * The value cannot be removed from the list for the duration =
of the lifetime annotated
> +        //   on the returned `ArcBorrow`, because removing it from the l=
ist would require mutable
> +        //   access to the list. However, the `ArcBorrow` is annotated w=
ith the iterator's
> +        //   lifetime, and the list is immutably borrowed for that lifet=
ime.
> +        // * Values in a list never have a `UniqueArc` reference.
> +        Some(unsafe { ArcBorrow::from_raw(item) })
> +    }
> +}


