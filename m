Return-Path: <linux-kernel+bounces-38292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E012D83BE26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D23B2DD85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DA41CD3A;
	Thu, 25 Jan 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzv10JHx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLgm1Xgl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D381CD2C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175520; cv=none; b=TnWgHX7lriRPd054Smjy08xcoSAELde1B/uJf8J6ANMQfx+6eM8FOzwRWA87wJg+UKkEpRiu10tDUiSFg1eCF1qSgkkZJPBtmRCpdkzumg1DIWgdLtrmXq6b6EhPIiRH8tX7CnxG0yCBrpbu9i5sKz7T0pl/3ykE/HVYja8WwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175520; c=relaxed/simple;
	bh=CNAktRCwF+AEmF8BsY9r7SYP1FMPZxLbGHZDZj2YVP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s3/IjFu5WC088OQUKZTD3vFUyjtjUj8qFjWS4YkyFjSHANdCsrrVJWyhD3vdAuAbkXNUnJNbUqmlSOGObVLat9OYG8/Ie68cm/kQraC1ZvJR57VmMJQ8a/9RNN2m1vhzCUH3J0/ALUW1IMT4FooaFmJ2N0KBqhWAOYKOe7zcXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzv10JHx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PLgm1Xgl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNAktRCwF+AEmF8BsY9r7SYP1FMPZxLbGHZDZj2YVP4=;
	b=vzv10JHxZJn6Mo9BMsSOzQxJzM6rEYCRW3mqD20GSTagTN7CFG5hqhowfRxPDaAq4JrXlr
	OJwSzROo3wwblrdJ5N+L1/6XV1hDDoPjoBtdxtUtl0rEgu5lilj1V3K+mL2xWXA/dubp4c
	nOyW6oXGDvVn0mjmVFS9DcNJlQjRBOPVUT7bkK+c5iNQ7jfFpLmNIvNrObKEcQ9ajJJBmH
	ydnvWWi3C53xsOhuG55pn0r/ro9hKpm37T0aDiMqOc2hmTdI4GdsGBv7HSnnWk0arBFu1I
	Vb3cmcR1D/qCenC39W2w4mfwyd8H71bia6OJu1RzR5GCe0BbE1mzrM4hu2EpYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNAktRCwF+AEmF8BsY9r7SYP1FMPZxLbGHZDZj2YVP4=;
	b=PLgm1XglALdZA1GwOkIDa69R3p/xQnb0mDl42YVfVT+Db3wZRlfNe8QpHRwYUzp2SUCW16
	8G3YbnyWdmXiheCw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 09/15] tick: Move broadcast cancellation up to
 CPUHP_AP_TICK_DYING
In-Reply-To: <20240124170459.24850-10-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-10-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:38:36 +0100
Message-ID: <87ttn1iwgz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> The broadcast shutdown code is executed through a random explicit call
> within stop machine from the outgoing CPU.
>
> However The tick broadcast is a midware between the tick callback and

s/The/the/

> the clocksource, therefore it makes more sense to shut it down after the
> tick callback and before the clocksource drivers.
>
> Move it instead to the common tick shutdown CPU hotplug state where
> related operations can be ordered from highest to lowest level.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

