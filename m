Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8387B4173
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjI3PGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjI3PGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:06:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7037E92;
        Sat, 30 Sep 2023 08:06:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C451AC433C8;
        Sat, 30 Sep 2023 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696086364;
        bh=wnkyExyaG21DXgTSmLw5ySjs4l/o+ms9WJYMq4obo0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ktwi0N+7iaRVmKSObmzkW5wQR8IqI+uNHAq1oMq9UY14r2Xuh+LSoRwRcB9e6eDd7
         Q4vzHRNqY0nNA6NKQPXzeUKgbxu8VpbW1R73WFkaRyUTsRqdvkcslzBtN2SJ18bucP
         pWzbnxFowx5waETeQ6aU8SLZPhSdHyQ8n5fksfMdOTz03+sQYJngGJxSwQ5pM05pzp
         HbTwE+PgvwtlIFOWFTNGG17whQJ6iD03kV4Jij046ZirNapaPBWp51prsu79mcDYN0
         UySxvGCjkFndsec2Tbp+jbFNntHC+ahuxzjN7QTUyRp6zn68m76g2sAswxjTngqEtE
         Z5q6nK0OZDZzg==
Date:   Sat, 30 Sep 2023 16:06:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/27] staging: iio: resolver: ad2s1210: refactor
 setting excitation frequency
Message-ID: <20230930160603.08b01a33@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-15-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-15-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This combines the ad2s1210_update_frequency_control_word() and
> ad2s1210_soft_reset() functions into a single function since they
> both have to be called together. (The software reset does not reset
> any configuration registers, it only updates the excitation output
> and resets the tracking loop.)
> 
> Also clean up a few things while touching this:
> - move AD2S1210_DEF_EXCIT macro with similar macros
> - remove unnecessary dev_err() calls
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I'm sure it'll will stop me at some point but I'll keep trying to apply
patches even though I skipped previous one on basis the fewer I see
again, the less terrifying my inbox looks :)

So applied this one and pushed out as testing. Bit of fuzz as you'd expect.

Thanks,

Jonathan

> ---
> 
> v3 changes:
> * Expanded comment on soft reset register write.
> * Fixed multiline comment style.
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 66 +++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index a82cb124a12f..28ab877e1bc0 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -51,12 +51,11 @@
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
> @@ -188,18 +187,32 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
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
> +static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
> +						u16 fexcit)
>  {
> -	unsigned char fcw;
> +	int ret;
> +	u8 fcw;
>  
> -	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->clkin_hz);
> -	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
> -		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
> +	fcw = fexcit * (1 << 15) / st->clkin_hz;
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
> +	/*
> +	 * Software reset reinitializes the excitation frequency output.
> +	 * It does not reset any of the configuration registers.
> +	 */
> +	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
>  }
>  
>  static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
> @@ -214,11 +227,6 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
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
> @@ -233,27 +241,24 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
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
> +	ret = ad2s1210_reinit_excitation_frequency(st, fexcit);
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
> @@ -630,10 +635,8 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	ret = ad2s1210_update_frequency_control_word(st);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> +	ret = ad2s1210_reinit_excitation_frequency(st, AD2S1210_DEF_EXCIT);
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  	return ret;
> @@ -778,7 +781,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
>  	st->resolution = 12;
> -	st->fexcit = AD2S1210_DEF_EXCIT;
>  
>  	ret = ad2s1210_setup_clocks(st);
>  	if (ret < 0)
> 

