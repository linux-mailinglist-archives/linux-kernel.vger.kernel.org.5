Return-Path: <linux-kernel+bounces-73101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A785BD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE46CB2106C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB074E12;
	Tue, 20 Feb 2024 13:48:56 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F96A345;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=fhFEi/OWzaNQ6P7D1RHcczGJL5y2sbzqGmOhes4I7FVZK0aUexif7qQlA3LTS5xzHGP7i9FKCzX7NJwyKOg840zuLtGmYsQQ/Ev3ImuBaCfwPAq3SS9BS8Limgt0D+9cdn5E9kDyFSYNCZGWfBmunUtReiE9aFG6mQJwacrmJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=dN9MbC0dNk5OxWYWmvs4wMDcGflhy2eneDFOeyPwUIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZU3CdoMtnbNGHtyDL3E5Uu8/HdmpR1Ic+cUq5Qun+bkr96Zs3WrvWNEjhO8F4x1+nEQ7VM3vr8I2GliAW6h5wy+PHJsZXFAhzdKtKDXC1McU6HNbPKyoB2Cq5I3Dgag7LrgKFqYwNVB+7bIG80J50jL+4gwtWFUd0h0GSNpTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OO-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B2CADC066F; Tue, 20 Feb 2024 14:37:47 +0100 (CET)
Date: Tue, 20 Feb 2024 14:37:47 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Erick Archer <erick.archer@gmx.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: Alchemy: Use kcalloc() instead of kzalloc()
Message-ID: <ZdSrK6QeToAl2K2h@alpha.franken.de>
References: <20240120133443.4237-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120133443.4237-1-erick.archer@gmx.com>

On Sat, Jan 20, 2024 at 02:34:43PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  arch/mips/alchemy/common/clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
> index c01be8c45271..6c8996e20a7d 100644
> --- a/arch/mips/alchemy/common/clock.c
> +++ b/arch/mips/alchemy/common/clock.c
> @@ -771,7 +771,7 @@ static int __init alchemy_clk_init_fgens(int ctype)
>  	}
>  	id.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE;
> 
> -	a = kzalloc((sizeof(*a)) * 6, GFP_KERNEL);
> +	a = kcalloc(6, sizeof(*a), GFP_KERNEL);
>  	if (!a)
>  		return -ENOMEM;
> 
> --
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

