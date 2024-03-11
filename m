Return-Path: <linux-kernel+bounces-98820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B8877FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E7F1F22A24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232813C6A6;
	Mon, 11 Mar 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdOdzBmD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397303C08F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159737; cv=none; b=T6MzhmkCFV+3Cjy+PtUE6aXqFFeVzQT3WFWrNCKyS4nuDu8B1h8G/KcoeOLiaXkdVOj1aiaxd4ufFZyIjfuWd15gQr4d908JnL0Nn0btrkVpE21DfAMxtmf1yNxHg0BUWi5DWDiYEamm5TOcy6OvBzr+7A9eTwzNJMG/496zM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159737; c=relaxed/simple;
	bh=nzvi+Q7Zc7v/LHpAYHsUDePwOhaGJa+bGEU5NJIY5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS5Nn2AgQoRKmt60SdvfqKxT0odrGndpA8ChNCNGqNLSAUIQdoaUWDCN02Wph71XbwOdfCBglHiw+MqAQB0YnUtoadKcNvTaV3mZmNvxqJsBcos6mvXeDY9Jv+c4FjT8ZXGIau76sFCEyfxrIRDzR0R019AuosHQVGizbSyBcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdOdzBmD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710159733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dxf9l3FVcs3Y6LZTf/hatE8AZT2x1pwYFJhqRJ+R4I=;
	b=JdOdzBmDf5MmBjQoWraRh+AGwCvrWPNBGEgdI+pF5NBhnGZW0Q/rPo1syF02qu53ynJ+Vd
	HfeWRXFeIf1SFnmDFHLfzjfWSKMnIGCTRCClbgwesVlls1n39UKYrRU5FEED2bnkNkzcTC
	yKGi1hKp771InA5ml0KfNh5h0Z7bByM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-IQHnKeFuNM-t3xQb_KFrwg-1; Mon, 11 Mar 2024 08:22:11 -0400
X-MC-Unique: IQHnKeFuNM-t3xQb_KFrwg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412e355e2abso21370545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159731; x=1710764531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dxf9l3FVcs3Y6LZTf/hatE8AZT2x1pwYFJhqRJ+R4I=;
        b=LFAtGXaAtiwfn1jSqHYSKqmQT5uPNURwGaYAed5Ej7NOt7jiJbwTqxJA3kPYkuQ/58
         HJemgkkU76+iMzzSxf2Tj5ezfE6nwztHP0DiC5fx4EECdpJEVqaGRe14otEEGLR2u0Kx
         bCowTvRkf2l00cH1s/6Q5p524CI4ZAd0WWMiCcwPtNwwGIk+nd8oHtJQaPOjpvEz/jDu
         ts9Ns7b/qhq4e4KdC+9BexPzoAer7mpFSS3OctsSfj0w9sjgUO8MKldKko98xqaXOPoX
         RW4yAKPNXluqx/knulFtLtHQFTe91llTKBaGfRpjZzDsmRhGYkCF8ggqnyP35LTZI0Ab
         hIGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/2tg43/zkwNgJZGAjsf09qYdnOIzsAkRT9cWtwSkCuM8+gVcZb41EG1/9d2lzUNsi+yrgN7QHhCu9mBZOgELXJr80vjds/05i4gDU
X-Gm-Message-State: AOJu0YzkbKBZJ+9KyND6heb7D6XRPJuMwD1FoHlZ/llV0kQ5FbaiBbgs
	BarTMLL5bovcDUHk6bb3hy8E9+FSMtOW027FokhTP3iosLuBGL4rVmQJXVO+X5rR0OK/VSujTox
	5S7sB4zOAlmXxtzkoeT6VHToRqxYA9+ZmoEfMSxV301IeSe/HWP7A80o5ICZbhw==
X-Received: by 2002:a05:600c:4588:b0:413:2c77:1a22 with SMTP id r8-20020a05600c458800b004132c771a22mr936293wmo.8.1710159730744;
        Mon, 11 Mar 2024 05:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBbb7Y4Loy24pyff1/Zn1iHq6UmVm7da6yocw6+FzEH+R8dsh6vkWk8Gm14feUGP9Ez6PvSQ==
X-Received: by 2002:a05:600c:4588:b0:413:2c77:1a22 with SMTP id r8-20020a05600c458800b004132c771a22mr936280wmo.8.1710159730348;
        Mon, 11 Mar 2024 05:22:10 -0700 (PDT)
Received: from hs01.dakr.org (hs01.dk-develop.de. [2a02:c207:3002:6234::1])
        by smtp.gmail.com with ESMTPSA id bo5-20020a056000068500b0033e7e9c8657sm6287929wrb.45.2024.03.11.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:22:09 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:22:00 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to
 CString
Message-ID: <Ze73aPMEg-BUCE8W@hs01.dakr.org>
References: <20240223163726.12397-1-dakr@redhat.com>
 <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>

