Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D37AD8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjIYNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIYNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:17:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6AA2;
        Mon, 25 Sep 2023 06:17:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvNdp4dbPz6D9xP;
        Mon, 25 Sep 2023 21:15:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 14:17:27 +0100
Date:   Mon, 25 Sep 2023 14:17:26 +0100
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
Subject: Re: [PATCH v3 2/6] iio: improve doc for available_scan_mask
Message-ID: <20230925141726.0000325d@Huawei.com>
In-Reply-To: <9c0938d7-7c35-4d46-ec69-4171e0cf14ae@gmail.com>
References: <cover.1695380366.git.mazziesaccount@gmail.com>
        <74b66a5b9eee2fb7046f254928391e3da61aa3b2.1695380366.git.mazziesaccount@gmail.com>
        <20230924165908.5a332fac@jic23-huawei>
        <9c0938d7-7c35-4d46-ec69-4171e0cf14ae@gmail.com>
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

On Mon, 25 Sep 2023 12:50:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/24/23 18:59, Jonathan Cameron wrote:
> > On Fri, 22 Sep 2023 14:16:57 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The available_scan_mask is an array of bitmaps representing the channels
> >> which can be simultaneously enabled by the driver. In many cases the
> >> hardware can offer more channels than what the user is interested in
> >> obtaining. In such cases it may be preferred that only subset of
> >> channels are enabled, and driver reads only a subset of the channels from
> >> the hardware.
> >>
> >> Some devices can't support all channel combinations. For example the
> >> BM1390 pressure sensor must always read the pressure data in order to
> >> acknowledge the watermark IRQ, while reading temperature can be omitted.
> >> So, the available scan mask would be 'pressure and temperature' and
> >> 'pressure only'.
> >>
> >> When IIO seatchs for the scan mask it asks the driver to use, it will  
> > 
> > Spell check description.  searches  
> 
> Oh, right. Thanks!
> 
> >   
> >> pick the first suitable one from the 'available_scan_mask' array. Hence,
> >> ordering the masks in the array makes difference. We should 'prefer'
> >> reading just the pressure from the hardware (as it is cheaper operation
> >> than reading both pressure and temperature) over reading both pressure
> >> and temperature. Hence, we should set the 'only pressure' as first scan
> >> mask in available_scan_mask array. If we set the 'pressure and
> >> temperature' as first in array, then the 'only temperature' will never
> >> get used as 'pressure and temperature' can always serve the user's
> >> needs.
> >>
> >> Add (minimal) kerneldoc to the 'available_scan_mask' to hint the user
> >> that ordering of masks matters.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >>   include/linux/iio/iio.h | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> >> index 202e55b0a28b..7bfa1b9bc8a2 100644
> >> --- a/include/linux/iio/iio.h
> >> +++ b/include/linux/iio/iio.h
> >> @@ -556,7 +556,9 @@ struct iio_buffer_setup_ops {
> >>    *			and owner
> >>    * @buffer:		[DRIVER] any buffer present
> >>    * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
> >> - * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
> >> + * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sort the
> >> + *			   array in order of preference, the most preferred
> >> + *			   masks first.  
> > 
> > LGTM  
> 
> I'll try to spell check the commit message and then I treat this as an 
> ack. Please, let me know if it's not Ok.
Given I'll be picking these up anyway, not a formal Ack that you should carry
with the next version, but looks fine to me.

J

> 
> >>    * @masklength:		[INTERN] the length of the mask established from
> >>    *			channels
> >>    * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers  
> >   
> 

