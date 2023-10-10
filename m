Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4207BF82D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjJJKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjJJKEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:04:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD9B94;
        Tue, 10 Oct 2023 03:04:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A2C433CB;
        Tue, 10 Oct 2023 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696932247;
        bh=mn3zjhWL1qWRx7zYIkF0MFuS9a9Ph4ybWsNqNi7p9RA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eRtkSJsQ3dfCQMb7oQW95nJMO26WCjQCoKf8tqZqbDsonqiBF/IjMLU97HrZkkNW7
         T/6TTVWjANzlKk8Qoe/a8j5X3Sk2VHvFFlrBQzSTppB0zm/NooySI9Qfk9KG1yS6rz
         0xoPFEX5Y9c+i8RU3FR6cMzqEzGsPybwPjkR0ivCe87Xf9nThWU8m87MfVw09HTfKK
         rafD0FQ2SIhyija0nRC6XkGtatVfC61aANJygoiFDNcMZhNAxqJV9G5FZqf17giGZD
         upW1unQ7zYBhLKwH/jQzIXx34xcdUsFl2+bOKzeOhs2EqdXpqSzS2ZOYh7qRw9RosI
         3h1r63JY7DKKg==
Date:   Tue, 10 Oct 2023 11:04:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sanity check available_scan_masks array
Message-ID: <20231010110419.00899e0e@jic23-huawei>
In-Reply-To: <751a87c9-a4aa-4e06-1d12-1e2b1a3487de@gmail.com>
References: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
        <20231005163026.2c7707de@jic23-huawei>
        <751a87c9-a4aa-4e06-1d12-1e2b1a3487de@gmail.com>
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

On Fri, 6 Oct 2023 14:10:16 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Again Jonathan.
> 
> On 10/5/23 18:30, Jonathan Cameron wrote:
> > On Tue, 3 Oct 2023 12:49:45 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> When IIO goes through the available scan masks in order to select the
> >> best suiting one, it will just accept the first listed subset of channels
> >> which meets the user's requirements. If driver lists a mask which is a
> >> subset of some of the masks previously in the array of
> >> avaliable_scan_masks, then the latter one will never be selected.
> >>
> >> Add a warning if driver registers masks which can't be used due to the
> >> available_scan_masks-array ordering.
> >>
> >> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > Hi Matti
> > 
> > Thanks for doing this.  A few comments inline + maybe we need to think
> > about a unit test for the matching code. I feel we aren't pushing the
> > corners of that in any drivers so far so it might bite us later.
> > 
> > Still that's a job for another day.
> > 
> > Jonathan
> >   
> >>
> >> ---
> >> The change was suggested by Jonathan here:
> >> https://lore.kernel.org/lkml/20230924170726.41443502@jic23-huawei/
> >> ---
> >>   drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 57 insertions(+)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index c77745b594bd..d4f37f4eeec0 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -1896,6 +1896,53 @@ static int iio_check_extended_name(const struct iio_dev *indio_dev)  
> 
> ...
> 
> >> +
> >> +	for (num_masks = 0; *av_masks; num_masks++)  
> > 
> > I think we can't just check *av_masks - need bitmap_empty() as first
> > long might be 0 but could be bits set in the next one.
> >   
> >> +		av_masks += longs_per_mask;  
> 
> I did switch this to:
> +       for (num_masks = 0; !bitmap_empty(av_masks, masklength); 
> num_masks++)
> +               av_masks += longs_per_mask;
> 
> but this kind of freaks me out.

Good because I'm fairly sure you need to reduce the masklength int hat
bitmap_empty as well.  It is getting a bit complex.


> 
> I think in kernel we see two ways of constructing and passing arrays to 
> frameworks. One is creating a NULL terminated array, the other being an 
> array which size is given. The available_scan_masks is using the first 
> approach.
> 
> The array represents bitmasks, which are thought to be of arbitrary 
> length. The type of array items is longs though. When building an arry 
> like this, it is easy to just do:
> 
> unsigned long masks[] = {
> 	mask1_hi,
> 	mask1_lo,
> 	mask2_hi,
> 	mask2_lo,
> 	...
> 	maskN_lo,
> 	/* sentinel */
> 	0
> }
> 
> (By the way, I've always hated that 'sentinel' comment as it - in my 
> opinion - is not worth adding. I think the meaning of 0 should be 
> obvious, but here I just added it to alleviate the problem).
> 
> Here, if I'm not mistaken, the check I implemented would go reading out 
> of the array bounds.

