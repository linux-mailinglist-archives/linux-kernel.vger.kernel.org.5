Return-Path: <linux-kernel+bounces-23770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A482B175
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FF91C24A49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCE4CB25;
	Thu, 11 Jan 2024 15:10:19 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F822074;
	Thu, 11 Jan 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 11 Jan
 2024 18:10:11 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 11 Jan
 2024 18:10:10 +0300
Message-ID: <b7ca60c4-2392-448e-90e4-5078051d7af6@fintech.ru>
Date: Thu, 11 Jan 2024 07:10:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: em28xx: return error on media_device_register()
 failure
To: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
 <20240111074905.67d61b00@coco.lan>
Content-Language: en-US
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <20240111074905.67d61b00@coco.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)


On 1/10/24 22:49, Mauro Carvalho Chehab wrote:
> Em Wed, 10 Jan 2024 09:39:58 -0800
> Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:
> 
>> In an unlikely case of failure in media_device_register(), release
>> resources and return the erroneous value. Otherwise, possible issues
>> with registering the device will continue to be ignored.
>>
>> Found by Linux Verification Center (linuxtesting.org) with static
>> analysis tool SVACE.
>>
>> Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>  drivers/media/usb/em28xx/em28xx-cards.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
>> index 4d037c92af7c..dae731dfc569 100644
>> --- a/drivers/media/usb/em28xx/em28xx-cards.c
>> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
>> @@ -4095,6 +4095,8 @@ static int em28xx_usb_probe(struct usb_interface *intf,
>>  	 */
>>  #ifdef CONFIG_MEDIA_CONTROLLER
>>  	retval = media_device_register(dev->media_dev);
>> +	if (retval)
>> +		goto err_free;
> 
> Not freeing resources here is intentional. See, the media controller 
> API is optional on this driver. It will just provide a way to identify
> the device's topology, but the device is completely usable without
> it.
> 
> Perhaps we need, instead, a patch documenting it, and preventing
> static analysis tools to point it as an issue.
> 
> Thanks,
> Mauro

Thank you for your feedback, however I had a few questions...

While I understand what you mean about optional nature of media
controller registration in this case, a quick glance into other calls to
media_device_register() across the source code shows that usually
failure with registering is handled as a proper error regardless of
whether the device is still usable. But if you think that we can make an
exception here, I'll happily oblige.

Then if I am to continue on this path, would the following comment above
the call to media_device_register() suffice?

 #ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * No need to check the return value, the device will still be 	     +
 * usable without media controller API.
+	 */
 	retval = media_device_register(dev->media_dev);

Thanks,
Nikita

