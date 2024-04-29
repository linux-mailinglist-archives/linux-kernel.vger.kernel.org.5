Return-Path: <linux-kernel+bounces-161905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5C8B5319
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E1281468
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298C17589;
	Mon, 29 Apr 2024 08:26:24 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE0171B0;
	Mon, 29 Apr 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379184; cv=none; b=MNTpLy4TqVbd97nIzh19MY8Z8sUCHShJ38GSCpdVH8D+3p3usPv8DhwpRXGboGkpZMAHJFYloRImWPjhCyeZMq0lWYBn3GOyOEJqTuih6RKKz1pdZOzO23GpoC6YxxBEClaAkzv/h7op46Uo1dXD3+cpS+2hEyAjkvqEI6Z2k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379184; c=relaxed/simple;
	bh=fG/3DgD9qg8PAoCTBqPrTfIB8CcOOZ4f1uEoJ+ssisM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGQLkqTP6PunrqnwlZ0D/lwxddKWLu3EdwXfo7pBdOsS3o4FqGWGuBkF7CCORtO9HVILbleqfEOx3l6GQ+wed0CZjI/Eo+TuvGOGB0myDlJgrc5uycJ0Efow/H8UYOPahcvsjn1vIhG2TTg0MipsWoTIhSlmQR3mH9ItSl3LsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1s1MGC-0000Bf-00; Mon, 29 Apr 2024 10:21:16 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 33BE6C0135; Mon, 29 Apr 2024 10:18:57 +0200 (CEST)
Date: Mon, 29 Apr 2024 10:18:57 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Siarhei Volkau <lis8215@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: Take in account load hazards for HI/LO restoring
Message-ID: <Zi9X8cqTpWUR1Z6l@alpha.franken.de>
References: <20231012162027.3411684-1-lis8215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012162027.3411684-1-lis8215@gmail.com>

On Thu, Oct 12, 2023 at 07:20:27PM +0300, Siarhei Volkau wrote:
> MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
> and right after move to HI/LO will usually stall the pipeline for
> significant amount of time. Let's take it into account and separate
> loads and mthi/lo in instruction sequence.
> 
> The patch uses t6 and t7 registers as temporaries in addition to t8.
> 
> The patch tries to deal with SmartMIPS, but I know little about and
> haven't tested it.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  arch/mips/include/asm/stackframe.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index a8705aef47e1..3821d91b00fd 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -308,17 +308,11 @@
>  		jal	octeon_mult_restore
>  #endif
>  #ifdef CONFIG_CPU_HAS_SMARTMIPS
> -		LONG_L	$24, PT_ACX(sp)
> -		mtlhx	$24
> -		LONG_L	$24, PT_HI(sp)
> -		mtlhx	$24
> -		LONG_L	$24, PT_LO(sp)
> -		mtlhx	$24
> -#elif !defined(CONFIG_CPU_MIPSR6)
> +		LONG_L	$14, PT_ACX(sp)
> +#endif
> +#if defined(CONFIG_CPU_HAS_SMARTMIPS) || !defined(CONFIG_CPU_MIPSR6)

isn't that just #ifndef CONFIG_CPU_MIPSR6 ? 

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

