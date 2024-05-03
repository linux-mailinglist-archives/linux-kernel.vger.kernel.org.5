Return-Path: <linux-kernel+bounces-167659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7748BACE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0554B216D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EE139CE0;
	Fri,  3 May 2024 12:55:37 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4318C3D;
	Fri,  3 May 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740936; cv=none; b=D7eAB2iJRx04QAuIhDAQ5mpYBQtQkEQY4S4t5JXV1aiZ4b9Zr6HHe2HZlIBLA/PZpi+wWCJg43fIUyc1XMcuOmv4oEYWBmYVLxT9Dhdt1B0BzSL9OLJs4av6AjAlVSgtMX1JIEbRXOX05ZMJTvU0S/zi2juVIp0Qp1TRsUxzOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740936; c=relaxed/simple;
	bh=BWZRweGYonVWt53MqLLIvhjQRxNRVYfkNEXhBYrkWDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaSMyKkkwdTLMWYNmGLL993zipRUPMiRHFflzQpkGZh4jlq+I4rH/aYhyytLHT9ClbEMi79LY21Bi6bPRlER1r9CkOWrr1ROfONfCbiCoE2Cnz20hKoky4pQWl1tcULUWTPLKrBWzXQREa/mLnVpkTXsnTZnMqzi/dZ9+s46Q0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1s2sRd-000318-00; Fri, 03 May 2024 14:55:21 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B6289C0248; Fri,  3 May 2024 14:50:40 +0200 (CEST)
Date: Fri, 3 May 2024 14:50:40 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: SGI-IP27: use WARN_ON() output
Message-ID: <ZjTdoLG+KH/qYF2l@alpha.franken.de>
References: <20240416173711.613750-1-yury.norov@gmail.com>
 <20240416173711.613750-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416173711.613750-3-yury.norov@gmail.com>

On Tue, Apr 16, 2024 at 10:37:11AM -0700, Yury Norov wrote:
> WARN_ON() propagates the result of conditional expression, and it can be
> used to return early in the following expression in the arch_init_irq().
> 
> This is a no-op cleanup, except that compiler may optimize the error paths
> better because WARN_ON() implies 'unlikely()'.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-irq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> index d8acdf0439d2..00e63e9ef61d 100644
> --- a/arch/mips/sgi-ip27/ip27-irq.c
> +++ b/arch/mips/sgi-ip27/ip27-irq.c
> @@ -289,13 +289,12 @@ void __init arch_init_irq(void)
>  	bitmap_set(hub_irq_map, NI_BRDCAST_ERR_A, MSC_PANIC_INTR - NI_BRDCAST_ERR_A + 1);
>  
>  	fn = irq_domain_alloc_named_fwnode("HUB");
> -	WARN_ON(fn == NULL);
> -	if (!fn)
> +	if (WARN_ON(fn == NULL))
>  		return;
> +
>  	domain = irq_domain_create_linear(fn, IP27_HUB_IRQ_COUNT,
>  					  &hub_domain_ops, NULL);
> -	WARN_ON(domain == NULL);
> -	if (!domain)
> +	if (WARN_ON(domain == NULL))
>  		return;
>  
>  	irq_set_default_host(domain);
> -- 
> 2.40.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

