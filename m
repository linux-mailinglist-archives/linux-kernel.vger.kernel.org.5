Return-Path: <linux-kernel+bounces-146577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA58A677C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FFF1F2148E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9C86258;
	Tue, 16 Apr 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RwNaJezF"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0631272B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261219; cv=none; b=HKzMh4DUX6+yE7Qis8aRPQKw8fL3krna44RrsY69bdedl3UagnYdsBL93/0jVA/JDza5RkLDvmN5RT/rxBYzQ46UsM3vMlbhxzIginhrlJmSNdEARZiL3W78An8ERJBZsTDk3ZD3lOp6DgWCtWv2S73/1DCSyH5vmW2TL35DiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261219; c=relaxed/simple;
	bh=83s13mn2KXx82X2UotydUVvraiEuoD5bk0bv+uKQ0j4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rewO3UxoRrNmL3AcXQI0LN5xXCxme0Ixiz0O7ujxBm0S6aDU4cmA8qzmVzg9vg39LCtXirvzFZWHuCxQ46MkZ4StDyVV+OHqD/j8LrxolS6d9/VWEdpeu/2AF3Ov2m90iIsyAHrQEpjuiP6+7ZBHmDp9xQTFxmjcTldtATTbSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwNaJezF; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-516d92389e0so3696945e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261215; x=1713866015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dWBKU5D27aRchDLY2aDBlpODU4i4Munl9LNc7I7ZXQ=;
        b=RwNaJezFECdtmEn9L+eBtjPzr4gWDohJiORigLsmbEJuH3+kkNvlhmVJ6aRsw133sZ
         4BA6LepBODJMiWVuRUKUR3G8K2tH+WIY2m08Z2N1B0JFGUAEoGbrYHVpYDxMbdCm2C47
         KpIqF9qwPGGPf2bGjpqVNtwKFq2FBELYFfgeD6MHcGK7ilNGJ6rcpZf/iORN88ZH+lhT
         UMl8/cEeckLjGlRkNvTXO11GSYXW52p9aUI/U5Twh640zgg3qwu7w9O6LT3CSL0K5+3u
         0I09oLlGJnQSgqriga9B7KQ0FijqTtG9BAooGcoSALW2AeAZgxJHDubxdmUpqpadNx/p
         AVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261215; x=1713866015;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8dWBKU5D27aRchDLY2aDBlpODU4i4Munl9LNc7I7ZXQ=;
        b=KAw7ryUjGCt8d5RaFXYDQA0uZMrvw49LRBtFKKUtiuEwktCsfznLNT0LHA9Dz9KnbB
         MCUj2ag1qaR7xdAf6HlGzfcWx881a9tXA88rS6SrnIWCCCqwJSibdMXxxW76tRPj71yz
         ZZ+th1lgZgeoxkcK40aqeuGnbpRGsbHOOzKI6eS3z4uxYTQQrppbTDN/4gITTR36EXME
         MIWIKO8JuzABM78twT9OzdVBaJYkZLuJhZjr1HlEbwY9w94F/JhmAbb0caODuPAPef4Z
         OmThnWaMl6mblhLERlM+BnM8yF/wxMyX6VrP8cjjPVDa7mLNUVyvF9oXUYkXm9sCoXvD
         5W0g==
X-Forwarded-Encrypted: i=1; AJvYcCWlQki0IlUoNneRCuqhX/aITmxn7qR5Jd0l2zeQm5XhGIe4LPeygCbKKtgdgdcq59ukOTOzpbeuEaYwFL3LQirL/XNQcl2IZeItthvB
X-Gm-Message-State: AOJu0YwQRfn0g5S0AFZ6v/HrqmTkQX84s75mKW60FL70BDTPQ6DJwJMP
	npBucGoA3aWvXVJqoIuMTaI9JyFHCigX/GZHZhbntCJwhIy06/IU+2rndNhfpmHSuiKPb54ZLy5
	YhgRyVkrM1oGFPw==
X-Google-Smtp-Source: AGHT+IHcsJ5hw/vAV99RGLFobjm/zsOzmQtTDncHcg7emEQfzy1uf60bL8m87fTCzGgApod6m1hAcwICRv+RptI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3411:b0:518:a967:e2b3 with SMTP
 id i17-20020a056512341100b00518a967e2b3mr9083lfr.0.1713261215426; Tue, 16 Apr
 2024 02:53:35 -0700 (PDT)
