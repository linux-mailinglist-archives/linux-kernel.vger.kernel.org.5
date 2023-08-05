Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98B77118C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHESpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHESpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE52D4C;
        Sat,  5 Aug 2023 11:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403F460E95;
        Sat,  5 Aug 2023 18:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAF6C433C8;
        Sat,  5 Aug 2023 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691261117;
        bh=zRwcgDm9xNYahle4qODcQFQM9HNNqUQlzReiRppvU1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XvNX7ZzXC4HkFpdouVTsGr73/P2bhxP/bTo5HcR32j8oV3AX5q9urQMyDlMmBEpXq
         wdFjDLCdvM55xKLHztxhULsbWNvb1YORrltwb486p9g5++qpBtgTs1cNYUrLfkCZvs
         rcoGlZ2niRc0K4VofuuomK/oiKbQgWQpEId+gsLArSyPN0sAk/xkj/aV8nTyjCNIXH
         D93PUKAaJPFMkUyEchc+G0Z4BDBs7J9bcvXeRfqKvFUTgvtZDc4CY7wr/rpv+g3rZp
         oNNVgbF8aIBNNO+M3x+4SH9Y3Y+gp2qvXn9MBkbtNIHU7D6dp/1E9WTk6aCU8u+ll5
         qWDAUCDYK8BBg==
Date:   Sat, 5 Aug 2023 19:45:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Message-ID: <20230805194511.3490477a@jic23-huawei>
In-Reply-To: <20230804064559.47192-4-ramona.bolboaca@analog.com>
References: <20230804064559.47192-1-ramona.bolboaca@analog.com>
        <20230804064559.47192-4-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 09:45:59 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add support for delta angle and delta velocity raw and buffer
> readings to adis16475 driver.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>

Hi Ramona,

A few trivial comments inline given we need to make that unit change
so you will be doing a v4.  Otherwise I might have just done a bit of tidying
up whilst applying.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/adis16475.c | 165 +++++++++++++++++++++++++++++++-----
>  1 file changed, 146 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 17275a53ca2c..dbbeb80c4d23 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -31,6 +31,12 @@
>  #define ADIS16475_REG_Y_ACCEL_L		0x14
>  #define ADIS16475_REG_Z_ACCEL_L		0x18
>  #define ADIS16475_REG_TEMP_OUT		0x1c
> +#define ADIS16475_REG_X_DELTANG_L	0x24
> +#define ADIS16475_REG_Y_DELTANG_L	0x28
> +#define ADIS16475_REG_Z_DELTANG_L	0x2C
> +#define ADIS16475_REG_X_DELTVEL_L	0x30
> +#define ADIS16475_REG_Y_DELTVEL_L	0x34
> +#define ADIS16475_REG_Z_DELTVEL_L	0x38
>  #define ADIS16475_REG_X_GYRO_BIAS_L	0x40
>  #define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
>  #define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
> @@ -55,6 +61,8 @@
>  #define ADIS16475_REG_PROD_ID		0x72
>  #define ADIS16475_REG_SERIAL_NUM	0x74
>  #define ADIS16475_REG_FLASH_CNT		0x7c
> +#define ADIS16500_BURST_DATA_SEL_MASK	BIT(8)
> +#define ADIS16500_BURST_DATA_SEL(x)	FIELD_PREP(ADIS16500_BURST_DATA_SEL_MASK, x)

I guess this is consistent with other bits of the driver, but I'm not sure
in general that the macro adds anything over directly calling the FIELD_PREP()
which is pretty obvious on it's own.

>  #define ADIS16500_BURST32_MASK		BIT(9)
>  #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
>  /* number of data elements in burst mode */
> @@ -65,6 +73,10 @@
>  #define ADIS16475_BURST_MAX_SPEED	1000000
>  #define ADIS16475_LSB_DEC_MASK		BIT(0)
>  #define ADIS16475_LSB_FIR_MASK		BIT(1)
> +#define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
> +#define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)

Add a blank line here to separate these flag definitions or
see below...

> +#define ADIS16475_HAS_BURST32		BIT(0)
> +#define ADIS16475_HAS_BURST_DELTA_DATA	BIT(1)
>  
>  enum {
>  	ADIS16475_SYNC_DIRECT = 1,
> @@ -84,16 +96,18 @@ struct adis16475_chip_info {
>  	const struct adis16475_sync *sync;
>  	const struct adis_data adis_data;
>  	const char *name;
> +	const long flags;
I would put the two flag definitions here. Then it's obvious what
they are used for.  
>  	u32 num_channels;
>  	u32 gyro_max_val;
>  	u32 gyro_max_scale;
>  	u32 accel_max_val;
>  	u32 accel_max_scale;
>  	u32 temp_scale;
> +	u32 deltang_max_val;
> +	u32 deltvel_max_val;
>  	u32 int_clk;
>  	u16 max_dec;
>  	u8 num_sync;
> -	bool has_burst32;
>  };
>  
>  struct adis16475 {
> @@ -115,6 +129,12 @@ enum {
>  	ADIS16475_SCAN_ACCEL_Y,
>  	ADIS16475_SCAN_ACCEL_Z,
>  	ADIS16475_SCAN_TEMP,
> +	ADIS16475_SCAN_DELTANG_X,
> +	ADIS16475_SCAN_DELTANG_Y,
> +	ADIS16475_SCAN_DELTANG_Z,
> +	ADIS16475_SCAN_DELTVEL_X,
> +	ADIS16475_SCAN_DELTVEL_Y,
> +	ADIS16475_SCAN_DELTVEL_Z,
>  };
>  

>  	[ADIS16507_3] = {
> @@ -962,20 +1060,46 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
>  		.accel_max_val = 392,
>  		.accel_max_scale = 32000 << 16,
>  		.temp_scale = 100,
> +		.deltang_max_val = 2160,
> +		.deltvel_max_val = 400,
>  		.int_clk = 2000,
>  		.max_dec = 1999,
>  		.sync = adis16475_sync_mode,
>  		/* pulse sync not supported */
>  		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
> -		.has_burst32 = true,
> +		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,

In the ideal world, a precursor patch would have made the change to have
a flags field, then this one would have just added the new flags.

However it would have made a huge difference to readability of this patch
so I'm not that bothered about not having it broken out.

>  		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
>  	},
>  };
>  
> +static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	u16 en;
> +	int ret;
> +	struct adis16475 *st = iio_priv(indio_dev);
> +
> +	if (st->info->flags & ADIS16475_HAS_BURST_DELTA_DATA) {
> +		if ((*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK) && (*scan_mask & ADIS16500_BURST_DATA_SEL_1_CHN_MASK))

Very long line. No obvious reason not to break it after the &&

> +			return -EINVAL;
> +		if (*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK)
> +			en = ADIS16500_BURST_DATA_SEL(0);
> +		else
> +			en = ADIS16500_BURST_DATA_SEL(1);
> +
> +		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16500_BURST_DATA_SEL_MASK, en);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return adis_update_scan_mode(indio_dev, scan_mask);
> +}

