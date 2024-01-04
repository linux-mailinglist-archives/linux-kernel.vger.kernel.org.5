Return-Path: <linux-kernel+bounces-16638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424408241B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD6E286102
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B70225D2;
	Thu,  4 Jan 2024 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6CtpzgY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA480225AF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156B5C433C7;
	Thu,  4 Jan 2024 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704370973;
	bh=tnsTGxjomhIrnB3BnUgfs/p8K5ZjHkHT6ioMQvM9KRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d6CtpzgY+Ll4YTDyRczpFqx71h8N1oJ8wPHn5Qy4hd63j/O28c4vHxBg7/gMfTmiX
	 KlITUW+Zuf8CtcDsO3hnKOXiFVltB0Anjs1pEGKJa/ePlp+3J25DuWDF9hdnWgf3Kq
	 DSybo3EZdwd89cUeYZnYJneAo34IUqqO/FM2lxTZ0/PURWEuSt850n9ZUAMC29NGJc
	 lpDyTnCMPgusz4o2OvM5wrg4vmoFPCk5vPCPI9Jh9uts4PXwmIR5EmI4aiU/RfX52Q
	 3p48grv63KZDILeYoDnEUrc+LXjU/3rOy2Q9O7XK5JfZnlornYuK0qwnlnKuDk5Uur
	 NLUxrCx78lu9Q==
Message-ID: <a041b9a4-213f-47ae-ad33-6152213ad376@kernel.org>
Date: Thu, 4 Jan 2024 06:22:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] firmware: stratix10-svc: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <e574041cdce2e4e69f729dfa726a6d090762cff9.1703693980.git.u.kleine-koenig@pengutronix.de>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <e574041cdce2e4e69f729dfa726a6d090762cff9.1703693980.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/27/23 10:26, Uwe Kleine-König wrote:
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
>   drivers/firmware/stratix10-svc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index c693da60e9a9..528f37417aea 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1251,7 +1251,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int stratix10_svc_drv_remove(struct platform_device *pdev)
> +static void stratix10_svc_drv_remove(struct platform_device *pdev)
>   {
>   	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
>   	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
> @@ -1267,13 +1267,11 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
>   	if (ctrl->genpool)
>   		gen_pool_destroy(ctrl->genpool);
>   	list_del(&ctrl->node);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver stratix10_svc_driver = {
>   	.probe = stratix10_svc_drv_probe,
> -	.remove = stratix10_svc_drv_remove,
> +	.remove_new = stratix10_svc_drv_remove,
>   	.driver = {
>   		.name = "stratix10-svc",
>   		.of_match_table = stratix10_svc_drv_match,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

