Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B880BAA4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjLJMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:22:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444EFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:22:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDD5C433C8;
        Sun, 10 Dec 2023 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702210946;
        bh=soHpppCx2/0tcuziKrSgy12+x/XFsaso6RhP5ZsXMGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g7pb7o+TXb3k5qiipbQOoYvEPmYh4Nv7Y+N2wxjgjdXT8U+JIMUgKiLODex7rl9jv
         tNS2bupApGOy/Y6W1fi4d4RbletRkIp4bGLAaXr/djNWY+h64bGXB6411qYxwTI1Qn
         3VbjNjhTOgSjlEUJCdgK3K4lrlpa06s86pXXqIPeTonDijFqFFpIFUuK8olNHkggtP
         /5vLkrwPSxGtghhmYS8MNWWKPVgE4nG9/SCXD+ouwzeDS0B8KHZEnIwEfAKCrRFf7F
         vOU+jISiSDBoZvl3iETiFvOtsbXbdWmRQjHEjSHnNboEN0qtVNi9IMGHZbyfBGFaJf
         +Eiz2HedbvWdQ==
Date:   Sun, 10 Dec 2023 12:22:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/13] iio: adc: ad7091r: Enable internal vref if
 external vref is not supplied
Message-ID: <20231210122218.6c0c1d19@jic23-huawei>
In-Reply-To: <0c71001f4c1eba169230caee6640661cec4b979b.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
        <0c71001f4c1eba169230caee6640661cec4b979b.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 15:41:25 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADC needs a voltage reference to work correctly.
> Enable AD7091R internal voltage reference if no external vref is
> supplied.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad7091r-base.c | 9 ++++++---
>  drivers/iio/adc/ad7091r-base.h | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index f2cb638b8d77..59a7ec44955d 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -215,10 +215,13 @@ int ad7091r_probe(struct device *dev, const char *name,
>  	iio_dev->channels = st->chip_info->channels;
>  
>  	st->vref = devm_regulator_get_optional(dev, "vref");

This does not return NULL, only a valid regulator or an error code.

> -	if (IS_ERR(st->vref)) {
> -		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +	if (IS_ERR_OR_NULL(st->vref)) {

You still need to explicitly handle deferal here.
There might be a perfectly good regulator that just isn't ready yet and
if that happens we want to try probing this driver again later rather
than papering over it.


> +		/* Enable internal vref */
>  		st->vref = NULL;
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +					 AD7091R_REG_CONF_INT_VREF, BIT(0));
> +		if (ret)
> +			return ret;
>  	} else {
>  		ret = regulator_enable(st->vref);
>  		if (ret)
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 9546d0bf1da7..e153c2d7deb5 100644
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

