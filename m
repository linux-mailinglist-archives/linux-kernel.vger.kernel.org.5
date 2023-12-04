Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4743F802F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjLDKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjLDKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:05:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92726119
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:05:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33789C433C7;
        Mon,  4 Dec 2023 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701684327;
        bh=TjbVpp0w/mr0UQlKAwP4FFpH3IWzsJ2Rxf+6614AKw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LCeo5emhYBiylF4hn4+CLQjHs53oxcvqzN6JNW4byYOf8eYp9U98no67sD6bozjNo
         5bdXsgeseUO4kEa6zkVHbKkI7rsY8QbHAj+xI8C0NPgjGJHi4ARMKiNyZin6vzPSOM
         cQ/9IjtcLf82phzN1tyCG6IYmyF3rcMa6xpdNUBkzmFInDyF2ovoAwtdQbMS+PPPq+
         DFvxk2tG5Ll7GaA5StWiAF9g1W1PwG4tlKjfbHgu3PXVS8ZvzYtYpD2CYDRqKcWKt3
         EcAg9hyL+mAXykW5rC5IHjO8lSHVEU4sJqzb7kQz+H1zH61AyrFd+7KZuzKt3tDqA3
         ZEFenR3p1m8Dg==
Date:   Mon, 4 Dec 2023 10:05:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] iio: light: driver for Lite-On ltr390
Message-ID: <20231204100517.30df720e@jic23-huawei>
In-Reply-To: <f6ced6e9-65d2-4bbc-9792-473465bad547@gmail.com>
References: <20231117074554.700970-1-anshulusr@gmail.com>
        <20231117074554.700970-2-anshulusr@gmail.com>
        <20231125140641.08284929@jic23-huawei>
        <f6ced6e9-65d2-4bbc-9792-473465bad547@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >> +struct ltr390_data {
> >> +	struct regmap *regmap;
> >> +	struct i2c_client *client;
> >> +	struct mutex lock;  
> > 
> > All locks need a comment explaining the scope of data they protect.
> > Note that regmap and the i2c bus will have their own locks by default
> > so I'm not sure you need one here at all as I'm not seeing read modify write
> > cycles or anything like that (I might be missing one though!)  
> 
> My goal with the mutex was to protect the sysfs though that might be
> unnecessary.

Ok.  So, there is nothing stopping multiple parallel sysfs accesses, but
what you'll actually be protecting is either device or driver state, not
sysfs as such.

> 
> >> +};
> >> +
> >> +static const struct regmap_config ltr390_regmap_config = {
> >> +	.name = LTR390_DEVICE_NAME,
> >> +	.reg_bits = 8,
> >> +	.reg_stride = 1,
> >> +	.val_bits = 8,
> >> +};
> >> +


> >> +static int ltr390_probe(struct i2c_client *client)
> >> +{
> >> +	struct ltr390_data *data;
> >> +	struct iio_dev *indio_dev;
> >> +	int ret, part_number;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +
> >> +	data->regmap = devm_regmap_init_i2c(client, &ltr390_regmap_config);
> >> +	if (IS_ERR(data->regmap))
> >> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),  
> > There are quite a few &client->dev in here. I'd introduce
> > struct device *dev = &client->dev;
> > as a local variable then use that to shorten all those lines a little.
> >   
> >> +				     "regmap initialization failed\n");
> >> +
> >> +	data->client = client;
> >> +	i2c_set_clientdata(client, indio_dev);  
> > 
> > Why set this? I don' think you are using it.
> >   
> 
> It seems to be necessary for regmap to work properly, I tested without
> it and I get an EREMOTEIO(121) when reading the part id.

That's weird given regmap will have no understanding of an iio_dev.

If you can do some more debugging on where that error is coming from
in regmap that would be great.

I suspect it's coming from down in the bus master which should not
be touching this at all.  What is the i2c master in this case?

Jonathan


> 
> >> [..]  
> 
> Thanks for the review,
> Best regards,
> Anshul

