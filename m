Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3EF7ACB3D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjIXSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:08:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D937FC;
        Sun, 24 Sep 2023 11:08:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99DFC433C7;
        Sun, 24 Sep 2023 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695578927;
        bh=K4C1oC670Bkna/wZX45ZLW5pc06w+mKGafxBCZT2xhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGGzJDc+UD2YUnei689bIhBtleV0v+Oevaj3+4FoGhR7F7POp39qJ4IMFFGSgxEfN
         lq5w8DTRE/53V+bC9r/KRIszE3eNgIqfzyotwjUF6Z+oGz23IubZlOhrTt6b/YLqHt
         7Y0aKYBD/mlIYLnnSg6erpsqTuikjBBBtMm71OPXobLjDVxE9bqVwIoDU3xVYZQQKn
         x/LIo7YZ5dmlIBjeeL4HVmw1Zb02Bpc2tnGCTYYJih9g6i52C08/9VL1xWeRWgqWhc
         M6mqPVARrq0msc5ptj284DQkIPNPVGAgfgyUBZFlov/3RQmV2hViNRAgKW3OihTwfe
         YoMJ19x7j7yww==
Date:   Sun, 24 Sep 2023 19:08:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 14/19] staging: iio: resolver: ad2s1210: refactor
 setting excitation frequency
Message-ID: <20230924190839.4ecd918d@jic23-huawei>
In-Reply-To: <20230921144400.62380-15-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-15-dlechner@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 09:43:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This combines the ad2s1210_update_frequency_control_word() and
> ad2s1210_soft_reset() functions into a single function since they
> both have to be called together.
> 
> Also clean up a few things while touching this:
> - move AD2S1210_DEF_EXCIT macro with similar macros
> - remove unnecessary dev_err() calls
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>


Probably worth calling out that this reset doesn't touch config
registers (they normally do!) but instead resets the tracking logic.

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 63 ++++++++++++-------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index fe413759deb9..f1ffee34ebbc 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -53,12 +53,11 @@
>  #define AD2S1210_MIN_CLKIN	6144000
>  #define AD2S1210_MAX_CLKIN	10240000
>  #define AD2S1210_MIN_EXCIT	2000
> +#define AD2S1210_DEF_EXCIT	10000
>  #define AD2S1210_MAX_EXCIT	20000
>  #define AD2S1210_MIN_FCW	0x4
>  #define AD2S1210_MAX_FCW	0x50
>  
> -#define AD2S1210_DEF_EXCIT	10000
> -
>  enum ad2s1210_mode {
>  	MOD_POS = 0b00,
>  	MOD_VEL = 0b01,
> @@ -184,18 +183,29 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
>  	return 0;
>  }
>  
> -static inline
> -int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
> +/*
> + * Sets the excitation frequency and performs software reset.
> + *
> + * Must be called with lock held.
> + */
> +static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
> +					     u16 fexcit)
>  {
> -	unsigned char fcw;
> +	int ret;
> +	u8 fcw;
>  
> -	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
> -	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
> -		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
> +	fcw = fexcit * (1 << 15) / st->fclkin;
> +	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW)
>  		return -ERANGE;
> -	}
>  
> -	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
> +	ret = regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->fexcit = fexcit;
> +
> +	/* software reset reinitializes the excitation frequency output */
> +	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
>  }
>  
>  static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
> @@ -210,11 +220,6 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
>  				     bitmap);
>  }
>  
> -static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> -{
> -	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
> -}
> -
>  static ssize_t ad2s1210_show_fexcit(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> @@ -229,27 +234,24 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
>  				     const char *buf, size_t len)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned int fexcit;
> +	u16 fexcit;
>  	int ret;
>  
> -	ret = kstrtouint(buf, 10, &fexcit);
> -	if (ret < 0)
> -		return ret;
> -	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
> -		dev_err(dev,
> -			"ad2s1210: excitation frequency out of range\n");
> +	ret = kstrtou16(buf, 10, &fexcit);
> +	if (ret < 0 || fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT)
>  		return -EINVAL;
> -	}
> +
>  	mutex_lock(&st->lock);
> -	st->fexcit = fexcit;
> -	ret = ad2s1210_update_frequency_control_word(st);
> +	ret = ad2s1210_set_excitation_frequency(st, fexcit);
>  	if (ret < 0)
>  		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> +
> +	ret = len;
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  
> -	return ret < 0 ? ret : len;
> +	return ret;
>  }
>  
>  static ssize_t ad2s1210_show_resolution(struct device *dev,
> @@ -624,10 +626,8 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	ret = ad2s1210_update_frequency_control_word(st);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> +	ret = ad2s1210_set_excitation_frequency(st, AD2S1210_DEF_EXCIT);
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  	return ret;
> @@ -773,7 +773,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
>  	st->resolution = 12;
> -	st->fexcit = AD2S1210_DEF_EXCIT;
>  
>  	ret = ad2s1210_setup_clocks(st);
>  	if (ret < 0)

