Return-Path: <linux-kernel+bounces-146576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB428A677B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553551F2157D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B31272A0;
	Tue, 16 Apr 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="0kAYJSRe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8186AE2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261215; cv=none; b=uFv0dfAUvLJPI05TSFjVLnEGbxpQfTSqjzws1mvUwLPlcMIyCjpbx4WSiXDbmIu6ebQhG2BioaduTYffAaRkipIrnwSvxeSgK+lXOe9edHikNgccw3ROTVk9JZaBKJYrRZH8hyVpcspyoqCwrE686Yef0JTIrrHnLGYLD8isdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261215; c=relaxed/simple;
	bh=aHSVCaMgVYEOxB4WL4+UESTTGEGkGtZz9krgfDSbn90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E8lfmYFAy54/7R3d9LJd9ql+juC4YkMVyH9CaH7yTGqzYHTcxdiiFulU/aKgUm/Kob+iawx2ZL3m624vKUpk4KBGnSWCrI8iVLNx+uP7JZdvKq1ot48S5lYCdknWyr0cNXj66mE+yWnqf7atpeuw1Vb+N0MQs/LJyEMgsDMCj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kAYJSRe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61aecbcb990so11052247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261212; x=1713866012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0aAJKt43O2yMsuhFwcdl7D4L5XLScuydd0VdOB1c5I=;
        b=0kAYJSReotcGKxB8Y2Dga8o64+1KfhuHuSIhIdERlZmE3Qs53JHwPRa2izyqNTmy2e
         jS/0U4lh5sPBzeHof981+pQMpvBFRjUUQnSCpSneFngssaS6+Z4nYdsfk69TMtz7SK11
         nTl3rT0vhSIH4pOs1R5q4ZOGkvmfwYtAzA+5cQUF7O0oGX6FsnMbrzKuz/CcGbqDQ5fH
         3/Ms95dihwkVqkZPlao8SRPAapdEOc2DkXBYMxtnk5JdeYW7NEDHlCYyRMGHaLiGE3pI
         HfHmBNW31pPD3ddpI4CchdqY7eN78Mxz6+mupZJLxz/EoJ83MaD3TDH7lT06zK3SEQYH
         gS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261212; x=1713866012;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0aAJKt43O2yMsuhFwcdl7D4L5XLScuydd0VdOB1c5I=;
        b=q0/4mAEPWOaNFFMqpBWWEO684qfvWsl3TWYEZYTtsFYNgwjKUQ+psUD5aniOxV75fS
         /TZffCernthAdoHzkYpTkrTiNouD5csZMso9FqAT0xWgRQUeduptjEHDrm8uJTU+nRKo
         0EIVVrqZnE6wfWvvT5YBMHzikX2CvsnjpvcMHAkmOaqxfUsc+EBZ4HLEWC7plSKia9r7
         DgdudKIqsbeXSNqYxBRbqaGfxtjwM2yxwGKPQ5OoVnQ34N8Aqn15snJPJy972foCaUJq
         PVdfJ40lTXXIPpA3tuW5FGI+xxnU7JQOgxTz24iGc1SSAN9KuM4bHrxc0w2CdUxNrHVG
         Kdpg==
X-Forwarded-Encrypted: i=1; AJvYcCUsC8UAUtFecX4WZhB3c9N6qgsj51BGo8+AepdBl7jaPQPjjb7WRGfK/Ddx8gQp+/PtSxAqwpuQLRnT4dxXxGWEYPjMBRODRs//L7SU
X-Gm-Message-State: AOJu0YyDP5/OyVD4zXy6chcGML4eRAUXXQezhyuNCmdpdSo/rD2rY5Y+
	2kfOJGMyw28QQdK4R1KrmYgR9IYfORb2SZYUOnbGm32RfXH0h9NEiC7Lcrta3lFgHsfQ/rRyJk4
	V0fAf6iGMGOKarQ==
X-Google-Smtp-Source: AGHT+IHM936jZicui9CRp5azu04c56T/Uxhpa7e4PHfoxPMGDIPiy9FGgXUa2AlZ+SNM7EZIFmDxAxMSYI8T7Hg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:f84:b0:dc2:550b:a4f4 with SMTP
 id ft4-20020a0569020f8400b00dc2550ba4f4mr3952714ybb.1.1713261212591; Tue, 16
 Apr 2024 02:53:32 -0700 (PDT)
