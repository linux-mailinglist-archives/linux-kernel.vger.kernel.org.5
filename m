Return-Path: <linux-kernel+bounces-122826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558688FDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FF01C257E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076F7E564;
	Thu, 28 Mar 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nxi3K+om"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861F7CF1F;
	Thu, 28 Mar 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625039; cv=none; b=kenvsjlnbZv3RQJxrO9ho7AuOwu3zRNojtN6ahQi+z9RMOo2Q4N7M7lw32UO1O9O74AHdYk3HVu4Sc7Zfu5zb+D8KOynrVTZ/nX5G9phJ6XGdaEJZDQ1cnwEIP1k0dKoaJR4XvL4vSPN+rCH9mSlQNOrpmASplq0WNtG6ZT6re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625039; c=relaxed/simple;
	bh=86h0emdJ0YBYZjZ1r0P4UPOx03+47D7Z3e3EeA+98Mg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCKZGu6van7yU0qBRUvNHbKKQOyztHeUNNhNb0Nz7jP0d36tl2QsipCap1pqAegQTz0I29vXTqxTm/OdzV9BigOFhwcGNihxTEC6vB59yjX3F5LeIboZqS/UMBasGkM8YkGGuB863iHLfn491yOsUZA8mm0z54gQ7k8OAZKUKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nxi3K+om; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBNr4T127106;
	Thu, 28 Mar 2024 06:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711625033;
	bh=IwVEGYlbyeUCCcamPvrjgWzCcvQsaU0T56u+4M4+IEc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nxi3K+omcpO5Efj2HEmE0HpTA2idSjREEbURpnyUYT2FTXmD7+bQAEYrEuCjC0rgG
	 +nmigKekEci23CjjReXkr3UQsAh2XURCFd/NaxlUvGXUnHHCni+hV98f4gDRmSPGlT
	 ct/pJ/n5RfA8qNV5Qe80tOVCjtAGskjJmc8VLEwc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBNrO0014612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 06:23:53 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:23:53 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:23:53 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBNq4s107593;
	Thu, 28 Mar 2024 06:23:52 -0500
Date: Thu, 28 Mar 2024 16:53:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] bus: ti-sysc: Drop legacy quirk handling for
 smartreflex
Message-ID: <20240328112351.e7klcl7zjz6uov2j@dhruva>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-5-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327081508.36747-5-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 27, 2024 at 10:15:07 +0200, Tony Lindgren wrote:
> With the smartreflex driver no longer relying on the use of
> pm_runtime_irq_safe(), we can finally drop the related legacy quirk
> handling.

Just for some more context can you describe from which commit of
smartreflex driver did this happen?

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2869,8 +2869,7 @@ static const struct sysc_capabilities sysc_34xx_sr = {
>  	.type = TI_SYSC_OMAP34XX_SR,
>  	.sysc_mask = SYSC_OMAP2_CLOCKACTIVITY,
>  	.regbits = &sysc_regbits_omap34xx_sr,
> -	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED |
> -		      SYSC_QUIRK_LEGACY_IDLE,
> +	.mod_quirks = SYSC_QUIRK_USE_CLOCKACT | SYSC_QUIRK_UNCACHED,
>  };
>  
>  /*
> @@ -2891,13 +2890,12 @@ static const struct sysc_capabilities sysc_36xx_sr = {
>  	.type = TI_SYSC_OMAP36XX_SR,
>  	.sysc_mask = SYSC_OMAP3_SR_ENAWAKEUP,
>  	.regbits = &sysc_regbits_omap36xx_sr,
> -	.mod_quirks = SYSC_QUIRK_UNCACHED | SYSC_QUIRK_LEGACY_IDLE,
> +	.mod_quirks = SYSC_QUIRK_UNCACHED,
>  };
>  
>  static const struct sysc_capabilities sysc_omap4_sr = {
>  	.type = TI_SYSC_OMAP4_SR,
>  	.regbits = &sysc_regbits_omap36xx_sr,
> -	.mod_quirks = SYSC_QUIRK_LEGACY_IDLE,

I'm good with the changes,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

