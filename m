Return-Path: <linux-kernel+bounces-2656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB106816006
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C19281188
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7B44C82;
	Sun, 17 Dec 2023 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY6aIoJ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA49A1EB25;
	Sun, 17 Dec 2023 14:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30F6C433C8;
	Sun, 17 Dec 2023 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824975;
	bh=Sa7R+X1/EuMXebA+/AwvMnTGgalQNlLpxvYlZlFQHIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RY6aIoJ9vR9NqPf9flT5HEsl8rVfyV7RHQQ80DwaosA0/VvnLWH6010xqUCdqngZB
	 P5uFGXl3OcKl+yLxK9HKCGhm6GCMhuVGmfryUCtGMhu83XdqGVLQbjCY/oAs5uiTO5
	 IvX6oi2xcmSw0T7241DoUKrxGvAqf0NnRx3O7LdbIAxt1lf9HP3nfampD1+CC38EPp
	 03nvUsEkz7dq5N8CwILYH670JKPCnIA4H8v8dRPGEcsF1brLyGWclH6cA/1GMx3fpu
	 01vJXzO+kfltMK2YKLsiNR2xJWgVtVIR8+hPyoFHLe5Sl2kst2dbSNmdRniEaX+zas
	 Lt1yBNou1wg8A==
Date: Sun, 17 Dec 2023 14:55:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/15] iio: adc: ad7091r: Set alert bit in config
 register
Message-ID: <20231217145557.36d6a738@jic23-huawei>
In-Reply-To: <e8da2ee98d6df88318b14baf3dc9630e20218418.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<e8da2ee98d6df88318b14baf3dc9630e20218418.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:46:37 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ad7091r-base driver sets up an interrupt handler for firing events
> when inputs are either above or below a certain threshold.
> However, for the interrupt signal to come from the device it must be
> configured to enable the ALERT/BUSY/GPO pin to be used as ALERT, which
> was not being done until now.
> Enable interrupt signals on the ALERT/BUSY/GPO pin by setting the proper
> bit in the configuration register.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

In V3 review I asked if this should have a fixes tag.  I've assumed for now
the answer is no and applied it without.  If you let me know fast enough
I can probably slip on in, but if not you may want to consider requesting
a backport after this is upstream.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7091r-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 0e5d3d2e9c98..8aaa854f816f 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -28,6 +28,7 @@
>  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
>  
>  /* AD7091R_REG_CONF */
> +#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
>  #define AD7091R_REG_CONF_AUTO   BIT(8)
>  #define AD7091R_REG_CONF_CMD    BIT(10)
>  
> @@ -232,6 +233,11 @@ int ad7091r_probe(struct device *dev, const char *name,
>  	iio_dev->channels = chip_info->channels;
>  
>  	if (irq) {
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
> +		if (ret)
> +			return ret;
> +
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  				ad7091r_event_handler,
>  				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);


