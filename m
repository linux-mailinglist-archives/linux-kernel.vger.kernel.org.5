Return-Path: <linux-kernel+bounces-29479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9026830F14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5803E1F27CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECB286AC;
	Wed, 17 Jan 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lr+87xkv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5vbaTvS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200982557C;
	Wed, 17 Jan 2024 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529328; cv=none; b=kK+usL7UFtV5gT6HJWEkXJnY25jKpjJYdz79+RuMZCamWxSRb1lw4t+aoSj5oiw2ogjAGcZqjJFM4LB0c7xx7+ygcH4ts0N+gwKbrGhBp9YA/ubveeJEdIMrEXKi2zIE/TXImm15swtGZxwv8DTh4JrMHW/3zpYHgJTQx2/ieKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529328; c=relaxed/simple;
	bh=qFaa8BOzaemhbbpaBNe+bRaxotM4CvhfHIbd776F9dI=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=Fhk+E3Gx17SYuFyXI+YDnwgbEM+cK93AzQ+nI7LeCtJB7Y2hF0CLsZqVP0BIMUpVtiXfYm0W0g7hAkCyXJxN3UlB6kIvj2TW4VyV5P0155BGeVUGNoETN/FKzlu+gGgUtazHgNps7hAkg+hraCwMqHLNh5LSVBnWqKACRyHcvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lr+87xkv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5vbaTvS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705529324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8Rre0myowdkjUOQXq/GBz+sm7iyJq6YRt8odewpPa4=;
	b=Lr+87xkvQscfF5q5za0FUeY5Fp+AFvZOkhxF8ESsLSzdwYh4MSsPyelV7KnMtVecYpnaAE
	w6+6jPvWfv+dy/EeTXAdqYc9xIV6/sb4VZUAV+p5jHoXnuXDgKOlELj9gDNufOHF66KyBP
	CdFbUBRPv/FSlM1z2i8f5mg2eAl9ymzM7uu31TxstEA/ryV+fk0aspLaFPfWeNnoX0ap6P
	dvs85DAv50BmY+nb+onfKUtMeYirjTw6kXGNOFnVNUvlkUz1rWVCLTglUwHdYT2vVyGCpE
	+3dTrsisWITBRfR4OyoOD2dPvZjizcILoyr0zs/qOXzSj6OT9AhOYm0dXhpnwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705529324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8Rre0myowdkjUOQXq/GBz+sm7iyJq6YRt8odewpPa4=;
	b=f5vbaTvSe3JRd9U0N0qbggcC0Ynjd5eLuBgJhqrv/GsmGdIok/kRSbLRbdWrOur0OtmJmm
	bIpRJwhWTy4bbeAw==
To: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, John Ogness <john.ogness@linutronix.de>, Tony
 Lindgren <tony@atomide.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RESEND RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if
 an irq_thread handles one IRQ request
In-Reply-To: <20240116073701.2356171-2-leobras@redhat.com>
References: <20240116073701.2356171-1-leobras@redhat.com>
 <20240116073701.2356171-2-leobras@redhat.com>
Date: Wed, 17 Jan 2024 23:08:44 +0100
Message-ID: <87ttnbfw9f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 16 2024 at 04:36, Leonardo Bras wrote:
> This IRQ line disable bug can be easily reproduced with a serial8250
> console on a PREEMPT_RT kernel: it only takes the user to print a lot
> of text to the console (or to ttyS0): around 300k chars should be
> enough.

That has nothing to do with RT, it's a problem of force threaded
interrupts in combination with an edge type interrupt line and a
hardware which keeps firing interrupts forever.

> To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
> one IRQ request.

This papers over the symptom and makes runaway detection way weaker for
all interrupts or breaks it completely.

The problem with edge type interrupts is that we cannot mask them like
we do with level type interrupts in the hard interrupt handler and
unmask them once the threaded handler finishes.

So yes, we need special rules here when:

   1) The interrupt handler is force threaded

   2) The interrupt line is edge type

   3) The accumulated unhandled interrupts are within a sane margin

Thanks,

        tglx