Date: Tue, 16 Apr 2024 09:53:32 +0000
In-Reply-To: <CALNs47tEZqL201jsExfF1j7m+yW37YRAws-NTF6hwsxohSKoQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALNs47tEZqL201jsExfF1j7m+yW37YRAws-NTF6hwsxohSKoQA@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416095333.1108884-1-aliceryhl@google.com>
Subject: Re: [PATCH v5 4/4] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: tmgross@umich.edu
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Trevor Gross <tmgross@umich.edu> writes:
> On Mon, Apr 15, 2024 at 3:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> Adds a new struct called `Page` that wraps a pointer to `struct page`.
>> This struct is assumed to hold ownership over the page, so that Rust
>> code can allocate and manage pages directly.
>>
>> The page type has various methods for reading and writing into the page.
>> These methods will temporarily map the page to allow the operation. All
>> of these methods use a helper that takes an offset and length, performs
>> bounds checks, and returns a pointer to the given offset in the page.
>>
>> This patch only adds support for pages of order zero, as that is all
>> Rust Binder needs. However, it is written to make it easy to add support
>> for higher-order pages in the future. To do that, you would add a const
>> generic parameter to `Page` that specifies the order. Most of the
>> methods do not need to be adjusted, as the logic for dealing with
>> mapping multiple pages at once can be isolated to just the
>> `with_pointer_into_page` method.
>>
>> Rust Binder needs to manage pages directly as that is how transactions
>> are delivered: Each process has an mmap'd region for incoming
>> transactions. When an incoming transaction arrives, the Binder driver
>> will choose a region in the mmap, allocate and map the relevant pages
>> manually, and copy the incoming transaction directly into the page. This
>> architecture allows the driver to copy transactions directly from the
>> address space of one process to another, without an intermediate copy
>> to a kernel buffer.
>>
>> This code is based on Wedson's page abstractions from the old rust
>> branch, but it has been modified by Alice by removing the incomplete
>> support for higher-order pages, by introducing the `with_*` helpers
>> to consolidate the bounds checking logic into a single place, and by
>> introducing gfp flags.
>>
>> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
> I have a couple questions about naming, and think an example would be
> good for the functions that are trickier to use correctly. But I
> wouldn't block on this, implementation looks good to me.
>=20
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks for taking a look!

