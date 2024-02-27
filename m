Return-Path: <linux-kernel+bounces-83343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159C8693CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C121B1C21DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB7145FE3;
	Tue, 27 Feb 2024 13:46:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287E13DB92;
	Tue, 27 Feb 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041611; cv=none; b=Uiow/9/52fL7OVx5zvM+wzCHV5vilm24F/2snq9fLDxkj71TX9O8KmXoYrzdLBYa5z2LL+lpH36B8OFt/tCCnf7DZaENy8+GQ3OKHv4AYu7spuPTlPZ4/aq3B5cc25zAad5qrxIuegssEjrNivdyDSxebl0N/PGtjzGUFih8kD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041611; c=relaxed/simple;
	bh=Kvh5mtk92pn+GmzhsBj3v6EsxD9iSlLWlQs86SKVnTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9ILh6W56NEBa7dvDQ+OitMrG0rfE9qRy7rVt2hlpt3W61iN1mE63RhxfsdZHvPJz3M0Tq93SkDe8YvHFL1Gy9zO42LJCqt4TAmBhYX5g3KUHP1SwQPSKaz1rfOjv/Mc0iQd8xqkybyA2E7bWWZSFVjQGMUTuh+zGVXXtv/ZKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB54C43390;
	Tue, 27 Feb 2024 13:46:42 +0000 (UTC)
Date: Tue, 27 Feb 2024 13:46:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH 4/4] vdso: avoid including asm/page.h
Message-ID: <Zd3nwGX2oevtj_hQ@arm.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226161414.2316610-5-arnd@kernel.org>

On Mon, Feb 26, 2024 at 05:14:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The recent change to the vdso_data_store broke building compat VDSO
> on at least arm64 because it includes headers outside of the include/vdso/
> namespace:
> 
> In file included from arch/arm64/include/asm/lse.h:5,
>                  from arch/arm64/include/asm/cmpxchg.h:14,
>                  from arch/arm64/include/asm/atomic.h:16,
>                  from include/linux/atomic.h:7,
>                  from include/asm-generic/bitops/atomic.h:5,
>                  from arch/arm64/include/asm/bitops.h:25,
>                  from include/linux/bitops.h:68,
>                  from arch/arm64/include/asm/memory.h:209,
>                  from arch/arm64/include/asm/page.h:46,
>                  from include/vdso/datapage.h:22,
>                  from lib/vdso/gettimeofday.c:5,
>                  from <command-line>:
> arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
>   298 |         u128 full;
> 
> Use an open-coded page size calculation based on the new CONFIG_PAGE_SHIFT
> Kconfig symbol instead.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
> Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

