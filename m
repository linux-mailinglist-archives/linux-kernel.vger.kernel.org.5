Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52067B422E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjI3QeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:34:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C81C6;
        Sat, 30 Sep 2023 09:34:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D08C433C7;
        Sat, 30 Sep 2023 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696091651;
        bh=QN0DUz4XIKMWjuArId5bSKDyvo7SIQjTXOmmbnVcF2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bg5jvZOg4EwLkYjOit6uHQNqkYetAyeY6BTDCJCxARC9rJIpM5LcvOXPdwO+rN9uD
         WwYMGYPHn9ZuEnyHhRfxNGajCg0FsVr8sC5eroaysbHPZCy9OzyRSqF9y92XplA59E
         Nv3+larLCI3pyNkQpq6aAZd2NW7sL4448cSWtQ9KAoMHV6Nwy4qWODuSjUQrb8nVKJ
         BpcA1/WJBIlqOKkDABqecfDEzT+ZVf1iAi3w9icXGrJlGG5AIMgyfEseKGXndU06ap
         uPG7A0GtGG7E56jcXBGm9qjAoOnSjMAptDoC3ddbinSNbrUuyMsy+IlyX6Qefy9Ts0
         X4e/2Ba8wkawA==
Date:   Sat, 30 Sep 2023 17:34:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <20230930173409.4fe38d94@jic23-huawei>
In-Reply-To: <e986b4562ca663e19ea30b81d15221c15bd87227.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
        <e986b4562ca663e19ea30b81d15221c15bd87227.1695727471.git.mazziesaccount@gmail.com>
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

On Wed, 27 Sep 2023 11:26:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The iio_generic_buffer can return garbage values when the total size of
> scan data is not a multiple of the largest element in the scan. This can be
> demonstrated by reading a scan, consisting, for example of one 4-byte and
> one 2-byte element, where the 4-byte element is first in the buffer.
> 
> The IIO generic buffer code does not take into account the last two
> padding bytes that are needed to ensure that the 4-byte data for next
> scan is correctly aligned.
> 
> Add the padding bytes required to align the next sample with the scan size.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> I think the whole alignment code could be revised here, but I am unsure
> what kind of alignment is expected, and if it actually depends on the
> architecture. Anyways, I'll quote myself from another mail to explain
> how this patch handles things:
> 
> > For non power of2 sizes, the alignment code will result strange alignments.
> > For example, scan consisting of two 6-byte elements would be packed -
> > meaning the second element would probably break the alignment rules by
> > starting from address '6'. I think that on most architectures the proper
> > access would require 2 padding bytes to be added at the end of the first
> > sample. Current code wouldn't do that.  
> 
> > If we allow only power of 2 sizes - I would expect a scan consisting of a
> > 8 byte element followed by a 16 byte element to be tightly packed. I'd
> > assume that for the 16 byte data, it'd be enough to ensure 8 byte alignment.
> > Current code would however add 8 bytes of padding at the end of the first
> > 8 byte element to make the 16 byte scan element to be aligned at 16 byte
> > address. To my uneducated mind this is not needed - but maybe I just don't
> > know what I am writing about :)  
> 
> Revision history
> v3 => v4:
>  - drop extra print and TODO coment
>  - add comment clarifying alignment sizes
> ---
>  tools/iio/iio_generic_buffer.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 44bbf80f0cfd..c07c49397b19 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -54,9 +54,12 @@ enum autochan {
>  static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  {
>  	unsigned int bytes = 0;
> -	int i = 0;
> +	int i = 0, max = 0;
> +	unsigned int misalignment;
>  
>  	while (i < num_channels) {
> +		if (channels[i].bytes > max)
> +			max = channels[i].bytes;
>  		if (bytes % channels[i].bytes == 0)
>  			channels[i].location = bytes;
>  		else
> @@ -66,6 +69,19 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>  		bytes = channels[i].location + channels[i].bytes;
>  		i++;
>  	}
> +	/*
> +	 * We wan't the data in next sample to also be properly aligned so
> +	 * we'll add padding at the end if needed.
> +	 *
> +	 * Please note, this code does ensure alignment to maximum channel
> +	 * size. It works only as long as the channel sizes are 1, 2, 4 or 8
> +	 * bytes. Also, on 32 bit platforms it might be enough to align also
> +	 * the 8 byte elements to 4 byte boundary - which this code is not
> +	 * doing.
Very much not!  We need to present same data alignment to userspace
indpendent of what architecture is running. 

It's annoyingly inconsistent how 8 byte elements are handled on 32 bit
architectures as some have optimized aligned access routines and others
will read as 2 32 bit fields.  Hence we just stick to 8 byte value is
8 byte aligned which is always fine but wastes a bit of space on x86 32
bit - which I don't care about ;)

Please drop this last bit of the comment as we should just say what it
does, not conjecture what it might do!



> +	 */
> +	misalignment = bytes % max;
> +	if (misalignment)
> +		bytes += max - misalignment;
>  
>  	return bytes;
>  }

