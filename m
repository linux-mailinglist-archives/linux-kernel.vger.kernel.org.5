Return-Path: <linux-kernel+bounces-108934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B5881235
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B52BB20FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1840BFD;
	Wed, 20 Mar 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FE4nGxSY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRfQcawU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E93CF6A;
	Wed, 20 Mar 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940734; cv=none; b=dCfYmnL/1M1mp9hlJyTYh8k+lhVDLxq+1hpUQaziq5dBkF4/eYtMAI8guMND3CnLbI1WW3khy6AoR1H9SA4l7dd2vaIJzR9neaD810CTEzCKJxK/isx20IjgABgMOrT2Sd4DfWytNVvTbrk1E+yLEfGR0///plND4+7ilp0irV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940734; c=relaxed/simple;
	bh=+jpXXIEeaJenKyQ3XK/8Tixii9tnHPTCZ6gd0CUF5zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZdK308K55hAjXCy0b4iNFY2eprW/64i+pRPX/aMqmleGDVkeDTraAo99SxAQjXfNep7eWEujybGXdzGImKpZkK+qREvBpdTPA5vRtuWY03FZZb+ljFTJu/ukI//JiLOboKFPjsdEfGp3h1KZU/zO9LCPHQEmrzM1+vwIyfgNjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FE4nGxSY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRfQcawU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710940731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUNpdgzqhkxsescD5mhvB4F0uZWIG7XsxVM/4+Kxi2A=;
	b=FE4nGxSYwpRBStfHyUjT+4PiPihErxEaVjuhOlRr/HKxEfC0IqmYETFdRFVAr81EQ/4v6n
	UJinrGfXFjMDVE4EFTw12v7JHcIMOlWGygjWMjD0SSgP+UTDTNEciAjagvALM9YUS17HyE
	kctfz8bgptLH2HY6/yJOYCIJIsmJ6N1FNFWedCepcxOdUs9j9XRobEVvg63MP5LB5uqzcS
	HgphbGcD/CFcoD24VldwsVuoDqVcewSJvnRLbqiBnSG4bYLkNerj+Bs0vR/WYEaa7oSAFC
	MWik0cEHP7RoSiQgWojMYEDyC/M1l4c9Bq4EcmWxfSHSOINe3G3VVkUEI9IAMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710940731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUNpdgzqhkxsescD5mhvB4F0uZWIG7XsxVM/4+Kxi2A=;
	b=FRfQcawU0uVk8FY/gWbFxDwCOjjtfLWgpRcIfpq8WZO8zoxBjiqHpqdKLjL2OAcg1IPyDj
	zY5A6kwkvhepr8Cw==
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg
 <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] rust: time: add Ktime
In-Reply-To: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>
References: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>
Date: Wed, 20 Mar 2024 14:18:51 +0100
Message-ID: <87wmpxghxg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 20 2024 at 10:08, Alice Ryhl wrote:
> +impl Ktime {
> +    /// Create a `Ktime` from a raw `ktime_t`.
> +    #[inline]
> +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> +        Self { inner }
> +    }
> +
> +    /// Get the current time using `CLOCK_MONOTONIC`.
> +    #[inline]
> +    pub fn ktime_get() -> Self {
> +        // SAFETY: It is always safe to call `ktime_get`.

That's not entirely correct. ktime_get() cannot be safely invoked from
NMI context. That won't matter for driver writers obviously.

Looks sensible otherwise.

Thanks,

        tglx

