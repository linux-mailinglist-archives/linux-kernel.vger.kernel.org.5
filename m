Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFC7BA4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjJEQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjJEQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FCF8E83;
        Thu,  5 Oct 2023 08:30:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAE2C433C8;
        Thu,  5 Oct 2023 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696519820;
        bh=NuCRzVUHR0bnsOcH35H7Igd6EZEuXotDfK6oA+MFivU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSk3o6BMFz/HP6YdCF+ymIM9ZPmIIQKeOBtjR8ZIrBsKjFoHlcMiUp+sSphuRNM62
         QShlaLmJzjOcxIHc/A1sENsoNoMLt8m5shB/GCi4WRYazmSMRRXH3g5C3juu2BNcon
         VFAUaFsOIKXhAcLgHGmmP3gCXcUmamGS9hdRrVnAHnGJrohiavwuRHWw+4jQo09tIv
         +x5ICQZTsJ+cxR7GREtxjgncSFpoKUoA2pYD9Wj+zHX/8epsMIENMqeVRw7tL0XWmH
         W4KPdtQMM2XClL06LSLG/fIOH8TWLekDzTrNH6/lzs/700dGnAFEh5zS2o0dbBtExn
         nx6N2YdOmTIkA==
Date:   Thu, 5 Oct 2023 16:30:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sanity check available_scan_masks array
Message-ID: <20231005163026.2c7707de@jic23-huawei>
In-Reply-To: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
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

On Tue, 3 Oct 2023 12:49:45 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> When IIO goes through the available scan masks in order to select the
> best suiting one, it will just accept the first listed subset of channels
> which meets the user's requirements. If driver lists a mask which is a
> subset of some of the masks previously in the array of
> avaliable_scan_masks, then the latter one will never be selected.
> 
> Add a warning if driver registers masks which can't be used due to the
> available_scan_masks-array ordering.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Hi Matti

Thanks for doing this.  A few comments inline + maybe we need to think
about a unit test for the matching code. I feel we aren't pushing the
corners of that in any drivers so far so it might bite us later.

Still that's a job for another day.

Jonathan

> 
> ---
> The change was suggested by Jonathan here:
> https://lore.kernel.org/lkml/20230924170726.41443502@jic23-huawei/
> ---
>  drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c77745b594bd..d4f37f4eeec0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1896,6 +1896,53 @@ static int iio_check_extended_name(const struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
> +static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
> +{
> +	unsigned int num_masks, masklength, longs_per_mask;
> +	const unsigned long *av_masks;
> +	int i;
> +
> +	av_masks = indio_dev->available_scan_masks;
> +	masklength = indio_dev->masklength;
> +	longs_per_mask = BITS_TO_LONGS(masklength);
> +
> +	if (bitmap_empty(av_masks, masklength))
> +		dev_warn(indio_dev->dev.parent, "empty scan mask\n");

They'd definitely notice this one as you'd never be able to enable the
buffer - if someone hasn't tested that, then meh.  Still this function
is called sanity_check so might as well check for insanity.


> +
> +	for (num_masks = 0; *av_masks; num_masks++)

I think we can't just check *av_masks - need bitmap_empty() as first
long might be 0 but could be bits set in the next one.

> +		av_masks += longs_per_mask;
hmm. Makes me wonder if the available scan mask stuff actually works
for large numbers of channels (so more than one long).  I don't think
we have any drivers that both have large channel counts and use
available_scan_masks.   The code is there to support matching in this
case but probably wants a selftest at somepoint to make sure it will work
if such a device comes along...


> +
> +	if (num_masks < 2)
> +		return;

Not sure it's worth bothering with this early exit route.  The loops
will be trivial anyway if num_masks == 1.


> +
> +	av_masks = indio_dev->available_scan_masks;
> +
> +	/*
> +	 * Go through all the masks from first to one before the last, and see
> +	 * that no mask found later from the available_scan_masks array is a
> +	 * subset of mask found earlier. If this happens, then the mask found
> +	 * later will never get used because scanning the array is stopped when
> +	 * the first suitable mask is found. Drivers should order the array of
> +	 * available masks in the order of preference (presumably the least
> +	 * costy to access masks first).
> +	 */
> +	for (i = 0; i < num_masks - 1; i++) {
> +		const unsigned long *mask1;
> +		int j;
> +
> +		mask1 = av_masks + i * longs_per_mask;
> +		for (j = i + 1; j < num_masks; j++) {
> +			const unsigned long *mask2;
> +
> +			mask2 = av_masks + j * longs_per_mask;
> +			if (bitmap_subset(mask2, mask1, masklength))
> +				dev_warn(indio_dev->dev.parent,
> +					 "available_scan_mask %d subset of %d. Never used\n",
> +					 j, i);
> +		}
> +	}
> +}
> +
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> @@ -1934,6 +1981,16 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		goto error_unreg_debugfs;
>  	}
>  
> +	/*
> +	 * In order to not wreck utter havoc we just warn for now. Might want
> +	 * to convert this to a failure after people have had time to act upon
> +	 * the warning. It'd be nice to check this earlier, but we need the
> +	 * iio_buffers_alloc_sysfs_and_mask() to have the masklength set.

It's not going to break anyone if they get this wrong, they will just waste time
and possibly power reading too many channels!  So warn is appropriate I think.

I'm not sure the comment adds much in general so I'd slim it down or drop it
from v2.

> +	 */
> +	if (indio_dev->available_scan_masks)
> +		iio_sanity_check_avail_scan_masks(indio_dev);
> +
One blank line is enough ;)

> +
>  	ret = iio_device_register_sysfs(indio_dev);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,
> 
> base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec

