Return-Path: <linux-kernel+bounces-87715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56FB86D81A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4491C21003
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD81851;
	Fri,  1 Mar 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sl2K9FRu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UcJ+hhU2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F7EC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251348; cv=none; b=pXPmtywafu+fYaYFmjdezNjMHcQLJDDkFyUblqi+4/IjEoo+67YPsyVCrsfgXJG+nrrawZa6kIegi/ZhdndHVUcZ52QEttIbz51CPfnOYG90T/C+ts7+C/HzO7dCQLIk43hn+67hcUY07h13DfwIJ5aOZPD+Y/stVHl4YxXJIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251348; c=relaxed/simple;
	bh=oUJiaf0TY3gDkbZPcr6f6p1dgQYPYkH6NvKCqsgj1dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEEO6mjJ+Lfu9J70UPXWaqbvKOAYQFf3KQkGReL2BSvbbTNhNCFOACjYyzECUBI4XnPxcYVW3qhFOzibS7z1VXLh4Gu/dy/lnbvfNYsKs/fK+0gkuoXUkpDcIZsvQzfHU20d625JCv/ONdDlsQIjriXFxQY1JzHjbYL/nDrbAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sl2K9FRu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UcJ+hhU2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709251343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNLxnwnRr0Lnru2BqChvcZ/4Fhlb3GVJp1r6JvXa0JY=;
	b=Sl2K9FRuLPWlgdM1XhIQXkH4ku/NSnMTZaIVaJ584hSHJ4hov86MiSvUZuCZepIUVR1cAx
	oIAd19FIiFpZhPHCMUytfz736D85uQuykrl1uiXXBGU+ehS0tIR5i6Og713rtfA4Vb3thb
	2MYEb04nw1jZ0UZbBMj+WDKy0/TT6nIgqd1FYRfe5qhT95dSEyKVrkioPYQTEJfR70tBMI
	av5wCrc8Ha2AZQfzPfAXK+btFjrbeNVb8EJFZgZonhyLldweWhvrA/VoI8CpvtXRTzsGmy
	4w8r/0MEaWbhCmuU0X9wAgisrnK4Ab4CPdYU22KqF6zJkMuwXqFyKqQfCiIE6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709251343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNLxnwnRr0Lnru2BqChvcZ/4Fhlb3GVJp1r6JvXa0JY=;
	b=UcJ+hhU2wQDuzErMMuwb1abPj6Fwm77imjQaAgGeflRvwfr7OUJZxk2PWYmAx8HPt83+vl
	EzRkidiP60XJfEAQ==
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
In-Reply-To: <f1fc564c-528a-47d0-8b68-d596d6681eb5@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
 <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk> <87wmqn6uaw.ffs@tglx>
 <edd520ab-b95f-4a60-a35a-2490a6d5057f@kernel.dk> <87sf1b6o9w.ffs@tglx>
 <f1fc564c-528a-47d0-8b68-d596d6681eb5@kernel.dk>
Date: Fri, 01 Mar 2024 01:02:22 +0100
Message-ID: <87jzmm7rap.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 15:30, Jens Axboe wrote:
> On 2/29/24 12:52 PM, Thomas Gleixner wrote:
>>         return atomic_read(&cpu_rq(cpu)->nr_iowait) & ((1 << 16) - 1);
>> 
>> Obviously written with proper inline wrappers and defines, but you get
>> the idea.
>
> I'll play with this a bit, but do we want to switch to an atomic_long_t
> for this? 2^16 in iowait seems extreme, but it definitely seems possible
> to overflow it.

Indeed. 32bit has PID_MAX_LIMIT == 0x8000 which obviously fits into 16
bits, while 64bit lifts that limit and relies on memory exhaustion to
limit the number of concurrent threads on the machine, but that
obviously can exceed 16bits.

Whether more than 2^16 sit in iowait concurrently on a single CPU that's
a different question and probably more academic. :)

Though as this will touch all nr_iowait places anyway changing it to
atomic_long_t in a preparatory patch first makes a lot of sense.

Thanks,

        tglx





