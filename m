Return-Path: <linux-kernel+bounces-132365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261389939F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13825B21B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74118E28;
	Fri,  5 Apr 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Q3QIzxzR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9B17545;
	Fri,  5 Apr 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286616; cv=none; b=JzEagG13axjOlLtktNrkgO75ZgwKyc4JZZqCZLHscinI/HASs1m5+2wbsucm0dlAkqKtcYyYfFQRI5z+QAjjqc6U29Jlse9TvObxUt7k1h9wE7pHu4//IWFZJCzPt52PKzHN5hhpH/Bp2jsMnMTElnkYHQEVZGD/VYRReU/YOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286616; c=relaxed/simple;
	bh=5YM7mvGWbMlZmbIx5ybNEkNpgBfZXycaMReGwErZsdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kilnnEC0G8/9TUei6fzWHql2SQ7kR/drYoYcpEgSBbLH5i3v6aDNIcI4ZPybicYqok7H06R8Xc45LxdOowQ70VcxZA3SPbqGMegnXrGWdwDisKOUkGBWPktPPdeM6MHRNMtzqwSuajOOfuA8YGxY6Wr89y0uaf/O3gfKfKYSVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Q3QIzxzR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712286613;
	bh=5YM7mvGWbMlZmbIx5ybNEkNpgBfZXycaMReGwErZsdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q3QIzxzRbXpx2e47F9wae2WgRCUdoJb3BHqgFNQVHo4XOAcj6V4A6KAwpGReH2mLc
	 f4tWtIJ+360ZAKdin4JhCHTv8ghAVgTzDcPVTwAJNRCc/XIai15DUZ9CcoTd+cXGl3
	 CD64SNl4kNizJb6K2tWtg4KZzFiVTo67Mm7LyQ/ef6Ff7cb7pSMjsnUThoWI+4srek
	 3NrOXgKPwAv5ld8VkOq9Zsx07cH9xbaJYm5WvPsNggkC+eeNBC6WhkTXLl9IbgkFrt
	 kUeb7ERnoYAz1FDsjnvakUEh/M29R0AZI9Ci6zUJqmudcmTafdmRUuAxe33KrBmI4x
	 w8K64JUPj8pfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9k4j0HHRz4wyh;
	Fri,  5 Apr 2024 14:10:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial/pmac_zilog: Remove flawed mitigation for rx
 irq flood
In-Reply-To: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org>
References: <0df45bedded1249f6c6ec2c2fb0d9879da1841b7.1712273040.git.fthain@linux-m68k.org>
Date: Fri, 05 Apr 2024 14:10:12 +1100
Message-ID: <87v84w7be3.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Finn Thain <fthain@linux-m68k.org> writes:
> The mitigation was intended to stop the irq completely. That may be
> better than a hard lock-up but it turns out that you get a crash anyway
> if you're using pmac_zilog as a serial console:
>
> ttyPZ0: pmz: rx irq flood !
> BUG: spinlock recursion on CPU#0, swapper/0
>
> That's because the pr_err() call in pmz_receive_chars() results in
> pmz_console_write() attempting to lock a spinlock already locked in
> pmz_interrupt(). With CONFIG_DEBUG_SPINLOCK=y, this produces a fatal
> BUG splat. The spinlock in question is the one in struct uart_port.
>
> Even when it's not fatal, the serial port rx function ceases to work.
> Also, the iteration limit doesn't play nicely with QEMU, as can be
> seen in the bug report linked below.
>
> A web search for other reports of the error message "pmz: rx irq flood"
> didn't produce anything. So I don't think this code is needed any more.
> Remove it.

Yeah I think you're probably right.

I assume you have tested this on an actual pmac, as well as qemu?

cheers

