Return-Path: <linux-kernel+bounces-78702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D879F861792
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157D41C2445E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B285268;
	Fri, 23 Feb 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR/gyaa0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F584FB4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704963; cv=none; b=Z+ZMVZqOaIo9CBoLFUvmTOpLExu0q3R7LL39khs3phS2Ayw3kYc/RH3I5fzggU86XsPrTL3xkxkJJBomuTdLb4OdJf5Bx7ZrVfxaVCBauVUMYHz41TT5hWV9MclLMmicSPtXla16OHY+5oHMMPSgsYBIXHsIvPsTsqHhR2ItQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704963; c=relaxed/simple;
	bh=dQlULNoHT7Qs4BBqk4xJH7Fe4UH0/aQgmFtZgnvh9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phe56tkbO7tAN4el4MxUWIQtuZ+cZVDsj19FfsOOF47wvLPfMLTWmAqs+YxMA1VOfM0bP9f3zNi/I8uQ4XeE+ChHN/4rEnk5Oiha2omjfKgp2iWx+IxsT8Q4aNkbaeGAnOjxi0FBEb2hQT4aYqz0miVId5X62lXOo7efb5wOOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR/gyaa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E813C433C7;
	Fri, 23 Feb 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704963;
	bh=dQlULNoHT7Qs4BBqk4xJH7Fe4UH0/aQgmFtZgnvh9r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR/gyaa0rdaWGHGjd7PDMy2/n4BdmnVEexuQn+GqUC3gPRKsDVJ2X/Sl97P+ymoZx
	 aca+vQR640Ppm+0a2zVeRQlqIeii0NcXMZFLk8Nqh1SmRe4Zpd9Rh613zK9eXEcBtH
	 3S4CwC5pXKH4afDpXfjuDWi2xyWKdoQRotUFeR2joQI46fjL/LBz7Ysdaouzt8R6Nu
	 jH1VhDMyM+UXc8IM81PlYRec908v0tjB7qs/NMgLRNRUJ87S+lo9kVxuL6+Nvegqyj
	 LGNb1SRkMwAx8WcUhhsxPBz45IpYdwo3YIhc86tXIhnKC+OdCRzNTLcLDzCBHHBHiM
	 RfTNNMG/BVJLQ==
Date: Fri, 23 Feb 2024 16:15:59 +0000
From: Lee Jones <lee@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: rk8xx-core: Fix interrupt processing order
 for power key button
Message-ID: <20240223161559.GI1666215@google.com>
References: <20240217195615.1767907-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217195615.1767907-1-megi@xff.cz>

On Sat, 17 Feb 2024, Ondřej Jirman wrote:

> From: Ondrej Jirman <megi@xff.cz>
> 
> Process rise event last, to avoid stuck keys when multiple interrupts
> are coalesced. This can happen typically when resuming from suspend
> via power key press and holding the power button for a bit too short,
> so that RISE an FALL IRQ flags are set before any interrupt routine
> has a chance to run.
> 
> Input subsystem will interpret it as holding down a power key for
> a long time, which leads to unintended initiation of shutdown UI
> on some OSes.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
> Sorry, resent without the bogous patch series numbering.
> 
>  drivers/mfd/rk8xx-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index b1ffc3b9e2be..e2261b68b844 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -43,8 +43,8 @@ static struct resource rk806_pwrkey_resources[] = {
>  };
>  
>  static const struct resource rk817_pwrkey_resources[] = {
> -	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
>  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
> +	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),

FWIW, basing solutions on ordering like this is often fragile!

>  };
>  
>  static const struct resource rk817_charger_resources[] = {
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

