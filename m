Return-Path: <linux-kernel+bounces-97301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13287687C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEEE1F21D85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AD54672;
	Fri,  8 Mar 2024 16:28:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63562C198;
	Fri,  8 Mar 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915314; cv=none; b=dGNoNm+Fb2RVz2shwpsXDhrYqb1eBDOalIi9U7cOQkQxGpDmOc6rETVC5NeBBfcOQNVw2lDAPKq2czVxxq7S4poDqoykpZ6FqtJCDv5jlG/a2hiO/Q5G4ldnoyJaf7FUPkzYRoNGPKrUBAj/Ich5HQUDaz0feyVHEHM+jiiWsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915314; c=relaxed/simple;
	bh=9j/NHJuOnCijcSwAMnGxtR70JgvZ3zyScIi+TGHHdhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ0BKZg9HeENGwvy/UPk8m6UlPIZHSqbwbUOX/3nt9fQww3uRmh7pS3t2Jk6Zc2nufm95HSVDytp1URYNcz+6j4QRXt7FB0Rzp82qxEcIuIwlZGJ4RwXfOtJO2OscYfBXkaponLlDSddEafECXOFsTBb9Q8vXUqaLswhmEK+tRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86262C15;
	Fri,  8 Mar 2024 08:29:08 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D0F3F73F;
	Fri,  8 Mar 2024 08:28:25 -0800 (PST)
Message-ID: <5b2d7341-553d-42f0-977b-404f2da411e9@arm.com>
Date: Fri, 8 Mar 2024 16:28:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 0/3] arch: mm, vdso: consolidate PAGE_SIZE definition
To: Arnd Bergmann <arnd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>,
 x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20240306141453.3900574-1-arnd@kernel.org>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240306141453.3900574-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/03/2024 14:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Naresh noticed that the newly added usage of the PAGE_SIZE macro in
> include/vdso/datapage.h introduced a build regression. I had an older
> patch that I revived to have this defined through Kconfig rather than
> through including asm/page.h, which is not allowed in vdso code.
> 
> The vdso patch series now has a temporary workaround, but I still want to
> get this into v6.9 so we can place the hack with CONFIG_PAGE_SIZE
> in the vdso.
> 
> I've applied this to the asm-generic tree already, please let me know if
> there are still remaining issues. It's really close to the merge window
> already, so I'd probably give this a few more days before I send a pull
> request, or defer it to v6.10 if anything goes wrong.
> 
> Sorry for the delay, I was still waiting to resolve the m68k question,
> but there were no further replies in the end, so I kept my original
> version.
> 
> Changes from v1:
> 
>  - improve Kconfig help texts
>  - remove an extraneous line in hexagon
> 
>       Arnd
>

Thanks Arnd, looks good to me.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

