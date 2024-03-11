Return-Path: <linux-kernel+bounces-98890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7E8780B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6D4281CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFD840870;
	Mon, 11 Mar 2024 13:34:05 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24314085E;
	Mon, 11 Mar 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164044; cv=none; b=DCGsLmqlXRZuxpSA+O/cV+e/ll6Syl2DrE0WyBwL3tWZENe5UW2g934NYZ8cvDkuLUnraqQMnRt/h3ePuLai7pmO2wlAJYiV2hIOAqCeI0+7RTgxYXfsTKZHIRh7rZA8iahhUTr33dBrN6EfgbKrH/VNwqVXUpt3qn76iON5LVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164044; c=relaxed/simple;
	bh=fpFQr843KOifIG2LaYlm2F7Z5q9uRlkCVtNhgQnuXjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKcJEe9AYGlM2//6btrc+YVpw6GsR3iKMScPgmoFIr6XEAcn2NqL/43pxWHxkesFXmsJoMdsDBMC/5gjJRaUWlAYfVeXduVkJSCV/R1reWf6AX9Oz/7BE53qAf7ANnxR66BFPIiSGfFru5Z3jISlz8ylXmBe7SpAk7f/VTC7e1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rjfO2-0001bi-00; Mon, 11 Mar 2024 14:08:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E1C83C069B; Mon, 11 Mar 2024 14:05:37 +0100 (CET)
Date: Mon, 11 Mar 2024 14:05:37 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MIPS: Fix missing proto and passing arg warnings
Message-ID: <Ze8BoUxUZ3CL0yG4@alpha.franken.de>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226105427.7191-1-fancer.lancer@gmail.com>

On Mon, Feb 26, 2024 at 01:54:20PM +0300, Serge Semin wrote:
> After getting my local tree rebased onto the kernel 6.8-rc3 the MIPS32
> kernel build procedure produced a couple of warnings which I suggest to
> fix in the framework of this series.
> 
> A first warning is of the "no previous prototype for `<func>`" type. In
> particular my arch-specific code has the mips_cm_l2sync_phys_base() method
> re-defined, but even though the function is global it' prototype isn't
> declared anywhere. Fix that by moving the __mips_cm_l2sync_phys_base()
> body to a weak implementation of mips_cm_l2sync_phys_base() and adding the
> method prototype declaration to the mips/include/asm/mips-cm.h header
> file. For the sake of unification a similar solution was provided for the
> mips_cm_phys_base()/__mips_cm_phys_base() couple.
> 
> The following text describes the patches which have already merged in at
> v1 stage of the patchset (see changelog v2).
> 
> One more case of the denoted earlier warning I spotted in the
> self-extracting kernel (so called zboot) with the debug printouts enabled.
> In particular there are several putc() method re-definitions available in:
> arch/mips/boot/compressed/uart-prom.c
> arch/mips/boot/compressed/uart-16550.c
> arch/mips/boot/compressed/uart-alchemy.c
> All of these files lacked the prototype declaration what caused having the
> "no previous prototype for ‘putc’" printed on my build with the next
> configs enabled:
> CONFIG_SYS_SUPPORTS_ZBOOT=y
> CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM=y
> CONFIG_ZBOOT_LOAD_ADDRESS=0x85100000
> CONFIG_DEBUG_ZBOOT=y
> 
> The second warning is of the "passing argument <x> of ‘<func>’ from
> incompatible pointer type" type which I discovered in the
> drivers/tty/mips_ejtag_fdc.c driver. The problem most likely happened due
> to the commit ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character
> pointers").
> 
> That's it for today.) Thanks for review in advance. Any tests are very
> welcome.
> 
> Link: https://lore.kernel.org/linux-mips/20240215171740.14550-1-fancer.lancer@gmail.com
> Changelog v2:
> - Drop aleady applied pateches:
>   [PATCH 3/4] mips: zboot: Fix "no previous prototype" build warning
>   [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
> - Drop Linux serial mailing list and the respective maintainers from the
>   Cc-list.
> - Covert the underscored versions of the CM2/L2-sync base address
>   getters to being the body of the weakly defined original methods.
> 
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (2):
>   mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function
>   mips: cm: Convert __mips_cm_phys_base() to weak function
> 
>  arch/mips/include/asm/mips-cm.h | 20 ++++++++++++++++----
>  arch/mips/kernel/mips-cm.c      | 10 ++--------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> -- 
> 2.43.0

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