It does indeed.


> 
> Knowing how easy it would be slip the above array past my reviewing eyes 
> - I find this scary. And ugly part of this is that we can't detect this 
> in the iio-core side, because we have no way of knowing how big the 
> array and sentinel are. What makes this worse is that the core does:
> 
> for (i = 0; i < indio_dev->num_channels; i++)
>                          ml = max(ml, channels[i].scan_index + 1);
>                  indio_dev->masklength = ml;
> 
> so, masklength may not be what was set in driver.

IIRC this is there to allow for sparse scan_index values.  Those are
very rare, but I think there are a few drivers doing that because
it allowed for slightly simpler code a long time back.  May not even
matter today.  Key is that mask_length is big enough to allow the
bits at all present scan_index values to be set.

So it should always match with the drivers where this is used to make
sure available_scan_masks has the right number of longs per entry,
but the drivers may need to be a little clever if they are both
doing large numbers of channels and sparse scan_index values.
AFAIK there are none doing that. Going further I don't recall any
drivers that use the available_scan_masks stuff going beyond 32
channels (so needing more than one unsigned long per element).

> 
> I did quick and dirty grep for "_scan_mask\[" in iio directory and 
> didn't spot any bigger than a few channels masks. Still, this makes me 
> worried.
> 
> BTW: I did also:
> 
> Author: Matti Vaittinen <mazziesaccount@gmail.com>
> Date:   Fri Oct 6 13:53:11 2023 +0300
> 
>      iio: buffer: use bitmap_empty() to find last mask
> 
>      When IIO buffer code is scanning the array of available masks for
>      matching the user's enable request to channel configuration 
> supported by
>      driver, the code uses a 'check for long 0' as indication of last mask.
>      This does not work right for channel masks greater than BITS_PER_LONG.
> 
>      Use bitmap_empty() to find the last element in available_scan_masks
>      array.
> 
>      Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>      ---
>      NOTE: This is potentially hazardous change. Please, don't pick without
>      thorough check and understanding.
> 
> diff --git a/drivers/iio/industrialio-buffer.c 
> b/drivers/iio/industrialio-buffer.c
> index 176d31d9f9d8..1e59afddcf9a 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -413,7 +413,7 @@ static const unsigned long 
> *iio_scan_mask_match(const unsigned long *av_masks,
>   {
>          if (bitmap_empty(mask, masklength))
>                  return NULL;
> -       while (*av_masks) {
> +       while (!bitmap_empty(av_masks, masklength)) {
>                  if (strict) {
>                          if (bitmap_equal(mask, av_masks, masklength))
>                                  return av_masks;
> 
> but this is just as fragile - for obvious reasons.
Ah. yes, that is indeed a bug.  I'm not sure your fix is particularly
fragile though.  This comes back to us having no drivers that actually use
big bitmaps yet.

Key is that we need the available_scan_masks null terminator to be the
same length as any other entry - so if multiple unsigned longs needed
then multiple 0's should be there.  We should definitely document that
and ideally add a test case.   We can bulk out the dummy driver
to trigger these and provide an example of how available_scan_masks
should be set.

> 
> One way around this would be to have the first bit in the long always 
> set for a valid mask - and take this into account when going through the 
> masks. It's probably somewhat more confusing than current code though - 
> but it would allow using just a single long (with all - or  at least 
> first - bits zero to indicate end of masks).

Too complex.

> 
> Other option I see is to just error out if available_scan_masks array is 
> given with larger than one 'long' wide masks and worry things when this 
> breaks.

That would kick the problem into the long grass.

> 
> Anyways, I don't like using bitmap_empty() for array of bitmaps which 
> may be longer than BITS_PER_LONG unless we can sanity check the size of 
> the array...
> 
> How do you feel about this?

Agreed it's problematic as that null terminator isn't clearly forced to
be big enough.  Hmm. Can we cheat for any drivers that actually need large
masks (when they come along) and use an appropriate 2D array.

unsigned long available_masks[][2] = {
	{mask0_ll, mask0_hl},
	{mask0_ll, mask0_hl},
	{}
};

	iio_dev->available_scan_masks = (unsigned long *)available_masks;

If we put such an example into the dummy / example driver then that might
act to avoid us getting bugs in future + test the fix you have above and
related.

Jonathan

> 
> Yours,
> 	-- Matti
> 

