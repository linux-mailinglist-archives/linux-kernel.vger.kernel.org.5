Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1397A66B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjISO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjISO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:29:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62BBC;
        Tue, 19 Sep 2023 07:29:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqkWf14Jnz6HJh1;
        Tue, 19 Sep 2023 22:27:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 15:29:09 +0100
Date:   Tue, 19 Sep 2023 15:29:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Wadim Egorov <W.Egorov@phytec.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "mugunthanvnm@ti.com" <mugunthanvnm@ti.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
        "nm@ti.com" <nm@ti.com>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Message-ID: <20230919152908.000041be@Huawei.com>
In-Reply-To: <f2b18c8b-97f9-49c5-a4a1-a3d5c1ae13eb@phytec.de>
References: <20230914121300.845493-1-w.egorov@phytec.de>
        <20230917114552.3f5cd081@jic23-huawei>
        <f2b18c8b-97f9-49c5-a4a1-a3d5c1ae13eb@phytec.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 19 Sep 2023 10:21:28 +0000
Wadim Egorov <W.Egorov@phytec.de> wrote:

> Hi Jonathan,
> 
> Am 17.09.23 um 12:45 schrieb Jonathan Cameron:
> > On Thu, 14 Sep 2023 14:13:00 +0200
> > Wadim Egorov <w.egorov@phytec.de> wrote:
> >  
> >> DMAs are optional. Even if the DMA request is unsuccessfully,
> >> the ADC can still work properly.
> >> Make tiadc_request_dma() not fail if we do not provide dmas &
> >> dma-names properties.
> >>
> >> This actually fixes the wrong error handling of the tiadc_request_dma()
> >> result where the probing only failed if -EPROPE_DEFER was returned.
> >>
> >> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
> >>  
> > No line break here.  Fixes tag is part of the main tag block.  
> >> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>  
> >  
> >> ---
> >>   drivers/iio/adc/ti_am335x_adc.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> >> index 8db7a01cb5fb..e14aa9254ab1 100644
> >> --- a/drivers/iio/adc/ti_am335x_adc.c
> >> +++ b/drivers/iio/adc/ti_am335x_adc.c
> >> @@ -543,8 +543,11 @@ static int tiadc_request_dma(struct platform_device *pdev,
> >>   	if (IS_ERR(dma->chan)) {
> >>   		int ret = PTR_ERR(dma->chan);
> >>   
> >> +		if (ret != -ENODEV)
> >> +			return dev_err_probe(&pdev->dev, ret,
> >> +					     "RX DMA channel request failed\n");
> >>   		dma->chan = NULL;
> >> -		return ret;
> >> +		return 0;
> >>   	}
> >>   
> >>   	/* RX buffer */
> >> @@ -670,7 +673,7 @@ static int tiadc_probe(struct platform_device *pdev)
> >>   	platform_set_drvdata(pdev, indio_dev);
> >>   
> >>   	err = tiadc_request_dma(pdev, adc_dev);
> >> -	if (err && err == -EPROBE_DEFER)
> >> +	if (err)  
> > So this looks like a more subtle change than you are describing.
> > In the original code, we backed off only if the return was a PROBE_DEFER, otherwise
> > we carried on.
> >
> > Your change seems to make that happen for any non -ENODEV error, including PROBE_DEFER.
> > That's fine, but it's not what the description implies.
> >
> > Whilst tiadc_request_dma will fail today if the dmas etc is not provided, that seems
> > like correct behavior to me.  A function requesting dma fails if it isn't available.
> > The handling of whether to carry on the job for the caller.  
> 
> That makes sense, yes. But stm32-adc is doing the same in its dma 
> request function.
> So I assumed we can do it like that.
> 
> >
> > So I think it should just be
> > 	if (err && err != -EINVAL)
> > 		goto err_dma;  
> 
> We will end up failing if no dmas are configured because the request 
> returns -ENODEV.
> So I think it needs to be a check for non -ENODEV.

That makes sense. I wonder if a long time back that returned -EINVAL, hence the
wrong value here. If you can do a bit of checking in the git history that would
be good as it will change how far we backport this.

> 
> >
> > and no change in tiadc_request_dma()
> >
> > However, the case you describe should have worked find with existing code
> > as it wasn't -EPROBE_DEFER, so I don't understand why you were looking at this
> > code block in the first place?  
> 
> Providing wrong dmas in the device tree should've made the driver fail 
> to probe.

Agreed,

Thanks,

Jonathan

> 
> Regards,
> Wadim
> 
> >
> > Jonathan
> >
> >  
> >>   		goto err_dma;
> >>   
> >>   	return 0;  
> 
> 

