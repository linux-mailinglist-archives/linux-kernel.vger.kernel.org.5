Return-Path: <linux-kernel+bounces-39989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54D83D90B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFB7B3E78F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF741CF8F;
	Fri, 26 Jan 2024 10:16:05 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD621CD1A;
	Fri, 26 Jan 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264165; cv=none; b=AEQOUIiq8uCAJGvBQtR3thauc9UCMgg7D7f13cxno3NdTuiaeglHu2wqBU7LiBBgdJXxFDobNC3f39VDDVZzqvWK1W73FyXpgqtrgQ59jErhnqR5496XaC4JDyGd8cmZqznZrJ0jYo8pYSE9qkNW+vDv+qHFRQiaoFnrcUIXz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264165; c=relaxed/simple;
	bh=JzsJ1hi/HTW0sIn7Hj+aVlk0JmlpkAgZaLCD04xMdtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l32eXsR73L32zXhiKvc6KUPbKO2TnqGeU4nUfmp+n/jDeymWz0FyCBaYBixqwTcsZF7zPrXFMgrhrkQ8A05OLJceqa/05FFyPb7oKV0MDJ4dN+QDwcx+bRY6VcUx6mx8YOoICv3VJk4XeTp8ghdJKTtTzU0vBDy8ES5SCSSF7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rTJFY-0003wk-00; Fri, 26 Jan 2024 11:15:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 83452C0661; Fri, 26 Jan 2024 11:13:43 +0100 (CET)
Date: Fri, 26 Jan 2024 11:13:43 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: john@phrozen.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: register smp_ops on non-smp platforms
Message-ID: <ZbOF1wPz2Xa3AyU/@alpha.franken.de>
References: <20240122184709.9625-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184709.9625-1-olek2@wp.pl>

On Mon, Jan 22, 2024 at 07:47:09PM +0100, Aleksander Jan Bajkowski wrote:
> Lantiq uses a common kernel config for devices with 24Kc and 34Kc cores.
> The changes made previously to add support for interrupts on all cores
> work on 24Kc platforms with SMP disabled and 34Kc platforms with SMP
> enabled. This patch fixes boot issues on Danube (single core 24Kc) with
> SMP enabled.
> 
> Fixes: 730320fd770d ("MIPS: lantiq: enable all hardware interrupts on second VPE")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/mips/lantiq/prom.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index a3cf29365858..0c45767eacf6 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -108,10 +108,9 @@ void __init prom_init(void)
>  	prom_init_cmdline();
>  
>  #if defined(CONFIG_MIPS_MT_SMP)
> -	if (cpu_has_mipsmt) {
> -		lantiq_smp_ops = vsmp_smp_ops;
> +	lantiq_smp_ops = vsmp_smp_ops;
> +	if (cpu_has_mipsmt)
>  		lantiq_smp_ops.init_secondary = lantiq_init_secondary;
> -		register_smp_ops(&lantiq_smp_ops);
> -	}
> +	register_smp_ops(&lantiq_smp_ops);
>  #endif
>  }
> -- 
> 2.39.2

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

