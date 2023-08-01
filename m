Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D976BBBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjHARzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHARzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CC1BF6;
        Tue,  1 Aug 2023 10:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99E76154F;
        Tue,  1 Aug 2023 17:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04115C433C8;
        Tue,  1 Aug 2023 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912501;
        bh=9+iH7eVxFr4wHi/N95S6chs7KFxakju7TNL5dJY/X4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lG3Vaeavv2JUipv1eLk91e2CQ/94rkNiLm7pEduScTyvjRg70aeNgvTRBrn+6DfDs
         +FfcRdH8xGy94j1nc5YxdNHaEhVOCRSaojCrtHfcfUdy/1moxlTK3dBfqhQPiAg4Uu
         01cy8BKmjIwuavn1p97tHW/enwweF8Iv53Tpq182AFElni1VxxGhpWM+5MjfcGnl0B
         fczonjKdWDCQSvjmOClA4ZaM7WpgLe912vzkcvqo0xxN3MOJ76PfAVhvzmA9awJkJd
         icfHQR0E4hgnVtvFl0d3wxALbz4vjtbwWzAehMRydKaQfg4QnJTG7tUZrnD26Tqt+Z
         oju3JylN43LOw==
Date:   Tue, 1 Aug 2023 18:54:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/8] iio: cdc: ad7150: relax return value check for
 IRQ get
Message-ID: <20230801185454.0d115aaa@jic23-huawei>
In-Reply-To: <3ad1c6f195ead3dfa8711235e1dead139d27f700.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
        <3ad1c6f195ead3dfa8711235e1dead139d27f700.1690890774.git.mazziesaccount@gmail.com>
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

On Tue, 1 Aug 2023 15:02:47 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> fwnode_irq_get[_byname]() were changed to not return 0 anymore. The
> special error case where device-tree based IRQ mapping fails can't no
> longer be reliably detected from this return value. This yields a
> functional change in the driver where the mapping failure is treated as
> an error.
> 
> The mapping failure can occur for example when the device-tree IRQ
> information translation call-back(s) (xlate) fail, IRQ domain is not
> found, IRQ type conflicts, etc. In most cases this indicates an error in
> the device-tree and special handling is not really required.
> 
> One more thing to note is that ACPI APIs do not return zero for any
> failures so this special handling did only apply on device-tree based
> systems.
> 
> Drop the special handling for DT mapping failures as these can no longer
> be separated from other errors at driver side. Change all failures in
> IRQ getting to be handled by continuing without the events instead of
> aborting the probe upon certain errors.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Again, fiddled tags so I don't have RB and SoB

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> 
> ---
> Revision history:
> v5 => v6:
>  - Never abort the probe when IRQ getting fails but continue without
>    events.
> 
> Please note that I don't have the hardware to test this change.
> Furthermore, testing this type of device-tree error cases is not
> trivial, as the question we probably dive in is "what happens with the
> existing users who have errors in the device-tree". Answering to this
> question is not simple.
> 
> The patch changing the fwnode_irq_get() got merged during 5.4:
> https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
> This is a clean-up as agreed.
> ---
>  drivers/iio/cdc/ad7150.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
> index d656d2f12755..4c03b9e834b8 100644
> --- a/drivers/iio/cdc/ad7150.c
> +++ b/drivers/iio/cdc/ad7150.c
> @@ -541,6 +541,7 @@ static int ad7150_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct ad7150_chip_info *chip;
>  	struct iio_dev *indio_dev;
> +	bool use_irq = true;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> @@ -561,14 +562,13 @@ static int ad7150_probe(struct i2c_client *client)
>  
>  	chip->interrupts[0] = fwnode_irq_get(dev_fwnode(&client->dev), 0);
>  	if (chip->interrupts[0] < 0)
> -		return chip->interrupts[0];
> -	if (id->driver_data == AD7150) {
> +		use_irq = false;
> +	else if (id->driver_data == AD7150) {
>  		chip->interrupts[1] = fwnode_irq_get(dev_fwnode(&client->dev), 1);
>  		if (chip->interrupts[1] < 0)
> -			return chip->interrupts[1];
> +			use_irq = false;
>  	}
> -	if (chip->interrupts[0] &&
> -	    (id->driver_data == AD7151 || chip->interrupts[1])) {
> +	if (use_irq) {
>  		irq_set_status_flags(chip->interrupts[0], IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(&client->dev,
>  						chip->interrupts[0],

