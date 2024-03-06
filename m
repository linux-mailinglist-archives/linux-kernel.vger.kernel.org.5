Return-Path: <linux-kernel+bounces-94318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFED873D13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B951F21172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86E13BACA;
	Wed,  6 Mar 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLcCHGoD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r2OKQF+b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E704132C0C;
	Wed,  6 Mar 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745292; cv=none; b=UyimjW+kFB/k48w6HZLRkrZqliWXY4P6ZGn5UliZbwn1CkGqHRYKedi3cakAaYVhcJsh6zcq7+p0W0mSkBK5Mc8EHsud4RJeif+ChMXnKOIPPcAEDYzJ1IFrJ8mGB7QdqvCpt6/1/4SjNmcf6bF7lozIJ0JXP793vmWwnPfP9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745292; c=relaxed/simple;
	bh=Vp8CgcEh2+XD1rrYCq9vFCOWhJV6Gj0UcBPHVO/mG3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqlOdOfS0WvFUpfk6O+hYTbqOXylNZ9WO1bX7dy/p6b4c5HMLQGh2g0KAvRLZnAu2mInePlqi00jjWp59eM4EVFpl+tfsSGrAOV4iGoOsMtNHlMRpS7WPHhFIXrsyEHP7OQTWbqWp424a5sTVvY52LjOmwpi0KcWmuizsftAacg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLcCHGoD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r2OKQF+b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709745282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp8CgcEh2+XD1rrYCq9vFCOWhJV6Gj0UcBPHVO/mG3I=;
	b=hLcCHGoDD+mz8ZbKjQeB5xXhhoPU/fE2kNC3hQNfd1ma/u8J/zddviA/HqdTgqdG3oVELs
	yVs1/hPOwmAOTuivi7bn/t5AdXxzOgCbrjnNic9a7P3UD6t9DbBcDDZEQv9mdkZ5gNQmWv
	7vbCgHbSJECaiSNWreeRIZmRe08ButQng2h/CGVRcpYXfkeDvP8s8MUjoaw0ejkV2aOd6J
	GhCC5IBZxfnMkFg4BEdSUxSJkuNwB3HEKPGk8Ts8FrpJGs4nl/zkw473YhePn+NXGru8W6
	nrJgDF25SYoVsf+V+wjNsd9UV9qsXdOpH54xyHauuhHRCs6LH5fgqRzBOaZs6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709745282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp8CgcEh2+XD1rrYCq9vFCOWhJV6Gj0UcBPHVO/mG3I=;
	b=r2OKQF+b39Jbfxu8K1wz0pKjaanVs2rF1CqBPX6sZtQq8gqd45t5LNMwP4WV+c9wRqAr36
	puBSYY3XgU94OPAA==
To: Arnd Bergmann <arnd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Andy Lutomirski
 <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH v2 1/3] arch: consolidate existing CONFIG_PAGE_SIZE_*KB
 definitions
In-Reply-To: <20240306141453.3900574-2-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-2-arnd@kernel.org>
Date: Wed, 06 Mar 2024 18:14:42 +0100
Message-ID: <875xxzuvst.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 06 2024 at 15:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

