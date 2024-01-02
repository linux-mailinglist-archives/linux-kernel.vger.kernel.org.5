Return-Path: <linux-kernel+bounces-14781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDC822236
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3062846B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09E15EB9;
	Tue,  2 Jan 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9HQ7G7B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B315E96;
	Tue,  2 Jan 2024 19:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7BAC433C7;
	Tue,  2 Jan 2024 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704224537;
	bh=PaPzSK5xpA5yNPUsXf1i+zSw0U93BBhc+sQEbo5cMqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C9HQ7G7BFl5okQ2vuavV72FAxqlAyD0LjS6KZzt1xIePGgLnu4Zf1Bmci2e5M10JB
	 O664QYQcItyQjciCvh8Rua30UZNjlQhcBP9POS5Ez0MxapzHYC/dqxHhQBwoNieW+k
	 sOGyMUcuSGPKngPa826J1SRROqGJgLOLfsi7PtTqGw5HcuPTX386vSsIVlaqTtQ23y
	 YzQR9Q/QvAeKttcBxB4dCHR5+so/C+v+tbUr21WOeuyYt+ECxs1cFSBVeuNQEICzqx
	 yGKa0EBqF098KAGYmb29a2c/y5Yiizb4E///ml5bu1MA1f3TyK2O08448Rt8FDHBTJ
	 TWulcoLNQfktw==
Date: Tue, 2 Jan 2024 19:42:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: zhouzhouyi@gmail.com
Cc: songqiang1304521@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "zhili.liu" <zhili.liu@ucas.com.cn>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: add boundary check for
 the value read from RM3100_REG_TMRC
Message-ID: <20240102194209.39dac963@jic23-huawei>
In-Reply-To: <1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com>
References: <1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jan 2024 09:07:11 +0800
zhouzhouyi@gmail.com wrote:

> From: "zhili.liu" <zhili.liu@ucas.com.cn>
> 
> Recently, we encounter kernel crash in function rm3100_common_probe
> caused by out of bound access of array rm3100_samp_rates (because of
> underlying hardware failures). Add boundary check to prevent out of
> bound access.
> 
> Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Fixes is a formal tag so needs to be part of the main tags block
(i.e. No blank line here!)

I'll fix that whilst applying.

> 
> Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
> ---
>  drivers/iio/magnetometer/rm3100-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 69938204456f..12c2e3b0aeb6 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -530,6 +530,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	struct rm3100_data *data;
>  	unsigned int tmp;
>  	int ret;
> +	int samp_rate_index;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -586,8 +587,14 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
>  	if (ret < 0)
>  		return ret;
> +
> +	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
> +	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
> +		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
> +		return -EINVAL;
> +	}
>  	/* Initializing max wait time, which is double conversion time. */
> -	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
> +	data->conversion_time = rm3100_samp_rates[samp_rate_index][2]
>  				* 2;
I've rewrapped this to be on one line whilst applying. Make sure to check for
side effects like this when updating code.  If we don't tidy it up at the time
we end up with gradually worse formatting over a long period!

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>  
>  	/* Cycle count values may not be what we want. */