On Mon, Mar 04, 2024 at 01:22:17PM +0100, Danilo Krummrich wrote:
> On 2/23/24 17:37, Danilo Krummrich wrote:
> > Add functions to convert a CString to upper- / lowercase, either
> > in-place or by creating a copy of the original CString.
> > 
> > Naming followes the one from the Rust stdlib, where functions starting
> > with 'to' create a copy and functions starting with 'make' perform an
> > in-place conversion.
> > 
> > This is required by the Nova project (GSP only Rust successor of
> > Nouveau) to convert stringified enum values (representing different GPU
> > chipsets) to strings in order to generate the corresponding firmware
> > paths. See also [1].
> 
> Gentle ping.

It doesn't seem there's any further feedback, thus can this be merged?

- Danilo

> 
> > 
> > [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> > Changes in V5:
> >    - remove unneeded return statements
> >    - use Vec::as_mut_slice() instead of a dereference
> > Changes in V4:
> >    - move to_ascii_{lower,upper}case() to CStr
> >    - add a few comments suggested by Alice
> > Changes in V3:
> >    - add an `impl DerefMut for CString`, such that these functions can be defined
> >      for `CStr` as `&mut self` and still be called on a `CString`
> > Changes in V2:
> >    - expand commit message mentioning the use case
> >    - expand function doc comments to match the ones from Rust's stdlib
> >    - rename to_* to make_* and add the actual to_* implementations
> > ---
> >   rust/kernel/str.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 86 insertions(+), 1 deletion(-)
> > 
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 7d848b83add4..c1c8ccc80c52 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -5,7 +5,7 @@
> >   use alloc::alloc::AllocError;
> >   use alloc::vec::Vec;
> >   use core::fmt::{self, Write};
> > -use core::ops::{self, Deref, Index};
> > +use core::ops::{self, Deref, DerefMut, Index};
> >   use crate::{
> >       bindings,
> > @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
> >           unsafe { core::mem::transmute(bytes) }
> >       }
> > +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> > +    /// additional checks.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
> > +    /// `NUL` byte (or the string will be truncated).
> > +    #[inline]
> > +    pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> > +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> > +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > +    }
> > +
> >       /// Returns a C pointer to the string.
> >       #[inline]
> >       pub const fn as_char_ptr(&self) -> *const core::ffi::c_char {
> > @@ -206,6 +219,70 @@ pub unsafe fn as_str_unchecked(&self) -> &str {
> >       pub fn to_cstring(&self) -> Result<CString, AllocError> {
> >           CString::try_from(self)
> >       }
> > +
> > +    /// Converts this [`CStr`] to its ASCII lower case equivalent in-place.
> > +    ///
> > +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> > +    /// but non-ASCII letters are unchanged.
> > +    ///
> > +    /// To return a new lowercased value without modifying the existing one, use
> > +    /// [`to_ascii_lowercase()`].
> > +    ///
> > +    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
> > +    pub fn make_ascii_lowercase(&mut self) {
> > +        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
> > +        // string.
> > +        self.0.make_ascii_lowercase();
> > +    }
> > +
> > +    /// Converts this [`CStr`] to its ASCII upper case equivalent in-place.
> > +    ///
> > +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> > +    /// but non-ASCII letters are unchanged.
> > +    ///
> > +    /// To return a new uppercased value without modifying the existing one, use
> > +    /// [`to_ascii_uppercase()`].
> > +    ///
> > +    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
> > +    pub fn make_ascii_uppercase(&mut self) {
> > +        // INVARIANT: This doesn't introduce or remove NUL bytes in the C
> > +        // string.
> > +        self.0.make_ascii_uppercase();
> > +    }
> > +
> > +    /// Returns a copy of this [`CString`] where each character is mapped to its
> > +    /// ASCII lower case equivalent.
> > +    ///
> > +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> > +    /// but non-ASCII letters are unchanged.
> > +    ///
> > +    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
> > +    ///
> > +    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
> > +    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
> > +        let mut s = self.to_cstring()?;
> > +
> > +        s.make_ascii_lowercase();
> > +
> > +        Ok(s)
> > +    }
> > +
> > +    /// Returns a copy of this [`CString`] where each character is mapped to its
> > +    /// ASCII upper case equivalent.
> > +    ///
> > +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> > +    /// but non-ASCII letters are unchanged.
> > +    ///
> > +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
> > +    ///
> > +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
> > +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
> > +        let mut s = self.to_cstring()?;
> > +
> > +        s.make_ascii_uppercase();
> > +
> > +        Ok(s)
> > +    }
> >   }
> >   impl fmt::Display for CStr {
> > @@ -593,6 +670,14 @@ fn deref(&self) -> &Self::Target {
> >       }
> >   }
> > +impl DerefMut for CString {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: A `CString` is always NUL-terminated and contains no other
> > +        // NUL bytes.
> > +        unsafe { CStr::from_bytes_with_nul_unchecked_mut(self.buf.as_mut_slice()) }
> > +    }
> > +}
> > +
> >   impl<'a> TryFrom<&'a CStr> for CString {
> >       type Error = AllocError;
> > 
> > base-commit: 39133352cbed6626956d38ed72012f49b0421e7b


