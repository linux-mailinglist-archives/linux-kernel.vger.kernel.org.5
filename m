Return-Path: <linux-kernel+bounces-92627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3987230D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F181F223E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF7127B65;
	Tue,  5 Mar 2024 15:44:09 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93085944;
	Tue,  5 Mar 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653448; cv=none; b=XrBa6uqePs2OPwaZqIoyFOK/cLT84ZczEWkToFGfefg3Nz+M2f3ljZVKHoZfBcs3Jn8Olh5HSMzGHQJlmGHQ1WKo1sEMJtjOSFbTopmo1tWjNXruknVG4QsY+5gIMekhRrS5ynrFR53KhJn8vwp7Gw4PTj0640jvm0SC1Y+sk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653448; c=relaxed/simple;
	bh=MnnHCdDfPrQPB8WD5/lqBatvO68cm49it20wP3Yp/aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGdLYjcXLWBCitB1HPozNI2e3Gglt4G/vxWR/2b2NfVKoLoEx0icMYV2XAbSrJKGMNT5yty6D+7W19oKffH79FfFkadvqSYDsi57YvLbSNFGHausjBmQdaZdQbGq/0NcFqMHREOFCIFLvxk953oM9du7yG6H/9LEyzIe1qZRdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 92E3261E5FE36;
	Tue,  5 Mar 2024 16:43:49 +0100 (CET)
Message-ID: <84dd5c01-906c-4e13-9d8c-e5350f718d56@molgen.mpg.de>
Date: Tue, 5 Mar 2024 16:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
Content-Language: en-US
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, LinoSanfilippo@gmx.de,
 p.rosenberger@kunbus.com, lukas@wunner.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Lino,


Thank you for the patch.

Am 01.02.24 um 12:36 schrieb Lino Sanfilippo:
> If interrupts are not activated the work struct 'free_irq_work' is not
> initialized. This results in a warning splat at module shutdown.
> 
> Fix this by always initializing the work regardless of whether interrupts
> are activated or not.
> 
> cc: stable@vger.kernel.org
> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Closes: https://lore.kernel.org/all/CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org/
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 1b350412d8a6..64c875657687 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -919,8 +919,6 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>   	int rc;
>   	u32 int_status;
>   
> -	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> -
>   	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>   				       tis_int_handler, IRQF_ONESHOT | flags,
>   				       dev_name(&chip->dev), chip);
> @@ -1132,6 +1130,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   	priv->phy_ops = phy_ops;
>   	priv->locality_count = 0;
>   	mutex_init(&priv->locality_count_mutex);
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>   
>   	dev_set_drvdata(&chip->dev, priv);

This is commit d6fb14208e22 in jarkko/next.

I tested this patch on top of Linux 6.8-rc7 on a Dell OptiPlex 5055 [1] 
and it fixes the issue there too.


Kind regards,

Paul


[1]: https://lore.kernel.org/all/CYJ163J3I09U.2XMVZ0BLWV1Y1@seitikki/

