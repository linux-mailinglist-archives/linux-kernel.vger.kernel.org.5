Return-Path: <linux-kernel+bounces-165192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C508B8951
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FB31F21435
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13187F496;
	Wed,  1 May 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="biLkbaCq"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1E79B7E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563434; cv=none; b=h+JR4Wm/JjEskhPgW3NJh2Jj/a5HKoUU4PFvgszO7NJOatDL9B4oY6NIBlkmOekctZyN+RDcKN7/nsHDz0w6AH4KIJsanEN9vvMkAKjNUllIkD0lTYA6Gdw0dKA6gkotNDFof/FV9INOXG0dmaeIg/lIzvWBIJc0Il3hzl/Kogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563434; c=relaxed/simple;
	bh=I8ZOvKDmnHpoDeeCfIBcoHBvCL0HKsayrdpo6OGfZ2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YKf2KlPsbaeWuYh4j7/8XsKABDyGUkzuLrlCZFJlgcoyIqpt2tKNjKpGr1QlsM7GEQ2GDqRc6Aa6h78ThKOmx5kTUccmj0/zlM98+hU49ckWZAZeLA6ji72uzPn4KjuaUu7AHdPQ4PIMuyy5cKaHwuHSXoFr9ttH2f9kuj20Hx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=biLkbaCq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso1026379f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714563429; x=1715168229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG5/quJWFmfDCJiDcJk+VNFQbi8uBoxA9kjLvqd6ZU0=;
        b=biLkbaCq4da1+LjE0ZsWEoM0MPkElxuKHzsdT4kfyu+UDZK7BAgd4ojtzqkSLYE+Xm
         4/W506L4pXHVa83bojO7nap2IrbONeKNRXQSu1kj6di7rtafXka5U0Em7syvVCN8xtye
         tJ8gUOVXJbdeNUuYpqWpiGwQpxHcDcnkvngXyZL7KBwHRdbWqh8qaFB/Hnypi0gbgG/N
         Ct6Mu+X5Y4Em72B32LI/HMiMDSJEmpHBAc06fbaEqC+/sQ4qnkqxjEFXw1W2FE8/I/i/
         1hkTY/DRW/cqeJK0CGMRBBpZeG1VDd8XE7JlYP91v5wMN59FwMsikMdlRsB5DWdoYmB2
         sNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714563429; x=1715168229;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IG5/quJWFmfDCJiDcJk+VNFQbi8uBoxA9kjLvqd6ZU0=;
        b=mNVWSNqNc6bPE6W/Gje9aQm/keaFzswq2mT3J3ExdazbDD3mFagNNGM2ZJCFU2SfD9
         nBYuvQMgPw5N7kpSsMEWPr6b2GTGw/D3L6TUvLTua97MyknwlIofQJha8+MHHJ4KENaR
         L5Pnkf9NLHLDM8Fny6ADWqPSsIB0KllWVAVkC4uJNeRfZl/Y+hWDulnWmt8dCN5ct2s1
         EUmOvICt5HpUv6RazQiU6eCE7MQgchiseB5iTcEQuq30Z91Tt4QF53DUYidWjczSCrG5
         suhsHbDCtskuEW+0e0CTUZvIF9+SO7S6I5qKTk72LwU6Adbus/RKZzJG0T4qJW85aA64
         6Dbg==
X-Forwarded-Encrypted: i=1; AJvYcCWOpnOE4Y8VxwbIVgPtbaV/ptocsoHjCJ6hD2VjqvtXM2gZJLTWR/P9R0Ne5PqCI+MtTnB9ATFxLnIfiI6YOwkLKCXBa48SqOdkii3S
X-Gm-Message-State: AOJu0Yy41h5JDSG8SNPpqSS1/ISVCPOTBCnThu4EDQEZsk9LGXfCwkdf
	O61jab8ZR9nM9lMw3O0+Rl18sBsHJQoxAavTfGoinuIzNUUSKMk69RXjmfFTAOw=
X-Google-Smtp-Source: AGHT+IE9vHAXQZXMDFbK6G1UR1ZR/zumQD8aczVM+x+syL/lx6iNkEFAFccxE/7dWhl41rvM6vgemQ==
X-Received: by 2002:adf:f302:0:b0:348:b435:273b with SMTP id i2-20020adff302000000b00348b435273bmr1455887wro.54.1714563428531;
        Wed, 01 May 2024 04:37:08 -0700 (PDT)
