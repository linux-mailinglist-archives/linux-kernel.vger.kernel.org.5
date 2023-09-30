Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29857B4221
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjI3Q1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3Q1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:27:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33DA4;
        Sat, 30 Sep 2023 09:27:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D51C433C7;
        Sat, 30 Sep 2023 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696091255;
        bh=+088iW0UMANAokgkBFuPTbVCjL9y7V6oanlnC+U+iW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hYLOloRRyAyDqd3RnWhpqSTs2aKZdWjxLN9WNKZKxCWF+UPjCtNv7mm3dbHHq/xir
         hYCHposnFCGyT5M2l2VfE2GFPzvuECaFyRBiS+YQEqb/n7TzlvsdzQwdqWEX80vzL1
         oIE1wAbR+iKK77FO7Axo3qN80lrE9soDQKGKiR44tb6R3Z2VGKvj1Di4OJLw2MxQ8Q
         sEhtfsHde9Fc/Hb/twpTKmZT5AHFhPcIfAfThJR2rjuzPfcvl8HHQYWTuoKIRBQT5M
         TbHoGRb4vPfjGBy6pKRFErhCuYS9J23MSnAsHBcCNz36MZqJMHln6eHL1E3IPHS04l
         eyfbQgFaTuXaA==
Date:   Sat, 30 Sep 2023 17:27:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <20230930172733.23844ce7@jic23-huawei>
In-Reply-To: <50587108-4ba7-3885-0669-7efaf5528233@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
        <029b4e3e18c76b330b606f5b14699e5ee4e5ed35.1695380366.git.mazziesaccount@gmail.com>
        <20230924165737.54631dd3@jic23-huawei>
        <7ff22aa4-475c-b524-9f7a-f47ad02e940b@gmail.com>
        <20230925141629.00004522@Huawei.com>
        <50587108-4ba7-3885-0669-7efaf5528233@gmail.com>
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

