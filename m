Return-Path: <linux-kernel+bounces-22647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927682A0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA01C229E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436244E1C1;
	Wed, 10 Jan 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cmX0CTeX"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC64E1BF;
	Wed, 10 Jan 2024 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Ne3HrzATcfp3nNe3Hr24kC; Wed, 10 Jan 2024 20:15:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704914148;
	bh=g7+iuuMcNhBZIQyGCPwUwqPwuUSKEMctp/ieQIw+e7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cmX0CTeXCCRTdtzv+RKWgeYEugEN2wV4ltK8UvEFX2/D3Jtq0K+opz+P6jD+eJzx4
	 VRiCT44gsJxbEdMCvhuibMaKeg5HCQ39/qRw/tK8OqqacAkIqBXhcM0w5jviHJDEt5
	 vPcMOXNSB9BAUgvctpp/C+eLD4hFxCw4JWx186OGICsLAS9uumct2PZ8dHH01TAJ+P
	 rJMUMrpbYBTxCAkPTn/KPcQH9bxfjtqD0YKzFO0EbsJo28WG7BzewKJnntmR9ErLVO
	 cP3HkdhnGeOluzXf2fPbNLsdyvxpVw3kWr2V0bYl9ZBexoE+oqiVWOeXWIDUkxIpG2
	 gdOwbk0VytOUw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 10 Jan 2024 20:15:48 +0100
X-ME-IP: 92.140.202.140
Message-ID: <6a9e7d6d-2054-45da-943f-e95bc6261c42@wanadoo.fr>
Date: Wed, 10 Jan 2024 20:15:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: em28xx: return error on media_device_register()
 failure
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/01/2024 à 18:39, Nikita Zhandarovich a écrit :
> In an unlikely case of failure in media_device_register(), release
> resources and return the erroneous value. Otherwise, possible issues
> with registering the device will continue to be ignored.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>   drivers/media/usb/em28xx/em28xx-cards.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> index 4d037c92af7c..dae731dfc569 100644
> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> @@ -4095,6 +4095,8 @@ static int em28xx_usb_probe(struct usb_interface *intf,
>   	 */
>   #ifdef CONFIG_MEDIA_CONTROLLER
>   	retval = media_device_register(dev->media_dev);
> +	if (retval)
> +		goto err_free;
>   #endif
>   
>   	return 0;
> 
> 
Hi,

I think that some resources allocated in em28xx_init_dev() should also 
be freed if media_device_register() fails. (see the error handling path 
at the end of em28xx_init_dev())

Just my 2c.

CJ

