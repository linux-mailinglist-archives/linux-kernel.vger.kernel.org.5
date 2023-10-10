Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423F7BF88F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjJJK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJJK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:26:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59181AF;
        Tue, 10 Oct 2023 03:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1584EC433C8;
        Tue, 10 Oct 2023 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696933576;
        bh=PqLwa/jUv0/v1YHnMTFC+aJ+JxMcrb9OrAWtpCIlSVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjGJc9OXY4TmtAKccg9N8dWKXu8WN0fawl0VNIqj4TJBQLwfeThvQ3cim64MtrDnB
         AVWMnva+eyVktQHmkI83jbsmtWTb+rErQJXK6MnNAlQ4lcLJeokGNc1gK4J1TYqpnr
         PR0B4014dStxg2v6nFC8wMyixp1gHgFgnnKNGx727ZX7eNSwNwO41WrlpJI2ruxMMd
         /zvhFNesw7t+FDLmr6SBAMc2w40IrqAirb7fQtlvE9Wh1JROnQyS25hJ595Ea7mY0M
         jcR9TnVdL02Yeab6mJGg1e20cS+HnjZyOwLau5LurYQpHxZe+s+DldxxueWEgdfYRz
         T9RGc0ZpcLsQA==
Date:   Tue, 10 Oct 2023 11:26:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ceclan Dumitru-Ioan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231010112621.0b371e74@jic23-huawei>
In-Reply-To: <07afa29c-bfef-72dc-d471-f72dfcebe342@gmail.com>
References: <20231005105921.460657-1-mitrutzceclan@gmail.com>
        <20231005105921.460657-2-mitrutzceclan@gmail.com>
        <20231005180131.0518f46c@jic23-huawei>
        <07afa29c-bfef-72dc-d471-f72dfcebe342@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> >> +		chan[chan_index].differential = fwnode_property_read_bool(child, "bipolar");  
> > 
> > bipolar doesn't normally == differential. 
> > You can have unipolar differential (just that you can't get a negative answer)
> > Perhaps just a terminology thing?
> >  
> 
> This device supports only differential channels. Here, the differential flag is used to show
> if bipolar coding should be used.

I'm confused - you are setting differential in the iio_chan_spec with this.
That affects the sysfs naming and a bunch of other stuff - not merely
the bipolar nature of the channel.


> 
> 
> >> +	st->info = device_get_match_data(dev);
> >> +	if (!st->info)
> >> +		return -ENODEV;  
> > This works for the cases of DT and ACPI but not for anyone just
> > using the spi_device_id table. 
> > There is spi_device_get_match_data() to cover all options.
> >   
> I could not find the spi_device_get_match_data() function in the repo.
> It appears however as a suggestion from Andy Shevchenko in a thread:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2382960.html
>  Is this it? 

ah. I got the name wrong.
spi_get_device_match_data()


https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/spi/spi.c#L364
