Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438567F9468
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKZRHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:07:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DABEFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:07:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A08C433C7;
        Sun, 26 Nov 2023 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701018428;
        bh=XUM7qw4H5Ny7dZR+MIodYJqjaaevZ0Fq9kn1EHutWXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LRTmJQ3xoY1hLDtcHRx+zh0vqin88ikJAaqkKXbeQBPgdpdMb7EN9II+FYQWLCxKN
         x1fY/MjjzXIbFiFikjMXSjppbLfeEzTWcyLudo4O+CnVfWRx5I6KvFArjkT7qSmMpD
         CyapR6bScFuplZRJOSSwOFqsxWTwW11PWMlNtPZllln7CSZMpa8vk7ghopfSLZSvdY
         8Xp2M7TjfAI8sPpupBhPDJpOZyaSqg8v+tDmbtDRQZCkUIKAHS0Zdedjslwb7/17u0
         9gD++jL+iZtGHHwF6z+8xvzJsZPdcmS6EA0AHIFwxOA3LMZQrizz1hnWdOlESxu74E
         ma4FxdS0A3xjA==
Date:   Sun, 26 Nov 2023 17:07:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     lars@metafoo.de, jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: return callee's error code
 rather than -EINVAL
Message-ID: <20231126170700.550d20e7@jic23-huawei>
In-Reply-To: <20231030020752.67630-1-suhui@nfschina.com>
References: <20231030020752.67630-1-suhui@nfschina.com>
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

On Mon, 30 Oct 2023 10:07:53 +0800
Su Hui <suhui@nfschina.com> wrote:

> regmap_bulk_write()/regmap_bulk_read() return zero or negative error
> code, return the callee's error code is better than '-EINVAL'.
Thanks and fully agree - though one small tweak I made whilst applying is mentioned
below.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if we missed anything.

> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index a9a5fb266ef1..5ded0781797c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -572,7 +572,7 @@ static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
>  	ind = (axis - IIO_MOD_X) * 2;
>  	result = regmap_bulk_write(st->map, reg + ind, &d, sizeof(d));
>  	if (result)
> -		return -EINVAL;
> +		return result;
>  
>  	return 0;
I tweaked this to go further

	return regmap_bulk_write();

>  }
> @@ -586,7 +586,7 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  	ind = (axis - IIO_MOD_X) * 2;
>  	result = regmap_bulk_read(st->map, reg + ind, &d, sizeof(d));
>  	if (result)
> -		return -EINVAL;
> +		return result;
>  	*val = (short)be16_to_cpup(&d);
>  
>  	return IIO_VAL_INT;

