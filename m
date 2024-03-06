Return-Path: <linux-kernel+bounces-94570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D887418B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D7F2822E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89A171B0;
	Wed,  6 Mar 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KcoqCCIO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5014A82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758179; cv=none; b=k4NO2U+dOsfXK28WGRBT439XKlFZJfLJyrVdkA0/OUBhVifHr+HM/1s8ChRqPky5u5K+XAbFb/BNMGMfmvkPaZqLcao7pe3Gxtz2DLb3znu0MLQWccrKUO5SaWqttUPKW61Y2mzIk7pVKH3krLkGrE6jW18VIOKnYcgv5M5f0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758179; c=relaxed/simple;
	bh=LK0gBJGkoaxvPUcQkbcW85MwC6l95SvrK86Yk7Qjrwc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb9sVGGKu3EaM8Yrss6JHJX/1p0rxuKME+TKOJAkqwvRtnP9/22BW1UOYnKtuq7E8nHpMLLNR5w8nPKHXBOBrt/9sX/69Q6vaDnDyVhq4pwfprcWcML/K+gkCnqlenH4vSGbozxh8M2mekJVgNGwt/+L2msv1HzGXJOQS6xcZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KcoqCCIO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426KnHKZ077609;
	Wed, 6 Mar 2024 14:49:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709758157;
	bh=Ow2bJDZHIOf/6igE/KhcehTJAmDzHvpWjmUZu+Rns58=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KcoqCCIOLbX4YeHIzuGlPoM0Wmev536JdwEHJdqMpPotaPzqUVIFATkbAxWOu0r0/
	 UXSga6WDTSeBhe2frLfGB1xA3ZwZZZObLUAPAKSRrJw/cOCgJKaWOMnIj/DkPrH1FR
	 ZlZo5h7vVgknJN26leqPFq8gFjWP+kiOeL7RHtvk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426KnH7J010115
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Mar 2024 14:49:17 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 14:49:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 14:49:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426KnHQl052746;
	Wed, 6 Mar 2024 14:49:17 -0600
Date: Wed, 6 Mar 2024 14:49:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: ti-sci: Convert to platform remove callback
 returning void
Message-ID: <20240306204917.l4vlp6hjotkwa5ig@stingy>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
 <ab374da386cafd6748aac5bdf66e6be3e1860509.1709674157.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab374da386cafd6748aac5bdf66e6be3e1860509.1709674157.git.u.kleine-koenig@pengutronix.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:32-20240305, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Thanks.

Reviewed-by: Nishanth Menon <nm@ti.com>

>  drivers/reset/reset-ti-sci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
> index cc01fa5b0bea..d384da0982fa 100644
> --- a/drivers/reset/reset-ti-sci.c
> +++ b/drivers/reset/reset-ti-sci.c
> @@ -235,20 +235,18 @@ static int ti_sci_reset_probe(struct platform_device *pdev)
>  	return reset_controller_register(&data->rcdev);
>  }
>  
> -static int ti_sci_reset_remove(struct platform_device *pdev)
> +static void ti_sci_reset_remove(struct platform_device *pdev)
>  {
>  	struct ti_sci_reset_data *data = platform_get_drvdata(pdev);
>  
>  	reset_controller_unregister(&data->rcdev);
>  
>  	idr_destroy(&data->idr);
> -
> -	return 0;
>  }
>  
>  static struct platform_driver ti_sci_reset_driver = {
>  	.probe = ti_sci_reset_probe,
> -	.remove = ti_sci_reset_remove,
> +	.remove_new = ti_sci_reset_remove,
>  	.driver = {
>  		.name = "ti-sci-reset",
>  		.of_match_table = ti_sci_reset_of_match,
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

