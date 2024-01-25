Return-Path: <linux-kernel+bounces-38650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAC83C3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231D31C22801
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44BB51009;
	Thu, 25 Jan 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1OLbGSp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19zO674G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646451001
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189446; cv=none; b=RSu6nkZrSIWweFsA50LbkKW3Zc+Zco1mIqVwffPckdJfxGJvreGtYDRVaX24ACXD+Q/pQMPyp+Zf2gTewwbKQPcP/OULNi/N7B0H04t7GGAOz/1Sypp+KYb/bqMJBJzmaYMRzvBKIbCxAJAVYxFkbMZq41OZSooAV7x2xXOByPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189446; c=relaxed/simple;
	bh=h/uU8eQoI7TkoVtv+orv7Gfc3jLYH0IXZ5VfTnexG5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQwY0jtcnvB2YiV4wvvjKWb1ir3Y/LUOYGBzlfk9wvrSjfBac5cLH6/bXo0bpINxMHUtevofm34p+6dJG1aZtGjnfmE2lpQen0XPVsADzE2yH0NuJkTQD7BfFJhVtfh94n/W4l0+8EEuZFgN6cAWntf0/V3gCTuaaQbSMucowEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1OLbGSp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=19zO674G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706189442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5kdSSfYvADGdKw5gjzcDDROwT0/gGqPhOncxQDSRibs=;
	b=k1OLbGSpKX+/4+ZtQfB9dula0aX82Ze9+njKeLbZ8g0cldKYs16BrCLcaBUfxiUZoWCW5p
	RsvG1OZI9S8uejqqU+0lOG60ymdkPE92R3SorJLDaa9Mc1oTDUqY1NrMmgHd8Zlvon6R91
	/wOCrkS9AHRc5005Xe3W05/arK6o2+0K0l4be3OkT/1rxwsn39Q1RP8bRU+cibWrxRd6bJ
	WdZFrb8yPEvNUd1wDROEDBaevUuUPC1QRy6oFOG/SicbXt9qKNlkyNCbUTCZX7Qgw4VdhU
	vXsZyfh3XAS1P9rfvjroQ25yvW3M8ECa9tZUj2TdvyVgqCAxmDuQmm1DpfHgYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706189442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5kdSSfYvADGdKw5gjzcDDROwT0/gGqPhOncxQDSRibs=;
	b=19zO674GUTmD1nE1l1xdSNd8U7B/A5i6PnKuiH9aCOGIGaCXV7uzhbpDQlVHJHTfW48KTa
	yQh/8GUnNcrOGKCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 02/15] tick/nohz: Remove duplicate between lowres and
 highres handlers
In-Reply-To: <ZbJM7uP2tWJrqbk/@lothringen>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-3-frederic@kernel.org> <87ede5kbc6.ffs@tglx>
 <ZbJM7uP2tWJrqbk/@lothringen>
Date: Thu, 25 Jan 2024 14:30:41 +0100
Message-ID: <8734ulilq6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 25 2024 at 12:58, Frederic Weisbecker wrote:

> On Thu, Jan 25, 2024 at 10:32:09AM +0100, Thomas Gleixner wrote:
>> On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
>> > +/*
>> > + * We rearm the timer until we get disabled by the idle code.
>> > + * Called with interrupts disabled.
>> > + */
>> > +static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
>> 
>> Isn't that a misnomer now?
>
> Would tick_nohz_hrtimer_handler() make more sense then? Because it's clearly
> an hrtimer handler, just emulated in low-res mode.

Kinda. tick_nohz_handler() would be sufficient too.


