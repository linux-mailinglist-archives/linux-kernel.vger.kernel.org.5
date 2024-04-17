Return-Path: <linux-kernel+bounces-148383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B638A81D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F901F21FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0913C8FD;
	Wed, 17 Apr 2024 11:14:27 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390126A02E;
	Wed, 17 Apr 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352467; cv=none; b=CWKggYpCkMCb7xwsDWsdDRe7Z66O08sA4UFh5Y7RR22yCnjQ7l6/IQwhFMx7Bv0iUGJoqCNhjLTF6gHLGhqy97/Ks2UxdyHZsTaEar0VdJdi38N/G761MPyVKY7cF8vt8dm9SG3du8iu96FpmxlT5UWvalOeAdwDPlx5t9fXzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352467; c=relaxed/simple;
	bh=WzRvm8JFqBZI9PDvUaCvjiXbej6u5EVb2PLAKCqA8jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOOMYcpz49XvX/uYlDGyS1MU9RcvW6anUSHAQm2yJNX7QLl9u7FE0AlxQpjpfgDuf6dI309a7aZi6sPAB53V+TtBvM1fPYsb0ol4IgMqXxNcB2837Ej3J7nQD4zgQ6hkjM/J6tqZKS9R7K9v5p1gy0CDno2cdF/eQbNSKxVIbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rx3En-0003qf-00; Wed, 17 Apr 2024 13:14:01 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B18B4C01B0; Wed, 17 Apr 2024 13:10:52 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:10:52 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Message-ID: <Zh+uPB0druail4XC@alpha.franken.de>
References: <20240416173711.613750-1-yury.norov@gmail.com>
 <20240416173711.613750-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416173711.613750-2-yury.norov@gmail.com>

On Tue, Apr 16, 2024 at 10:37:10AM -0700, Yury Norov wrote:
> The function sets adjusted groups of bits in hub_irq_map by using
> for-loops. There's a bitmap_set() function dedicated to do this.
> 
> Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
> ranges belong to the same machine word, bitmap_set() would boil down
> to an inline wrapper in both cases, avoiding generating a loop, with
> the associate overhead. Effectively, it would be a compile-time:
> 
> 	*hub_irq_map = GENMASK() | GENMASK();
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-irq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> index 8f5299b269e7..d8acdf0439d2 100644
> --- a/arch/mips/sgi-ip27/ip27-irq.c
> +++ b/arch/mips/sgi-ip27/ip27-irq.c
> @@ -277,7 +277,6 @@ void __init arch_init_irq(void)
>  {
>  	struct irq_domain *domain;
>  	struct fwnode_handle *fn;
> -	int i;

I've already applied your first version, so I need an incremental
patch, which just removes the unused variable.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

