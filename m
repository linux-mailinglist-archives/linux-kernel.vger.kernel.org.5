Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC95D7C00E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjJJP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjJJP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:59:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB197;
        Tue, 10 Oct 2023 08:59:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A371C433C7;
        Tue, 10 Oct 2023 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953545;
        bh=OPlhF+ij5+nDi2Y2jm7qw/gg2jrqcnUYBRVJO1XRlb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bqj9z/XeQGfxu4j6A0XiLOGIh8HkXHcboAxtwTHV6c4oF/W2HIYcaYxRRG7CB1BIz
         mYR9CQKK8jHVaBmq7WbptMzxeSTI+kBaEP76geWkg5XQbUaLvDDMKALHw6DYZGs1I7
         nHpH1fq5FddAHADlDIwLYxQhFxrau3Cq0XJ/gocKSWMtvlRYXrAkvtSyuZ9HvnRtx2
         LnBfO9MOfNDtxc9oUFzSJZKoXPx6NccxmusjZF6a6B1a8kOePTUBCM+wxcjXP2xuVF
         y0u0JoEdzkUVzpCK2O+XpOsDO91i2/axucjFyBi9OdyWDJSTSVzJpx0eMjzBgN5Fel
         nU0cV7DUQLLmg==
Date:   Tue, 10 Oct 2023 16:59:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/17] iio: event: add optional event label support
Message-ID: <20231010165917.4c1cb0a9@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-12-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-12-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new optional field to struct iio_info to allow drivers to
> specify a label for the event. This is useful for cases where there are
> many events or the event attribute name is not descriptive enough or
> where an event doesn't have any other attributes.
> 
> The implementation is based on the existing label support for channels.
> So either all events of a device have a label attribute or none do.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Was going to moan about lack of docs, but I see they are in later patches.

Ok. General feature is fine. Applied.

Jonathan

> ---
> 
> v4 changes: New patch in v4.
> 
>  drivers/iio/industrialio-event.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h          |  8 ++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 19f7a91157ee..910c1f14abd5 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -355,6 +355,21 @@ static ssize_t iio_ev_value_store(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t iio_ev_label_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	if (indio_dev->info->read_event_label)
> +		return indio_dev->info->read_event_label(indio_dev,
> +				 this_attr->c, iio_ev_attr_type(this_attr),
> +				 iio_ev_attr_dir(this_attr), buf);
> +
> +	return -EINVAL;
> +}
> +
>  static int iio_device_add_event(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int spec_index,
>  	enum iio_event_type type, enum iio_event_direction dir,
> @@ -411,6 +426,41 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  	return attrcount;
>  }
>  
> +static int iio_device_add_event_label(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      unsigned int spec_index,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	char *postfix;
> +	int ret;
> +
> +	if (!indio_dev->info->read_event_label)
> +		return 0;
> +
> +	if (dir != IIO_EV_DIR_NONE)
> +		postfix = kasprintf(GFP_KERNEL, "%s_%s_label",
> +				iio_ev_type_text[type],
> +				iio_ev_dir_text[dir]);
> +	else
> +		postfix = kasprintf(GFP_KERNEL, "%s_label",
> +				iio_ev_type_text[type]);
> +	if (postfix == NULL)
> +		return -ENOMEM;
> +
> +	ret = __iio_add_chan_devattr(postfix, chan, &iio_ev_label_show, NULL,
> +				spec_index, IIO_SEPARATE, &indio_dev->dev, NULL,
> +				&iio_dev_opaque->event_interface->dev_attr_list);
> +
> +	kfree(postfix);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return 1;
> +}
> +
>  static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan)
>  {
> @@ -448,6 +498,11 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		attrcount += ret;
> +
> +		ret = iio_device_add_event_label(indio_dev, chan, i, type, dir);
> +		if (ret < 0)
> +			return ret;
> +		attrcount += ret;
>  	}
>  	ret = attrcount;
>  	return ret;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 7bfa1b9bc8a2..d0ce3b71106a 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -427,6 +427,8 @@ struct iio_trigger; /* forward declaration */
>   * @write_event_config:	set if the event is enabled.
>   * @read_event_value:	read a configuration value associated with the event.
>   * @write_event_value:	write a configuration value for the event.
> + * @read_event_label:	function to request label name for a specified label,
> + *			for better event identification.
>   * @validate_trigger:	function to validate the trigger when the
>   *			current trigger gets changed.
>   * @update_scan_mode:	function to configure device and scan buffer when
> @@ -511,6 +513,12 @@ struct iio_info {
>  				 enum iio_event_direction dir,
>  				 enum iio_event_info info, int val, int val2);
>  
> +	int (*read_event_label)(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				char *label);
> +
>  	int (*validate_trigger)(struct iio_dev *indio_dev,
>  				struct iio_trigger *trig);
>  	int (*update_scan_mode)(struct iio_dev *indio_dev,
> 

