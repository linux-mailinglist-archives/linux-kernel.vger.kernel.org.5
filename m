Return-Path: <linux-kernel+bounces-131551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF354898980
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338A7282181
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71E1292F3;
	Thu,  4 Apr 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iCa1J4wU"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71581292D5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239571; cv=none; b=YA4okoi1qEtr5h9tUbobse4zSR1w/nB9LkrR+BJjMxwYX/Cfca6nu+SEZy8KQMDnv1OY16v4vmpkeonaApvJsWHT6EpKc1DlWPYZguSTVqgbNykN3crj/siAPhJ5A5orF02XB0ct8xR6S1dguKCXmeKkNqSRP9ZMxoc35asqolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239571; c=relaxed/simple;
	bh=HvvT5dkrkVC/M7IgnWDxF9rb0NCqbFQfhfPLfRudlak=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbrvvXJ22oe5wbARPFDuKW6QW9AlbpZpAHFnUvBsqwA22WmVbUnNFyO8SjaXRdCl+rYaAxPZcLQkYUwI+dq9fqXHEtJRnJ/PGE1J2mzRRO+BQ7dGf5ENVzpsKqvc20wlJ0uuA9ZlOk5AFcnUfreeyBWuQ59bGVUTD11kvFDBh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iCa1J4wU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712239567; x=1712498767;
	bh=FJrqTr4Imcj+L1bEBOlUEE1YfQ+xWTE4Rj2kPwIalRc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iCa1J4wUqBL1wPcqDUO22R1BP2sLFRe37WPTT2i81lq1XqXu+OB/hkG8GnCR5Dtj5
	 5MZT0RC7mfh3gjIdcY7+VWQwof9PJQWmsrXhKYP992n8uut5C8UqHLBDsomAK59KM8
	 5oaB5lytf+iDf5oLHcSHORqLvR++IkQvAPEq5ZojoS7cikfEnZtoxQBGqxXrTb/bSJ
	 oGWVFR9fFUxRmHCBaY6FsXZQ9FXemCxN4BXZHs77T8ZUbyIz0g3OUD6weDgVhoYlXZ
	 tr1XUk/rip1zMQxhx9YeZ9rtt7YX1OXO7wwzQdGgsctdWQANh6TKVc+BcTV9SIDh8H
	 zLyg5y7/AIH1w==
Date: Thu, 04 Apr 2024 14:05:57 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/9] rust: list: add struct with prev/next pointers
Message-ID: <9c003b63-6358-4e03-9c8a-e0de701e5df8@proton.me>
In-Reply-To: <CAH5fLghJtSvW-zNnDNFVgtb-px2d4W-xUk2++QdvyMYFMBGM-Q@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-3-b1c59ba7ae3b@google.com> <2500d66a-e54e-46d8-97cb-37fd9fc00c45@proton.me> <CAH5fLghJtSvW-zNnDNFVgtb-px2d4W-xUk2++QdvyMYFMBGM-Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 16:03, Alice Ryhl wrote:
> On Wed, Apr 3, 2024 at 5:57=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 02.04.24 14:17, Alice Ryhl wrote:
>>> +/// Implemented by types where a [`ListArc<Self>`] can be inserted int=
o a `List`.
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// Implementers must ensure that they provide the guarantees document=
ed on the three methods
>>> +/// below.
>>> +///
>>> +/// [`ListArc<Self>`]: ListArc
>>> +pub unsafe trait ListItem<const ID: u64 =3D 0>: ListArcSafe<ID> {
>>> +    /// Views the [`ListLinks`] for this value.
>>> +    ///
>>> +    /// # Guarantees
>>> +    ///
>>> +    /// * If there is a currently active call to `prepare_to_insert`, =
then this returns the same
>>> +    ///   pointer as the one returned by the currently active call to =
`prepare_to_insert`.
>>
>> I was a bit confused by the term "active call to `prepare_to_insert`",
>> since I thought that the function would need to be executed at this
>> moment. I inferred from below that you mean by this that there has been
>> a `prepare_to_insert` call, but not yet a corresponding `post_remove`
>> call.
>> I did not yet find a better way to phrase this.
>>
>> I like putting the guarantees on the functions very much.
>=20
> How about this?
>=20
> If there is a previous call to `prepare_to_insert` and there is no
> call to `post_remove` since the most recent such call, then this
> returns the same pointer as the one returned by the most recent call
> to `prepare_to_insert`.
>=20
> Otherwise, the returned pointer points at a read-only [`ListLinks`]
> with two null pointers.
Sounds good.

--=20
Cheers,
Benno



