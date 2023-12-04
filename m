Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6368031B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjLDLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:46:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F2B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:46:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99456C433C8;
        Mon,  4 Dec 2023 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701690391;
        bh=i1+VKeSNTBMfL+Jw9GhDsIITBUtuYP9Ee/ts7oDwFgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LYZOekNSEYjZHt0q1vMfNanrbaTZwFa3bfc1jqH/fiIipmhRFHY14gN7d2UaeUqYR
         kFmE4PSCKESYlxK6Ze6RMrI+/P8eaVT0khlLEZkpqzVBn6lL58zjooUFS/uIj++YGJ
         sfFo884yHwHHXfkZDfNcdrcNgoB7Y1nkyB0NcsxM9rztyQHw/ylE4SM6CmK9+QVI7W
         Kwqgs8iKN6wGgJMqa+1YUa/g2dXrPqBJa+McF/UNmMDY8+3OABYdYctiN0A2DEaVce
         LJpLJB1f8JHUBDKKqtImQ+k1vnFcqt7aehSxnSl/FYyFQQI/BfvYBYB+ls9WaiDz6d
         OA5xATpMcvLGQ==
Date:   Mon, 4 Dec 2023 11:46:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <20231204114623.3aaa98d2@jic23-huawei>
In-Reply-To: <ZWtU836_yYWgMYZp@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
        <20231126183334.625d2d8b@jic23-huawei>
        <ZWX55o_-WT5BQlo-@sunspire>
        <20231201182453.00005673@Huawei.com>
        <ZWtU836_yYWgMYZp@sunspire>
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

On Sat, 2 Dec 2023 18:01:55 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello!
> 
> On Fri, Dec 01, 2023 at 06:24:53PM +0000, Jonathan Cameron wrote:
> > > > > +static int hsc_spi_probe(struct spi_device *spi)
> > > > > +{
> > > > > +	struct iio_dev *indio_dev;
> > > > > +	struct hsc_data *hsc;
> > > > > +	struct device *dev = &spi->dev;
> > > > > +
> > > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > > > > +	if (!indio_dev)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	hsc = iio_priv(indio_dev);
> > > > > +	hsc->xfer = hsc_spi_xfer;  
> > > > 
> > > > Also, pass the callback and spi->dev into hsc probe. Easy to use
> > > > a container_of() to get back to the struct spi_device *spi    
> > > 
> > > I'd rather simply pass along the client struct.
> > >   
> > 
> > I don't like the fact it has to be a void *
> > 
> > The core code has no idea what is in there.  At least we constraint it
> > somewhat with a struct device.  
> 
> but ...
> that is the nice part. the core code never needs to know what exactly is behind
> that pointer, since it only gets used by the i2c/spi module that provided that
> pointer in the first place. I've never seen a better use of void * :)
> 
> I could define a
> 
> struct client_handle;
> 
> in the .h, use a pointer to that that as function argument, do a lot of
> castings, but I feel like it's still a void * with extra steps.

Usual trick for this is either use struct device and container_of or
an anonymous union wrapped up in a struct.

struct hsc_client_handle {
	union {
		struct i2c_client *i2c_client;
		struct spithingy *spi_client;
	};
};

Then assign appropriate element and pass the containing struct around.
No casting needed.
Aim is to define it as a constrained type that can only take one or the other of
the types in the union. 

Jonathan


> 
> cheers,
> peter
> 

