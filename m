Return-Path: <linux-kernel+bounces-90564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA22870126
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BF2282115
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A43BB53;
	Mon,  4 Mar 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Skbesx0W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4E3C48A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554945; cv=none; b=LzbK3kxzEVJcFRDpbEEfnmTkbvqwmXbvndYdTn6sxE6Ai2D9QfKuDfFV8sDjgzEgk/HSgTlA1lWUF41N4X9kGzCgSxN7YsF1xOh/KazFeGKg1wkxGD4L5uMb4C1rU0ZLO9bMLYuekS1JBOgMhRf6+ZCBk317qCEs4FOu+1yHF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554945; c=relaxed/simple;
	bh=+VpdmpWcjthie9bWBOicSlzcbpKXFDNDMOw67MtVJdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN6UtlKdrHh+BmljDAsQL+LDuSZ7qqyKxd2buwvfYqu7/52hxN+vbqokQpvJVOWMxm8bAIQ7oA9Zs+Fe8VhDnNBqd+Rh5Dzj//gVAGVQNu+VM9R2+18KeWwzXRRwF/s/deJ2sC7+ldAWL1x2MpeuEPzrtr4MB4lE6BcpZl1Qun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Skbesx0W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709554942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nU8jfnXZ0VGXBtvUTL9dT3AJhK7MefkSEx/1fQz0Hos=;
	b=Skbesx0WvTGgTN2sDXQEjQKlNEMTPW2o/egaVhm0Kr3sNCksMui8eKpc0l1HAREqhZkeaH
	qUg7lT0aZwHQt7PO8owx8R3uIoUiaecfBP9p9e3ic027Vg04K1/Ba7kvGB4z+S7mMsWVpo
	Gajv/A//6YW3RtPtcW9w/k/Cm3hUNyM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-_kw0IxthOAOmev3TAcZciw-1; Mon, 04 Mar 2024 07:22:20 -0500
X-MC-Unique: _kw0IxthOAOmev3TAcZciw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a449be9db59so176725066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 04:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709554939; x=1710159739;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU8jfnXZ0VGXBtvUTL9dT3AJhK7MefkSEx/1fQz0Hos=;
        b=WjOjSXGZW9/YQ2RppF75w47viEGsMNLL2Lyu2NIkHO6Bio4ybXioEijDi6W9MNq3Ft
         Z6NDCFZZvRHCV6OhDqHUTZ+PCS/exUr0S/cwMtC8nVs6Sm/yNxkBOvTe4qJbuBnZd+2H
         UyERa6uWFjCmMgM5IDbekdjPhIDRst19tVkNAYlC3zG2B3N9XhS02JxnLEbn3uTcIUpz
         yBh7BrT81kpKNiYfHpuJtWtea3zxLwHvQxz1WD/turj9V1TmYeP6AbcsJ6WFjJqSNwgV
         WLUPDOOomdn6viK8OkqrBFjJqj/KiuBpDoQJg47wOTrmWNt/eLhytp2eJhl0bO7ZO6bL
         tWdA==
X-Forwarded-Encrypted: i=1; AJvYcCVgbWP35VNYnaJlt7gS2g0I+u+jj5nSHRIe8apet9pq7xORbD6dO79V/J+VuyYuB5Sqq+NzC/oIRTdcSWsItlfitAYBKvwoshY6ywns
X-Gm-Message-State: AOJu0YxKapxT2zFYY/J9DFjM1k2Oi2VTVr0xOGwVkIT9FyAPEKkLLQE3
	t7wJsuMUkB37aoNCVXXwNUcjiZN8xizjyJHCSfrycHSHIe8UdxuMKqAaz9lSZAiMIs8Q63PbBvd
	Iah6j023NTl6daYU5Pg28Ll806vxSsYVY/l/+T+Nm1gw9UWhtfTrtzVDbB9YsHQ==
X-Received: by 2002:a17:906:c459:b0:a45:6b66:92ab with SMTP id ck25-20020a170906c45900b00a456b6692abmr812335ejb.51.1709554939466;
        Mon, 04 Mar 2024 04:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL14WuFmk+KyX/YSiXAZPgmh+sa+gp6Cdl2T1aog1knDX96jaVdGoAbiM0dAZWQxsyaMs4EQ==
