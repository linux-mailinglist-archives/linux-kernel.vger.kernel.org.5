Return-Path: <linux-kernel+bounces-150824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDDF8AA545
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4F1C210BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD6199EA4;
	Thu, 18 Apr 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fT8B6Pml"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA71180A67
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478137; cv=none; b=VsZc/qoShShMNJ/hERDwHK9EP8/AQadf7zksO3gIOCxZNMjksOHUazhbgPQS2+idA3w2VcygJQBE0o4yAT8/bUaYWlpo4wx7M1HqWyzwqLZj3wd2j1vEeRhZlxg7KuZuv6NnVC1jNhSmF1uoz3hcQ1sM+DDPHkj9EaKnvnu/un4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478137; c=relaxed/simple;
	bh=8yhag9nyYhIaBZwR31umJrijVM/yDN+aTTJGtC3fpqg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmcTeamUj+VS3JUP1uJGsSUzTIDL+H5tpS3o1TW+CCsDS+j0Ljts5B9qXkiwOWrIc/hkeirhdU0Rh3QZorMtcEZW8dtNCT/lHAaZ/vuNnLgCQi7qVO55OCDroEBU3NJxj3s8iDzWCNlcCDfzMy/SOBWz/vlRh1BtNbUxCKhLX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fT8B6Pml; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=r6zuhh2gpff4riwh2mm7beoj3q.protonmail; t=1713478127; x=1713737327;
	bh=BjZw5NoXdZy4cjpwzceRMewixxlr0ZNrjRE7YuR6ZzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fT8B6PmlDHeDQ4NR6WOPZAFGeOM3AkMJP+HEIGfVsXqhHRxDrwroYmciROBh7weqZ
	 vH27Ji8ol8PBYoNBhEFf2SZwthGAloNqtWk8ZT2HoJW40FTHYxqPWLrlGs2kZJt4v6
	 GMKca4XYiOv9oN9Tc5uJe6ShVj6SC++mYTrkfsskr4DbhLxlAF0QTd3OIbUiA7B0EW
	 pNJ7zirktW3xqJ0sbmPvIBp1K2nACmIxYLaoVTM0onD2c4mL5RcN32V54l4v/ULy8A
	 0IVlelYq9GdbK9iOjj4lJGWbmT864+43ZVhgf2EWHWhicDcj6EYvWNIOumvaT8K7H9
	 17nF5UI1VytTA==
Date: Thu, 18 Apr 2024 22:08:40 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 4/4] rust: add abstraction for `struct page`
Message-ID: <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
In-Reply-To: <ZiFsCLb-BZWbBHsu@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com> <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com> <ZiFsCLb-BZWbBHsu@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cd25ad47d5df3781bfc222584317121079a4a3b5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.24 20:52, Boqun Feng wrote:
> On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
>> +    /// Runs a piece of code with a raw pointer to a slice of this page=
, with bounds checking.
>> +    ///
>> +    /// If `f` is called, then it will be called with a pointer that po=
ints at `off` bytes into the
>> +    /// page, and the pointer will be valid for at least `len` bytes. T=
he pointer is only valid on
>> +    /// this task, as this method uses a local mapping.
>> +    ///
>> +    /// If `off` and `len` refers to a region outside of this page, the=
n this method returns
>> +    /// `EINVAL` and does not call `f`.
>> +    ///
>> +    /// # Using the raw pointer
>> +    ///
>> +    /// It is up to the caller to use the provided raw pointer correctl=
y. The pointer is valid for
>> +    /// `len` bytes and for the duration in which the closure is called=
 The pointer might only be
>> +    /// mapped on the current thread, and when that is the case, derefe=
rencing it on other threads
>> +    /// is UB. Other than that, the usual rules for dereferencing a raw=
 pointer apply: don't cause
>> +    /// data races, the memory may be uninitialized, and so on.
>> +    ///
>> +    /// If multiple threads map the same page at the same time, then th=
ey may reference with
>> +    /// different addresses. However, even if the addresses are differe=
nt, the underlying memory is
>> +    /// still the same for these purposes (e.g., it's still a data race=
 if they both write to the
>> +    /// same underlying byte at the same time).
>> +    fn with_pointer_into_page<T>(
>> +        &self,
>> +        off: usize,
>> +        len: usize,
>> +        f: impl FnOnce(*mut u8) -> Result<T>,
>=20
> I wonder whether the way to go here is making this function signature:
>=20
>      fn with_slice_in_page<T> (
>          &self,
> =09       off: usize,
> =09       len: usize,
> =09       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
>      ) -> Result<T>
>=20
> , because in this way, it makes a bit more clear that what memory that
> `f` can access, in other words, the users are less likely to use the
> pointer in a wrong way.
>=20
> But that depends on whether `&UnsafeCell<[u8]>` is the correct
> abstraction and the ecosystem around it: for example, I feel like these
> two functions:
>=20
> =09    fn len(slice: &UnsafeCell<[u8]>) -> usize
> =09    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
>=20
> should be trivially safe, but I might be wrong. Again this is just for
> future discussion.

I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
can always access the length.

Another question would be if page allows for uninitialized bits, in that
case, we would need `&[Opaque<u8>]`.

But I don't remember how to get a valid raw pointer from
`&[UnsafeCell<u8>]`.

--=20
Cheers,
Benno


