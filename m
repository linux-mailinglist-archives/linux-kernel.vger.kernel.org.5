Return-Path: <linux-kernel+bounces-139018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF889FD83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F53280F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDED17B51E;
	Wed, 10 Apr 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EiizNN1U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2QjUseu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998617B51B;
	Wed, 10 Apr 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768279; cv=none; b=kSPF8ycWlwQEBXbZEmHXRF00+dKfCJjewYBqaY0AH/OHtVuCTCwXh+6if0ZBVKwFmC+kknM3oelJhTXZHttetMns0kSJh1N25VVxHY0lqb2DaEybyovUvJXltJq1wmi5ayjsPeDbn6maRya47EUrnxjU7kRRtl1y1AoYt7TwPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768279; c=relaxed/simple;
	bh=Z/ZgqaypGaV5swi15SPT/jtzv4HSULo1UI0nOqmEKes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bFX8FCdYmCUWPmmtVL7J2Gs8krU1n+NU+8+Q3mGykH7+j8hHo0S0dxs49z1v8OExHKwyX7xQc0yYS5AdzQmhrEIC14hD0mOm6XjBOrGECbA1L4c984MKHKwIHk4BHxiX6EV3Cz3Oe/xJCmU5UdPpQVYm+meM8AAz/O42+SwPQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EiizNN1U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2QjUseu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712768276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/ZgqaypGaV5swi15SPT/jtzv4HSULo1UI0nOqmEKes=;
	b=EiizNN1UGYKYXzf7NRbZWq2tkmt5yiBlDPHkpDAh9Ri1hi8XJ5nzE99AE4MhnhNBLewiSM
	wHUwV0D6NYfWxaQjQKHRhhhSOA6SE5J/Agy/1Wy4uomoxh4WOH89ZrMHojmSi1gW3wPY3U
	jYeA1eHDmfEyrTgBmvPpPjWi+IEwG84JkPhO0S6YDG66RuvF0geKWLM9t+YgftTfCkjM56
	2587eF+AcK9qi0/E3Jrc4QvKVKpn6Vcd3VIbyI/5UAcGXBs3n0v0YBaKUTvyFODSIS3fFb
	6J1qxOAg2BSKMgku5QHBZ7K71Uopcd8RFnLGC2J5LkeMG/BhRfNLEmGbWyUvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712768276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/ZgqaypGaV5swi15SPT/jtzv4HSULo1UI0nOqmEKes=;
	b=L2QjUseufo3EpamzfqlCtxYv+wy8YLexNGrqOW2E5n24SXMLLo33ABn9a/7QKMYA17/ilC
	N0G5TERtlqRbXYDw==
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg
 <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: time: add Ktime
In-Reply-To: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
Date: Wed, 10 Apr 2024 18:57:55 +0200
Message-ID: <87v84p2m0c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 22 2024 at 08:59, Alice Ryhl wrote:
> Introduce a wrapper around `ktime_t` with a few different useful
> methods.
>
> Rust Binder will use these bindings to compute how many milliseconds a
> transaction has been active for when dumping the current state of the
> Binder driver. This replicates the logic in C Binder [1].
>
> For a usage example in Rust Binder, see [2].
>
> The `ktime_get` method cannot be safely called in NMI context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [3] or a similar tool will be used to check it in the future.
>
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103 [2]
> Link: https://rust-for-linux.com/klint [3]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

