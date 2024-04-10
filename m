Return-Path: <linux-kernel+bounces-139165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1058D89FF60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4178D1C23143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1017F395;
	Wed, 10 Apr 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TPB4I1jH"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD051168DC;
	Wed, 10 Apr 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772206; cv=none; b=U6v48jH5x7wSAVlT0fLidG1CUO49fVTjf26v4X8gLTFX7BKLmhyBOEPmHGCaxJ45+qs3IV3BsmO9w9ihFJZHigkOmFawztgztiVcE4TJQRAP4Hc5FLPUHx3Prvcd2zHnNyjHh3RYR+eaYmpVy+xdvYI828ejNrh9/kIECgrM5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772206; c=relaxed/simple;
	bh=wMS4gDZI3WDLgsegzWGhOd6/GvMxbzC3pD//XnWrfc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/nP7WVP38f0lVKMS7+MJz18V5VziyrN9ya3H73qUOiEcs9O5pU7qe+N687Gu5kpf8zy+H9QomTxwhWAXIOZyh81b/3LUfw25MoCzsPvfYniwUc2P52dKpjd0f90G4VjK4Yt0AjueHEFfi+0zTtNP8wzB5SPm0vr5EIg3pVDf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TPB4I1jH; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AI3K38017451;
	Wed, 10 Apr 2024 13:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712772200;
	bh=PlFYSUDoFAWZm0R0ly88cvpUbEU2YxPPUdusejymroQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TPB4I1jHY7FjJTbMo6oKZj/ne3Ha/i/YL62locf+H6L/BEAvoLm+fygC5+botuQmz
	 XbJy9KG5RstWJg+uGVjmVkeHkJ0DvxTrBUdXL/7stwMryof5kD+Id2+u7fUK513Uw2
	 h+sRRX7bPIfVJliZk+oYgkvnL7xiRfJA9TtAhEoo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AI3Kmh021090
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 13:03:20 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:03:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:03:19 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AI3IvZ028308;
	Wed, 10 Apr 2024 13:03:19 -0500
Date: Wed, 10 Apr 2024 23:33:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] bus: ti-sysc: Move check for no-reset-on-init
Message-ID: <20240410180318.ddpbdlnlss7bqweg@dhruva>
References: <20240410064010.57142-1-tony@atomide.com>
 <20240410064010.57142-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240410064010.57142-2-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 10, 2024 at 09:40:05 +0300, Tony Lindgren wrote:
> We are wrongly checking SYSC_QUIRK_NO_RESET_ON_INIT flag in sysc_reset(),
> it can be called also after init from sysc_reinit_module(). Let's fix the
> issue by moving the check to the init code.

I am not able to understand exactly the potential bug here, what was the
issue exactly?
What I am able to infer is this is more of an improvement than fixing a
bug? Maybe I am missing some context, can you help me understand the
potential bug here?

> 
> Fixes: 6a52bc2b81fa ("bus: ti-sysc: Add quirk handling for reset on re-init")

Fixes tag, you might want to CC stable@vger.kernel.org?

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2145,8 +2145,7 @@ static int sysc_reset(struct sysc *ddata)
>  	sysc_offset = ddata->offsets[SYSC_SYSCONFIG];
>  
>  	if (ddata->legacy_mode ||
> -	    ddata->cap->regbits->srst_shift < 0 ||
> -	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
> +	    ddata->cap->regbits->srst_shift < 0)
>  		return 0;
>  
>  	sysc_mask = BIT(ddata->cap->regbits->srst_shift);
> @@ -2240,12 +2239,14 @@ static int sysc_init_module(struct sysc *ddata)
>  			goto err_main_clocks;
>  	}
>  
> -	error = sysc_reset(ddata);
> -	if (error)
> -		dev_err(ddata->dev, "Reset failed with %d\n", error);
> +	if (!(ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)) {
> +		error = sysc_reset(ddata);
> +		if (error)
> +			dev_err(ddata->dev, "Reset failed with %d\n", error);
>  
> -	if (error && !ddata->legacy_mode)
> -		sysc_disable_module(ddata->dev);
> +		if (error && !ddata->legacy_mode)
> +			sysc_disable_module(ddata->dev);
> +	}
>  

-- 
Best regards,
Dhruva

