Return-Path: <linux-kernel+bounces-164486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FB8B7E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F7A1F23445
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2AD17B4F7;
	Tue, 30 Apr 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0eSJFJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PjfGE2I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DA143759;
	Tue, 30 Apr 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496744; cv=none; b=dh00fhxcnLvGrkD8xoHYJCXfWCDcIKAOFKjZVA9oGYRWletnaSzXw74Z1L1L9Ci8JrYjXax2tX/DcfY3ttB76Je8kmSEI76XxXRy5N4iKNhfXSgVgVAhvgqG9NvpOvKP87hQw1+vYwBntpB84ppD77pQbGs6/bFbijxB6R3M7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496744; c=relaxed/simple;
	bh=G7Kcu3vK4BG2uY14XUOC2AcXoQbX4M7wiJtUiTnP7Jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyZI9FqP1IQ4TY97T1CRszyGRcjMeSCcQxPf9KNFqy5SRgYI7Gev7ZqCdYjj9FIDXSreiJIQAKaM/6YqNnAlDDmUycqj6WIBPLOxInl9lwEKtdy8HJKZ/vSeK1+klfGyxygQH4oSXcwZ1IiA06+6uryYum+ox+297GFxhF3WV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0eSJFJO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PjfGE2I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714496741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH0PXfBAqkgaJL8r0cv+ui01m2qWIJu7rp3i651vjzc=;
	b=a0eSJFJOepk0VrObCXWQ3d2RU3hL88gxqH046kEGZS4e7+lLKdkxMtMQ98J1bDAoe1TzAA
	nDVReKFFZ0/itlpZtd0sV0yTDZseTU4G3w8wTH3hsLR7WBhtXaylUpcTHDKkgIPRD4CqpB
	qxql17GSDWeeXnkPptPyIQVk59h8US+YTStFF3jsqwbzVFSxnPrtiH89NtCVG8/RhL8ZEz
	sqoEAqEvgsGSb9J4rMAUYpnBYDQ/0c6iRBaxvF33IH5wXKuiGbPfL+/5mM+/YzZxf2RhlA
	3vZ3d2/KO6RFcAx58THi/Q0Iu5v6uFRVur//Z9eb3GXz+j0ap3QJg6XXJocf6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714496741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH0PXfBAqkgaJL8r0cv+ui01m2qWIJu7rp3i651vjzc=;
	b=3PjfGE2I2bIpcOOuh8wb9t3oFPOEs4Rj1ye7JDCUheflQcgfXGbpVTAtgvYWHHS27yjsU3
	UC9mltSJKv6WdEAw==
To: Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg
 <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
References: <20240425094634.262674-1-nmi@metaspace.dk>
 <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
Date: Tue, 30 Apr 2024 19:05:37 +0200
Message-ID: <87o79qsrvi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 26 2024 at 07:52, Benno Lossin wrote:
> On 25.04.24 11:46, Andreas Hindborg wrote:
>> +#[pinned_drop]
>> +impl<T> PinnedDrop for Timer<T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: By struct invariant `self.timer` was initialized by
>> +        // `hrtimer_init` so by C API contract it is safe to call
>> +        // `hrtimer_cancel`.
>> +        unsafe {
>> +            bindings::hrtimer_cancel(self.timer.get());
>> +        }
>> +    }
>> +}
>
> Why is this needed? The only way to schedule a timer using this API is
> by having an `Arc` with a timer-containing struct inside. But to
> schedule the `Arc`, you consume one refcount which is then sent to the
> timer subsystem. So it is impossible for the refcount to drop below zero
> while the timer is scheduled, but not yet running.
> Do you need to call `hrtimer_cancel` after/while a timer is running?
>
> Also is it ok to call `hrtimer_cancel` inside the timer callback? Since
> that can happen when the timer callback owns the last refcount.

You cannot invoke hrtimer_cancel() from within the callback. That
deadlocks because hrtimer_cancel() waits for the callback to complete.

Thanks,

        tglx

