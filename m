Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6275B6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGTS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGTS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994EC270D;
        Thu, 20 Jul 2023 11:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D25C61BBA;
        Thu, 20 Jul 2023 18:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB9C433C7;
        Thu, 20 Jul 2023 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877656;
        bh=2GMTN6ceqPES1/d6gjRazz6Y4nOBxsMGPt0GoZG9nCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VRhrfpOF955zzNBQirMa4yp9YDTrPggwE1IOLByKCD9aiw5Qg3CjFFgm4nUgSKqTT
         NOD+OeVoyCoBHtwW4Fr/ju/0acGoYs7cDzEycSRfj7l5jLxGsZZCSoOax7beFZxgGd
         eXfcMa0udsQt81aKNcs24bhPBHblwzBehsjQP7tmPDMMe5Iwjy6oYDKSW7STpdnRu5
         TtfxHYpIjnby9JIZMZUoSOqrWtYItonYM2uk2xm/pnrCyxGiaXQdMd5qjGI8PGvIcw
         n6X2JtjJTf7cth+Wg1qtL7jEvWGhdJd7pyj9R/Cz9XRa7ASTytP/Tyn7BrduUvsgTJ
         jFBSy0Pb7HAAA==
Date:   Thu, 20 Jul 2023 19:27:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: ad7816: add iio interface
Message-ID: <20230720192730.490cf3cb@jic23-huawei>
In-Reply-To: <DB4PR10MB626128364C9D170DFFAD0A48923BA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
References: <DB4PR10MB6261ADF6C8845AF66AB292989232A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
        <20230716144024.30ded663@jic23-huawei>
        <DB4PR10MB626128364C9D170DFFAD0A48923BA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

	0);
> >> -
> >> -static ssize_t ad7816_show_value(struct device *dev,
> >> -				 struct device_attribute *attr,
> >> -				 char *buf)
> >> -{
> >> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>   	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> >>   	u16 data;
> >> -	s8 value;
> >>   	int ret;
> >>   
> >> +	chip->channel_id = (u8)chan->channel;  
> > Can we keep the channel_id local?
> > It is used for over temperature detection (OTI) but that needs separating out.  
> 
> ack, maybe need a another commit.
> 
> channel_id may be removed from ad7816_chip_info

Agreed. A separate ID will tidy this up and may provide a transition path
to let you do the other parts in multiples steps.

> 
> >
> > Given you'll be breaking that connection I think you need to deal with
> > both the main attributes and the event ones in a single go.  Thus removing
> > any hidden usage of the last channel touched like you have here.
> >
> >  
> >>   	ret = ad7816_spi_read(chip, &data);
> >>   	if (ret)
> >>   		return -EIO;
> >> @@ -227,22 +180,21 @@ static ssize_t ad7816_show_value(struct device *dev,
> >>   	data >>= AD7816_VALUE_OFFSET;
> >>   
> >>   	if (chip->channel_id == 0) {
> >> -		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
> >> -		data &= AD7816_TEMP_FLOAT_MASK;
> >> -		if (value < 0)
> >> -			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
> >> -		return sprintf(buf, "%d.%.2d\n", value, data * 25);
> >> +		*val = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);  
> > Use masks and FIELD_GET() though that change perhaps belongs in a separate patch set.  
> ack
> >> +		*val2 = (data & AD7816_TEMP_FLOAT_MASK) * 25;
> >> +		if (*val < 0)
> >> +			*val2 = BIT(AD7816_TEMP_FLOAT_OFFSET) - *val2;
> >> +		return IIO_VAL_INT_PLUS_MICRO;
> >>   	}
> >> -	return sprintf(buf, "%u\n", data);
> >> -}
> >>   
> >> -static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
> >> +	*val = data;
> >> +
> >> +	return IIO_VAL_INT;
> >> +}
> >>   
> >>   static struct attribute *ad7816_attributes[] = {
> >>   	&iio_dev_attr_available_modes.dev_attr.attr,
> >>   	&iio_dev_attr_mode.dev_attr.attr,
> >> -	&iio_dev_attr_channel.dev_attr.attr,
> >> -	&iio_dev_attr_value.dev_attr.attr,
> >>   	NULL,
> >>   };
> >>   
> >> @@ -341,10 +293,47 @@ static const struct attribute_group ad7816_event_attribute_group = {
> >>   };
> >>   
> >>   static const struct iio_info ad7816_info = {
> >> +	.read_raw = ad7816_read_raw,
> >>   	.attrs = &ad7816_attribute_group,
> >>   	.event_attrs = &ad7816_event_attribute_group,
> >>   };
> >>   
> >> +static const struct iio_chan_spec ad7816_channels[] = {
> >> +	{
> >> +		.type = IIO_TEMP,
> >> +		.indexed = 1,
> >> +		.channel = 0,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> >> +	},
> >> +};
> >> +
> >> +static const struct iio_chan_spec ad7817_channels[] = {
> >> +	{
> >> +		.type = IIO_TEMP,
> >> +		.indexed = 1,
> >> +		.channel = 0,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),  
> > This would require the reading presented to be in the units defined by
> > the ABI (Documentation/ABI/testing/sysfs-bus-iio)
> > Can you confirm that these are all correct?  
> I will upload test report

Perfect.

> >
> > Note it is very unusual for an IIO driver to present all processed channels.
> > Superficially it looks like there might be some appropriate conversions done
> > for the temperature channels for them to be in the right units, but nothing
> > at all is done to the voltage channels...  
> 
> In fact, I hope to set voltage channel to RAW, and leave conversion to 
> users.
> 
> Is it a good idea?

Yes, though hopefully we can also provide a _SCALE to give userspace the
information it needs.

> 


