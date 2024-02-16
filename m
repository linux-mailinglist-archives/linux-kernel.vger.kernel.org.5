Return-Path: <linux-kernel+bounces-69050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B888583D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50411C23262
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA71350C7;
	Fri, 16 Feb 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LvF0Ltoo"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B9130E34;
	Fri, 16 Feb 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103553; cv=none; b=Hy1qt8Bj7w2BWRquCDOlC6JcKGz6e/QuZs7lOfbXobgU4N7lqCmZ9uR/fcWIvr0hIipkWkqnBOLDYe1mEj6q4KZRnurJS9ia+qr/8gtSPGbs/8cp6vevkK11jhajv/Ikfq0c3fNwoHdDOZJ+WsSBOTXgofi5rgZi6+E2XtYd1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103553; c=relaxed/simple;
	bh=oDdva2PT7Y0RL4gg8yCp3llIbKMFmAymSKDhJUcZrGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edgIMhWvJaTEhsTqv8nUUuQ0AU4DU1ycw1wPGEKoYu8yY5e4DEKlR6xjz6VcZfCtIms15nigsfoOguV0pGHj6CU0719/NpYEDqF0IG+zbtqV+tIcTQ3Q0wa8zIfs2pRk5ffNLsmVLCmES9wk96ly/f5JNxaPq02xIp2nOcdujjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LvF0Ltoo; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tbz561RHNz681Q;
	Fri, 16 Feb 2024 18:12:26 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tbz4p2Grxz6809;
	Fri, 16 Feb 2024 18:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708103546;
	bh=u+7m0ysgFtgrkmEJrdGpb8Y0tCuVXhfQeXNdhjpOpRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LvF0LtooPcEev2leFNAATsWRlCRiYxAr394TZe6xxrQk5VXnG8GBTyznzXodihQYD
	 Re3Zm+zbYB5EoQJb/luHksSy6mmQhREXwvAwGPaK8l8eOib+DoTGuyeR2OYIeehkhy
	 WUiK38+WhtZe9JyMy01b9fRPn2umDHWqIdScoqyw=
Message-ID: <d1a616f1-0fd2-4af0-8b89-e0d0a8842a6d@gaisler.com>
Date: Fri, 16 Feb 2024 18:12:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/27] sparc32: Drop run-time patching of ASI instructions
Content-Language: en-US
To: sam@ravnborg.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-17-64bb44b598c5@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-17-64bb44b598c5@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-19 23:03, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> With only LEON supported there is no need to run-time patch
> the instructions to match ASI.
> 
> Move a few functions back to C with inline asm, now that
> run-time patching is not needed.
> 
> Deleted a few functions that turns out not to be used rather
> than re-implement them in C.
..
> diff --git a/arch/sparc/include/asm/sections.h b/arch/sparc/include/asm/sections.h
> index 08f833453ab3..e9d28148850b 100644
> --- a/arch/sparc/include/asm/sections.h
> +++ b/arch/sparc/include/asm/sections.h
> @@ -8,7 +8,4 @@
>  /* sparc entry point */
>  extern char _start[];
>  
> -extern char __leon_1insn_patch[];
> -extern char __leon_1insn_patch_end[];
> -
>  #endif
> diff --git a/arch/sparc/include/asm/winmacro.h b/arch/sparc/include/asm/winmacro.h
> index b6e911f5d93c..c496b04cdfaf 100644
> --- a/arch/sparc/include/asm/winmacro.h
> +++ b/arch/sparc/include/asm/winmacro.h
> @@ -108,18 +108,11 @@
>  661:	rd	%tbr, %idreg;				\
>  	srl	%idreg, 10, %idreg;			\
>  	and	%idreg, 0xc, %idreg;			\

These three lines, including the label, should also be removed as they
are not for LEON. Additionally, I think it would be best to split out
removing the cpuid instruction fixups to one patch and the MMU ASI
instruction fixups to another patch.

> -	.section	.cpuid_patch, "ax";		\
> -	/* Instruction location. */			\
> -	.word		661b;				\
> -	/* SUN4D implementation. */			\
> -	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg;	\
> -	sll	 %idreg, 2, %idreg;			\
> -	nop;						\
> -	/* LEON implementation. */			\
> +							\
>  	rd 	%asr17, %idreg;				\
>  	srl	%idreg, 0x1c, %idreg;			\
>  	sll	%idreg, 0x02, %idreg;			\
> -	.previous;					\
> +							\
>  	sethi    %hi(current_set), %dest_reg; 		\
>  	or       %dest_reg, %lo(current_set), %dest_reg;\
>  	ld       [%idreg + %dest_reg], %dest_reg;
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index 0f2417ee3f95..9cf8f87e8c42 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S

The hard_smp_processor_id function also needs to be reduced to just the
LEON code. With the patching removed, SMP otherwise breaks with CPUs
other than CPU 0 getting stuck.

Thanks,
Andreas

