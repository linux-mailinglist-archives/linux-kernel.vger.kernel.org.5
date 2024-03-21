Return-Path: <linux-kernel+bounces-110044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDF88594A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF061C21768
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250BD83CBA;
	Thu, 21 Mar 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lBaQYgeM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C379B8E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024976; cv=none; b=UdROgWF754vnqszcg7zCPkzFsYsbFY2ZmXTQgjto2kahIUUBAreNxLPtbidXxb1zvESt3ECjPUrTds8+cWZn6pcys28wwp1PvfH1th9bQP/sxWdIe4o1GFrfZCEnQ9jJ9lClkMGeHj7UMpwDzQWwdOuNr/u/ZUPxNZSBtBL+Xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024976; c=relaxed/simple;
	bh=NNxhDZjT+rNDq/hX0SWVPFMlR2IKBPmi54Pihb/EZ38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpK7JvBsp1N7sEhoek/of3jVLUHo1WPp4KcscvOny+PBKhvoIcQ3KsARgNXcWJT+XA/XcIjmU5qED244aYYTvxk7M05q/0o5FGDluOifDXJDwIp8ARwhz8A2j+Mt2iqgHylIIY+NfTmJ8RGQpPctoQpis/9OrIrJP5Bo/Rg2oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lBaQYgeM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711024971;
	bh=/zO2JRQSx2yIFlQ7GeaMJ96UTln9Ndn56Jfacwy/vnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lBaQYgeMMrcVUleS2KE4HTsdvyldimLhhCWWn2WAZs2wy3Zka8ZPQsaUnnvlvC0Ss
	 UTz3xCPF4Dvkp9/fccVpDduN8LM89uK2STyGhnCIihvBEIULmhqN6IieMTtku6V57i
	 pP+2qv97wswBvqiLdss5oo1M5hLlLxbWkuVzaSZZx19UFSAlNmCTDf/2KichNubu7E
	 VHfnBxtamfBzC9Vxa3lGs3dn5aQgIfi7uw9sfsgG9Dx358AgzKri6sVGfritGheAr5
	 PhffbH8Mqa85tDjjE2M+yvephpZ2lkBysWRs7RTaTOsZensk+oQ5hzqyQg+fMsb7ri
	 i4uc2XtRftH5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V0lVK2PzKz4wc1;
	Thu, 21 Mar 2024 23:42:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: use CONFIG_PAGE_SHIFT in vdso/datapage.h
In-Reply-To: <20240320180228.136371-1-arnd@kernel.org>
References: <20240320180228.136371-1-arnd@kernel.org>
Date: Thu, 21 Mar 2024 23:42:46 +1100
Message-ID: <87h6gzzrg9.fsf@mail.lhotse>
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
> Both the vdso rework and the CONFIG_PAGE_SHIFT changes were merged during
> the v6.9 merge window, so it is now possible to use CONFIG_PAGE_SHIFT
> instead of including asm/page.h in the vdso.
>
> This avoids the workaround for arm64 and addresses a build warning
> for powerpc64:
>
> In file included from <built-in>:4:
> In file included from /home/arnd/arm-soc/arm-soc/lib/vdso/gettimeofday.c:5:
> In file included from ../include/vdso/datapage.h:25:
> arch/powerpc/include/asm/page.h:230:9: error: result of comparison of constant 13835058055282163712 with expression of type 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>   230 |         return __pa(kaddr) >> PAGE_SHIFT;
>       |                ^~~~~~~~~~~
> arch/powerpc/include/asm/page.h:217:37: note: expanded from macro '__pa'
>   217 |         VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> arch/powerpc/include/asm/page.h:202:73: note: expanded from macro 'VIRTUAL_WARN_ON'
>   202 | #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> arch/powerpc/include/asm/bug.h:88:25: note: expanded from macro 'WARN_ON'
>    88 |         int __ret_warn_on = !!(x);                              \
>       |                                ^
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> See-also: 8b3843ae3634 ("vdso/datapage: Quick fix - use asm/page-def.h for ARM64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/include/asm/vdso/gettimeofday.h | 3 +--
>  include/vdso/datapage.h                      | 8 +-------
>  2 files changed, 2 insertions(+), 9 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
> index f0a4cf01e85c..78302f6c2580 100644
> --- a/arch/powerpc/include/asm/vdso/gettimeofday.h
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -4,7 +4,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <asm/page.h>
>  #include <asm/vdso/timebase.h>
>  #include <asm/barrier.h>
>  #include <asm/unistd.h>
> @@ -95,7 +94,7 @@ const struct vdso_data *__arch_get_vdso_data(void);
>  static __always_inline
>  const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
>  {
> -	return (void *)vd + PAGE_SIZE;
> +	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
>  }
>  #endif
>  
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 5d5c0b8efff2..c71ddb6d4691 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -19,12 +19,6 @@
>  #include <vdso/time32.h>
>  #include <vdso/time64.h>
>  
> -#ifdef CONFIG_ARM64
> -#include <asm/page-def.h>
> -#else
> -#include <asm/page.h>
> -#endif
> -
>  #ifdef CONFIG_ARCH_HAS_VDSO_DATA
>  #include <asm/vdso/data.h>
>  #else
> @@ -132,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
>   */
>  union vdso_data_store {
>  	struct vdso_data	data[CS_BASES];
> -	u8			page[PAGE_SIZE];
> +	u8			page[1U << CONFIG_PAGE_SHIFT];
>  };
>  
>  /*
> -- 
> 2.39.2

