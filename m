Return-Path: <linux-kernel+bounces-16637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6F8241AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE976B21E58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282DC224C9;
	Thu,  4 Jan 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBs3Y53E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F2224E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D39C433B6;
	Thu,  4 Jan 2024 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704370964;
	bh=n5fZPxMlYURf21Tg9Wf4ahvg+/HkJT7vhscIgcegP8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BBs3Y53E/UyLx9vNOph00dS4Hds/ICNbgR9p6NNbD+ByD2M9jix1ebUqkuvlOYwEK
	 an3acC87wlLCQvG0t7+jKclqSgdDKHIXBr4TlLYj5+qVCjQO5K96it3ejYZ1Yu2cDt
	 IklzOKO71zFz/IoQyM6VrcT0yObgBhM4ondW31Fdfa89uV33Y+1kG0PK90/mT1xw+7
	 4KESSZq49gzl2cUg31HnQrKj2DYjlwgGx7Z5880R/5c/Tekou61EWy76+XgYsq4Lve
	 Y81OMc2aQOII1AFEuXuuLLuDJKDEOxbOE9O/S83xduRhOk2Ajs9qfA/I8IW8k1YPt9
	 LYAt7Wo8AmtvA==
Message-ID: <7a873aea-f118-4dbf-9309-bffcd7317627@kernel.org>
Date: Thu, 4 Jan 2024 06:22:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] firmware: stratix10-rsu: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <06df45c697a747cb6543800a4613db6e1f5462b4.1703693980.git.u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <06df45c697a747cb6543800a4613db6e1f5462b4.1703693980.git.u.kleine-koenig@pengutronix.de>
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
>   drivers/firmware/stratix10-rsu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
> index 4f7a7abada48..e20cee9c2d32 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -793,17 +793,16 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int stratix10_rsu_remove(struct platform_device *pdev)
> +static void stratix10_rsu_remove(struct platform_device *pdev)
>   {
>   	struct stratix10_rsu_priv *priv = platform_get_drvdata(pdev);
>   
>   	stratix10_svc_free_channel(priv->chan);
> -	return 0;
>   }
>   
>   static struct platform_driver stratix10_rsu_driver = {
>   	.probe = stratix10_rsu_probe,
> -	.remove = stratix10_rsu_remove,
> +	.remove_new = stratix10_rsu_remove,
>   	.driver = {
>   		.name = "stratix10-rsu",
>   		.dev_groups = rsu_groups,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