>> +/// Flags for the "get free page" function that underlies all memory al=
locations.
>> +pub mod flags {
>> +    /// gfp flags.
>=20
> Uppercase acronym, maybe with a description:
>=20
>     GFP (Get Free Page) flags.
>=20
>> +    #[allow(non_camel_case_types)]
>> +    pub type gfp_t =3D bindings::gfp_t;
>=20
> Why not GfpFlags, do we do this elsewhere?
>=20
>> +    /// `GFP_KERNEL` is typical for kernel-internal allocations. The ca=
ller requires `ZONE_NORMAL`
>> +    /// or a lower zone for direct access but can direct reclaim.
>> +    pub const GFP_KERNEL: gfp_t =3D bindings::GFP_KERNEL;
>> +    /// `GFP_ZERO` returns a zeroed page on success.
>> +    pub const __GFP_ZERO: gfp_t =3D bindings::__GFP_ZERO;
>> +    /// `GFP_HIGHMEM` indicates that the allocated memory may be locate=
d in high memory.
>> +    pub const __GFP_HIGHMEM: gfp_t =3D bindings::__GFP_HIGHMEM;
>=20
> It feels a bit weird to have dunder constants on the rust side that
> aren't also `#[doc(hidden)]` or just nonpublic. Makes me think they
> are an implementation detail or not really meant to be used - could
> you update the docs if this is the case?

All of this is going away in the next version because it will be based
on [1], which defines the gfp flags type for us.

[1]: https://lore.kernel.org/rust-for-linux/20240328013603.206764-1-wedsona=
f@gmail.com/

>> +
>> +impl Page {
>> +    /// Allocates a new page.
>=20
> Could you add a small example here?

I can add an example that shows how to pass gfp flags.

>> +    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocErr=
or> {
>> [...]
>> +    }
>> +
>> +    /// Returns a raw pointer to the page.
>=20
> Could you add a note about how the pointer needs to be used correctly,
> if it is for anything more than interfacing with kernel APIs?

I can clarify that it's a pointer to the `struct page` and not the
actual PAGE_SIZE bytes stored in the page, and that it's for use with
the raw C apis. I won't go into more details than that.

>> +    pub fn as_ptr(&self) -> *mut bindings::page {
>> +        self.page.as_ptr()
>> +    }
>> +
>> +    /// Runs a piece of code with this page mapped to an address.
>> +    ///
>> +    /// The page is unmapped when this call returns.
>> +    ///
>> +    /// # Using the raw pointer
>> +    ///
>> +    /// It is up to the caller to use the provided raw pointer correctl=
y. The pointer is valid for
>> +    /// `PAGE_SIZE` bytes and for the duration in which the closure is =
called. The pointer might
>> +    /// only be mapped on the current thread, and when that is the case=
, dereferencing it on other
>> +    /// threads is UB. Other than that, the usual rules for dereferenci=
ng a raw pointer apply: don't
>> +    /// cause data races, the memory may be uninitialized, and so on.
>> +    ///
>> +    /// If multiple threads map the same page at the same time, then th=
ey may reference with
>> +    /// different addresses. However, even if the addresses are differe=
nt, the underlying memory is
>> +    /// still the same for these purposes (e.g., it's still a data race=
 if they both write to the
>> +    /// same underlying byte at the same time).
>> +    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
>> [...]
>> +    }
>=20
> Could you add an example of how to use this correctly?

This is a private function, you're not supposed to use it directly.
Anyone who is modifying this file directly can look at the existing
users for examples.

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
>=20
> This could probably also use an example. A note about how to select
> between with_pointer_into_page and with_page_mapped would also be nice
> to guide usage, e.g. "prefer with_pointer_into_page for all cases
> except when..."

Same as above. This is a private function.

>> +    fn with_pointer_into_page<T>(
>> +        &self,
>> +        off: usize,
>> +        len: usize,
>> +        f: impl FnOnce(*mut u8) -> Result<T>,
>> +    ) -> Result<T> {
>> [...]
>> +    /// Maps the page and zeroes the given slice.
>> +    ///
>> +    /// This method will perform bounds checks on the page offset. If `=
offset .. offset+len` goes
>> +    /// outside ot the page, then this call returns `EINVAL`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that this call does not race with a read or=
 write to the same page that
>> +    /// overlaps with this write.
>> +    pub unsafe fn fill_zero(&self, offset: usize, len: usize) -> Result=
 {
>> +        self.with_pointer_into_page(offset, len, move |dst| {
>> +            // SAFETY: If `with_pointer_into_page` calls into this clos=
ure, then it has performed a
>> +            // bounds check and guarantees that `dst` is valid for `len=
` bytes.
>> +            //
>> +            // There caller guarantees that there is no data race.
>> +            unsafe { ptr::write_bytes(dst, 0u8, len) };
>> +            Ok(())
>> +        })
>> +    }
>=20
> Could this be named `fill_zero_raw` to leave room for a safe
> `fill_zero(&mut self, ...)`?

I suppose I can rename these _raw as well.

>> +    /// Copies data from userspace into this page.
>> +    ///
>> +    /// This method will perform bounds checks on the page offset. If `=
offset .. offset+len` goes
>> +    /// outside ot the page, then this call returns `EINVAL`.
>> +    ///
>> +    /// Like the other `UserSliceReader` methods, data races are allowe=
d on the userspace address.
>> +    /// However, they are not allowed on the page you are copying into.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that this call does not race with a read or=
 write to the same page that
>> +    /// overlaps with this write.
>> +    pub unsafe fn copy_from_user_slice(
>> +        &self,
>> +        reader: &mut UserSliceReader,
>> +        offset: usize,
>> +        len: usize,
>> +    ) -> Result {
>> +        self.with_pointer_into_page(offset, len, move |dst| {
>> +            // SAFETY: If `with_pointer_into_page` calls into this clos=
ure, then it has performed a
>> +            // bounds check and guarantees that `dst` is valid for `len=
` bytes. Furthermore, we have
>> +            // exclusive access to the slice since the caller guarantee=
s that there are no races.
>> +            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(ds=
t.cast(), len) })
>> +        })
>> +    }
>> +}
>=20
> Same as above, `copy_from_user_slice_raw` would leave room for a safe API=
.

Okay

Alice