Date: Tue, 16 Apr 2024 09:53:30 +0000
In-Reply-To: <CALNs47vkeAeU5jGk2AV_w0oRfPCiXzcWTGO_bauCnSsqQTX-iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALNs47vkeAeU5jGk2AV_w0oRfPCiXzcWTGO_bauCnSsqQTX-iA@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416095330.1108574-1-aliceryhl@google.com>
Subject: Re: [PATCH v5 3/4] rust: uaccess: add typed accessors for userspace pointers
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
>> Add safe methods for reading and writing Rust values to and from
>> userspace pointers.
>>
>> The C methods for copying to/from userspace use a function called
>> `check_object_size` to verify that the kernel pointer is not dangling.
>> However, this check is skipped when the length is a compile-time
>> constant, with the assumption that such cases trivially have a correct
>> kernel pointer.
>>
>> In this patch, we apply the same optimization to the typed accessors.
>> For both methods, the size of the operation is known at compile time to
>> be size_of of the type being read or written. Since the C side doesn't
>> provide a variant that skips only this check, we create custom helpers
>> for this purpose.
>>
>> The majority of reads and writes to userspace pointers in the Rust
>> Binder driver uses these accessor methods. Benchmarking has found that
>> skipping the `check_object_size` check makes a big difference for the
>> cases being skipped here. (And that the check doesn't make a difference
>> for the cases that use the raw read/write methods.)
>>
>> This code is based on something that was originally written by Wedson on
>> the old rust branch. It was modified by Alice to skip the
>> `check_object_size` check, and to update various comments, including the
>> notes about kernel pointers in `WritableToBytes`.
>>
>> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
> Couple of docs nits but this looks good to me.
>=20
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks for taking a look!

>> +/// Types for which any bit pattern is valid.
>> +///
>> +/// Not all types are valid for all values. For example, a `bool` must =
be either zero or one, so
>> +/// reading arbitrary bytes into something that contains a `bool` is no=
t okay.
>> +///
>> +/// It's okay for the type to have padding, as initializing those bytes=
 has no effect.
>> +///
>> +/// # Safety
>> +///
>> +/// All bit-patterns must be valid for this type.
>> +pub unsafe trait FromBytes {}
>=20
> No `UnsafeCell` is also a requirement in zerocopy/bytemuck

I can add that requirement.

>> +/// Types that can be viewed as an immutable slice of initialized bytes=
.
>> +///
>> +/// If a struct implements this trait, then it is okay to copy it byte-=
for-byte to userspace. This
>> +/// means that it should not have any padding, as padding bytes are uni=
nitialized. Reading
>> +/// uninitialized memory is not just undefined behavior, it may even le=
ad to leaking sensitive
>> +/// information on the stack to userspace.
>> +///
>> +/// The struct should also not hold kernel pointers, as kernel pointer =
addresses are also considered
>> +/// sensitive. However, leaking kernel pointers is not considered undef=
ined behavior by Rust, so
>> +/// this is a correctness requirement, but not a safety requirement.
>=20
> I don't think mentions of userspace are relevant here since the trait
> is more general. Maybe a `# Interfacing with userspace` section if
> there is enough relevant information.

I think it is relevant. It is the main purpose of the trait right now,
and it is also part of the justification for why the rules are what they
are.

>> +/// # Safety
>> +///
>> +/// Values of this type may not contain any uninitialized bytes.
>=20
> No UnsafeCell

Will add.

>> +pub unsafe trait AsBytes {}
>=20
>> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> index c97029cdeba1..e3953eec61a3 100644
>> --- a/rust/kernel/uaccess.rs
>> +++ b/rust/kernel/uaccess.rs
>> @@ -4,10 +4,15 @@
>>  //!
>>  //! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess=
h)
>>
>> -use crate::{bindings, error::code::*, error::Result};
>> +use crate::{
>> +    bindings,
>> +    error::code::*,
>> +    error::Result,
>> +    types::{AsBytes, FromBytes},
>> +};
>>  use alloc::vec::Vec;
>>  use core::ffi::{c_ulong, c_void};
>> -use core::mem::MaybeUninit;
>> +use core::mem::{size_of, MaybeUninit};
>>
>>  /// A pointer to an area in userspace memory, which can be either read-=
only or read-write.
>>  ///
>> @@ -238,6 +243,38 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Res=
ult {
>>          self.read_raw(out)
>>      }
>>
>> +    /// Reads a value of the specified type.
>> +    ///
>> +    /// Fails with `EFAULT` if the read encounters a page fault.
>> +    pub fn read<T: FromBytes>(&mut self) -> Result<T> {
>> [...]
>> +    /// Writes the provided Rust value to this userspace pointer.
>> +    ///
>> +    /// Fails with `EFAULT` if the write encounters a page fault.
>> +    pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
>=20
> Read & write could use an example if you are up for it

I may or may not add an example.

Alice

