Return-Path: <linux-kernel+bounces-83270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FA869118
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FA61F22C32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CF13AA43;
	Tue, 27 Feb 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lbeHOiis"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130013A275;
	Tue, 27 Feb 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038659; cv=none; b=r9qh2898CcWrJ2rIITG1WqNibQpD+5aMDpUoDGS5va3XwmiBatZOhYJTuLX9Zj8qD1+KXzyuzKB6R60xwZ4fupsBduZ4evriNDvaGH+4xjvtOrxPKEyMlocuBH2KILFJZcDCXNLkklAgwkKEOLUc1ZKLaRUQlY3FGuPzVCfYFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038659; c=relaxed/simple;
	bh=swDhxalnop+40QyzTwmELhQq8fYEaBd8gs0d47AC/h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGpAUg0WaDN0rDgcV6agXVcfZxPv+8s8udkH3ie3+zOlOJJdpKEzWPiYtnd/etF5gwMEdvgk/x0YNgHD5qCss7ErpOwPw8/YNoJ+xMG0kbrIUP7xVZ7XVvUbRJTbFLye5wsyEc8bqxs/PvaVcTNnKB+IruFcvpAkfgege4pjcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lbeHOiis; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709038654;
	bh=swDhxalnop+40QyzTwmELhQq8fYEaBd8gs0d47AC/h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lbeHOiisvAviMzJQIz1moD9CMIwDWnyEkMBx5y4p+r5c4IjQoB18qgrlVCvB1x8lp
	 iw5qgUFtP6yhK80WEdbT7VjiMz5ok3ncpSQJrzolcOlwZxH0A6OqtUbvamzsIkn3yn
	 RBV09p6PQKg3ejTTuOeVaiqbz3dvd4in83oOIMRRq6JTZgTEUiakFeAj3srmtE6C78
	 mi6JAHZh6pFZdAUi8XVUbjcFAS71GtwQc2qeDeH5P4Xuct27XPV7LT/rxZnWTHu126
	 fiuYYKa4gKtFpVdOYRIR7pO1OxjT3IRFVQPGGzi+xxv3ckTfZSwTY4PM6V5s6Vt2Jl
	 0WyDEwagYDlRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkcvp132Mz4wbQ;
	Tue, 27 Feb 2024 23:57:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>,
 "x86@kernel.org" <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andy
 Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Kieran
 Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org"
 <linux-hexagon@vger.kernel.org>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, "linux-m68k@lists.linux-m68k.org"
 <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org"
 <linux-mips@vger.kernel.org>, "linux-openrisc@vger.kernel.org"
 <linux-openrisc@vger.kernel.org>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org"
 <linux-sh@vger.kernel.org>, "sparclinux@vger.kernel.org"
 <sparclinux@vger.kernel.org>, "linux-um@lists.infradead.org"
 <linux-um@lists.infradead.org>, Linux Kernel Functional Testing
 <lkft@linaro.org>
Subject: Re: [PATCH 4/4] vdso: avoid including asm/page.h
In-Reply-To: <80bc4de5-a351-4ac0-93c8-80c8d80fb202@csgroup.eu>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-5-arnd@kernel.org>
 <80bc4de5-a351-4ac0-93c8-80c8d80fb202@csgroup.eu>
Date: Tue, 27 Feb 2024 23:57:25 +1100
Message-ID: <87h6hu5akq.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 26/02/2024 =C3=A0 17:14, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The recent change to the vdso_data_store broke building compat VDSO
>> on at least arm64 because it includes headers outside of the include/vds=
o/
>> namespace:
>
> I understand that powerpc64 also has an issue, see=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20231221120410.22=
26678-1-mpe@ellerman.id.au/

Yeah, and that patch would silently conflict with this series, which is
not ideal.

I could delay merging my patch above until after this series goes in,
mine only fixes a fairly obscure build warning.

cheers

