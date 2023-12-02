Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06483801D9E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjLBQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:01:54 -0500
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEB94;
        Sat,  2 Dec 2023 08:01:59 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 1AE6628EE6F;
        Sat,  2 Dec 2023 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701532917;
        bh=jB8oEC6mjeL2dllM2of5rXMFZjB7XW3eFIvJcBkpmWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=uLhAajAAo+TjG7a0Fh4VrOH3X3D00QY7UL9uAav0gJvvnLaWnpNacmHpqxFxUXsNE
         Frbs/MOfShNfXMJhQVRY7C+R6lxpcvjHqPbEgvS7fc+fTMUx6nw8y6HD1ASYgg3tru
         g2Q3f4/tJEmfJqzo9XwfRcH9tuoBlk7mqjnwWrWk=
Date:   Sat, 2 Dec 2023 18:01:55 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWtU836_yYWgMYZp@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
 <20231126183334.625d2d8b@jic23-huawei>
 <ZWX55o_-WT5BQlo-@sunspire>
 <20231201182453.00005673@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201182453.00005673@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

On Fri, Dec 01, 2023 at 06:24:53PM +0000, Jonathan Cameron wrote:
> > > > +static int hsc_spi_probe(struct spi_device *spi)
> > > > +{
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct hsc_data *hsc;
> > > > +	struct device *dev = &spi->dev;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hsc = iio_priv(indio_dev);
> > > > +	hsc->xfer = hsc_spi_xfer;
> > > 
> > > Also, pass the callback and spi->dev into hsc probe. Easy to use
> > > a container_of() to get back to the struct spi_device *spi  
> > 
> > I'd rather simply pass along the client struct.
> > 
> 
> I don't like the fact it has to be a void *
> 
> The core code has no idea what is in there.  At least we constraint it
> somewhat with a struct device.

but ...
that is the nice part. the core code never needs to know what exactly is behind
that pointer, since it only gets used by the i2c/spi module that provided that
pointer in the first place. I've never seen a better use of void * :)

I could define a

struct client_handle;

in the .h, use a pointer to that that as function argument, do a lot of
castings, but I feel like it's still a void * with extra steps.

cheers,
peter