Received: from localhost ([147.161.155.113])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0034c59c41f45sm13341917wru.7.2024.05.01.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 04:37:08 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  Andreas Hindborg <a.hindborg@samsung.com>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,  Alice
 Ryhl <aliceryhl@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87ikzysd36.ffs@tglx> (Thomas Gleixner's message of "Wed, 01 May
	2024 00:25:01 +0200")
References: <20240425094634.262674-1-nmi@metaspace.dk> <87r0emss0j.ffs@tglx>
	<87le4uk936.fsf@metaspace.dk> <87ikzysd36.ffs@tglx>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Wed, 01 May 2024 13:37:00 +0200
Message-ID: <87cyq5kbkz.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> Andreas!
>
> On Tue, Apr 30 2024 at 20:18, Andreas Hindborg wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> On Thu, Apr 25 2024 at 11:46, Andreas Hindborg wrote:
>>>> +// SAFETY: A `Timer` can be moved to other threads and used from ther=
e.
>>>> +unsafe impl<T> Send for Timer<T> {}
>>>> +
>>>> +// SAFETY: Timer operations are locked on C side, so it is safe to op=
erate on a
>>>> +// timer from multiple threads
>>>
>>> Kinda. Using an hrtimer from different threads needs some thought in the
>>> implementation as obviously ordering matters:
>>>
>>>      T1                              T2
>>>      hrtimer_start()                 hrtimer_cancel()
>>>
>>> So depending on whether T1 gets the internal lock first or T2 the
>>> outcome is different. If T1 gets it first the timer is canceled by
>>> T2. If T2 gets it first the timer ends up armed.
>>
>> That is all fine. What is meant here is that we will not get UB in the
>> `hrtimer` subsystem when racing these operations. As far as I can tell
>> from the C source, the operations are atomic, even though their
>> interleaving will not be deterministic.
>
> That's correct. All operations happen with the associated base lock held.
>
>>>> +unsafe impl<T> Sync for Timer<T> {}
>>>> +
>>>> +impl<T: TimerCallback> Timer<T> {
>>>> +    /// Return an initializer for a new timer instance.
>>>> +    pub fn new() -> impl PinInit<Self> {
>>>> +        crate::pin_init!( Self {
>>>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrt=
imer| {
>>>> +                // SAFETY: By design of `pin_init!`, `place` is a poi=
nter live
>>>> +                // allocation. hrtimer_init will initialize `place` a=
nd does not
>>>> +                // require `place` to be initialized prior to the cal=
l.
>>>> +                unsafe {
>>>> +                    bindings::hrtimer_init(
>>>> +                        place,
>>>> +                        bindings::CLOCK_MONOTONIC as i32,
>>>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>>>
>>> This is odd. The initializer really should take a clock ID and a mode
>>> argument. Otherwise you end up implementing a gazillion of different
>>> timers.
>>
>> I implemented the minimum set of features to satisfy the requirements
>> for the Rust null block driver. It is my understanding that most
>> maintainers of existing infrastructure prefers to have a user for the
>> implemented features, before wanting to merge them.
>>
>> I can try to extend the abstractions to cover a more complete `hrtimer`
>> API. Or we can work on this subset and try to get that ready to merge,
>> and then expand scope later.
>
> Wouldn't expanding scope later require to change already existing call si=
tes?

Yes, potentially. But I hear that Coccinelle is gaining Rust support =F0=9F=
=91=8D

>
>>>> +                    );
>>>> +                }
>>>> +
>>>> +                // SAFETY: `place` is pointing to a live allocation, =
so the deref
>>>> +                // is safe. The `function` field might not be initial=
ized, but
>>>> +                // `addr_of_mut` does not create a reference to the f=
ield.
>>>> +                let function: *mut Option<_> =3D unsafe { core::ptr::=
addr_of_mut!((*place).function) };
>>>> +
>>>> +                // SAFETY: `function` points to a valid allocation.
>>>> +                unsafe { core::ptr::write(function, Some(T::Receiver:=
:run)) };
>>>
>>> We probably should introduce hrtimer_setup(timer, clockid, mode, functi=
on)
>>> to avoid this construct. That would allow to cleanup existing C code to=
o.
>>
>> Do you want me to cook up a C patch for that, or would you prefer to do
>> that yourself?
>
> Please create that patch yourself and convert at least one C location to
> this new interface in a separate patch. THe remaining C cleanup can go
> from there and mostly be scripted with coccinelle.

Ok.

>
>>>> +/// [`Box<T>`]: Box
>>>> +/// [`Arc<T>`]: Arc
>>>> +/// [`ARef<T>`]: crate::types::ARef
>>>> +pub trait RawTimer: Sync {
>>>> +    /// Schedule the timer after `expires` time units
>>>> +    fn schedule(self, expires: u64);
>>>
>>> Don't we have some time related rust types in the kernel by now?
>>
>> There are patches on the list, but I think they are not applied to any
>> tree yet? I did not want to depend on those patches before they are
>> staged somewhere. Would you prefer this patch on top of the Rust `ktime`
>> patches?
>
> The initial set is queued in
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>
> for 6.10. Boqun has some updates on top IIRC. Your stuff should go
> through that branch too.

Ok.

>
>>>> +        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
>>>> +        let receiver =3D unsafe { Arc::from_raw(data_ptr) };
>>>> +
>>>> +        T::run(receiver);
>>>> +
>>>> +        bindings::hrtimer_restart_HRTIMER_NORESTART
>>>
>>> One of the common use cases of hrtimers is to create periodic schedules
>>> where the timer callback advances the expiry value and returns
>>> HRTIMER_RESTART. It might be not required for your initial use case at
>>> hand, but you'll need that in the long run IMO.
>>
>> If you are OK with taking that feature without a user, I will gladly add
>> it.
>
> I'm fine with taking a more complete API which does not require to
> change usage sites later on.

I will expand the API and send an updated patch when that is done =F0=9F=91=
=8D

BR Andreas

