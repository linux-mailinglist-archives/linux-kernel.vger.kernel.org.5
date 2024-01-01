Return-Path: <linux-kernel+bounces-13922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC48214E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9B7B20D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40EBA35;
	Mon,  1 Jan 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfxGlA1y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4FB8F6E;
	Mon,  1 Jan 2024 18:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A75FC433C8;
	Mon,  1 Jan 2024 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704132355;
	bh=+cCe5o3RRCYAMqeKsVmrT8NhuMZxadYYIe3PASgNwg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfxGlA1yXV18HvyP44JXFlAiWbAt4VR9PcGCJokRXAhdpXKMjdMOpO7QKA3hWXwM+
	 h/gxKtSzLK8awgjdYs3iUWD7IshU9fhm4/GoqDDVKJuJH++yb2CXLWF15V8BsepN7/
	 EnBmbCZS8orVO2L2GIU2Gds/tQkuCdo6Tp+8ePkHch/trW5hvORM9FYB5F0Jb2IEZd
	 Gsl4c/P5E0UDHz0Lh5donS3YaSWewoXXiJ5MNz0N3cp0W8ZCSVCGPZcbBMoA91nOBV
	 GY1wAJooRnw8ziJFoJGzAVuhSRjBgc1wN9vdh/UHEqglmvNDKed0JVAh2LkK5aDvxV
	 n3EV0EJ47ahHQ==
Date: Mon, 1 Jan 2024 18:05:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: zhouzhouyi@gmail.com
Cc: songqiang1304521@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "zhili.liu" <zhili.liu@ucas.com.cn>
Subject: Re: [PATCH v2] iio: magnetometer: rm3100: add boundary check for
 the value read from RM3100_REG_TMRC
Message-ID: <20240101180549.1be7e6de@jic23-huawei>
In-Reply-To: <1704034604-9846-1-git-send-email-zhouzhouyi@gmail.com>
References: <1704034604-9846-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Dec 2023 22:56:44 +0800
zhouzhouyi@gmail.com wrote:

> From: "zhili.liu" <zhili.liu@ucas.com.cn>
> 
> Recently, we encounter kernel crash in function rm3100_common_probe
> caused by out of bound access of array rm3100_samp_rates (because of
> underlying hardware failures). Add boundary check to prevent out of
> bound access.
> 
> Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
Please provide a Fixes tag so we know how far back to backport this.

Seems like a reasonable bit of hardening against potential hardware issues.
However it would be cleaner with a local variable used for the index.
See inline.


Jonathan

> ---
> The format of the previous patch was a bit problematic,
> we are sending it again.
> 
> Sorry for the trouble.
> 
> Thank you very much.
> --
>  drivers/iio/magnetometer/rm3100-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 69938204456f..fc50b6d4a334 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -586,6 +586,12 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
>  	if (ret < 0)
>  		return ret;
> +
> +	if (tmp < RM3100_SAMP_NUM || tmp - RM3100_TMRC_OFFSET >= RM3100_SAMP_NUM) {
Just a local variable of
int samp_rate_index = tmp - RM3100_TMRC_OFFSET;
Check that for negative or >=  RM3100_SAMP_NUM 
> +		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
> +		return -EINVAL;
> +	}
> +
>  	/* Initializing max wait time, which is double conversion time. */
>  	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
>  				* 2;


