Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3B7ACB43
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjIXSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E365FB;
        Sun, 24 Sep 2023 11:12:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C38C433C7;
        Sun, 24 Sep 2023 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695579133;
        bh=2hiu8uOnsElorfhRSfYCC2/uuUILnH3TV41+hLNifBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=akB4F2tvtes1qxA4M1M3ZbP3TfZFdRsxCfN9FeMxZ/qHi5W0q1tiwFgitJ4oM89h1
         UIpwa1tsGEdpZQoUj+vaAQ8r0miccsqeWjNG19XjgERX+m4ZNut1sWOeIkKr0qG/Lj
         CqLpZ9IxGyPDVmWM9JeZ1co7eQfBgNBpUj5Rmf9iwl6NUr0ebKCgCxAq66VOTzFqMq
         2dzDemBWcGMxvmjnQaV8B1gutABMHGjFZRggFs2o+SZn60aBRqyPPHREHNCVhpZzr2
         eIvbgWQ6VwoJ5On4SoJVYL0lDY3ZEqqKdBNh29jQJR8lmTlpqIatx8WFkTKwb5Dlnh
         UyNIoYpcMyRbQ==
Date:   Sun, 24 Sep 2023 19:12:04 +0100
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
Subject: Re: [PATCH v2 18/19] staging: iio: resolver: ad2s1210: add
 phase_lock_range attributes
Message-ID: <20230924191204.176ee3a6@jic23-huawei>
In-Reply-To: <20230921144400.62380-19-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-19-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds new phase_lock_range and phase_lock_range_available attributes
> to the ad2s1210 resolver driver. These attributes allow the user to set
> the phase lock range bit in the control register to modify the behavior
> of the resolver to digital converter.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
The guard() and scoped_guard() magic will work well in here.

Otherwise, I think as you raised in the cover letter, that the interface
needs some thought as far form obvious what a phase_lock is + nonstandard
ABI is best avoided if we can.

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 58 +++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 71f0913b7e2e..f5b8b290e860 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -259,6 +259,60 @@ static ssize_t excitation_frequency_store(struct device *dev,
>  	return ret;
>  }
>  
> +static ssize_t phase_lock_range_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +			       AD2S1210_PHASE_LOCK_RANGE_44);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = sprintf(buf, "%d\n", ret ? 44 : 360);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static ssize_t phase_lock_range_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	u16 udata;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 10, &udata);
> +	if (ret < 0 || (udata != 44 && udata != 360))
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +				 AD2S1210_PHASE_LOCK_RANGE_44,
> +				 udata == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = len;
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static ssize_t phase_lock_range_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	return sprintf(buf, "44 360\n");
> +}
> +
>  /* read the fault register since last sample */
>  static ssize_t ad2s1210_show_fault(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
> @@ -506,6 +560,8 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
> +static IIO_DEVICE_ATTR_RW(phase_lock_range, 0);
> +static IIO_DEVICE_ATTR_RO(phase_lock_range_available, 0);
>  static IIO_DEVICE_ATTR(fault, 0644,
>  		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
>  
> @@ -552,6 +608,8 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  
>  static struct attribute *ad2s1210_attributes[] = {
>  	&iio_dev_attr_excitation_frequency.dev_attr.attr,
> +	&iio_dev_attr_phase_lock_range.dev_attr.attr,
> +	&iio_dev_attr_phase_lock_range_available.dev_attr.attr,
>  	&iio_dev_attr_fault.dev_attr.attr,
>  	&iio_dev_attr_los_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,

