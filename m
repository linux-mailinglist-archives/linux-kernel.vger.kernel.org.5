Return-Path: <linux-kernel+bounces-62460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECF585211A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0CB1F21D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81F4D5B4;
	Mon, 12 Feb 2024 22:12:11 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433A4D59C;
	Mon, 12 Feb 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775931; cv=none; b=CVeFCrg5ciYFc0ds2+LtLvwDMOFTUPNmIhFkMcRAk8eeVXx27W1gQwx80rQQbR7GVI334r5X4G6bXsRmdeeF5togJciDLyoHy+SKxetIlnOPs226vwNuBQuj38m3jRX58ne1zEg6PValUtGbmLhUgdxkeWuJqKAhy0cY7svYkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775931; c=relaxed/simple;
	bh=RhuxBaFv9+X6IjUPB1x+8s2diCNbvkSPrmzjHzBrDh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evBLGbEzzcU7nZm+SvgdwEj0oAvYPA4et/pGXHoIxyKFNW8/n1oFqvnJAzscEc8UW9ZdoJER7TmMlwTG/9jhQAEsEOgyB9j6xqNAhximtVUEKsDvIqQcc5GNSYm6oUFfY5s8EOWEe/N57YxUdMfwDWXVZYwkvpwsigWVCE3Zy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rZeWs-0002fx-00; Mon, 12 Feb 2024 23:11:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 96BCEC0267; Mon, 12 Feb 2024 23:08:45 +0100 (CET)
Date: Mon, 12 Feb 2024 23:08:45 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] MIPS: Add 'memory' clobber to csum_ipv6_magic() inline
 assembler
Message-ID: <ZcqW7SDE5gvFT+84@alpha.franken.de>
References: <20240211160837.2436375-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211160837.2436375-1-linux@roeck-us.net>

On Sun, Feb 11, 2024 at 08:08:37AM -0800, Guenter Roeck wrote:
> After 'lib: checksum: Use aligned accesses for ip_fast_csum and
> csum_ipv6_magic tests' was applied, the test_csum_ipv6_magic unit test
> started failing for all mips platforms, both little and bit endian.
> Oddly enough, adding debug code into test_csum_ipv6_magic() made the
> problem disappear.
> 
> The gcc manual says:
> 
> "The "memory" clobber tells the compiler that the assembly code performs
>  memory reads or writes to items other than those listed in the input
>  and output operands (for example, accessing the memory pointed to by one
>  of the input parameters)
> "
> 
> This is definitely the case for csum_ipv6_magic(). Indeed, adding the
> 'memory' clobber fixes the problem.
> 
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/mips/include/asm/checksum.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index 4044eaf989ac..0921ddda11a4 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -241,7 +241,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  	"	.set	pop"
>  	: "=&r" (sum), "=&r" (tmp)
>  	: "r" (saddr), "r" (daddr),
> -	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
> +	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
> +	: "memory");
>  
>  	return csum_fold(sum);
>  }
> -- 
> 2.39.2

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

