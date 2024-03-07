Return-Path: <linux-kernel+bounces-95969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C783787557B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E61289369
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646E130E5B;
	Thu,  7 Mar 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjoQWOFC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE578130AE1;
	Thu,  7 Mar 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833596; cv=none; b=UzA5dfhd5EIjktpGjSOJA9I+gPn9SybDQlWVLU/pZwtAR+r0aQWqCV0VyZQhrb9l/ZNf5zwl6Cu8Di06y0fB59MAnEEHGF0WoGcOBnLnc/8/ZJKD/HuTOCiJ463a6bVHB0+/BOmMFirz2WvTeUsk1U74E0X1GMSFg34HDOXNm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833596; c=relaxed/simple;
	bh=X59QqX4H8M/10w2nNvVyVuDtckeb/yTabVDkxTaENJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt7ADROPT8UuUqZMe0DA4VGY5vmpenpVkWRzSWk+fTHbV0/upYDJ8pOQ0KWG1LudSXeAg4w4UVv0LfdsMASNjNMJ0gLAhqzwlO55Zq/Tc3SG28WVzkp8S1r/Q1EOYzsXx2dns5/Pet44CJgkD80HCkBW5hAu+owoW+L/+Lh6SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjoQWOFC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4131651709bso984445e9.2;
        Thu, 07 Mar 2024 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709833593; x=1710438393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zidrMVgwKZG7PoFFeaVJDkEIlmqOlMqbL//oQj2VMe0=;
        b=OjoQWOFChxbSpB9AS+JZgmabKUD0mgFo+ChAO+Yfpu0O35hTzuRdEOxzoaqXqHuniD
         Harn5wFv7i4/BePEsVOLT11XUv+MfTQBrG+A7DE5B+/F3QmGc4pJuE1xdXYkOvHdI5++
         +j4y6+E9pzYwoq4DPaVMFOp5uBOcrfmPYLgGMcoGZczCPlkrVJTAbRtDHS7YK5WFnTjo
         UT0azqA10Iw/frSF+dt+be3LcVUOg9BRT0PwUZR/v28+gg74hATTTiqphJygwu1FEsp9
         p0D5kvOe5mZ1ct9IgSsSkRg7kvmN76w8YNHO9c8QqvMEet1rNYu7rtmtnPDBCSBAkfap
         RXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833593; x=1710438393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zidrMVgwKZG7PoFFeaVJDkEIlmqOlMqbL//oQj2VMe0=;
        b=g2IDhh1alMPBc3xqFAD7TikRmgvPZDFajEhfrEM1TW9an4C+fC0cpNRNipNE7xUGtJ
         Jx7YFA8NI2nQdqeRaSe+L1ltKIYFBnXBAQQO8h1owpcY3bhQfiNtaZz0HExqhLM8xk+b
         Bl3NqolS6bwZw09NbvVd/Vm7tyf2lo+yPavxBE0zsqpjD4wWbkkLVx+2Hdz1nksxNtzJ
         Ywi0oQEHNFqG4OrSugnpNwrUjt4zTkaDNojeAmtnCKULq/oXSxHQc42scylKsN9xAvQX
         P/pAPKjrDUP6oZryZx440wGhA0zKeF1ED+7huRAg8agZ6LYfaAXRbt4crgGMHqwY4av+
         mI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiy+XYS+P8VdW+9eoebCYrHrd4SQ4meEDmNW85v/9hA+ootf00vaqJf8o4LFd5/pEUFHsP63LnESJdK79MmpgFapv/9Oi+MEwU462zWQD2RCrqwiiLHSB6Vw8pJvgJ2SQyUyeiv93fhqlpP5bBzGBuDbWQiGJi0WWAyPLVL70lAUtoYkxk3hP1
X-Gm-Message-State: AOJu0YyPpIMEuocm2lq5VPRTBvGoT1n158GxFKV0XM3poSukqiNy7g0y
	rErOmljzv+TMY7VVtIRt1LQ8fWbWpgxYb5Q6Z+TQHASCfCS9A1iY
X-Google-Smtp-Source: AGHT+IHetAQpP5/ML/yXLg+SIqzs0WbSWPeIuCRA1d1fNHUAKAT9glKWnCfGjizvnc9rO6jrvLS/0A==
X-Received: by 2002:a05:600c:46cd:b0:412:dcf0:991a with SMTP id q13-20020a05600c46cd00b00412dcf0991amr10169173wmo.12.1709833592771;
        Thu, 07 Mar 2024 09:46:32 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n20-20020a05600c501400b00412ea92f1b4sm3473188wmr.19.2024.03.07.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 09:46:32 -0800 (PST)
Message-ID: <7aab696f-6a4f-410d-9769-17fda28f5c4d@gmail.com>
Date: Thu, 7 Mar 2024 17:46:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] usb: gadget: net2272: remove redundant variable
 irqflags
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307105135.1981060-1-colin.i.king@gmail.com>
 <mywsgq453muhggv5y7pfrsg7zrodtuebcpo5rbc4kus5h2ameo@fhnpemjuntaz>
 <2b318367-2428-44ba-b4d9-0a452fcb7858@rowland.harvard.edu>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <2b318367-2428-44ba-b4d9-0a452fcb7858@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/03/2024 17:29, Alan Stern wrote:
> On Thu, Mar 07, 2024 at 05:51:59PM +0100, Uwe Kleine-König wrote:
>> On Thu, Mar 07, 2024 at 10:51:35AM +0000, Colin Ian King wrote:
>>> The variable irqflags is being initialized and being bit-or'd with
>>> values but it is never read afterwards. The variable is redundant
>>> and can be removed.
>>>
>>> Cleans up clang scan build warning:
>>> drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
>>> set but not used [-Wunused-but-set-variable]
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>
>> this "problem" exists since the driver was introduced in commit
>> ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device
>> controller"). Might be worth a Fixes: line.
>>
>> I wonder if the better fix would be:
>>
>> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
>> index 12e76bb62c20..19bbc38f3d35 100644
>> --- a/drivers/usb/gadget/udc/net2272.c
>> +++ b/drivers/usb/gadget/udc/net2272.c
>> @@ -2650,7 +2650,7 @@ net2272_plat_probe(struct platform_device *pdev)
>>   		goto err_req;
>>   	}
>>   
>> -	ret = net2272_probe_fin(dev, IRQF_TRIGGER_LOW);
>> +	ret = net2272_probe_fin(dev, irqflags);
>>   	if (ret)
>>   		goto err_io;
> 
> I agree, that makes much more sense.

OK, I'll send a V2, but I can't test it, so I suspect that is a risk, 
but it is clearly wrong as it stands.

Colin

> 
> Alan Stern


