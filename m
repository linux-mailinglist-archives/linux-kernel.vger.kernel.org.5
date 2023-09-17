Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974BE7A34FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjIQJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIQJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A1E136;
        Sun, 17 Sep 2023 02:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA461C433C7;
        Sun, 17 Sep 2023 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694943966;
        bh=PRQTZ74W76qbT/4zBV5XcHZim2Zv3vF4LRiK4mfC6hU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=km9vOKMZmfeau6aTEJOVYFQMTKkS4C4p5iSqN03HSsnpGHGpG2ur2Y0Uy85Yz5HQF
         6u7IroTigKvEhenzzALBv9VCcE1XU3Zha3vByBlSbUDK5bJgYBT8gJFdoMCc2PFGue
         /L3fthrl2leKPJvXqIpXv0HtS8lyRS6ZLOhCXGTobl3DKdlnhoX+GlxWE1CxF9O0ER
         Vq8mFapLb/fQ9sF3rdBeCZUw7FQ6cei4X2CTkH5JFidEncy/hWjgTmBforG6mqlgLb
         ywGPy/NW6WUELFKAnMoy3NiR9xs5ZFJbRD4pvE8ipsYmd3CN9xvR6AXlzf91LoWvCA
         G17cXjI3aLJJQ==
Date:   Sun, 17 Sep 2023 10:45:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <20230917104558.19179dbc@jic23-huawei>
In-Reply-To: <9c550fb28e34915d473e379f812c7753f7643bae.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
        <9c550fb28e34915d473e379f812c7753f7643bae.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2023 14:38:52 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.
> Implement the function as a callback in the device-specific chip_info structure
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>


>  const struct kx022a_chip_info kx022a_chip_info = {
> -	.name		  = "kx022-accel",
> -	.regmap_config	  = &kx022a_regmap_config,
> -	.channels	  = kx022a_channels,
> -	.num_channels	  = ARRAY_SIZE(kx022a_channels),
> -	.fifo_length	  = KX022A_FIFO_LENGTH,
> -	.who		  = KX022A_REG_WHO,
> -	.id		  = KX022A_ID,
> -	.cntl		  = KX022A_REG_CNTL,
> -	.cntl2		  = KX022A_REG_CNTL2,
> -	.odcntl		  = KX022A_REG_ODCNTL,
> -	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> -	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> -	.buf_clear	  = KX022A_REG_BUF_CLEAR,
> -	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> -	.buf_read	  = KX022A_REG_BUF_READ,
> -	.inc1		  = KX022A_REG_INC1,
> -	.inc4		  = KX022A_REG_INC4,
> -	.inc5		  = KX022A_REG_INC5,
> -	.inc6		  = KX022A_REG_INC6,
> -	.xout_l		  = KX022A_REG_XOUT_L,
This is a very good illustration of why aligning value assignments is not
(in my opinion) a good idea. I'll tweak the earlier patch whilst
applying to add the extra indent.

However, in future look through your complete series for cases where
code added in an earlier patch is simply reformatted in a later one.

Same applies to the structure kdoc below.


> +	.name				= "kx022-accel",
> +	.regmap_config			= &kx022a_regmap_config,
> +	.channels			= kx022a_channels,
> +	.num_channels			= ARRAY_SIZE(kx022a_channels),
> +	.fifo_length			= KX022A_FIFO_LENGTH,
> +	.who				= KX022A_REG_WHO,
> +	.id				= KX022A_ID,
> +	.cntl				= KX022A_REG_CNTL,
> +	.cntl2				= KX022A_REG_CNTL2,
> +	.odcntl				= KX022A_REG_ODCNTL,
> +	.buf_cntl1			= KX022A_REG_BUF_CNTL1,
> +	.buf_cntl2			= KX022A_REG_BUF_CNTL2,
> +	.buf_clear			= KX022A_REG_BUF_CLEAR,
> +	.buf_status1			= KX022A_REG_BUF_STATUS_1,
> +	.buf_read			= KX022A_REG_BUF_READ,
> +	.inc1				= KX022A_REG_INC1,
> +	.inc4				= KX022A_REG_INC4,
> +	.inc5				= KX022A_REG_INC5,
> +	.inc6				= KX022A_REG_INC6,
> +	.xout_l				= KX022A_REG_XOUT_L,
> +	.get_fifo_bytes_available	= kx022a_get_fifo_bytes_available,
>  };
>  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
>  
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 0e5026019213..7ca48e6f2c49 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -76,29 +76,34 @@
>  
>  struct device;
>  
> +struct kx022a_data;
> +
>  /**
>   * struct kx022a_chip_info - Kionix accelerometer chip specific information
>   *
> - * @name:		name of the device
> - * @regmap_config:	pointer to register map configuration
> - * @channels:		pointer to iio_chan_spec array
> - * @num_channels:	number of iio_chan_spec channels
> - * @fifo_length:	number of 16-bit samples in a full buffer
> - * @who:		WHO_AM_I register
> - * @id:			WHO_AM_I register value
> - * @cntl:		control register 1
> - * @cntl2:		control register 2
> - * @odcntl:		output data control register
> - * @buf_cntl1:		buffer control register 1
> - * @buf_cntl2:		buffer control register 2
> - * @buf_clear:		buffer clear register
> - * @buf_status1:	buffer status register 1
> - * @buf_read:		buffer read register
> - * @inc1:		interrupt control register 1
> - * @inc4:		interrupt control register 4
> - * @inc5:		interrupt control register 5
> - * @inc6:		interrupt control register 6
> - * @xout_l:		x-axis output least significant byte
> + * @name:			name of the device
> + * @regmap_config:		pointer to register map configuration
> + * @channels:			pointer to iio_chan_spec array
> + * @num_channels:		number of iio_chan_spec channels
> + * @fifo_length:		number of 16-bit samples in a full buffer
> + * @who:			WHO_AM_I register
> + * @id:				WHO_AM_I register value
> + * @cntl:			control register 1
> + * @cntl2:			control register 2
> + * @odcntl:			output data control register
> + * @buf_cntl1:			buffer control register 1
> + * @buf_cntl2:			buffer control register 2
> + * @buf_clear:			buffer clear register
> + * @buf_status1:		buffer status register 1
> + * @buf_read:			buffer read register
> + * @inc1:			interrupt control register 1
> + * @inc4:			interrupt control register 4
> + * @inc5:			interrupt control register 5
> + * @inc6:			interrupt control register 6
> + * @xout_l:			x-axis output least significant byte
> + * @get_fifo_bytes_available:	function pointer to get amount of acceleration
> + *				data bytes currently stored in the sensor's FIFO
> + *				buffer
>   */
>  struct kx022a_chip_info {
>  	const char *name;
> @@ -121,6 +126,7 @@ struct kx022a_chip_info {
>  	u8 inc5;
>  	u8 inc6;
>  	u8 xout_l;
> +	int (*get_fifo_bytes_available)(struct kx022a_data *);
>  };
>  
>  int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);

