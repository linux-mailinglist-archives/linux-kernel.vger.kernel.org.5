Return-Path: <linux-kernel+bounces-89893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDC86F6F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E129B20E1F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F179DBE;
	Sun,  3 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwR+HOEV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29Tr+bYO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22479DB1;
	Sun,  3 Mar 2024 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496654; cv=none; b=uowhrU8p8oCT4bJk9MVUkhgklrF4tnu2O+38oMGGQqCfyjBMT+PK1H6o7bnR4gg3g3bmqCCPT97zhch6cuqGC/UkYEbBA4VaAQxunYFeL/IjgjFHX/EoHv4ab6JJSWULtaeoImKezxx2rNf8l26pJWtNUzU2GdMOOsNwGcJLAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496654; c=relaxed/simple;
	bh=FzTndEO7lXg43Boxwns0aVbF9ykNu4K7zUCMZVjG2RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zi+eWCTfy7QhThqlKszajy7LMkGFxTjNJ1sMCulqoEJ139N6AmUzhu06AiEeUsviJni1weA+3FQ2Kk1GlJUD0NU1GaR8u+f5qlMQK2D7yEhF8L28C0BHBb576CuuDE/R2W9fvlYWwBEgIXFmSJHj+v3KtHsrPjrzhI+Gq2PAX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rwR+HOEV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29Tr+bYO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709496651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn94CLT9/W7Sw9FixsWA934JJ4me1mWypVyVM1LhbOw=;
	b=rwR+HOEVdk+qVaSLRQNrcjS4FplTQzEV0FKbZfyg4RKBHJGHIrsmbd2gbXL7GZyMHYfCYi
	bWqW25TRNP1GS+Me4hZZ7xLMyTN468zwQItcTvpssQO4VaXXgRrrmsWhs9EH6CHnW+y5i8
	N4fyu2mmA+N7m4DDW0FXEkQl9jN12S6GSkiHBOXv/vqqsgPK6vyPlomCBcEKn8s1HsKQPl
	xAZqu2lj83CCR4U+04nz+1a0iJUOemOEKUpn+BfHTXg9T5JHZB84H2tri8WlK+a7gGtQ7S
	1olicMrU6OgyKIkJDFyszppfhOxdIW9TeuWNaHMNhsQxY5heF73XBxaSsKS5cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709496651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn94CLT9/W7Sw9FixsWA934JJ4me1mWypVyVM1LhbOw=;
	b=29Tr+bYOnRnxAupJFd0RrIO//c9mIZzwiMuhnV4t6piYd+AEQYrTSGpYQcIDaq1EygevVQ
	UwxjaR8fO5zuuVCA==
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot
 <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 x86@kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse
 Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx>
 <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx>
 <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
Date: Sun, 03 Mar 2024 21:10:50 +0100
Message-ID: <87bk7vuldh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03 2024 at 20:03, Uros Bizjak wrote:
> On Sun, Mar 3, 2024 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> I did not follow the __set_gs work closely, so I don't know whether Uros
>> ever tried to actually mark the per CPU variable __set_gs right away,
>> which would obviously catch the above 'foo' nonsense.
>
> No, because [1]:
>
> "gcc does not provide a way to remove segment qualifiers, which is needed
> to use typeof() to create local instances of the per-cpu variable. For
> this reason, do not use the segment qualifier for per-cpu variables, and
> do casting using the segment qualifier instead."

Right. I just figured that out myself when playing with it in user
space.

That's so sad because it would provide us compiler based __percpu
validation.

Right now this simply does not work and __verify_pcp_ptr(ptr) is not
doing anything except when sparse looks at it.

Sigh.

        tglx


