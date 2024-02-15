Return-Path: <linux-kernel+bounces-67635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9826856E41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0763A1C21A92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67B13A883;
	Thu, 15 Feb 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0FLFrpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WF2133Sb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB141A81
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027443; cv=none; b=uiea1Di58GoEXRNXeDEStXU9tSQ8hW2dBCizuscmFIDcLOeFjnZKv4g2Fla/RZOgy/pcQUZivzDz3AxSkieCHgqozpzTbZsMv2/4w1qFObgKpJoRIUzYGmUgVn48smzk5XRrCOyCn0loadhNVu0eBsftc/T2lN2mDhZdYx4zjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027443; c=relaxed/simple;
	bh=019l0rTUicLsyOLLYAl0uCZ+zXM6fXOVg4/goWPmOZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dx7o97H4W5Mla6RQbwwEY3MnBMyqJAH5A6juZ2kdHS9OIqNd4hUX5vhEXoXOhmlBHzG3j5bFa6ocpsebutOc83c7yShJB9CquO0Q2mgHw9RPda1B2pcqbQyNh2tTuj5aVuUoJaAAsQyXJQr/2oZZr2RNxt6oemsV5x/P2gUh8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0FLFrpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WF2133Sb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708027440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=019l0rTUicLsyOLLYAl0uCZ+zXM6fXOVg4/goWPmOZY=;
	b=J0FLFrpTUnhuDsfRGKxdoXRjoHbbmfV7DIRu2Lh6pQ7+rsX6xqUKUuFv4BpeLsjorI0F/6
	RgyKhoLsMe9fwG79NG0ow7FyBvXc8S50tvvzfybFRGPADZLu/uDyl2xl8iRuOD4mzcfWEV
	w8j4ioC4vUjM8Hy+OqweXFBtWSbjA1phG6+/JykyQvd+r9SnnQbiiigOscFM4MkKhlRwi7
	yOF04yty4LTpmE+b6u2mx1XJ6sPz/gtYXUJvPIvLbQkEiVTFjr4EE5DwwKWjxDJkX2380D
	5dMTZ9xSPBex8u48lZbN3BsVGUeiUaXvpj2deBQhz2roq/l9IDMbDC2KbwoiRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708027440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=019l0rTUicLsyOLLYAl0uCZ+zXM6fXOVg4/goWPmOZY=;
	b=WF2133Sb/SlkQBH6/efVP7g53EOSCWM6Obq9KTBIZD8x7xQqoHccOF8SAu0fbJmvyy/N7x
	Ot8DAj893Za2B5Cg==
To: paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
 mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
 bristot@kernel.org, mathieu.desnoyers@efficios.com,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
 bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-Reply-To: <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
Date: Thu, 15 Feb 2024 21:04:00 +0100
Message-ID: <87sf1tcx5b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 15 2024 at 11:28, Paul E. McKenney wrote:
> On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
> I am also getting these from builds that enable KASAN:
>
> vmlinux.o: warning: objtool: mwait_idle+0x13: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x36: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_safe_halt+0x0: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poll_idle+0x33: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: default_enter_idle+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
>
> Does tif_resched() need to be marked noinstr or some such?

__always_inline() probably

