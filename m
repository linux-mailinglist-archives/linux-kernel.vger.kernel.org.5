Return-Path: <linux-kernel+bounces-131493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397808988A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FAD1C217C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1A1272D3;
	Thu,  4 Apr 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq4vWqDz"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBF86245;
	Thu,  4 Apr 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236561; cv=none; b=TC74HvwL7C1zTjUHigmnDLGFNORXD6+hVuLb9C7IkxFa4WJcLLOsVoaJSNwy2WRZOVQL9m5x31YLNk9vyfPKzWGZowIAPZT7KdkfEavdwzFKYcx7Tv5Z+O4XZztujVNDq5806+0Xd4shfy9yv91PNf6jyTkEJdZ93kFjwAOo2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236561; c=relaxed/simple;
	bh=/gCKA/oReueBMsYxeYFIKM9dWH0tB6N2OUmuLZEgT1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVEcywnIlsTRXYjtNYWgoEGMNye1E1x6sIUbs4BExZ4s14qOUR45Lr5FDPDEZ7xQwXkTR+kDK0bNj+PDmmW1t8nAaVQGNJCmMbAvlXwZ2LnJh6xZnfgO9JR0zasUQaAHd/Aj3ypCQj7Wdo5rtdVwI9e/PEJXdhV7ftHSxEz1FJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq4vWqDz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c11b6af9so1367757e87.2;
        Thu, 04 Apr 2024 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712236558; x=1712841358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FbFTfD/TvLUw6fU15r42KRVHlg7cUmb8nJYcUP4iv4=;
        b=Oq4vWqDzq+CIjmJddOh1qNEWdNUCysErHnKZRo44dje+w5uY/g56BN/KShvxrYfGY7
         vadOcy9ZyVm9tSCxpPBn64SL4fhsz3mW5DaOxzae+HeQ3FsF4dcO/A0peWrAHAU39Iu3
         cGszU+BhsSoI3hPXPhx1pMThe5A1rMaRP6OQZeq8PTYJ8SPl3PWBekTwgZp4itDgBQ3S
         yBC//TqUe5QoNaQ+uef6HMuLEBM6thT4fq8i7Dzd5hc/o+xJuDeQ8aBuGH/MkHhfktCB
         S5IJVEqSQZRKug4BPmvfrY1jskvlldToK6Hz2rpFHWfGQI6ueIWvgZDjHe+SMwAWHXmu
         ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236558; x=1712841358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FbFTfD/TvLUw6fU15r42KRVHlg7cUmb8nJYcUP4iv4=;
        b=oT4VK/dlOQgDIvkTHFUMsHwFzXGbGcF++N8WLqvsjqJdx+2OfbnjFmO9VfdLRrUvTs
         6BSV3hmRUicamY92ww0QhwByserpx4dWKFAdswy5MAWClopxQp+MZykdITbMsPq+1bXS
         ONrvuN4tUNBTilvZMo0WU2ZGwMDe+Qqwg4j9NR2dgeLEMBJ1aBroX2PDbyvMuuWIs/CD
         atS2gSaL6j9xK2YhFGJI68APtSIAm2ZNIIl+8ebM9asCReuMqljzVRwIQ4swa8EMo97f
         gewAL5V/Y41UcuXdGHRYOC3dc/Wfu0xkYuSh7lQHayx5tzqwLBBGqgPNg7+21Xr/i9za
         1I6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOJBHckdrPaTZ8sMpF4k6qm5mjl8vQnASLeqb89gSX74DAzZWTfa4Pt7TlltUeH3IyqhlbpSZLRje+FWfstgCcPN+cSzqx9lbCVGtCxsqowch1gDOC08f2+mpclxdMRwUVBG3jQAnhKeIi1yUdwW09e8H40Lu/iq4x27YlzofcL/Z07xnqWXeX
X-Gm-Message-State: AOJu0YwY1fhf2opnYDz+WZMyZMSVoRx3VpZFQr/PJanJuL2xAF0dCbLd
	2XnVwsDD3DTN/FveGWLA5ruvWBAYxPNfg7WllziPq7HNZwDhRXNj
X-Google-Smtp-Source: AGHT+IFpvBBKlDlenBy4zyj+4duAMba2fIxXc6gDdHoGF1BQpu9586dGzFH3NKdaIHnKmAo1FqvnfA==
X-Received: by 2002:ac2:51aa:0:b0:515:8bb2:72a2 with SMTP id f10-20020ac251aa000000b005158bb272a2mr1505812lfk.55.1712236557860;
        Thu, 04 Apr 2024 06:15:57 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2515b000000b00516c8e144adsm191259lfd.172.2024.04.04.06.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 06:15:57 -0700 (PDT)
Message-ID: <b6279be8-cf7d-4608-b556-3c01587f0d43@gmail.com>
Date: Thu, 4 Apr 2024 16:15:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Content-Language: en-US, en-GB
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
 <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 4/4/24 15:09, Mark Brown wrote:
> On Thu, Apr 04, 2024 at 10:26:34AM +0300, Matti Vaittinen wrote:
> 
>> 1. Should we be able to have more than 1 IRQ domain / device?
>> 2. Should regmap_irq support having more than 1 HWIRQ
> 
> I would expect each parent interrupt to show up as a separate remap_irq.
> 
>> then it seems that reading the IRQ information from the /proc/interrupts
>> works as expected. Here I am making a wild guess that the name of the domain
>> is used as a key for some data-lookups, and having two domains with a same
>> name will either overwrite something or cause wrong domain data to be
>> fetched. (This is just guessing for now).
> 
> So if we arrange to supply a name when we register multiple domains
> things should work fine?

Thanks for taking the time to look at my questions :)
I have been debugging this thing whole day today, without getting too 
far :) It seems there is something beyond the name collision though.

After I tried adding '-1' to the end of the other domain name to avoid 
the debugfs name collision I managed to do couple of successful runs - 
after which I reported here that problem seems to be just the naming. 
Soon after sending that mail I hit the oops again even though the naming 
was fixed.

Further debugging shows that the desc->action->name for the last 28 
'errb' IRQs get corrupted. This might point more to the IRQ requester 
side - so I need to further study the BD96801 driver side as well as the 
regulator_irq_helper. I'm having the creeping feeling that at the end of 
the day I need to find the guilty one from the mirror :)

But yes, creating 2 regmap-IRQ controllers for one device seems to 
generate naming conflict in the debugfs - so unless I'm mistaken, with 
the current regmap-IRQ we can't have more than 1 regmap-IRQ entity for a 
single device.

Just please give me some more time to see if I find the cause of the 
corruption and I hope I can write more concrete description. For now it 
was enough for me to hear having more than 1 IRQ domain / device is not 
something on the "DON'T DO THIS" -list.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