X-Received: by 2002:a17:906:c459:b0:a45:6b66:92ab with SMTP id ck25-20020a170906c45900b00a456b6692abmr812316ejb.51.1709554939087;
        Mon, 04 Mar 2024 04:22:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id tk2-20020a170907c28200b00a43ab3e38d6sm4728091ejc.114.2024.03.04.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:22:18 -0800 (PST)
Message-ID: <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>
Date: Mon, 4 Mar 2024 13:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to
 CString
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240223163726.12397-1-dakr@redhat.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240223163726.12397-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 17:37, Danilo Krummrich wrote:
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
> 
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
> 
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].

Gentle ping.

> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
> Changes in V5:
>    - remove unneeded return statements
>    - use Vec::as_mut_slice() instead of a dereference
> Changes in V4:
>    - move to_ascii_{lower,upper}case() to CStr
>    - add a few comments suggested by Alice
> Changes in V3:
>    - add an `impl DerefMut for CString`, such that these functions can be defined
>      for `CStr` as `&mut self` and still be called on a `CString`
> Changes in V2:
>    - expand commit message mentioning the use case
>    - expand function doc comments to match the ones from Rust's stdlib
>    - rename to_* to make_* and add the actual to_* implementations
> ---
>   rust/kernel/str.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 7d848b83add4..c1c8ccc80c52 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -5,7 +5,7 @@
>   use alloc::alloc::AllocError;
>   use alloc::vec::Vec;
>   use core::fmt::{self, Write};
> -use core::ops::{self, Deref, Index};
> +use core::ops::{self, Deref, DerefMut, Index};
>   
>   use crate::{
>       bindings,
> @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
>           unsafe { core::mem::transmute(bytes) }
>       }
>   
> +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> +    /// additional checks.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
> +    /// `NUL` byte (or the string will be truncated).
> +    #[inline]
> +    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> +    }
> +
>       /// Returns a C pointer to the string.
>       #[inline]
>       pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
> @@ -206,6 +219,70 @@ pub unsafe fn as_str_unchecked(&self) -> &str {
>       pub fn to_cstring(&self) -> Result<CString, AllocError> {
>           CString::try_from(self)
>       }
> +
> +    /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
> +    ///
> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To return a new lowercased value without modifying the existing one, use
> +    /// [`to_ascii_lowercase()`].
> +    ///
> +    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
> +    pub fn make_ascii_lowercase(&mut self) {
> +        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
> +        // string.
> +        self.0.make_ascii_lowercase();
> +    }
> +
> +    /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
> +    ///
> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To return a new uppercased value without modifying the existing one, use
> +    /// [`to_ascii_uppercase()`].
> +    ///
> +    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
> +    pub fn make_ascii_uppercase(&mut self) {
> +        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
> +        // string.
> +        self.0.make_ascii_uppercase();
> +    }
> +
> +    /// Returns a copy of this [`CString`] where each character is mapped to its
> +    /// ASCII lower case equivalent.
> +    ///
> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
> +    ///
> +    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
> +    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
> +        let mut s = self.to_cstring()?;
> +
> +        s.make_ascii_lowercase();
> +
> +        Ok(s)
> +    }
> +
> +    /// Returns a copy of this [`CString`] where each character is mapped to its
> +    /// ASCII upper case equivalent.
> +    ///
> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
> +    ///
> +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
> +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
> +        let mut s = self.to_cstring()?;
> +
> +        s.make_ascii_uppercase();
> +
> +        Ok(s)
> +    }
>   }
>   
>   impl fmt::Display for CStr {
> @@ -593,6 +670,14 @@ fn deref(&self) -> &Self::Target {
>       }
>   }
>   
> +impl DerefMut for CString {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: A `CString` is always NUL-terminated and contains no other
> +        // NUL bytes.
> +        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut_slice()) }
> +    }
> +}
> +
>   impl<'a> TryFrom<&'a CStr> for CString {
>       type Error = AllocError;
>   
> 
> base-commit: 39133352cbed6626956d38ed72012f49b0421e7b


