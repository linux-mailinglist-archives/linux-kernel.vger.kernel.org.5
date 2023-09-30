Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9C7B41D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjI3Pri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjI3Prf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE818F;
        Sat, 30 Sep 2023 08:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667D4C433C7;
        Sat, 30 Sep 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696088853;
        bh=Gor7hCiDiW4Jc346jiB8/6JVwQoGcfKYgZ6QWObW8cY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uR5/74pgtU3bWICZedmsfmolkXmgw1MzXq/N4TYCXl+QvUfNxVH/xidREmFNBktf4
         fd6D3yreDGWmwvo4qkXIx+h/EoxGdku6pPpFY/tMOfTBj3InjPA83TDCIAsH5rVi7z
         QP2CKniYoTU4tNb7/mvGkKxsUh3ToH2kzKViiwXZC3u8FAz0KzHUNLye7oqRyULwld
         b4oRzbJf82CJOT1VbnoyjBKKYEJHZrsSeaScG8Dp36C5lbJ1fsGqdB8Q7UV1UQJOaH
         QAO1ZoUAkGhmJnrNrKXqkEfbMQXo9NBqHbbvq72PY2IHKmFeTWV6asO8f+sPbfJCQD
         CxfqOglvk6SRA==
Date:   Sat, 30 Sep 2023 16:47:32 +0100
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
Subject: Re: [PATCH v3 25/27] staging: iio: resolver: ad2s1210: rename DOS
 reset min/max attrs
Message-ID: <20230930164732.34e62b20@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-25-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-25-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> The AD2S1210 has a programmable threshold for the degradation of signal
> (DOS) mismatch fault. This fault is triggered when the difference in
> amplitude between the sine and cosine inputs exceeds the threshold.
> 
> The DOS reset min/max registers on the chip provide initial values
> for internal tracking of the min/max of the monitor signal after the
> fault register is cleared.
> 
> This patch converts the custom device DOS reset min/max threshold
> attributes custom event attributes on the monitor signal channel.
> 
> The attributes now use millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v3 changes: This is a new patch in v3
> 
>  .../Documentation/sysfs-bus-iio-resolver-ad2s1210  | 27 ++++++
>  drivers/staging/iio/resolver/ad2s1210.c            | 99 ++++++++++++----------
>  2 files changed, 82 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210 b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> new file mode 100644
> index 000000000000..ea75881b0c77
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
> @@ -0,0 +1,27 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0-altvoltage1_thresh_rising_reset_max
Ah. So these are differential.  But the mismatch channel value isn't?  

I also got the format wrong for differential channels. Oops. Should
be the in_altvoltage0-altvoltage1 format for the previous suggestion
to change that channel type to differential.

This looks fine to me as new ABI.

Jonathan



> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Maximum
> +		Threshold value in millivolts. Writing sets the value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0-altvoltage1_thresh_rising_reset_max_available
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the allowable voltage range for
> +		in_altvoltage0-altvoltage1_thresh_rising_reset_max.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0-altvoltage1_thresh_rising_reset_min
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the current Degradation of Signal Reset Minimum
> +		Threshold value in millivolts. Writing sets the value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0-altvoltage1_thresh_rising_reset_min_available
> +KernelVersion:  6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the allowable voltage range for
> +		in_altvoltage0-altvoltage1_thresh_rising_reset_min.
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index aa14edbe8a77..e1c95ec73545 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -283,41 +283,6 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
>  	return ret < 0 ? ret : len;
>  }
>  
> -static ssize_t ad2s1210_show_reg(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> -	unsigned int value;
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = regmap_read(st->regmap, iattr->address, &value);
> -	mutex_unlock(&st->lock);
> -
> -	return ret < 0 ? ret : sprintf(buf, "%d\n", value);
> -}
> -
> -static ssize_t ad2s1210_store_reg(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned char data;
> -	int ret;
> -	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> -
> -	ret = kstrtou8(buf, 10, &data);
> -	if (ret)
> -		return -EINVAL;
> -
> -	mutex_lock(&st->lock);
> -	ret = regmap_write(st->regmap, iattr->address, data);
> -	mutex_unlock(&st->lock);
> -	return ret < 0 ? ret : len;
> -}
> -
>  static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  				      struct iio_chan_spec const *chan,
>  				      int *val)
> @@ -743,13 +708,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  static IIO_DEVICE_ATTR(fault, 0644,
>  		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
>  
> -static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
> -		       ad2s1210_show_reg, ad2s1210_store_reg,
> -		       AD2S1210_REG_DOS_RST_MAX_THRD);
> -static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
> -		       ad2s1210_show_reg, ad2s1210_store_reg,
> -		       AD2S1210_REG_DOS_RST_MIN_THRD);
> -
>  static const struct iio_event_spec ad2s1210_position_event_spec[] = {
>  	{
>  		/* Tracking error exceeds LOT threshold fault. */
> @@ -867,8 +825,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  
>  static struct attribute *ad2s1210_attributes[] = {
>  	&iio_dev_attr_fault.dev_attr.attr,
> -	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
> -	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -876,6 +832,49 @@ static const struct attribute_group ad2s1210_attribute_group = {
>  	.attrs = ad2s1210_attributes,
>  };
>  
> +static ssize_t event_attr_voltage_reg_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	unsigned int value;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, iattr->address, &value);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", value * THRESHOLD_MILLIVOLT_PER_LSB);
> +}
> +
> +static ssize_t event_attr_voltage_reg_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	u16 data;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 10, &data);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_write(st->regmap, iattr->address,
> +			   data / THRESHOLD_MILLIVOLT_PER_LSB);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
>  static ssize_t
>  in_angl1_thresh_rising_value_available_show(struct device *dev,
>  					    struct device_attribute *attr,
> @@ -906,6 +905,14 @@ IIO_CONST_ATTR(in_phase0_mag_value_available,
>  IIO_CONST_ATTR(in_altvoltage0_thresh_falling_value_available, THRESHOLD_RANGE_STR);
>  IIO_CONST_ATTR(in_altvoltage0_thresh_rising_value_available, THRESHOLD_RANGE_STR);
>  IIO_CONST_ATTR(in_altvoltage0_mag_value_available, THRESHOLD_RANGE_STR);
> +IIO_DEVICE_ATTR(in_altvoltage0_mag_reset_max, 0644,
> +		event_attr_voltage_reg_show, event_attr_voltage_reg_store,
> +		AD2S1210_REG_DOS_RST_MAX_THRD);
> +IIO_CONST_ATTR(in_altvoltage0_mag_reset_max_available, THRESHOLD_RANGE_STR);
> +IIO_DEVICE_ATTR(in_altvoltage0_mag_reset_min, 0644,
> +		event_attr_voltage_reg_show, event_attr_voltage_reg_store,
> +		AD2S1210_REG_DOS_RST_MIN_THRD);
> +IIO_CONST_ATTR(in_altvoltage0_mag_reset_min_available, THRESHOLD_RANGE_STR);
>  IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
>  IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
>  
> @@ -914,6 +921,10 @@ static struct attribute *ad2s1210_event_attributes[] = {
>  	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
>  	&iio_const_attr_in_altvoltage0_thresh_rising_value_available.dev_attr.attr,
>  	&iio_const_attr_in_altvoltage0_mag_value_available.dev_attr.attr,
> +	&iio_dev_attr_in_altvoltage0_mag_reset_max.dev_attr.attr,
> +	&iio_const_attr_in_altvoltage0_mag_reset_max_available.dev_attr.attr,
> +	&iio_dev_attr_in_altvoltage0_mag_reset_min.dev_attr.attr,
> +	&iio_const_attr_in_altvoltage0_mag_reset_min_available.dev_attr.attr,
>  	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
>  	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
>  	NULL,
> 

