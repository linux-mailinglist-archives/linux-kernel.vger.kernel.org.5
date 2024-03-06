Return-Path: <linux-kernel+bounces-94321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F58873D34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99941C227B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959313BACF;
	Wed,  6 Mar 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqrivvwV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V6wMfLDO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935813A26E;
	Wed,  6 Mar 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745428; cv=none; b=kDaRA/3O+5NcrhM3++Ex+7YJk9JTy2Cnmm0AvpMR5d6FLayPV0Pdd11ndlxEjlLq98o5gxuHatC3iXKsEqDvOiig6/hneMoqRaWtt7If2aJksge4pfBO8KU6QBwfqb2+jn4i97Fl2mEQgIk6OCygC37TUMXxguPVAwgHc9tlAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745428; c=relaxed/simple;
	bh=vbQn+OoB0S0JSESblEPZvsiWW6fd58wDKWFuC+9wmuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNk0WzGcYmp055GaNDRhS2UlsoW3oagwFWiAJy8WeTilzyGDASYZELycfF+FBuHF+qmhCzvcZEMZ3xmeH+SYXJ9HnrjlWa/u+EKixcdHya+HP03CLVLsq+TjKzTtxgQNsw6Uyy0BQcpZ6nkM4CBv/N6fJ+919SKF+iK7GBW//J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqrivvwV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V6wMfLDO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709745424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQn+OoB0S0JSESblEPZvsiWW6fd58wDKWFuC+9wmuM=;
	b=hqrivvwV8/uKaYSb4vgXogwmxXcmvHD/vpzX4SBT0qMvFOUGrraEFjzmhKWJFdAjgFwGGu
	i0YzuY8UAmRYf0nsjTLgEHobhCl5xrMUkpEssGQL2qsxjWjlfnV1WwwZsck0s/iT0LXTQv
	0Rl1eNFX6Z2fuzs4m8UZFZe3NmzD9v+oOARm8YY+Fk5f6y7mGuzj3DqaTd7Ikfe/xxEDxk
	o/Gn2QgDdLN/gW/30q5PkH4obkwRFVxPLxZYjQeciiXq9oUFO60wX+E19iH4m+YvzQnm17
	bk4e9hBXQ4eLzXkZtwKVSF+vzA64I5Uh6wxpGU8BVYlxcOrJXuu6QcrFCrnF8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709745424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vbQn+OoB0S0JSESblEPZvsiWW6fd58wDKWFuC+9wmuM=;
	b=V6wMfLDOUa0xxXybHidon5vJJmDL46LPJZaLPA1eJ+JCds6w+m0GI846wFu3s4IZ8nf3hV
	tO38zJpHmpndsvDg==
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
 linux-um@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, Stafford
 Horne <shorne@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] arch: define CONFIG_PAGE_SIZE_*KB on all
 architectures
In-Reply-To: <20240306141453.3900574-4-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-4-arnd@kernel.org>
Date: Wed, 06 Mar 2024 18:17:04 +0100
Message-ID: <87zfvbth4f.ffs@tglx>
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
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

