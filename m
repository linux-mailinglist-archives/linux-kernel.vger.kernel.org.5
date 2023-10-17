Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417657CBE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjJQJF6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjJQJFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:05:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC9FD;
        Tue, 17 Oct 2023 02:05:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8p3B6DLfz6K9Jt;
        Tue, 17 Oct 2023 17:05:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 10:05:40 +0100
Date:   Tue, 17 Oct 2023 10:05:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Message-ID: <20231017100539.000039b0@Huawei.com>
In-Reply-To: <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
        <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
        <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
        <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 12:05:32 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> 2023-10-16 at 10:39, Linus Walleij wrote:
> > On Sun, Oct 15, 2023 at 12:38 AM Peter Rosin <peda@axentia.se> wrote:  
> >> 2023-09-02 at 21:46, Linus Walleij wrote:  
> >   
> >>>       if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
> >>> -         iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> >>> -             dev_info(dev, "using raw+scale source channel\n");
> >>> +         (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
> >>> +          iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
> >>> +             dev_info(dev, "using raw+scale/offset source channel\n");  
> >>
> >> If the rules really are that when not provided scale is 1 and offset 0
> >> (reasonable of course) then the above still looks suspect to me. Should
> >> this part not simply be
> >>
> >>         if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
> >>                 dev_info(dev, "using raw source channel\n");
> >>
> >> in that case?  
> > 
> > The patch is based on Jonathan's comment that while we currently
> > support raw+scale, having just raw+offset provided is a possibility.
> > 
> > The if()-clause above (which I guess you are commenting) is meant
> > as "take this path if scale or offset or both are provided".
> > 
> > Just raw (with neither offset or rescale) doesn't make sense, since  
> 
> And I don't see why not. That's the crux.
> 
> > the AFE rescaler does just offsetting and rescaling, in that case the
> > user should just use the raw channel. Also it would then take
> > precedence over a processed channel (which applies rescale and
> > offset internally) which doesn't make sense to me.  
> 
> Why isn't it perfectly fine for a device to provide only a raw
> channel and then expect that to be interpreted as the real unit?
> Why would it need a processed channel when no processing is
> going on? E.g. a device reporting the temp in the expected unit
> in one of its registers. Or whatever with such a friendly
> register.

In that case it should report a processed value to indicate that.
It's admittedly a bit of a corner case given it's not processed by
the kernel - there is an argument that this (more or less) only
happens when someone has processed a raw ADC count but in theory
that's not necessarily true.

There are a few examples of drivers passing through the register value
as processed in tree - normally when there
is a microprocessor doing some fusion of signals or similar.

Raw gets reported on it's own in a few other cases, such as when
there are no known units - that happens for things like light intensity,
proximity (which is often reflected light intensity).
For those I'm not sure the rescaler is useful.

> 
> And if the above holds, it should also be perfectly fine to run
> that through the rescaler.
> 
> >   
> >> Or was "raw + processed" some kind of special case that we want to handle
> >> as processed? If that's the case then we need to have more complex logic.  
> > 
> > Processed is on the else-path, which will be tried only when neither
> > scale nor offset is provided:
> >   
> >>       } else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
> >>               dev_info(dev, "using processed channel\n");
> >>               rescale->chan_processed = true;  
> > 
> > I'm not sure I fully understood the remark, please elaborate if I got it wrong!  
> 
> I agree that the patch does exactly as you intend. I question if
> what you intend is correct, but since I don't know the rules, I'd
> simply like to have the rules clarified.
> 
> Is that clearer?
> 
> Cheers,
> Peter

