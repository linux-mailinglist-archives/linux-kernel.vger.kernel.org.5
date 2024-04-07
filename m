Return-Path: <linux-kernel+bounces-134270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B46489AFD5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2842831BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843B12B75;
	Sun,  7 Apr 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W4KM894T"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DC125A9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480348; cv=none; b=L4zfaI7lFPhEVhp2f5CZPCQQomyh0fHlRDySEv6w110GRla5iLUXDGETbO3Gr7Z1suRyMDeOJeVJAEkjd3aoQ8X8mOTlsWJrfn0OvjJvxlwA/XrAeiXFHGkHU2Ny3113F3bKUHRScvTwv12K0jl3Tq5OXN/4MX4gWYbEwfMYLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480348; c=relaxed/simple;
	bh=APMjPK8g5pOGPv0dwlk1KSseSXNGp/4m07t8x/ixSo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgqUyD0Y7R7KP3gdt6F3f4M1yAYjKsYe5Wd4rU4OWVju5Rsc3higeBHDjfW3UuC+DhK1XCuZcvJugOYimhcsy7cxnSu6QE2KaN8pqu7F4z+WMLejx2JejkINvPiQDCCNjOflv5noDAC7t0qFnYElypgjuVt6c4eCfW9JdWqNf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W4KM894T; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pqs54sg6ifhbtj7unmv7pp4qau.protonmail; t=1712480338; x=1712739538;
	bh=APMjPK8g5pOGPv0dwlk1KSseSXNGp/4m07t8x/ixSo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W4KM894T30Nvu/5Jg8f5a0pedkYEE9Ylz9e18LTSxXUYXznis8BometXs7Yrf7al6
	 SU7+lWst6jQZdOOyRDFBM4ps0WD/pkIt0cuSbgU/hFttyxhj/p200c9O7D+XSdfb2S
	 uBHSq2l8JFwrOVb0vV5qUJJBwELvvFxrP+TIly1xKnw+TtGeonf4Nbe6+WS5Hbxw+K
	 yUf4ubNEklQZ6OhSeku5G9NqwLaSOlliVdOFsQfQ9jMqApNkCEYE6SaYH1ys5XNRdZ
	 QWtDcR6Vmwyy/qSS+nnNS6xXzmjxAq4y124thVRZB8Agf5UZkjV6GOdNCMWsht4a4D
	 caZhhArNRMktA==
Date: Sun, 07 Apr 2024 08:58:50 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
Message-ID: <c130a6f5-77d7-4d9e-984d-7a8bf48ff918@proton.me>
In-Reply-To: <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com>
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com> <20240404-alice-mm-v4-4-49a84242cf02@google.com> <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me> <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.24 09:44, Alice Ryhl wrote:
> On Fri, Apr 5, 2024 at 12:33=E2=80=AFAM Benno Lossin <benno.lossin@proton=
me> wrote:
>>
>> On 04.04.24 14:31, Alice Ryhl wrote:
>>> +/// A bitwise shift for the page size.
>>> +#[allow(clippy::unnecessary_cast)]
>>
>> Why can't you remove the cast?
>=20
> Bindgen could decide to use a different type in the future or on
> different platforms.

Did that already happen?

I think that we might want to know if the type changes, since then the
value might change?

--=20
Cheers,
Benno


