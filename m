Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0277AD8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjIYNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIYNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:16:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C3107;
        Mon, 25 Sep 2023 06:16:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvNf037XGz6J72G;
        Mon, 25 Sep 2023 21:15:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 14:16:30 +0100
Date:   Mon, 25 Sep 2023 14:16:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <20230925141629.00004522@Huawei.com>
In-Reply-To: <7ff22aa4-475c-b524-9f7a-f47ad02e940b@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
        <029b4e3e18c76b330b606f5b14699e5ee4e5ed35.1695380366.git.mazziesaccount@gmail.com>
        <20230924165737.54631dd3@jic23-huawei>
        <7ff22aa4-475c-b524-9f7a-f47ad02e940b@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 10:01:09 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/24/23 18:57, Jonathan Cameron wrote:
> > On Fri, 22 Sep 2023 14:16:08 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The iio_generic_buffer can return garbage values when the total size of
> >> scan data is not a multiple of largest element in the scan. This can be
> >> demonstrated by reading a scan consisting for example of one 4 byte and
> >> one 2 byte element, where the 4 byte elemnt is first in the buffer.
> >>
> >> The IIO generic buffert code does not take into accunt the last two
> >> padding bytes that are needed to ensure that the 4byte data for next
> >> scan is correctly aligned.
> >>
> >> Add padding bytes required to align the next sample into the scan size.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >> Please note, This one could have RFC in subject.:
> >> I attempted to write the fix so that the alignment is done based on the
> >> biggest channel data. This may be wrong. Maybe a fixed 8 byte alignment
> >> should be used instead? This patch can be dropped from the series if the
> >> fix is not correct / agreed.
> >>
> >>   tools/iio/iio_generic_buffer.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> >> index 44bbf80f0cfd..fc562799a109 100644
> >> --- a/tools/iio/iio_generic_buffer.c
> >> +++ b/tools/iio/iio_generic_buffer.c
> >> @@ -54,9 +54,12 @@ enum autochan {
> >>   static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
> >>   {
> >>   	unsigned int bytes = 0;
> >> -	int i = 0;
> >> +	int i = 0, max = 0;
> >> +	unsigned int misalignment;
> >>   
> >>   	while (i < num_channels) {
> >> +		if (channels[i].bytes > max)
> >> +			max = channels[i].bytes;
> >>   		if (bytes % channels[i].bytes == 0)
> >>   			channels[i].location = bytes;
> >>   		else
> >> @@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
> >>   		bytes = channels[i].location + channels[i].bytes;
> >>   		i++;
> >>   	}
> >> +	/*
> >> +	 * We wan't the data in next sample to also be properly aligned so
> >> +	 * we'll add padding at the end if needed. TODO: should we use fixed
> >> +	 * 8 byte alignment instead of the size of the biggest samnple?
> >> +	 */  
> > 
> > Should be aligned to max size seen in the scan.  
> 
> Or, maybe it should be
> min(max_size_in_scan, 8);
> ?

Definitely not.   If you are grabbing just one channel of 8 bit data,
we want it to be tightly packed.

If we have a bug that already made that true then we might be stuck
with it, but I'm fairly sure we don't.
> 
> I think my suggestion above may yield undesirable effects should the 
> scan elements be greater than 8 bytes. (Don't know if this is supported 
> though)

It is supported in theory, in practice not seen one yet.

> 
> >   
> >> +	misalignment = bytes % max;
> >> +	if (misalignment) {
> >> +		printf("Misalignment %u. Adding Padding %u\n", misalignment,  max - misalignment);  
> > 
> > No print statement as this is correct behaviour (well the tool is buggy but the kernel generates it
> > correctly I believe).  Fine to add a comment though!  
> 
> Oh, indeed. The print was forgotten from my test runs. Thanks for 
> pointing it out!
> 
> >   
> >> +		bytes += max - misalignment;
> >> +	}
> >>   
> >>   	return bytes;
> >>   }  
> >   
> 
> Yours,
> 	-- Matti
> 

