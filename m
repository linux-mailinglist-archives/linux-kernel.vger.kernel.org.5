Return-Path: <linux-kernel+bounces-96203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E6875881
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0D9281267
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432AA634F6;
	Thu,  7 Mar 2024 20:33:57 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2C446DE;
	Thu,  7 Mar 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843636; cv=none; b=F9sawlPWGNekwHEKdvGmAb571HEFE7c1b3ClpWZI8A8lLkx3htbhuNL5xQWghlBd0LGdLcZTLXDLvFYvTJ8qs52DglWsfm43IqI2Zba+zeJnNfVfUIQ/0L/SKKZh7tvwVG4+BZFLz0KzRJkcmQCACVfFbu1EEqws2Qtw/226TQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843636; c=relaxed/simple;
	bh=i7NnHGgJh/gaT/CXNqVxZUDLT1k1C/mMAz3cqvpjzZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lq7pZiFpzUFcpt1taU0tjYCt3YJEli7Jdv7yb4y8UGFARHi5RvPBsiIlKqtuA5yjLQ2rZmCjOjmA9cm70bQPSfW1tNLA3CoHEQNz+MOfbhLPpJiWtQpN65PsKxvXHhkoIPgRkjJr4m/aBlmJVjVvc7ThhlwvTd82Bxhdxx4tj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4da.dynamic.kabel-deutschland.de [95.90.244.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C570B61E5FE06;
	Thu,  7 Mar 2024 21:33:28 +0100 (CET)
Message-ID: <58f49929-fbcf-4d8a-bece-c66454ca51bc@molgen.mpg.de>
Date: Thu, 7 Mar 2024 21:33:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>, peterhuewe@gmx.de,
 LinoSanfilippo@gmx.de, p.rosenberger@kunbus.com, lukas@wunner.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
 <84dd5c01-906c-4e13-9d8c-e5350f718d56@molgen.mpg.de>
 <CZNSDUEJ4P9S.235D7ZCOV738N@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CZNSDUEJ4P9S.235D7ZCOV738N@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jarkko,


Am 07.03.24 um 21:05 schrieb Jarkko Sakkinen:
> On Tue Mar 5, 2024 at 5:43 PM EET, Paul Menzel wrote:

>> Am 01.02.24 um 12:36 schrieb Lino Sanfilippo:
>>> If interrupts are not activated the work struct 'free_irq_work' is not
>>> initialized. This results in a warning splat at module shutdown.
>>>
>>> Fix this by always initializing the work regardless of whether interrupts
>>> are activated or not.
>>>
>>> cc: stable@vger.kernel.org
>>> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
>>> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> Closes: https://lore.kernel.org/all/CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org/
>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>> ---
>>>    drivers/char/tpm/tpm_tis_core.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>> index 1b350412d8a6..64c875657687 100644
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -919,8 +919,6 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>>>    	int rc;
>>>    	u32 int_status;
>>>    
>>> -	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>>> -
>>>    	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>>>    				       tis_int_handler, IRQF_ONESHOT | flags,
>>>    				       dev_name(&chip->dev), chip);
>>> @@ -1132,6 +1130,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>>    	priv->phy_ops = phy_ops;
>>>    	priv->locality_count = 0;
>>>    	mutex_init(&priv->locality_count_mutex);
>>> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>>>    
>>>    	dev_set_drvdata(&chip->dev, priv);
>>
>> This is commit d6fb14208e22 in jarkko/next.
>>
>> I tested this patch on top of Linux 6.8-rc7 on a Dell OptiPlex 5055 [1]
>> and it fixes the issue there too.
> 
> Thanks!
> 
> If you don't mind I'll add your tested-by to the commit before I send
> my next pull request to Linus?

Sure, go ahead. I thought, it’s not going to be amended, and therefore 
didn’t add the tag.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

