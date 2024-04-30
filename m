Return-Path: <linux-kernel+bounces-164771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6628B82A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F0A1F219C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863A1BF6F7;
	Tue, 30 Apr 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQEFIXc8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOaCImBv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6C1BF6DE;
	Tue, 30 Apr 2024 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515908; cv=none; b=aCYLueAMe4YlolZ4qgdMnJmtuTxSj0RP9fQKCJBWkZTdqKGLXzXSuxZ55B2sb9EILsplYbHJqRsCh85U4ziaGfPEbqIfpD10v+9wYDpRNYc0oRb36wK00MVxgk+OWKbEiBwLtQjT70iZWk5AvyjZs2B0WR0gvt+LjxMX87E6Wps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515908; c=relaxed/simple;
	bh=Tdxlrja/E556yM8G8Moo4I9ZA6Lih+TFa36AHyR449o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZM8AioNJwz0LRELoeyE8Foyd1lC59DMNqsXb9KcoHJ0EDicYdjguc/zuDDApm12Q1wyrDDN9Y7gTDxiZVxWbNW08D4+BGJENDFiVWB9by0GMmQgARW72szxgb6VzToqi+bGmB+bowmorYy/vnn+Nq9lmbDr+N2LVw1pYXYxgyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQEFIXc8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOaCImBv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714515904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1TS/HO0mqmfdycdlpODJrQqB9T6VoVjE4nOwjJ+wi5o=;
	b=EQEFIXc8+ljJg4VFarlQSTuWQLtlMexz56Vjrdd2LJBUjc0/7QLF8+UtlZxvkiOhtx1a7C
	CDeX82g08YWVQp1dmER5ocK4rP+xxaM3RS3O/4xFDCWYmEx75+PGT2SPWaaa2ZO0HYEseO
	rsbMNyz3Nl/A5HtPvRLJx9qDrYuS5MRHVRJSDHuRezkM0m7tgjNJV1204PddkuCjFx8/aV
	k/4Hf0tUvLzKash7Myf2umsWxMiNiA9ye+kLyXEMjJ0WE/JbnkkfdKsopGqHlGdP6GWGFr
	HMmRfxow+8VIR8Qs5y6djKgLj6ZTkllW+MKc4iAwoKHHhbadlYbfb64LVXSyKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714515904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1TS/HO0mqmfdycdlpODJrQqB9T6VoVjE4nOwjJ+wi5o=;
	b=UOaCImBvI/YdTXd5F4mwktZqa/1l0OwKJQOr8PcCxdmaHROTFISROrDyl2xObEtax9G1kf
	v8zD8fQna57EgwCQ==
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87le4uk936.fsf@metaspace.dk>
References: <20240425094634.262674-1-nmi@metaspace.dk> <87r0emss0j.ffs@tglx>
 <87le4uk936.fsf@metaspace.dk>
Date: Wed, 01 May 2024 00:25:01 +0200
Message-ID: <87ikzysd36.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas!

On Tue, Apr 30 2024 at 20:18, Andreas Hindborg wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> On Thu, Apr 25 2024 at 11:46, Andreas Hindborg wrote:
>>> +// SAFETY: A `Timer` can be moved to other threads and used from there.
>>> +unsafe impl<T> Send for Timer<T> {}
>>> +
>>> +// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
>>> +// timer from multiple threads
>>
>> Kinda. Using an hrtimer from different threads needs some thought in the
>> implementation as obviously ordering matters:
>>
>>      T1                              T2
>>      hrtimer_start()                 hrtimer_cancel()
>>
>> So depending on whether T1 gets the internal lock first or T2 the
>> outcome is different. If T1 gets it first the timer is canceled by
>> T2. If T2 gets it first the timer ends up armed.
>
> That is all fine. What is meant here is that we will not get UB in the
> `hrtimer` subsystem when racing these operations. As far as I can tell
> from the C source, the operations are atomic, even though their
> interleaving will not be deterministic.

That's correct. All operations happen with the associated base lock held.

>>> +unsafe impl<T> Sync for Timer<T> {}
>>> +
>>> +impl<T: TimerCallback> Timer<T> {
>>> +    /// Return an initializer for a new timer instance.
>>> +    pub fn new() -> impl PinInit<Self> {
>>> +        crate::pin_init!( Self {
>>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
>>> +                // SAFETY: By design of `pin_init!`, `place` is a pointer live
>>> +                // allocation. hrtimer_init will initialize `place` and does not
>>> +                // require `place` to be initialized prior to the call.
>>> +                unsafe {
>>> +                    bindings::hrtimer_init(
>>> +                        place,
>>> +                        bindings::CLOCK_MONOTONIC as i32,
>>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>>
>> This is odd. The initializer really should take a clock ID and a mode
>> argument. Otherwise you end up implementing a gazillion of different
>> timers.
>
> I implemented the minimum set of features to satisfy the requirements
> for the Rust null block driver. It is my understanding that most
> maintainers of existing infrastructure prefers to have a user for the
> implemented features, before wanting to merge them.
>
> I can try to extend the abstractions to cover a more complete `hrtimer`
> API. Or we can work on this subset and try to get that ready to merge,
> and then expand scope later.

Wouldn't expanding scope later require to change already existing call sites?

>>> +                    );
>>> +                }
>>> +
>>> +                // SAFETY: `place` is pointing to a live allocation, so the deref
>>> +                // is safe. The `function` field might not be initialized, but
>>> +                // `addr_of_mut` does not create a reference to the field.
>>> +                let function: *mut Option<_> = unsafe { core::ptr::addr_of_mut!((*place).function) };
>>> +
>>> +                // SAFETY: `function` points to a valid allocation.
>>> +                unsafe { core::ptr::write(function, Some(T::Receiver::run)) };
>>
>> We probably should introduce hrtimer_setup(timer, clockid, mode, function)
>> to avoid this construct. That would allow to cleanup existing C code too.
>
> Do you want me to cook up a C patch for that, or would you prefer to do
> that yourself?

Please create that patch yourself and convert at least one C location to
this new interface in a separate patch. THe remaining C cleanup can go
from there and mostly be scripted with coccinelle.

>>> +/// [`Box<T>`]: Box
>>> +/// [`Arc<T>`]: Arc
>>> +/// [`ARef<T>`]: crate::types::ARef
>>> +pub trait RawTimer: Sync {
>>> +    /// Schedule the timer after `expires` time units
>>> +    fn schedule(self, expires: u64);
>>
>> Don't we have some time related rust types in the kernel by now?
>
> There are patches on the list, but I think they are not applied to any
> tree yet? I did not want to depend on those patches before they are
> staged somewhere. Would you prefer this patch on top of the Rust `ktime`
> patches?

The initial set is queued in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

for 6.10. Boqun has some updates on top IIRC. Your stuff should go
through that branch too.

>>> +        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
>>> +        let receiver = unsafe { Arc::from_raw(data_ptr) };
>>> +
>>> +        T::run(receiver);
>>> +
>>> +        bindings::hrtimer_restart_HRTIMER_NORESTART
>>
>> One of the common use cases of hrtimers is to create periodic schedules
>> where the timer callback advances the expiry value and returns
>> HRTIMER_RESTART. It might be not required for your initial use case at
>> hand, but you'll need that in the long run IMO.
>
> If you are OK with taking that feature without a user, I will gladly add
> it.

I'm fine with taking a more complete API which does not require to
change usage sites later on.

Thanks,

        tglx

