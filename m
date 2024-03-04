Return-Path: <linux-kernel+bounces-91310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221E870D25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1722B1F23D77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C57BB02;
	Mon,  4 Mar 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="shCCcZWF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549E7BAE6;
	Mon,  4 Mar 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587866; cv=none; b=ISwFeL1Yrzzir7iq55gERGe+bHux5gbdwTZAXN3oUoLVsm2A5YYRn2H0Noh3ZxYVZ4nKnQLoBLiK21PvmoY0pPJCxRHnz5DsUsQBbk4ZTNsXQbqUNWXdK26SSBDI0F8Knf7U0o2FAFyaT+LWYER4UHEHpjVh6V+GSeegooLZAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587866; c=relaxed/simple;
	bh=M9ya6bkKPebgsSfZTJFdkZYGyMKRaZjpH8OWyDkP1ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjvmNQ0gbERrpDuDZG0jOl+IO1QH96kFe9lbpK/6Ajytrtu5oNMJCqa/Hxre+tO/QwvWzKdFmTTGupFp7ZPAvjGCzY4l+/NQRxdu526PuQAn7QaLq22IrV35TrTNVjwsaEWeBBRfxwrwmL2J6TLf5e8qqBSszXDKwP8ney2NqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=shCCcZWF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 916931FB2;
	Mon,  4 Mar 2024 22:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709587845;
	bh=M9ya6bkKPebgsSfZTJFdkZYGyMKRaZjpH8OWyDkP1ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shCCcZWFR+XUgZA8RLUJFALUMKx4UaAhW9PSPCNCQhzKUcKtLEWW5qLOoxosFD0vn
	 hqssrHbEpfQt6J03DbAnHCXDbL4rI6M+Q1nLaKpT82+KeJGCcGZLMVhwAicRD3jzYi
	 UxxiJIcAmVkXWZ8A/1oHYX19q3L0XS4jJujLKVok=
Date: Mon, 4 Mar 2024 23:31:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v3 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Message-ID: <20240304213103.GA3239@pendragon.ideasonboard.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
 <20240229165333.227484-20-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229165333.227484-20-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Thu, Feb 29, 2024 at 07:53:32PM +0300, Mikhail Rudenko wrote:
> Split ov4689_s_stream into __ov4689_stream_on and __ov4689_stream_off
> functions. Also remove repetitive pm_runtime_put calls and call
> pm_runtime_put once at the end of the __ov4689_stream_off function if
> any error occurred.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 100 ++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 2496067b90a0..5cea9b5ba201 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -537,61 +537,67 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
>  	return ret;
>  }
>  
> +static int __ov4689_stream_on(struct ov4689 *ov4689,

No need for the __ prefix. Same for __ov4689_stream_off().

> +			      struct v4l2_subdev_state *sd_state)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(ov4689->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cci_multi_reg_write(ov4689->regmap, ov4689_common_regs,
> +				  ARRAY_SIZE(ov4689_common_regs), NULL);
> +	if (ret)
> +		goto cleanup_pm;
> +
> +	ret = ov4689_setup_timings(ov4689, sd_state);
> +	if (ret)
> +		goto cleanup_pm;
> +
> +	ret = ov4689_setup_blc_anchors(ov4689, sd_state);
> +	if (ret)
> +		goto cleanup_pm;
> +
> +	ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
> +	if (ret)
> +		goto cleanup_pm;
> +
> +	ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> +			OV4689_MODE_STREAMING, NULL);
> +	if (ret)
> +		goto cleanup_pm;
> +
> +	return 0;
> +
> + cleanup_pm:

No space before the label. I would also name it just "error".

With those small changes,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	pm_runtime_put(ov4689->dev);
> +	return ret;
> +}
> +
> +static int __ov4689_stream_off(struct ov4689 *ov4689)
> +{
> +	cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE, OV4689_MODE_SW_STANDBY,
> +		  NULL);
> +	pm_runtime_mark_last_busy(ov4689->dev);
> +	pm_runtime_put_autosuspend(ov4689->dev);
> +
> +	return 0;
> +}
> +
>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  {
>  	struct ov4689 *ov4689 = to_ov4689(sd);
>  	struct v4l2_subdev_state *sd_state;
> -	struct device *dev = ov4689->dev;
> -	int ret = 0;
> +	int ret;
>  
>  	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -		if (ret < 0)
> -			goto unlock_and_return;
> -
> -		ret = cci_multi_reg_write(ov4689->regmap,
> -					  ov4689_common_regs,
> -					  ARRAY_SIZE(ov4689_common_regs),
> -					  NULL);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> -
> -		ret = ov4689_setup_timings(ov4689, sd_state);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> -
> -		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> -
> -		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> -
> -		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> -				OV4689_MODE_STREAMING, NULL);
> -		if (ret) {
> -			pm_runtime_put(dev);
> -			goto unlock_and_return;
> -		}
> -	} else {
> -		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
> -			  OV4689_MODE_SW_STANDBY, NULL);
> -		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		ret = __ov4689_stream_on(ov4689, sd_state);
> +	else
> +		ret = __ov4689_stream_off(ov4689);
>  
> -unlock_and_return:
>  	v4l2_subdev_unlock_state(sd_state);
>  
>  	return ret;

-- 
Regards,

Laurent Pinchart

