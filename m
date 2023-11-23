Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7797F63FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKWQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjKWQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:32:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD719D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:32:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE75C433CA;
        Thu, 23 Nov 2023 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700757178;
        bh=zPsWJqwWfxO0CDcsvsukWva+BtzQ1ZCrq2r/akLCBZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp8HVRI2nXh8VRvYSc8w+8dzmeXhxL4Tbf+eBzAD3HEbXSqqs98sOGZu7Z/z2pg2L
         B5e28h98kmeR/vEiT3h6sXQrbEYvV11yv7m3QzetjHAYwBxgLSJ4B+R2rQBUQI31NL
         Pm5jGYRsV0HCRWbEqSlC39nFo+Ucmvi4wipFETCueJnGlUGmkZ22lCimBzAkAO/vFR
         YFU6yQ+VNld+zrcOw+ncnMYnZTCnRyzERR6IOKJ6j99PAj1Bw0vGWRZU5IzSIfPosv
         s/gvX9Qd3PalXHIHPOW9e/Fn1m6JmSFWvYrfjt6blIFmaYyRo0gou1YZXonCvNkzC5
         1BVpsaTatdjMw==
Date:   Thu, 23 Nov 2023 16:32:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 04/11] leds: aw200xx: calculate dts property
 display_rows in the driver
Message-ID: <20231123163252.GF1354538@google.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-5-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121202835.28152-5-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Dmitry Rokosov wrote:

> From: George Stark <gnstark@salutedevices.com>
> 
> Get rid of device tree property "awinic,display-rows". The property
> value actually means number of current switches and depends on how leds

Nit: LEDs

> are connected to the device. It should be calculated manually by max
> used led number. In the same way it is computed automatically now.

As above - I won't mention this again.

> Max used led is taken from led definition subnodes.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/leds/leds-aw200xx.c | 39 +++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index 7762b3a132ac..4bce5e7381c0 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -379,6 +379,30 @@ static void aw200xx_disable(const struct aw200xx *const chip)
>  	return gpiod_set_value_cansleep(chip->hwen, 0);
>  }
>  
> +static bool aw200xx_probe_get_display_rows(struct device *dev, struct aw200xx *chip)
> +{
> +	struct fwnode_handle *child;
> +	u32 max_source = 0;
> +
> +	device_for_each_child_node(dev, child) {
> +		u32 source;
> +		int ret;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &source);
> +		if (ret || source >= chip->cdef->channels)

Shouldn't the second clause fail instantly?

> +			continue;
> +
> +		max_source = max(max_source, source);
> +	}
> +
> +	if (!max_source)

Since max_source is an integer, please use an '== 0' comparison.

> +		return false;
> +
> +	chip->display_rows = max_source / chip->cdef->display_size_columns + 1;
> +
> +	return true;
> +}
> +
>  static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
>  {
>  	struct fwnode_handle *child;
> @@ -386,18 +410,9 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
>  	int ret;
>  	int i;
>  
> -	ret = device_property_read_u32(dev, "awinic,display-rows",
> -				       &chip->display_rows);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to read 'display-rows' property\n");
> -
> -	if (!chip->display_rows ||
> -	    chip->display_rows > chip->cdef->display_size_rows_max) {
> -		return dev_err_probe(dev, ret,
> -				     "Invalid leds display size %u\n",
> -				     chip->display_rows);
> -	}
> +	if (!aw200xx_probe_get_display_rows(dev, chip))

Function calls in side if() statements in general is rough.

Please break it out and use 'ret' as we usually do.

> +		return dev_err_probe(dev, -EINVAL,

Make this the return value from aw200xx_probe_get_display_rows() and use
'ret' instead.

> +				     "No valid led definitions found\n");
>  
>  	current_max = aw200xx_imax_from_global(chip, AW200XX_IMAX_MAX_uA);
>  	current_min = aw200xx_imax_from_global(chip, AW200XX_IMAX_MIN_uA);
> -- 
> 2.36.0
> 

-- 
Lee Jones [李琼斯]
