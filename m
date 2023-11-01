Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7227E7DDEDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjKAKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjKAKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:00:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4B101;
        Wed,  1 Nov 2023 03:00:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SL2VL3Ckfz6K63t;
        Wed,  1 Nov 2023 17:57:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 10:00:20 +0000
Date:   Wed, 1 Nov 2023 10:00:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Su Hui <suhui@nfschina.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <jean-baptiste.maneyrol@tdk.com>, <andy.shevchenko@gmail.com>,
        <chenhuiz@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Message-ID: <20231101100019.00004be7@Huawei.com>
In-Reply-To: <7555437b-9289-eba4-efa8-965386e0e956@nfschina.com>
References: <20231027145949.243f03f2@jic23-huawei>
        <7555437b-9289-eba4-efa8-965386e0e956@nfschina.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 10:10:05 +0800
Su Hui <suhui@nfschina.com> wrote:

> On 2023/10/27 21:59, Jonathan Cameron wrote:
> > On Mon, 23 Oct 2023 12:05:52 +0800
> > Su Hui <suhui@nfschina.com> wrote:
> >  
> >> inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
> >> true value rather than only return IIO_VAL_INT.
> >>
> >> Signed-off-by: Su Hui <suhui@nfschina.com>  
> > If you can figure out a fixes tag that would be great.  Just reply to this thread
> > with it and I'll pick it up from here.  
> Oh, I just send a v3 patch, sorry....
> Fixes: d5098447147c ("iio: imu: mpu6050: add calibration offset support")
That works too!

Thanks,

J
> >> ---
> >> v2:
> >>   - fix the error of commit title.
> >> v1:
> >>   - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
> >>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> index 29f906c884bd..a9a5fb266ef1 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> @@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >>   			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
> >>   						chan->channel2, val);
> >>   			mutex_unlock(&st->lock);
> >> -			return IIO_VAL_INT;
> >> +			return ret;
> >>   		case IIO_ACCEL:
> >>   			mutex_lock(&st->lock);
> >>   			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
> >>   						chan->channel2, val);
> >>   			mutex_unlock(&st->lock);
> >> -			return IIO_VAL_INT;
> >> +			return ret;
> >>   
> >>   		default:
> >>   			return -EINVAL;  
> 

