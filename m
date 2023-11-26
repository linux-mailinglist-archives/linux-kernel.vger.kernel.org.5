Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D57F946F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKZRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:09:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE6FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:09:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE5DC433C8;
        Sun, 26 Nov 2023 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701018584;
        bh=S3oBnSKIVaAwos9u+x7GmQmmKapxv7I388lspEsC2bI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=COWYlnyuDob5yZ/8Wr0ZT0tTymWeBTs52UHwhZ45F7Vf49nLqkI/Zqz6Lu9snAc7K
         rD3LPgpyU6NjlH1idl6LlzIhSuqwTK8+T9Ai7hutimfIPITJmSY82Ta08JXAYFwiQn
         A0Fw/9ZjDl+4cJj3FKonCc0pZu1Sx88r0G2fmRwITZo7v/uEYIGe/n238eRE8zTIzq
         X0KmtkrBdYwJQ4q8MZJMjtowWZSOblsA+frByz9n3jTZhSltS0bbzaIc4obztti8Tt
         cQ10yzvs+unZa+dYECjn38p7l7jpd+2VK/1PonTEXXfZSVzK1DC804wU934mWZlV/b
         KsspJp5eQJA3w==
Date:   Sun, 26 Nov 2023 17:09:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
        andy.shevchenko@gmail.com, chenhuiz@axis.com, mranostay@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Message-ID: <20231126170935.3074a06e@jic23-huawei>
In-Reply-To: <20231030020218.65728-1-suhui@nfschina.com>
References: <20231030020218.65728-1-suhui@nfschina.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 10:02:19 +0800
Su Hui <suhui@nfschina.com> wrote:

> inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
> true value rather than only return IIO_VAL_INT.
> 
> Fixes: d5098447147c ("iio: imu: mpu6050: add calibration offset support")
> Signed-off-by: Su Hui <suhui@nfschina.com>
Applied to the fixes-togreg branch of iio.git.

It's independent enough from the improved error reporting that they can hopefully
got through different branches.

Thanks,

Jonathan

> ---
> v3:
>  - add Fixes tag
> v2:
>  - fix the error of commit title.
> v1: 
>  - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 29f906c884bd..a9a5fb266ef1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			return ret;
>  
>  		default:
>  			return -EINVAL;

