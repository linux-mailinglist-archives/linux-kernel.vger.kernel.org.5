Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3217B4F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjJBJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjJBJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:39:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD0F2;
        Mon,  2 Oct 2023 02:39:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzbVB2Vv3z6K60M;
        Mon,  2 Oct 2023 17:38:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 10:39:41 +0100
Date:   Mon, 2 Oct 2023 10:39:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Potin.Lai@quantatw.com" <Potin.Lai@quantatw.com>,
        "patrickw3@meta.com" <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Message-ID: <20231002103940.00001dbd@Huawei.com>
In-Reply-To: <SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
        <20230930174501.039095da@jic23-huawei>
        <SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 02:30:43 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> On Mon, 25 Sep 2023 16:18:45 +0800
> Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
> > > Create event sysfs for applying the deglitch condition. When
> > > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
> > > the driver will use the in_voltageY_thresh_rising_value and
> > > in_voltageY_thresh_falling_value as threshold values. If the ADC value
> > > falls outside this threshold, the driver will wait for the ADC sampling
> > > period and perform an additional read once to achieve the deglitching
> > > purpose.
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> 
> > Hi Billy  
> 
> > This is pushing the meaning of the events interface too far.
> > You can't use it to hide a value you don't like from userspace.  
> 
> > If you can explain what the condition is that you are seeing
> > and what you need to prevent happening if it is seen that would help
> > us figure out if there is another way to do this.  
> 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Currently, we are experiencing some voltage glitches while reading from our
> controller, but we do not wish to report these false alarms to the user space.
> Instead, we want to retry the operation as soon as possible. This is why the
> driver requires this patch to handle retries internally, rather than relying on user
> space which could introduce unpredictable timing for retrying the reading process.
> This software approach aims to minimize the possibility of false alarms as much as possible.
Thanks for the extra detail. Perhaps share more of that in the cover letter for v2.
> 
> If you have any suggestions or recommendations regarding this situation, please feel free to
> share them with me.

Why do you need userspace control for the thresholds?
Perhaps this is something that belongs in DT for a particular board design?

Jonathan
> 
> Thanks 
> 
> > > ---
> > >  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 189 insertions(+), 4 deletions(-)
> >   

