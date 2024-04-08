Return-Path: <linux-kernel+bounces-135083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8AA89BAE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D41C21C34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FC3FB8D;
	Mon,  8 Apr 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j1cr+GRr"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE83C470
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566278; cv=none; b=BmQP9uHAY7TLOiOczd2byZ6jZM/zQriadDXutgwDsoS1M7tARZdxvxxJT4fEsF7KGPPGP2icPmD/4gy5xMddf7T92zTOLYy1weH6JhJ4xM5HLQVZQrv/1eDdfgD4qXo5hICdLRvzoOnxYbq7jXVbolXarkYs8r10MXEk2Bc1/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566278; c=relaxed/simple;
	bh=LrHR5P/LrNI/UQPu1hlqeRHQWbUqR3Ke0r8v10Mpe2c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1MYDki0gP8esQdlOK2EN9NgYcFrVhHMtVBCzQBfJRV8ihUYqAPedrixqkxa1+LiUA63pzfJd+WSWyvVUMHnvpOavp1XOiNpsTVKaxq+c/9UPUqBzM/mpVB+9BIyOopyPNEzbMzNyBBwfg0Nb0uUJ3CLjHGQZT1K/S33nn119Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j1cr+GRr; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712566268; x=1712825468;
	bh=CUkPAONzwDRb/Nkur4cZQic06C81obmvAaXkWg3RRnE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j1cr+GRrMMDEkZcscWsT32bBHzNmnUv2/sPLO4VMfHQ4WnUlopjx3XddPs8HG7wJQ
	 Kf+AcdxPcMhQTVUvM1mValC43tW63xzJrRISZ4s77mQlvR6EW2V/6+uB+rKayebDhg
	 SCKC+p8UstTdDBVEUZ/nvdmVDNKz7D+c9WnkaL/I9gpcFCfJiMYm4gqVjH6+3SI6vM
	 g/LwBLJz+/VXvwC9c+6Jm5MeljxZywSpgz8gbiP9X4HsFWDpZcbNUi8A/ug1nPVQ6m
	 Amg9Q9foy4phbHdWfWV9bMYg2drenU45LTXhDaCSTHTgd3vA8FMeDP/7HG3rSSXrKX
	 xYmHkxCcbUlQg==
Date: Mon, 08 Apr 2024 08:51:04 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 5/9] rust: list: add List
Message-ID: <f51231b2-46a4-4fea-af9d-d16b0ea59bf5@proton.me>
In-Reply-To: <CAH5fLggF=dBYzySEt-TgNT+Tr-SNYvQxp3A26NktXNb2SNhDDg@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com> <d896a813-3081-40b4-985b-ef257d55cec2@proton.me> <CAH5fLgiN3jcd_HMgmP7H-026daMw0xkMk=CGaGc9AM7uHkFXFA@mail.gmail.com> <3f3cf5ae-30df-4032-b752-77126035784c@proton.me> <CAH5fLggF=dBYzySEt-TgNT+Tr-SNYvQxp3A26NktXNb2SNhDDg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.24 10:04, Alice Ryhl wrote:
> On Thu, Apr 4, 2024 at 4:51=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 04.04.24 16:12, Alice Ryhl wrote:
>>> On Thu, Apr 4, 2024 at 4:03=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>> On 02.04.24 14:17, Alice Ryhl wrote:
>>>>> +        // never null for items in a list.
>>>>> +        //
>>>>> +        // INVARIANT: There are three cases:
>>>>> +        //  * If the list has at least three items, then after remov=
ing the item, `prev` and `next`
>>>>> +        //    will be next to each other.
>>>>> +        //  * If the list has two items, then the remaining item wil=
l point at itself.
>>>>> +        //  * If the list has one item, then `next =3D=3D prev =3D=
=3D item`, so these writes have no effect
>>>>> +        //    due to the writes to `item` below.
>>>>
>>>> I think the writes do not have an effect. (no need to reference the
>>>> writes to `item` below)
>>>
>>> ?
>>
>> The first write is
>>
>>       (*next).prev =3D prev;
>>
>> Using the fact that `next =3D=3D prev =3D=3D item` we have
>>
>>       (*item).prev =3D prev;
>>
>> But that is already true, since the function requirement is that
>> `(*item).prev =3D=3D prev`. So the write has no effect.
>> The same should hold for `(*prev).next =3D next`.
>=20
> Oh, you are arguing that we aren't changing the value? I hadn't
> actually realized that this was the case. But the reason that they end
> up with the correct values according to the invariants is the writes
> below that set them to null - not the fact that we don't change them
> here. After all, setting them to a non-null value is wrong according
> to the invariants.

I just was confused by the "due to the writes to `item` below".
In the single element case, I also think that the INVARIANT comment of
the next `unsafe` block (still visible in this mail) is a bit weird,
since the element still is in the list.
For a single item, removing it is setting the prev, next and first
pointers to null. So I think you might be able to use this for the last
bullet point:

     * If the list has one item, then `next =3D=3D prev =3D=3D item`, so th=
ese
       writes have no effect, since also `(*item).prev =3D=3D prev` and
       `(*item).next =3D=3D next` by function requirement.

For the INVARIANT comment below, I think you also need the case
distinction:

     * If the list had more than one item, `item` is no longer in the
       list, so the pointers should be null.
     * If the list had one item, then `item` points to itself, to remove
       it, we set `prev` and `next` to null and later also `self.first`.

What do you think?

--=20
Cheers,
Benno

>=20
> Alice
>=20
>>>>> +        unsafe {
>>>>> +            (*next).prev =3D prev;
>>>>> +            (*prev).next =3D next;
>>>>> +        }
>>>>> +        // SAFETY: We have exclusive access to items in the list.
>>>>> +        // INVARIANT: The item is no longer in a list, so the pointe=
rs should be null.
>>>>> +        unsafe {
>>>>> +            (*item).prev =3D ptr::null_mut();
>>>>> +            (*item).next =3D ptr::null_mut();
>>>>> +        }


