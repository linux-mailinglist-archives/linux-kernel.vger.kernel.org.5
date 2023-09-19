Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25887A66C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjISOdC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjISOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:33:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0483;
        Tue, 19 Sep 2023 07:32:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqkXj1xPXz67ZCr;
        Tue, 19 Sep 2023 22:28:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 15:32:52 +0100
Date:   Tue, 19 Sep 2023 15:32:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <ak@it-klinger.de>, <andriy.shevchenko@linux.intel.com>,
        <ang.iglesiasg@gmail.com>, <bbara93@gmail.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <matti.vaittinen@fi.rohmeurope.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230919153251.000024d3@Huawei.com>
In-Reply-To: <7ec2ac97-8ee3-186b-ef25-ceb5ec57751a@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
        <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
        <cdc9a8f8-fbd5-1eb3-7bac-1e6e5893bc9b@wanadoo.fr>
        <7ec2ac97-8ee3-186b-ef25-ceb5ec57751a@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
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


> >> +static int bm1390_read_raw(struct iio_dev *idev,
> >> +               struct iio_chan_spec const *chan,
> >> +               int *val, int *val2, long mask)
> >> +{
> >> +    struct bm1390_data *data = iio_priv(idev);
> >> +    int ret;
> >> +
> >> +    switch (mask) {
> >> +    case IIO_CHAN_INFO_SCALE:
> >> +        if (chan->type == IIO_TEMP) {
> >> +            *val = 31;
> >> +            *val2 = 250000;
> >> +
> >> +            return IIO_VAL_INT_PLUS_MICRO;
> >> +        } else if (chan->type == IIO_PRESSURE) {
> >> +            *val = 0;
> >> +            /*
> >> +             * pressure in hPa is register value divided by 2048.
> >> +             * This means kPa is 1/20480 times the register value,
> >> +             * which equals to 48828.125 * 10 ^ -9
> >> +             * This is 48828.125 nano kPa.
> >> +             *
> >> +             * When we scale this using IIO_VAL_INT_PLUS_NANO we
> >> +             * get 48828 - which means we lose some accuracy. Well,
> >> +             * let's try to live with that.
> >> +             */
> >> +            *val2 = 48828;
> >> +
> >> +            return IIO_VAL_INT_PLUS_NANO;
> >> +        }
> >> +
> >> +        return -EINVAL;
> >> +    case IIO_CHAN_INFO_RAW:
> >> +        ret = iio_device_claim_direct_mode(idev);
> >> +        if (ret)
> >> +            return ret;
> >> +
> >> +        ret = bm1390_read_data(data, chan, val, val2);
> >> +        iio_device_release_direct_mode(idev);
> >> +        if (ret)
> >> +            return ret;
> >> +
> >> +        return IIO_VAL_INT;
> >> +    default:
> >> +        return -EINVAL;  
> > 
> > Certainly useless, but should we break and return -EINVAL after the 
> > switch, so that it is more explicit that bm1390_read_raw() always 
> > returns a value?  
> 
> I think there is also opposite opinions on this. For my eyes the return 
> at the end of the function would also be clearer - but I think I have 
> been asked to drop the useless return when I've been working with other 
> sensors in IIO domain :) My personal preference would definitely be:
> 
> int ret;
> 
> switch (foo)
> {
> case BAR:
> 	ret = func1();
> 	if (ret)
> 		break;
> 
> 	ret = func2();
> 	if (ret)
> 		break;
> 
> ...
> 	break;
> 
> case BAZ:
> 	ret = -EINVAL;
> 	break;
> }
> 
> return ret;
> 
> - but I've learned to think this is not the IIO preference.

Some static analyzers get confused (probably when there is a little
bit more going on after the function) by that and moan that some
cases are not considered in the switch.  I got annoyed enough with the
noise they were generating to advocate always having explicit defaults.


> 
> 

