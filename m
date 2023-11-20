Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF737F193C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKTRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKTRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:01:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF7BA;
        Mon, 20 Nov 2023 09:01:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYtzF4Xclz6K9KG;
        Tue, 21 Nov 2023 00:59:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 20 Nov
 2023 17:01:14 +0000
Date:   Mon, 20 Nov 2023 17:01:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
Message-ID: <20231120170113.00000992@Huawei.com>
In-Reply-To: <588dd3f4-bea5-4453-9ef6-f92fb42c7514@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
        <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
        <20231119150233.10fdc66e@jic23-huawei>
        <588dd3f4-bea5-4453-9ef6-f92fb42c7514@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 18:40:16 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 19.11.23 16:02, Jonathan Cameron wrote:
> >> +
> >> +struct veml6075_data {
> >> +	struct i2c_client *client;
> >> +	struct regmap *regmap;
> >> +	struct mutex lock; /* register access lock */  
> > 
> > regmap provides register locking as typically does the bus lock, so good to
> > say exactly what you mean here.  Is there a Read Modify Write cycle you need
> > to protect for instance, or consistency across multiple register accesses?
> >   
> What I want to avoid with this lock is an access to the measurement
> trigger or an integration time modification from different places while
> there is a measurement reading going on. "register access lock" is
> probably not the best name I could have chosen though.
> 
> I was not aware of that guard(mutex) mechanism. I guess it is new
> because only one driver uses it in the iio subsystem (up to v6.7-rc1).
> I will have a look at it.

Yup. It is very new.

> >> +};  
> >   
> >> +
> >> +static const struct iio_chan_spec veml6075_channels[] = {
> >> +	{
> >> +		.type = IIO_INTENSITY,
> >> +		.channel = CH_UVA,
> >> +		.modified = 1,
> >> +		.channel2 = IIO_MOD_LIGHT_UV,
> >> +		.extend_name = "UVA",
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +			BIT(IIO_CHAN_INFO_SCALE),
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> >> +	},
> >> +	{
> >> +		.type = IIO_INTENSITY,
> >> +		.channel = CH_UVB,
> >> +		.modified = 1,
> >> +		.channel2 = IIO_MOD_LIGHT_UV,
> >> +		.extend_name = "UVB",  
> > 
> > Extent name is very rarely used any more.  It's a horrible userspace interface
> > and an old design mistake. 
> > Instead we use the channel label infrastructure.  Provide the read_label()
> > callback to use that instead.
> > 
> > I'm not sure this is a great solution here though.  For some similar cases
> > such as visible light colours we've just added additional modifiers, but that
> > doesn't really scale to lots of sensitive ranges.
> > 
> > One thing we have talked about in the past, but I don't think we have done in
> > a driver yet, is to provide actual characteristics of the sensitivity graph.
> > Perhaps just a wavelength of maximum sensitivity?
> > 
> > Visible light sensors often have hideous sensitivity curves, including sometimes
> > have multiple peaks, but in this case they look pretty good.
> > Do you think such an ABI would be more useful than A, B labelling?
> >   
> My first idea was adding new modifiers because I saw that
> IIO_MOD_LIGHT_UV and IIO_MOD_LIGHT_DUV coexist, but then I thought _UVA
> and _UVB might not be used very often (wrong assumption?) and opted for
> a local solution with extended names. But any cleaner solution would be
> welcome because the label attributes are redundant.
> 
> Maybe adding UV-A, UV-B and UV-C modifiers is not a big deal as these
> are fairly common bands. Actually DUV is pretty much UV-C and could be
> left as it is.

Ok. Add UV-A and UV-B as that's inline with other cases.
Always a guessing game for how often a modifier will turn up.  We have
space and the list isn't growing that fast so should be fine.

> 
> This sensor has a single peak per channel, but I do not know how I would
> provide that information to the core if that is better than adding UVA
> and UVB bands. Would that add attributes to sysfs for the wavelengths or
> extend the channel name? In that case two new modifiers might be a
> better  and more obvious solution.

Would be attributes if we did add max sensitivity wavelengths.
Might be worth a revisit at somepoint, but not feeling like it's necessary
for this driver.

> > Jonathan
> > 
> >   
> I will work on the other issues you pointed out. Thanks a lot for your
> review.

> 
> Best regards,
> Javier Carrasco
> 
> 

