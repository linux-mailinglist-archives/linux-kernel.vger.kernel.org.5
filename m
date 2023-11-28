Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE57FC238
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjK1OcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbjK1OcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:32:03 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4281702;
        Tue, 28 Nov 2023 06:32:09 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id E682828EE6F;
        Tue, 28 Nov 2023 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701181928;
        bh=R7gI18pL+5FP+C77LHDW4m+kGE5GKSW9p/MbTSMPxI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pner+R5ZzBoF4d9Im0tnCFaHXFemE3NLZugvt6BTLBsbq+nEmE+d8OWHqYX6etZtR
         I0uyGZv6XPkDpb+sLwoq/J/d1I0a2BbaM0rcreOYouaxG3pKaeBs/rXriI5X74FKnL
         +hHYIUY9db+j06v8q0rGNGM4uxyLyOKoI+3yjtCk=
Date:   Tue, 28 Nov 2023 16:32:06 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWX55o_-WT5BQlo-@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
 <20231126183334.625d2d8b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126183334.625d2d8b@jic23-huawei>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

On Sun, Nov 26, 2023 at 06:33:34PM +0000, Jonathan Cameron wrote:
> On Sun, 26 Nov 2023 12:27:17 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> > Adds driver for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors. 
>
> Hi Petre
> 
> A quick end of day review.
> 
> Jonathan

welcome back.
amazing how you were able to review so many code sets in one day.
thank you for your input.

> > +#define     HSC_PRESSURE_TRIPLET_LEN  6
> 
> Can you make this length based on something like a structure length, or number
> of registers?  That would make it self documenting which is always nice to have.

I added a comment in V4, this length is simply based on the string used by
honeywell to differentiate these chips based on their pressura range, 
measurement unit and sensor type. see the first column in Table 8, 9, 10 in [1]

[1] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf

> > +struct hsc_data {
> > +	void *client;
> > +	const struct hsc_chip_data *chip;
> > +	struct mutex lock;
> > +	int (*xfer)(struct hsc_data *data);
> > +	bool is_valid;
> > +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE];
> 
> This is used for SPI transfers so should be DMA safe. It's not currently.
> Look at how IIO_DMA_MINALIGN is used in other drivers to ensure there is
> no unsafe sharing of cachelines.
> 
> On some architectures this is fixed by the stuff that bounces all small transfers
> but I don't think that is universal yet.  If you want more info find the talk
> by Wolfram Sang from a few years ago an ELCE on I2C DMA safe buffers.

that was a nice rabbit hole, thanks for the pointer.

now, based on [2] I will skip explicit i2c dma-related code since my requests
are 4 bytes long. according to the document, any i2c xfer below 8bytes is not
worth the overhead.

[2] https://www.kernel.org/doc/html/latest/i2c/dma-considerations.html

> > +static int hsc_spi_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct hsc_data *hsc;
> > +	struct device *dev = &spi->dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	hsc = iio_priv(indio_dev);
> > +	hsc->xfer = hsc_spi_xfer;
> 
> Also, pass the callback and spi->dev into hsc probe. Easy to use
> a container_of() to get back to the struct spi_device *spi

I'd rather simply pass along the client struct.

> > +	hsc->client = spi;
> > +
> > +	return hsc_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
> > +			 spi_get_device_id(spi)->driver_data);
> Don't use anything form spi_get_device_id()
> 
> Name is a fixed string currently so pass that directly.
> For driver data, there isn't any yet but if there were use
> spi_get_device_match_data() and make sure to provide the data in all the
> id tables.  That function will search the firmware ones first then call
> back to the spi specific varient.

along the way driver_data became redundant, so it was removed from the function
prototype.

best regards,
peter

