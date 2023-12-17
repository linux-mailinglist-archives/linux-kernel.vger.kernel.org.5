Return-Path: <linux-kernel+bounces-2670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5A816038
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CFCB217E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAD44C97;
	Sun, 17 Dec 2023 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmwGWyMD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5044C94;
	Sun, 17 Dec 2023 15:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8689C433C8;
	Sun, 17 Dec 2023 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702827720;
	bh=ovab6ORHF0GtuIwBZlj2200LHMco9SKl/almTH+DVgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmwGWyMDgARtHTMkR6oPbxcnyLG2zhtQfT1hT1yf7H/tOILSiYNzQrsFUybheJfrB
	 Od46St3/xSi/NbBp3w60WeUTZGUFB2+AEd9WUFUdUSITyNjOjSNPFtlFcp2l+pJjgF
	 3dJg7yiXMoG1v/gDoxoYtulL406XiPTCgkIL8OZTHqIpZepwW0Gjzre8db4qokahxR
	 Mv3p1SjuFIaH0uPiBTIa7po/jcaBpusHCflyUw0MQIA+Kky/KgV1efr5uE7EDfN2dx
	 mabIectN6VR7HAfP/zvhnUM+Ssgg9shrFQ2kyGCfZS5U5BYZ0fJOf8/LIDKR/68DAZ
	 kRYDtE9FkyIwg==
Date: Sun, 17 Dec 2023 15:41:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/15] iio: adc: ad7091r: Enable internal vref if
 external vref is not supplied
Message-ID: <20231217154142.191ba69b@jic23-huawei>
In-Reply-To: <ce92ae93b1c2e36b20a9881b145c8c2c85acb1dd.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<ce92ae93b1c2e36b20a9881b145c8c2c85acb1dd.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:49:07 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADC needs a voltage reference to work correctly.
> Enable AD7091R internal voltage reference if no external vref is supplied.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
This one sounds to me like it should have a fixes tag and be
much earlier in the set to perhaps simplify backports.

Jonathan

> ---
>  drivers/iio/adc/ad7091r-base.c | 7 +++++++
>  drivers/iio/adc/ad7091r-base.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index aead72ef55b6..9d0b489966f5 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -217,7 +217,14 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
>  	if (IS_ERR(st->vref)) {
>  		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> +
>  		st->vref = NULL;
> +		/* Enable internal vref */
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_INT_VREF, BIT(0));
> +		if (ret)
> +			return dev_err_probe(st->dev, ret,
> +					     "Error on enable internal reference\n");
>  	} else {
>  		ret = regulator_enable(st->vref);
>  		if (ret)
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 81b8a4bbb929..9cfb362a00a4 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -20,6 +20,7 @@
>  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
>  
>  /* AD7091R_REG_CONF */
> +#define AD7091R_REG_CONF_INT_VREF	BIT(0)
>  #define AD7091R_REG_CONF_ALERT_EN	BIT(4)
>  #define AD7091R_REG_CONF_AUTO		BIT(8)
>  #define AD7091R_REG_CONF_CMD		BIT(10)


