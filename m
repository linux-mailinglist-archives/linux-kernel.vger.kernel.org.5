Return-Path: <linux-kernel+bounces-95541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9487874F30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A61F22507
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFDE12BE9C;
	Thu,  7 Mar 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="m2hV8+Uz"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678111292CD;
	Thu,  7 Mar 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814854; cv=none; b=q9lnFMreDpziGRypK1KILGcPa70m7PVKWYjypoUs0OGANROERInDPwob40yrAPcLR5cidJ0AzGHwQTLrRyYrVlf93kQ+rs9qy768vv6kr2oq+m6GlT1MWUlkSjz/l2WQi6HfggPXPNrTpB1vW6XICi7oYUT6LtyMU9wvWIsstMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814854; c=relaxed/simple;
	bh=A8FmQi+nWttuZkN0OHf+hc97YU7oIRy5k7+znlJGMlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKP66HIDcPfXHGPsU0JkipDg/5RGLq2YWeUE8am3xOhEQu/7tObarZHXNmX707H7b7ua6+apWri1YZrfnza11jgzDfNdBIEoB2kxMnxfepxG0AuCQln3VHbMHw7bi/xswijfy3ymVljb061baJ6QuCgvrh9zznkVtC4aMtBnKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=m2hV8+Uz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709814848;
	bh=5GCSx/SWwEQN6H1v+rlc6aQIECBTZdtYZCIuJdaUGZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m2hV8+UzshtbVo1SMQpGCIZAVMu9h2hQvtpDC9CkF6Ead01MUqjonBYL92rbYu9o5
	 eONdwUL5JV+qzsPtqxYxcbEZTnxik/VNQnkbfcaMbISw7CbDppUAmAH/9P3sku/f8b
	 i2LMQgXCW1DJms0NeuRTzJ0tBX4bUIMqKowAPBctWZSTjYyNqR0YILGQIfrcB30lQJ
	 AxLogULtOaYvLPcYayeLz0xu9HzQh3oaG4608ibo49kkmjQLQ5CoPOkqEhC/05rYgX
	 JxgCpZfY9Df2KdR0oUWson/F66hS7hXm3iPnnhME1f/unkDf0IfUz0QTmy9qELYv1z
	 htVjJ1WY+KwZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tr7yd1VsMz4wc8;
	Thu,  7 Mar 2024 23:34:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Palmer
 Dabbelt <palmer@dabbelt.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov
 <jcmvbkbc@gmail.com>, Andy Lutomirski <luto@kernel.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arch: simplify architecture specific page size
 configuration
In-Reply-To: <20240306141453.3900574-3-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-3-arnd@kernel.org>
Date: Thu, 07 Mar 2024 23:34:00 +1100
Message-ID: <878r2unruv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> arc, arm64, parisc and powerpc all have their own Kconfig symbols
> in place of the common CONFIG_PAGE_SIZE_4KB symbols. Change these
> so the common symbols are the ones that are actually used, while
> leaving the arhcitecture specific ones as the user visible
> place for configuring it, to avoid breaking user configs.
>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu> (powerpc32)
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No changes from v1
>
>  arch/arc/Kconfig                  |  3 +++
>  arch/arc/include/uapi/asm/page.h  |  6 ++----
>  arch/arm64/Kconfig                | 29 +++++++++++++----------------
>  arch/arm64/include/asm/page-def.h |  2 +-
>  arch/parisc/Kconfig               |  3 +++
>  arch/parisc/include/asm/page.h    | 10 +---------
>  arch/powerpc/Kconfig              | 31 ++++++-------------------------
>  arch/powerpc/include/asm/page.h   |  2 +-
>  scripts/gdb/linux/constants.py.in |  2 +-
>  scripts/gdb/linux/mm.py           |  2 +-
>  10 files changed, 32 insertions(+), 58 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

