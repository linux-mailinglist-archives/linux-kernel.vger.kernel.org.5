Return-Path: <linux-kernel+bounces-94740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8C87449C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72312282F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D883D549;
	Wed,  6 Mar 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dfxSn7ES"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278023FB16;
	Wed,  6 Mar 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768482; cv=none; b=awTI0mhN82gEeAvB3C3J787toCMnN17gVRfNAI/6d8ty1gvTdw99tqqdM+FJiLvWJfBuq44XKPvr6Ka6E3EG8RZrWTSGzTckap+kZdZxOVf+tIZofMcvKtLUcULVSi78cJpTtV2V4o9nVi6G4p5lolD+HsOkqiL07gSSUrAzdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768482; c=relaxed/simple;
	bh=dZ6jOLMDzgPZpijPacAiasUg5Crtb+AP4LxE80M2xBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iHuEzZsu/Urn8zldaiQ5j7gzq7GJ0CTbGgp67QIz72WiI+U5gLTWlVlL5x/hkMHlzYSsaA/mHWW497z+fQSp0kyu9Jzw63h7t9EVYEfjScasjKTy5baSAkmsV9DIXOLagUXW9H6/eGvrDEXdd3NUu6o6Al788cDBoF29z2idXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dfxSn7ES; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709768472;
	bh=OHx3bVLlXnvaD4Lk/LqRAXihRU8d5iuk+jHowRU57+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dfxSn7ESt9feXa7Ah5VgnrgsTR94t0TrfqG0PcTuTf3mOM2nYClb7KzncEO44oWvJ
	 z177IwNoKxwaRwuRElWO9dM9vGP1BGgcQEfox5PbPq0mqdcUVphkGszRXScQ0d7mcO
	 jW4ikoUKpq/rq3DBl50CSj6CPBHJDbwDqtBF6NxW+foiGgFyBpZYE+I728npTZNMg3
	 1t/2+QbQypMyzr9+0O+l4J8vO9YugJeJGU6R2JxmPiIz07vqQ4qeSoMI/Ta1CVt4Pi
	 EW9aQ8ONAeTLEZ2I6yd+B+il/wLckJElOl67KFtvN0q8NsP2LkndTztEXc4YygJJsv
	 te7iy+1YEdhjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqppm50HGz4wcN;
	Thu,  7 Mar 2024 10:41:04 +1100 (AEDT)
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
Subject: Re: [PATCH v2 1/3] arch: consolidate existing CONFIG_PAGE_SIZE_*KB
 definitions
In-Reply-To: <20240306141453.3900574-2-arnd@kernel.org>
References: <20240306141453.3900574-1-arnd@kernel.org>
 <20240306141453.3900574-2-arnd@kernel.org>
Date: Thu, 07 Mar 2024 10:41:02 +1100
Message-ID: <87sf13nd2p.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Arnd,

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These four architectures define the same Kconfig symbols for configuring
> the page size. Move the logic into a common place where it can be shared
> with all other architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v1:
>  - improve Kconfig help texts
>  - fix Hexagon Kconfig
>
>  arch/Kconfig                      | 92 ++++++++++++++++++++++++++++++-
>  arch/hexagon/Kconfig              | 24 ++------
>  arch/hexagon/include/asm/page.h   |  6 +-
>  arch/loongarch/Kconfig            | 21 ++-----
>  arch/loongarch/include/asm/page.h | 10 +---
>  arch/mips/Kconfig                 | 58 ++-----------------
>  arch/mips/include/asm/page.h      | 16 +-----
>  arch/sh/include/asm/page.h        | 13 +----
>  arch/sh/mm/Kconfig                | 42 ++++----------
>  9 files changed, 121 insertions(+), 161 deletions(-)

There's a few "help" lines missing, which breaks the build:

  arch/Kconfig:1134: syntax error
  arch/Kconfig:1133: invalid statement
  arch/Kconfig:1134: invalid statement
  arch/Kconfig:1135:warning: ignoring unsupported character '.'
  arch/Kconfig:1135:warning: ignoring unsupported character '.'
  arch/Kconfig:1135: invalid statement
  arch/Kconfig:1136: invalid statement
  arch/Kconfig:1137:warning: ignoring unsupported character '.'
  arch/Kconfig:1137: invalid statement
  arch/Kconfig:1143: syntax error
  arch/Kconfig:1142: invalid statement
  arch/Kconfig:1143: invalid statement
  arch/Kconfig:1144:warning: ignoring unsupported character '.'
  arch/Kconfig:1144: invalid statement
  arch/Kconfig:1145: invalid statement
  arch/Kconfig:1146: invalid statement
  arch/Kconfig:1147: invalid statement
  arch/Kconfig:1148:warning: ignoring unsupported character '.'
  arch/Kconfig:1148: invalid statement
  make[4]: *** [../scripts/kconfig/Makefile:85: syncconfig] Error 1

Fixup diff is:

diff --git a/arch/Kconfig b/arch/Kconfig
index 56d45a75f625..f2295fa3b48c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1130,6 +1130,7 @@ config PAGE_SIZE_16KB
 config PAGE_SIZE_32KB
        bool "32KiB pages"
        depends on HAVE_PAGE_SIZE_32KB
+       help
          Using 32KiB page size will result in slightly higher performance
          kernel at the price of higher memory consumption compared to
          16KiB pages.  This option is available only on cnMIPS cores.
@@ -1139,6 +1140,7 @@ config PAGE_SIZE_32KB
 config PAGE_SIZE_64KB
        bool "64KiB pages"
        depends on HAVE_PAGE_SIZE_64KB
+       help
          Using 64KiB page size will result in slightly higher performance
          kernel at the price of much higher memory consumption compared to
          4KiB or 16KiB pages.


cheers

