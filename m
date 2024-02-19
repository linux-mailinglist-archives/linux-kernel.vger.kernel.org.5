Return-Path: <linux-kernel+bounces-71081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D866B85A06D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A47D282615
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9F82556D;
	Mon, 19 Feb 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gTXeI+X0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaUWd7S4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B60250ED;
	Mon, 19 Feb 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336777; cv=none; b=fufyfF6f4VP27ZQ+BgGQQXol0kEw3FVd8S7p2dQWYKyV3i/3dz9j05k7TKDpr2kniKh+/NB55/mbClabTtfokYP/9X42U5K3xHKcosJnDKD9j3OcuJ9DfZWCME1EitLruQbAIXlkt/RuRjNCxjH7riAtz6xCalJKtoBqqVjfgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336777; c=relaxed/simple;
	bh=719/8bQ/fJs7PlrwLT9LOERWbFxosqOojR0oxWtQS3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0uQ0UF9XzxeQ5Dw0aBLJHJe4oOl6235BAGh93nm5RJyuxIXd81TjpHsEGnI3NwuAm53p6DauLWG1fqr//mp/8SX9hZnKHvBzkh5ug6zF8bW1GGN+iwGFtdfFK5/ol8DtEwqWM3z6d/iYszPMZ9H6BnMEFdYl+GyrCjdF7KFuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gTXeI+X0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AaUWd7S4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708336773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEgT5l6Rc8UCXjauf1B1Sdo67SS0C1xsgpH1Y9aPN5k=;
	b=gTXeI+X07xiTlovvS7BnUubcUVAELIIapaAZwE9T/0sOjpSqJ4bJFSpdpebeHem9F79HJH
	ViK5gDEhPOCizEVOOCDY+SgZtWjgtZOfpLgqTEjXzVto1mjcJAEsMDT2zi0JqQ/Py1vrZV
	DKFXacrTLoDfkTGjsAQGbAwj2XbuS4IVjLpoMiPcKfF0Gt+3F+BdufLXlq6ZgIZnXAEoVU
	pOg1c6dbN48WeiMQXVBKYWZ7uga5kqadcj+IXBvoA0AosYuoGy5owtK3ERuJg1+R0h93xp
	0Y3gelAThHhS7E0zXTF/JVASMjGrfalIGq2QIUd3ihgQt4mCeIiHICYlQnmnzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708336773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEgT5l6Rc8UCXjauf1B1Sdo67SS0C1xsgpH1Y9aPN5k=;
	b=AaUWd7S4YM1ZTooyGtVjK+aRlPWp1mh/hvJ++iXKQfnl19KN/a3GYBwIreoGGA2veL4qgz
	Kqz8Ym3QQt41i7BA==
To: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Leonardo Bras <leobras@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <20240216075948.131372-5-leobras@redhat.com>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com>
Date: Mon, 19 Feb 2024 10:59:33 +0100
Message-ID: <87zfvwai62.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 16 2024 at 04:59, Leonardo Bras wrote:

> In threaded IRQs, some irq handlers are able to handle many requests at a
> single run, but this is only accounted as a single IRQ_HANDLED when
> increasing threads_handled.
>
> In order to fix this, introduce IRQ_HANDLED_MANY, so the returned value of
> those IRQ handlers are able to signal that many IRQs got handled at that
> run.
>
> Is scenarios where there is no need to keep track of IRQ handled, convert
> it back to IRQ_HANDLED.

That's not really workable as you'd have to update tons of drivers just
to deal with that corner case. That's error prone and just extra
complexity all over the place.

This really needs to be solved in the core code.

Thanks,

        tglx

