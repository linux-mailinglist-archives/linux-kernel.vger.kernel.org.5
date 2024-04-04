Return-Path: <linux-kernel+bounces-131503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333748988C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635C51C21D81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9E127B45;
	Thu,  4 Apr 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mXGrdLWt"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425F823C3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237308; cv=none; b=OKJa2m0C9yqOuuQEgw01LuQIhqsul3B1PbdFULY05p8q09NHQb4Cv384bYLUishLB541jnQ3xTfqNpVQ5gIlhsO0vquKShcTB58NShqM89PwAPYKw9XmYoEKdVeSzkSudM+3lJmW8OtoJFu7mbwYo/JmGWUIwgG3HQOAxxdAREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237308; c=relaxed/simple;
	bh=5Dfs/b/6BwRGYkpvYujP65mkScmyquVJPMK3QpaXkPA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2yvomNqVPt95I41CYA4rOnY7yqXBRLsD7pnGnIE/vV7RgdBnKLLHY2yzpDagotLavz3Mq2E5cmc+wmmOCHheIqOGYyN6XMwp9pwjiqo4uKGiJUuY9fU/oIrlBEc61NBFTQNuvleFfWlyEy+ZuDRa+07laxjPH+Yve0TP8foNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mXGrdLWt; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712237304; x=1712496504;
	bh=oeSJBTz+vnlmc3oPqtdJLsV9ot2/7tEkK8xNb1dVcUY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mXGrdLWtP3XQq+ln5kCxi4M7EvfUo4H3h8C/v2evQ1e8xlQEmjoZSBDpqsQUQgaHI
	 tYXsXjPevCXwpjqn6fTXzV3p9Yl7UvYCNy80R7Qd12z8Ok4bGKkZs5hwKvzrgqbpKp
	 OdId7LJqf5YS2AeyPJD2KfL95tNw68szKQ8k6M22kHaP4zbi0Pm/krDnkS6EnKu6zi
	 p0PGSyyhr1JcxwPJibxzaPsgY0fabezYQzE+KfxiIIrSYaJjQNP6M1zAL5+ClkZInH
	 SGmuuvfcbby3ZN56R39V5MSLRAaLxgwdR3aZSRvTJeceT0QMZx162OnJbHB8Z+jfmO
	 pWYsCJ+ENrnuQ==
Date: Thu, 04 Apr 2024 13:28:16 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 7/9] rust: list: add cursor
Message-ID: <fe34947f-2daa-438a-b621-8557b78f1da6@proton.me>
In-Reply-To: <CAH5fLghEg37m_PhJxE8FVORHGROE9rd1CJttaWBGc7cXZCX+yQ@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com> <4aaf7fd7-49ed-4b3e-b691-0d8d7d426d3a@proton.me> <CAH5fLghEg37m_PhJxE8FVORHGROE9rd1CJttaWBGc7cXZCX+yQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.24 14:49, Alice Ryhl wrote:
> On Wed, Apr 3, 2024 at 2:19=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 02.04.24 14:17, Alice Ryhl wrote:
>>> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
>>> +    /// Access the current element of this cursor.
>>> +    pub fn current(&self) -> ArcBorrow<'_, T> {
>>> +        // SAFETY: The `current` pointer points a value in the list.
>>> +        let me =3D unsafe { T::view_value(ListLinks::from_fields(self.=
current)) };
>>> +        // SAFETY:
>>> +        // * All values in a list are stored in an `Arc`.
>>> +        // * The value cannot be removed from the list for the duratio=
n of the lifetime annotated
>>> +        //   on the returned `ArcBorrow`, because removing it from the=
 list would require mutable
>>> +        //   access to the cursor or the list. However, the `ArcBorrow=
` holds an immutable borrow
>>> +        //   on the cursor, which in turn holds an immutable borrow on=
 the list, so any such
>>
>> The cursor has a mutable borrow on the list.
>>
>>
>>> +        //   mutable access requires first releasing the immutable bor=
row on the cursor.
>>> +        // * Values in a list never have a `UniqueArc` reference.
>>
>> Is there some type invariant guaranteeing this?
>=20
> The List owns a ListArc reference to the value. It would be unsound
> for there to also be a UniqueArc reference to it.

I think it would be good to add the existence of the `ListArc` as an
explanation.

--=20
Cheers,
Benno


