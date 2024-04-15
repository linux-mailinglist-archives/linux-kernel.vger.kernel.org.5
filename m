Return-Path: <linux-kernel+bounces-144765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495C8A4A70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDEDB230A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914D38389;
	Mon, 15 Apr 2024 08:36:01 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB51EA80;
	Mon, 15 Apr 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170161; cv=none; b=nl6iDK0vTpjjH/u3Q6ppXqiPT+dwLAepRz1+T1+eoWdVnRLoX7JHO5YrHCk1lTE3S+Er1LX+/3xYmkNcrSWZNmc8us0yKiLR2gMfksGoir9+2zywQxxP5ocm8PTnn4lD4fEEwPMc8mhDMHFDhpyYgixaFqCSRS7X1QwoAW43FKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170161; c=relaxed/simple;
	bh=zCwhZJeLM6BejwsbJwh9RhBF8AjtaK6UWfkK7UhZzSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRXa2c9pw14mhmy7KEWctVI4dMUsFkJ1Nd6oKyKDfYshNVq+/15tX2mkPFC0pT+sqBevalNYrh4r13urEisvJqBgT7AJH7HOzmMIQ/dNUMHKgN9m2rLjVZ9zPjNvQfE8/bxh1+Ikt0zATrntkYhc7bezhwklMpc8fNzXM01sS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rwHoa-0004hf-00; Mon, 15 Apr 2024 10:35:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id CE426C0135; Mon, 15 Apr 2024 10:31:37 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:31:37 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Message-ID: <Zhzl6TE57LCjdJXL@alpha.franken.de>
References: <20240413184913.69268-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413184913.69268-1-yury.norov@gmail.com>

On Sat, Apr 13, 2024 at 11:49:13AM -0700, Yury Norov wrote:
> The function sets adjasted groups of bits in hub_irq_map by using
> for-loops. There's a bitmap_set() function dedicated to do this.
> 
> Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
> ranges belong to the same machine word, bitmap_set() would boil down
> to an inline wrapper in both cases, avoiding generating a loop, whth
> the associate overhead.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-irq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> index e6ca34cc9853..3c3a4b56ab95 100644
> --- a/arch/mips/sgi-ip27/ip27-irq.c
> +++ b/arch/mips/sgi-ip27/ip27-irq.c
> @@ -279,11 +279,8 @@ void __init arch_init_irq(void)
>  	 * Mark these as reserved right away so they won't be used accidentally
>  	 * later.
>  	 */
> -	for (i = 0; i <= CPU_CALL_B_IRQ; i++)
> -		set_bit(i, hub_irq_map);
> -
> -	for (i = NI_BRDCAST_ERR_A; i <= MSC_PANIC_INTR; i++)
> -		set_bit(i, hub_irq_map);
> +	bitmap_set(hub_irq_map, 0, CPU_CALL_B_IRQ + 1);
> +	bitmap_set(hub_irq_map, NI_BRDCAST_ERR_A, MSC_PANIC_INTR - NI_BRDCAST_ERR_A + 1);
>  
>  	fn = irq_domain_alloc_named_fwnode("HUB");
>  	WARN_ON(fn == NULL);
> -- 
> 2.40.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

