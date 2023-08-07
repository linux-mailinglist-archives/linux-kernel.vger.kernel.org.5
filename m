Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8777279E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjHGOZX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 10:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHGOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:25:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0EC2;
        Mon,  7 Aug 2023 07:25:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKJRC3CBqz6J6x9;
        Mon,  7 Aug 2023 22:21:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 15:25:18 +0100
Date:   Mon, 7 Aug 2023 15:25:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>, <jic23@kernel.org>,
        <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iio: Add IIO_DELTA_ANGL channel type
Message-ID: <20230807152517.00002ddb@Huawei.com>
In-Reply-To: <cef38375a5259e7df0111821b112341ed670e682.camel@gmail.com>
References: <20230807111227.374371-1-ramona.bolboaca@analog.com>
        <20230807111227.374371-2-ramona.bolboaca@analog.com>
        <cef38375a5259e7df0111821b112341ed670e682.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 16:26:17 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Mon, 2023-08-07 at 14:12 +0300, Ramona Bolboaca wrote:
> > The delta angle is defined as a piece-wise integration of angular
> > velocity data. The delta angle represents the amount of
> > angular displacement between two consecutive measurements and it
> > is measured in radians.
> > 
> > In order to track the total angular displacement during a desired
> > period of time, simply sum-up the delta angle samples acquired
> > during that time.
> > 
> > IIO currently does not offer a suitable channel type for this
> > type of measurements hence this patch adds it.
> > 
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
> >  drivers/iio/industrialio-core.c         |  1 +
> >  include/uapi/linux/iio/types.h          |  1 +
> >  tools/iio/iio_event_monitor.c           |  2 ++
> >  4 files changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index a2854dc9a839..32675fa7dc6f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -279,6 +279,20 @@ Description:
> >                 but should match other such assignments on device).
> >                 Units after application of scale and offset are m/s^2.
> >  
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_deltaangl_x_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_deltaangl_y_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_deltaangl_z_raw  
> 
> I wonder if we also need to add these to the scan element specific bits? From a
> quick look, it seems not all supported attributes are in there so I'm not sure
> what's the policy in here :)
> 
Yeah, should add them for everything the driver uses.  I forgot about that.
Intent is that anyone grepping will find the docs so they need to be complete.

Jonathan

> 
> - Nuno Sá

