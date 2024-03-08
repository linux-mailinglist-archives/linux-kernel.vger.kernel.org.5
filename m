Return-Path: <linux-kernel+bounces-97592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5912E876C46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3472824D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7C5F578;
	Fri,  8 Mar 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT3Uqn1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADC17745;
	Fri,  8 Mar 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932069; cv=none; b=j0fsm54fWHwaa48XPppnVIKN8sKairzJt/mQ2HByoDgePj+sQ/GaStbgPmwgM1V5PqTrxZPfmDUga7bUP+vnFz2fn2ld6Ac9XSeK9Av1fvjWBTsb7jbsVmiJCcVbEbbvWjN4jyP4wGry06Xji0skvHlp6hr1OhWnKPQIjLSeGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932069; c=relaxed/simple;
	bh=Rafts2ktybCYCpYRua0CGo5JhyQRssPbKtGgM7c4hs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm4p98aQIKYoUdfzDOHKGiyRUaS/eZlc+91a9LNocEBWgvfbwW1OxrH/aOWiXjb8c+968WxOMjW1RFCciKpyKKS83RsUyH1Xn69WHYiqLzNmkHjsEyg2/gCKABN42x6r8yJFOO/aucpajDmuY1BK10N+zj2xrXKd5EIwX1m0INA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT3Uqn1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CADC43390;
	Fri,  8 Mar 2024 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932068;
	bh=Rafts2ktybCYCpYRua0CGo5JhyQRssPbKtGgM7c4hs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eT3Uqn1VjwoaFOvgzuD3hNka8x/blswH1Zz7/dmxoAU1T2rEZLdmF0Zv8druvgf8C
	 dChAIdgK0a0y37ONSQgy/VadgUVkO68TCstLJA4zgxc5HRUXnj4410JlphPLQuEXoG
	 temNOYJbPuc4E+n9EM4TC2fntUtFfjf8Gdh4fhbwMzeb0fQR4dm1F4MKlZKSLRbhOv
	 E3NzCRjZjooefTy5/fuvJR5jfMsa6/pOXdjrK/88fVyCnyZanb9AeMyT+biXVMLna3
	 UiiqePWQ3hx7ag1v9xNPJP7Prjwss47rthQdUFBMqXJcTsUGuhv+uUmz897Tdcs1vU
	 XFT2fz87XHMvw==
Date: Fri, 8 Mar 2024 21:07:45 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] ptp: Move from simple ida to xarray
Message-ID: <20240308210745.GE603911@kernel.org>
References: <20240307100327.887758-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307100327.887758-1-kory.maincent@bootlin.com>

On Thu, Mar 07, 2024 at 11:03:26AM +0100, Kory Maincent wrote:
> Move from simple ida to xarray for storing and loading the ptp_clock
> pointer. This prepares support for future hardware timestamp selection by
> being able to link the ptp clock index to its pointer.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

..

> @@ -246,11 +246,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (ptp == NULL)
>  		goto no_memory;
>  
> -	index = ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
> -	if (index < 0) {
> -		err = index;
> +	err = xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
> +		       GFP_KERNEL);
> +	if (err)
>  		goto no_slot;
> -	}
>  
>  	ptp->clock.ops = ptp_clock_ops;
>  	ptp->info = info;

Hi Kory,

Prior to this change err was -ENOMEM at this point. Now it is 0.

And The immediately following code is:

	ptp->devid = MKDEV(major, index);
	ptp->index = index;
	INIT_LIST_HEAD(&ptp->tsevqs);
	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
	if (!queue)
		goto no_memory_queue;

The goto above results in:

	return ERR_PTR(err);

But here err is 0. This does not seem correct.

Flagged by Smatch.

..

-- 
pw-bot: changes-requested

