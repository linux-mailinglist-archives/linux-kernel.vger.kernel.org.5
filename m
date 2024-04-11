Return-Path: <linux-kernel+bounces-141458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA98A1E85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491661F294EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464D139579;
	Thu, 11 Apr 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pkslds6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6A13A248;
	Thu, 11 Apr 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859100; cv=none; b=gzU/LJYMSIWjvKi3yBN5bq1FJ5waIcHCZ1KiOFwIKdQgopAL+/9htDgy7RxYQlhBz8qBmDhe2CgIFUNml9mW8NAw8H9agtBP03WuNLYg1X3sc38bq60QDv0mG7cShS0Qfj3ukIHuCxvVb/vcMQa50Th85P/2TvlRlcSDMEYSTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859100; c=relaxed/simple;
	bh=6PD3j62MZIhS1PTwrJR+fB5FOccOx8hNCngLSnkhUUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLMkAAf8EFPt3g0CmBA+kZaAwLh4/FB9PezoucqmDP7NNU6YeDd3Smj/aBRdkapv28CYYnH4V4Ekpr0Ediu6e82jdv2IY3YpHAAmTvfLBGajnvMOAtkcV9u/tgVmN1Hp//LPsHAf5Tlf4rA1+hsxVtrStszgDIn261WBP3HSivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pkslds6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF53C072AA;
	Thu, 11 Apr 2024 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712859099;
	bh=6PD3j62MZIhS1PTwrJR+fB5FOccOx8hNCngLSnkhUUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pkslds6rM2DQ0uj78jhCYHoC3+F9IXK8RCTl8maGsIdCcCfwsycdXHUzmvFi/EEHQ
	 VDSsNkmQpbGmBxme6A8UVgEEB149FZUp7oxCQYyBMAUuABd135KFCg1/Fm2f/S5hw/
	 S2lBQrPLx5x3J7Z12Rrwqaq176a87h1io9r95HWo=
Date: Thu, 11 Apr 2024 20:11:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
Message-ID: <2024041111-tummy-boil-a6aa@gregkh>
References: <20240411180256.61001-1-romeusmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411180256.61001-1-romeusmeister@gmail.com>

On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> Add a cleanup function attribute '__free(device_node)' to the device node
> pointer initialization statement and remove the pairing cleanup function
> call of 'of_node_put' at the end of the function.
> The '_free()' attrubute is introduced by scope-based resource management
> in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> '__free()' attribute makes a compiler insert a cleanup function call
> to the places where the pointer goes out of the scope. This feature
> allows to get rid of manual cleanup function calls.
> 
> Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> This patch targets the next tree:
> tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> tag: next-20240411
> ---
>  drivers/tty/sysrq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 02217e3c916b..1d1261f618c0 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
>  static void sysrq_of_get_keyreset_config(void)
>  {
>  	u32 key;
> -	struct device_node *np;
>  	struct property *prop;
>  	const __be32 *p;
>  
> -	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +	struct device_node *np __free(device_node) =
> +		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> +
>  	if (!np) {
>  		pr_debug("No sysrq node found");
>  		return;
> @@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
>  
>  	/* Get reset timeout if any. */
>  	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> -
> -	of_node_put(np);
>  }
>  #else
>  static void sysrq_of_get_keyreset_config(void)

Also, this change really makes no sense at all, the pointer never goes
out of scope except when the function is over, at the bottom.  So why
make this complex change at all for no benefit?

In other words, properly understand the change you are making and only
make it if it actually makes sense.  It does not make any sense here,
right?

thanks,

greg k-h