On Tue, 26 Sep 2023 13:29:02 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/25/23 16:16, Jonathan Cameron wrote:
> > On Mon, 25 Sep 2023 10:01:09 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 9/24/23 18:57, Jonathan Cameron wrote:  
> >>> On Fri, 22 Sep 2023 14:16:08 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> >>>> The iio_generic_buffer can return garbage values when the total size of
> >>>> scan data is not a multiple of largest element in the scan. This can be
> >>>> demonstrated by reading a scan consisting for example of one 4 byte and
> >>>> one 2 byte element, where the 4 byte elemnt is first in the buffer.
> >>>>
> >>>> The IIO generic buffert code does not take into accunt the last two
> >>>> padding bytes that are needed to ensure that the 4byte data for next
> >>>> scan is correctly aligned.
> >>>>
> >>>> Add padding bytes required to align the next sample into the scan size.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>> ---
> >>>> Please note, This one could have RFC in subject.:
> >>>> I attempted to write the fix so that the alignment is done based on the
> >>>> biggest channel data. This may be wrong. Maybe a fixed 8 byte alignment
> >>>> should be used instead? This patch can be dropped from the series if the
> >>>> fix is not correct / agreed.
> >>>>
> >>>>    tools/iio/iio_generic_buffer.c | 15 ++++++++++++++-
> >>>>    1 file changed, 14 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> >>>> index 44bbf80f0cfd..fc562799a109 100644
> >>>> --- a/tools/iio/iio_generic_buffer.c
> >>>> +++ b/tools/iio/iio_generic_buffer.c
> >>>> @@ -54,9 +54,12 @@ enum autochan {
> >>>>    static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
> >>>>    {
> >>>>    	unsigned int bytes = 0;
> >>>> -	int i = 0;
> >>>> +	int i = 0, max = 0;
> >>>> +	unsigned int misalignment;
> >>>>    
> >>>>    	while (i < num_channels) {
> >>>> +		if (channels[i].bytes > max)
> >>>> +			max = channels[i].bytes;
> >>>>    		if (bytes % channels[i].bytes == 0)
> >>>>    			channels[i].location = bytes;
> >>>>    		else
> >>>> @@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
> >>>>    		bytes = channels[i].location + channels[i].bytes;
> >>>>    		i++;
> >>>>    	}
> >>>> +	/*
> >>>> +	 * We wan't the data in next sample to also be properly aligned so
> >>>> +	 * we'll add padding at the end if needed. TODO: should we use fixed
> >>>> +	 * 8 byte alignment instead of the size of the biggest samnple?
> >>>> +	 */  
> >>>
> >>> Should be aligned to max size seen in the scan.  
> >>
> >> Or, maybe it should be
> >> min(max_size_in_scan, 8);
> >> ?  
> > 
> > Definitely not.   If you are grabbing just one channel of 8 bit data,
> > we want it to be tightly packed.  
> 
> I think that in this case the max_size_in_scan would be 1, and min(1, 8) 
> would be 1 as well, resulting a tightly packed data. I am just wondering 
> if we should use 8 as maximum alignment - eg, if our scan has 16 bytes 
> data + 1 byte data, we would add 7 bytes of padding, not 15 bytes of 
> padding. I am not sure what is the right thing to do.
Ah I read that backwards as you've noticed.

We don't have any such big channels, so indeed have some flexibility here.
I think we stick to naturally aligned so 16 bytes case would be 16 byte
aligned - mostly because I don't expect to see one any time soon and
because it makes the docs simpler.

> 
> > If we have a bug that already made that true then we might be stuck
> > with it, but I'm fairly sure we don't.  
> >>
> >> I think my suggestion above may yield undesirable effects should the
> >> scan elements be greater than 8 bytes. (Don't know if this is supported
> >> though)  
> > 
> > It is supported in theory, in practice not seen one yet.  
> 
> So, whether to unconditionally use largest scan element sized alignment 
> - or largest scan element up to 8 bytes - is a question we haven't hit 
> yet :)
> 
> Actually, more I stare at the alignment code here, less sure I am it is 
> correct - but maybe I don't understand how the data should be aligned.
> 
> I think it works if allowed data sizes are 1, 2, 4, and 8. However, I 
> suspect it breaks for other sizes.

Indeed - it's meant to be power of 2 only. More than possible we don't check
that rigorously enough or have it clearly documented though.

The aim is for the data to be padded for efficient accesses
+ because it is a pain to deal with arbitrary padding so we restrict
it to power of 2 naturally aligned only.  One relaxation we've talked
about in the past is packing multiple channels per byte (for logic
analyser cases). Not done it yet though.

> 
> For non power of2 sizes, the alignment code will result strange 
> alignments. For example, scan consisting of two 6-byte elements would be 
> packed - meaning the second element would probably break the alignment 
> rules by starting from address '6'. I think that on most architectures 
> the proper access would require 2 padding bytes to be added at the end 
> of the first sample. Current code wouldn't do that.
> 
> If we allow only power of 2 sizes - I would expect a scan consisting of 
> a 8 byte element followed by a 16 byte element to be tightly packed. I'd 
> assume that for the 16 byte data, it'd be enough to ensure 8 byte 
> alignment. Current code would however add 8 bytes of padding at the end 
> of the first 8 byte element to make the 16 byte scan element to be 
> aligned at 16 byte address. To my uneducated mind this is not needed - 
> but maybe I just don't know what I am writing about :)

16 byte alignement is probably not needed - but who knows for future
architecture. Note this has been really non obvious in the past and
is why we force alignment for timestamp elements in lots of drivers.

Most architectures align an s64 in a c structure to an 8 byte boundary
but x86 32 bit doesn't.  Hence we have to force it all over the place.

Fixing that (because userspace ABI data placement should not vary across
architectures) was a pain. I don't want to do it again!

> 
> In any case, the patch here should fix things when allowed scan element 
> sizes are 1, 2, 4 and 8 and we have to add padding after last scan 
> element. It won't work for other sizes, but as I wrote, I suspect the 
> whole alignment code here may be broken for other sizes so things 
> shouldn't at least get worse with this patch... I think this should be 
> revised if we see samples of other sizes - and in any case, this might 
> at least warrant a comment here :) (I reserve a right to be wrong. 
> Haven't been sleeping too well lately and my head is humming...)

Might be worth a power of 2 only comment.

J
