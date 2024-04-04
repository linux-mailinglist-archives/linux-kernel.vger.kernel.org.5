Return-Path: <linux-kernel+bounces-131655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C57898A72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D191F21056
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5E1BDE6;
	Thu,  4 Apr 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FKUU19VO"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5A41C68
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242362; cv=none; b=L+7Q3xIh1yK+QEVPa+0xJyYd06R0qUDyYs6S43bU7wPRqMcLsooIAG6yzGVuYdDgfy3o3DvAb80jQ0ea6XUfsHew/54CM6j3F6z/NN+0kg1KY1t+ovT451Uq9gEOaZLZrSyyhNuU7BA9VAFu6RA1tm7ihZIxWTQVIRS/kA6ptr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242362; c=relaxed/simple;
	bh=BkLSbtK8Nf5PzWncO5eh4M62k+sCM5Hlzp2GGZnYD2c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSNMxwjyBcOrr6gJrRbEivBqc4kVr1eUiGqaNfC0kPABVWtXnkNp6dYm/TBtngVYQdmEsgkq/ogO4lDk9ORoF5Kzct+6qlf5O8PSB0daXQWUjQV/NlMA/u6cwt3fhd09/W4jwQA3daVzHxEJzrg+Qya/hE3D2Zuyz+QIGLvZfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FKUU19VO; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712242358; x=1712501558;
	bh=KHjrZ7L/o/5RAJWobPfw5bBLIJX2aXSEBFmB1P0i8VM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FKUU19VO9s8jHrtlRm0l4Oa9EYZ2LNskf59Lccmcx00wF0/hXavvOgNkICFTEXLr7
	 eG8K7G3KU5pArEJW1gis6nSeajzvP2+wZKnU/5xlzLO0blbAsz6A1+2W0eg145IwXW
	 1WBT+UOh3kz9e2WPI7eCgFETHOBtzCx9B8WXSpaZmm5YO2aclP7CMZJuvy9C0AXB1B
	 u32vOV45Rtj7N4O/KWnUd6tK57LEGDdDBFRODtwfYX811JHexOP0qc3UMDnpmTQe9G
	 lgNRtR0HIUvn0T7dFeSnhvU4H7Z8ukRI8WsWOyMmKN/iU42EwvP3Tn9x49eaTq3Tyt
	 gH0efbnKxXcLg==
Date: Thu, 04 Apr 2024 14:52:31 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 6/9] rust: list: add iterators
Message-ID: <4045af19-05a4-48f0-9ca1-0d8d4d2b865c@proton.me>
In-Reply-To: <CAH5fLggS3qtCy20Y=kuxULUY9Q_4dSzJN5n2WitU362cYuqPLA@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-6-b1c59ba7ae3b@google.com> <98449574-4c1b-4281-bbd3-3ac2767020cb@proton.me> <CAH5fLggS3qtCy20Y=kuxULUY9Q_4dSzJN5n2WitU362cYuqPLA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 16:41, Alice Ryhl wrote:
> On Thu, Apr 4, 2024 at 4:36=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 02.04.24 14:17, Alice Ryhl wrote:
>>> +/// the end of the list. The `stop` pointer points at the first value =
in the same list, or it is
>>> +/// null if the list is empty.
>>> +#[derive(Clone)]
>>> +pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
>>> +    current: *mut ListLinksFields,
>>> +    stop: *mut ListLinksFields,
>>> +    _ty: PhantomData<&'a ListArc<T, ID>>,
>>> +}
>>> +
>>> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Iterator for Iter<'a=
, T, ID> {
>>> +    type Item =3D ArcBorrow<'a, T>;
>>> +
>>> +    fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
>>> +        if self.current.is_null() {
>>> +            return None;
>>> +        }
>>> +
>>> +        let current =3D self.current;
>>> +
>>> +        // SAFETY: We just checked that `current` is not null, so it i=
s in a list, and hence not
>>> +        // dangling. There's no race because the iterator holds an imm=
utable borrow to the list.
>>
>> This (that the iterator holds an immutable borrow) is not true (there
>> is no `&List` field in `Iter`), but you can make that an invariant
>> instead.
>=20
> What I mean is that the borrow-checker will consider the `List` to be
> borrowed by `Iter`. Whether or not there is a real reference or not
> doesn't matter.

Yes, but that is implementation detail of the safe function
`List::iter`, so I think it must also be captured by an invariant.

--=20
Cheers,
Benno


