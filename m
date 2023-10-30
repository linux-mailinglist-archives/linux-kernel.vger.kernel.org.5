Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B87DB1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJ3CKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:10:23 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5D3E693;
        Sun, 29 Oct 2023 19:10:21 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id F16A26027E05D;
        Mon, 30 Oct 2023 10:10:05 +0800 (CST)
Message-ID: <7555437b-9289-eba4-efa8-965386e0e956@nfschina.com>
Date:   Mon, 30 Oct 2023 10:10:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan.Cameron@Huawei.com, lars@metafoo.de,
        jean-baptiste.maneyrol@tdk.com, andy.shevchenko@gmail.com,
        chenhuiz@axis.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <20231027145949.243f03f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/27 21:59, Jonathan Cameron wrote:
> On Mon, 23 Oct 2023 12:05:52 +0800
> Su Hui <suhui@nfschina.com> wrote:
>
>> inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
>> true value rather than only return IIO_VAL_INT.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> If you can figure out a fixes tag that would be great.  Just reply to this thread
> with it and I'll pick it up from here.
Oh, I just send a v3 patch, sorry....
Fixes: d5098447147c ("iio: imu: mpu6050: add calibration offset support")
>> ---
>> v2:
>>   - fix the error of commit title.
>> v1:
>>   - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 29f906c884bd..a9a5fb266ef1 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>>   			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>>   						chan->channel2, val);
>>   			mutex_unlock(&st->lock);
>> -			return IIO_VAL_INT;
>> +			return ret;
>>   		case IIO_ACCEL:
>>   			mutex_lock(&st->lock);
>>   			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>>   						chan->channel2, val);
>>   			mutex_unlock(&st->lock);
>> -			return IIO_VAL_INT;
>> +			return ret;
>>   
>>   		default:
>>   			return -EINVAL;
