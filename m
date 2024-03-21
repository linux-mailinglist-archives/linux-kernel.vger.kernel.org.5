Return-Path: <linux-kernel+bounces-110115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A1885A31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753851C21303
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE984FA9;
	Thu, 21 Mar 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CwO5JKKg"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32184A54
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029397; cv=none; b=fe1WdVqL4+qPer2xHC8D3VEZIeFRn/AYRF3hkGB6H8IwOLiBrapQf2P6m+lkiVYAAzm1EEnuX8CM2NIqEzdkn5xEwlxe/p08lNK4BrAFiZ4GnIraocafcLaiC+1OLWdK0r65rEiKwffDVNdvRPXY0JNf1R141e2wR1JE57/G8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029397; c=relaxed/simple;
	bh=qXTQzXE42jIqU86dY8JNyjmzbaiF6mqxNVesECoZkAk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMNfsAWw/lEdCJBfF8fv1DofDDdVdHl5zpBwyy7tsaDGphpGljz8Ls224fCxJrmY1blNmXbOPT5UGdmO/Uy8TBcVCimtE2gkpe9KhlpA0vdMmvvB67VWEaH78C3hJ8QxC0EdcWMI/tzzHPnlauVKjTo38DKp7HgFQo4gKJyIHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CwO5JKKg; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711029385; x=1711288585;
	bh=+DZVzwGA3DNwg1DykuRDpqsopt/Gmedd14krbU6mhdE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CwO5JKKgXVn+JoGs/oxfHnLuOyuxpDFkQiKIHtgtT472HlueJhv0iSK590fc+QdMr
	 4ZZvdyJfubOA8rbBKo2cbbYcbxRANSBUeL3kxYYKUMv1Rk/BeIsHh1JwT4ZstA6VRF
	 czmYQzARvgK0c39fgn0Dfq27/7/VF+zelB8iskbVAoCPdmaNc7zJlgYCpl1S8hBUir
	 /dq64fhB4jQaqrCMX+tH/8OPGLRcHV5qfhVLhl90sh9WXwfSFDWPARDMrXdFqb0CQR
	 adGovePRsjpcc92pFMbrvFVfk7tKdAkzrmDzUX/9LAFBzAkYwRGSZE3gfvKg6rA/XI
	 /kG4xT5Y5ceOQ==
Date: Thu, 21 Mar 2024 13:56:11 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, arnd@arndb.de, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <e088f9a2-c0aa-41b6-993b-01adb5fba929@proton.me>
In-Reply-To: <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com>
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me> <20240320084630.2727355-1-aliceryhl@google.com> <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me> <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/21/24 14:42, Alice Ryhl wrote:
> On Thu, Mar 21, 2024 at 2:16=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
>>
>> On 3/20/24 09:46, Alice Ryhl wrote:
>>>> On 3/11/24 11:47, Alice Ryhl wrote:
>>>>> +/// A pointer to a page that owns the page allocation.
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// The pointer points at a page, and has ownership over the page.
>>>>
>>>> Why not "`page` is valid"?
>>>> Do you mean by ownership of the page that `page` has ownership of the
>>>> allocation, or does that entail any other property/privilege?
>>>
>>> I can add "at a valid page".
>>
>> I don't think that helps, what you need as an invariant is that the
>> pointer is valid.
>=20
> To me "points at a page" implies that the pointer is valid. I mean, if
> it was dangling, it would not point at a page?
>=20
> But I can reword to something else if you have a preferred phrasing.

I would just say "`page` is valid" or "`self.page` is valid".

>>>>> +    /// Runs a piece of code with this page mapped to an address.
>>>>> +    ///
>>>>> +    /// The page is unmapped when this call returns.
>>>>> +    ///
>>>>> +    /// It is up to the caller to use the provided raw pointer corre=
ctly.
>>>>
>>>> This says nothing about what 'correctly' means. What I gathered from t=
he
>>>> implementation is that the supplied pointer is valid for the execution
>>>> of `f` for `PAGE_SIZE` bytes.
>>>> What other things are you allowed to rely upon?
>>>>
>>>> Is it really OK for this function to be called from multiple threads?
>>>> Could that not result in the same page being mapped multiple times? If
>>>> that is fine, what about potential data races when two threads write t=
o
>>>> the pointer given to `f`?
>>>>
>>>>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) =
-> T {
>>>
>>> I will say:
>>>
>>> /// It is up to the caller to use the provided raw pointer correctly.
>>> /// The pointer is valid for `PAGE_SIZE` bytes and for the duration in
>>> /// which the closure is called. Depending on the gfp flags and kernel
>>> /// configuration, the pointer may only be mapped on the current thread=
,
>>> /// and in those cases, dereferencing it on other threads is UB. Other
>>> /// than that, the usual rules for dereferencing a raw pointer apply.
>>> /// (E.g., don't cause data races, the memory may be uninitialized, and
>>> /// so on.)
>>
>> I would simplify and drop "depending on the gfp flags and kernel..." and
>> just say that the pointer is only valid on the current thread.
>=20
> Sure, that works for me.
>=20
>> Also would it make sense to make the pointer type *mut [u8; PAGE_SIZE]?
>=20
> I think it's a trade-off. That makes the code more error-prone, since
> `pointer::add` now doesn't move by a number of bytes, but a number of
> pages.

Yeah. As long as you document that the pointer is valid for r/w with
offsets in `0..PAGE_SIZE` bytes, leaving the type as is, is fine by me.


>>> It's okay to map it multiple times from different threads.
>>
>> Do you still need to take care of data races?
>> So would it be fine to execute this code on two threads in parallel?
>>
>>       static PAGE: Page =3D ...; // assume we have a page accessible by =
both threads
>>
>>       PAGE.with_page_mapped(|ptr| {
>>           loop {
>>               unsafe { ptr.write(0) };
>>               pr_info!("{}", unsafe { ptr.read() });
>>           }
>>       });
>=20
> Like I said, the usual pointer rules apply. Two threads can access it
> in parallel as long as one of the following are satisfied:
>=20
> * Both accesses are reads.
> * Both accesses are atomic.
> * They access disjoint byte ranges.
>=20
> Other than the fact that it uses a thread-local mapping on machines
> that can't address all of their memory at the same time, it's
> completely normal memory. It's literally just a PAGE_SIZE-aligned
> allocation of PAGE_SIZE bytes.

Thanks for the info, what do you think of this?:

/// It is up to the caller to use the provided raw pointer correctly. The p=
ointer is valid for reads
/// and writes for `PAGE_SIZE` bytes and for the duration in which the clos=
ure is called. The
/// pointer must only be used on the current thread. The caller must also e=
nsure that no data races
/// occur: when mapping the same page on two threads accesses to memory wit=
h the same offset must be
/// synchronized.

>=20
>> If this is not allowed, I don't really like the API. As a raw version it
>> would be fine, but I think we should have a safer version (eg by taking
>> `&mut self`).
>=20
> I don't understand what you mean. It is the *most* raw API that `Page`
> has. I can make them private if you want me to. The API cannot take
> `&mut self` because I need to be able to unsafely perform concurrent
> writes to disjoint byte ranges.

If you don't need these functions to be public, I think we should
definitely make them private.
Also we could add a `raw` suffix to the functions to make it clear that
it is a primitive API. If you think that it is highly unlikely that we
get a safer version, then I don't think there is value in adding the
suffix.

--=20
Cheers,
Benno


