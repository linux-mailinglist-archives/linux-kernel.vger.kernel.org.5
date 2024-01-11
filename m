Return-Path: <linux-kernel+bounces-23115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC782A7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1603282A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2415663;
	Thu, 11 Jan 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5unuc2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CE46B1;
	Thu, 11 Jan 2024 06:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7C7C43390;
	Thu, 11 Jan 2024 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704955749;
	bh=r1x+We+0nH/taygFxjUmf5m8A7mmAiVByiI7VPe83PA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5unuc2p/3gwIMkXAMpmy5JjoSpUscszCoBNgIdTdVhTazeXw/WldvE3kTtNo5Nku
	 TZ289TAgbABfTp7yE84kSh3ZGGYW2CNLLbzFeVI+pXaaSaDxCydcZCVydGs2aTd1+R
	 oBBZRz0wuWTxEzScYTTg4bqVC9OvrRWzyb13EsZHYB8fRI5BofGnYHj4IuSiUnlEsU
	 a2VwpIPLF0a7CFlB4g3W1jDxalW5uXkgb7i7wTJt76D3zy8bcP6VFDR6htZJSRRVeB
	 x6zR20wfo4lqcI7pl3egI+HARXxi6s29lqYA3GPj2N6NjGaLXMZqCyB/n+j/EsRA9k
	 FnR3LppzWzk4Q==
Date: Thu, 11 Jan 2024 07:49:05 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: em28xx: return error on media_device_register()
 failure
Message-ID: <20240111074905.67d61b00@coco.lan>
In-Reply-To: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
References: <20240110173958.4544-1-n.zhandarovich@fintech.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 10 Jan 2024 09:39:58 -0800
Nikita Zhandarovich <n.zhandarovich@fintech.ru> escreveu:

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
>  drivers/media/usb/em28xx/em28xx-cards.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> index 4d037c92af7c..dae731dfc569 100644
> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> @@ -4095,6 +4095,8 @@ static int em28xx_usb_probe(struct usb_interface *intf,
>  	 */
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	retval = media_device_register(dev->media_dev);
> +	if (retval)
> +		goto err_free;

Not freeing resources here is intentional. See, the media controller 
API is optional on this driver. It will just provide a way to identify
the device's topology, but the device is completely usable without
it.

Perhaps we need, instead, a patch documenting it, and preventing
static analysis tools to point it as an issue.

Thanks,
Mauro

