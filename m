Return-Path: <linux-kernel+bounces-99152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801F878421
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDA4282DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50A44C7C;
	Mon, 11 Mar 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="awLHHh1q"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F140BF9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172071; cv=none; b=VbTgO+nkP8sclH+3AM+mt0bynmjM6C0VrL3GVSU6DQHh7/tzg2THTHAbqBNP6JZBxOUW4b1ZZmR6HKdN1si0BSNPxAMyoUFyVv5Q/0OPlStUpZhg4M/BOXMzCIB9e1zcun7o489MBeuFwuffirG0gjfV3S6KUiiJi4iCQKt8r4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172071; c=relaxed/simple;
	bh=ie8Prz8cFj64R0Di70+m7ran2yxryj4ASar1kHwJEKU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7VYiJyYbHYwJxp3F2ffPf/uAzt14Dhjo7ngORMqkDVWl4QCIdUd3Gwu49CJOz8kTkjuiThNGu1I9UzXk0oXbGzCftF+NlyZgg/hbgbBuYZGKN6D1gXtJr1UT25E6zRAmJYonu10WNTMm/9voGQb9LHzxdeyyYYDnXslB4GZf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=awLHHh1q; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1710172062; x=1710431262;
	bh=BCPyxOpQj1xUiAdi8EVHQZWgJdnxIRG4CYEF8aEZ154=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=awLHHh1qc+d+P+7OR+A0Zji+o8QMzfc5OLXw61LTTycaJzgMEF6R3fcuPPQhhL6Vf
	 JT4N84b7Y7CPiMH0pvIIqmzt7++HpEdgbzKJppbLA1UkNE//OhsPfrdfAD6I3/ZmOu
	 aSSHf6ylweV6nlEpD0Uxt6QBpA+O8YJRcPyIkrtKUsKCpexgNoY+RJl/RQjMB1N1sR
	 hqFq/PJiw3tXntU0yKmkbUdVtq7oNqVTDQ6Z5pyHPfuzfaCQG/hjzz24aod8RW4LDH
	 KY8kl+gVzkv4L96mEo4S4JBzwdkuwAEEPz3Q/YMk+0QN6RZP2xBY7mk4T8q66L3aAJ
	 Qg/gGO0Eqw5qQ==
Date: Mon, 11 Mar 2024 15:47:35 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: sync: add `Arc::into_unique_or_drop`
Message-ID: <47d24edd-6252-445b-a46e-6eb450f7786b@proton.me>
In-Reply-To: <CAH5fLgj-CH+DmvUjPe2Kacs6QQUQ0qj8ctFrx_jjJg-w1Xrc_w@mail.gmail.com>
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com> <20240228-arc-for-list-v2-2-ae93201426b4@google.com> <d52c5d95-99cd-4bd4-864f-b704299d3b1b@proton.me> <CAH5fLggrRANz1GrjEa671Vj0m9=UDeEcGV5vhOxq8XtR6EjUSg@mail.gmail.com> <7976d136-3cf7-427d-a047-41c29d25ad32@proton.me> <CAH5fLghFKVBucpLGEXQ9CdRZRreEhT+u8tPFi+A9-+CX9_Mz1w@mail.gmail.com> <CAH5fLgj-CH+DmvUjPe2Kacs6QQUQ0qj8ctFrx_jjJg-w1Xrc_w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/24 16:45, Alice Ryhl wrote:
> On Mon, Mar 11, 2024 at 4:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> On Mon, Mar 11, 2024 at 4:15=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>
>>> On 3/11/24 10:03, Alice Ryhl wrote:
>>>> On Sat, Mar 9, 2024 at 2:02=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>>
>>>>> On 2/28/24 14:00, Alice Ryhl wrote:
>>>>>> +        // SAFETY: If the refcount reaches a non-zero value, then w=
e have destroyed this `Arc` and
>>>>>> +        // will return without further touching the `Arc`. If the r=
efcount reaches zero, then there
>>>>>> +        // are no other arcs, and we can create a `UniqueArc`.
>>>>>
>>>>> This comment is not explaining why it is safe to call
>>>>> `refcount_dec_and_test` on `refcount`.
>>>>> It dose however explain what you are going to do, so please keep it, =
but
>>>>> not as a SAFETY comment.
>>>>
>>>> I'll reword.
>>>>
>>>>>> +        let is_zero =3D unsafe { bindings::refcount_dec_and_test(re=
fcount) };
>>>>>> +        if is_zero {
>>>>>> +            // SAFETY: We have exclusive access to the arc, so we c=
an perform unsynchronized
>>>>>> +            // accesses to the refcount.
>>>>>> +            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_=
INIT(1)) };
>>>>>> +
>>>>>> +            // SAFETY: We own one refcount, so we can create a `Uni=
queArc`. It needs to be pinned,
>>>>>> +            // since an `Arc` is pinned.
>>>>>
>>>>> The `unsafe` block is only needed due to the `new_unchecked` call, wh=
ich
>>>>> you could avoid by using `.into()`. The `SAFETY` should also be an
>>>>> `INVARIANT` comment instead.
>>>>>
>>>>>> +            unsafe {
>>>>>> +                Some(Pin::new_unchecked(UniqueArc {
>>>>>> +                    inner: Arc::from_inner(me.ptr),
>>>>>> +                }))
>>>>>> +            }
>>>>
>>>> The from_inner method is also unsafe.
>>>
>>> Ah I missed that, might be a good reason to split the block.
>>> It confused me that the SAFETY comment did not mention why calling
>>> `new_unchecked` is sound.
>>
>> I don't mind splitting up the unsafe block into several pieces.
>>
>>>> I think that using new_unchecked here makes more sense. That method is
>>>> usually used in the case where something is already pinned, whereas
>>>> into() is usually used to pin something that was not previously
>>>> pinned.
>>>
>>> I get your argument, but doing it this way avoids an unsafe function
>>> call. I think it would be fine to use `.into()` in this case.
>>> Splitting the unsafe block would also be fine with me.
>>
>> If you are okay with splitting the unsafe block instead, then I prefer
>> that. I don't think avoiding unsafe blocks is always the best answer;
>> especially not when you're already using unsafe right next to it.
>>
>> This reminds me of NonNull::new_unchecked(Box::into_raw(my_box)) vs
>> NonNull::from(Box::leak(my_box)). The latter is safe, but I don't
>> necessarily think that makes it the better choice. It's also important
>> that your code carries the right intent.
>>
>> Another way to go around it could be to add UniqueArc::from_raw or
>> from_inner methods, as well as from_raw_pinned and from_inner_pinned,
>> and then use those here.
>=20
> After looking at the code, I've changed my mind. I will write it like thi=
s:
>=20
> Some(Pin::from(UniqueArc { inner: ManuallyDrop::into_inner(me) }))
>=20
> With an INVARIANT comment. Does that make sense for you?

That also looks good to me.

--=20
Cheers,
Benno


